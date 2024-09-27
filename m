Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD32B9B5;
	Fri, 27 Sep 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435308; cv=fail; b=gQ9LMuzqe7cmg4YuMtJ0VsyTanz6a+loCr7UJ8m5EShlzFRWrqWug9Lz7hJCQnGWWzwJiDSjI0SFYOc63sPw6Jo9oNv62nzTyIp+GhJx2s3uztdEzi0ot1DAM5B/BUa2AO+ZaEQBJL0rjbTAFVDcFTjJd+qv9DxPURQDXN2EIyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435308; c=relaxed/simple;
	bh=96u4lo4QbWf3wRm/1lj4Qe/W1Vzue36CoHbSBah+iEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pkxKh7lIZVsdMsrePvfHcJGQqyO+jirYaN/M7ComlpQlnYDtcMib665ESqYxckZ5hzyOEtLUukyj9VXlDjJtIGTPE+7VjihNpJaWMeQCzsxo3GEFY5t2UAzgaO2tygonBdyhShYP14tND2D7m5XL+Ce3fn0pp2y+nhZoL49ukzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S6fxygLP; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S6fxygLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnTpnITvotVLi7z/UP2MJCd+K0G5z7M47qSRmV9iIpwTUDASbB5bFAZYyiqYwiME7MQpvLXhdAcJdxO4DawmH/SF9ZezadvC5pUeZRDkRC+dK0kHTckPn+TRnpvnf3L3v0SDor27EMVJOISAnKw1+9RKWm24FTYjHRfF6PatdO3an+ANucxhrq4ol49doGvfIaaymVVewABvxfCPuPyHdK7A2tBfex4V6C/NJajEzqEkgiDVaa6lm7HVQUQXe+OW7Ytc1mNd2G8u+VXOLArK87IMEx3I4p6VpfUBp8CC51dXgwRKgqnrGn6b1UGGk43pNFgd/BmneWKmbW0DV/c6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMb47/T3MYXkBzrcpoA8Lboszs/Q9rt39lHup7knp08=;
 b=d6S78FcIjghnxTo73ieILAXWepBU4CEVYJ2Wv1NfR/Yn5HzNAG4HrT/+cHFR4r3o/Y/C0bVtHWqWZvXyYTXHlgtktTaZkBd0DTifHTpamBlemQVZAFXn2fdXNWN/Cc/QsM00QtEwQV5ABDN5ZIYeudNJ2k+djTRF6YIfRjWoVps0K/TXlz3EXETqfRp7L2QuQtB/r9YBAVWhUDkeJobmUfd1wqWgVr03Zg8XOyqih9/2xgvF62LgzhWyBof2/cVHD74kLk07l4ReeNwIPEHwCa4gNfRQQ3AOAVVlRiWPiEKqxnJEMl/D7akxHe1WMEkoGYye4qKqleStw5Pm0qVJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMb47/T3MYXkBzrcpoA8Lboszs/Q9rt39lHup7knp08=;
 b=S6fxygLPY95jvT8UfLg25Ja5ifUlxeNk/ynNjU1b1vTEVPMWrJ0M6SZnC4uYDvKc5xbi4Mnm6Bucv3jnHORKJi3vLmIv2IFkMy6wOyrqX7bknbk7Gr2IQcjOHW0SKfKs1TKR2jKwSXVpmpBP3YNS8QNMcXn+rh8GeHK2FOInMBI=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 11:08:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9f) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 11:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 11:08:20 +0000
Received: from [10.136.38.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 06:08:11 -0500
Message-ID: <438e185b-b1dc-4a34-ae09-667a706aa1a3@amd.com>
Date: Fri, 27 Sep 2024 16:38:04 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] perf sched stats: Add schedstat v16 support
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
 <20240916164722.1838-4-ravi.bangoria@amd.com> <ZvT74_Sp1bQZvqbO@google.com>
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <ZvT74_Sp1bQZvqbO@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: a048ccf6-1b7f-4946-bd33-08dcdee4b278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjFwLzVETXRNRE9DWFZETFdMa0h4ZGREL1dmVDhIdE1iejAxcVR5UmFYc1VT?=
 =?utf-8?B?eXdQbk9NQVJ3cE5jRk5zK3NCRWUyVDVNQkFmRCtOQ1MwNzBCOGpPYTY5TjNJ?=
 =?utf-8?B?SklpR3NHMjRUM2JxMlByYmd1NzVlOWwraG9kb0RmdE5tQXdONUxabEsvN1pE?=
 =?utf-8?B?MWVFRnliejNTcmtnVTR0Unc0WjFaTkJ6blc5U0NaRW40d3VtM0FaSE1SSWZu?=
 =?utf-8?B?QklXRERaT1RDamUzUzJiWkZnWTBYN1haTlRXaUcwbVZ0V2ZjMkI1bUxRMEsw?=
 =?utf-8?B?VE5rbmZkeUlPeVZKb2poUDRhZ2MvVWlkVUZFd3JrbkNQUHB0RGNVQkQya2Ny?=
 =?utf-8?B?UFErUitwQnFYWS9IV1BoM3ExcGdzYWZLSHJTOVJtM0NoVTkyYkRJbWtrUHRO?=
 =?utf-8?B?dHovZkNCL1BXZUIvU1piVDZ1S0hzSW1mOFdGMVp2by94TGNiVXNRREZZb1V0?=
 =?utf-8?B?Tk5CU05vRXI0ZEZsNzRzYlJSRjE4aFNXZWVHUThRc2tJMW9Qdks3MUo0M0J0?=
 =?utf-8?B?RUt4YmZ4WWJKRE1Lb25xUStYUDlzS1pYYk9YbzMyaHhlamdSL0l3cnN5dEFY?=
 =?utf-8?B?YUFuQjg0WFgrRURYUnk4azRreURaSGgwejA2YkJpT21kM0VVblpiSDdnVm1t?=
 =?utf-8?B?VSsrTEJlWUZyUkFUZEhaT2xKN01GdGFCSkJha2ZCK3A2bzdPRml2bFZBN3hE?=
 =?utf-8?B?bmI3cys4VW1NMXVVN1JqWWRpTEFML3Q3S0Y5djlEazZUdm9aMmhWYnRPYzFv?=
 =?utf-8?B?dzNEV3E5VnMxN2JjdFkzcVA2NmxGSzhxYURWUk1FWVdkdENQV1dveWRWUGZz?=
 =?utf-8?B?bXJXNWozU2w2SnFoeHczVDVpbmptL1dFL0tsUzJCYUEwK3h3bU9OL041WWhB?=
 =?utf-8?B?NDF3MVdnTmVCRXMzS3VQdFNwZHVhUTZwbkU2M1h5UVdvVVY3T3RNS2R0UkZX?=
 =?utf-8?B?Wno4R0NnQ3dLVWxST09Wd1poZ0o4Q0s5emU3MlBMT1BZcGV3MlVHMW5HQitT?=
 =?utf-8?B?QVFhWVBGamhIYTVMUEQrdDMwVkR1UnIyRzV3ZU1jemFVM1F2ZXI1Qll1dDBm?=
 =?utf-8?B?NlpZalZnTmFRdmJ3WFoyMTVtNzIvdWthNFVva2JlNWpkMHdtckx4SFZhTDVt?=
 =?utf-8?B?QUZOR0lHZzAzWVhHMFpQeU5yRG5JbmNQdk8wSzdpWWpjMTFxVVNJZnhGem45?=
 =?utf-8?B?RUdRSzRvNC9CUVZlaW5Ra0N0b0o1aUtJT0xtLyt3MnBwbUJCVFRQZlA1NitF?=
 =?utf-8?B?WE5heXRyTFVLRndOSGlFbGxqd0YzMEZUN0pLb0svS2pqSVNlakw2dUNjM0Rh?=
 =?utf-8?B?ZUFVYWRBdlRocTB2bU1wbE5OcjRLQlk0VFpETkZTclRTTTNDenZ1OG1zSkVi?=
 =?utf-8?B?blB0Yk55YlpzdVlRKzFCOGJvOVpsZ1p5MTJITS9maTBLZ2ROUllHdkt5STRq?=
 =?utf-8?B?bGJsR2kraHhmY05OcVRXdzQzNlgwemFBVHBtNHBlTUtiZVEzRmphUm8wbEZZ?=
 =?utf-8?B?TzhnQ1BhbkZNNmFTMTZnSk5uNldhT3FtMEdaVUNhYU5Hcnd2Z2t2aVNmOVNJ?=
 =?utf-8?B?dlJic3Zwb1V3OEVtaFFPSkt5eStHQnpWRjBnZk1CWkc2a09WcEZQRXR6a1FY?=
 =?utf-8?B?R2ZPOW9mNW9WZC9HT0k0YU5PTkZ1ZC9jTlVXOE5oZEpzQ1N4VGo2WlJzUEpo?=
 =?utf-8?B?SmJOVnJoU2JpdXcwYUthVTZNaUF1Sk1TeXhMbFpxS1RUa3pTeTYxQVdLT0xt?=
 =?utf-8?B?aUNkMlduUzIyVDJxelovdGJRc2JEbXhKV2VJSjFBZVIvYXcxYXdENzAwVXo3?=
 =?utf-8?B?QU5iYk9obW54QVdwcElhVGQzenFnS1FjcTQ1cDhCaVNFa1VlUnV1akU0OTFG?=
 =?utf-8?Q?XvoSPWbe7mmEU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 11:08:20.6841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a048ccf6-1b7f-4946-bd33-08dcdee4b278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

Hello Namhyung,

On 9/26/2024 11:44 AM, Namhyung Kim wrote:
> On Mon, Sep 16, 2024 at 04:47:20PM +0000, Ravi Bangoria wrote:
>> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>
>> /proc/schedstat file output is standardized with version number.
>> Add support to record and raw dump v16 version layout.
> 
> How many difference between v15 and v16?  Can we have it in the same
> file with a different version number?
There is difference in ordering in domain fields between v15 and v16, 
busy and idle load balancing fields are interchanged. Furthermore if new 
fields are added, the parser breaks and maintaning a separate header 
file seemed cleaner.
It will be difficult to define the perf structs, if the fields are 
present in same header file.
If you any suggestion to handle this, I am all ears.

--
Thanks and Regards,
Swapnil
> 
> Thanks,
> Namhyung
> 
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>   tools/lib/perf/Makefile                       |  2 +-
>>   tools/lib/perf/include/perf/event.h           | 14 +++++++
>>   .../lib/perf/include/perf/schedstat-cpu-v16.h | 13 ++++++
>>   .../perf/include/perf/schedstat-domain-v16.h  | 40 +++++++++++++++++++
>>   tools/perf/util/event.c                       |  6 +++
>>   tools/perf/util/synthetic-events.c            |  6 +++
>>   6 files changed, 80 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v16.h
>>   create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v16.h
>>
>> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
>> index ebbfea891a6a..de0f4ffd9e16 100644
>> --- a/tools/lib/perf/Makefile
>> +++ b/tools/lib/perf/Makefile
>> @@ -187,7 +187,7 @@ install_lib: libs
>>   		$(call do_install_mkdir,$(libdir_SQ)); \
>>   		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>>   
>> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
>> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h schedstat-cpu-v16.h schedstat-domain-v16.h
>>   INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>>   
>>   INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
>> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
>> index 35be296d68d5..c332d467c9c9 100644
>> --- a/tools/lib/perf/include/perf/event.h
>> +++ b/tools/lib/perf/include/perf/event.h
>> @@ -463,6 +463,12 @@ struct perf_record_schedstat_cpu_v15 {
>>   #undef CPU_FIELD
>>   };
>>   
>> +struct perf_record_schedstat_cpu_v16 {
>> +#define CPU_FIELD(_type, _name, _ver)		_type _name;
>> +#include "schedstat-cpu-v16.h"
>> +#undef CPU_FIELD
>> +};
>> +
>>   struct perf_record_schedstat_cpu {
>>   	struct perf_event_header header;
>>   	__u16			 version;
>> @@ -470,6 +476,7 @@ struct perf_record_schedstat_cpu {
>>   	__u32			 cpu;
>>   	union {
>>   		struct perf_record_schedstat_cpu_v15 v15;
>> +		struct perf_record_schedstat_cpu_v16 v16;
>>   	};
>>   };
>>   
>> @@ -479,6 +486,12 @@ struct perf_record_schedstat_domain_v15 {
>>   #undef DOMAIN_FIELD
>>   };
>>   
>> +struct perf_record_schedstat_domain_v16 {
>> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
>> +#include "schedstat-domain-v16.h"
>> +#undef DOMAIN_FIELD
>> +};
>> +
>>   #define DOMAIN_NAME_LEN		16
>>   
>>   struct perf_record_schedstat_domain {
>> @@ -490,6 +503,7 @@ struct perf_record_schedstat_domain {
>>   	char			 name[DOMAIN_NAME_LEN];
>>   	union {
>>   		struct perf_record_schedstat_domain_v15 v15;
>> +		struct perf_record_schedstat_domain_v16 v16;
>>   	};
>>   	__u16			 nr_cpus;
>>   	__u8			 cpu_mask[];
>> diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v16.h b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
>> new file mode 100644
>> index 000000000000..f3a55131a05a
>> --- /dev/null
>> +++ b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifdef CPU_FIELD
>> +CPU_FIELD(__u32, yld_count, v16)
>> +CPU_FIELD(__u32, array_exp, v16)
>> +CPU_FIELD(__u32, sched_count, v16)
>> +CPU_FIELD(__u32, sched_goidle, v16)
>> +CPU_FIELD(__u32, ttwu_count, v16)
>> +CPU_FIELD(__u32, ttwu_local, v16)
>> +CPU_FIELD(__u64, rq_cpu_time, v16)
>> +CPU_FIELD(__u64, run_delay, v16)
>> +CPU_FIELD(__u64, pcount, v16)
>> +#endif /* CPU_FIELD */
>> diff --git a/tools/lib/perf/include/perf/schedstat-domain-v16.h b/tools/lib/perf/include/perf/schedstat-domain-v16.h
>> new file mode 100644
>> index 000000000000..d6ef895c9d32
>> --- /dev/null
>> +++ b/tools/lib/perf/include/perf/schedstat-domain-v16.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifdef DOMAIN_FIELD
>> +DOMAIN_FIELD(__u32, busy_lb_count, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_balanced, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_failed, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_imbalance, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_gained, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16)
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_count, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_balanced, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_failed, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_imbalance, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_gained, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16)
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_count, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_failed, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_gained, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16)
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16)
>> +DOMAIN_FIELD(__u32, alb_count, v16)
>> +DOMAIN_FIELD(__u32, alb_failed, v16)
>> +DOMAIN_FIELD(__u32, alb_pushed, v16)
>> +DOMAIN_FIELD(__u32, sbe_count, v16)
>> +DOMAIN_FIELD(__u32, sbe_balanced, v16)
>> +DOMAIN_FIELD(__u32, sbe_pushed, v16)
>> +DOMAIN_FIELD(__u32, sbf_count, v16)
>> +DOMAIN_FIELD(__u32, sbf_balanced, v16)
>> +DOMAIN_FIELD(__u32, sbf_pushed, v16)
>> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v16)
>> +DOMAIN_FIELD(__u32, ttwu_move_affine, v16)
>> +DOMAIN_FIELD(__u32, ttwu_move_balance, v16)
>> +#endif /* DOMAIN_FIELD */
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index c9bc8237e3fa..d138e4a5787c 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -566,6 +566,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
>>   	if (version == 15) {
>>   #include <perf/schedstat-cpu-v15.h>
>>   		return size;
>> +	} else if (version == 16) {
>> +#include <perf/schedstat-cpu-v16.h>
>> +		return size;
>>   	}
>>   #undef CPU_FIELD
>>   
>> @@ -641,6 +644,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
>>   	if (version == 15) {
>>   #include <perf/schedstat-domain-v15.h>
>>   		return size;
>> +	} else if (version == 16) {
>> +#include <perf/schedstat-domain-v16.h>
>> +		return size;
>>   	}
>>   #undef DOMAIN_FIELD
>>   
>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>> index 9d8450b6eda9..73b2492a4cde 100644
>> --- a/tools/perf/util/synthetic-events.c
>> +++ b/tools/perf/util/synthetic-events.c
>> @@ -2546,6 +2546,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
>>   
>>   	if (version == 15) {
>>   #include <perf/schedstat-cpu-v15.h>
>> +	} else if (version == 16) {
>> +#include <perf/schedstat-cpu-v16.h>
>>   	}
>>   #undef CPU_FIELD
>>   
>> @@ -2667,6 +2669,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>>   
>>   	if (version == 15) {
>>   #include <perf/schedstat-domain-v15.h>
>> +	} else if (version == 16) {
>> +#include <perf/schedstat-domain-v16.h>
>>   	}
>>   #undef DOMAIN_FIELD
>>   
>> @@ -2709,6 +2713,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
>>   
>>   	if (!strcmp(line, "version 15\n")) {
>>   		version = 15;
>> +	} else if (!strcmp(line, "version 16\n")) {
>> +		version = 16;
>>   	} else {
>>   		pr_err("Unsupported /proc/schedstat version: %s", line + 8);
>>   		goto out_free_line;
>> -- 
>> 2.46.0
>>
