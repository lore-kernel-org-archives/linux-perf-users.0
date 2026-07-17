Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012039.outbound.protection.outlook.com [52.101.126.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE63D25AF;
	Fri, 17 Jul 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284394; cv=fail; b=m0xJh2UfRVt7NvtciZ/30et0GjN6IEt6iYORiCRv4HGCg9m+TVdtZA4YkgDoW9FI7M3q6Qmur1dG0kqnWl2LKqLbZtBv5E8BCTFYTmUZe6J7rh+bleMSs9+xlX1lLJGY8tl0oLPW6IzZ0Bh+1BdHSHFQqs7Ghg7gzcLDvljRyao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284394; c=relaxed/simple;
	bh=p8Cuxoz2RC4l6beSn/KFAiuPaIKGo4+vBjoxI0lHW6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XC+hr9uU/ImjcQAgCx0llW+C/5ol/q6+AMJx9jrJnP6Il+WcqfflTlf2H4E8CBb7ysEWjL7iA4F0BD9toHxMuhg3jiT1+82Ul39cqLBWk9LQT4BLQ2MZ5UgJLEpiETHkQ4TPmOs7S69CjiyGAPMhuyi3sG+zVa6w/UZ+n+dKBgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=R6KIgU7u; arc=fail smtp.client-ip=52.101.126.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="R6KIgU7u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqpA1hrmYZxmHbU8VNJCEGh3Ses1SNShUA3xpLFZpUpdtB7kbxUiAUg6V13uRZB2G1Pbk0yI3j5SO8D2bFtucynqJ5yQ4v0/NjiAerbMg9epmXf7W3TRpI8mGfly66MuH7BnT12oTO095E2MIYl6oMpJ1bB4evIOGjGtqwVn48kXhaCXdEqgMapaPZv+iGNxbUH1hkhZ2XSY33XiXgbJBTxzBc83RWoQdWaNwk1PuzMyi7JA3wzqJfP5O0ZvuRvNhVlKbGZ7mR17EuvPHe999nsW5fuurWly/iFDlj60fgHUXcPfEXjXCykwvY/rnitiSHr+/GZTNkpRoEsIKQqCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU1sHn346PJX6moDyJFmlx+Rt73kxTLNJGH3QUMjqFo=;
 b=OLgwMV0TYVn59mjgDwIs//9sxKH+KdgNZ2EuSh1jDrtFb/RO1f/IUZp59QQwkv5falb8+PgetBRyGpVCeRuQM/dl8/uGhaGVAvtt8g1OPh+uxnd8f5ipjUcXe8RwtS6d4cvPdpb8AT2hEGbj3ntzbo9hPEUxbdk0EaytSJC3nK2TyTA8SFMcL9azz/1j8OFSCRJX3qusoXGu0CSUrQu5cLtG01HvtHR0QE11lSTGIhPh+bye1OHOSmi/trlwW50sSn7XiZtu95Bk/g3kIIa2K8/VCzdoPaEfrLxWeYX1hFPsyS7lvguN6lE5mMXrcqxXM9PyDzQR+M8LmfmWwHbtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU1sHn346PJX6moDyJFmlx+Rt73kxTLNJGH3QUMjqFo=;
 b=R6KIgU7uQIWvFBWJtIDOD9ESCGg18LHdQWg9wOgC0lvGW1KKqyHLkcWJoy4/9JEIGPORd7quNpvrVJ0ZaoRQVmullVabTcJOqsG9+bmAFNyX3mDC8TfBR12FlU4q7fZckoDJPzTpLZ9zyJAxXTMxYV3cASB9g8yKW+QqjxJ3djETvIeExxUJfHwqBjI+cy1tZVmDY/0XDH/4atfk9UyfOfAg1PNte3aSa/TAoCI4kCMadCEiPgpVJ6SMSWcUTrMJLFXLnWxVTTce0oQkwZsV8OcuK1+NqYRZUT2QuHMNAo9oEg/yh0nLSyGFhRok2Y6im/PXZ1CFvzoxPwCUrCOxuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY2PPFF72AB57F6.apcprd06.prod.outlook.com (2603:1096:408::7b2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 10:33:10 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:33:10 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Li <Frank.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/3] perf: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 18:31:17 +0800
Message-Id: <20260717103123.34887-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717103123.34887-1-panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY2PPFF72AB57F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 088a27c1-d73f-49f0-054a-08dee3eecc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|921020|38350700014|6133799003|10067099003|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7WjmlvgKKCajrfHPDDS6r1JQnmP71yfN3Bk5iiZIpMKlpo9EYHC8+i1KVW1V3qByehRi89JS2RAHNJP1xZeQZ7676aUlN0lvkCjjk6vGb2/ENBfpouhwMHlAxxJ3xy/MIfKq0sB2WhV9i1qe/jOwkqE94wrWV9U0OAAdIhsb+eSJI9E0B0xl7PcPflSSi6O9ilF36BWvJZ6neFNfdnE4BDxrrviZIRGDzreU5OMrmdpvZHgg0gtO8NAQnU3xM2TJcdsRffSrbmTpDIpefOCmEyuNo2SfO7cQjdID4Wmo8PlZVO3qO6nsl7cln+8QZCsy+kmn2WICWMkB/n6JeiGN6uMHN6f5Xj2QdVL8geQvfs/JP3RfZS819NJ3pcxYb4kKeCoEDVIbnF16HW8u0C1E4BeatFUfk+zZqERhXAgSJM+/N1r4so0WzJsJiB03hPIWKrVyj0qDf+qB7qyzf7kOlji95zbYlOVvwfqRk/iY9GIh8KkXObNrFaCBXHYa6Eo16JiIaiSeWtsAR7eBTJ1nDA1Cqxmwd95z6tB0B3hv2PgwLDuwfDG6uKewOrpZ0Q8NPJ02HsSDvtBZA88+Hzcl4naYtBE3ko/ax/IM3+/JOdoDQnhvWKgXEZtlwFHIbi7QLDe0V9yXj6RNGsblDhQdaIjSg8Y0QPmMTGLbT6il5JSaiU30WIu/4jGC+LAH3lCqvgdsUByT/NZmvgDIXJIfVa6Lz5hfS+8rFsyhNfPRRtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014)(6133799003)(10067099003)(22082099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZG6LvlS1hxxrCeQF56OA+Wx6JdR+E2ZN/n4E+PrJE1ocsMXDomDdwdM068k?=
 =?us-ascii?Q?oI6GoKpQWNHr0Gp2LFe7hvoYnfZ5IN7UMLzEyEJz7P+JxwIbtfyefmtcqgFJ?=
 =?us-ascii?Q?FK+knModb9YvlQefzqKuiOLL0qyiiEgHR6k5te9PHGRSUvF3f8yP5IOOj8hA?=
 =?us-ascii?Q?b5JjGKk47WMINR5/5r2n/YcTA0GNYowijzs+EzNC0C5AH+QK1aqgmct0nzX6?=
 =?us-ascii?Q?jfikINVllqErBrJCs+9UikVQW0YyFgftWzbjktrWMWVQwO8LKRlvL+IO524o?=
 =?us-ascii?Q?qHm+WCRqRAs+J0lNDR5nOCwWwk6JeTNTv4UYBmau1V/qBniRlNkXSsAxMhEb?=
 =?us-ascii?Q?JLztMrQucPmKp+nJU8K9Uppkx0UNU705OgK0bAGANXLGcxfGC2ZLm9wvFFRm?=
 =?us-ascii?Q?Zv8F7J426kmMcGwq/xH9nLKryRetGXBPD7T7WnX9Y3EK+N56e+tR7u0KCoKK?=
 =?us-ascii?Q?/TW3qYCUfs/M6QFo8ltO7brJn3FiV+ZU8vkoyzMYUjk81CqyYzI0vYUOWCcF?=
 =?us-ascii?Q?/f7cBq7idPCOWbDfDOI+XHZq3ydO+buJ16A8LGESYDkHN5a7Hb6cALZk+0PC?=
 =?us-ascii?Q?ubcoKKEPoRWiGwFinltChUxNK+XrOokQEEfaunnHyxlnK7AFxecSi2WiLEvs?=
 =?us-ascii?Q?mPKEZWk6sfSOctyhc3wOVG57mcP8Szl1IrSB6yOppJoHK677cwi5Cle0gxRw?=
 =?us-ascii?Q?j2WnUoo+mCdFWuCXYkSWCr5eL/kVi/w8XUrcueBru9dGAS9e3IaigGQA56VS?=
 =?us-ascii?Q?wDdf9XXcRE2R9IGD8SE72kUdArLVMB5V1Wya5HrCzi99w68WaROp9VPVZvCq?=
 =?us-ascii?Q?mNj8ezxaHmYWzi8JeQ6HdJaa8PNRTRLdJsI/XPgRByOfXnXhGxRUeab8P3+a?=
 =?us-ascii?Q?G4BxwmnoIGiHhicKiVvJ89zUm0GHRefWxkJjAhWpZ7oqLPi8X/T1tmedNEpZ?=
 =?us-ascii?Q?sgg1c/fY2BRsMLqxQPp7C8PymQEAPR7Rdia0QvVbsLL8586djjGjEZXVPY2s?=
 =?us-ascii?Q?oAche7qHRLZV8WYhcYx5rcdpSneqX2J5bP1NleDlihxKsNXXZWVygeQX4g7p?=
 =?us-ascii?Q?pd7GNkXmQ41oAL+jPE1RCVfsBJaQHqi5vYdmfv48126gp58zfgj0bZtvWe57?=
 =?us-ascii?Q?wyLpfodprkME4NwfkPHZkVR/j71FeteluInGGJ1272lbn8FrgNj1DjeY1dxs?=
 =?us-ascii?Q?kvIuGVQxo48wldowQ3dh5V1Xk/2ZmPJCCQpbwE0xlNb4XEt5O4gLjYt0RFnr?=
 =?us-ascii?Q?B2dHixn4u7A9pqNcJHJB7uOFZKWRvnaOQ6/QDqTiOrkUvBFOtIxWIYhtMB5b?=
 =?us-ascii?Q?u7bdwb1poCEyVwkDVdCFhFelKA/YdIWE4zQcE5LZs3If3GaeFW+Q+lb4Cvbl?=
 =?us-ascii?Q?McHTXJbk9cvflpWYb3Ln1IWDmCMHaVNnPA7uRTH+9TOiK5wmH4kMI9vpQHaR?=
 =?us-ascii?Q?sAyH2JK7MDaDhpw6wDVSU+oZcr+ED2GEMb1cN4Uu9qgJT5Ku+Tg7ma/tTGTY?=
 =?us-ascii?Q?NKi9eX5JxqJez858Xd4XU8tTZrJc1jJC5+MtNJy/TXPdPeP63PJjSkHg1Z4l?=
 =?us-ascii?Q?jDM37E22WpKaBCdi7Tst/+a4eRYzDMwfeWI/RrUUqlmGIv8+igiK93zq8v1L?=
 =?us-ascii?Q?NTkldDmU2ypFqNN5oR1+6nwMEc/+pa3hYVqjlIdaUT9iECoDF8hcVLjR3HlE?=
 =?us-ascii?Q?q3TCOFxDpMA8eaZ3KAniH+KXQcysfepAIJibLoY/4G+O2zKSFlJWT2aG/M6t?=
 =?us-ascii?Q?JLDckrgxYA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a27c1-d73f-49f0-054a-08dee3eecc3f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:33:10.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bfq9lNvZHgWwqSDC76pcInqsTrhEcnVYD10NHvYGzJ45NnGiWfWFEdHao/h4G7534MDf7apRWm1MiDPzIE6Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFF72AB57F6

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 5 +----
 drivers/perf/fsl_imx8_ddr_perf.c      | 4 +---
 drivers/perf/fsl_imx9_ddr_perf.c      | 4 +---
 drivers/perf/fujitsu_uncore_pmu.c     | 2 +-
 drivers/perf/qcom_l2_pmu.c            | 5 +----
 drivers/perf/qcom_l3_pmu.c            | 5 +----
 drivers/perf/starfive_starlink_pmu.c  | 2 +-
 drivers/perf/xgene_pmu.c              | 4 +---
 8 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 74786a5dd6a2..fc934bccf4a6 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -449,11 +449,8 @@ static struct ali_drw_pmu_irq *__ali_drw_pmu_init_irq(struct platform_device
 	 */
 	ret = devm_request_irq(&pdev->dev, irq_num, ali_drw_pmu_isr,
 			       IRQF_SHARED, dev_name(&pdev->dev), irq);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"Fail to request IRQ:%d ret:%d\n", irq_num, ret);
+	if (ret < 0)
 		goto out_free;
-	}
 
 	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
 	if (ret)
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 3760ebe02674..dd8046265584 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -858,10 +858,8 @@ static int ddr_perf_probe(struct platform_device *pdev)
 					IRQF_NOBALANCING | IRQF_NO_THREAD,
 					DDR_CPUHP_CB_NAME,
 					pmu);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Request irq failed: %d", ret);
+	if (ret < 0)
 		goto ddr_perf_err;
-	}
 
 	pmu->irq = irq;
 	ret = irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu));
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 6fee5eb5087a..d59bc5ea3155 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -830,10 +830,8 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, ddr_perf_irq_handler,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
 			       DDR_CPUHP_CB_NAME, pmu);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Request irq failed: %d", ret);
+	if (ret < 0)
 		goto ddr_perf_err;
-	}
 
 	pmu->irq = irq;
 	ret = irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu));
diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
index ede652f757da..fa64146fcac6 100644
--- a/drivers/perf/fujitsu_uncore_pmu.c
+++ b/drivers/perf/fujitsu_uncore_pmu.c
@@ -526,7 +526,7 @@ static int fujitsu_uncore_pmu_probe(struct platform_device *pdev)
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
 			       name, uncorepmu);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request IRQ:%d\n", irq);
+		return ret;
 
 	ret = irq_set_affinity(irq, cpumask_of(uncorepmu->cpu));
 	if (ret)
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index c0c522b10b72..29554cca22c5 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -869,11 +869,8 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 			       IRQF_NOBALANCING | IRQF_NO_THREAD |
 			       IRQF_NO_AUTOEN,
 			       "l2-cache-pmu", cluster);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Unable to request IRQ%d for L2 PMU counters\n", irq);
+	if (err)
 		return err;
-	}
 
 	dev_info(&pdev->dev,
 		 "Registered L2 cache PMU cluster %lld\n", fw_cluster_id);
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index c8d259dd1f80..e18d0f94e8d8 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -767,11 +767,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, ret, qcom_l3_cache__handle_irq, 0,
 			       name, l3pmu);
-	if (ret) {
-		dev_err(&pdev->dev, "Request for IRQ failed for slice @%pa\n",
-			&memrc->start);
+	if (ret)
 		return ret;
-	}
 
 	/* Add this instance to the list used by the offline callback */
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE, &l3pmu->node);
diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
index dc4e653761fc..98e5ccee2fdc 100644
--- a/drivers/perf/starfive_starlink_pmu.c
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -435,7 +435,7 @@ static int starlink_setup_irqs(struct starlink_pmu *starlink_pmu,
 	ret = devm_request_irq(&pdev->dev, irq, starlink_pmu_handle_irq,
 			       0, STARLINK_PMU_PDEV_NAME, starlink_pmu);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to request IRQ\n");
+		return ret;
 
 	starlink_pmu->irq = irq;
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index e9e4871db08d..ab3623fab914 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1876,10 +1876,8 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
 				IRQF_NOBALANCING | IRQF_NO_THREAD,
 				dev_name(&pdev->dev), xgene_pmu);
-	if (rc) {
-		dev_err(&pdev->dev, "Could not request IRQ %d\n", irq);
+	if (rc)
 		return rc;
-	}
 
 	xgene_pmu->irq = irq;
 
-- 
2.34.1

