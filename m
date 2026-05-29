Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26207329E79;
	Fri, 29 May 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037911; cv=fail; b=R6tEWyhpzo/Mm+t/r5xIiSlOk0akafLMRXVeBLKOV64N6fBkJz8J91DMemCvy1VYnkrILJObsJoilGiG3NSatsZdF8WpYeh+Ufoz63YHitBBEimN9nyU1E53/vfeb9FBwLswhq38lcbYOXMt2f1+JjtSGUHPJwbg5ITziMT9QxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037911; c=relaxed/simple;
	bh=9b1mhTJaeQJ/c/3KiAhjJvUw4gzxqQO1StwsfSJ64N8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tnthv0qxIBA7hvKti8/jNejoi8yOccIukYWc6qQ9N2WXgW8hDCvpUHiTT2Xfl0kyCRuDQEHMnLiUQ8xLeEczTUkMt3br+NFyo6FH9lifHEAsuHNgpQruBDV2B2nlo/Y/F8Fj/v1OQAujKBdVV2zlwX1SclCbTmHqMUb60/LWgi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOzVxmkv; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOzVxmkv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHR6eBmljza3TOkJ9VbSAsbw171bu6TRRxmfkbvScem7OMUsEZbaZYb+Goxxanm2GmtENfBkhWHLR0hLam0+hycojKCztGi/STKooYVTXCT67tuDtxE3TMZ5LbsGIhDZyukOpKQetu/+VjXblF/OzGDKJs+EQ9zQDXaybiopuZpluSEyJ0Om/SqNIJnqzI9u4YlM2qyRoAPb8OhDYIncY3XNnDxxWOxWAoX4P6iuGSCUR9NNfHYeqvHzuJtzY85DyJbSx39PtyDygBuh06vm848FvnKunT7aYaiVru5LkHgPeviwuIazBhA6x0KAPTsGZv6XAojHZvbVYU/mfQH5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hceykVTF24S+tp4LnQ802kCg/ubOWtfLAhTLuHGhw4=;
 b=GX8SRUTKnL4Ks1PuTpHb+oDLtaArAG+30a1K53taVbnKBrLq/kHJTOa7e+YvkUqqSuxE6o8M54ndhJj9CQO/fa+DyZ/JdyQj0IwewFUiFPCABoJ9rhTSWo0gHGkz8XM0phZlxg67FBAGd3RAD+nW7ZRukDMb1Ifd8nNs1LFW0HqleiCHeMNs2xuAJYXlAgNUjX8Ngr1Q3AqMdwruSxAGaGPkF+INq0SL8j3hpHdYEsFwDREY14Gdl3TMbxUDZ0szTtdzaBVrt9bIo4/AKp3mCtRaBy1MZNY1FXYnknClYTP0sRKSsD71+eg2wZnbEx9FcZ53cOH/pYG7mF8apw4Nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hceykVTF24S+tp4LnQ802kCg/ubOWtfLAhTLuHGhw4=;
 b=uOzVxmkvWa/EPD1Nee4pqSqY8F8suKoBEy4pejMuE9c7FnleofEy0RDcQ32zvNaks+4Kx46k0gqf8KVjJEACR+7k933GK8qW3tV/fY/1hz4/bnE9u1mi94qU1VaehnRziOaFe9drTPJwyHZwEeB9yFZ6ZCIiHQpnwPGk2wfDmL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:58:22 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 06:58:22 +0000
Message-ID: <09786a38-54e3-4b08-9210-7c7c6bc80f9c@amd.com>
Date: Fri, 29 May 2026 12:28:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
To: Vasant Hegde <vasant.hegde@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@kernel.org,
 bp@alien8.de, hpa@zytor.com, iommu@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com
References: <20260517114026.6817-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260517114026.6817-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 716fd37c-acbf-4268-f6aa-08debd4fab9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|921020|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sgHqJOOOZMwGeOg9QzyQvzbjkQ+ip50ZU6mJDbrBlLxJVhP3LRCCCiDHPVp/keZa7QxdZaYtkRLQNomnf2LOBUN5GJQcQI+81OXwCO/lxyseRKPWYliZYK50xnYIDzTHzdsSwwDgfMWRucRR3IFh6+PR79W8k/My0Ai51SfIUdkHTMNTupiJQns7exSSFeq/uNw7Vv1GrTZ8ryge6njo0u4a7JjkxToz5VfefpkVmm7/RYhqjaIq3s/xxWdMWTQrQIk0nHomO8RxvYuv5bf45046dR88MqtNkf4JjIl8AKljzV6iAOo7MeG0a2dtmPHpzg+1QrYvOvL0JV6ouPqZ5AgwF2cpeJU2RLDQULPyGuy/xbdRu8/tX0kq1UeZFs9Z3veuknBbPDYaIXFPlYAg0ItNUdzE7AE1hUSvhXvE8yH9KDfRwJY7WffGa3Yny1KSgY2TMnj1NAPvy8FLTDK4Ex8W8kGVr/0Fyfshvckd8lsY/G0mmJWix1p1Eq5E7ykb5lvQc2wj7tbC7xzvUvBM3bZIQkZ8+YwuaO765bPJ3woKAWf4gw7XHjXS1DTRImVod1QAEFDvQQeyEa/hdbXiNB84cXjPyQJUcTr3hoKe++BZODykN1RiaaIaz+NS9t7MogUX0czFbHenLuipBBNEw1AvpFrs2pSF5QSchVnScaYnNiKdCfj4YZ8bk3N8kEDebkAG3lUbsFD0m6HTNws0AFXXVTbsNeHCMZ8t+BfZD9tlred/gqiW3H6ZVzb8By91
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(921020)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnM1TjRNRDkvQ015T3Q0QUdtc0hTRnJYQ3JpUEFsZC8xL2ZiQ0tVWjcxZDBh?=
 =?utf-8?B?dWl1WW9RNTRpWEx5ZVRKd3Mxc1ZFYW9MUHg3OTZIQkQxcndueHYzby9UcEIr?=
 =?utf-8?B?NjdpNHJlUmtmUloxcnRiMkNKNzQyK3RjUVBkZ1FKRmlCdWFiWG05Vk1UMU95?=
 =?utf-8?B?QTMyU0NWRWZjTFpKYUZ2VWM5VHExY2tPdXRKaVZUUUVUK1lESlRodUxjSExC?=
 =?utf-8?B?TEhEVWR2K0hrTmhqQVdWVkRYQ015R1pkaDRFRjlqQmlvVmo0azlTZGpMNU00?=
 =?utf-8?B?T0xvL3ZYNUtXNGlyYzNOMFdyMjU4RjN1UHZnOURqSmFJTjdoL2JTVEhVdG1m?=
 =?utf-8?B?SG1PZE0xUVZDNzNXSWF0Rm5QZlgzdmJQdmFGOWFyQ1RIcW5DNjZrZzdkNnZE?=
 =?utf-8?B?YnErS0cwYU1DUnhCNUN0bTkwTTluU1BYWEplV2VQVWV5WGp2bmc4QTNZU1Uy?=
 =?utf-8?B?ZFdudHdCZnNMRnFkdVIrSzhVeEpnVlZVek9wMUJmc3JtTjFOdmlOZ2x1NmRk?=
 =?utf-8?B?VjE4VitSeUdQV3E3SlVrMHBjZkdIRHpxWENhOWdiZTRlK2ZFTmZNZjB2aGZV?=
 =?utf-8?B?VTVHZTVibFpQS3ljalRQaWE5TnlPUDNnbUxUK3BzWlRmUEJNQklnZGI5RENi?=
 =?utf-8?B?U0pJMlk3KzZVNUpIMCtNNi80T25Fb003Y25yQlRXc1N5dGJzQVEwdTRnMGVz?=
 =?utf-8?B?UE4xKzUvb0hRc21aTW9LK2tFL2RDb3FjRWc1cmRXOEZqcDdvSjJ4aGR6LzZ5?=
 =?utf-8?B?bnBHb3YxRmZPbTUxelVaaC92RVFZbmVmU3lyK3BuQVRDb0hFTXBsUzdwWEx0?=
 =?utf-8?B?R3kxNWNSOXlLcDkrQWQ5L1VkTTNhT1F0VFNDZDlrQ0pGcHJlSVM5UW1aaFBz?=
 =?utf-8?B?U2xwUTlNdUp3T2dIMGVpZHEzcDd0bFVZVHMweDVpL2tka3lvZE1jYnZLNHUv?=
 =?utf-8?B?c0s1ZTgzK3QxRVk3QU8wVC9IVksrY2piL0xJLzNmVld2dmJtdTBHa0M0TnF2?=
 =?utf-8?B?Y3pGcklYb0M4MzAyMStlaXJsM3NnL3FkVytiWnY3NlBpRFEraGdWTW9LM09l?=
 =?utf-8?B?MldFNlJudnFBRmN5dWVvbVY2TDE0OGlyNUtQUGpHekRvcmFrRUxpcldPL25t?=
 =?utf-8?B?WnQyUk9Ebk8zOXM2N05nb1BKYUxJYTJwdnB2bTloNE95NjdvWTJFVk94dTBo?=
 =?utf-8?B?UnZBT1o0Qk1WMERsdTV0TUhDNFd2blZUUTJocDI5SC9hUW1GWVRMalU4angv?=
 =?utf-8?B?S0ExeDdVc0JYYTJNQm81dG9VQmlJL01GcUtGUEkzb2VTL1pNZ0FyeGNlb1lT?=
 =?utf-8?B?MThXb2oyS0k1NzJpaHhNN0k5R3VLQ0tGYi9KVUFOMWdJQWl4Z2tpcWJyVm4y?=
 =?utf-8?B?d3Bpa2RUbG45QlI1Z1dwRWVsSU5wYjNNY2FmWDRUeUc4dTIrWGcwOFZIbm95?=
 =?utf-8?B?dkJwa1ovTVh1Umt5WGZFOXNKVXVlR1d1cGdMR0hkV2gxVkxlZzlYc0JERk5J?=
 =?utf-8?B?TFlObmI1ckpkdXlUM1EvTHExUWcxU2VKRzQvUWVTZzRjZXhuN1ovd2Q4UFNt?=
 =?utf-8?B?OWFXMEEramM2MEFEUUhucm0yOEoxbExiR3RLcDAwVjlZbUVxSktiSW1vT01k?=
 =?utf-8?B?MXM5MUVmS1NGaGVZN3UybU1DNDNLbnY3UEt0TWJzc204eHRxNHFyRVg1ZUNv?=
 =?utf-8?B?ckdTUlBBeVZzZmFyQzRNRE5lNXVFa3BSd0dsUWZTNGpiWlMzUEFhRXJhWDRD?=
 =?utf-8?B?dFN1dmdxQ1NhVVFIS1MyMmdnU1haL05ZWG9sTXlucW1ocjlmMkZ4VDFzZjNx?=
 =?utf-8?B?RElWaTRuUlIrdklNdG1wWDhIYTk3Z0JHWitqaEpyMk1wOVQxNlJXYUZTdE50?=
 =?utf-8?B?RFJlcUgybmNEdFF1NWtETzRZa2Q2bXZTRmNtTFpaeEwxcGtpZkozVGRoNHlW?=
 =?utf-8?B?UE1hY2FSVWpDSWN6UkJ6QTEwUnJ5bTZ0QlJIRXJiNjV5MFNEOTBBT0lPSjdw?=
 =?utf-8?B?TElYcUl4TnV0TmFjbUJ5OWJpRnVSVHprUG5qcU9wWWkwVE1aVUd0KytoZkxj?=
 =?utf-8?B?aSsvTERDdXd3ZmxlQmtJbWRlcjN4alBFUG15cjJhckVZd3VSbGdwZEwvcC8w?=
 =?utf-8?B?cnYvNmdhOVFBSldDcE0wdC95VU55SUlWK3djd0JPcEZxclBLK3d3QUVmRHYx?=
 =?utf-8?B?REgrMTVIanlKRVg4Rm9WbWNrZERTdFllMDh5SXMydzRRUm8yNEducFNnbGZs?=
 =?utf-8?B?TFJWSHcvSzFhTVZMN1p1RFROUkcwcmN6V0VlOXNFU0RiK2ttOXR5RDJXVCsy?=
 =?utf-8?B?cUxaZFRaRnVTb0praVNiWloyMFl3QzdZeWRGMG5yU0d6Q2FNZDdMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716fd37c-acbf-4268-f6aa-08debd4fab9d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:58:21.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Frw1KQFcinwcgDQuvUd7SQ1zp8ShIC+MFgS2IShXXQjgoyvbL93wdGs6zWdnUrVirDTJzLdqh3q++gF7xpU6bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

On 17-05-2026 17:10, Vasant Hegde wrote:
> IOMMU performance counters are accessed via MMIO space. Currently IOMMU
> PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
> IOMMU PMU instances. This prevents collecting per-socket numbers
> (ex: perf stat --per-socket).
> 
> Fix this by adjusting cpumask based on IOMMUs NUMA node.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

> ---
>  arch/x86/events/amd/iommu.c | 29 +++++++++++++++++++++++------
>  drivers/iommu/amd/init.c    |  7 +++++++
>  include/linux/amd-iommu.h   |  1 +
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 07b110e8418a..b1848300028d 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt)	"perf/amd_iommu: " fmt
>  
> +#include <linux/device.h>
>  #include <linux/perf_event.h>
>  #include <linux/init.h>
>  #include <linux/cpumask.h>
> @@ -43,6 +44,7 @@ struct perf_amd_iommu {
>  	u8 max_counters;
>  	u64 cntr_assign_mask;
>  	raw_spinlock_t lock;
> +	cpumask_t cpumask;
>  };
>  
>  static LIST_HEAD(perf_amd_iommu_list);
> @@ -131,13 +133,15 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
>  /*---------------------------------------------
>   * sysfs cpumask attributes
>   *---------------------------------------------*/
> -static cpumask_t iommu_cpumask;
> -
>  static ssize_t _iommu_cpumask_show(struct device *dev,
>  				   struct device_attribute *attr,
>  				   char *buf)
>  {
> -	return cpumap_print_to_pagebuf(true, buf, &iommu_cpumask);
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct perf_amd_iommu *perf_iommu =
> +			container_of(pmu, struct perf_amd_iommu, pmu);
> +
> +	return cpumap_print_to_pagebuf(true, buf, &perf_iommu->cpumask);
>  }
>  static DEVICE_ATTR(cpumask, S_IRUGO, _iommu_cpumask_show, NULL);
>  
> @@ -420,7 +424,8 @@ static const struct pmu iommu_pmu __initconst = {
>  static __init int init_one_iommu(unsigned int idx)
>  {
>  	struct perf_amd_iommu *perf_iommu;
> -	int ret;
> +	struct device *dev;
> +	int node, cpu, ret;
>  
>  	perf_iommu = kzalloc_obj(struct perf_amd_iommu);
>  	if (!perf_iommu)
> @@ -440,6 +445,20 @@ static __init int init_one_iommu(unsigned int idx)
>  		return -EINVAL;
>  	}
>  
> +	dev = amd_iommu_idx_to_dev(idx);
> +	node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +	if (node != NUMA_NO_NODE)
> +		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> +	else
> +		cpu = cpumask_any(cpu_online_mask);
> +
> +	if (cpu >= nr_cpu_ids) {
> +		pr_warn("Failed to find online CPU for IOMMU %d.\n", idx);
> +		kfree(perf_iommu);
> +		return -ENODEV;
> +	}
> +	cpumask_set_cpu(cpu, &perf_iommu->cpumask);
> +
>  	snprintf(perf_iommu->name, IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
>  
>  	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
> @@ -483,8 +502,6 @@ static __init int amd_iommu_pc_init(void)
>  		return -ENODEV;
>  	}
>  
> -	/* Init cpumask attributes to only core 0 */
> -	cpumask_set_cpu(0, &iommu_cpumask);
>  	return 0;
>  }
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 3bdb380d23e9..2c35d171b5ae 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3939,6 +3939,13 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
>  	return NULL;
>  }
>  
> +struct device *amd_iommu_idx_to_dev(unsigned int idx)
> +{
> +	struct amd_iommu *iommu = get_amd_iommu(idx);
> +
> +	return iommu ? &iommu->dev->dev : NULL;
> +}
> +
>  /****************************************************************************
>   *
>   * IOMMU EFR Performance Counter support functionality. This code allows
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index edcee9f5335a..6b8d6b53b4e9 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -67,6 +67,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
>  int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
>  		u64 *value);
>  struct amd_iommu *get_amd_iommu(unsigned int idx);
> +struct device *amd_iommu_idx_to_dev(unsigned int idx);
>  
>  #ifdef CONFIG_KVM_AMD_SEV
>  int amd_iommu_snp_disable(void);

