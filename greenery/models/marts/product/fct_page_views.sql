with session_timing_agg as (
    select *
    from {{ ref('int_session_timing') }}
)

{% set event_types = dbt_utils.get_column_values(
    table = ref('stg_postgres__events'), 
    column = 'event_type'
) %}

select
    events.session_id,
    events.user_id,
    coalesce(events.product_id, order_items.product_id) as product_id,
    session_started_at,
    session_ended_at,
    {% for event_type in event_types %}
        {{ sum_of('events.event_type', event_type) }} as {{ event_type }}s,
    {% endfor %}
    datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from {{ ref('stg_postgres__events') }} events
left join {{ ref('stg_postgres__order_items') }} order_items
    on order_items.order_id = events.order_id
left join session_timing_agg session_timing
    on session_timing.session_id = events.session_id
group by 1, 2, 3, 4, 5