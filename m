Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8524502E;
	Mon, 17 Mar 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218177; cv=fail; b=c2BvkqINOKFLvssHl4aAj5tn3V0gK2nb9Xyjm5J6vz9AKwjM3rvZqxmJ5IK0fhMLu7COgR1hqvmMAF7KDtamJZ7NlYrdfxtbqDV/So7sjmxhfRLlMLa1NGFwim7L3CGwtuo5vvjOBmmeJA1kXuC1rAr/na2ONiZPT1SKx/l40nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218177; c=relaxed/simple;
	bh=Hq1QoaI+pW92JZgKYVqzHw06O6OlX2lwkx97rpaKsGQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=KO7+8OQgdgliSzHM3sUvfwMjKvABLPTjLPlF/bhDoiHhkjAKGTxzkgxUh8XXAuwgvUk2gEPtA5r8MthhklEj7RjZSNKZUNwA/d5uRG0up1yNuxPdcqs6n2snDutEC/KLjnvdiQDa27pomW++jPjI1TY5/La4/caNPOuZFqpPMbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abRj6L2m; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abRj6L2m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skDtcNkyRRsMQ5tUx/5zlQOWqddl4wHUKadWXtTt5ycHlMfSc30pdncpRIQpjSVuMr9IKHvDUq4+jfWNXrYsgXhN5Wym4Tc9xIlywJmQWpnMZE/uzMxT9yvHA4GozWvQYP2VZMRhYLL4BrTd62s3hJrtwUJS55YPObO9VSf823C/PSTLMFqTDjyhxFFc5dnQxxhZCrXk9sNlvfNWaNMc+grGg0kfmtZuYg22hYWwBiO0dpyh64XYroHMqaVxs3V9il3l7QZJWGcl5ZME5zqrb+FRT+nSFQcnHtRA/qMQ/ErJzDBcmUdFHmgt9aib6k0PL9fOaImEHxmjfwmpmVTWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K91WM/DzpQGnX7RAwDqHiut6YWM+nnQPGSquxk4hxM=;
 b=PaGvikM4upDFoYEXC9e0Osd/r+njbJoMTjFwGid4c2N83qx8ZeasRY5ud1txfxsinl/PDGQ2YllLseS5RGpSqLIbRWZYgckAVYGdaJ0xe1gbuIuQC/5nxqvaSebCYheOCywvAaU8lu6oJDllHM5C47Mak38Ghc+IBj3z2Jbwiq2JBMGwd56ws2hdTvn7Lh0dJe0L4sy/zovHDvTol4pbsPysJmOa5TApxx3BoOBUGJb3p/D5GZdwz123eEyHSdpPB75dTZ1w6OJ593Vl14gO4gyGAQb1fANbSxcAjSS7nyehOT2ZJOG+C1sMVkKF/jCXEr2sAOtp76fIMXPmcCEqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K91WM/DzpQGnX7RAwDqHiut6YWM+nnQPGSquxk4hxM=;
 b=abRj6L2m+WtuVvvGWMQn3cf8LrqH6K+X8DZmUuUEwH9T3E7cD6vVoYhvj0sG3GZf/w6H6I8FCd9C0mb0RCUJB+MPPjy5DUhpkRJMk3CQMPg36rlyWcUI8kV57K9r2KcVFbh5+rl0kFtvRmRxz1Ay0YDEIA/Q7sYSxK1FQoiHq+w=
Received: from MN2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:208:15e::17)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:29:28 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::e1) by MN2PR17CA0004.outlook.office365.com
 (2603:10b6:208:15e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.22 via Frontend Transport; Mon,
 17 Mar 2025 13:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 13:29:27 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 08:29:19 -0500
Message-ID: <e14ade22-b426-4569-a1d2-9a8c8d0bc3b0@amd.com>
Date: Mon, 17 Mar 2025 18:59:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Subject: Re: [PATCH v3 1/8] perf sched stats: Add record and rawdump support
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-2-swapnil.sapkal@amd.com> <Z9Tk-HFcMVvDViiO@google.com>
Content-Language: en-US
In-Reply-To: <Z9Tk-HFcMVvDViiO@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f961a1-37be-4ec9-5570-08dd6557bd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGRLNi9VUVVocTZmOUlUOThrS29wV29qMEd0YWtZbXVFMU5OdjdVdVBwVEVD?=
 =?utf-8?B?bGUxK2FyL3hDbTdtNjZobmZ1MWxrWktxVjk4THpDUFdsck5nZ2tIMzJHdWFn?=
 =?utf-8?B?WTcrTExKQThRTE50bjJhSDh3allXR01FbFJsNm5KanZhZm9EclAyRmcwalFM?=
 =?utf-8?B?ME93OWxtWnhNSklIL2VLL2RobS95cGZNU0tld0owa2FFRWt2bEZ3MVRoU2hv?=
 =?utf-8?B?Qzh2ZndYQWwrdGIrbk9xWnRIaHdhb0tFWnBVcVRUMTRJNWhpZDF4TVVxdWx2?=
 =?utf-8?B?V2R3dElXV05wKzVtUnlvZmFKL0luZXpsaTE3MTFmUnNoaXNaNXNUc0pGY1ZJ?=
 =?utf-8?B?S29NVkZtRlNTcHhNZS96dWVHZXNyWnpiMlFYaU44ZWVzSHlmK2xua2YyZnFs?=
 =?utf-8?B?VlVGcHZjVmNBaStPT3VJVjFmMStpdytpd0k2WGJlZzFYOHZ2K2E4aHdlK1VD?=
 =?utf-8?B?VmxwOUNDaWNjSXBRVzhmNjBXUHJQcWFicFBXd1dBU2hoMVU0bzZyOHhjb3pz?=
 =?utf-8?B?RU5OdDZlbHI0L29QUS9JMmJNV2FWcDlLNjJ3VnlxZTBYN2VZYWtsUktaT1Rz?=
 =?utf-8?B?QUxIMDRGaGs5am5QQTlWaldXSUxGZ2lCRkpXYUsxNUMyWDduS3o4NGF2cGRx?=
 =?utf-8?B?VTg1cnNDOU0rL3NFa2V1NkVTWkttSWVkZTBzUnpHQ2lTSE9yQjFZWEdUaU5F?=
 =?utf-8?B?Y3lpS3c2bWtPTXdFQ3ZsR1lGdCtyU0didzZVYi9HT3FlRXBjQTlFV2ZEblMz?=
 =?utf-8?B?bjNTQVFVZ3dyb0JFZ0JUZEl2L3YxYnh5K0dNZTFoTnIzVjhOQUZUZ2J4dnQz?=
 =?utf-8?B?VnhZM1dwMjdKUTU5dFRDTE16aWxSSHpnWDJaeE9FR3M0MlFrcnoyb05UQ2l0?=
 =?utf-8?B?eXZaWFpmcDk1TTUxN1hEc2ZmZkNaZTZqLzRTc0F3bjFaU0ozeDNuaUduVk9D?=
 =?utf-8?B?K3FCdXVvT212ZTYxQmh1SExTWnRnQ2RKOStJY0tEUzU0YnVXZytnU0JhaWd0?=
 =?utf-8?B?bGlVcW9yVWVOWkkvK3cxUmo0WDRiRisvTythMjVIQlh0UFZLUmIvK3BwalhD?=
 =?utf-8?B?NjBmUXg5NUtWTk1yRDNYYWg2M1ZlaTFNQkxQVm44R0NRZy91Q0JVRWIvSjcv?=
 =?utf-8?B?T3B1SnYyOWI3TVdEN2IrTkF0NUJFbWJ4VndlczdUeGNKM2psUXhLWDhXVjYw?=
 =?utf-8?B?bFp1NG53Tkh3bDRkelVFMldiaElSLy9SOFYxKzhOelBGQVExQUdYMWtvT3dD?=
 =?utf-8?B?WmJCWDRnekNBRDVodTNZbEcwRVF3M0E5OVhVVERrVVdiZXNDSXdFbFZKKzNC?=
 =?utf-8?B?b2tkckRLeXozNWMvS2NqM2NvSk5rY2dkQWtBQXFyWDBNYUY3SnljaDlXbEp6?=
 =?utf-8?B?TWtYejlFWHhndnRzeHJXM2R5QzNncXl6VHRrOW8zY3FYMEtkSTVEZWhKMkh0?=
 =?utf-8?B?RTRsdEgyN1doeVpIMXVsQVVLM0llOHU3NjErVVpOY1VjZHVMKzUwUlo4ZTQx?=
 =?utf-8?B?SlU1cnpyZGhEdzJ0SDlGTUVZNm11dGVzQzNNaERVS0JXVjFxUkp5UjFTYk1D?=
 =?utf-8?B?enkwckZIZWNkUlFWbmJ1SlN4eHdJNStHaUJVMWpNMUJTMlEyMmVsY0R1M1Ir?=
 =?utf-8?B?djR2N0M1dkhYem9JdkpNTS9HZzJ1aTA0aFZ5eXRoamRJcWt6WkFDRHVEMlVQ?=
 =?utf-8?B?eHJJcTU1NVJUbUJIem5vamdrbGJ1N1JZVlM2V3BUZEVqVEVkRU1IVHNmVzdh?=
 =?utf-8?B?eFpLVUpIZVJsaytlVzRFR2FtdERYWVk3Y2hwajZiQVpRRWZUTUNzeXVwSFVn?=
 =?utf-8?B?STI1OVh3dWF4ZjRya1p2NXE1MWwrVThEVWRMVzFxckc3SlJDYWRmK2RjWjFz?=
 =?utf-8?B?clNnUE5wMlNiOEpsMmhaOUVxb0RsME1MaWZDK1BxSTNWekNOZEF5OTh6dElX?=
 =?utf-8?B?V3NXOVZIalFwZTBxc1FlakNWS29mS0VmRml1MitITTZ5WlU1ZFBFbU5EZTlo?=
 =?utf-8?Q?c5IXgXQ+m5Ne2udeJo804mo89ieCVk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:29:27.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f961a1-37be-4ec9-5570-08dd6557bd9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

Hello Namhyung,

Thank you for reviewing the series.

On 3/15/2025 7:54 AM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Mar 11, 2025 at 12:02:23PM +0000, Swapnil Sapkal wrote:
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
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Tested-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/lib/perf/Documentation/libperf.txt    |   2 +
>>   tools/lib/perf/Makefile                     |   2 +-
>>   tools/lib/perf/include/perf/event.h         |  42 ++++
>>   tools/lib/perf/include/perf/schedstat-v15.h |  52 +++++
>>   tools/perf/builtin-inject.c                 |   2 +
>>   tools/perf/builtin-sched.c                  | 226 +++++++++++++++++-
>>   tools/perf/util/event.c                     |  98 ++++++++
>>   tools/perf/util/event.h                     |   2 +
>>   tools/perf/util/session.c                   |  20 ++
>>   tools/perf/util/synthetic-events.c          | 239 ++++++++++++++++++++
>>   tools/perf/util/synthetic-events.h          |   3 +
>>   tools/perf/util/tool.c                      |  20 ++
>>   tools/perf/util/tool.h                      |   4 +-
>>   13 files changed, 709 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
>>
>> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
>> index 59aabdd3cabf..3f295639903d 100644
>> --- a/tools/lib/perf/Documentation/libperf.txt
>> +++ b/tools/lib/perf/Documentation/libperf.txt
>> @@ -210,6 +210,8 @@ SYNOPSIS
>>     struct perf_record_time_conv;
>>     struct perf_record_header_feature;
>>     struct perf_record_compressed;
>> +  struct perf_record_schedstat_cpu;
>> +  struct perf_record_schedstat_domain;
>>   --
>>   
>>   DESCRIPTION
>> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
>> index e9a7ac2c062e..4b60804aa0b6 100644
>> --- a/tools/lib/perf/Makefile
>> +++ b/tools/lib/perf/Makefile
>> @@ -174,7 +174,7 @@ install_lib: libs
>>   		$(call do_install_mkdir,$(libdir_SQ)); \
>>   		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>>   
>> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
>> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h
>>   INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>>   
>>   INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
>> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
>> index 37bb7771d914..189106874063 100644
>> --- a/tools/lib/perf/include/perf/event.h
>> +++ b/tools/lib/perf/include/perf/event.h
>> @@ -457,6 +457,44 @@ struct perf_record_compressed {
>>   	char			 data[];
>>   };
>>   
>> +struct perf_record_schedstat_cpu_v15 {
>> +#define CPU_FIELD(_type, _name, _ver)		_type _name
>> +#include "schedstat-v15.h"
>> +#undef CPU_FIELD
>> +};
>> +
>> +struct perf_record_schedstat_cpu {
>> +	struct perf_event_header header;
>> +	__u64			 timestamp;
>> +	union {
>> +		struct perf_record_schedstat_cpu_v15 v15;
>> +	};
>> +	__u32			 cpu;
>> +	__u16			 version;
> 
> Why not putting these before the union?  I think it'll have variable
> size once you add different versions then it'd be hard to access the
> fields after union.  You may want to add a padding explicitly.
> 

I put these fields after the union to remove holes but your point makes
sense as we add different versions it will change. Sure, will add explicit
padding in the next version.

>> +};
>> +
>> +struct perf_record_schedstat_domain_v15 {
>> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
>> +#include "schedstat-v15.h"
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
> If this has similar information for schedstat_cpu, I think it's better
> to start with the same layout.  And having version before timestamp
> would add unnecessary paddings.
> 

Yes, It has the same information. I will keep the layout same.

> 
>> +	char			 name[DOMAIN_NAME_LEN];
>> +	union {
>> +		struct perf_record_schedstat_domain_v15 v15;
>> +	};
>> +	__u16			 nr_cpus;
>> +	__u8			 cpu_mask[];
> 
> Does cpu_mask represent the domain membership?  Maybe you can split
> those info into a separate record or put it in a header feature like
> we have topology information there.
> 

I got the idea what you are trying to say. I will think more on this and
come back.

> 
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
>> diff --git a/tools/lib/perf/include/perf/schedstat-v15.h b/tools/lib/perf/include/perf/schedstat-v15.h
>> new file mode 100644
>> index 000000000000..43f8060c5337
>> --- /dev/null
>> +++ b/tools/lib/perf/include/perf/schedstat-v15.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifdef CPU_FIELD
>> +CPU_FIELD(__u32, yld_count, v15);
>> +CPU_FIELD(__u32, array_exp, v15);
>> +CPU_FIELD(__u32, sched_count, v15);
>> +CPU_FIELD(__u32, sched_goidle, v15);
>> +CPU_FIELD(__u32, ttwu_count, v15);
>> +CPU_FIELD(__u32, ttwu_local, v15);
>> +CPU_FIELD(__u64, rq_cpu_time, v15);
>> +CPU_FIELD(__u64, run_delay, v15);
>> +CPU_FIELD(__u64, pcount, v15);
>> +#endif
>> +
>> +#ifdef DOMAIN_FIELD
>> +DOMAIN_FIELD(__u32, idle_lb_count, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_balanced, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_failed, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_imbalance, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_gained, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_count, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_balanced, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_failed, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_imbalance, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_gained, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_count, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_failed, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_gained, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15);
>> +DOMAIN_FIELD(__u32, alb_count, v15);
>> +DOMAIN_FIELD(__u32, alb_failed, v15);
>> +DOMAIN_FIELD(__u32, alb_pushed, v15);
>> +DOMAIN_FIELD(__u32, sbe_count, v15);
>> +DOMAIN_FIELD(__u32, sbe_balanced, v15);
>> +DOMAIN_FIELD(__u32, sbe_pushed, v15);
>> +DOMAIN_FIELD(__u32, sbf_count, v15);
>> +DOMAIN_FIELD(__u32, sbf_balanced, v15);
>> +DOMAIN_FIELD(__u32, sbf_pushed, v15);
>> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v15);
>> +DOMAIN_FIELD(__u32, ttwu_move_affine, v15);
>> +DOMAIN_FIELD(__u32, ttwu_move_balance, v15);
>> +#endif
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index 11e49cafa3af..af1add2abf72 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -2530,6 +2530,8 @@ int cmd_inject(int argc, const char **argv)
>>   	inject.tool.finished_init	= perf_event__repipe_op2_synth;
>>   	inject.tool.compressed		= perf_event__repipe_op4_synth;
>>   	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
>> +	inject.tool.schedstat_cpu	= perf_event__repipe_op2_synth;
>> +	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
>>   	inject.tool.dont_split_sample_group = true;
>>   	inject.session = __perf_session__new(&data, &inject.tool,
>>   					     /*trace_event_repipe=*/inject.output.is_pipe);
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 26ece6e9bfd1..1c3b56013164 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -28,6 +28,8 @@
>>   #include "util/debug.h"
>>   #include "util/event.h"
>>   #include "util/util.h"
>> +#include "util/synthetic-events.h"
>> +#include "util/target.h"
>>   
>>   #include <linux/kernel.h>
>>   #include <linux/log2.h>
>> @@ -55,6 +57,7 @@
>>   #define MAX_PRIO		140
>>   
>>   static const char *cpu_list;
>> +static struct perf_cpu_map *user_requested_cpus;
> 
> I guess this can be in evlist.
> 

Sure, Will add it in evlist.

> 
>>   static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>>   
>>   struct sched_atom;
>> @@ -236,6 +239,9 @@ struct perf_sched {
>>   	volatile bool   thread_funcs_exit;
>>   	const char	*prio_str;
>>   	DECLARE_BITMAP(prio_bitmap, MAX_PRIO);
>> +
>> +	struct perf_session *session;
>> +	struct perf_data *data;
>>   };
>>   
>>   /* per thread run time data */
>> @@ -3670,6 +3676,199 @@ static void setup_sorting(struct perf_sched *sched, const struct option *options
>>   	sort_dimension__add("pid", &sched->cmp_pid);
>>   }
>>   
>> +static int process_synthesized_schedstat_event(const struct perf_tool *tool,
>> +					       union perf_event *event,
>> +					       struct perf_sample *sample __maybe_unused,
>> +					       struct machine *machine __maybe_unused)
>> +{
>> +	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>> +
>> +	if (perf_data__write(sched->data, event, event->header.size) <= 0) {
>> +		pr_err("failed to write perf data, error: %m\n");
>> +		return -1;
>> +	}
>> +
>> +	sched->session->header.data_size += event->header.size;
>> +	return 0;
>> +}
>> +
>> +static void sighandler(int sig __maybe_unused)
>> +{
>> +}
>> +
>> +static int enable_sched_schedstats(int *reset)
>> +{
>> +	char path[PATH_MAX];
>> +	FILE *fp;
>> +	char ch;
>> +
>> +	snprintf(path, PATH_MAX, "%s/sys/kernel/sched_schedstats", procfs__mountpoint());
>> +	fp = fopen(path, "w+");
>> +	if (!fp) {
>> +		pr_err("Failed to open %s\n", path);
>> +		return -1;
>> +	}
>> +
>> +	ch = getc(fp);
>> +	if (ch == '0') {
>> +		*reset = 1;
>> +		rewind(fp);
>> +		putc('1', fp);
>> +		fclose(fp);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int disable_sched_schedstat(void)
>> +{
>> +	char path[PATH_MAX];
>> +	FILE *fp;
>> +
>> +	snprintf(path, PATH_MAX, "%s/sys/kernel/sched_schedstats", procfs__mountpoint());
>> +	fp = fopen(path, "w");
>> +	if (!fp) {
>> +		pr_err("Failed to open %s\n", path);
>> +		return -1;
>> +	}
>> +
>> +	putc('0', fp);
>> +	fclose(fp);
>> +	return 0;
>> +}
>> +
>> +/* perf.data or any other output file name used by stats subcommand (only). */
>> +const char *output_name;
>> +
>> +static int perf_sched__schedstat_record(struct perf_sched *sched,
>> +					int argc, const char **argv)
>> +{
>> +	struct perf_session *session;
>> +	struct evlist *evlist;
>> +	struct target *target;
>> +	int reset = 0;
>> +	int err = 0;
>> +	int fd;
>> +	struct perf_data data = {
>> +		.path  = output_name,
>> +		.mode  = PERF_DATA_MODE_WRITE,
>> +	};
>> +
>> +	signal(SIGINT, sighandler);
>> +	signal(SIGCHLD, sighandler);
>> +	signal(SIGTERM, sighandler);
>> +
>> +	evlist = evlist__new();
>> +	if (!evlist)
>> +		return -ENOMEM;
>> +
>> +	session = perf_session__new(&data, &sched->tool);
>> +	if (IS_ERR(session)) {
>> +		pr_err("Perf session creation failed.\n");
> 
> Also need evlist__delete().
> 

Sure, Will add it in next version.

> 
>> +		return PTR_ERR(session);
>> +	}
>> +
>> +	session->evlist = evlist;
>> +
>> +	sched->session = session;
>> +	sched->data = &data;
>> +
>> +	fd = perf_data__fd(&data);
>> +
>> +	/*
>> +	 * Capture all important metadata about the system. Although they are
>> +	 * not used by `perf sched stats` tool directly, they provide useful
>> +	 * information about profiled environment.
>> +	 */
>> +	perf_header__set_feat(&session->header, HEADER_HOSTNAME);
>> +	perf_header__set_feat(&session->header, HEADER_OSRELEASE);
>> +	perf_header__set_feat(&session->header, HEADER_VERSION);
>> +	perf_header__set_feat(&session->header, HEADER_ARCH);
>> +	perf_header__set_feat(&session->header, HEADER_NRCPUS);
>> +	perf_header__set_feat(&session->header, HEADER_CPUDESC);
>> +	perf_header__set_feat(&session->header, HEADER_CPUID);
>> +	perf_header__set_feat(&session->header, HEADER_TOTAL_MEM);
>> +	perf_header__set_feat(&session->header, HEADER_CMDLINE);
>> +	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
>> +	perf_header__set_feat(&session->header, HEADER_NUMA_TOPOLOGY);
>> +	perf_header__set_feat(&session->header, HEADER_CACHE);
>> +	perf_header__set_feat(&session->header, HEADER_MEM_TOPOLOGY);
>> +	perf_header__set_feat(&session->header, HEADER_CPU_PMU_CAPS);
>> +	perf_header__set_feat(&session->header, HEADER_HYBRID_TOPOLOGY);
>> +	perf_header__set_feat(&session->header, HEADER_PMU_CAPS);
> 
> Probably you don't need {CPU_,}PMU_CAPS.  Also I wonder if it's possible
> to add cpu-domain info here.
> 

I will skip {CPU_,}PMU_CAPS. I will think about adding cpu-domain info here.

>> +
>> +	err = perf_session__write_header(session, evlist, fd, false);
>> +	if (err < 0)
>> +		goto out;
>> +
>> +	/*
>> +	 * `perf sched stats` does not support workload profiling (-p pid)
>> +	 * since /proc/schedstat file contains cpu specific data only. Hence, a
>> +	 * profile target is either set of cpus or systemwide, never a process.
>> +	 * Note that, although `-- <workload>` is supported, profile data are
>> +	 * still cpu/systemwide.
>> +	 */
>> +	target = zalloc(sizeof(struct target));
> 
> It seems no need to alloc the target, just putting it on stack would be
> fine.
> 

Sure, Will change this.

> 
>> +	if (cpu_list)
>> +		target->cpu_list = cpu_list;
>> +	else
>> +		target->system_wide = true;
>> +
>> +	if (argc) {
>> +		err = evlist__prepare_workload(evlist, target, argv, false, NULL);
>> +		if (err)
>> +			goto out_target;
>> +	}
>> +
>> +	if (cpu_list) {
>> +		user_requested_cpus = perf_cpu_map__new(cpu_list);
> 
> Where is this freed?
> 

Will fix this.

> 
>> +		if (!user_requested_cpus)
>> +			goto out_target;
>> +	}
>> +
>> +	err = perf_event__synthesize_schedstat(&(sched->tool),
>> +					       process_synthesized_schedstat_event,
>> +					       user_requested_cpus);
>> +	if (err < 0)
>> +		goto out_target;
>> +
>> +	err = enable_sched_schedstats(&reset);
>> +	if (err < 0)
>> +		goto out_target;
>> +
>> +	if (argc)
>> +		evlist__start_workload(evlist);
>> +
>> +	/* wait for signal */
>> +	pause();
>> +
>> +	if (reset) {
>> +		err = disable_sched_schedstat();
>> +		if (err < 0)
>> +			goto out_target;
>> +	}
>> +
>> +	err = perf_event__synthesize_schedstat(&(sched->tool),
>> +					       process_synthesized_schedstat_event,
>> +					       user_requested_cpus);
>> +	if (err < 0)
>> +		goto out_target;
>> +
>> +	err = perf_session__write_header(session, evlist, fd, true);
>> +
>> +out_target:
>> +	free(target);
>> +out:
>> +	if (!err)
>> +		fprintf(stderr, "[ perf sched stats: Wrote samples to %s ]\n", data.path);
>> +	else
>> +		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
>> +
>> +	close(fd);
>> +	perf_session__delete(session);
> 
> It seems session->evlist is deleted only when the data is in read mode.
> 

Ack.

>> +
>> +	return err;
>> +}
>> +
>>   static bool schedstat_events_exposed(void)
>>   {
>>   	/*
>> @@ -3846,6 +4045,12 @@ int cmd_sched(int argc, const char **argv)
>>   	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-migration wait time"),
>>   	OPT_PARENT(sched_options)
>>   	};
>> +	const struct option stats_options[] = {
>> +	OPT_STRING('o', "output", &output_name, "file",
>> +		   "`stats record` with output filename"),
>> +	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
>> +	OPT_END()
>> +	};
>>   
>>   	const char * const latency_usage[] = {
>>   		"perf sched latency [<options>]",
>> @@ -3863,9 +4068,13 @@ int cmd_sched(int argc, const char **argv)
>>   		"perf sched timehist [<options>]",
>>   		NULL
>>   	};
>> +	const char *stats_usage[] = {
>> +		"perf sched stats {record} [<options>]",
>> +		NULL
>> +	};
>>   	const char *const sched_subcommands[] = { "record", "latency", "map",
>>   						  "replay", "script",
>> -						  "timehist", NULL };
>> +						  "timehist", "stats", NULL };
>>   	const char *sched_usage[] = {
>>   		NULL,
>>   		NULL
>> @@ -3961,6 +4170,21 @@ int cmd_sched(int argc, const char **argv)
>>   			return ret;
>>   
>>   		return perf_sched__timehist(&sched);
>> +	} else if (!strcmp(argv[0], "stats")) {
>> +		const char *const stats_subcommands[] = {"record", NULL};
>> +
>> +		argc = parse_options_subcommand(argc, argv, stats_options,
>> +						stats_subcommands,
>> +						stats_usage,
>> +						PARSE_OPT_STOP_AT_NON_OPTION);
>> +
>> +		if (argv[0] && !strcmp(argv[0], "record")) {
>> +			if (argc)
>> +				argc = parse_options(argc, argv, stats_options,
>> +						     stats_usage, 0);
>> +			return perf_sched__schedstat_record(&sched, argc, argv);
>> +		}
>> +		usage_with_options(stats_usage, stats_options);
>>   	} else {
>>   		usage_with_options(sched_usage, sched_options);
>>   	}
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index aac96d5d1917..0f863d38abe2 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -77,6 +77,8 @@ static const char *perf_event__names[] = {
>>   	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
>>   	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
>>   	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
>> +	[PERF_RECORD_SCHEDSTAT_CPU]		= "SCHEDSTAT_CPU",
>> +	[PERF_RECORD_SCHEDSTAT_DOMAIN]		= "SCHEDSTAT_DOMAIN",
>>   };
>>   
>>   const char *perf_event__name(unsigned int id)
>> @@ -550,6 +552,102 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
>>   	return ret;
>>   }
>>   
>> +size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
>> +{
>> +	struct perf_record_schedstat_cpu *cs = &event->schedstat_cpu;
>> +	__u16 version = cs->version;
>> +	size_t size = 0;
>> +
>> +	size = fprintf(fp, "\ncpu%u ", cs->cpu);
>> +
>> +#define CPU_FIELD(_type, _name, _ver)						\
>> +	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
>> +
>> +	if (version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +		return size;
>> +	}
>> +#undef CPU_FIELD
>> +
>> +	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
>> +		       event->schedstat_cpu.version);
>> +}
>> +
>> +size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
>> +{
>> +	struct perf_record_schedstat_domain *ds = &event->schedstat_domain;
>> +	__u16 version = ds->version;
>> +	size_t cpu_mask_len_2;
>> +	size_t cpu_mask_len;
>> +	size_t size = 0;
>> +	char *cpu_mask;
>> +	int idx;
>> +	int i, j;
>> +	bool low;
>> +
>> +	if (ds->name[0])
>> +		size = fprintf(fp, "\ndomain%u:%s ", ds->domain, ds->name);
>> +	else
>> +		size = fprintf(fp, "\ndomain%u ", ds->domain);
>> +
>> +	cpu_mask_len = ((ds->nr_cpus + 3) >> 2);
>> +	cpu_mask_len_2 = cpu_mask_len + ((cpu_mask_len - 1) / 8);
>> +
>> +	cpu_mask = zalloc(cpu_mask_len_2 + 1);
>> +	if (!cpu_mask)
>> +		return fprintf(fp, "Cannot allocate memory for cpumask\n");
>> +
>> +	idx = ((ds->nr_cpus + 7) >> 3) - 1;
>> +
>> +	i = cpu_mask_len_2 - 1;
>> +
>> +	low = true;
>> +	j = 1;
>> +	while (i >= 0) {
>> +		__u8 m;
>> +
>> +		if (low)
>> +			m = ds->cpu_mask[idx] & 0xf;
>> +		else
>> +			m = (ds->cpu_mask[idx] & 0xf0) >> 4;
>> +
>> +		if (m >= 0 && m <= 9)
>> +			m += '0';
>> +		else if (m >= 0xa && m <= 0xf)
>> +			m = m + 'a' - 10;
>> +		else if (m >= 0xA && m <= 0xF)
>> +			m = m + 'A' - 10;
>> +
>> +		cpu_mask[i] = m;
>> +
>> +		if (j == 8 && i != 0) {
>> +			cpu_mask[i - 1] = ',';
>> +			j = 0;
>> +			i--;
>> +		}
>> +
>> +		if (!low)
>> +			idx--;
>> +		low = !low;
>> +		i--;
>> +		j++;
>> +	}
>> +	size += fprintf(fp, "%s ", cpu_mask);
>> +	free(cpu_mask);
>> +
>> +#define DOMAIN_FIELD(_type, _name, _ver)					\
>> +	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name)
>> +
>> +	if (version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +		return size;
>> +	}
>> +#undef DOMAIN_FIELD
>> +
>> +	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
>> +		       event->schedstat_domain.version);
>> +}
>> +
>>   size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp)
>>   {
>>   	size_t ret = fprintf(fp, "PERF_RECORD_%s",
>> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
>> index 2744c54f404e..333f2405cd5a 100644
>> --- a/tools/perf/util/event.h
>> +++ b/tools/perf/util/event.h
>> @@ -361,6 +361,8 @@ size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
>>   size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>>   size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
>>   size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
>> +size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp);
>> +size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp);
>>   size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
>>   
>>   int kallsyms__get_function_start(const char *kallsyms_filename,
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index c06e3020a976..bcffee2b7239 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -692,6 +692,20 @@ static void perf_event__time_conv_swap(union perf_event *event,
>>   	}
>>   }
>>   
>> +static void
>> +perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
>> +			       bool sample_id_all __maybe_unused)
>> +{
>> +	/* FIXME */
>> +}
>> +
>> +static void
>> +perf_event__schedstat_domain_swap(union perf_event *event __maybe_unused,
>> +				  bool sample_id_all __maybe_unused)
>> +{
>> +	/* FIXME */
>> +}
>> +
>>   typedef void (*perf_event__swap_op)(union perf_event *event,
>>   				    bool sample_id_all);
>>   
>> @@ -730,6 +744,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>>   	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
>>   	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
>>   	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
>> +	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
>> +	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
>>   	[PERF_RECORD_HEADER_MAX]	  = NULL,
>>   };
>>   
>> @@ -1455,6 +1471,10 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>>   		return err;
>>   	case PERF_RECORD_FINISHED_INIT:
>>   		return tool->finished_init(session, event);
>> +	case PERF_RECORD_SCHEDSTAT_CPU:
>> +		return tool->schedstat_cpu(session, event);
>> +	case PERF_RECORD_SCHEDSTAT_DOMAIN:
>> +		return tool->schedstat_domain(session, event);
>>   	default:
>>   		return -EINVAL;
>>   	}
>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>> index 6923b0d5efed..f928f07bea15 100644
>> --- a/tools/perf/util/synthetic-events.c
>> +++ b/tools/perf/util/synthetic-events.c
>> @@ -2511,3 +2511,242 @@ int parse_synth_opt(char *synth)
>>   
>>   	return ret;
>>   }
>> +
>> +static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version,
>> +						    __u64 *cpu, __u64 timestamp)
>> +{
>> +	struct perf_record_schedstat_cpu *cs;
>> +	union perf_event *event;
>> +	size_t size;
>> +	char ch;
>> +
>> +	size = sizeof(struct perf_record_schedstat_cpu);
> 
> I think the kernel code prefers sizeof(*cs) instead.
> 

Sure, Will change accordingly.

> 
>> +	size = PERF_ALIGN(size, sizeof(u64));
>> +	event = zalloc(size);
> 
> The size is static, do you really need a dynamic allocation?
> 

Will make event static.

> Thanks,
> Namhyung
> 
--
Thanks and Regards,
Swapnil
