{{ config(materialized='table') }}

(
    SELECT 
        ad_id AS ad_id,
        0 AS add_to_cart,
        adset_id AS adset_id,
        campaign_id AS campaign_id,
        channel AS channel,
        clicks AS clicks,
        0 AS comments,
        NULL AS creative_id,
        date AS date,
        0 AS likes,
        0 AS shares,
        imps AS impressions,
        0 AS purchase,
        spend AS spend,
        0 AS video_views,
        0 AS installs,
        0 AS registrations,
        conv AS total_conversions,
        0 AS link_clicks,
        revenue AS revenue,
        0 AS engagements
    FROM {{ ref('src_ads_bing_all_data')}}
)
UNION ALL 
(
    SELECT 
        ad_id AS ad_id,
        add_to_cart AS add_to_cart,
        adset_id AS adset_id,
        campaign_id AS campaign_id,
        channel AS channel,
        clicks AS clicks,
        comments AS comments,
        creative_id AS creative_id,
        date AS date,
        likes AS likes,
        shares AS shares,
        impressions AS impressions,
        purchase AS purchase,
        spend AS spend,
        views AS video_views,
        mobile_app_install AS installs,
        complete_registration AS registrations,
        purchase AS total_conversions,
        inline_link_clicks AS link_clicks,
        purchase_value AS revenue,
        (
            COALESCE(comments, 0) +
            COALESCE(likes, 0) +
            COALESCE(shares, 0) +
            COALESCE(inline_link_clicks, 0) +
            COALESCE(views, 0) +
            COALESCE(mobile_app_install, 0) +
            COALESCE(complete_registration, 0)
        ) AS engagements
    FROM {{ ref('src_ads_creative_facebook_all_data')}}
)
UNION ALL 
(
    SELECT 
        ad_id AS ad_id,
        0 AS add_to_cart,
        NULL AS adset_id,
        campaign_id AS campaign_id,
        channel AS channel,
        clicks AS clicks,
        0 AS comments,
        NULL AS creative_id,
        date AS date,
        0 AS likes,
        0 AS shares,
        impressions AS impressions,
        purchase AS purchase,
        spend AS spend,
        video_views AS video_views,
        rt_installs AS installs,
        0 AS registrations,
        conversions AS total_conversions,
        0 AS link_clicks,
        0 AS revenue,
        (
            COALESCE(video_views, 0) +
            COALESCE(rt_installs, 0)
        ) AS engagements
    FROM {{ ref('src_ads_tiktok_ads_all_data')}}
)
UNION ALL
(
    SELECT 
        NULL AS ad_id,
        0 AS add_to_cart,
        NULL AS adset_id,
        NULL AS campaign_id,
        channel AS channel,
        clicks AS clicks,
        comments AS comments,
        NULL AS creative_id,
        date AS date,
        likes AS likes,
        retweets AS shares,
        impressions AS impressions,
        0 AS purchase,
        spend AS spend,
        video_total_views AS video_views,
        0 AS installs,
        0 AS registrations,
        0 AS total_conversions,
        url_clicks AS link_clicks,
        0 AS revenue,
        engagements AS engagements
    FROM {{ ref('src_promoted_tweets_twitter_all_data')}}
)
