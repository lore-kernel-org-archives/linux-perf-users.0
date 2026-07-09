Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB803EBF15;
	Thu,  9 Jul 2026 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588627; cv=fail; b=rJryYZrdfUEj3/rvVwu+EplZME5hSDBlE56zh/SbEiQPTN0A6xayT0kRjJMb4PbN8Q0TyXaLmwNWOQWXFkutclv1tHX5NtGeomvQZJUHIe9Us/UMF+KDlNUIqLkuRcmB39YJorUms+CF/eTzPH2BN9Oxn39vA108ovTmnLk8FSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588627; c=relaxed/simple;
	bh=JJTqB92cNS3/LToG+oMdHnJ3/9PdNzrXDmVZ7KZnd5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mkfRgc7BTwV4IM00QqySr71LTxcJAUlXu6LCn8qbfB8Is/I/gordV2a0BWq121QzYFw0rQRULi4kt+6cdCZlVtWgcygsqFCvxnWUYRQObwd+KFbascPf2MF6iq31+SutNqzddjUrgfMMvIahaGj4kLSaGhNrOF9psupMVhdYqiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3FfJqIv; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3FfJqIv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOJMyJB6LAHM9YbEdbUz+q2/gEOC5Xlm/VYrUZKil1UAIuri2VceIiIs5Fqfcrc732fwzjoxmPJaTWvaqhGekqU7Bx74dvCfV2QzGWA/rZxXFA1lOBQltfOvQ54K6j8HhGlH6J43CLGjtngb630iOGXKoLEeSNtVTwqA0pMr8vjV7KB3dTBekW9A91KnqE2b/phSmxzB3dtPUhZZTEDRp04uBX653V09dU8bziCCEEF2McMb+ppBDhLRQ8NUI6L85JKClzkOHW4DDQscxM8t0qmCNl18YLFglNskOIpLUzIRHkcSLkQAUsrqmqhWgwbwVQrysL6xVehzF5y9FQ894g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHowT8qXU/aqj2hMyLXP1/2vYUord0LQigKfXjK65a8=;
 b=L90iVdcfj56W/wRkEozREJ09MZCHzaH3JWTTENS1q+Oc3/o7Fp6VvMNZuVCulK2oRr/nQ5vOIYHMB3wsqcN3iuPyPhB1WQMqITI9LKhDq6RuKmGlSqmO6sbnLdk+9hyP8wmwbK70ljQGIrzJ4QRvEhbcpWPsuFlYIbYdZvTDm7Ow73jFvDfiu1+qp1+hSfS2qlKzN7t672b1U20GwuIfi6u3bB5bjxgc9z6yPS8Z5akZDDEiKO4bFXh1fbLDNFWw5WFj3RGLpKcATc0LDm70xPVnBcmu+lTWOo8h23ZLoKSrAFSS3cP2UbPJpePOZjO+jj8gYK1qVjSQlgfTOXEqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHowT8qXU/aqj2hMyLXP1/2vYUord0LQigKfXjK65a8=;
 b=a3FfJqIvcr+e1CR+/13CajYlrQRKlCGGolG9u82sPQcnsertOh4wm4p37ciCx0o2SvtgH/oF4igHYtqdHzVZVLcRVB1zwl40d8QnobyN+ukm9IbzJ4ZhsDojcnXQR6TJH/wjs+O5VLdsoudClZ6mTcDDKdJsCfWl2Xgobr756n39fKwJAq7Hm5SbTm1ydNx4y6v+KqR2prNpqsSYdY+zbikl1Rmgxem3e1qSv0K4oBby65fG3wsBLmTa7eNB5FhwciEQoKCAmu+Zqgyw16p+Rr4ZYVCDTFHoCNo3GUNMvs49xhclrJtOdmc72RB4npj/sitx0rgZmvPNVMDUwffRjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 9 Jul 2026 09:17:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:17:01 +0000
Date: Thu, 9 Jul 2026 17:16:53 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, 
	harshal.t@samsung.com, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf/cxlpmu: Support Channel/Rank/Bank filter
Message-ID: <ak9lQFNDiWAr2GUE@MWDK4CY14F>
References: <20260630235002.253297-1-dave@stgolabs.net>
 <20260630235002.253297-2-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630235002.253297-2-dave@stgolabs.net>
X-ClientProxiedBy: KL1P15301CA0053.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d8fad6-31d1-4b30-3afe-08dedd9ad550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|6133799003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dUm+oeq5sgvLmGn7dg5ua1vZrCDTq0+AFLv20wjAGuWfC4T9hYlEqg2XbidyOcf2kIcdL+sK4g3aM7IRdkeiZ2aF+RQPL99aDILPlzchAmrcYQvByhN6lEk2K0U2nzmwBpp1PKVJM+A+0Xjgw7k/GYwhYegYiLtQJ/7ruCog1LJpq+Tw8bfimQIdRvek82T72d4jkGG4Pf6BSUjUx3BCLWvk8gKQH3O00BhNc90AmHEEGdScZlOT0Yjd49D1rg7mhYcXZfHJukAV1X/zgfFQOhTvpbn4kmPL918KQZwww8BG2TI1RdawCJaaSBssFhCF7kWFfB86HEpqFbPCUc1JNJWJRNS/cur4SVLU8XBTIptqo/xwni+meRrwZHqDWz39kfsn5TuYAOwnc7gguVci89Hdxti6aqYxVZ5UrlGtXvpJWov5xAUrS8SNzhcPJB25R6NUhQpHSk11Dpi/ZxAXxtpFyj40Wi8jawLsF8cJD1reYoGPpNazF8hv0R2rlUAjvY0xoGcuZNq6euQrBsdIc1QQHvn5ZX/76ulF8WEg85I49xxqYNXxi/kJmvsMeuaC6yukjQ+mEcRwwc4BuwMaNO8a84G++kvQlybIaXLkZ1hX+VYct19ppeAtoGicIr/yRdaxk7dbXHHBuyEJi2bA7cAAnLZBHK5IfGECUDUNNHk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(6133799003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EEY0BpdN8Km7df0L23f5ZMaNAPBgDBJamHtZ2cz4m/MFsnGbjpZ86EPWAG7a?=
 =?us-ascii?Q?bDTuIg3yMQbErCk/qSdVyvXI0AMAS4U1MKF7rKwIHppAEfnoXOgRJXtWv+05?=
 =?us-ascii?Q?xOniyJ2H/RbbZF1SYFVsZUAcVn9FDhUTyOJuRCFmQeEX8WsVLIqCPYNevcdW?=
 =?us-ascii?Q?w9/3gn1Rkqm7XGMPE0LA+eGqwIdA3C/BYbwTq1IvSwakIv99Ic3B8PR2M/yn?=
 =?us-ascii?Q?7jvoYJkY9VQeF2GEvnBDxXSYBfwwsPpHk3sC+p1Lohl2uoiuFBoqE1tKpj8z?=
 =?us-ascii?Q?jOccNViVvIYPyh61oDJuAG4Hu7w/UhYt5Bv6Tsnrp08qcmokWrc8eRDsQSX9?=
 =?us-ascii?Q?juM/Caohwp6IcFei235QyFkHgTgo97ynoG4QvRSfkiIYeNxKkOxn1vUahoUb?=
 =?us-ascii?Q?oW1ZApGCYjBl+PmgmsgkcICFVgCnfKxj/pJ+97itdAPalXd/J2haxPHyU1I9?=
 =?us-ascii?Q?q/FMXlNT7JeswWkC2V0mfaF8iGdmES+i+P/jTAQd8aFqsWm5uwPpc8YpJQzz?=
 =?us-ascii?Q?+NzAg2WboDLx6A50EnGAGk7OGHOBDwXgVl323hLScb8AW9GV7jPMDAiA778H?=
 =?us-ascii?Q?c0pF0vRM4IN3yxnX6wI1VsYCPsklC/MgTiG3z1ZGZPtczqjIIxOt5OgxxEpF?=
 =?us-ascii?Q?3P+RMLZK7QA8vUprVKlY2zoB1EHmrm7EEd0EFsnyLJdoi4x9zJRqsUKD3ZBt?=
 =?us-ascii?Q?30ET4gsuAmtHW8cBXmXP1kR0X8ppvYin1pg8xdkIT2RhzBaB7g57zBCMB4lU?=
 =?us-ascii?Q?u18aaMArBoXsh6Ne1NHLlerbqouumRv0xIj83OFPk8g0uGyRKN5zIBbr/c0I?=
 =?us-ascii?Q?FkPb4I7yk9xnpLZzaT7y5rIRH15VmOqok+uTQVQNHe3qfiyIfbHlKhIDCtI9?=
 =?us-ascii?Q?I0+/peA0E6W3RskT+3ikUphxWHIuhmbDmFSfQcmIU4XOhVg019E7tmUQOvVg?=
 =?us-ascii?Q?dhIwwu7xQ94pxfo9jfxmJF7hfYIvOvM/VYPS3tznDoAlMzEtXLbo4RHWXQiO?=
 =?us-ascii?Q?DZcHaAkKnrfoUgMFDdy5F5BTdaIBlhyXzMrR4ZVR7kTqcCxhRmBmXgH8jICE?=
 =?us-ascii?Q?ybJKdErpHeP2TfJHBxE934B3oigWfMe5RjwnXwQfivKrnp5y8YYTwKqtqkVu?=
 =?us-ascii?Q?tRLqNrcVi18tKAT5kY5dvtfRgtFtvdqORbXjonO4egTA17YBtnQSiqUGxZPD?=
 =?us-ascii?Q?ndtS88/jKb1r4nLt5ZXxlL79y8rB2Zxi4eM0REc/ZLUubuV9JFiFfsPUIjDE?=
 =?us-ascii?Q?4OA0ub7WFynR6eIZWDbuDZyWqkDcU6EDisUR1XDzbICit/rhXnudouuoJdyZ?=
 =?us-ascii?Q?HqbVKo5dyGjbIXvQ26IiNFq4U88rdfAQntn9bBs/4e3T3M+GnSzRnsJfLBEC?=
 =?us-ascii?Q?dafijqNPhy8Yiqme0rn1zU3WtVebRY0TOQtGmz9qCNxBII9ZypkfmOhlQMmU?=
 =?us-ascii?Q?TJ6V/YugiHp+XZgYCMTzrstmY851xeiDq+B7ivlaUByycIM5kY8WuI0AP+oH?=
 =?us-ascii?Q?g3tlwRSvhL3CTlSr5yXG8TDQuEHUwSgYHV4QoDB6AY75q0+tD5rlpyE+jbKQ?=
 =?us-ascii?Q?HBqkh/l0cX/TfqqkZ+0TCwyERUOebS6Pi1KVE+t8NsA48BlHlCbdUPxkgPNd?=
 =?us-ascii?Q?F/9KbZiObZxwwHU3zpWuODt14U8ZQcVJOE88VlPDWMB39lAlNUA8ZuPbE++A?=
 =?us-ascii?Q?Wi25uWdt7trzqHGCSf8nVwWp6pPhU/ra320cN/PGhFHlRUsdAc8C99geJKfa?=
 =?us-ascii?Q?QPwwNvAAJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d8fad6-31d1-4b30-3afe-08dedd9ad550
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:17:01.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBPqmxDPjEu+qOPCqaFXwfcd5bYsAcP06GtZC/v6qgMtTnIVUd9/1IN0j82xZ7rKe95SowVpK/M6qQMRfwZxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

On Tue, Jun 30, 2026 at 04:50:01PM +0800, Davidlohr Bueso wrote:
> From: Harshal Thakkar <harshal.t@samsung.com>
> 
> Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the
> current filtering support beyond HDM. These filters are only for
> DDR Interface events.
> 
> Placing the 32-bit CRB value at config2:32-63 leaves the
> existing HDM value at config2:0-15 untouched and avoids needing
> a new config3.
> 
> Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/perf/cxl_pmu.c | 47 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8..58c15680f299 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -106,6 +106,7 @@ struct cxl_pmu_info {
>  	int on_cpu;
>  	struct hlist_node node;
>  	bool filter_hdm;
> +	bool filter_chan_rank_bank;
>  	int irq;
>  };
>  
> @@ -142,6 +143,8 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
>  	info->num_event_capabilities = FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
>  
>  	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
> +	info->filter_chan_rank_bank = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) &
> +		CXL_PMU_FILTER_CHAN_RANK_BANK;
>  	if (FIELD_GET(CXL_PMU_CAP_INT, val))
>  		info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
>  	else
> @@ -225,6 +228,8 @@ enum {
>  	cxl_pmu_edge_attr,
>  	cxl_pmu_hdm_filter_en_attr,
>  	cxl_pmu_hdm_attr,
> +	cxl_pmu_crb_filter_en_attr,
> +	cxl_pmu_crb_attr,
>  };
>  
>  static struct attribute *cxl_pmu_format_attr[] = {
> @@ -236,6 +241,8 @@ static struct attribute *cxl_pmu_format_attr[] = {
>  	[cxl_pmu_edge_attr] = CXL_PMU_FORMAT_ATTR(edge, "config1:17"),
>  	[cxl_pmu_hdm_filter_en_attr] = CXL_PMU_FORMAT_ATTR(hdm_filter_en, "config1:18"),
>  	[cxl_pmu_hdm_attr] = CXL_PMU_FORMAT_ATTR(hdm, "config2:0-15"),
> +	[cxl_pmu_crb_filter_en_attr] = CXL_PMU_FORMAT_ATTR(crb_filter_en, "config1:19"),
> +	[cxl_pmu_crb_attr] = CXL_PMU_FORMAT_ATTR(crb, "config2:32-63"),
>  	NULL
>  };
>  
> @@ -246,7 +253,9 @@ static struct attribute *cxl_pmu_format_attr[] = {
>  #define CXL_PMU_ATTR_CONFIG1_INVERT_MSK		BIT(16)
>  #define CXL_PMU_ATTR_CONFIG1_EDGE_MSK		BIT(17)
>  #define CXL_PMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
> +#define CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK	BIT(19)
>  #define CXL_PMU_ATTR_CONFIG2_HDM_MSK		GENMASK(15, 0)
> +#define CXL_PMU_ATTR_CONFIG2_CRB_MSK		GENMASK_ULL(63, 32)
>  
>  static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
>  					 struct attribute *attr, int a)
> @@ -263,6 +272,11 @@ static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
>  	     attr == cxl_pmu_format_attr[cxl_pmu_hdm_attr]))
>  		return 0;
>  
> +	if (!info->filter_chan_rank_bank &&
> +	    (attr == cxl_pmu_format_attr[cxl_pmu_crb_filter_en_attr] ||
> +	     attr == cxl_pmu_format_attr[cxl_pmu_crb_attr]))
> +		return 0;
> +
>  	return attr->mode;
>  }
>  
> @@ -319,6 +333,17 @@ static u16 cxl_pmu_config2_get_hdm_decoder(struct perf_event *event)
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
> @@ -571,6 +596,14 @@ static int cxl_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  	/* TODO: Validation of any filter */
>  
> +	if (cxl_pmu_config1_crb_filter_en(event)) {
> +		if (!info->filter_chan_rank_bank)
> +			return -EINVAL;
> +		/* only valid for DDR Interface events */
> +		if (cxl_pmu_config_get_gid(event) != CXL_PMU_GID_DDR)
> +			return -EINVAL;
> +	}
> +

Hi Davidlohr,

Would this be too strict ?
In CXL 4.0, Table 13-5 "Events under CXL Vendor ID", Section 13.2 "Performance Monitoring"
Filter ID 1 is also permitted for Queue Occupancy (8001h), Queue Residency (8002h)
and Retry Events (8003h).
With this change, when we do something like
"""
perf stat -e cxl_pmu/rd_queue_occ,crb_filter_en=1,crb=0x5/
"""
It will fail with -EINVAL, even though the sepc allows Filter ID 1 for that
event group.

>  	/*
>  	 * Verify that it is possible to count what was requested. Either must
>  	 * be a fixed counter that is a precise match or a configurable counter
> @@ -627,15 +660,23 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
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
>  			cfg = cxl_pmu_config2_get_hdm_decoder(event);
>  		else
>  			cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
> -		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +	}

This is a real bug fix on its own.
The old 64-bit write also wrote 0 into the Filter ID 1 register at offset+4,
and per Table 8-186 0 there means "filter to hannel/rank/bank 0", not disable.

So on hardware that supports both filters, current kernel silently undercount.
Woth splitting into its own patch so it can be backported without the new
feature.

Best regards,
Richard Cheng.

> +
> +	if (info->filter_chan_rank_bank) {
> +		if (cxl_pmu_config1_crb_filter_en(event))
> +			cfg = cxl_pmu_config2_get_crb(event);
> +		else
> +			cfg = GENMASK(31, 0); /* no filtering if 0xFFFF_FFFF */
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 1));
>  	}
>  
>  	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> -- 
> 2.39.5
> 
> 
