Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0642E62A9;
	Thu, 16 Jul 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184817; cv=fail; b=ZjtL1YExuc6qNZlrlIDca9/RRYjM5Ke5lN8nPyYlLZxhnNr276Xe3+bdne42Lfh2nj60+b7/A/8BY9v29Mer6HG/3BayHmuw8Di0bm0ljILn3rNAhWHvu6T7giZe7hNgxjj8YvlsGfwSW1eN7dPO4FsELfuZR+ZY65nhvd3b274=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184817; c=relaxed/simple;
	bh=jnjpRbBU0PNutP4IASv6g0q6xNJhl5OqGD2HR4IOz+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AG+l8xbm7C14T/pmNtpVFfdNaKFUO2n/OgXfJi7Plb7rGj4zUiVKx1lojl/paGPjJfqXErYgdRuL3f5gzfalKeM/fkI36+inSO/17PS9x37PuyazMSWoILEVhBC0GnxHrmHL/9cFcbM++NSvV6/B1Z20bhBJPmZN22jf3G1wRVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhXApUE9; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhXApUE9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnqxyiSgXun7h+lDWjg0vtUdte4lz7nI0fOOnfpcNXt/EwKTURNcRfM2FX1a00LU7BZpkNERCYJti8SGabACDRAEnmSWnvlBG/w637s/E9dkfQQJ/o4+dFNgZcyoVXKHXV6lJnXxFPPzGM+qcldeKT+e3PhmCqfNhwf+zgZoOm03NhrvDlzmT1ssoMmHMoSylMxyo7ugy9TRA+rp3lU8/QnbBCBO864UCSkuyFy2ohYyJYmzQnguzY3EuriRlyK+GhG6uq05wCQTVb7lhf25K1BW3tRqPWGrsdxM0YCORmv9RABfGYiCm3jtnx2QXGnOf/gxIBdA+AP0q+7AsNy4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab6jfLXHXhDlRH3EOet4UTE8o3U96i55NjIFPrVcPRs=;
 b=cKNsxHpzcfK6gaRRG/ZKFnIPRAmZKcGGHAL1MrfKPm/li041toUxYJ/szGWm5Q8ZniI4eLzguEAzAj02yEWi+wzeVJk31Y79sETGKtxpwejrRutvb+XoY9qZZb6vFKLF8CLVn97laeD4NTco+NtC2qHeZrmzkC9L8j3/FBy+SqtxjUzuVX0Voc6RJ9R3KxYVYLS0S6V0FyZbW2VF1UywjcEtwk8glb3mZJbWYZxd6JbaP4jAE0SJ2cpd805JfnN0rw51aHCmyVudP6f8Yzj4srK/3FeORzLUUkqTgKT1/lyvOz13hpu8Ws60lojxjXD3uBEJbQnnKbNituFCGAQidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab6jfLXHXhDlRH3EOet4UTE8o3U96i55NjIFPrVcPRs=;
 b=bhXApUE9pLiE6IQLQ4ePVJi7m7Th1P3oA5lTGXmiHm71/MbUABIGxkXUblWsg93wq9x7lsZkSKEEZdQacJi/hwtaT/yzMKtZcYoPvKcDT2ALuNEVpqWjG7Wo9MR02n/Uw1oXBavS9coAHJPvufFWMNHrDDpMhwNMuwAUfY0sozfwsqzWbgDx3sXoQSWoDPD7/Zy/OFwHluSFPvbVKHMQq9abQHnl953Fdt6WJfhSzfmwrCG9r9tswMC4whpvspZOwwvT12cBRGYT/XlaPPCP8Tf11Nxn1BbIMcLiTCCB36Gkycih4I3TEA1bhWHKfnmcp/6q+u/zbOr7Z2cZq2VByQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 06:53:32 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:53:32 +0000
Date: Thu, 16 Jul 2026 14:53:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, 
	harshal.t@samsung.com, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 3/3] perf/cxlpmu: Support Channel/Rank/Bank filter
Message-ID: <alh_wcMiD1hsnXvx@MWDK4CY14F>
References: <20260715191454.459673-1-dave@stgolabs.net>
 <20260715191454.459673-4-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715191454.459673-4-dave@stgolabs.net>
X-ClientProxiedBy: KU0P306CA0004.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::7) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: edc659cc-6fab-4d35-4906-08dee306f259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	pe7zqXQU0Ns/dYB9Eos+nZWbArUfa6tjNDMO+Ti2QWrIa8q7wQZ0gtK0cCx5n+dfy8vDzl4tMPY7EDKvEif+g3x6zybyxeCVV6kqZ34RkSNlCc6lg2rEYB31EeTZOiK80fiIxLAkvJFODRfU8Xjj3kqMbqTNAT0ewG337FkenKOFBDaY2u5FnXW4/S3/+F2Xw/sseLNwDlz8E+FQ2AwDTS/rP4X5+cF99H3UIoZotXJJTsnqTz16zFCOTNMFovWX2EVyb3RNA0xvCd6rNOUastRHehaElm7qHSIGxU+QFEKZXNoes7gxi1uyFbylE/V6uobZJtONZaT5+ktyvdjLrFj7VinqaRPfGte6oeJ2mWh2YinxdRAtIe6J9+PQHZOV/kQQg8AkADVJnDpfqPkYmL1mrtr9mWlzdEEUEXSWudGmkQlauePuMSJvrBUl4BrrFBzoYGkA+aB2mutvuPeWk/tw7GZBPWx8R+G7XhiSeoootKrY++PLKaGekIufbEvyOPMBIpE/893IgHYkIHSuj7LukIOzIhHGM1bi3KN57cR+E8+njQLg9+hVclDUrt5GxkzsqAjc6MssyQZcGIQ2uCjBaJtWwqVIXHYZqI2fOAhzRm2SSxfLMoZWPTEKcJD7v2ro5Ca1/9t64+NMr/kk29tc7t74LyuPGMflMSWuXdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?le5RN4kDsP0LkTbkztdZJNg9Pb85v678LyFGHlwB5sCSjYuAHLvKv12LDFMI?=
 =?us-ascii?Q?PiHlC8ook/CbNyqXpHdDgRoMeFwc3OjqoP0DqYhY0PtZO2nb7FldqsXCBl0e?=
 =?us-ascii?Q?ZyswOwoyv9cmvfn6EaDMVysd+rrs+dkyr9NGXzqtGfegKazYhdp+V84rMyr9?=
 =?us-ascii?Q?FUaE059ckg7TcdjGb6B+8CEL3krBd+2J1/D7AJdEVdV3n5fCu27a2Yw15WtC?=
 =?us-ascii?Q?8wnuqfRW/FgYWRwtgNdUG7BrnZL3m4OWT2OQ14MJgucZHxvlhbelG2VHhlcL?=
 =?us-ascii?Q?lkpe4ZgwpPrQT2/pJfyBtQerYce7wz9fgoHQ/14H7p88XpCqYDhcp09VL8Yw?=
 =?us-ascii?Q?MPl4Mvf+9EvsUkYZvqTMJcmDWptvZGZZTWz15SNXQgO0PAyNHydAjXQ5alNX?=
 =?us-ascii?Q?igcANmlmuYlmqM/EnkD9l5V/W4KR6leX11IlyU6uLk4lg3eNzLJGFby14fRw?=
 =?us-ascii?Q?cWpme17nkWdgotdIBnImCeI5yJ1waY/UsNXCc5mdB8g1SldD6PWWYSFss7lP?=
 =?us-ascii?Q?b3UvDyQ0lwzsRIHmbz1n8rJ37YpUBWaFRewJhmNysmufTE3/nqG0p3AD9lHL?=
 =?us-ascii?Q?EcLMo1HVzP6PM7SnM6cnnJrwo+8ytMaYgcNjQN/a2+fy3TDOYBAjYjNEE3wP?=
 =?us-ascii?Q?RAtBO4/PUuhF7Y2qO4Si5y15qqs5e7pZ2NjE0Q0AijaI7jWqiOhQpT2s7TMw?=
 =?us-ascii?Q?u2Yd/Iw5ptDoN0qqnfhEeKkjgKBJIAKTpXiAaUJgO6xRfD46pxkkPDpwEeFe?=
 =?us-ascii?Q?e4I8EYkhsg080Y2SxHNkBignWDZuvtGGr9GEdZhAr5jGJ3p1KU74XOAzFjj1?=
 =?us-ascii?Q?Azk/q8zguseaKo0zdFN0UfVPnILbocSM3SPhZOo4VeZLhCM26mHj3+JGqdwT?=
 =?us-ascii?Q?757w/RQ7n0cFgkQOA32s8AOkldC7tPy3r/jQ07z9zIzlTtVEd+OyaOYt/l4e?=
 =?us-ascii?Q?5Yb9+q4iDeTjSaHtDy2iSwzkBLa9JXZU3lGsP0EyEFXtdvT7OkN8QOtqdu4H?=
 =?us-ascii?Q?OMKXOyhrYsIzr8mxVbiikE91NkdVGmsRhWqOnNtEm2eiEMLI9Iy24Thdhs9J?=
 =?us-ascii?Q?5oElgAOoeKr3m4OCPjGbSLmLCA6QmaeCPmPTamPSj3tXBr6WeqxWtpaf/5cs?=
 =?us-ascii?Q?FBH0ujUXAwcxrNn3eLVJPK5aLK3JSg5PPF3+uksdhJS4rkKqpupMVazhE/b3?=
 =?us-ascii?Q?xcDsH41lmuzi9cGoMU3UIuMp6loSFVye+ufJfP0jxlx7iJYmhawqo0l+/ADA?=
 =?us-ascii?Q?Yc+4IhTLgF8bsNf213IY9D77TJA7xUh2bz3sxaFpw3vnPrvPikkcmzLH1PB+?=
 =?us-ascii?Q?syjhAnTO6f+TdxTzCPxaFaqlKMhN4lagIgsixedqci1hqyecn6UBPzLwac/J?=
 =?us-ascii?Q?5rQgDHoMm00esNvuNgL06KrIsHzYDJiZsfwzxHHTwpStj3EG+JdhS/5QOClU?=
 =?us-ascii?Q?9lF48VDpd5/40aIqqZQb82USwmPgxHgcNLhuUyxI2WtOHcfqy7gaOje705jf?=
 =?us-ascii?Q?lrqGdSDMgdaovg/f5E1xuOFrbdXDKFovqpbidSPFhXw7ZcoeeG7FYf7Tv70i?=
 =?us-ascii?Q?0SccX3L+YMtTF3ES2BdumAku6KqNN/FEd1RiXKld6KXp/tgGgGUpIjZkfpV0?=
 =?us-ascii?Q?gE9fNUxRqm/hhZpADRMMd46TJIVsOKf9XICytasn1Pc40wLwfDlU0TFkhxtE?=
 =?us-ascii?Q?CSyVUdw8kr3eViRYug6/Q8q1/8/rW7zItJGXniG84q3ijpASKrcyOINtEuqM?=
 =?us-ascii?Q?9Q5HuziPhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc659cc-6fab-4d35-4906-08dee306f259
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:53:31.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8RRnbq0hExEiUzqmwiqjuE87aIoGToCb27hB0BAhXL7/C1bs4UmtmKiBAdCEwHh723kTvzimXdadYMmK+4VXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

On Wed, Jul 15, 2026 at 12:14:54PM +0800, Davidlohr Bueso wrote:
> From: Harshal Thakkar <harshal.t@samsung.com>
> 
> Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the
> current filtering support beyond HDM. CRB filtering is only
> permitted for the DDR Interface, Queue Occupancy, Queue Residency
> and Retry event groups (CXL 4.0 Table 13-5), and only when counting
> a single event (a single mask bit). Because these group IDs are
> scoped by the CXL vendor ID, events from other vendors are also
> rejected. For example, to count DDR activates on channel 2 only:
> 
>   perf stat -a -e cxl_pmu_mem0.0/ddr_act,crb_filter_en=1,crb=0x02FFFFFF/
> 
> Placing the 32-bit CRB value at config2:32-63 leaves the
> existing HDM value at config2:0-15 untouched and avoids needing
> a new config3.
> 
> Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
> [davidlohr: multiple fixes]
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

--Richard

> ---
>  drivers/perf/cxl_pmu.c | 67 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 1fc83858f653..bb32cd1084e9 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -110,6 +110,7 @@ struct cxl_pmu_info {
>  	int on_cpu;
>  	struct hlist_node node;
>  	bool filter_hdm;
> +	bool filter_crb;
>  	int irq;
>  };
>  
> @@ -146,6 +147,8 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
>  	info->num_event_capabilities = FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
>  
>  	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
> +	info->filter_crb = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) &
> +		CXL_PMU_FILTER_CHAN_RANK_BANK;
>  	if (FIELD_GET(CXL_PMU_CAP_INT, val))
>  		info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
>  	else
> @@ -229,6 +232,8 @@ enum {
>  	cxl_pmu_edge_attr,
>  	cxl_pmu_hdm_filter_en_attr,
>  	cxl_pmu_hdm_attr,
> +	cxl_pmu_crb_filter_en_attr,
> +	cxl_pmu_crb_attr,
>  };
>  
>  static struct attribute *cxl_pmu_format_attr[] = {
> @@ -240,6 +245,8 @@ static struct attribute *cxl_pmu_format_attr[] = {
>  	[cxl_pmu_edge_attr] = CXL_PMU_FORMAT_ATTR(edge, "config1:17"),
>  	[cxl_pmu_hdm_filter_en_attr] = CXL_PMU_FORMAT_ATTR(hdm_filter_en, "config1:18"),
>  	[cxl_pmu_hdm_attr] = CXL_PMU_FORMAT_ATTR(hdm, "config2:0-15"),
> +	[cxl_pmu_crb_filter_en_attr] = CXL_PMU_FORMAT_ATTR(crb_filter_en, "config1:19"),
> +	[cxl_pmu_crb_attr] = CXL_PMU_FORMAT_ATTR(crb, "config2:32-63"),
>  	NULL
>  };
>  
> @@ -250,7 +257,9 @@ static struct attribute *cxl_pmu_format_attr[] = {
>  #define CXL_PMU_ATTR_CONFIG1_INVERT_MSK		BIT(16)
>  #define CXL_PMU_ATTR_CONFIG1_EDGE_MSK		BIT(17)
>  #define CXL_PMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
> +#define CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK	BIT(19)
>  #define CXL_PMU_ATTR_CONFIG2_HDM_MSK		GENMASK(15, 0)
> +#define CXL_PMU_ATTR_CONFIG2_CRB_MSK		GENMASK_ULL(63, 32)
>  
>  static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
>  					 struct attribute *attr, int a)
> @@ -267,6 +276,11 @@ static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
>  	     attr == cxl_pmu_format_attr[cxl_pmu_hdm_attr]))
>  		return 0;
>  
> +	if (!info->filter_crb &&
> +	    (attr == cxl_pmu_format_attr[cxl_pmu_crb_filter_en_attr] ||
> +	     attr == cxl_pmu_format_attr[cxl_pmu_crb_attr]))
> +		return 0;
> +
>  	return attr->mode;
>  }
>  
> @@ -323,6 +337,17 @@ static u16 cxl_pmu_config2_get_hdm_decoder(struct perf_event *event)
>  	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_HDM_MSK, event->attr.config2);
>  }
>  
> +static u16 cxl_pmu_config1_crb_filter_en(struct perf_event *event)
> +{
> +	return FIELD_GET(CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK,
> +			 event->attr.config1);
> +}
> +
> +static u32 cxl_pmu_config2_get_crb(struct perf_event *event)
> +{
> +	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
> +}
> +
>  static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
>  					struct device_attribute *attr, char *buf)
>  {
> @@ -621,6 +646,36 @@ static int cxl_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  	/* TODO: Validation of any filter */
>  
> +	if (cxl_pmu_config1_crb_filter_en(event)) {
> +		if (!info->filter_crb)
> +			return -EINVAL;
> +		/* event group IDs are scoped by the CXL vendor ID */
> +		if (cxl_pmu_config_get_vid(event) != PCI_VENDOR_ID_CXL)
> +			return -EINVAL;
> +
> +		/*
> +		 * CRB filtering (Filter ID 1) is only valid for the DDR
> +		 * Interface, Queue Occupancy, Queue Residency and Retry
> +		 * event groups (CXL 4.0 Table 13-5).
> +		 */
> +		switch (cxl_pmu_config_get_gid(event)) {
> +		case CXL_PMU_GID_DDR:
> +		case CXL_PMU_GID_QUEUE_OCC:
> +		case CXL_PMU_GID_QUEUE_RESID:
> +		case CXL_PMU_GID_RETRY_EVENTS:
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Filtering while counting multiple events is
> +		 * undefined behavior.
> +		 */
> +		if (hweight32(cxl_pmu_config_get_mask(event)) > 1)
> +			return -EINVAL;
> +	}
> +
>  	/*
>  	 * Verify that it is possible to count what was requested. Either must
>  	 * be a fixed counter that is a precise match or a configurable counter
> @@ -677,8 +732,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>  	hwc->state = 0;
>  
>  	/*
> -	 * Currently only hdm filter control is implemented, this code will
> -	 * want generalizing when more filters are added.
> +	 * Filter ID=0: HDM decoder filter
> +	 * Filter ID=1: Channel/Rank/Bank (CRB) filter
>  	 */
>  	if (info->filter_hdm) {
>  		if (cxl_pmu_config1_hdm_filter_en(event))
> @@ -688,6 +743,14 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>  		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
>  	}
>  
> +	if (info->filter_crb) {
> +		if (cxl_pmu_config1_crb_filter_en(event))
> +			cfg = cxl_pmu_config2_get_crb(event);
> +		else
> +			cfg = GENMASK(31, 0); /* no filtering if 0xFFFF_FFFF */
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 1));
> +	}
> +
>  	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
> -- 
> 2.39.5
> 
