Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7818E03A;
	Mon, 28 Oct 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118693; cv=fail; b=jSCviaJ3aoc0v6NHeUOepdxFzhvo94/my7iEuN6KHtGl2doKItBHoPQM56CBirfyO0ayeHbBZtp7HgY1QLdMpQIsbW8SclfEG4Vn6p/L5tkCozd8G1hdXZmjS3UM2nPU4I6qhRrb83u+tjd0WbY2wRfSYNjznr7lQcSQEl8ObDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118693; c=relaxed/simple;
	bh=1zxSnPM+cUvchQQbgxCtwzZoNYD0M/nVTZKFJXPVlkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lslH5ln2pctxqHwsGg2meCu6OvzdJjR2UWQrrD5b5siliLNf/m3sV+jgCVBT/HLeZf1mOXF8+4yW1ne4waDUkv/2pUoVZOhZ22/T4sz/KOW0bk/0Sjc4bi9icqItfEyl4tqbj4opxzlwXCfVI6mUzbL3g1WYSW5zz2KwFOL8qjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ORXENqTw; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ORXENqTw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Gz6BQNyzB3C+gu+41SZygb/wuKF4lEBlKxKCZ8Q2wWOK4tlQlqUQmcpnjCWRZqClazd0j0JCwh9q2vtGrG/0KSPGZpFBWcxKvb3UPttTcVPMHrXIJqvwmEQW/vTKTshLS+UQxJ0FXFNGWrSY2BgZIhKF8jCGM4UlIBkhzbiYSbsjCoHe9T49RBt8X8cjfD93I0VcOOl4QK+808+ijLWaLo/gEDqUSqJlRPy+38b4WyqY8bhxHAHNRwLi+N4eF6/2CljACiZDOwFpJuNYdh+S0BmgTSQsnydgGT1Ih9eBo6CJ+y7j020QA8wur11kCTsfAZ3du2W/QWvigY66rkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oazQSGsIC33nxGVLOULmliuPbJ+6Kz3w9HD45gOr7kM=;
 b=Wp69VhwBE9xjtQPYdvghXs2n/bm3t0o36/kP+W+8Lt9KdvudPl2K1rKaW74h6CGhBLp6fpgDltThl54kbuCUzhmQKwzGnb7Xks+x/F5FW3sctq461f08uOnhlsnzb58hK0JyhN659p06EsDztSnPjLZQwEmg1gr53wnLdoT8aIz1cmdRurQ9sWmF3Y+bDQnfi6D1rMl4JmXwvugY4niGmoTCn/hsO8BKsvno59VKgI6hQX8gzuLJ4mL41OvBnQ6obMcsDbe8gaxmtiK/VZO+VTvrjpnU42If4AW2hmJm/zNA+c7U3QCJU/3PxRQARbv2XjqwFjjlWEymde63d63MlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oazQSGsIC33nxGVLOULmliuPbJ+6Kz3w9HD45gOr7kM=;
 b=ORXENqTwS6dWfCJgBbF2htAzNrQ8SLGQe7ZJtPfGlSdzJUnwPlTN5mLHzvLje6cf+/sbc4OCO1Yi5xL9157+9iLC8QT5ezjAAEfGZD3xZ5c77Vdc/8VwOl5V4u6qPlvSTEod31PO+B92QWnfwnclaiY7N40ut0Jf8B5E1ZDT9Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 12:31:25 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 12:31:25 +0000
Date: Mon, 28 Oct 2024 18:01:10 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, ananth.narayan@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/10] perf/x86/rapl: Add arguments to the init and
 cleanup functions
Message-ID: <Zx+EDmtALgLDRpQ0@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-7-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-7-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7223e9f1-4c38-443e-1932-08dcf74c6fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDHcgi+HaOwCvWi2mbAIahWB3q8HHD35ztNQiLIyE9qkpxz20M7uvvnf56k/?=
 =?us-ascii?Q?JC7/g8D7a5IUhbrwDy6RtnlFIuyFWALVJvDLBTjlflyzApmTZhqwAPi2iAvL?=
 =?us-ascii?Q?l8DQDh/oPbms5psIfGnS6mFbIFFhARz9cjQU1Nr55mYi33QsehB1PrNh5SZi?=
 =?us-ascii?Q?keGWrXcfWYA0Ed7y4PUs/a3RKp+aQoOWNc0k1gmKkp0xPesJI6aIPK126sff?=
 =?us-ascii?Q?obm/Ra9yZs+rqt8rUJQ7BT4cSWpPnivaPak14eTRIm9wYLw9TFnAB/hgfU8F?=
 =?us-ascii?Q?rN+qS56IbeT/EL0UfiDItwjYt+K94FnhT0RImtX2BJ3de8acT8Y1jPKjDIEB?=
 =?us-ascii?Q?8PV+ANmGZ5MntEsgcxmeQj5ksKX8KaaUJf1aT2CWMz9nDMt6awdk4cWPMKtU?=
 =?us-ascii?Q?IZxSm3TOis4+6+supJdBeQbM0JJGeShibIrVwJA+LQ0AJ/UjmNIYEf//a9oA?=
 =?us-ascii?Q?ryCoagZvXMeb8sLGS5PqrpGXDHzrrt1uURHbWLqQg/Zl0ej3g+hbtpn3rTXM?=
 =?us-ascii?Q?33kkz1gPI3QhF8ULM2RUBRhQdvpWGk/scKDBiCyvAHrVZ2yEK/6SJrqEYt9A?=
 =?us-ascii?Q?Lh7BA7ltyS46lGix3++63xq305H1Txoa8RwZekXF+RYJgJN8Oo8X3TNlsnKS?=
 =?us-ascii?Q?eutB15aVWke84SLxs0WwyFuD14ORXXCF71rJCPaz+G090zdaSVq6tPDznsRs?=
 =?us-ascii?Q?5lKJL+XIZRIUgS1hTj1aZDqL+ja6CnFUqzpV/HWI7WhJuh3HeqLjcG/Jt96d?=
 =?us-ascii?Q?66TynCafDDQm0S4EBjCs1Rvdpp8+O8DpaZy30EFzK3Mj9UaK33PesV5S8z5o?=
 =?us-ascii?Q?KLLZqemuGTQ6EYGsWhlbLff5foYVD9Lh6vSSjce/y5Cu4fLqNT24pKcZVcEm?=
 =?us-ascii?Q?MJCy3NlGrDxRlYN1I0LibjVk4b/FNIqXYo74ZH3ulQVXkeF/ANq3w8Wh4vQp?=
 =?us-ascii?Q?NoEfzJ2Sv/DAC3jnN6/6/SgQQU1DazhjVnEjHlLDBJduoC/5c/j18U2q/pKV?=
 =?us-ascii?Q?enTdU8/QyXtP2Op48xKUQt+CFfxqPBUflHedrnqb6pOTHE6ekaaKCIuBMPiu?=
 =?us-ascii?Q?FtaeQv2/hCy4TkDWkE5MsdWKynMNsiLH2e89XFpyz5QPerLgth56ZRgNOJeb?=
 =?us-ascii?Q?UlU3OTODapj846SEr3F39QYSE47aqrHU7YE/OXYjA1zU9LPYhQ8pNFmay+Pu?=
 =?us-ascii?Q?DClzf9Gh6nWoGz4B8+tPBfLXq/VEHy5LIcmyjJbZJ1kvrSsBa0tsWYJJdBsl?=
 =?us-ascii?Q?p6f4TLUA7iR4Hs5pr5Wf4YaipmUwVIav3TPaNKvSyCZxySt4k/vjgvJj/YeY?=
 =?us-ascii?Q?XIdx1Ge1I/1/O58+M7NAxG0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBzG4QBXAeFWYHku+JhreqijeoiD2A2FJjXvXyijcJk7JDgRoibteP4KVY6A?=
 =?us-ascii?Q?cRUbFyJy4ZDG7FufC9aEj7OAenigABzDyw//fkMsvsHoXiRb6oNT0C+exHRL?=
 =?us-ascii?Q?lLyxTYstxT0G5IgAnOPnxVM4MPKx3FVzaqPh2VgLiiqsnkJ5D+6lRbgYpoKK?=
 =?us-ascii?Q?Kw4t908jY/kbGHOJ53gt+3yu24XzOrqpocP58HGIrV9ZSlVvDSa5E5Wo4RhS?=
 =?us-ascii?Q?hg7BwgTbdZ4/ZE6ey+nFpwJfVrAMpC8TCh4cq4x046mENDOhts7OZ/x5Vqyn?=
 =?us-ascii?Q?F1qPFf33d+3kllSthqPgDULr1aDvZ+8PL78hF30k1agzVGvjLiZZUm+PJ99/?=
 =?us-ascii?Q?kcn4+V5JOjsiJEb6gjypLMfnoTIhmXM3nV8kGanoiGzN3D0r0UCeEW7eyFOy?=
 =?us-ascii?Q?ecQOeJUN6r9U+2z/DGD0KORlsrNa324dTyXn9tVx+TXYtLcGJXFioCXJtXI/?=
 =?us-ascii?Q?l4oGIuA05vdgb4Yxq5So0kIRO+IJKypqqAwKCZqCE+RUMRYxJlGzkETqSx+u?=
 =?us-ascii?Q?nOIkUFytSjqh6yYe1d2dUxqefT0NkDuyO96WNUmA8K/hNH/amczVHw9i2HdA?=
 =?us-ascii?Q?kl4LyOpsGm3coa8aSWORmZNya2RVZYLi0R1Vnuy+s8MSFVjhfgH4I7OO6c1l?=
 =?us-ascii?Q?GVHGAgcR0tD540s2WZViFjsOopsq0JIrbjgHbH3l1LSXYPSWg1G3pfp17J+W?=
 =?us-ascii?Q?8fwv66/QUngyDZ9dflF7h9DOK3QBSL0oLgInIJ+q0VXaPCmXBliwWnwjewFv?=
 =?us-ascii?Q?ZKOwl+mbwnJEPlPfYtX6DRGaOyQ4DfVkJlgmkSV7HbtnBl36OVaXv5skZIjG?=
 =?us-ascii?Q?11XzDnl/5TzU96QxqTs6Gpoj/Z61Iah4tR1PWUeIvnYiwMmm/jodti0RfhxK?=
 =?us-ascii?Q?72Ky3mDfyAuhfOjiHrIQ+JM4mBQBZqhKfV+qP2g1EQrdR7YRZDoeY63LhrWX?=
 =?us-ascii?Q?DJbouPag7N6LFSmSzywPjMvQ4D4He+1qKiAWB011xEK6zpyxBCl5ZQEmzKNk?=
 =?us-ascii?Q?yfcH/teu5Vr9gVwul3qHIiI7Tzida16WfTjEFqTt/bSqM1mZgMS9T/blY69x?=
 =?us-ascii?Q?GNy5Cf2M413YP1C2feNEimM+p1Q2VhiBWyOiDrSxpOupD+6uk+fRcTTZRSKX?=
 =?us-ascii?Q?orktzd5VphliXoaD+NPjW5LywTCEM3hKKoFozacdMW1YUZsUkFBLn7OBJkvF?=
 =?us-ascii?Q?kkpBqrmgmjDCzjcctU27of0UcrfEl44KrXRocP0KoxYvUdCO9VCFvbhaT/ie?=
 =?us-ascii?Q?KXzDASqGxGGdW0eABykKX6sqatmJjZgdnTfI8xuQzl56vaI0rqqyxOk34fdl?=
 =?us-ascii?Q?oxf/rgudVaWioc4ypdLGEF3aqck6Oo5J6X4Q78v1N7skWxNL7flvPaOlVl9F?=
 =?us-ascii?Q?4NpKdw308WFNyLj2KhoxdFYMM5C8hd2o5x+vTmKv3SJq2r8FRKm0u/qb3QCE?=
 =?us-ascii?Q?kkNnauzCf6EP5Q/7Dr54zmMuj+qeE9VRhSj7c/p1Xgw6HBsljYIdgGYUWz2j?=
 =?us-ascii?Q?dnReYD6Et5Aou2juU9+h9umpp/pQ6+Fhbv4ePLINIPgvtiQ3CR4dDisHwnEN?=
 =?us-ascii?Q?psHmZLvvLgrAjsONqTkdtQvKrWT7bp4j2dCBTRNv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7223e9f1-4c38-443e-1932-08dcf74c6fdd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:31:25.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTSYpvo85BF7hD7CNLJI10uVYOPoxZbvIRu35oT/PMAK8Y+omXtiMO3V6ZmX9SdeTRfkgCyDL42RkUS8Ho3kDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

Hello Dhananjay,


On Fri, Oct 25, 2024 at 11:13:44AM +0000, Dhananjay Ugwekar wrote:
> Prepare for the addition of RAPL core energy counter support.
> 
> Add arguments to the init and cleanup functions, which will help in
> initialization and cleaning up of two separate PMUs.
> 
> No functional change.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  arch/x86/events/rapl.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 447f62caa5f9..bf6fee114294 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -597,7 +597,7 @@ static void __init rapl_advertise(void)
>  	}
>  }
>  
> -static void cleanup_rapl_pmus(void)
> +static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
>  {
>  	int i;
>  
> @@ -615,7 +615,7 @@ static const struct attribute_group *rapl_attr_update[] = {
>  	NULL,
>  };
>  
> -static int __init init_rapl_pmu(void)
> +static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  {
>  	struct rapl_pmu *rapl_pmu;
>  	int idx;
> @@ -641,20 +641,20 @@ static int __init init_rapl_pmu(void)
>  	return -ENOMEM;
>  }
>  
> -static int __init init_rapl_pmus(void)
> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
>  {
>  	int nr_rapl_pmu = topology_max_packages();
> -	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
> +	struct rapl_pmus *rapl_pmus;
>  
> -	if (!rapl_pmu_is_pkg_scope()) {
> -		nr_rapl_pmu *= topology_max_dies_per_package();
> -		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
> -	}
> +	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
> +		nr_rapl_pmu	*= topology_max_dies_per_package();
>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
>  		return -ENOMEM;
>  
> +	*rapl_pmus_ptr = rapl_pmus;
> +
>  	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
>  	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
>  	rapl_pmus->pmu.attr_update	= rapl_attr_update;
> @@ -669,7 +669,7 @@ static int __init init_rapl_pmus(void)
>  	rapl_pmus->pmu.module		= THIS_MODULE;
>  	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
>  
> -	return init_rapl_pmu();
> +	return init_rapl_pmu(rapl_pmus);
>  }
>  
>  static struct rapl_model model_snb = {
> @@ -793,8 +793,12 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
>  static int __init rapl_pmu_init(void)
>  {
>  	const struct x86_cpu_id *id;
> +	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
>  	int ret;
>  
> +	if (rapl_pmu_is_pkg_scope())
> +		rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
> +
>  	id = x86_match_cpu(rapl_model_match);
>  	if (!id)
>  		return -ENODEV;
> @@ -810,7 +814,7 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = init_rapl_pmus();
> +	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
>  	if (ret)
>  		return ret;
>  
> @@ -823,7 +827,7 @@ static int __init rapl_pmu_init(void)
>  
>  out:
>  	pr_warn("Initialization failed (%d), disabled\n", ret);
> -	cleanup_rapl_pmus();
> +	cleanup_rapl_pmus(rapl_pmus);
>  	return ret;
>  }
>  module_init(rapl_pmu_init);
> @@ -831,6 +835,6 @@ module_init(rapl_pmu_init);
>  static void __exit intel_rapl_exit(void)
>  {
>  	perf_pmu_unregister(&rapl_pmus->pmu);
> -	cleanup_rapl_pmus();
> +	cleanup_rapl_pmus(rapl_pmus);
>  }
>  module_exit(intel_rapl_exit);
> -- 
> 2.34.1
> 
