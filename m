Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44F18952A;
	Wed, 18 Sep 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665609; cv=fail; b=OfNKXpTrZgi/4miFtRiKPTQzVYS26iouGVdZ73rQzG4cQC5FQpAJSDfayliV7sRbuge2KpD/0Y+9e/Bm/TmztizMaV8XdvpmxolUNAlbEg5MbWBB3Js9dCkV62pQbdOaeOycH/Hec6FbU2dJBiEIIHtMbxcS5rvMy2zLR4TvBGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665609; c=relaxed/simple;
	bh=N8rZM/+D8c00SIvYUWSEIgqoGdrKbq8x0msIT+OAAKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PgKuUwdgYjKtpVENz0a08k0kTfvlt7FdjfbP/wk4ug+LRBbhzjdDU7dSJyR6F+398OFUDOepUCFLFh3kNRZ/0CNCjTebXJSgOs7eyygwf3AY4Sge8SyPicCd0wG7m+BeJLdJZxPQEdfOCU8Wf0TPYdrfdPYAk0zYu53h+Higk2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=upIniZBC; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="upIniZBC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWBPuLBIj4K7t/Pfp0meoqCZjAegnDW/jy+fAf0fSFxnVMOGdKWFvUv3AoEc8OV8Ewj6kMaElcB9+/s2A4PrOjbCioYtcgEB7YF1AXooS2Z4bdbUVvh4QHtiK69vTKw5k/5KJYCCUIVkcutEe6RgcNTYjwN8NO9HYaD434iKXFxYBULaF1WPE9BS00CHUq/l4oPfimWIkKJu8fzZoOUcaiZZJzgh4p5psbnMUrqiKHAzxei9oJty8ibn4wONdLFLAsDMYJGJFuf4xyLhDDLYZNZHZ3VVehHT1Q1HzzGrlegZ9i2iByIKZI1IWWqQrfk7Nr2hc0OG3/QzT4hIY2pXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr+dHzYORG2Ce3SKuWLDE6MEiqAO54E/eHq8o2fnJNA=;
 b=PvHk2knBAfa2c/bkGX8yOiwQjdS3VywR2enSDdbkN4lPMZqVRgXw5RnCpxi4/1Ste+V6LHHJLnQEN0sTtCT1fdP2u8wqVKz3h7oevRGiCS10jzWAbRpPycKC5RS80+6G+jDmt0FVLvWVbfr7lTQOOMeT05m4BbCumLHirHxDju8xNns3ptUswG+FCUR7xO3usID2ES4sLNrcwc2d3aNhWKnTnB/jrYSQ7pq+6dNlK9zk6JWfYBQxuivMI6pDiKX7WQtX4vthdxFKblMMuECBYlCKCbdtKpS0X+Qi4788/Jf2pZlys1mV/CcjwXqO4iPfhiD7uZKx4j0Cr62TrKcRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr+dHzYORG2Ce3SKuWLDE6MEiqAO54E/eHq8o2fnJNA=;
 b=upIniZBCsFPbFL4x69J89Go1sKSflHQiMSu6jzbcDzmkKsqs6tOGXogtl2jxMtoiW97+xaXZD5gj+wMBg2jHRupwTvnw6Kw499+qjmtszJFVneyt0ZqN6gIYRkFAow6g4XQL0q/bEcXxJ+72VBPRepGHmGN/Myzw5bW7U0zplIk=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 13:20:03 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::ae) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 13:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 13:20:03 +0000
Received: from [172.31.178.209] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 08:19:54 -0500
Message-ID: <124e9602-77c6-4e85-907c-907dfdc42087@amd.com>
Date: Wed, 18 Sep 2024 18:49:52 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] perf sched: Introduce stats tool
Content-Language: en-GB
To: James Clark <james.clark@linaro.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>
CC: <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <bristot@redhat.com>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <f022afad-793d-4a3d-acad-13fd27dd5e62@linaro.org>
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <f022afad-793d-4a3d-acad-13fd27dd5e62@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: ae30c6e3-8b86-4046-3b1d-08dcd7e49b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJjTlRIT3ZPeTUwRFFYamN4QVhZY0V3YnB2ZVVlbE5RVUlmakJvWXh2emZC?=
 =?utf-8?B?Zm5kZzdYenFtZWhReFRiSzVjdklwRWZNblZhYmVYdjQ4aVFFa1A0ZTVFQkFI?=
 =?utf-8?B?QkFZSWhPVXFlbU1DRWJaaFFSbXJ1K01ZcGtjNFFZZHI4ZU1OVnMvZlBWWHdn?=
 =?utf-8?B?QTNOSVhYZVJkbk43aVMva2s3MmdPZ1N3bkNxVzRRTzJmWFhkSFB5cnpuTTVu?=
 =?utf-8?B?RUdLR3Y2bVhsN3VjSGJ2RzRrSWpJc1pNUzRmSDMxYjFGS1hNN09PbWNPS1Ax?=
 =?utf-8?B?bVVBN3BqT2w4WDRSSnBUUXRJVW9pcEpEK3U0QWlyUEU1M1htam0vYlpoQUpL?=
 =?utf-8?B?T3JQSXBKcFJUOTNwcGdPMGlZM2FNdG1uK0lHZEtGMFM3Q1A5a3JQdERXb2RO?=
 =?utf-8?B?N2M1Uk45L3NtY2ZZWmlaaFEraFVuNFFTdEhLK2YrMDJFQUdIU3BIZmFIMXRD?=
 =?utf-8?B?a0VDZjZHalJ2czg1eUYwRU5SOTZWQmI3QzQwRDlSS1FkN3RnU0tTZlVjbXA5?=
 =?utf-8?B?K0lxdjVHTSs3S2U4UUFKN0UzbFlNWXhqZGxWdTNDVGNvUzF6UEVCSys3WGZZ?=
 =?utf-8?B?ZE9zd1FNZTh6MituZklzbVVlZjVlSnlQTHZqdmlOYmRyV05GZUMxaGpxQUpS?=
 =?utf-8?B?WDJoRkVITWk3L3lhN1Q5UjdUTmgvYVRsMmpOOWlhU2dwbUR4VzQ1blQ3RFgz?=
 =?utf-8?B?Z0dxQWFuSDBBR0p0QzdzcW44SzA3TERpV215L1hPeEJLbzVLVzNWOXB3aFB6?=
 =?utf-8?B?Rmw0N1BkeXpieHFldGplTzhKSlRjN2lrZnV0SVpsZ2YwVmpoR3QwaVlHUkdX?=
 =?utf-8?B?YUtuS1hYOXpRV0dFWERxYS9pQnVZZHNKMkpQdWVvb0lCWmhlbk9jYWozN05l?=
 =?utf-8?B?elZLZUJaRTFxUjAwMFVmazIvZ1pCNmN2UTV0QmM3WWJYWTdyZUpvZjA4aGxs?=
 =?utf-8?B?QjdQR1duTTNrdlBlN29MRmFHSGEvNUVQTDJIRHdYT1JkRytFOEthYXA5Yllu?=
 =?utf-8?B?NlVVUHhobmQ4TjJHUHJiVUlpZ28rakRubGkwT3FUSWtDcnVBUWkyeTV6SDAx?=
 =?utf-8?B?ME1JSlYyUW1BSXJsUzJsdFp4cUN0K2dDTFhCcWNvaGtmWndNM1RNNXgvUnZw?=
 =?utf-8?B?ZHNORnlFckFvb3o1cEJVdE5rNkZXRHZnbkpNK2Z3Nno4VTU1QUlLajQzSlox?=
 =?utf-8?B?U2xnZlJpckFiNGdDR2FoTDJVNzFpbi9MMm01ck43OUhZQkh5by8zbklKT3I5?=
 =?utf-8?B?Q0F2bHJ5SzlXcnJKeUtjWEg1TEFRcVQxZ1VqWHZFbU4vUHU1dVNJMU1QTzND?=
 =?utf-8?B?T3Y0VlpSRnJjYzhaZlBwVTAyL0U2dmR0b0theDR1N2JHQkNwSzJFY3QwWTg0?=
 =?utf-8?B?OU9WR1RKZS9UbTh1Rk5xVWxya3ZyTzVhMnhyajRSeEZ0TUk0bTJOZnRmTFBO?=
 =?utf-8?B?VkZUNjFkd2h5b1kyTmhZNjErWTRKQmZBM0JiWWZucThyWTU2TTBDMkVsMkcw?=
 =?utf-8?B?Qkt1VjFpMnYyM0lVQ00xYU81RXR5RlVzWXlTcnozVEw1QjIyTjhmUjlUdXdK?=
 =?utf-8?B?RWZNMXRuS1BVOEtmSUhDREZGTE1TdWV0bDhZWTkrVTdLakZvVnhMaFdvTEtY?=
 =?utf-8?B?U2JVQm52clVYUjFGRHliektTV2VKMmJZNWJFMjE0Y242V25GS21YQy9zejR3?=
 =?utf-8?B?elBpeHRkNzJWVmxVSU5FMXQ3cWhWejJ1bVZCNFRiL1hZK3hPQkhCdklQMHFL?=
 =?utf-8?B?bkpWdkNQcjN1N0tySVRyeWtlRkpOLytjLzRIYzVjcG95UXhONVVzQmcwK2Ji?=
 =?utf-8?B?ZGx3R3U1ZDFna0J1b3hXN0txTG9sdER2L2xBN011RkRVNW02OWpxeWRwSDVa?=
 =?utf-8?B?U2x2UzVabzBQbDhDK2daRDZGb3hzeHNvWDNTUysvMDNaYjExK3BhWkM2SzZr?=
 =?utf-8?Q?v6uEVdkijRZ0lXGRXbpe2Nd63jtpKS7d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 13:20:03.3205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae30c6e3-8b86-4046-3b1d-08dcd7e49b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529

Hi James,

On 9/17/2024 4:05 PM, James Clark wrote:
> 
> 
> On 16/09/2024 17:47, Ravi Bangoria wrote:
>> MOTIVATION
>> ----------
>>
>> Existing `perf sched` is quite exhaustive and provides lot of insights
>> into scheduler behavior but it quickly becomes impractical to use for
>> long running or scheduler intensive workload. For ex, `perf sched record`
>> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
>> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
>> generates huge 56G perf.data for which perf takes ~137 mins to prepare
>> and write it to disk [1].
>>
>> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
>> and generates samples on a tracepoint hit, `perf sched stats record` 
>> takes
>> snapshot of the /proc/schedstat file before and after the workload, i.e.
>> there is almost zero interference on workload run. Also, it takes very
>> minimal time to parse /proc/schedstat, convert it into perf samples and
>> save those samples into perf.data file. Result perf.data file is much
>> smaller. So, overall `perf sched stats record` is much more light weight
>> compare to `perf sched record`.
>>
>> We, internally at AMD, have been using this (a variant of this, known as
>> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
>> of any scheduler code changes[3][4].
>>
>> Please note that, this is not a replacement of perf sched record/report.
>> The intended users of the new tool are scheduler developers, not regular
>> users.
>>
>> USAGE
>> -----
>>
>>    # perf sched stats record
>>    # perf sched stats report
>>
>> Note: Although `perf sched stats` tool supports workload profiling syntax
>> (i.e. -- <workload> ), the recorded profile is still systemwide since the
>> /proc/schedstat is a systemwide file.
>>
>> HOW TO INTERPRET THE REPORT
>> ---------------------------
>>
>> The `perf sched stats report` starts with total time profiling was active
>> in terms of jiffies:
>>
>>    
>> ----------------------------------------------------------------------------------------------------
>>    Time elapsed (in jiffies)                                   :       
>> 24537
>>    
>> ----------------------------------------------------------------------------------------------------
>>
>> Next is CPU scheduling statistics. These are simple diffs of
>> /proc/schedstat CPU lines along with description. The report also
>> prints % relative to base stat.
>>
>> In the example below, schedule() left the CPU0 idle 98.19% of the time.
>> 16.54% of total try_to_wake_up() was to wakeup local CPU. And, the total
>> waittime by tasks on CPU0 is 0.49% of the total runtime by tasks on the
>> same CPU.
>>
>>    
>> ----------------------------------------------------------------------------------------------------
>>    CPU 0
>>    
>> ----------------------------------------------------------------------------------------------------
>>    sched_yield() count                                         
>> :           0
>>    Legacy counter can be ignored                               
>> :           0
>>    schedule() called                                           :       
>> 17138
>>    schedule() left the processor idle                          :       
>> 16827 ( 98.19% )
>>    try_to_wake_up() was called                                 
>> :         508
>>    try_to_wake_up() was called to wake up the local cpu        
>> :          84 ( 16.54% )
>>    total runtime by tasks on this processor (in jiffies)       :  
>> 2408959243
>>    total waittime by tasks on this processor (in jiffies)      :    
>> 11731825 ( 0.49% )
>>    total timeslices run on this cpu                            
>> :         311
>>    
>> ----------------------------------------------------------------------------------------------------
>>
>> Next is load balancing statistics. For each of the sched domains
>> (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
>> the following three categories:
>>
>>    1) Idle Load Balance: Load balancing performed on behalf of a long
>>                          idling CPU by some other CPU.
>>    2) Busy Load Balance: Load balancing performed when the CPU was busy.
>>    3) New Idle Balance : Load balancing performed when a CPU just became
>>                          idle.
>>
>> Under each of these three categories, sched stats report provides
>> different load balancing statistics. Along with direct stats, the
>> report also contains derived metrics prefixed with *. Example:
>>
>>    
>> ----------------------------------------------------------------------------------------------------
>>    CPU 0 DOMAIN SMT CPUS <0, 64>
>>    ----------------------------------------- <Category idle> 
>> ------------------------------------------
>>    load_balance() count on cpu idle                                 
>> :          50   $      490.74 $
>>    load_balance() found balanced on cpu idle                        
>> :          42   $      584.21 $
>>    load_balance() move task failed on cpu idle                      
>> :           8   $     3067.12 $
>>    imbalance sum on cpu idle                                        
>> :           8
>>    pull_task() count on cpu idle                                    
>> :           0
>>    pull_task() when target task was cache-hot on cpu idle           
>> :           0
>>    load_balance() failed to find busier queue on cpu idle           
>> :           0   $        0.00 $
>>    load_balance() failed to find busier group on cpu idle           
>> :          42   $      584.21 $
>>    *load_balance() success count on cpu idle                        
>> :           0
>>    *avg task pulled per successful lb attempt (cpu idle)            
>> :        0.00
>>    ----------------------------------------- <Category busy> 
>> ------------------------------------------
>>    load_balance() count on cpu busy                                 
>> :           2   $    12268.50 $
>>    load_balance() found balanced on cpu busy                        
>> :           2   $    12268.50 $
>>    load_balance() move task failed on cpu busy                      
>> :           0   $        0.00 $
>>    imbalance sum on cpu busy                                        
>> :           0
>>    pull_task() count on cpu busy                                    
>> :           0
>>    pull_task() when target task was cache-hot on cpu busy           
>> :           0
>>    load_balance() failed to find busier queue on cpu busy           
>> :           0   $        0.00 $
>>    load_balance() failed to find busier group on cpu busy           
>> :           1   $    24537.00 $
>>    *load_balance() success count on cpu busy                        
>> :           0
>>    *avg task pulled per successful lb attempt (cpu busy)            
>> :        0.00
>>    ---------------------------------------- <Category newidle> 
>> ----------------------------------------
>>    load_balance() count on cpu newly idle                           
>> :         427   $       57.46 $
>>    load_balance() found balanced on cpu newly idle                  
>> :         382   $       64.23 $
>>    load_balance() move task failed on cpu newly idle                
>> :          45   $      545.27 $
>>    imbalance sum on cpu newly idle                                  
>> :          48
>>    pull_task() count on cpu newly idle                              
>> :           0
>>    pull_task() when target task was cache-hot on cpu newly idle     
>> :           0
>>    load_balance() failed to find busier queue on cpu newly idle     
>> :           0   $        0.00 $
>>    load_balance() failed to find busier group on cpu newly idle     
>> :         382   $       64.23 $
>>    *load_balance() success count on cpu newly idle                  
>> :           0
>>    *avg task pulled per successful lb attempt (cpu newly idle)      
>> :        0.00
>>    
>> ----------------------------------------------------------------------------------------------------
>>
>> Consider following line:
>>
>>    load_balance() found balanced on cpu newly idle                  
>> :         382    $      64.23 $
>>
>> While profiling was active, the load-balancer found 382 times the load
>> needs to be balanced on a newly idle CPU 0. Following value encapsulated
>> inside $ is average jiffies between two events (24537 / 382 = 64.23).
> 
> This explanation of the $ fields is quite buried. Is there a way of 
> making it clearer with a column header in the report? I think even if it 
> was documented in the man pages it might not be that useful.
> 
Thank you for the suggestion. I will add a header in the report to 
explain what each column values are representing.

> There are also other jiffies fields that don't use $. Maybe if it was 
> like this it could be semi self documenting:
> 
> ----------------------------------------------------------------------
>      Time elapsed (in jiffies)               :        $  24537        $ 
>   ----------------------------------------------------------------------
> 
> ------------------<Category newidle> ---------------------------------
>    load_balance() count on cpu newly idle    :   427  $     57.46 avg $
> ----------------------------------------------------------------------
> 
> 
> Other than that:
> 
> Tested-by: James Clark <james.clark@linaro.org>

Ack.

--
Thanks and Regards,
Swapnil
