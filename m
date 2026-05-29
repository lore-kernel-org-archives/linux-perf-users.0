Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1F3AFCED;
	Fri, 29 May 2026 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046811; cv=fail; b=CfanDja/V3+XB/htDbW6fw2k/90uFqlzMBIF7ImshGB1NQrg+Tni4jSBOwbV4PyCUAFxVWdi4JEYGb4hdp8R1OsatSSwNmQmQy2Yrhpdj2Ft1ra7Enboyj8D6OPTHt52FELYpNqmLcv5DmTvuoIKHL3TkZ4sCFYYUVI+5iV5zio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046811; c=relaxed/simple;
	bh=DH8xadVPgPU5S32B1BmYMS6+myW1QezBv9XnzW3CbPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gxvB+zvjS8xDyNpIGBEuDb6ryk8d7LKIx3mCbikRjZs7llJruzU+2B2vRUnXc2RoPI2LVADdz7mLcjt9LohAAcFboOCHyh4BVp0VVwKt29FYit3ypL6t5p3KJgTO3Nc1Da3evB1xCMhd8R2vXv1pum3lrBC067ZXS34+zvdc7as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OfxRDizp; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OfxRDizp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwszByb8ZtR11oNlSUKU9D55ew05UlHCWBwTea+oO7/+r4tPtwS7A4i1Qpt5w+J8zX0yPOGYmTnzm8cV5Oh47rw19T54gsjWZk12JDOAcAi5uH++CmJ87sUB0RAZq/AVZv/76p2oLJ4pFz9PbsLev66Oe0vC07VrJnr+FWBSw0X4iEkQw3Ay0Uz0OV7SJmmbJZqjnIErKxJGpuCWKs8St3tLa0OVtil7IxUqlISb5HTS+sWvhEtlwAR+kF7C9fT1eFHoXj1Ts2eSVMad3J2x7hzr0VYIdRhce4952mHDFt8eHGPo7hzNOT3v/IO2dnDq7wtCDyxd7UhSPulB+mz4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyWm+naG/Rfk81BoTQVSeuhO/WWCONuJ9EtfKLp46NE=;
 b=Jqe/RMeXC00WgEBNlXHF55/zaNBKZrg0HG5zQDAdW2+aB/yGzn6HYfjdds4slLkRvxK8k9O/WnUkJP3QJL2wUcw2KbwNoiMbjclarukaGUoO9JW0EinNMsAV3XA9RW5ufgERCuflHtJ/g90wSRgMFw84DllIP80og12KFvPnX0hs/NVrXf0h7cB2KIQbUVS5rvsO9Rft2HT09/PdK0lPfAguTbZmA+73cjgYn+n6+UKlKMiPjKtAuqBbrq6Ypivshrf3eXE9qJC/MUFmy5ztB7bEqhceVPuL2K+q7Cq24q53sOKP7nSNEGFGY+LtbqkkZC6Nf9NFgTdc7RhDjr/HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyWm+naG/Rfk81BoTQVSeuhO/WWCONuJ9EtfKLp46NE=;
 b=OfxRDizpfBn4Q/2vOqerDy2dzEmoBbsw8NSNmiAm0JDQ/wHaVjChHU6Aq6QoqcE9OORqMnRPdiCubZnqLsl2y79XIsaR9r+xxPieKU6KhX8hzHRXtsre7lqm+7/YlvU2BvKkB+FUz2Hu3sp5dpGtnxk40gvrK+5R1ohDWn7HbhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 09:26:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 09:26:46 +0000
Message-ID: <300855bd-c4fd-4915-8a93-8671377493b3@amd.com>
Date: Fri, 29 May 2026 14:56:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf jevents: Add IOMMU metrics for AMD
To: Chun-Tse Shao <ctshao@google.com>, Perry Taylor <perry.taylor@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528234455.434027-1-ctshao@google.com>
 <20260528234455.434027-2-ctshao@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260528234455.434027-2-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: d94b333c-143b-4a76-6c12-08debd646764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HmiPQpHWlLns7dgQqt6BtiuVfwuPzpy5h2qVa3+gIQdvK9NjJ+GNo8GvLjy33HcxJLGFB/hyrYGR7m4p6Bx2p9D8zV2wi8+T7fZk1xUuv2TsmJHxWGNzBl9zH9npnkQuDoUW7EHtqbvWgz3DN7dxm+quWfPV3lxHfLgVwUF8Ezd9C0Xx1gSQt4dkH7t11XkueOpNKit9CDeTHXj7G13LT5Qrqq7cZv4+nV6dX6tHXLeBQNLYgLRqLB0gQvlu3kU7IE+IMp2vjEwIpXpgJW42Qejgg1wmQuMj02/JBWeWJQwGV/SahVBvMyq33hB2aFKVCs7k5bv6jdJ1BJxM4yHdcyxxQJjy2pwZ0xoyRUK0nr610XZzpGOMQ2qMhAro8xwhihkzj3sFmnJ7bXsZQNP7Z4HMwLMr2m69t7zbff9BBlNWzA2ph1UrI2mCl9q5TyGscBDP0MA31IQumWexPQhPsh7OLPsb72sZpY8dcQdHXnMTLadajYyLK5IVHU9RcBOaArRHGv6XbIlJZ2fVeukYQTIMNc7dj1Vbqbftk9EW7HZxRLt3JhA/p0kGpdtzz8y9ahdvz9Jd7FkW6XnN01EO5RD9L4XRm8Shf3QZYRx42ww8wsnoGgyiAeRNQZ88bXQOfftIVDnHoJv3uuce8ixHWlsZeBFuebbpCeCUeyb9Ucs8rWj4ETL/795Wqf1tcDng
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djdIc3FzYXJVR21VeXdaaE5jNWVLZEsvNVdFWG9jN0UxNC9sV1pvQ0hjaHpq?=
 =?utf-8?B?c05YUFEzUSt6NkVtYUIvQk13K204aHVUZWZ0OUk3OENpMWJ3TVowaHVWbXN0?=
 =?utf-8?B?WU14ZCtEbXRmTlVwc0tmT3VwcFdaU28xbzlxKzk4NCs3Y2lPcjlqc2pTbTg5?=
 =?utf-8?B?R25WNGV4QTJxUUl4akF3UENXOTFGaC9BTFhjaFRNMStGUXNxa0Vqd3NQNTRF?=
 =?utf-8?B?STVEOWVPUVBWSk9CN3VvcFRhS1FSdU12bDVJakEvOFJQRStPVlVaaEJGWmMw?=
 =?utf-8?B?L3lxVkhXdUV4TFF2YXZzdzdwVkRmME1PRGl4dVBIcUZKdy9LaEJkaENRcTRU?=
 =?utf-8?B?M3d0VDhadjVjb3ZmM0hwR0lTekN0ZHRyK2thUmdXTmtrL3Y1QkVIUHV2MWVO?=
 =?utf-8?B?TXVnWkFjQjNjMWpBT2tYdnpWYXdXWk9VMGxYVlhaZnJMajJQVC93Q2NFY25s?=
 =?utf-8?B?WjFZVmJmdng4QmdTbzlicXcwWU1vTCsrUzdKT2NaRnYxMGkwM25GeGErc2xR?=
 =?utf-8?B?a3RaaGdnRm1kVzV6ZVZUOTlDSEZPWWRxMEtYOVEvMmF1MExwRkVudG9aR0l3?=
 =?utf-8?B?aTJaYmg0bTR4cHR3U1BOcG1QanJhL3BsSmVZcVFLcG12MFNsWG9IU2RVaWRl?=
 =?utf-8?B?bXM0QXErbWRFUUZtUFhVOUxkTThzZkprL042c1dGQXV6ZjF4YWt2UjZXNzRr?=
 =?utf-8?B?a0Jzc1JZTm96THU3QWtvZmpzMTR3M25ISERiMVJnMkhhZk4vNzZNU0Z5M3dp?=
 =?utf-8?B?N01iOGpwdENCUzZ3Yis2TjFKRjRFd2RJcFV3VmJld09LZGNjMEdlSTRhZ0Zk?=
 =?utf-8?B?anJYOU9OMkNmKzQ3eDFOQUEvR2dqTllHK0luTkEyU2MxS0pzOUJVeVZmTTd1?=
 =?utf-8?B?bG5rdVA3RnJodU1aTTdNM0tRblJobHdpeEcxUC9VQjB2RVcxNysycnpCOWF1?=
 =?utf-8?B?OTRPQnNXeWllTWd0dlFvdEZRZ1FHY2IwbDdmNFdhN1VpcHpjdEc4aTBEVFFM?=
 =?utf-8?B?M0ZXOFowdXFJb2hQaGlvdFZUMEIydUJXcnRRWmtQLzRVV2swUTdNT1RSYVJS?=
 =?utf-8?B?SkxHQ004K1AxcDR0cVhhN1g1M0M2N3Z1blBPNWFCRFE2cE1qNlp5eVdaNzlC?=
 =?utf-8?B?cXphVGM2YlRDcWpRWjRTMk80N2VQS1pjbWZPZWcweXJRcVMrUXZvVFlqSzhP?=
 =?utf-8?B?WGMzQW1rV3VRN0lhcDl2RS9hYVZhL2hjT04za0xxUnNQWk05bGpoWUJwT0Y1?=
 =?utf-8?B?QUlubitCblJhMjFMLzJyeHFZeUY1YXJ0UTNjbVZPaDhhL3RLd2k3R1NoQWNa?=
 =?utf-8?B?bXJ0bUZOUzZVNGF0YmRsNnZkWGgzc0xDbFZnZ21PYkR5M3NpeTNFL0lQVHJU?=
 =?utf-8?B?amI0THRaemFvdllLZEZnS2hwRWxGeTJ6RVI1R01GWWRpRTRWeTBZOTJQSnpY?=
 =?utf-8?B?T25ZaWFMdGwydXBrWXJyNlcyTVF3SlZ6R0ZORmxpK05uc1RmMWxuNnAxdmxP?=
 =?utf-8?B?UVBtODBmV2ZPWk03cEF4Y0RhcHpSbVNIT3BRb0djSTA4a1A3c2FLK0tjWjkx?=
 =?utf-8?B?ZTFvRWdXbXVOeVNxN2dQdjFDZnZsS1FJODBJdHRLWXBPVFBvdUhRVUFmLzd3?=
 =?utf-8?B?M0NtZjhHUWh0RGRnOWFSVFZmdHlkUzBGSjlURWtZWWNEMkRmSEJiaFU3SGIx?=
 =?utf-8?B?WVZLcVYyU0xtOHE2clVVSzlZL044TTNUaXI2Z0VjOUljUW9QYWJSU3UyaU5U?=
 =?utf-8?B?U2NxK3g5azdLYUpSOXA1b3NVdjI3dnhSS241N2o2UXFyS2ZuMW9QTUdjRW8x?=
 =?utf-8?B?dnQ2djJISUxSTWF4Rk9IY3d4M00xY2wzajdmVWlrLzRUR3ZicWtVb0FEb3ZD?=
 =?utf-8?B?QmEvTGZFaVVQSE9vOFFZZ0IrMXlGRERibW1xd09MbWFyaGE5UWZ0TU1nSlE1?=
 =?utf-8?B?OUgrall3ZjVMVzVKVTMrRWw3cllCSjlML0lKNlVhVFEvTFRQNGhYbWRBQVVt?=
 =?utf-8?B?RTdwUDdzY3B0YVlUOTJIR0ZkTDdGQ3N2Mmc2YUY3QTBSVmZrUkYrTWZnYUZS?=
 =?utf-8?B?VE9nMzZGRDJraHNlSzFZRGdGKzRaVGFLcDZIOWVGeFVrcnFORCtGbzd6bWEy?=
 =?utf-8?B?N1oyWlZhdWt3UVVQN1k3UTl6R1VJandIRW5DUmFQendhWCt3anJvNjJFSFk3?=
 =?utf-8?B?aytvR0NYQ0wvTEN6U0ROYkcvSHh5eHFTNmdMS09TVTd0ZkdBZVVxR2FzcFJ2?=
 =?utf-8?B?aE9vQy9sdyt2MDREVDZqaW9peDIrK0ZkdkYwK05KVHFFa3hFNjdGMEc1TFNU?=
 =?utf-8?B?eUN5eWlrZzFYQTZPVktPMGNEWm5SNmkwR1Ezd2lqM2dyWlVzOWZTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94b333c-143b-4a76-6c12-08debd646764
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:26:46.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz3Lmy8nKU6L6nobNj8bqo1Jn/4Qoi0Rh+pcOJX73/NGM1dw4VEbsY8HXn/W9BpqsdpM64pVIs/WROc1T7F+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

On 29-05-2026 05:14, Chun-Tse Shao wrote:
> Add IOMMU Translation Lookaside Buffer (TLB) and interrupt cache metrics
> to perf jevents for AMD platforms. This enhances I/O performance
> observability, allowing fleet-wide monitoring of IOMMU overhead.
> 
> These metrics are supported on Zen 2 and newer processors (Rome, Milan,
> Genoa, Turin) and are implemented using the standard `amd_iommu` PMU
> events. The implementation uses the existing `_zen_model` helper to
> ensure these are only generated for Zen 2+. Note that the pde events on
> AMD cover both 2M and 1G pages, so 1G pages are implicitly included in
> the total hits/misses metrics (sum of pte and pde events).
> 
> The following metrics are added:
> - iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
> - iotlb_total_miss: Total IOTLB misses.
> - iotlb_miss_rate: IOTLB miss rate.
> - iotlb_interrupt_cache_hit: Interrupt cache hits.
> - iotlb_interrupt_cache_miss: Interrupt cache misses.
> - iotlb_interrupt_cache_lookup: Interrupt cache lookups.
> - iotlb_interrupt_cache_miss_rate: Interrupt cache miss rate.
> 
> Tested:
>   # perf stat -M \
>     iotlb_total_hit,iotlb_total_miss,iotlb_miss_rate \
>     --per-socket --metric-only -a -j -- sleep 10
>   {"socket" : "S0", "counters" : 10,
>    "hits  iotlb_total_hit" : "3579249.0",
>    "%  iotlb_miss_rate" : "0.0",
>    "misses  iotlb_total_miss" : "3.0"}
>   {"socket" : "S1", "counters" : 10,
>    "hits  iotlb_total_hit" : "0.0",
>    "%  iotlb_miss_rate" : "0.0",
>    "misses  iotlb_total_miss" : "0.0"}
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> ---

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

>  tools/perf/pmu-events/amd_metrics.py | 57 ++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 971f6e7af1f8..dccfcacaf148 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -265,6 +265,62 @@ def AmdDtlb() -> Optional[MetricGroup]:
>      ], description="Data TLB metrics")
>  
>  
> +def AmdIotlb() -> Optional[MetricGroup]:
> +    global _zen_model
> +    if _zen_model < 2:
> +        return None
> +
> +    # On AMD, the pde events cover both 2M and 1G pages.
> +    total_hit = Event("amd_iommu/mem_iommu_tlb_pte_hit/") + Event(
> +        "amd_iommu/mem_iommu_tlb_pde_hit/"
> +    )
> +    total_miss = Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
> +        "amd_iommu/mem_iommu_tlb_pde_mis/"
> +    )
> +    miss_rate = d_ratio(total_miss, total_miss + total_hit)
> +
> +    interrupt_cache_hit = Event("amd_iommu/int_dte_hit/")
> +    interrupt_cache_miss = Event("amd_iommu/int_dte_mis/")
> +    interrupt_cache_lookup = interrupt_cache_hit + interrupt_cache_miss
> +    interrupt_cache_miss_rate = d_ratio(
> +        interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
> +    )
> +
> +    return MetricGroup(
> +        "iotlb",
> +        [
> +            Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"),
> +            Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "misses"),
> +            Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"),
> +            Metric(
> +                "iotlb_interrupt_cache_hit",
> +                "IOTLB interrupt cache hit",
> +                interrupt_cache_hit,
> +                "hits",
> +            ),
> +            Metric(
> +                "iotlb_interrupt_cache_miss",
> +                "IOTLB interrupt cache miss",
> +                interrupt_cache_miss,
> +                "misses",
> +            ),
> +            Metric(
> +                "iotlb_interrupt_cache_lookup",
> +                "IOTLB interrupt cache lookup",
> +                interrupt_cache_lookup,
> +                "lookups",
> +            ),
> +            Metric(
> +                "iotlb_interrupt_cache_miss_rate",
> +                "IOTLB interrupt cache miss rate",
> +                interrupt_cache_miss_rate,
> +                "100%",
> +            ),
> +        ],
> +        description="IOMMU TLB metrics",
> +    )
> +
> +
>  def AmdItlb():
>      global _zen_model
>      l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
> @@ -473,6 +529,7 @@ def main() -> None:
>          AmdBr(),
>          AmdCtxSw(),
>          AmdDtlb(),
> +        AmdIotlb(),
>          AmdItlb(),
>          AmdLdSt(),
>          AmdUpc(),

