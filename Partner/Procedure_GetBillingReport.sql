
CREATE PROCEDURE GetBillingReport @user VARCHAR(20) = NULL,
    @period                             INT         = 1,
    @year                               CHAR(4)     = NULL
AS
BEGIN
    IF @year IS NULL
        SET @year = CAST(YEAR(GETDATE()) AS CHAR(4));
    SELECT
        Name = MAX(Users.fullname),
        [Billing Target] = MAX(targets.FeesBilled),
        [Actual Billed] = SUM(analysis.CostsDelivered),
        [Actual Received] = SUM(analysis.CostsReceived)
    FROM
        Analysis
        JOIN targets
            ON analysis.feeearnerref = targets.feeearnerref
               AND analysis.Period = targets.period
               AND analysis.year = targets.year
        JOIN Users
            ON analysis.feeearnerref = Users.Code
    WHERE
        analysis.FeeEarnerRef = @user
        AND analysis.Period = @period
        AND analysis.year = @year
    GROUP BY analysis.FeeEarnerRef;
END;

exec GetBillingReport 'yk', , '2016'