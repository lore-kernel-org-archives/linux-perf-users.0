Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2116.outbound.protection.outlook.com [40.107.243.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89A194C75
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303825; cv=fail; b=cg8Ep5nuEo1QhuR0LkTc+2x+Ug3e6UTcNIWFaY8osI/bg/vCD8Gj0pLULEeHHqs+rzUTz2jwOpubJ71epgz4LUlSYCmqbjCj3muJFlSiZOc8SpIqqMLkoMF79ay2QhI0lODH8fqmpWbxFtKH1rcqeULz4ufVk587E2dTNxiBQTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303825; c=relaxed/simple;
	bh=2VGYEVWamaTDvbYGkKQZN3zG8IQdWEeHYlLPtdAwYxw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=WEkRG5+h+buNPQpzGXJJi1IwVN6hrdfctcez3jJ5zEtQJo+Tckv9DthJoqIQRbyhvOBmz14jEYpmNW16vCLljcBJHoDOG+ZTZyVPW98a36wGalu2A9CcdOG69Q/Cs3F4VdHt3wpl62uLhs4nPajR7QRk7fSP9yT8J0ux+nG8T5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ohysZexg; arc=fail smtp.client-ip=40.107.243.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ohysZexg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX+bqgB9tee7rO0PgI112X+eUxEi1BcdFkjZErVUWlRhbBX3eP1LsZuAtDFl3WBhkizQa+QR5LbRvyd/boVl1LuKTEJhRgFOdXSJKzhbPEHjoMqZdqjzO/NmeTvQxVXHAHHQg5rkC8Tjw9VkuYq4qQV4uCWjf/VUBw6lvH8IDMVgJESsWaayiouRMk7izsoBv3oybnk8wQzE0fAP89iN3Y1Ry96kEyrFGrpKal8YfE27wy2ARYI7Fg8hTp8uEyc85RV/Aa1LOJ38Zh7QaoJAuOPo9DLDqcBUoDj1WA36b5RxWbXb0ZBHb8NUrq3cnckOpmXdee+UN4B4fIqhWsmyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apg9l8yUj/X72JUJ/9DcGw97bopBhDiKeD0Is3pAMrs=;
 b=VvU6172mMexDc+xxoUT/IYab4yq4sns/Deqs+3w5YxsQ+LblQmSVtVUoOrfXDhfZkFY2xPwVlUOdWnxGoPQIqTrdndt6YX1odpNjHzouRKMCJ3hBksQpelk+XAhkgwIcIxE0tafoYpO2k1Qb5yq+F5CDCvpv6TkjT+zK9xINLtIHr/VJbE4tVJ64n0WNy/DrvVvkXT1T0NE1tIP4XJDV3Uxf3fm6nHwAK80jl/wTDd82YiZeuoj+776tdyn/MiV+59Boa9vVMCipX7PDv4ma8dbmwTUqQ+1WnUB+6n5RJddAr3o7T2ngsdVERcDoVPVyt1ViYl/mGs6rMzY29Qh9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apg9l8yUj/X72JUJ/9DcGw97bopBhDiKeD0Is3pAMrs=;
 b=ohysZexg0kNqjHDpaeaeM9PPAYEcSxGJ1T9nzkf4OHnH9WSJYdJ1goBfPy3WCwWGiarlyMePiXj4878LaNYFKwyXecBPO7NaxWIUw8E//ioT2RMiECnUw9xSTnmwCfm/Kn1OmzkMUxXEHADCEQ4w/KV0fGh2XeMz/X09ZMDwmHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH5PR01MB8888.prod.exchangelabs.com (2603:10b6:610:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 23:30:20 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 23:30:20 +0000
Date: Thu, 6 Mar 2025 15:30:16 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, bwicaksono@nvidia.com, 
    ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf/arm_cspmu: Add PMEVFILT2R support
In-Reply-To: <b11be3f23a72bc27088b115099c8fe865b70babc.1741190362.git.robin.murphy@arm.com>
Message-ID: <5ac3785a-83d5-e795-a9c8-d118973f86a@os.amperecomputing.com>
References: <cover.1741190362.git.robin.murphy@arm.com> <b11be3f23a72bc27088b115099c8fe865b70babc.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SA0PR11CA0175.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::30) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH5PR01MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 53de0055-a5d1-4099-d263-08dd5d06dc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SWFvBXs9zObK8iaSQPthhZOjKR2t38EUTqRKWT/s8SrU0XZBN89hgQhKceU6?=
 =?us-ascii?Q?ngXz16DYmzosdWAs7lwmcQQfG6iblgDh2NCjokZKXsSeVsO3dkeivqNGzaMY?=
 =?us-ascii?Q?BJn+cCE3h0hX8fveUY7rcDtZ5s2qU+mZ+ivWkrc4ORYZL6feUmLa1k/qgp7D?=
 =?us-ascii?Q?C/mufWBdovHqYHWLGrI6HWoUHEx8wnkCwPhJmtWTuVrhuNusNJGTKfYwErKX?=
 =?us-ascii?Q?jcIyuTorHT8W7Fy0SVrrBeMQ5RToZ173jU5AcU5FNv5g6k/7UiUe2qOqBbEB?=
 =?us-ascii?Q?3ZQ25iPEKhlkSKABUChnpyN+irqwvEvIcSVAM9bFEeoPwwG9dkrCL7ahvohJ?=
 =?us-ascii?Q?RMPQLaf+LKNy/vN+EXISGr2am7zAIM3vSjfjLWnaOxjvnyKwa6Gegss6VBBQ?=
 =?us-ascii?Q?+xc4b/BFvCrPdiCVsrIUqPs41vxaqLG7K4xIJQVagRBwdHXZCm5tXVmp1dZb?=
 =?us-ascii?Q?YG3wBmvq0kipI6ixPf31N5KihwQY8BSrOD+sqDonqyZqS6wOIdS6enlucnWo?=
 =?us-ascii?Q?0eOVbj0ZaVc/YQWpsxDU2xGqDLYDY9pVsxTdM47XcY+AsqgMM9kGIJrRjM2f?=
 =?us-ascii?Q?14cjyTmgKKJ8qPlpHR5zaZDeTMFc2zwsa+y/QyRuDg8o7KXekN1SZCf13iaL?=
 =?us-ascii?Q?WJUrUHBKWUUOF6byvoemyXarLyZClR69drSttOmcUMvLeZrv6YkP/1whLjav?=
 =?us-ascii?Q?cpuUR+cg09tCqLcX7UvBVpHcsm5sW8WbmbTsPvP77EJMnLdVBa7RKXWdzHDJ?=
 =?us-ascii?Q?T4DgXNbfOFid9T1moLvtovVftTU4mc7BpQXTeGxUW9X7szspOTzatScnU5Ib?=
 =?us-ascii?Q?hyr4TWOKaUkh/O2WuvIt/cI9xlX9nydUzj0d3lPVOv8rY4yjF9xnJhSIhoZs?=
 =?us-ascii?Q?nqmbcen9duh4wQKZpP7qg0Lqs8eSjoQsy+omeO3CMsFDMrp7eD2WLTfFTfvp?=
 =?us-ascii?Q?MXWaXdRzGUODi+WAVkPKvkkIap8U/SQQIeuu1263lXqgSJr+aqKGfxo9Waga?=
 =?us-ascii?Q?ly7VzfVDELH+uKZv4sqfx+OZ/iArSpsqxE4xdifrLrKlKe8UY76Zirf3pjXr?=
 =?us-ascii?Q?k1KrIhttfke/KO5ZMa9isbCQrQ6k1HaG8wbxyjEg143mJ2DvR56oWb2+oOxT?=
 =?us-ascii?Q?VHgWmtiriWTvMrcSiB5mFMyN1caFOna7fkVE1I28eC/zLrhDd8n1IxFN3H/z?=
 =?us-ascii?Q?MuomAP5cqkO3L5Bqwz32FBZNZ3PjH++NoniLAAiIaE6nP7c9+VkoxtBGh6ja?=
 =?us-ascii?Q?QKzBCmvMjADyB9nAbdBLf+hYEfbT1XaxFpT947Z46QqvuqYnIyn+Cb3+8Ka+?=
 =?us-ascii?Q?fUjMWDmgrRVdq5X+NHN8uF9I/OGet8w3R2Ghkq6MlfWs+RiMIGwK3ZAZ6dv4?=
 =?us-ascii?Q?EGQDfynFA+6DVgb1FNBqInVJepU3Xt8W0s+9beJuetLl78+DZV6mPv0O4ga7?=
 =?us-ascii?Q?aMhm7tr2ts9/eaedoJdURPKcnF661VLw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mOrEQhY77cr72PVSEDFfOKhvX3fdzDo6njniTG5Ow+jBDhRTGBFsGlQeF5AN?=
 =?us-ascii?Q?BO+o8lIKP4XR7gu5zklcSfeSt2frS7iy3eOwbVUTRQPrVZte+J9PdxmOzsAH?=
 =?us-ascii?Q?XysjqKgOkbln92pnvzJEp5Vz5Zr/yEoEIrWC3ZFCi1QyNxih8rHT30PjmoCO?=
 =?us-ascii?Q?pNjBBBP+CqZ55JfJXwFQMNk2uZgBTmcdijajW26grYdNxPWRUIjHDBNPooEs?=
 =?us-ascii?Q?i0EJsp1kl1Nb+H0GdSDoLcvvLxdN9bjnn5aIk3Kw7ifMZOxFzTgOCzdcv0gh?=
 =?us-ascii?Q?OUhPkKG1ASarGdEUOKNdKDC+eVoyCHMx/XSHOuxfI9KnC3pPUB41WjbYmCch?=
 =?us-ascii?Q?1GSjJ1QoxETGah38WuA276Q8EG2IrG0s7PpAkJE7F0jsED8VDjhj+Ll9eQZK?=
 =?us-ascii?Q?gQeKfzNqxvq06aoQlQctwDvGLCnkKdoL/1BsOk9H3pnZU0GinUpTSZI0VQyQ?=
 =?us-ascii?Q?NhDsfek313GeOfg3IwsKt+YnxHH3QctFIMjWs1Hjq7QfDveJFsBiZC6MI5XB?=
 =?us-ascii?Q?w7jH0JEpol5lYLviY36bhetx/Fq8uZIAP4Cs9kmBuIDTa5bkQIxVCgdTVUbt?=
 =?us-ascii?Q?uOokG52J0gCLTKiVqBYT8cZGqnMyhoS8Q/jhH3yfC2E1l5IpmGecdLcMAK8H?=
 =?us-ascii?Q?shEraLwGJv0jmGzvRKVmvJXEJTV5zeZASwbcTbHwSPGml/gBTgZ7XY5X3LZ7?=
 =?us-ascii?Q?FQ1X3M8mMgsHE0Jm+1fLpuDReDUPWkiEV6wySiyyJ6ZlBdiwZPdG5IQyK4Q5?=
 =?us-ascii?Q?bM+ReEYhQjv6W25kO4mx6iZ6c2wSCO6Nd6KHM7sX4A3qrk6bujiqQtronBUf?=
 =?us-ascii?Q?HVzmog2p/BnCjZ5QAJ/q4H1A9ytex78AnMJ28rhXa20OEPkHBWgysBj/Jhdp?=
 =?us-ascii?Q?ikXnuXbEoSsUnUPY1WfjCSVbk1veHwY1iQwtxpxyWAdJ/wA84alkobH3t3HX?=
 =?us-ascii?Q?FfJe+70g6XrncdTc8oG8+b2O+HsKfAdMZgJ33q26huoTrRy2V26iXdc4H5U2?=
 =?us-ascii?Q?mWi2jA2PBuWK1HmEM0xgqqTgiKmpFoFwiEBdKUrQNv0FAoGn+JhPQ6oQ7jbS?=
 =?us-ascii?Q?Aaaif8s2ugezKOOtNYY3qcGQDYi4S6CjWpobUhW8vuD+zl1GxuiPs78IMu4n?=
 =?us-ascii?Q?Zu0eFpvpEmxqQ0m/azwd+feEZsNmM//MIga3+9Lgd1ld+bIUGOgry80hD2G3?=
 =?us-ascii?Q?lCb90qG1DtHOVqxRcmtdmjeVwMKBdL5Uy0tyBRaZdxbrbFL05dFATkb41ZWK?=
 =?us-ascii?Q?QEHY8z4VGMifI56rBW2AVDOnSWcCNgMGk7ItpkFy/xNabkvuTLKlNwWP9IZE?=
 =?us-ascii?Q?8yTdHvRK3HihM6KaGxh/DkWTr0UqM/W9+dh70z+DqJjyDJy6Cvxi02YL1REu?=
 =?us-ascii?Q?i5DKlRxfOTUAHExQ3yKsspf7RFEdOJDTBKoaI9fYnSFt14Cmu5JOUgvZ7HVh?=
 =?us-ascii?Q?btikKtVclmlLqvS05IYyvz8x3F4APs/C5f6uhsi9paTV2ZmfXcn5/LO3LemK?=
 =?us-ascii?Q?s3BvMCqAJn2MLLR/xxfyIOn5Hvsb1PFcYvgvMq0k7ugo6pT9O7xNJNgdHyoU?=
 =?us-ascii?Q?sBKf3thr9dj7iP6blCVTIBXa6ZYppxt8Uvk6ViD3in97tI8NUp1X5LQOYJTk?=
 =?us-ascii?Q?YMn8sGbSzneWyTNqfvUNKOA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53de0055-a5d1-4099-d263-08dd5d06dc53
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:30:20.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YTICyz/9jjso6e/Ozfv1u8QK4zFE94ScersmT/kxY4btLy7+Ovg59f5PbISi1Yf8txSv23kGBCdwJKgfj7fZaZPzzLHgkQ2ZbZyKoKrB3x1OhBObz4z0ltQy/NJYBv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8888



On Wed, 5 Mar 2025, Robin Murphy wrote:

> Architecturally we have two filters for each regular event counter,
> so add generic support for the second one too.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++--
> drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
> 2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 053bb7920df6..efa9b229e701 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -183,6 +183,7 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
> static struct attribute *arm_cspmu_format_attrs[] = {
> 	ARM_CSPMU_FORMAT_EVENT_ATTR,
> 	ARM_CSPMU_FORMAT_FILTER_ATTR,
> +	ARM_CSPMU_FORMAT_FILTER2_ATTR,
> 	NULL,
> };
>
> @@ -767,9 +768,11 @@ static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> 				    const struct perf_event *event)
> {
> 	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> -	u32 offset = PMEVFILTR + (4 * hwc->idx);
> +	u32 filter2 = event->attr.config2 & ARM_CSPMU_FILTER_MASK;
> +	u32 offset = 4 * event->hw.idx;
>
> -	writel(filter, cspmu->base0 + offset);
> +	writel(filter, cspmu->base0 + PMEVFILTR + offset);
> +	writel(filter2, cspmu->base0 + PMEVFILT2R + offset);
> }
>
> static void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index d59040d6a7e3..19684b76bd96 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -47,6 +47,8 @@
> /* Default filter format */
> #define ARM_CSPMU_FORMAT_FILTER_ATTR	\
> 	ARM_CSPMU_FORMAT_ATTR(filter, "config1:0-31")
> +#define ARM_CSPMU_FORMAT_FILTER2_ATTR	\
> +	ARM_CSPMU_FORMAT_ATTR(filter2, "config2:0-31")
>
> /*
>  * This is the default event number for cycle count, if supported, since the
> @@ -72,6 +74,7 @@
> #define PMEVCNTR_HI			0x4
> #define PMEVTYPER			0x400
> #define PMCCFILTR			0x47C
> +#define PMEVFILT2R			0x800
> #define PMEVFILTR			0xA00
> #define PMCNTENSET			0xC00
> #define PMCNTENCLR			0xC20
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
