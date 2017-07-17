# README

本demo包含类方法generate_contract()方法和实例generate_invoices()方法

>generate_contract(start_date,end_date,phases):
  >>参数:  
    start_date 字符串，合同起始日期，例：'2017-03-15'
    end_date   字符串，合同结束日期，例：'2017-06-15
    phases     数组，包含多个hash（即交租阶段，包括start_date,end_date,price,cycles等参数），
    ```例：[{:start_date=>"2017-03-15", :end_date=>"2017-05-31", :price=>2000.2, :cycles=>1}, {:start_date=>"2017-06-01", :end_date=>"2017-09-15", :price=>3000.3, :cycles=>1}]```
  
  > >返回:  
    合同对象，可通过调用view查看输出结果
    
>generate_invoices：
   >>通过调用此方法，可生成此对象下全部账单，返回结果可通过url访问查看
    

