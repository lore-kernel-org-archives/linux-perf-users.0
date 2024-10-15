Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FD1714C9;
	Tue, 15 Oct 2024 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728966318; cv=fail; b=SesTxEr0ZgYwmyR04iCJvksn5fKu7jN22fYNRh5h7m6yOkw8Tx6tupTMm9GAngt5n3TPGxFEv+XyG7ktwvledBsobbDI6V6XS6jE4ww/zCcC1DIw57hPcZ2lDyYSsdSoTLOymCVzZmENYydlMGtiMAV3StmrfYNh6Zztg8RSv/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728966318; c=relaxed/simple;
	bh=ZzedimhUJcyDim7Q2bQGLW1vZYBWXNudZNeKHDAfx10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkEca9uz9EiiSKFr9YjA/6jTChpwdtdWiBEsU19yL+a9k7LYw1aNvg/JtrBL9qEl/t51AV6JcDxxtkxuBHn+/YpbzJz2QZZ2hjAxXOGKjpvSk1u9gV0/OB1clVnwjiEeoWVTiOuwsdZlQwGktj84ur8HdFl2FhNAdhlUVREG9gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dejwcpw3; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dejwcpw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0RbGQ5+kznHuwwJLkHmK2tE3drcyz6u5jkpMlkqc1OA0bQMw85zhFrIoqfVsVVlyMmbajouKweZY74wj1M1vCi2W0+ZQFQhJBe/UHYjkAoWQyPxyhyXBq8rMxUhR6zrGIfPNsX0+X6vEPKE/QZ4adJtUOxi98Ls4t1731y2AO5tiB9VZZjBJ5+jy9v5CsmI+LNCwXKwgSsnhEUKFT4q8vo0x/MNNgfbj72QoIuoYWFafnWjmSYLuwEly1e16HzP2NlZGvWTvGhkLA75Uv1e6Wg6+aRmCaIX/QTI+AGIrHTaJcUyIJhtblZp6VsGq65ihuPHyx/x07H0H2el2tlH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AshuUmSLvhl5WHtZKc2/szDfOL1AKLegfPnJI/KmFd0=;
 b=bJK+MLTWRYVdslLVB3nKjN68VF7uvaSWTf7VpIp5t/ijZlSEIxIY5ZHCvO0i4cq5JuWH8h+pAnCOoS5QYGp1GLzDK+G5CKf4UresN/ol7NMZmtcMF7vbqPU8SRRdDVv/r0X2HHIa7HabN3HCo33kseRxzmcWxdz9xUbB/Axs3och5C9QydCLSKMXKW77nN2mI/yuAiSNBkNfEhcZjWWfB+SogPhzy8K6VnAfxx5l3f6CLq2FJQJdVpEt1sf4jNBwNrAYBUnV0eXTe/9lNVsJNditvZJ8hNQJSoSbN/9cOgrz+rEDRWZsoaWoQRxOLGMH4ndC1sqRjFT9holY8E767g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AshuUmSLvhl5WHtZKc2/szDfOL1AKLegfPnJI/KmFd0=;
 b=Dejwcpw3zEx9wJrR9AIq5JKTrq5gBYwZAiRKfEI9qXxSogXLItTlzZRJUOdZl6l0x4esY5ZvKpR+KKa2XnGcrTriBpWqmQt882XA3H83BdcsG+dj9XPcdx25IvZEf46x/8v9hEX94ySkcYuGilkmBUQXLvkOLdIJq72dUVlSyKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 04:25:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 04:25:14 +0000
Message-ID: <8a20f55b-ebfd-4171-9677-399f6c6f4257@amd.com>
Date: Tue, 15 Oct 2024 09:55:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v4)
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>,
 Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f430806-0681-4cb9-6431-08dcecd15d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTRjVFB6OVAyOHpwVHNGK3hUOWkyVWVpZHl0MmtrZHJXZzRaWm04YkZaeWFv?=
 =?utf-8?B?ZXJsNUw4NUxyTER4YkZTQnI1YjV0dy84bDFlQ20vdk13Mkt2dTdYeUR1TWhO?=
 =?utf-8?B?bUhha1VCUy9yOC9LZW16Y2NNWWQ4VEZvWkVCREZZcG9MUjl2UmNneDF3Z09h?=
 =?utf-8?B?czhIU1JOSDQrZWtIM2FaN0NqSHpoZmZlRGhrelk3c1krL296amxoUHArWDdD?=
 =?utf-8?B?bUpqR3pPK0xYdkVwd1pRQzd5OVNUekR0MGVKNnVIc2VNMHhPM3ZwU0Y5Y2k2?=
 =?utf-8?B?cE5vT3I3aVlST0lLbkhMM2lUaW5lU3o4dWtPWDQ4eTRqN1JEM0dFcTBmMi9y?=
 =?utf-8?B?NHZRNWRqSUc5bzQwRTAzbmR1LytzL202OTN0VCtCcFNONG9Yc0poanN5OEF4?=
 =?utf-8?B?aERpTlFFUGg0ZSs4WlVvbU9CY09wVHpHT09oMlN1RzVaQTlvcFFqbXNQNW4w?=
 =?utf-8?B?U1dZaXM1VzdqMEtJR1crRHBUbWdVcGxVcTNUUFBXOUtha0tjRHpWTDBQcy9I?=
 =?utf-8?B?YmJ6SDV0ZHYwSVRncE1laTlvT3BxcnM1UkpxQ0pNK2QwVFdqNWNTNkdrYk5U?=
 =?utf-8?B?aE1pTENoSFlZY1hRNWZwNlpsZXRmejZRWGtVM2ZyVFVmckJ0TFN4WkVkeVp6?=
 =?utf-8?B?bE1vdkVBTzNOSWFNVWgvYVpNWUxZV2xiQ3RTUlFBRW5GYnc2MkxwbzR2cTlk?=
 =?utf-8?B?QW5NOVkvOGlWeDBlS05acWF0SVNhSS9laTczcmx1aGRYRm95Q3NOZ1Urb2pK?=
 =?utf-8?B?NE1Mblh4OEJYSTZ0YkF1WUJYNCtjSnliWVVtRlBTTlhZL3VZUExzL1hwN0hZ?=
 =?utf-8?B?R1FwL3VHeWFFSE5jcjhVUUhUMGdaa1k3TkFEdjFxQXA2WHQvZVJMSWlacG5T?=
 =?utf-8?B?M0RDMzloc0lsRTdUeWN6bWs4bStpbndyZWZTRURha0ltTzdCZWd1aWl3SUk5?=
 =?utf-8?B?SGhmSndDdDZUcStWcDV6SnV3Q0xiOThBSXVwVHBKSXplY0tQNm9YOHlEQlVk?=
 =?utf-8?B?TFBCMFFvUjFYbmlFM09hWjhiRlB5THFzWkc5YitiUkxKV2JSbFZyQXNFOXBY?=
 =?utf-8?B?YzBreTRibDhQL0UrS2tFNml5ODJYRVZ2b0VsMFptQm5VcVlDd0pQdzN3UHNz?=
 =?utf-8?B?NXJWRTJTME9FTFdzdTRTNTVJQ0RHcUQzR2o5TEdNRnE4dGdJa2szYWE3OUV2?=
 =?utf-8?B?L2thQ3gwSVk3cEErTWFDaGhIN3RVRUpycmVva2FrdndMNGZNSmtzeTJLd2Zl?=
 =?utf-8?B?MkloTjNwcjZxRkhaVVNQek9vcUxkdmc2ZDRtTUpKMlgyWXlDNEtneG9GTWwy?=
 =?utf-8?B?eWQ3YWUrY0YxSklYT0psV1lDU0RuUzI0VGp6WWdEdklwR3RFdllPSlh1MWk4?=
 =?utf-8?B?L1RaZTNvd0gyeHErQ2kzR0FPODE1OUhmQ1FXWjN5RUtkK0dnSmZuR3VFQ1hq?=
 =?utf-8?B?Nm9aSnZMbFJheTNYMGcvaFdmTUEyWGlGTmRpbTNMVGJzVVhqNFhubkxGWVlm?=
 =?utf-8?B?TzNBUlhPYWVXN0pNRXJDSVNaT1F6ZFBNWTkxc0pwOGJ2OFlrcVhTQWk4OXJ4?=
 =?utf-8?B?d1lDMVM1YVNiczRBMlJnUWVVOHdxSFN4S1ZiWVlINUR0ZG45dy9HZ2tzRFV6?=
 =?utf-8?B?VWNtcU1xZlJoOVgvTW5meXp5Q3hTRW54V2xuUEVJNGxHbTBUWEtsOWx3dFA0?=
 =?utf-8?B?S1llRDZUeTh6VnJXcFd0NHJzdEhDbHdFeDdKdVBjSUtHTDE3ZnhVMmlKdzVG?=
 =?utf-8?Q?yCeRw13012UcX4OqiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5NR3VYaVZoTjdXSnYwbjZNOUNLZEEraHlyMzdiOFlmcXgwa20zaHpCSmRo?=
 =?utf-8?B?bWFmRkpSVGFJRkFnazlPcTE0bmxwRGoweFdZZVRQLzZGaHpDWVpYWWRjZEpt?=
 =?utf-8?B?KzZoai9MS0JyellmalY4YlpVTm56aGtpbGRiZURaejhNQUx1WVBIc1NiaU0r?=
 =?utf-8?B?V1ZIOFNnM01wbFVwQllFZ1BRTG9xUzVRYlE1N01jeVorMGpqdWtLQ25XbE5J?=
 =?utf-8?B?TG91MHZWaHRKYS9HMHJJaGhXS2lacERGZWV2RkUvTHM1NWk3SEovM3lOK1ZQ?=
 =?utf-8?B?U0JCWTI5aXRvT1BySE1xN1Z0SW5CcUZrOHMvRGRNSmNqL0dBOWQ4WXBKUTRZ?=
 =?utf-8?B?dmVWeGg2VjIxRkJ5ZVgzVG5OTkJKSktTNExhZDNueHlxZS8yQXZ2YmVlRUNX?=
 =?utf-8?B?U0VlV0dZWDhZdkVtODlRdS9UMXlCNnZ5WkxxNWl4RnFUR0NublJqaFFxaitQ?=
 =?utf-8?B?YW9xOFUrSVpSS21lbU9wZXM0a0tUTlRGcnlBTGRUOHAxMkpxSkFxWC9naGtO?=
 =?utf-8?B?WWhNTC9lMG1xbHpCUUdDZlFXU3pCOU9zMlQ2eFE4OUxwUEd2MXJ6cG1hOENT?=
 =?utf-8?B?RVlkQVBNZTg0UndzTzBCcVdLalVOZC83ZlJWbFRUZ2VUQnNIYW9XN1Q2UjVQ?=
 =?utf-8?B?ckF1eVpaNFUxK3BUQnFOd0ppZHdla045ZzB3Tmp6amlaKysyQWZDNStWWFNN?=
 =?utf-8?B?ZEVoK09qdVZwV3BBRzVpTEZpMDAvM25WaVpDQld2WDlaRExYc1Z3UEVWMENn?=
 =?utf-8?B?OEhvTVJQUFExS2ZXbWxNRGpDbVA5RWVSSWc1TG1lMFYyRzdOOWhURGk0bU5u?=
 =?utf-8?B?Ky9oUUN0YW5sd0YvNFJKWEpERlplRDBLcGdEcThNWnozT1VwRERGVEpHNGxk?=
 =?utf-8?B?aGV6ZnBGTnZSUHdKdzRWMmVvc0tva1NyZDRPMURGZnFLYUROY2RMMi96cmFM?=
 =?utf-8?B?NWorcU4ydG5JVWJXQlFlWGFZR3pENkNSR0xPdFZvRVNGTStPWWVUODdZQTdx?=
 =?utf-8?B?RUVDMUNuVnlUbnYzeU5MakpFRGM0OGNwR3VhUm43TjVkczA3RE1JeEkrUEZm?=
 =?utf-8?B?TW9oZXVvREtXVlpkbnhHMUFlMnR2ZEEyNDVlZytVTDhtSkE3Uyt2TWQ0NXZ5?=
 =?utf-8?B?Y0x6dmNLTWJURXR5UmlrNVBEeG1YTGh0dEZlMmUrSmJKSUVld3hpV0s0ZnJO?=
 =?utf-8?B?NERsamVNYXdxUk1xMUF5UE9OMkxKVnV3TTcxRmNVb3J1VTBWL1ByL0RucjNo?=
 =?utf-8?B?U1JPZUd5cmxwaHFKZE80bjFzNzBkam5WbGV5bGJ4dUdGRnF5RGhiSXdoS0Jh?=
 =?utf-8?B?Qm1DdXB1SU8yenBEUDAzSDIvd2RSaUN2VVp2MStITWQ1dHRHSTlvV0JhLzNm?=
 =?utf-8?B?NFF4RTRWUnNGTE9ualQ0VUJ4WmErSDAyN2h5R21wdmpaN1Nsd3V6NTdjUVpI?=
 =?utf-8?B?Z216dnBiTzNzWWZCYUg2Tk9ocU5VUzFPdEVlQS9DSjd1RTVubWpuL3R6SE9B?=
 =?utf-8?B?b3ZPbHRQa1JlTUVMdkhkeDk3Mm9sY25MRElNSG00R01oeW1nK281bEl3MThO?=
 =?utf-8?B?WjBETWFBUUlWS1QvVmk0RDg1MDkxdStNYmdUYjBES0tpdFJrT29aU0g0NTFZ?=
 =?utf-8?B?SnViTUpqWkpicGFHMVBSSUNqcUFaSDU1VFRiOXZrT2hvcjVEdmNWZkgwZkNU?=
 =?utf-8?B?dGlpUTJxOGpEM0JsalJQL0ZLaEh2QmlSRkFKZkNONmFMUFBGbVhFQ0o4SS93?=
 =?utf-8?B?WkNVOHpsWTlYN3FZaU9UVnVSS2NIWWFwWUN1RGNDY2NacURkZ0M5aGNOcTRi?=
 =?utf-8?B?UVlEODZSbXY5Q2dSazZWdmM5VkJpdmdNMGwrYnNvMkxsbkEyQmVaZkJNTW5s?=
 =?utf-8?B?ZEJGbGtKRkJLTE93c08rZjE4dGsyZnd2Nk5NMlN4VkVobDZvY0d0QzhDUGQ5?=
 =?utf-8?B?VXR5cThuNWVmRmxoQkQ0NWNIRlZSZ3JHbGRUakFBUkNLajhicGVVSG9Ca1dx?=
 =?utf-8?B?eGpiZ2NPV2t1dWhHSC9sV29tcWNGSXZmZVhuZTc4VGpCU0hSYzh3SS9sbFZs?=
 =?utf-8?B?Lzh4TkZiUEtJY2dFWHRHcE9hRW00RGlMRHc2QW44VDBBbVJpZWttT0t5d0gr?=
 =?utf-8?Q?6qkv9MwGRx5h7yhRSmmPwe6N7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f430806-0681-4cb9-6431-08dcecd15d7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 04:25:14.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 536mKXUsxwhH6BtJje5f2arOpGeB86HribspeaNsi2w3qXJ1gYLvci3BYWyeGAWjKwVNX8XZqvU48dJjuEIeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

On 01-Oct-24 5:50 AM, Namhyung Kim wrote:
> Hello,
> 
> I found perf tools set exclude_guest bit inconsistently.  It used to
> set the bit but now the default event for perf record doesn't.  So I'm
> wondering why we want the bit in the first place.
> 
> Actually it's not good for PMUs don't support any exclusion like AMD
> IBS because it disables new features after the exclude_guest due to
> the missing feature detection logic.
> 
> v4 changes)
> 
>  * handle EOPNOTSUPP error in compatible way  (Kan)
>  * drop --exclude-guest option in perf stat
>  * not to separate exclude_hv fallback
>  * rename to exclude_GH_default  (Kan)
>  * drop the RFC from the subject
> 
> v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/
> 
>  * move exclude_guest fallback to the front
>  * fix precise_max handling on AMD
>  * simplify the default event for perf record
> 
> v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/
> 
>  * update the missing feature detection logic
>  * separate exclude_hv fallback
>  * add new fallback for exclude_guest
> 
> v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
> 
> AFAIK it doesn't matter for the most cases but perf kvm.  If users
> need to set the bit, they can still use :H modifier.  For vPMU pass-
> through or Apple M1, it'd add the exclude_guest during the fallback
> logic.
> 
> Also the kernel feature detection logic should be separated from the
> exclude bit tests since it depends on the PMU implementation rather
> than the core kernel features.  So I changed it to use a software
> event for the detection and factor out some hw-specific checks.
> 
> The code is available at 'perf/exclude-v4' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Apart from few minor things, series looks good to me:

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
