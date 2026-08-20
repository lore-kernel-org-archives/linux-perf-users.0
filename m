Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF540A942;
	Thu, 20 Aug 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221263; cv=fail; b=CBg3x/L0Y1yYgbNCKcLYuAZy37Bs829Apu/urB/Ys98JPpZ8CO2oqJ9yVAyeVdSqsH/sJ1KH8JhSFzZabRHq21nIBFh83x6lrHuBtYDd320YNYD5oIOn289p4IvQkYLy2P5Bd693MV4m2ScbXk1JguSs3UeROX0cGPKQ8e3B2pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221263; c=relaxed/simple;
	bh=8lgLJRTOX1uGZf/me/ifSD+kNVFtBG/YCYqBlmYpNJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQ46ezwBsiKIVSZRJB7zlXigxc0LhhU5Pgpvwq4LFceKqjCUZalu+oHnBFkiyGTKJVy0zfUqM/ZhOGII1HGVsx6B3e/7KGtuzMRYMX+2TYTP4OEVEcUElLwhPDSHvSX9AZT4JHd2kGnJ2LGD03comNmONuN/rn0DprV455cwJSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bbl/2SOC; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bbl/2SOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F91LPo2MFPg7xmGdUUq+XuPl+zm+OXvaBuhz/HxY58OD1e6BnQu4JxBj3AFno7xI3oHQ0Ii93gr4rHWTEap+JsmA3YyKSx0L1no1fTD/HwoZ4lVDUXtBBmqrHBLRBV/iQhm3GRgaouq3TxxjwB1FXO1TcQMzEYTFTesvTllVdSz8XCo3QwpIvTP+F8GHidInWUmILqGCMRXLGN9DvsjzAUUQ04VOm/nyZIDeTEdNvgr8NLncxbT0AxYlT7xI+ELgcsRSiHJcs1vHQHZr50YlO8vyjils+Zjibx26Jaf1IpWNywYnbVdTeNRRuc1ZLAXyapo361TWsGPaloouoKWo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+uA5v/zn1h03hrka0g3O9XaWL5zpy9Ouad1JKsxTW4=;
 b=A/fWcSeKR5Ut1TFysszSqING3ue1Sph1EU4rXA8X5+dVQv3q2Xlh5uaV8mccqwyB4jH1F9VnPcy8UALPzzAAmsxnk7Hwo3sD7ElO7ZA4CQ4CTUSLY01cI7xl22VxEJt4AadihUmeHm8HKqSbVVGj3TxYAhc0M4GiSWBAq759xRj3JMdTX9JewXGliT2GSZH9M7k6qVeUDCMfJ5ZAgvL2N5h9A97L80qLB/AwNSNT7kGAMKVxNx+3X3vCBBSOy8QQhW6z4p7arQrfegCJurFiZP5SKQ5vzHZY0omWCBk9zhlkjtIkr7giinOfO/TAOoMsD594JE1P9BY2ctrbpDBXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+uA5v/zn1h03hrka0g3O9XaWL5zpy9Ouad1JKsxTW4=;
 b=bbl/2SOCu6q3nFCblIlQfGryeGSXiIp14H71i3gX1RTYZhuWmMol3Tf8b5FMwwYPQBbdE+Q1K4jiaeta4SDPh0DOt8M93xdkXS+IQFasx3pF4CbbsDXmei7yNG3pi613hxrLnp8eqhpwqY9AJPCxW+7sODkucr1tXi0M19+kBXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Thu, 20 Aug
 2026 10:20:53 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 10:20:53 +0000
Message-ID: <c30e91d3-514a-4fef-8b61-e1744f577d35@amd.com>
Date: Thu, 20 Aug 2026 15:50:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] perf/riscv: Use Sspesa for precise sample
 attribution
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817160222.3313295-1-mayuresh.chitale@oss.qualcomm.com>
 <20260817160222.3313295-4-mayuresh.chitale@oss.qualcomm.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260817160222.3313295-4-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0196.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::10) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: e92102a2-5505-493d-30a3-08defea4b6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p4fOuXSGHysHENr2XFAP1IFISCdOZciquvLrWiLbZM45D/JPnb/XNIXZk/rNt3j4mWqIUz3kbgNpAXYAX2CZvruTR3AIsTSvtEFsJS6cm6wWEo62sbqed8+lj9xfw0hgUUJAsuvFp4XMOn4AzZIzoT55lrxvZv5/lUUm38vq2/CcBVsdcWxdaEEJa/MgsZAAyhgFVeJRJqDZm1om/DA5HOw9izDWNre/eMxB6pFx3WdIuTi6wxu8iHrZKibKEzTc9o1jwU4rgVrreIEUOfULWdPlcb9VrwhDB33kfXp/KxbHJ80JXEMM+l1uV6C5oy19BAuSUQhBOIiJDv9Cifq7KpEZ4eE3l0aGhqPuo+2F7pNICb+XuLG+wlXY2spg9CGcGcm44qyqnaJDzbbAAI/osLBrtNV7qKun+nXbTjtaATXf0qHaX4uHUz6n8JOzsexD9CL4+FpA2AGVCNNGGlJ6kMhq+MLiRczGWJaAlF0cRcH4yDNUvSwjk83H1+9Vowl25RCrciNrbJaxb3UwY2O7SsX4INIRioBf0Ki/XwHBbJgSnDtDLd2Ss76eFkQ4NiLyHA+SfK3lzc1X3gA03XsKfAHSr4yD+uuzBUNq1SntWAfilb1xeQewc51LZX4uBrzNEkDdkrUFwSOCIRGniagc8OnjYThGJiPWmiV3nl572eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHE5ZE5aeFBwM0ZpZjdQWXV6bmJsdk1wV2d0ZjMxVUtRQ0VPOXVvL2xJL2JB?=
 =?utf-8?B?U1lzZ0hLRytlNFdJeU9oSGgvd0hoUmRhbnkwOTIvRkVaZVVPUHVvdkRqOFFI?=
 =?utf-8?B?TkY5UVZPTERhV1EvcFIzbUk0b3JXZFlxSXpZeFpzcVZnT0ZOaEk1M2lYMXhw?=
 =?utf-8?B?akFoZm9zMkIxZFhOUjl1U1djUTFsNEVWQUlvcDVnK1VIZ0ZhTXJLTHU1MU10?=
 =?utf-8?B?NEVPU3pqaUI0K3d6SXRVRFdqWldFSExtZWt0aXNpSndUTWlDWGp4U0ZYRGtt?=
 =?utf-8?B?YmlJQkZuNytxRnVZOGtRRzQwRUp4QUdZSWFlVWFEUm9HTXRsZHpheksxa3Jq?=
 =?utf-8?B?RHRPWGJSbUZYOXJnQ3lIQU1BajBlanRTc25Cc1p2U1lNd2NiOENaakF2SHox?=
 =?utf-8?B?L2dIS3dLYXhodVZnT0ZsNS93Yis5TmJaaXErV21YT2VaN2R0QWdoL1FVdzd2?=
 =?utf-8?B?SjlKSExaazQzakFjMTdDaVY4NGhNVXpjWHZqNU8vSVloRWNGc1RvbTlSdXdh?=
 =?utf-8?B?Z0hjcEJpYXVoNERkN3BpekJnSCtjZlN0VzdYVyt5SXQ3TFlHa0U3aEFieUYv?=
 =?utf-8?B?TmVyQkFIVElpQkEySlhWM0R6YS9mampHc29ZSm9HaGRHS3hIakVEV2pUNzNM?=
 =?utf-8?B?WEdEY0FUSGRocjFjVm9lenVtK3lOZU9YMVdmMVBoSW5lQ2x1cXhhOTVVek9q?=
 =?utf-8?B?TS9QYkRlUFRsdGR2L241ZWVOb3A5UDZGVVBtZTU5MGdoa0pOMTVNNDJJWHl5?=
 =?utf-8?B?SjAwcm5jK2hObDZiV3Q1aGdLanl2TlN6UHpZZVhMN0d4TlBsQ2cxRVl3Ty9J?=
 =?utf-8?B?SlFiRiszSDhMcTFsaERuSnVqVnpSUjVWUlJNVkVnY1FIczNEUllqVlVXZzVo?=
 =?utf-8?B?N2x4aXh4OGVUOWwwNXY5RE9zU0xvU3ljNmZzLzZxTXJWSXpENEFEUVNuRG5E?=
 =?utf-8?B?Uk5CVE45ZXBoai9HdnFKZVMxeVkzbTBhanlZRlpXbGJwYXlxcnNmVUFDWUJG?=
 =?utf-8?B?QkpXR3BlMDJ5cHY5UTY1dWIvTGtZOVd3Tlo4QkpPTDFHd3pLQkNOaTF4cDlB?=
 =?utf-8?B?ZEphRVZqNUoxRmRYR0xDSVVyQnNQWnc3Y2xueVJzSjRUaE1MVFdqL0lVQTJU?=
 =?utf-8?B?TTdsNVJhS0hOZVZvNTZidUVmcXBvT1pMK2ZobDVSeUZESmkrMjdhNG9sbmhQ?=
 =?utf-8?B?UDBFRFdhRFVncDB1YTRPaHpsZThPekZNb1FIa2RVZGJaVE43NU91TmE1b29K?=
 =?utf-8?B?TDdZUnBHYWIraG93TGRqWWVBVzRCQ0ZoSDZwTFIyTnkzQlFEam96RnE0NFJq?=
 =?utf-8?B?MXN4elI3VlRYcEFhbjlJTDJ0WUQrNnBNaDl4K0NTL0sycnpzUFRDZUJ6TU5L?=
 =?utf-8?B?RUdHclJiakt3UGIzbk9kMDhiSzhadHBCUSs0L09kdlk2WGd4TkdjRVdsclNO?=
 =?utf-8?B?V2R1YnVkRm1XWGZEclgzczhKcGdlU25UbTdhTjlhczZESDcxSUlhK3pTalVZ?=
 =?utf-8?B?VXR4QkR5bXhJMm1UOHEvY0RwdklvL1lHVy83bFFqQkMrcXVENS90WXZ0K2N5?=
 =?utf-8?B?MXFwa0FRd3Y5UjhoU2o5bXhON0J2MDBtWXA4dG1XOURtRHlzZnB0NGl5UzdM?=
 =?utf-8?B?S0xWZkllZ1doNlp5SFA0N3BsZTFoTE5rNFRXSjRsb3F1NlJjSE16cC8rYVN6?=
 =?utf-8?B?cXRMbFF1WTRTMGFwV2NlTEY0d0pPcnMzQS9Od1pZQWNEV0NUanUzZ0Eyc3dK?=
 =?utf-8?B?dER5OE5rZ3M1TktISklmdGlDZ2VUdW5teHJuR0lLdVBiZ1hCN1oyYjNmVFMv?=
 =?utf-8?B?RS9WOUlYalhWRVhreVJDemc4WlNFV1d1OUI2SERrNGtvdW0rdlpOYlRCZVY2?=
 =?utf-8?B?MHR6V1FHV2JVSGZpcU9XOWhqd1Z4VlpvMiszV05UL1ZpRUpFK1RJZFFheUFC?=
 =?utf-8?B?UTNVY0ZhdHRrYmlUVVhiSGRBQ0NIU1VGNGFiQXg1SWJNZXNGUnF5UkRnazg5?=
 =?utf-8?B?cE4vL1dXenFnUWtDRTZNdG5pYnk0eUx6R0xRZ3ZTd1JNb0FhMWZOOCtJNnNZ?=
 =?utf-8?B?d0pCUFlLUGlVUUkzajJrcW9KK2xIQlpvUGY0NmRQOTFKRjJsUzRGSE9YRjNo?=
 =?utf-8?B?aFl1RkxjQWhBaXhCSk5WR1hNQVp5VEpkdHIybHNFa3FWNDZsK2RUQVNIa3RM?=
 =?utf-8?B?L0JoU1ZFWVdRT3ZnOEI4L1BORTFxamg5RlVVN2hGemtsRWMwa1UrYUY0UWVq?=
 =?utf-8?B?WWk3Z2xxOUNwMy9uU1JiQ2xKZ3E2bG4rRmhOVnVHTHM2SEx3RGVYMTR0VEJF?=
 =?utf-8?Q?AM2As9yo0dPuCSFLMY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92102a2-5505-493d-30a3-08defea4b6a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:20:53.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikAJaCmUAsoYu7KZYPrN+UX3r0wFOSGF6YeXOAhXUgPZtMXuZ0Kg6mDsymskzG81INagDrTBzejrTvwSZiyUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411

On 17-08-2026 21:32, Mayuresh Chitale wrote:
> When the Sspesa (Precise Event Sample Attribution) extension is
> available and a counter overflows, the hardware records a sample PC in
> shpmspc register and the counter ID and additional implementation-defined
> data in shpmsdata register.
> 
> In the SBI PMU overflow handler, use shpmspc to report sample PC via
> PERF_SAMPLE_IP for the counter that caused the overflow. Shpmsdata is
> exported as raw data to userspace when events request PERF_SAMPLE_RAW
> sample type and it assists in deriving the sample PC from shpmspc if
> precise attribution is not supported for the event.
> 
> If sspesa is not available or for counters that don't match
> shpmsdata.CNTRID, fallback to epc for PERF_SAMPLE_IP.
> 
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dfc886dee5ad..1b0b1cc612de 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -63,6 +63,8 @@ PMU_FORMAT_ATTR(firmware, "config:62-63");
>  
>  static bool sbi_v2_available;
>  static bool sbi_v3_available;
> +static bool sspesa_available;
> +
>  static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>  #define sbi_pmu_snapshot_available() \
>  	static_branch_unlikely(&sbi_pmu_snapshot_available)
> @@ -1051,6 +1053,11 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
>  	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
> +	unsigned long sample_pc = 0;
> +	unsigned long sample_data = 0;
> +	int sample_cntrid = -1;
> +	u64 raw_sample;
> +	struct perf_raw_record raw = { 0 };
>  
>  	if (WARN_ON_ONCE(!cpu_hw_evt))
>  		return IRQ_NONE;
> @@ -1088,6 +1095,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  		return IRQ_NONE;
>  
>  	regs = get_irq_regs();
> +	/*
> +	 * Sspesa records the PC and metadata of the overflowing counter in
> +	 * hardware. The PC is precise only for events that support precise
> +	 * attribution; otherwise it is best-effort.
> +	 */
> +	if (sspesa_available) {
> +		sample_pc = csr_read(CSR_SHPMSPC);
> +		sample_data = csr_read(CSR_SHPMSDATA);
> +		sample_cntrid = sample_data & SHPMSDATA_CNTRID;
> +	}
>  
>  	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
>  		struct perf_event *event = cpu_hw_evt->events[lidx];
> @@ -1123,6 +1140,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  		riscv_pmu_event_update(event);
>  		hw_evt->state |= PERF_HES_UPTODATE;
>  		perf_sample_data_init(&data, 0, hw_evt->last_period);
> +		if (sspesa_available && hidx == sample_cntrid) {
> +			data.ip = sample_pc;

Does this need to be tied to event->attr.precise_ip?

> +			data.sample_flags |= PERF_SAMPLE_IP;
> +
> +			raw_sample = sample_data;
> +			raw.frag.size = sizeof(raw_sample);
> +			raw.frag.data = &raw_sample;
> +			perf_sample_save_raw_data(&data, event, &raw);
> +		}
>  		if (riscv_pmu_event_set_period(event)) {
>  			/*
>  			 * Unlike other ISAs, RISC-V don't have to disable interrupts
> @@ -1194,6 +1220,9 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
>  	struct irq_domain *domain = NULL;
>  
> +	if (riscv_isa_extension_available(NULL, SSPESA))
> +		sspesa_available = true;
> +
>  	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>  		riscv_pmu_irq_num = RV_IRQ_PMU;
>  		riscv_pmu_use_irq = true;

