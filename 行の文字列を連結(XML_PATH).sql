SELECT
    部署名
    , (
        SELECT
            氏名 + ','
        FROM
            社員マスタ
        WHERE
            部署ID = 部署マスタ.ID
        FOR XML PATH('')
    ) AS 所属社員
FROM
    部署マスタ
