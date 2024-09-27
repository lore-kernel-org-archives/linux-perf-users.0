Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AE39AD6;
	Fri, 27 Sep 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435118; cv=fail; b=kfiHnCGD6A5Ch57ftQqEjNEkdcXoFKWxIIqPRldQwqSVq96Eck0b2Lti5uW73WRuLhuBHfTE4LaqunEZ+nk8vD409kzoakLbnvyFSuyVd7dOHIUMv1nvM0ptCiV/ZUhGbPeZNEIVCqYBM7z4vq8cl27t0vwaq2Wu+EYANBJLOPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435118; c=relaxed/simple;
	bh=kvU1nbWNMX1bhR0Y1mYWzur/0/0VHBnrXLg/7e/0WSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j0ibqTBa6xBY5qRLk+mO1HhnzTFiXYGo4KEoIa44qKhLjiLaieUpwf3MUz89cfyJcUBSgxLOBe+cblnQJBsnFCjHuKBG4GVsT2EOsdwpNhbwML7yUEaPn+jwYxqTZOAlcLiaxRmjqX2UuQnRXtoKjEFcRj5yWD0hF2X9/iUTZ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IykcmbZb; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IykcmbZb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZneUa4aKM6FDLX8Md3q27E/WUAKOaN7puaFYiA+B75oQvXYAbEgTVznmevJplLYKV9fnscqKZ9BurUaezPcQ7DgHg2OJHfwkF/9JLz7wCt6uByoRfdzKebKRQdefNE4TrD8/D61jTJwhcei91ndA5NXPuzHGK4H/V2mXP2alfXYrXiCJqs5Cll74V05tvxpTp+FqAM/1LY3Vfg81VKQ6tnz9GaAfrN3g6Ql3DOSo6rpRYCSZ0rGRaT2mTVVGRnJfV/7ECzpxepCdBeC0EyFQxDwDHgBNbpPXQRJMOdkss18RXMEfpCXR28XNAZ/KgLUV4lwU15fW+hcOvTg1CHpYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9cIrs+H1WDkzRglT6eftkDTMOkgCme+2aLmpRdW9FY=;
 b=UCZ8HpzhVjKdA91198/gRbR5HnNT+oNHnM6cPdQGib2WpiKchmAXrXnr00xE/tEtJfmcnSlT2J6zwfF7Ksa3DDZ5ygBEfN5uITwWhdYK3FwjSrmHKJpRfHwHtDtIImObmJJDHZLHXX7eRC1ABN98ZoK1EgBkOLPwUiVWAyUcFDOZhCOMLo1DNVDji8xej9HBasDq8ylOaYPuNIuZo4xcz0GzS2X7s0lPI1D4mY7J1yMveorahWaerfRr4ScKQMAeWAKZwl4CT97cMHnY1s85CmjrjGHzftd4PK5GIs4PaatXbs7aBhsFsmIoBOU5ml3lhk31H7DDGC/O4D6am3ICMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9cIrs+H1WDkzRglT6eftkDTMOkgCme+2aLmpRdW9FY=;
 b=IykcmbZbiPoh0EhKkPxTZ6xQMNOMurysn2Sve+L2RFPUQ600+9OyIA6Tjr4fsRQHD0XXA+Nv2+Ju4ZVwMZftV9gsKKtVO8DAJCMo/Bl//b0dV13+PyRFsjdwrz60G21Xr3J9uKBg/XS+4LocpRhhSKvbGiWcYfTWQQeXPAahyhw=
Received: from CH0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:610:e6::34)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 11:05:10 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::a5) by CH0PR03CA0299.outlook.office365.com
 (2603:10b6:610:e6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23 via Frontend
 Transport; Fri, 27 Sep 2024 11:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 11:05:08 +0000
Received: from [10.136.38.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 06:05:00 -0500
Message-ID: <3be58f74-d2d5-46a7-89ba-8a6aba1c676f@amd.com>
Date: Fri, 27 Sep 2024 16:34:45 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] perf sched stats: Add record and rawdump support
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <bristot@redhat.com>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <20240916164722.1838-3-ravi.bangoria@amd.com> <ZvT7VkSUpNFKfqge@google.com>
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <ZvT7VkSUpNFKfqge@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ef22b5-cdb9-46f1-9e96-08dcdee4400c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3pWQWEwZ3NwSzZHOUJhNjArN012Q1c0aEIwV2NzR09MU244ZmhOYkYrMC9j?=
 =?utf-8?B?Y25aRUxSYXo0TDkvQ3dEdktleGs0a2dEaGNOYXB5N2lreHEySVlwVXJWekRU?=
 =?utf-8?B?Q0MvWVdlYTlLWWdHZE5iemJEcUllbWdnd3RaNG14b3hsR3hQOVNsU1E1NndZ?=
 =?utf-8?B?SXQzTXhJUGlERnlpT1VoWEVJNEtWN2RDNk03VWpON1drWE1tR0NBQmFkTXZ3?=
 =?utf-8?B?RzIrc3hXY0xNNm5NbGVKUkFOaStGMENaNjB3Q1R2WWpkRnNGeGdJcmwvMHlP?=
 =?utf-8?B?VVlBL21wcTBCNnU5SGJrYnUrTk5TSkJBNDV1QkpLS3N6SWlIVXZnTTVhbmQx?=
 =?utf-8?B?QnE4bWxOMWI0WVlYbmhTZ0tPd1ZiUk1EYnp3T0hXMkVQWlNZYm5od25MSDhC?=
 =?utf-8?B?cmgvMTQ1dVZ4R25rWXMwdmFOQ0NhMG5vZEFnS2wrMjdSOHUvNGxWZElPTkZk?=
 =?utf-8?B?cFBCZlNXSzFJR2VMOVRNMnNnYkhuYW54d1B1a2FYMXZsY0ROY3FWSXdENFZG?=
 =?utf-8?B?Qkhra3F4SWZTOXFrVjZSWTZiL3FkR1RzRExhYmF6M3U1dDM5ZjVYVmkvdkVR?=
 =?utf-8?B?N091KzRuVUVUWXFhbHNxWDFzaGNjSWpYRDBnajZaZTdHY1dMWmlzQTlvMkdV?=
 =?utf-8?B?MUx5ZkFvRWNrdW8zRFlDdm1ZQU9DMG02ZU1MT29hR0hSUjE1ejkxRW5GRlhx?=
 =?utf-8?B?OVpKcGZCTENOQlQ2dmNUTUtvRGZCTlVjditaS1FPdFBlY2xTMUxLaXZTTmJm?=
 =?utf-8?B?ZTgvOXZIR0R1ZGlwamF3UTljM3RQRVNtMUFiOW45YmdXSVBRSVNUTENIMm9u?=
 =?utf-8?B?REJpUi9aZ1ZDQWZpdDduaU4xY0puWVR0YUlKYlE0Rm1lTDhDZGlZaWtPUHVq?=
 =?utf-8?B?TGZzeEhGbGFtbTlUdVhzWlNRSWpyVUFkZ0pyWUpBclpYcjByZFM4TnhaMFhz?=
 =?utf-8?B?aC9SUGxsVTBPblk5RzkwN2Z4MFNaSTNYTXFFQndiZjl0cktHbktiN0ZyTElR?=
 =?utf-8?B?UmJGWkUveTA0QUVTNHBMTnQ5ZFJkNFN1c2RUbTl3eGJlU2lkSXVpVE5yUmFY?=
 =?utf-8?B?cWpRTk02ZjNwWDRla0x4QjNPdHMwU2x2SEZSdGJrTGg1Ti9Qc1lBM2hzM0ZD?=
 =?utf-8?B?TzRVWE92VG1hV3RxVFFLYy9ybDhKM2dZUmtPaFlTSzFCdDA1WWFZcGh4UTR4?=
 =?utf-8?B?eHhseldYdVhJbGQ1RFFSMlRuZVQxS2tMdENhbEZEbk5xV2dBaUlwYVRJYkxI?=
 =?utf-8?B?Q3piUittNGdCTGdUNTJSUzJ3NUwvS2pwaTZKdHV6T3djUG42UTZrNFlVcnZT?=
 =?utf-8?B?VTVzUjk5NnNlTjJmczA4NHpZeU5mS1gzb1A5SE5qVHZOaVVqY21BYTg4VThl?=
 =?utf-8?B?S2QyQy9yOVpmZk5henExTGVyMjRVVVJmSVFmU0NTRUw5amFVMDRzdm95bWlR?=
 =?utf-8?B?TUk4Vjg1bjAxUnQzZ3l5NWMzUXBCVHl2Y3BESTc3SjQvWWFEVWZLdXVRaDRP?=
 =?utf-8?B?ZkVVZC9xcVlsWS80aGg0eWJoM2pockhWTlpNMC96a2I5NHVRL2wxVDJGLzR6?=
 =?utf-8?B?ZGF5eFp6akx5U0ZjcE1SYlR2eTNwYWRnTFFsRDVyb3JwTjBXRWlPeVZJbzJ6?=
 =?utf-8?B?dzZiYmFLWmdFNmY1a1o0RXV2cTRidkZacDV4MFpFaXVJY1BLQWpzOE50VTdr?=
 =?utf-8?B?VEh3U01ad1paM0FrVEVtZjdsTVc1SkduN05heUlWQlhyK1dhMW8zYjBqenl1?=
 =?utf-8?B?dUVKMFZiUnBtTkc1RERvc3prYW52N29BU1FEWmVQa280WTJ4SkluRjNkeVBs?=
 =?utf-8?B?ZGRrMHB4Z1UvK3dSZGxULzBSNjdueFBpL2REakVzYlNhSE9LWjRLeUVOdkJt?=
 =?utf-8?Q?8f9TXIfmIgwu6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 11:05:08.7465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ef22b5-cdb9-46f1-9e96-08dcdee4400c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

Hello Namhyung,

Thank you for reviewing.

On 9/26/2024 11:42 AM, Namhyung Kim wrote:
> On Mon, Sep 16, 2024 at 04:47:19PM +0000, Ravi Bangoria wrote:
>> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>
>> Define new, perf tool only, sample types and their layouts. Add logic
>> to parse /proc/schedstat, convert it to perf sample format and save
>> samples to perf.data file with `perf sched stats record` command. Also
>> add logic to read perf.data file, interpret schedstat samples and
>> print rawdump of samples with `perf script -D`.
>>
>> Note that, /proc/schedstat file output is standardized with version
>> number. The patch supports v15 but older or newer version can be added
>> easily.
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>   tools/lib/perf/Documentation/libperf.txt      |   2 +
>>   tools/lib/perf/Makefile                       |   2 +-
>>   tools/lib/perf/include/perf/event.h           |  42 +++
>>   .../lib/perf/include/perf/schedstat-cpu-v15.h |  13 +
>>   .../perf/include/perf/schedstat-domain-v15.h  |  40 +++
>>   tools/perf/builtin-inject.c                   |   2 +
>>   tools/perf/builtin-sched.c                    | 222 +++++++++++++++-
>>   tools/perf/util/event.c                       |  98 +++++++
>>   tools/perf/util/event.h                       |   2 +
>>   tools/perf/util/session.c                     |  20 ++
>>   tools/perf/util/synthetic-events.c            | 249 ++++++++++++++++++
>>   tools/perf/util/synthetic-events.h            |   3 +
>>   tools/perf/util/tool.c                        |  20 ++
>>   tools/perf/util/tool.h                        |   4 +-
>>   14 files changed, 716 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
>>   create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h
>>
>> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
>> index fcfb9499ef9c..39c78682ad2e 100644
>> --- a/tools/lib/perf/Documentation/libperf.txt
>> +++ b/tools/lib/perf/Documentation/libperf.txt
>> @@ -211,6 +211,8 @@ SYNOPSIS
>>     struct perf_record_time_conv;
>>     struct perf_record_header_feature;
>>     struct perf_record_compressed;
>> +  struct perf_record_schedstat_cpu;
>> +  struct perf_record_schedstat_domain;
>>   --
>>   
>>   DESCRIPTION
>> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
>> index 3a9b2140aa04..ebbfea891a6a 100644
>> --- a/tools/lib/perf/Makefile
>> +++ b/tools/lib/perf/Makefile
>> @@ -187,7 +187,7 @@ install_lib: libs
>>   		$(call do_install_mkdir,$(libdir_SQ)); \
>>   		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>>   
>> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
>> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
>>   INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>>   
>>   INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
>> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
>> index 37bb7771d914..35be296d68d5 100644
>> --- a/tools/lib/perf/include/perf/event.h
>> +++ b/tools/lib/perf/include/perf/event.h
>> @@ -457,6 +457,44 @@ struct perf_record_compressed {
>>   	char			 data[];
>>   };
>>   
>> +struct perf_record_schedstat_cpu_v15 {
>> +#define CPU_FIELD(_type, _name, _ver)		_type _name;
>> +#include "schedstat-cpu-v15.h"
>> +#undef CPU_FIELD
>> +};
>> +
>> +struct perf_record_schedstat_cpu {
>> +	struct perf_event_header header;
>> +	__u16			 version;
>> +	__u64			 timestamp;
>> +	__u32			 cpu;
> 
> Can you change the layout to minimize the paddings?  Probably better to
> add an explicit field for unused bits.
> 
Sure, I will change.
> 
>> +	union {
>> +		struct perf_record_schedstat_cpu_v15 v15;
>> +	};
>> +};
>> +
>> +struct perf_record_schedstat_domain_v15 {
>> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
>> +#include "schedstat-domain-v15.h"
>> +#undef DOMAIN_FIELD
>> +};
>> +
>> +#define DOMAIN_NAME_LEN		16
>> +
>> +struct perf_record_schedstat_domain {
>> +	struct perf_event_header header;
>> +	__u16			 version;
>> +	__u64			 timestamp;
>> +	__u32			 cpu;
>> +	__u16			 domain;
> 
> Ditto.

Ack.
> 
>> +	char			 name[DOMAIN_NAME_LEN];
>> +	union {
>> +		struct perf_record_schedstat_domain_v15 v15;
>> +	};
>> +	__u16			 nr_cpus;
>> +	__u8			 cpu_mask[];
>> +};
>> +
>>   enum perf_user_event_type { /* above any possible kernel type */
>>   	PERF_RECORD_USER_TYPE_START		= 64,
>>   	PERF_RECORD_HEADER_ATTR			= 64,
>> @@ -478,6 +516,8 @@ enum perf_user_event_type { /* above any possible kernel type */
>>   	PERF_RECORD_HEADER_FEATURE		= 80,
>>   	PERF_RECORD_COMPRESSED			= 81,
>>   	PERF_RECORD_FINISHED_INIT		= 82,
>> +	PERF_RECORD_SCHEDSTAT_CPU		= 83,
>> +	PERF_RECORD_SCHEDSTAT_DOMAIN		= 84,
>>   	PERF_RECORD_HEADER_MAX
>>   };
>>   
>> @@ -518,6 +558,8 @@ union perf_event {
>>   	struct perf_record_time_conv		time_conv;
>>   	struct perf_record_header_feature	feat;
>>   	struct perf_record_compressed		pack;
>> +	struct perf_record_schedstat_cpu	schedstat_cpu;
>> +	struct perf_record_schedstat_domain	schedstat_domain;
>>   };
>>   
>>   #endif /* __LIBPERF_EVENT_H */
>> diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v15.h b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
>> new file mode 100644
>> index 000000000000..8e4355ee3705
>> --- /dev/null
>> +++ b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifdef CPU_FIELD
>> +CPU_FIELD(__u32, yld_count, v15)
>> +CPU_FIELD(__u32, array_exp, v15)
>> +CPU_FIELD(__u32, sched_count, v15)
>> +CPU_FIELD(__u32, sched_goidle, v15)
>> +CPU_FIELD(__u32, ttwu_count, v15)
>> +CPU_FIELD(__u32, ttwu_local, v15)
>> +CPU_FIELD(__u64, rq_cpu_time, v15)
>> +CPU_FIELD(__u64, run_delay, v15)
>> +CPU_FIELD(__u64, pcount, v15)
>> +#endif
> 
> Can we have a single schedstat.h containing both CPU fields and domain
> fields? 

Yes, I think it is possible to have a single schedstat.h for both CPU 
and domain fields. I will think more on this.


> You might require users to define the macro always and get rid
> of the ifdef condition here.
>The later patches needed this ifdef's so I kept it. If we combine both 
cpu and domain fields, we will need this.

> Also is there any macro magic to handle the version number?  I think you
> can have the number only (15; without 'v') and compare with input if
> needed..
> 
I will think more on this, if it works out cleaner I will update in the 
next  version.

> Thanks,
> Namhyung
> 
> 
>> diff --git a/tools/lib/perf/include/perf/schedstat-domain-v15.h b/tools/lib/perf/include/perf/schedstat-domain-v15.h
>> new file mode 100644
>> index 000000000000..422e713d617a
>> --- /dev/null
>> +++ b/tools/lib/perf/include/perf/schedstat-domain-v15.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifdef DOMAIN_FIELD
>> +DOMAIN_FIELD(__u32, idle_lb_count, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_balanced, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_failed, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_imbalance, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_gained, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15)
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_count, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_balanced, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_failed, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_imbalance, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_gained, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15)
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_count, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_failed, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_gained, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15)
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15)
>> +DOMAIN_FIELD(__u32, alb_count, v15)
>> +DOMAIN_FIELD(__u32, alb_failed, v15)
>> +DOMAIN_FIELD(__u32, alb_pushed, v15)
>> +DOMAIN_FIELD(__u32, sbe_count, v15)
>> +DOMAIN_FIELD(__u32, sbe_balanced, v15)
>> +DOMAIN_FIELD(__u32, sbe_pushed, v15)
>> +DOMAIN_FIELD(__u32, sbf_count, v15)
>> +DOMAIN_FIELD(__u32, sbf_balanced, v15)
>> +DOMAIN_FIELD(__u32, sbf_pushed, v15)
>> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v15)
>> +DOMAIN_FIELD(__u32, ttwu_move_affine, v15)
>> +DOMAIN_FIELD(__u32, ttwu_move_balance, v15)
>> +#endif /* DOMAIN_FIELD */
--
Thanks and Regards,
Swapnil
