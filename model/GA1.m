%此程序为求一个多元函数最大值问题，转化为天线问题需要在求函数处取min
function m_main()
clear;
clc;
%初值定义
Max_gen = 100;% 运行代数---自己设定
pop_size = 160;%种群大小---32*5=160条染色体
chromsome = 32;%染色体的长度---32个单元
pc = 0.9;%交叉概率---自己设定
pm = 0.1;%变异概率---自己设定
gen = 0;%统计代数---初始化赋值
 
 
%初始化
init = fix(5*rand(pop_size, chromsome));%---随机产生160行32列的数，数值大小为0-4
pop = init;
fit = obj_fitness(pop);%适应度计算函数
[max_fit, index_max] = max(fit);
maxfit = max_fit;
[min_fit, index_min] = min(fit);
best_indiv = pop(index_max, :);
%迭代操作
while gen<Max_gen
    gen = gen+1;  
    bt(gen) = max_fit;
    if  maxfit<max_fit;
        maxfit = max_fit;
        pop(index_min, :) = pop(index_max, :);
        best_indiv = pop(index_max, :);
    end
    best_indiv_tmp(gen) = pop(index_max);
    newpop = ga(pop, pc, pm, chromsome, fit);
    fit = obj_fitness(newpop);
    [max_fit, index_max] = max(fit);
    [min_fit, index_min] = min(fit);
    pop = newpop;
    trace(1, gen) = max_fit;
    trace(2, gen) = sum(fit)./length(fit);
end
 
 
%运行结果
[f_max gen_ct] = max(bt)%求的最大值以及代数
maxfit
best_indiv
%画图
% bt
hold on
plot(trace(1, :), '.g:');
plot( trace(2, :), '.r-');
title('实验结果图')
xlabel('迭代次数/代'), ylabel('最佳适应度（最大值）');%坐标标注
plot(gen_ct-1, 0:0.1:f_max+1, 'c-');%画出最大值
text(gen_ct, f_max+1,   '最大值')
hold off
 
 
    function  [fitness] = obj_fitness(pop)
        %适应度计算函数
        [r c] = size(pop);
        x = pop;
        fitness = zeros(r, 1);
        for i = 1:r
            for j = 1:c
                fitness(i, 1) = fitness(i, 1)+sin(sqrt(abs(40*x(i))))+1-abs(x(i))/20.0;
            end
        end
    end
 
 
    function newpop = ga(pop, pc, pm, chromsome, fit)
        pop_size = size(pop, 1);
        %轮盘赌选择
        ps = fit/sum(fit);
        pscum = cumsum(ps);%size(pscum)
        r = rand(1, pop_size);
        qw = pscum*ones(1, pop_size);
        selected = sum(pscum*ones(1, pop_size)<ones(pop_size, 1)*r)+1;%---rand出来随机数和哪个概率和接近，就属于哪一个概率
        newpop = pop(selected, :);
        %交叉
        if pop_size/2 ~= 0%---是否为双数的染色体，使双数的发生交叉
            pop_size = pop_size-1;
        end        
        for i = 1:2:pop_size-1%---两个选为一组
            while pc>rand%---一定概率下发生交叉
				c_pt=randi([1,31],1,1)%---从1-31中随机选一个数
				%---片段交叉操作				
                pop_tp1 = newpop(i, :);
				pop_tp2 = newpop(i+1, :);
				%---考虑是交换上部还是下部分
				if rand<0.5
					newpop(i+1, 1:c_pt) = pop_tp1(1, 1:c_pt);
                	newpop(i, 1:c_pt) = pop_tp2(1, 1:c_pt);
				else
					newpop(i+1, c_pt:chromsome) = pop_tp1(1, c_pt:chromsome);
                	newpop(i, c_pt:chromsome) = pop_tp2(1, c_pt:chromsome);
				end
            end 
        end
        % 变异
        for i = 1:pop_size
            if pm>rand
                m_pt = 1+round(32*rand);%---长度为32的染色体随机选取一处发生变异
                newpop(i, m_pt) = round(4*rand);%---另某一处随机改变相位
            end
        end
    end
end
