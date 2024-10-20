
    
    

select
    book_title as unique_field,
    count(*) as n_records

from "childrens_books"."public"."book_popularity"
where book_title is not null
group by book_title
having count(*) > 1


