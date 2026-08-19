Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC02264C0;
	Wed, 19 Aug 2026 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787116336; cv=fail; b=q7mQtMZ7pq5U9L2DQZQFJp6tZBtWewU2hkpsV/3S+BALzHzZ6NfX6bOsEDRtARZTRbKzKiI4elIl4SV9raQjrX0epZr1K05pfhNaXZ2occ0ZwgXbknQN3ZZUBst71B+f1HSxyzvEPfoybV4STZl7yEsgActvX7CY3zJbTBuS9go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787116336; c=relaxed/simple;
	bh=R/422OOPlN/NvbmqzBy0Ben94OGZPtt6QLLbQshLM5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jfephQS5R7HtLdmI6hse1FtMbQqg1LFNbgAIL41ptMr54Hx7rVF/f4VWCPuH64vuwKa3G6mFPc6uCduAsW0j+KErpqaAMni78UcG++0lybg1JhbPE5Dgj4765gVpMx51kYOT5SieeIerdlaNJ05d5SpfqIrdmE6Pi/2Ys4w4vQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MbDeyXg1; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MbDeyXg1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHf3zHeg4E0JOMSbDC6HviPfSVZQ5XQtCP4UIGNy3Ihj3ZbmFwWQPOjrCQ95sgeFXnzijGAQND99OGUngwf6H5t8/91IPp1ESe+TRNWS6oORiY4Mm1waSPvB2T2JyldddnjYfjxsHrITDAHqOK0JqHfh8r9MU0NWNhf61UyqU+c65/wNMczR/uE2zrFEUC1nv11N+nzBYhLGqy6CgZvM/7ZK+YQz+1wRCZKup40+34wIeQpWOWSyqN8v+Wd8PmXu1ZuqETuQrr09Oh2vPUFfAUKtbgwAjDljdKNSlkB5YYYFrngGEqM24sFZ8acWfSrsrEGE9PNsDQ9rdywcqLKmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dNmWpePDfuNb01y9iofe57V/jgxmBkgl7ZZHb1GrhQ=;
 b=JYR5D/9nvN9H97h2XKRURKPI2oC1s0zBd5Kr6W+lf6bSaymNX92wM9Z+hB0mZGQLxomTjVpxagZbH42Lyg3zSxDNWzOQBKK0lXc026VD1+jlR2oLqz20FYxpTf8lEuNOPbO7vwdxBJDv9s9W78p6BKy6YCbVKxpH6tlVuJM6ywsxWA8xvSuycwyc2cvPWPT6w9fvvQw7IhS5GBc/Sc4LJdNzP051zgtqwOohCuBZnZ2to9tzg37FBedKZlQO1ax/jb+D024uAk6Vbp3JBMhRKQSAvkM0WSQeoX8f+MQY2Pw+XRJyYQJxMnf0eCojeBcqx+O7cXjbEd4Cg0huEKTmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dNmWpePDfuNb01y9iofe57V/jgxmBkgl7ZZHb1GrhQ=;
 b=MbDeyXg1PWcIx4NBlAACYkH3rQuG2r/cuJ7tYhyG9pgu8FAO1NoGjGVOnwZ/bUP5zPGvQioqnTqe/vWpe2fvdlt6sBDzthveGfZIvo13NmIV5Rc+BLghFkXzB903Vh9ssuOgFhLPpo0AEHbFE7wdM2j6ro4uzdX2IGHOA8VZznA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 05:12:08 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 05:12:08 +0000
Message-ID: <79ff1562-d910-418c-b5b5-92d217cdc568@amd.com>
Date: Wed, 19 Aug 2026 10:41:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] perf vendor events hygon: Add Hygon Data Fabric
 PMU events and metrics
To: Qi Liu <liuqi@hygon.cn>, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 ravi.bangoria@amd.com, irogers@google.com, x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 lijing@hygon.cn
References: <20260818100118.12944-1-liuqi@hygon.cn>
 <20260818100118.12944-3-liuqi@hygon.cn>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260818100118.12944-3-liuqi@hygon.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0293.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::7) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 92612ac0-964e-44f4-2cea-08defdb06969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	dtQSnQc8FrMvUwGtE42OKDpy8OXyNq7hV7U9GScydLzDyjw7rzKVZpkfMIVL1Gr17dvKrTZM6qaRq03PzpL0RcOvdmCJqhsNs//IYJFg/CPe8uPW9bnLJVMxoBcTYWrKIwzKMyHb3lLxtCwK7LTLspgPTejxOHwtoupQ3VWXEKOdlIkIWC/VV6VOfSV6ySVMrZhhEezcZHg7qkhWoqQWn9KMdnsgKzfSPdlI74Ty5Q+vRboOGkhi/kjtFED0glcU6QUkYBtiecvaP28OreKLTtD0mySwXDSNNVXouVGQUU7eUlKFs//sM0GGKWtDHFtaLzXizt8cnx8xEdUVGagt1bkX5LKof/px/yTuVVlnGDDvwy6slfDiL8yksw1iqDTcqQ8zvfOHXnBL+UnOcTa/jYysLQTiGC80KvgKZt/NGghpmUY+HCvYXd8giXn2izhj3zDWKMsCF5jCbMBg3GuVzcsXau4qmwFG1hXA9lLdqJAbebgg7Vdu4ytugSh1u/1EN3gVAJDgDSN0FLCaDfXEWpf3yEgpTvqd9xGHw57+KoSqGd/FHtNb8weKVLgk19W0Tfyx/55DcW96Aw4amjnQq2qW8CCXb6aNwNcYwwlMbwn7jXQ5fQgLA0YTXZBuIMdA8rInguLHGR61DEN5bpV4H3yh71vo8uZSNDxvvc4hBBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTczSFFzTmtzNjBtQkhpVSt6YjFva1FKNytlQ1NiUUh1Wkk1b3dCVHQzbFF4?=
 =?utf-8?B?VlZVaGIzSGYvb1NwbmRGQ3NjUTZhbjdEdTVjRDZ1ekd5eGZaUURxeHd4Qkhr?=
 =?utf-8?B?b3FqNTVvN0RIeVBmVkFQeW1HSWxxMnBsSGVKbnhZa0RCM29zbXJVMGU4K1B1?=
 =?utf-8?B?M3BBeElYWFRsV2UrdGpuMXU4b3NXU1NKT09Fc3FEcWYxMDhiNkthWk55TDdp?=
 =?utf-8?B?ZW9ST1JtOGlDL3gvMlhwakNSUVptM2hGdjl4R1FvK2RoWGNhZTlyWTR5NXFY?=
 =?utf-8?B?cGUxNmtYd0lua0NJcDhablhWSmFSS01tZC93K2dlcytQL2lEZVg0Z25tTzNR?=
 =?utf-8?B?cUxaOXhGb1hYTWg3ek1jRWM1OTlCZCtFMlRvckxuMWtvajcvdFYySXBGZXht?=
 =?utf-8?B?Z3lLdVZEVnB2dkRBeDdZMzVVS1JpZ242YnN1bGc3amlWMG5zdnpSZHNkbkJz?=
 =?utf-8?B?OFJpSUZwWjY0cW9EbzRnNk5qTzFPN2RSd0RsOVVPaTRTRTZQTzRodmc2OUNu?=
 =?utf-8?B?Rlo1clc0MzNkZTFFVEhRVlA0aktEOG1TNXJBZFVYNXNWaDE1amFOblJwWmo4?=
 =?utf-8?B?R2hLUW5PczNpdHlvckpUbHhRbk5Sc2xjUFNMbjNwVWh5eC92NHZwTnVOUStM?=
 =?utf-8?B?d0VDcUVLZkxIejN4TzJudGNEK3JJQVBoTm5jZTlhQ015bzVURThHRVJMUito?=
 =?utf-8?B?clNLekVDYTJSdGR3THhFQ3dXYUt1UjhZSTRweDRNWmxuWnp0QUVUb1EycThv?=
 =?utf-8?B?bGN1cEVMeVp4NWxlcVdaMTI3YVI3ejdYMkNxU2tOSk1vVVhEa2ZIQW5hS3Y3?=
 =?utf-8?B?aVYyZTdzMTBabmJ3R1JLYkhheWdFM1FhcEYrTlAzTWVNWCtsdnFtNUgzT0lO?=
 =?utf-8?B?VXcrZXBpQjZJVFMxeVJOYkY3TW1ZRWU5WnlSU083cTBPcDBXREtjdE5BUW1X?=
 =?utf-8?B?QnU4TEFkZXZ3RGNJZVk2eUxGRk1iSHJJcHF4K3ViNkdPajI4VEpxamNNY3Q0?=
 =?utf-8?B?ZjV4bTJxYm1jOG9wYUdqOVRjcGdRbkpiK1U5MUpoVm0rc056MUZTYUVoZHdl?=
 =?utf-8?B?Q1JSRXZPd1ZPQm1XU0czWFZpLzZYaWJLZm9zZHNTdWRZQzN3UVBIdW9yREY0?=
 =?utf-8?B?ZE5naTNIOUwwVVdPNVFhUFpGNENmT0JwSmJpcWhyaDJrSjV3dDJJb3Z5LzNo?=
 =?utf-8?B?SC9xcThXcHg2QzNIQ0dPampoeUozQjlJak9WcExMUFFOUFBRM1dNZVdxNk5P?=
 =?utf-8?B?aW9NajR2djFXRTAvdkVNZW1jbUJmY1FIdnByQkp0b2Y0UHB1dmpmOHVxWk5r?=
 =?utf-8?B?K1ZpWDRvRS85SDA0Szk1LyticXZQVzA1OFovdjdkQVFzZUxNSlZWZFJDUWgz?=
 =?utf-8?B?UUNrUEdleFQ5SEhYMFNrZFljODJYczV0dE85RXdZVU03RmpkUlh6L2h4ajFx?=
 =?utf-8?B?WTNOcGN5RVNabTlIajlPL2IwVmNwV0g4Z3FPS1ViYmJIQ2J6TmJzNVlKemhE?=
 =?utf-8?B?ZmNyTDFEaGVNa3BtdEdDelltNGI2bXRUL3lGTnJ1MElieDh1bGxKNWRDakFZ?=
 =?utf-8?B?V0MvaktKN1FlQnJpTWthKzV2ek1Na2h5dnhOZmU4eDh4bHZxZExqSmdDRTgy?=
 =?utf-8?B?dnJzNm9EaUpzeWVBS0JyVnVpQ0Z2eDZKRXVqRmJySmRqZENyT05yNTh2VEZI?=
 =?utf-8?B?S2RsajlhbWo2VnZ6S0thS3R5c1N5aUJrZTd0cWtoU2g5VlBHOVd4cHVEazlw?=
 =?utf-8?B?dnZpMnV2YWhkbC9Cd1FCV0JhT1VhNHdQRS9RdUR5dE0vUHVzUlYwQVliOFBv?=
 =?utf-8?B?K1IxenNsNzlBbGZCKy81N2hGMmFBcGx3TUZuRUl4QkNSeVJHaGRDSnpjemox?=
 =?utf-8?B?ZkUzU2JrdGRRNTNZTm5zU3VaK21tVUNOL1JrMTZ6OGNSUVhVTUZ5bFVXRHB6?=
 =?utf-8?B?VUNWa0pFZktrZVpFdkNNR09jRWNlWHFiT3RXbGhXMjQ3VlFUa1MvV0JlK2RH?=
 =?utf-8?B?Q2FWbkJkRUJXeW05SlVnZjhhM252OVJQSnkrRUxHMzluSG4vdVFOR2xjMXNO?=
 =?utf-8?B?UWRySVMvejk1ZFBQNUdUVXl5ejZTRXV2U1RoVVBmVFVzZzN0UGhDbW1lL3Jk?=
 =?utf-8?B?K1dMK0ZKbi8zaE96VllNVDduQTlNdXI2NnE1blBtbTlJSmV4OS9tVmRJdk1H?=
 =?utf-8?B?UkQ4NGsxN0o3MHVOVkJtZzFkejdyT3d2UTZKNm9hTDNCMDRJVXpFckNOS0R3?=
 =?utf-8?B?QzJ1clVneitDOElURzdpVGE4WXZJYXExSU1zVUlTMVBCODlJUDJrdVNJeHkr?=
 =?utf-8?B?VDYvcENYOTVETEpEOENVV0t2WW9UYW56NE05RzRaN1RlLzRTaExCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92612ac0-964e-44f4-2cea-08defdb06969
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 05:12:08.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t7isxj73SSfoOMdvQwgs8I54dmNgmD8rVR1DYBurIlOzndcvyao839mqG+XqbnLrJCpfg8fQ+Gn6LuVekp72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

On 18-08-2026 15:31, Qi Liu wrote:
> Add perf JSON event definitions and metrics for the Hygon Data Fabric (DF)
> uncore PMU.
> 
> Signed-off-by: Qi Liu <liuqi@hygon.cn>
> ---
>  tools/perf/pmu-events/Build                   |   2 +-
>  .../arch/x86/hygonm1/data-fabric.json         |  95 ++++++++++
>  .../arch/x86/hygonm4/data-fabric.json         | 134 ++++++++++++++
>  .../arch/x86/hygonm6/data-fabric.json         | 170 ++++++++++++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
>  tools/perf/pmu-events/jevents.py              |   2 +
>  6 files changed, 405 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 372773b998e4..79a9b4cad202 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -95,7 +95,7 @@ endif
>  
>  ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
>  # Generate Intel Json
> -INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
> +INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v hygon|grep -v mapfile.csv)
>  INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
>  INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
>  GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
> diff --git a/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
> new file mode 100644
> index 000000000000..8c6a8e9ba9a5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
> @@ -0,0 +1,95 @@
> +[
> +  {
> +    "EventName": "cpu_read_requests_cs_0",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",

Coherent Station is the correct term, if you go by the terminology in AMD
PPRs. Since CSes are the interfaces between the data fabric and the memory
controllers (UMCs), it may be better to rephrase the descriptions as read
or write requests to DRAM channel 0..N which are backed by UMC 0..N and
CS 0..N.

> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"

As the naming suggests, my understanding is that these events count the
number of requests and each request carries a 64-byte payload. Perhaps
the ScaleUnit needs to be factored into the bandwidth metrics instead of
the individual events.

> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_1",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_0",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_1",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_0",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_1",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_0",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_1",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "MetricName": "cpu_memory_bandwidth",
> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1) * 64 / (duration_time * 1e6)",
> +    "BriefDescription": "Total CPU memory access bandwidth",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_max_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_write_requests_cs_0 + io_write_requests_cs_1) * 64 / (duration_time * 1e6)",
> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_min_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_write_requests_cs_0 + io_write_requests_cs_1) * 32 / (duration_time * 1e6)",
> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
> new file mode 100644
> index 000000000000..41932a1a3d6d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
> @@ -0,0 +1,134 @@
> +[
> +  {
> +    "EventName": "cpu_read_requests_cs_0",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_1",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_2",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_0",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_1",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_2",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_0",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_1",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_2",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_0",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_1",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_2",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "MetricName": "cpu_memory_bandwidth",
> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_read_requests_cs_2 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + cpu_write_requests_cs_2) * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Total CPU memory access bandwidth",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_max_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2) * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_min_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2) * 32 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> new file mode 100644
> index 000000000000..ee81e35dc6f3
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> @@ -0,0 +1,170 @@
> +[
> +  {
> +    "EventName": "cpu_read_requests_cs_0",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_1",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_2",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_3",
> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 3 (CS3).",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "CompId": "0x3",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_0",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_1",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_2",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_3",
> +    "BriefDescription": "Number of CPU write requests to memory in 64-byte units for Coherent Subordinate 3 (CS3).",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "CompId": "0x3",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_0",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_1",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_2",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_3",
> +    "BriefDescription": "Number of inbound I/O read requests to memory in 64-byte units for Coherent Subordinate 3 (CS3). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "CompId": "0x3",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_0",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 0 (CS0). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x0",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_1",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 1 (CS1). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x1",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_2",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 2 (CS2). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x2",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_3",
> +    "BriefDescription": "Number of inbound I/O write requests to memory in 64-byte units for Coherent Subordinate 3 (CS3). Some requests may be 32B, so the reported byte count may overestimate the actual data.",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "CompId": "0x3",
> +    "Unit": "HYGON_DF",
> +    "ScaleUnit": "64Bytes"
> +  },
> +  {
> +    "MetricName": "cpu_memory_bandwidth",
> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_read_requests_cs_2 + cpu_read_requests_cs_3 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + cpu_write_requests_cs_2 + cpu_write_requests_cs_3) * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Total CPU memory access bandwidth",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_max_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_min_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 32 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 50a403b429b1..ba17117245d1 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -45,3 +45,6 @@ AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
>  AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
>  AuthenticAMD-26-([12467][[:xdigit:]]|[[:xdigit:]]),v1,amdzen5,core
>  AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen6,core
> +HygonGenuine-24-[0123],v1,hygonm1,core
> +HygonGenuine-24-[45],v1,hygonm4,core
> +HygonGenuine-24-(1[012345678]|[6789ABCDEF]),v1,hygonm6,core
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 376dc2d24162..07a843d92483 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -294,6 +294,7 @@ class JsonEvent:
>            'L3PMC': 'amd_l3',
>            'DFPMC': 'amd_df',
>            'UMCPMC': 'amd_umc',
> +          'HYGON_DF': 'hygon_df',
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
>            'ali_drw': 'ali_drw',
> @@ -390,6 +391,7 @@ class JsonEvent:
>          ('Invert', 'inv='),
>          ('SampleAfterValue', 'period='),
>          ('UMask', 'umask='),
> +        ('CompId', 'compid='),
>          ('NodeType', 'type='),
>          ('RdWrMask', 'rdwrmask='),
>          ('EnAllCores', 'enallcores='),

