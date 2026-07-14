Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154252FE575;
	Tue, 14 Jul 2026 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010957; cv=fail; b=pAV9ppBhmungQh823Z1WYHobkV88osjZHO5HKbHGvAzq9wpFkaWJx31dqLPx/wwMsAt6iuaQMNnJVsEvrAnQwvY77EHK/L8aNI/agdHUDEueazmzGmf4ktLRMx80WlFoH76LriMXA2jl0DWZBcto1Orst3URK3gKp29noCZx74E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010957; c=relaxed/simple;
	bh=ZwjhcWpY+KQ/VdOcVYCGDb6HjgnI89o0/A0EkX9H4QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ys8SjTCwKP5Mfh2VMip85uVrspfBdz4yWkpRvQUv22bdsX+Y7VcSX+NfH7u700szvBny1tfs59xb/dVWa/Ckmj3VwekKKS4qkkdPlfn5ex0aVUUntXA3Xel4tIIVjcfhHuHZOrj8sym2p9pkiMmd0VgPJczO47X01O6mRBT8Jqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mvbi4QGw; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mvbi4QGw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot8OpKWzOqO2SdB156Z4VcqbOx6JcjgiSinKV3Kw930lezbUmWC48fo0KBSJJE6BGKZeemp7l4TduI9POKw3vvmiRgRVo/mXjpOocCcOyZSYJFYlCpct1k57NWWMnEsjC6IfjEYUAFSqgoVufI17M9fm6LRgkm/J4MtrZDhICRt9Lp0o4KIIlf2q+lUCGJXNCJJibQ1uEJSomh4u7F+6vI7Mg1n5mRPZMRhIEqdguws4ozDccTymBkoIMjlWtP4qze10fagZhEU6xIoShksnd3Hs/1+wvuRa0UxsUCTB1RbVNytxgJami9gzl4nyzTXfEG/d6cwA9K6WG4QWIbXN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmow8l6gp8Lm5LkV3H6ZMD9YjOASNyaJl3T7foR76IM=;
 b=txa8QSY0p5oXkzjQWQhYgezxcRvL5lVi5R3SjkmHADONEsnH1hgugxiEngrbeBX7sASead5y5ao4uKLH8a5htmePiSU5R2Dn2nJxh1JeFbk8EPwmzelds61AW5BJp2WGZZeXHe3py0tSpUVbZHfpL+Ot9LtfTtJgvIMP9vCOvtSg0L0sEiFsK71MAF131JKOlC/VVSW05ESR13UyMo5JkegLTX1IFbQRD/PfDRT+FAGlyFjOvdteszmeP5wAT/7YYi/8gUJOJYHNGjVIUEGch3HUXhacEwGQ3D8yRCW5NTVbdTXStKt0Lrs4lmh2BXYn+/15LwuWmkiFJFdgkij/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmow8l6gp8Lm5LkV3H6ZMD9YjOASNyaJl3T7foR76IM=;
 b=Mvbi4QGwiURifinVSa6t5EvCLELP8ijSINmqmI8UMWBJAJ8dXMPUadx5rTMCdWpk6wfjLh8ZzNHEtIzS1rnxWz4Mu4lYYz3/5NINVMUX65tZ2z+OWXybxcP9QcmVUzeZS0bHFeLh8HO7LP33FVoqQDdin3QKK/uLPmIve21XLxJkR3opX89VjmFx68RFD07qrMEZyPJj9fqWWqeJsZj8SRdf9bfxUa8+2Yxt8VfBJ03FGCQp2ajpM2hwyjhrzMlr1bbbOyfiqqCHw7dke0QgMMy6Yn35I3G4QIbgDpoWPLYG8RfuJboClA09/qbTVtvgARl9dDxRntqpVQc0w92y8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:35:48 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 06:35:47 +0000
Date: Tue, 14 Jul 2026 14:35:40 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, 
	harshal.t@samsung.com, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf/cxlpmu: Support Channel/Rank/Bank filter
Message-ID: <alXWrWdv-5xxHh4P@MWDK4CY14F>
References: <20260713061112.105419-1-dave@stgolabs.net>
 <20260713061112.105419-4-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713061112.105419-4-dave@stgolabs.net>
X-ClientProxiedBy: KUZPR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:d10:33::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: f97869e5-cc77-42c8-066a-08dee17223a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|4143699003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ouweEev8cQMmrtXnpQhE72StJeOkSnAaX4Qsl0MtuDJgX5qX3J7JRAPbFPyxQa6PtC0veOooxxAHU5Mq0wMsYTHCu65jf/kAf2rW3YFXneG6OW5Mg6rrsK2LwE8RhgdTg45LoyAO/cL/7mQ6+ARSi4x8wb4hMM9xHiHVl1v6DF6YpxILl/4zaVLQKBc31m51JV0JLqF/EmMTGupYjrolOayALNk5WZ5Cg6X+ybBHTv2kDyoe2cjK+gojN7JIUx6PyXAm4MtXzwRBXOPIpiqrCDmS7k8ySWjvc5JatgubfYi/vXZWZ9IYuUsfsrF3glVl16A/Lw59ouq4ZbJz/SNWNHRz2mZbdAFx/NVvkVYdiIzRvo+x3ohxgy8PX5tiiPKMrTSNVDdduGelD/K4XW9TofuaPxIdNCjPp0JNyWObmI99OQ+D1V3sAcOYGKAXCejYQBb3dNov3PcrCdOoAjRo9CxFtIxtvEt8YowVlhLeARdnL2UoHJPTq/jj7tA+b4ymzdCh/A2yk84f/bVbBYydnsVIZJ5MYDDvx+RGIGyS0xzRp40jA4PC+I5ndpg+gWLYqDcmKXYRx1YS1UYej8F6AkZGZJULxq2cTN4AgYKzzAzKwDHD4bAaAMZ1C2jNKc5ihZSWfQcQx9w51ZLeNgdtepGd8wwqsmU+FpvLkNqbavY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(4143699003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oi9n+iS1o+sMFscfTP/KIaB6s9YSyecXDschBtjTqz4vkvagsc3r5xIbpDpG?=
 =?us-ascii?Q?sNySJPZokYBIim++r3jfb4CXmy68gedIvOcvH3JQDgiSJG9FZ5I3R8VqXm/P?=
 =?us-ascii?Q?nWHQhND5liIaONWN/7NMAeiN/0AlU/aflZv1AArTAd1OwpNENHXvctj7xcY0?=
 =?us-ascii?Q?MyNkj82fBp23Ijch1A8gjxdMPmkTMvJ/6ArlPHfigPHfxdgjVXWL44jq3zzL?=
 =?us-ascii?Q?DLs+JwJ6t71YNvKiCgBao5bQXHtdTfCy83fjB3+KCJP0MKqCeb8eHhQQM36G?=
 =?us-ascii?Q?fqdcBMqz6f850tzkS/5RlhWAw+UKzUkpdI899iIy6Lm+64U1TrJbraCpA/cf?=
 =?us-ascii?Q?eLqN2pTk9jpwiRZNPO1slaC00QScong9YN8UFWIJRcKFtLBZg8gs1MFulgwx?=
 =?us-ascii?Q?x4Ly9RXX81O/SEK4QE/PHYzsh1gU4bOY0RupKivB+bY+9deJ3nlbimhMWnD1?=
 =?us-ascii?Q?vzJYyFrcDibByT1d7ryb1cBwVQ64QNHRMGFS99vbFglj0qa4tA8JxDespsCf?=
 =?us-ascii?Q?8D+/flK2WvOFhM7TYADsRMoxJiX4NuSGUMbM12QkYI643mP0RcfhrncySCMc?=
 =?us-ascii?Q?ZX+FCSDmF9kIhuZrD4BhLATNIYrWqXa2E+mObgeB4seiWcdjoMaGoV4tkreU?=
 =?us-ascii?Q?b1Y9m3NMKd3RbYjJq5UtDz5HC1NDgIBtCj8srVMcA/sSpnhynrRPZkz22Nuh?=
 =?us-ascii?Q?OIhskniAVPVrGm74rYSn0D0z16TQDPbpnJApkiDqdl7rs69Rk9pZF3s3PYrK?=
 =?us-ascii?Q?++nJ9AySBb6shYHKHiJTymjULfjKeTxP91JqN9h+0t7O2s329axBASH0le7e?=
 =?us-ascii?Q?mnRI6LXaiLT/km+BB7XmUWCsZUSGUPlYhSNsRLUmnoi0+F5BDI2ICo47ndE6?=
 =?us-ascii?Q?Z6j2qTB7Wctc1gEUwPUARQdaVv4W//ht+t1dqL+ayp5/sM8QkNEHS5oLdBhI?=
 =?us-ascii?Q?bbX4OiWbkRV2MLzfkCeuYlae6+RYsOsT9H5dXxrHQXG/NVi9QWFVcrdwiM2O?=
 =?us-ascii?Q?kAeUTLZqAsfaAdtJ/ftD0c9nto/fhD+yslwFSS3gJvHitskQf7vKwhsOK5dU?=
 =?us-ascii?Q?ggqScGCV2e3G1YacQLO8HZHH/9zuMtSaeYOfRHUZidapiH7s1iCQcdMfnitw?=
 =?us-ascii?Q?J3EyzGX1I/uXFfW48z9I92ri4GLcX0dGTYBN55YZuNvJlDHyc6aY7YeQbo2Z?=
 =?us-ascii?Q?y5kx9QZ4DtRAvB8eVrZmSat4uKdFRdRrLdrS8pCks3YwXTvtbXQtsJWGi/oA?=
 =?us-ascii?Q?yk9AKr/vbS0M+Ud79VyY6IUXSbGfib1gPJS2VmAXOUjjpcx8K9abz0Yn1D+9?=
 =?us-ascii?Q?4Btg5YqXuYMdO20jnMkwDTJahk2lFLcSLIxm0DsB9ZrhEgyC0kSr3QndYFxQ?=
 =?us-ascii?Q?kShnubcUto6fe/DPVMfQrHvgi8MsYBPaA5i1XulnNOBw+M22K0+TPprXxLtR?=
 =?us-ascii?Q?9tmyjcyB9KPeopj+fMcQjwu09S0zis+1JGT+JDQY2NeTYjrdBSJ2pLw+HtBK?=
 =?us-ascii?Q?Sb2DA4PU88i5LFCLGCmm+arTjmRcqOYlPvwtoP4+rtt3LQXsDTZFLZ1iMBis?=
 =?us-ascii?Q?ayt99RmHjncYIr8YnQkwpFx9KjOUSmsT0hD5pD9Upp+Tykhp+E0Ld/G0upti?=
 =?us-ascii?Q?r9dNKMQp+/pWw4JEk4CsEtHp80quTeBAz8i6uk+oKQkXOxrGvyLyPJEAgz/I?=
 =?us-ascii?Q?EY1E3M/rCNVCCkNVKA+XHrTWQOAPFRis3nRKfolriGzPJHck?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97869e5-cc77-42c8-066a-08dee17223a7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:35:47.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Hbg5a9KZ43mGWyBc3ava3QTwYOLOKGeX5hIpvcRkRHMkmheyRV8Dfx27S+EVH028+Z8i6kRTsMqX3f79S0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1

On Sun, Jul 12, 2026 at 11:11:12PM +0800, Davidlohr Bueso wrote:
> From: Harshal Thakkar <harshal.t@samsung.com>
> 
> Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the
> current filtering support beyond HDM. CRB filtering is only
> permitted for the DDR Interface, Queue Occupancy, Queue Residency
> and Retry event groups (CXL 4.0 Table 13-5), and only when counting
> a single event (a single mask bit). For example, to count DDR
> activates on channel 2 only:
> 
>   perf stat -a -e cxl_pmu_mem0.0/ddr_act,crb_filter_en=1,crb=0x02FFFFFF/
> 
> Placing the 32-bit CRB value at config2:32-63 leaves the
> existing HDM value at config2:0-15 untouched and avoids needing
> a new config3.
> 
> Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/perf/cxl_pmu.c | 63 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 1fc83858f653..ca3361eb832d 100644
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
> @@ -621,6 +646,32 @@ static int cxl_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  	/* TODO: Validation of any filter */
>  
> +	if (cxl_pmu_config1_crb_filter_en(event)) {
> +		if (!info->filter_crb)
> +			return -EINVAL;
> +		/*
> +		 * CRB filtering (Filter ID 1) is only valid for the DDR
> +		 * Interface, Queue Occupancy, Queue Residency and Retry
> +		 * event groups (CXL 4.0 Table 13-5).
> +		 */
> +		switch (cxl_pmu_config_get_gid(event)) {
> +		case CXL_PMU_GID_DDR:
> +		case CXL_PMU_GID_QUEUE_OCC:

Should we also validate the Event Vendor ID?

GID namespace is scoped by the Vendor ID, while the groups listed
in CXL 4.0 Table 13-5 are under CXL vendor ID.
A vendor-specific event could reuse one of these numeric GID and pass
this switch even though the CXL CRB rules don't apply to it.

I would suggest to reject non-CXL events before the switch
"""
if (cxl_pmu_config_get_vid(event) != PCI_VENDOR_ID_CXL)
    return -EINVAL;
"""

Do you think this make sense to you?

Best regards,
Richard Cheng.

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
> @@ -677,8 +728,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
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
> @@ -688,6 +739,14 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
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
