Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CE1EB5FD;
	Fri, 23 Jan 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185209; cv=fail; b=K4Me1vZSY06ZZyWdzB2jTDMkJp6zFB3m/f5N8xKyhvnvtQTqxI03vkSSz5gjQpir0jOggt1RN4iZNcdUc3ddyU0C09SNvjDR03/xkk0Ej+tvZW7dPfd69Hc+rEhO6n+mwn2nHy9udNqYIlgME9D8g3oGLw2o+qrhjpIW9E3DJvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185209; c=relaxed/simple;
	bh=PHo8iyYb0VxBjUBPjvXemmF56dr2KzPlGVjDxkEszsQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JK8hob3s0mV841ZmYvCx/X+igbV2ASuV4Ks0vkUIRmIGkQffQDWRv5IBnqXnlC6KXH0tronHo2PpDPCNzcddrNPz7TSixeEFuZD55ANBy1Av9KSf9a1Th2AZoaokcQN8Du+22KaAlTbKukPpOTNhDSbBPjeees2QrDR3StQPFMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O8qqRUoK; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O8qqRUoK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuhDCtqlroYsRLjAGNwXsKpd8hh1OJlRSaWSOfoP2G6JStJoC5aVMxXabsedSVTnpHHp+/JN9Zbys+ne3PslwIwRCtTUuEBGJ1QJ1du+IHU8dpyXRfbr+s7OicyGLcFJvk91X1bGIQ8gBBQdcEM5UXsV+TACbyBLSVP1b7Dnnft4CdLOn+9CDftxbwwON5eTlyjUWoXM1m0EzHqOzYZZ6GNKTkO4EoCvKJN8NPT3oYTuhBxFk/Q79KTuWz98VVjtYo3OAn4oCnQS9fk1bHKsqVxyAp7x7GNT2Id5zgQtZw+zka6rp/QV2hzj/hi2iJoFBu3HlCbu8EzscOf3rIzPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhUnY0COzuJ9q3e9f7NR3XUX5uAW5so8LDZKEDGnGZE=;
 b=APdNaCj9NLpt2yNbRxZJvnqcbUTnjLkd7ZPqK1RHJTOk3bv9KBc5ZDDwZQdGh1wuGtwr9I3OJK7XBBAr/jsHYsfgzu4pZc0kRUABW/lZdw4NzWSDY5qu5YgXD6gydE7vHaGIcyHhGAPJ4BZYzELNghZL1rn/B7giwaD5XIjn4uoVShFy3wALp/97lZCy8IYb2g9QzepR7DsqhUiOk18ml/Z5Hj1RNUfAfGPy9Wh26AoPLn14sYWLhYQ4YN+tOg/RS7YvWE6wjiZ+NqcYXLs9rrrator7gEkeECbSksg6b2hIQ0d7sVqXJIf0E2JuId/mz2JEsCQ5Oh0udx/NXWD8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhUnY0COzuJ9q3e9f7NR3XUX5uAW5so8LDZKEDGnGZE=;
 b=O8qqRUoKYqIHXC2uCSIbDIx9AnNZUd2hQfZwOoXdlu2j5AX+BuDMlCf5QMOEux16st3RCdgZ+R/yFFfmKXuqq8TVcpYnBVpOlIFRMP5qczTM+25JWE9sHfID5aHF3n60eycmAsXOLUIcyA1ryDOxdAKuFGdWPsEaq4TuvWPSqZc=
Received: from CYXPR03CA0021.namprd03.prod.outlook.com (2603:10b6:930:d0::12)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 16:19:58 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:d0:cafe::27) by CYXPR03CA0021.outlook.office365.com
 (2603:10b6:930:d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 16:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 16:19:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 10:19:55 -0600
Received: from [10.252.192.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:19:46 -0800
Message-ID: <0778a20a-00cb-4a90-9e8e-99ff033dc23d@amd.com>
Date: Fri, 23 Jan 2026 21:49:45 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: <ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<ctshao@google.com>, <quic_zhonhan@quicinc.com>, <thomas.falcon@intel.com>,
	<blakejones@google.com>, <ashelat@redhat.com>, <leo.yan@arm.com>,
	<dvyukov@google.com>, <ak@linux.intel.com>, <yujie.liu@intel.com>,
	<graham.woodward@arm.com>, <ben.gainey@arm.com>, <vineethr@linux.ibm.com>,
	<tim.c.chen@linux.intel.com>, <linux@treblig.org>, <santosh.shukla@amd.com>,
	<sandipan.das@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <ae2b9422-d203-4fc2-ab52-e0fd86e93f39@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <ae2b9422-d203-4fc2-ab52-e0fd86e93f39@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d0620b-9a76-4533-1550-08de5a9b3f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEVJQUpGSDQ4a0tHeEw4YzJrVjV6aTZYUmNPZ1dQWHFwNExMeFFXSHhjUmFv?=
 =?utf-8?B?OXA5Ym1WYk84cWx3bzlETnNEZ3U1c2F0TkJ4TjNDSFoxWVVQdlFhbktFUnE0?=
 =?utf-8?B?UUFGUW0vMjRudHpDRmxidFNJUi94L3duTjN2NHRnbkduajVNSDZ0aFM5cHFQ?=
 =?utf-8?B?azZqN3ZOK3hOTDFFbEdRbjYyYVpGNnJHZzd1aDJxZysrMDQ1SytZYVhtcG9Q?=
 =?utf-8?B?OXNvZUoxd3d3V1BQcWxlQnF1Nzh0RUszdGxFdVBMZ21NUzBWTjdaQmNEbWdq?=
 =?utf-8?B?NE5jY0xWc0xtUzJRS1pXKy8wbStnUTBIRUNxeGZyQkJubktuK0R6eXpGTkNR?=
 =?utf-8?B?YjFibEJ3MlJ0VlZNRSt4NGtPMTZRN21CUHpsVlhQQnJ0T1hIa3BSblovSDB5?=
 =?utf-8?B?VmhXT1g1YTVLUGtRVFBhVGJrZ1ZPZzAvZ0MwQlo0c1l6TXQyVGF5ekN2d3Jk?=
 =?utf-8?B?eTJJZ3g4UVVkNTVOT3pVWk5ucnNyZkl5TWFUZEVjeS93b3BLRHErZXIrcEpT?=
 =?utf-8?B?d2pObTVJKzNjNFhnNUM3dEtrK3pka3JjL1B3WFUzZUlML3hVOVpoNmdvNHda?=
 =?utf-8?B?Q2VUa0RiRHFyRzdSZWdrcXk3cFFZNXh5djZEOUVWL2MxcThiczNHMlR5OE9q?=
 =?utf-8?B?c0J6eUFnWmMvaGl6Yjl2ZWpiU2lDTy9TWTl5OEJQcHZ1QWRaWFNOYmhISHQ4?=
 =?utf-8?B?R1VoYytHMi9qczIxeUMyeWJWRHRiY3RpSzVhRFdEeFNjYU1Ub3ZDclQyYi9B?=
 =?utf-8?B?SGxIWTlxZGZFWlRJNzhjWE03VEFWcXZ1bGMveVpqdXZFMS9jQ0FRdFpSYm9q?=
 =?utf-8?B?aWdTUmNaV0NWSVpBYXVyNkF0SG9lVmE4SkdmelpRWklyNHVtR05XZzhJaWZW?=
 =?utf-8?B?MWxCd3N3K1hsc0RHNXFIUkQyZURuenFXTnVSZzA1aUphd0tvYXRZSnIyUlZ5?=
 =?utf-8?B?eVZXYzZadGllc0VFM0hvNjduYklaVnA1c2poWnhuMTJ5QXR1K1dTL1BnWXFs?=
 =?utf-8?B?VzdpUVQ0Q3d0OHQzN1JsRUN0V2c5R0MzRmZoYkhIZEVVdGpZL1FRR1I0dDM0?=
 =?utf-8?B?NDBvNzNRQ1JMa0owdzh6SE45Tk9UMGI3anprWDlmTXBERWltSjZaYkFkL08x?=
 =?utf-8?B?OU5DeHFndW9qSWNNTU52cy9VejZQbW41SkNzWmlLZXhDZXhveStNMlc4VndW?=
 =?utf-8?B?RWVyNHlhbVpMWDUvYXVMaWpkWThwY3RzajBDdEhvL0JGcE11bC85bGx3akps?=
 =?utf-8?B?M2M1WEZuUEdIZDNWZTkvZ3NlbG0zWENpMWFwdDI2Rld2cnIxN1dRR0Z2OUdq?=
 =?utf-8?B?ZXAvQWo3ZEJySWRudlRyRko0QThWcjBDcG1mWXh4L1RBUDZpZE1XaG0rMnZS?=
 =?utf-8?B?TzBoNUJ0dDU3emV2QUxZMGxnd3ZmZUlzYzNmU3pGTzFRMWI3TEJHUVJ0V3RJ?=
 =?utf-8?B?SW1qRE1vM0w5MzdDRkZ5YlU3VTc0MEg5aUxRSnhWUzBIb0NSTXcrblVHbDZj?=
 =?utf-8?B?SGJQdURpYzBoZ1hvREJkbHo2cmxrRHg4ZVFGREdpSHpVWXV5ZWpzcHNFRG85?=
 =?utf-8?B?ZWxaWVFuMDM1emJWTFloOUpFb1g4eEtiZmZDOUdVYnNnaldCTlhDZFprSmRM?=
 =?utf-8?B?NlZiMnBFVTVWYUlZdklzUGNoVzdEZ1AwcEwvejhpMDNTVmR5VUQxeS9jUWtQ?=
 =?utf-8?B?MTQ5TmdhMW4wTHhlM0FZVWwzTUVvd0x4OHJDSElJNkhpWE1CbnNvbTJSek12?=
 =?utf-8?B?WVFrNXFnWVc1ZHVJZXB5aksrRngzK1lQak1mNEUrS1RmdDJWYnJpNkdRU3hH?=
 =?utf-8?B?NSs5MGdrZ1lQSXZTa29ic3k5TG0wcjdYRW1NNVpxcVFYVjV5UkRhTzNJaUdN?=
 =?utf-8?B?cnpBUTF1eFliTWJHY2l6MUtSY1I2YVRsWld6WTUrcTRLQklObEdIMzdlNkVN?=
 =?utf-8?B?N0IyR2FJMk9sWmZUN2FXWk5sSlhYOVNId2RzMXlrV3JkZ2NqUnJNRFZrVkh6?=
 =?utf-8?B?RDluMnJSK2JodFdkcXhYdWJ4YTgybXBpcWtxcXFnYVFaZmtxd3VUc0FSdU9L?=
 =?utf-8?B?Q3BmRFFmbW83RTVwdFUxdG1mQ0FINDJFU0JKc2NCNG1yZ2I1ekh5aVZlZW1w?=
 =?utf-8?B?V1dWNHdlMjVzTnBRNkd6WnMwb2ZWZjlrSDNsT1N4RG1JOFZKTy9BK0dUWTRE?=
 =?utf-8?B?LzV1b2hGZzhZZ2Qvb1duckJaSXJqYWpUbGpaOXlkOE9tYUdUUUpvYTRKbmJL?=
 =?utf-8?B?SUxPUnY4czc0dlcyOGNYQW5pWjN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:19:56.5942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d0620b-9a76-4533-1550-08de5a9b3f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023

Hi Shrikanth,

On 21-01-2026 23:22, Shrikanth Hegde wrote:
> 
> 
> On 1/19/26 11:28 PM, Swapnil Sapkal wrote:
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
>> of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
>> series to report the analysis[6][7].
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
>>    # perf sched stats diff
>>
>> Note: Although `perf sched stats` tool supports workload profiling syntax
>> (i.e. -- <workload> ), the recorded profile is still systemwide since the
>> /proc/schedstat is a systemwide file.
>>
>> HOW TO INTERPRET THE REPORT
>> ---------------------------
>>
>> The `perf sched stats report` starts with description of the columns
>> present in the report. These column names are given before cpu and
>> domain stats to improve the readability of the report.
>>
>>    
>> ----------------------------------------------------------------------------------------------------
>>    DESC                    -> Description of the field
>>    COUNT                   -> Value of the field
>>    PCT_CHANGE              -> Percent change with corresponding base 
>> value
>>    AVG_JIFFIES             -> Avg time in jiffies between two 
>> consecutive occurrence of event
>>    
>> ----------------------------------------------------------------------------------------------------
>>
>> Next is the total profiling time in terms of jiffies:
>>
>>    
>> ----------------------------------------------------------------------------------------------------
>>    Time elapsed (in jiffies)                                   :       
>> 24537
>>    
>> ----------------------------------------------------------------------------------------------------
>>
> 
> nit:
> Is there a way to export HZ value too here?

As per my knowledge, we can get this value from /proc/config.gz and this 
depends on 'CONFIG_IKCONFIG_PROC' being enabled.

Peter, Is it okay to export the HZ value through a debugfs file, say 
something like '/sys/kernel/debug/sched/hz_value'? Though I am not sure 
if this is useful for anythyng else.

> 
>> Next is CPU scheduling statistics. These are simple diffs of
>> /proc/schedstat CPU lines along with description. The report also
>> prints % relative to base stat.
>>
>> In the example below, schedule() left the CPU0 idle 36.58% of the time.
>> 0.45% of total try_to_wake_up() was to wakeup local CPU. And, the total
>> waittime by tasks on CPU0 is 48.70% of the total runtime by tasks on the
>> same CPU.
>>
>>    
>> ----------------------------------------------------------------------------------------------------
>>    CPU 0
>>    
>> ----------------------------------------------------------------------------------------------------
>>    
>> DESC                                                                     COUNT   PCT_CHANGE
>>    
>> ----------------------------------------------------------------------------------------------------
>>    
>> yld_count                                                        :           0
>>    
>> array_exp                                                        :           0
>>    
>> sched_count                                                      :      402267
>>    
>> sched_goidle                                                     :      147161  (    36.58% )
>>    
>> ttwu_count                                                       :      236309
>>    
>> ttwu_local                                                       :        1062  (     0.45% )
>>    rq_cpu_time                                                      :  
>> 7083791148
>>    run_delay                                                        :  
>> 3449973971  (    48.70% )
>>    
>> pcount                                                           :      255035
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
>>    CPU: 0 | DOMAIN: SMT | DOMAIN_CPUS: 0,64
>>    
>> ----------------------------------------------------------------------------------------------------
>>    
>> DESC                                                                     COUNT    AVG_JIFFIES
>>    ----------------------------------------- <Category busy> 
>> ------------------------------------------
>>    
>> busy_lb_count                                                    :         136  $       17.08 $
>>    
>> busy_lb_balanced                                                 :         131  $       17.73 $
>>    
>> busy_lb_failed                                                   :           0  $        0.00 $
>>    
>> busy_lb_imbalance_load                                           :          58
>>    
>> busy_lb_imbalance_util                                           :           0
>>    
>> busy_lb_imbalance_task                                           :           0
>>    
>> busy_lb_imbalance_misfit                                         :           0
>>    
>> busy_lb_gained                                                   :           7
>>    
>> busy_lb_hot_gained                                               :           0
>>    
>> busy_lb_nobusyq                                                  :           2  $     1161.50 $
>>    
>> busy_lb_nobusyg                                                  :         129  $       18.01 $
>>    
>> *busy_lb_success_count                                           :           5
>>    
>> *busy_lb_avg_pulled                                              :        1.40
>>    ----------------------------------------- <Category idle> 
>> ------------------------------------------
>>    
>> idle_lb_count                                                    :         449  $        5.17 $
>>    
>> idle_lb_balanced                                                 :         382  $        6.08 $
>>    
>> idle_lb_failed                                                   :           3  $      774.33 $
>>    
>> idle_lb_imbalance_load                                           :           0
>>    
>> idle_lb_imbalance_util                                           :           0
>>    
>> idle_lb_imbalance_task                                           :          71
>>    
>> idle_lb_imbalance_misfit                                         :           0
>>    
>> idle_lb_gained                                                   :          67
>>    
>> idle_lb_hot_gained                                               :           0
>>    
>> idle_lb_nobusyq                                                  :           0  $        0.00 $
>>    
>> idle_lb_nobusyg                                                  :         382  $        6.08 $
>>    
>> *idle_lb_success_count                                           :          64
>>    
>> *idle_lb_avg_pulled                                              :        1.05
>>    ---------------------------------------- <Category newidle> 
>> ----------------------------------------
>>    
>> newidle_lb_count                                                 :       30471  $        0.08 $
>>    
>> newidle_lb_balanced                                              :       28490  $        0.08 $
>>    
>> newidle_lb_failed                                                :         633  $        3.67 $
>>    
>> newidle_lb_imbalance_load                                        :           0
>>    
>> newidle_lb_imbalance_util                                        :           0
>>    
>> newidle_lb_imbalance_task                                        :        2040
>>    
>> newidle_lb_imbalance_misfit                                      :           0
>>    
>> newidle_lb_gained                                                :        1348
>>    
>> newidle_lb_hot_gained                                            :           0
>>    
>> newidle_lb_nobusyq                                               :           6  $      387.17 $
>>    
>> newidle_lb_nobusyg                                               :       26634  $        0.09 $
>>    
>> *newidle_lb_success_count                                        :        1348
>>    
>> *newidle_lb_avg_pulled                                           :        1.00
>>    
>> ----------------------------------------------------------------------------------------------------
>>
>> Consider following line:
>>
>> newidle_lb_balanced                                              :       28490  $        0.08 $
>>
>> While profiling was active, the load-balancer found 28490 times the load
>> needs to be balanced on a newly idle CPU 0. Following value encapsulated
>> inside $ is average jiffies between two events (28490 / 24537 = 0.08).
>>
> 
> Could you please explain this? I couldn't understand.
> 
> IIUC, you are parsing two instance of /proc/schedtstat,
> once in the beginning and once in the end.
> 
> newidle_lb_balanced is a counter. In the beginning every iteration could
> have decided domain is imbalanced and once load stabilized, it could have
> decided now domain is balanced more often. i.e initially counter would add
> quickly and then may stay more or less same value.
> 
> Also, what is this logic ? (28490 / 24537 = 0.08)?
> 

Thanks for catching this. This is a miss from my end while writing the 
cover letter. Here the jiffies value and the counter values are from two 
different runs. Total jiffies for the run was 2323.

The values inside $ .. $ represents per jiffie how many times this event 
has occured. The calculation here is (total_jiffies / counter_value).
In the run it is (2323 / 24537 = 0.08)

I will fix this in man page also.

--
Thanks and Regards,
Swapnil
