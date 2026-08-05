Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020083.outbound.protection.outlook.com [52.101.56.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7730B53A
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913694; cv=fail; b=efQme8PQsrNNmJ9gzoftSYmDPpkQSDSpxgloJpsqQqv8kP8z6e8cIeE8mis0ZkEkLeiNSaKMd7PMzOHw+yPm1Mqbo9lWEsB7gWlSi7QBe9fjbmZ7nKvGnS66DKrRGTWWaD1OIZlYUPVHmJclW7fZ9mseeWfYLhqYaesPGnWuNk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913694; c=relaxed/simple;
	bh=o/L3ju6I6Mk4VzKq0UiotVOTz5+K8aIKLnUKPrQL/uo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=A3h9DNWlWxY/4i29ZPsXPmSzJb0j/u+YVSj/KONNcNLJTlPU3PXClyFCEce9m1IHKCp6hmisNcDZmOve37VwfuA6DZmzd4Zn2XyolTylAUHrh3WHLqbWKi/mLP0o8K4BbTBA2V1qlPqrEAwo/jSgr2oYsZ9E1kxMY6NmoU5R73U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Oj1451fi; arc=fail smtp.client-ip=52.101.56.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Oj1451fi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPXb5NADMHwEDIs0cbnqWqr3rbG9Lj4WLMFDSPfHh/LjGqDD/adLIMLpBIQzCPc6IPMCcqOcJ6o1VQxX+opS/eakdkBW6fvknzf6VAui+DIiguLY5pL7L5mEaUwoCoLLyiarKwe+EgBvPIFj8HKC+WRJfGE01Ku7crMXiYHC/EDrJKyi9oL6Uq7LI9Q/RKQcSaMcxSlzT0jIjKpsNovHob5We63wXMMfoxoLK26TviFUl2titdiq3yyiMj8okGaM73wWuRYeEN7o/IDmeqmleWNyQcxxGO6ht0SvgDFceSGVi+cE9JexpLqJ13FzjhXHRLm4CbnvyUUGVpZHIpUmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=webVN/gRm6vdlkdIkrxjgiEoIDI+tCyX7pHkCf/tA1I=;
 b=ikO7eaHreoCIu+94RXDyYJo4iCo8WqMsXkj9ZXYgSDz0H0eDIAeeu8dzmuYxVM9w8fckCaLHb97e2DP380nDR+bHPR8SFJZfFZSVUT9RAtTe5iwZ1SaB5z8Bb3mSmmpQ9qxRsxdTjbvTT9LtFxeOyR86Iu+akdgyDt9zXE8PtIixEpXImAwlt/FghUSIoaUy0l8EQgC7r7BS7EB3AavvbLLCkrrc4wvOiyWJ1hDxYGxbT0mNZrNJRfR4SUSvXuWZwrCzF8SOdDMzSN9pYEdAea2AYpaMMwKGZp3AQVpGfKAI6xIqETbG37Ih6a7hBc2pgoETmlqzhzPL1SNwPGYYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=webVN/gRm6vdlkdIkrxjgiEoIDI+tCyX7pHkCf/tA1I=;
 b=Oj1451fi0vmHcC/I3/o7WxALkIL3PPW90hDSVEiDPVhdSg1XF7AhXv9EFChiKRRC0hIe7nhlGUIeZYtEl0JqWDxpEvdvL+00zUyCigQUj63weCklA7+pjUypmZbFclXqcLIKIp78GMKnRhw/sWUvM2p/WiZk/wW8LLQx6kd1PRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 CO6PR01MB7401.prod.exchangelabs.com (2603:10b6:303:14e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Wed, 5 Aug 2026 07:08:08 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%5]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 07:08:08 +0000
Date: Wed, 5 Aug 2026 00:08:04 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com, bwicaksono@nvidia.com
Subject: Re: [PATCH v2] perf/arm_cspmu: Support 64-bit programmers' model
In-Reply-To: <2bde4469c918494e8fa04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com>
Message-ID: <14ac4db9-9574-70a0-485a-1943dce0d5f4@os.amperecomputing.com>
References: <2bde4469c918494e8fa04b2d297a6189ac8b7796.1785511378.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:303:86::28) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|CO6PR01MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: d5659a15-e846-4cae-a919-08def2c04d35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|55112099003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	l96N/z4gqyj5A9pWrHOSnDxXxAeUzWn0dLP5UU+eA4ri5qEpq+u+EeyrUlr1I/CTrDHsOF3glMfE1AtfyoWwOaBzxB7DONE76smYWNSctTNlHddeB0W3nQAJjnyA/GSxoYz/hrtSx+Yhb+bWQnMEFqKmQDRxhXvL/b2bLdgVjbL+HPvvN8gZtEyh/phfYa9ayitVMmomVSmnprVOMrAmcco49pvazMKGD0VSOnzn8OCG6ldlBUmFM7tvuLqviQmy3MvMt8wqkfI7S1u9yDS7ZtdVy15z4VPWbGhD3urj/Ts9cTqQQuEOWqJpyr8TSo4wEEUeXYUeom5kwOcCiS3pf9UTOh0fpC4WeA1lMQ/6yuVne80hTw/ZFm6zw+1jXs0D6TcNFtk4ksdk4WTxegU/tS0rCWfvlVaDtg3aTarRjT7iMR/8PKvUubqGuVNHPm28XqrEQa45Eni5HOPPNhCNOb91tkK5NnFHgWi3BmyY5qJhBJ5icZUgHG1X4gzWfT2NBDQ8P7U8zBynlCWvqD9pXu9VbVr5sjLTw+WkC+VWrkBm6E0YIVjS/ygyZOowXUlSbn2YrjlfPv8zc1YmhEYvprIPmPjlrZHrCzjGxv5jr/VgKULxa3OW93d/j6OnQfV9JGBxmqGzgayHBNB9tTAoUMDKL5B5pH/muX0OCfKRyBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyBJ0ksYQwDJEgMdjIwYf61pFdCjK7ALiy8v0/rCYqjoyvsNtt9SovetYymH?=
 =?us-ascii?Q?OSvkpTHr7E2XHuYM0T6kVTJtLlYm14bqfBn4STZo+/RfsSDVhYDWkE29iEt0?=
 =?us-ascii?Q?YhvAd2kB2CwdEso+PBz5qoFnl/VT6xGYk3W/IO6QZwQ+nVr9XxJ/OEdTujHG?=
 =?us-ascii?Q?sfI5K7gBHLRR2Bjj9LOKebWKwU/ygvxxSnu94AjAzaAUYS6hSUGZXkZw8Dgs?=
 =?us-ascii?Q?AeFAHlZVQH3P/3nTy9a+k6xcLvg7Se97O/JwNexfcMzbzSlxykUthuhe7yVw?=
 =?us-ascii?Q?00dmo6l6wT0nurN9du/CU18q8dTAI9TjGA2Aohh12Qic5iios3t8nLrDw6de?=
 =?us-ascii?Q?TjCUj2Myh1qxcxyJkZNNWRjoq7R9p3OYS/CdtEhno0NPNXi9mONzuqYqPqZU?=
 =?us-ascii?Q?skBoPnelo8DyrUUQlZxpeSKVwGwIkAsxArSqeqoYco5FGjLuk0v65vJYHjsF?=
 =?us-ascii?Q?uoMb6ia/ynAri2vPVR9ICvDj0gzjgvBlMrXZYUmJtKWTu13maLNZtPwl4wND?=
 =?us-ascii?Q?BpogxkEu7djiy812bVsjj5YAdzljq3wMALs4rvPcyPSXAhTFvZDmazLkNYG2?=
 =?us-ascii?Q?Bpr6+f2882CsImtNbrCMEjjZ2L5fMB1o/Ajpi37YMApUvjl2iG6spAd1VCb2?=
 =?us-ascii?Q?YmCWzAf+5Nkcrn1Xy5terzkccckefkW2ygkwb+5gh3RjzPKZVMD4iIzaj3/u?=
 =?us-ascii?Q?kG6Y3oajy49QP94c0nzPLqWIe7DES2LgGZ4KQh8i/beFiKPjQ8gjb+qyDN6I?=
 =?us-ascii?Q?LL8NXJBwSbbUVV4Yg+XGUArLqTdE3RlqU0XQUuHFYNoHFOnuAkHFBFiOsP+G?=
 =?us-ascii?Q?ap7455YmNlhD+kKuOaG1+h/C9eGdwlH3xdJzNcE93edtuz9DFx/2D9UVfBnJ?=
 =?us-ascii?Q?j08ObJdUDvpZVKRh29w2abZdto2Uch2f7CQHCChv59sp9E0TClWQ0tUcaQF1?=
 =?us-ascii?Q?HH95K9QUgeLTZoo4wuH/fUUY0dt5spPdBONnQFzJjNoh4fgCvPxnWavnypvh?=
 =?us-ascii?Q?8F4p5cgAL1gB2z0FvEoU9PHoDlo+oQNBLu8oc6v0Vg1HnuNzvJosO0wqFSrc?=
 =?us-ascii?Q?rt1b2PksRODPY5e1HAyy3tW9Nscf0lsyKjP7edYf9PR2opgMBsPL564WTSxE?=
 =?us-ascii?Q?sEs9ths2akKp/g+aVqbUCfcpF9NMTi88h1nPyRhdI6UwJJbH990dVv8Sssdt?=
 =?us-ascii?Q?ZG6N5vKRsfKzapDGHE/el+h1/0RL7f82W7cnPYXSIOI8uWfs99KD0DErvXQx?=
 =?us-ascii?Q?9FgWq+my+3eHsQo/PF7gCrqaHbXG5kNFR2t0u6bPcECS32ESBncfWLqrwESx?=
 =?us-ascii?Q?e9qRnMVBKVSqYTwkChHLOpW7M7WM3Sq6nmcUfZuhPLzR8/hQWgN/OhlFIvpA?=
 =?us-ascii?Q?sfh6l+tTtcpd/A6hV3BbM4vMUXEPD7CacR7fpRHpmoX1S2szY4rxhOX3pN9q?=
 =?us-ascii?Q?rqVwUPlENVkYdKxWu7B9lYebvG/zdOlxRrMQHeIXeGXZv/IvsAjBKOUr++Yf?=
 =?us-ascii?Q?67RWukbIAUgPKnqCiFBIgB7AnRQnHqNhBiCQ7SJ1Oqeqm+R4igi7Hcet2E/H?=
 =?us-ascii?Q?AMmXfgzyft06hcIi9H1t9WB/ESezyqylfcYZTOHU0ovDBLP1cJ1lB3cXIq5W?=
 =?us-ascii?Q?qOH29sIKI3pVfO2rI29Lp1/nnQIWc9vZ4W5HO0i6akQMyODLgcDNtGxQMvML?=
 =?us-ascii?Q?eKuhdTazuAUT9sc/4N1BlBlJq83bxgjF4I8+0dd0pgDllmtmwN/mufXSc9fq?=
 =?us-ascii?Q?0mAO6yS+doeZ9TO4/cWRA9pWj9p9apM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5659a15-e846-4cae-a919-08def2c04d35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:08:07.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAaH9Fnr4t6PUITWUOP4eL5GjDkuEhUgZJ1I5lPrMtCbQp6tVpULgFKpcRJD6BDf21yP9m61IhSDeoWa1cTVaixpllJBM8iIPPpUd2AMsM71gZlphf024YcPa+8/THaL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7401


On Fri, 31 Jul 2026, Robin Murphy wrote:
> The 64-bit Programmers' model extension, now named FEAT_CSPMU_EXT64,
> makes all the non-counter registers 64-bit as well, of which we most
> need to care PMEVFILTR<n>, PMEVTYPER<n>, and PMCR since it changes
> location. Our event config fields are ready for this internally, but
> we need a few more tweaks to propagate 64-bit values properly from
> end to end.
>
> Since 64-bit events leave no room for our existing "cycles" encoding,
> and we don't really expect to see implementations of it anyway, we
> deliberately omit generic support for the architectural fixed cycle
> counter in this case to save some bother. At worst, vendor modules
> can still implement their own encoding if they really want to.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

The patch looks good to me and v2 seemed to work fine on Ampere platform 
still.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
>
> v2: Fix off-by-one in the event format
> ---
> drivers/perf/arm_cspmu/arm_cspmu.c    | 121 +++++++++++++++++++++-----
> drivers/perf/arm_cspmu/arm_cspmu.h    |  25 +++---
> drivers/perf/arm_cspmu/nvidia_cspmu.c |   2 +-
> 3 files changed, 114 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index ad82de166dd1..3b48a35b6241 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -78,13 +78,13 @@ static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
> }
>
> /*
> - * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
> - * counter register. The counter register can be implemented as 32-bit or 64-bit
> - * register depending on the value of PMCFGR.SIZE field. For 64-bit access,
> - * single-copy 64-bit atomic support is implementation defined. APMT node flag
> - * is used to identify if the PMU supports 64-bit single copy atomic. If 64-bit
> - * single copy atomic is not supported, the driver treats the register as a pair
> - * of 32-bit register.
> + * With FEAT_CSPMU_EXT32, all of the MMIO registers are 32-bit except the
> + * counter registers, which are either 32-bit or 64-bit depending on the value
> + * of PMCFGR.SIZE. It is implementation-defined whether single-copy-atomic
> + * 64-bit accesses are supported, so we rely on a firmware flag to identify
> + * that, and otherwise treat a 64-bit counter as a non-atomic pair of 32-bit
> + * registers. With FEAT_CSPMU_EXT64, everything is 64-bit, but we may still
> + * have to deal with atomicity being broken.
>  */
>
> /*
> @@ -173,13 +173,30 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
> 	eattr = container_of(attr, typeof(*eattr), attr.attr);
>
> 	/* Hide cycle event if not supported */
> -	if (!supports_cycle_counter(cspmu) &&
> +	if ((cspmu->has_ext64 || !supports_cycle_counter(cspmu)) &&
> 	    eattr->id == ARM_CSPMU_EVT_CYCLES_DEFAULT)
> 		return 0;
>
> 	return attr->mode;
> }
>
> +ssize_t arm_cspmu_default_format_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct perf_pmu_events_attr *fmt = container_of(attr, typeof(*fmt), attr);
> +	struct arm_cspmu *cspmu = to_arm_cspmu(dev_get_drvdata(dev));
> +	u64 field = cspmu->has_ext64 ? U64_MAX : U32_MAX;
> +	DECLARE_BITMAP(bits, 64) = { BITMAP_FROM_U64(field) };
> +
> +	if (!fmt->id) {
> +		set_bit(32, bits); /* For 32-bit "cycles" event */
> +		return sysfs_emit(buf, "config:%*pbl\n", 64, bits);
> +	}
> +
> +	return sysfs_emit(buf, "config%lld:%*pbl\n", fmt->id, 64, bits);
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_default_format_show);
> +
> static struct attribute *arm_cspmu_format_attrs[] = {
> 	ARM_CSPMU_FORMAT_EVENT_ATTR,
> 	ARM_CSPMU_FORMAT_FILTER_ATTR,
> @@ -198,9 +215,9 @@ arm_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
> 	return attrs;
> }
>
> -static u32 arm_cspmu_event_type(const struct perf_event *event)
> +static u64 arm_cspmu_event_type(const struct perf_event *event)
> {
> -	return event->attr.config & ARM_CSPMU_EVENT_MASK;
> +	return event->attr.config;
> }
>
> static bool arm_cspmu_is_cycle_counter_event(const struct perf_event *event)
> @@ -208,6 +225,16 @@ static bool arm_cspmu_is_cycle_counter_event(const struct perf_event *event)
> 	return (event->attr.config == ARM_CSPMU_EVT_CYCLES_DEFAULT);
> }
>
> +static u64 arm_cspmu_filter(const struct perf_event *event)
> +{
> +	return event->attr.config1;
> +}
> +
> +static u64 arm_cspmu_filter2(const struct perf_event *event)
> +{
> +	return event->attr.config2;
> +}
> +
> static ssize_t arm_cspmu_identifier_show(struct device *dev,
> 					 struct device_attribute *attr,
> 					 char *page)
> @@ -417,6 +444,17 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> 		DEFAULT_IMPL_OP(event_attr_is_visible),
> 	};
>
> +	/*
> +	 * With 64-bit events, since our default "cycles" encoding won't work,
> +	 * and the architecture recommends against implementing it anyway, we
> +	 * choose to effectively ignore FEAT_CSPMU_CCNTR, unless a vendor
> +	 * module really wants to provide its own encoding and ops.
> +	 */
> +	if (cspmu->has_ext64) {
> +		cspmu->impl.ops.is_cycle_counter_event = NULL;
> +		cspmu->impl.ops.set_cc_filter = NULL;
> +	}
> +
> 	/* Firmware may override implementer/product ID from PMIIDR */
> 	if (apmt_node && apmt_node->impl_id)
> 		cspmu->impl.pmiidr = apmt_node->impl_id;
> @@ -518,19 +556,24 @@ static int arm_cspmu_alloc_attr_groups(struct arm_cspmu *cspmu)
> 	return 0;
> }
>
> +static inline int arm_cspmu_pmcr(struct arm_cspmu *cspmu)
> +{
> +	return cspmu->has_ext64 ? PMCR_64 : PMCR;
> +}
> +
> static inline void arm_cspmu_reset_counters(struct arm_cspmu *cspmu)
> {
> -	writel(PMCR_C | PMCR_P, cspmu->base0 + PMCR);
> +	writel(PMCR_C | PMCR_P, cspmu->base0 + arm_cspmu_pmcr(cspmu));
> }
>
> static inline void arm_cspmu_start_counters(struct arm_cspmu *cspmu)
> {
> -	writel(PMCR_E, cspmu->base0 + PMCR);
> +	writel(PMCR_E, cspmu->base0 + arm_cspmu_pmcr(cspmu));
> }
>
> static inline void arm_cspmu_stop_counters(struct arm_cspmu *cspmu)
> {
> -	writel(0, cspmu->base0 + PMCR);
> +	writel(0, cspmu->base0 + arm_cspmu_pmcr(cspmu));
> }
>
> static void arm_cspmu_enable(struct pmu *pmu)
> @@ -561,7 +604,8 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
> 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>
> 	if (supports_cycle_counter(cspmu)) {
> -		if (cspmu->impl.ops.is_cycle_counter_event(event)) {
> +		if (cspmu->impl.ops.is_cycle_counter_event &&
> +		    cspmu->impl.ops.is_cycle_counter_event(event)) {
> 			/* Search for available cycle counter. */
> 			if (test_and_set_bit(cspmu->cycle_counter_logical_idx,
> 					     hw_events->used_ctrs))
> @@ -804,26 +848,33 @@ static void arm_cspmu_event_update(struct perf_event *event)
> static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
> 					struct hw_perf_event *hwc)
> {
> -	u32 offset = PMEVTYPER + (4 * hwc->idx);
> -
> -	writel(hwc->config, cspmu->base0 + offset);
> +	if (cspmu->has_ext64)
> +		writeq(hwc->config, cspmu->base0 + PMEVTYPER + (8 * hwc->idx));
> +	else
> +		writel(hwc->config, cspmu->base0 + PMEVTYPER + (4 * hwc->idx));
> }
>
> static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> 				    const struct perf_event *event)
> {
> -	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> -	u32 filter2 = event->attr.config2 & ARM_CSPMU_FILTER_MASK;
> -	u32 offset = 4 * event->hw.idx;
> +	u64 filter = arm_cspmu_filter(event);
> +	u64 filter2 = arm_cspmu_filter2(event);
> +	int n = event->hw.idx;
>
> -	writel(filter, cspmu->base0 + PMEVFILTR + offset);
> -	writel(filter2, cspmu->base0 + PMEVFILT2R + offset);
> +	if (cspmu->has_ext64) {
> +		writeq(filter, cspmu->base0 + PMEVFILTR + (8 * n));
> +		writeq(filter2, cspmu->base0 + PMEVFILT2R + (8 * n));
> +	} else {
> +		writel(filter, cspmu->base0 + PMEVFILTR + (4 * n));
> +		writel(filter2, cspmu->base0 + PMEVFILT2R + (4 * n));
> +	}
> }
>
> +/* Note we deliberately don't expect 64-bit filters here; see init_impl_ops */
> static void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> 				    const struct perf_event *event)
> {
> -	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> +	u32 filter = arm_cspmu_filter(event);
>
> 	writel(filter, cspmu->base0 + PMCCFILTR);
> }
> @@ -976,6 +1027,30 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu)
> 		}
> 	}
>
> +	/*
> +	 * We can infer FEAT_CSPMU_EXT64 from PMCNTEN, or hope that anything
> +	 * that failed to get that right has at least implemented the optional
> +	 * PMDEVARCH correctly...
> +	 *
> +	 * Note that architecturally, has_ext64 *should* imply has_atomic_dword,
> +	 * but enough implementations have ignored that already that we'll just
> +	 * have to still rely on the firmware flag.
> +	 */
> +	writel(~0U, cspmu->base0 + PMCNTENCLR);
> +	writel(~0U, cspmu->base0 + PMCNTEN);
> +	if (readl(cspmu->base0 + PMCNTENCLR)) {
> +		cspmu->has_ext64 = true;
> +		writel(0, cspmu->base0 + PMCNTEN);
> +	} else {
> +		u32 reg = readl(cspmu->base0 + PMDEVARCH);
> +
> +		if (reg & ARM_CSPMU_PMDEVARCH_PRESENT) {
> +			reg &= ARM_CSPMU_PMDEVARCH_ARCHPART;
> +			if (reg == 0xaf4 || reg == 0xaf5)
> +				cspmu->has_ext64 = true;
> +		}
> +	}
> +
> 	cspmu->pmcfgr = readl(cspmu->base0 + PMCFGR);
>
> 	cspmu->num_logical_ctrs = FIELD_GET(PMCFGR_N, cspmu->pmcfgr) + 1;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 3fc5c8d77266..c4058d602477 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -35,21 +35,15 @@
> 	PMU_EVENT_ATTR_ID(_name, arm_cspmu_sysfs_event_show, _config)
>
>
> -/* Default event id mask */
> -#define ARM_CSPMU_EVENT_MASK	GENMASK_ULL(63, 0)
> -
> -/* Default filter value mask */
> -#define ARM_CSPMU_FILTER_MASK	GENMASK_ULL(63, 0)
> -
> /* Default event format */
> #define ARM_CSPMU_FORMAT_EVENT_ATTR	\
> -	ARM_CSPMU_FORMAT_ATTR(event, "config:0-32")
> +	PMU_EVENT_ATTR_ID(event, arm_cspmu_default_format_show, 0)
>
> /* Default filter format */
> #define ARM_CSPMU_FORMAT_FILTER_ATTR	\
> -	ARM_CSPMU_FORMAT_ATTR(filter, "config1:0-31")
> +	PMU_EVENT_ATTR_ID(filter, arm_cspmu_default_format_show, 1)
> #define ARM_CSPMU_FORMAT_FILTER2_ATTR	\
> -	ARM_CSPMU_FORMAT_ATTR(filter2, "config2:0-31")
> +	PMU_EVENT_ATTR_ID(filter2, arm_cspmu_default_format_show, 2)
>
> /*
>  * This is the default event number for cycle count, if supported, since the
> @@ -78,6 +72,7 @@
> #define PMEVFILT2R			0x800
> #define PMEVFILTR			0xA00
> #define PMCNTENSET			0xC00
> +#define PMCNTEN				0xC10
> #define PMCNTENCLR			0xC20
> #define PMINTENSET			0xC40
> #define PMINTENCLR			0xC60
> @@ -87,6 +82,8 @@
> #define PMCFGR				0xE00
> #define PMCR				0xE04
> #define PMIIDR				0xE08
> +#define PMCR_64				0xE10
> +#define PMDEVARCH			0xFBC
> #define PMPIDR0				0xFE0
> #define PMPIDR1				0xFE4
> #define PMPIDR2				0xFE8
> @@ -154,6 +151,10 @@
> #define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
> #define ARM_CSPMU_IMPL_ID_AMPERE	0xA16
>
> +/* PMDEVARCH */
> +#define ARM_CSPMU_PMDEVARCH_PRESENT	BIT(20)
> +#define ARM_CSPMU_PMDEVARCH_ARCHPART	GENMASK(11, 0)
> +
> struct arm_cspmu;
>
> /* This tracks the events assigned to each counter in the PMU. */
> @@ -183,7 +184,7 @@ struct arm_cspmu_impl_ops {
> 	/* Check if the event corresponds to cycle count event */
> 	bool (*is_cycle_counter_event)(const struct perf_event *event);
> 	/* Decode event type/id from configs */
> -	u32 (*event_type)(const struct perf_event *event);
> +	u64 (*event_type)(const struct perf_event *event);
> 	/* Set/reset event filters */
> 	void (*set_cc_filter)(struct arm_cspmu *cspmu,
> 			      const struct perf_event *event);
> @@ -234,6 +235,7 @@ struct arm_cspmu {
> 	int irq;
>
> 	bool has_atomic_dword;
> +	bool has_ext64;
> 	u32 pmcfgr;
> 	u32 num_logical_ctrs;
> 	u32 num_set_clr_reg;
> @@ -250,6 +252,9 @@ ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
> 				   struct device_attribute *attr,
> 				   char *buf);
>
> +ssize_t arm_cspmu_default_format_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf);
> +
> /* Register vendor backend. */
> int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
>
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index bac83e424d6d..a4c1ab886709 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -762,7 +762,7 @@ static void pcie_tgt_pmu_reset_ev_filter(struct arm_cspmu *cspmu,
> 	pcie_tgt_pmu_config_addr_filter(cspmu, false, base, mask, idx);
> }
>
> -static u32 pcie_tgt_pmu_event_type(const struct perf_event *event)
> +static u64 pcie_tgt_pmu_event_type(const struct perf_event *event)
> {
> 	return event->attr.config & NV_PCIE_TGT_EV_TYPE_MASK;
> }
> -- 
> 2.54.0.dirty
>
>
