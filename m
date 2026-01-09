Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128930EF7F;
	Fri,  9 Jan 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957931; cv=fail; b=Y/3QrFKXJbEYmZkoGuTsy2Ho9+BsDupgDHnAYg5J9fos2hHUgVbi/PRGBEbfUGhpBemMtAWRMUIIFGIzCd8zotFtVrSk2vc8M+4f9Zx9xLMwQBWd34gDM12Wop+g5pV6rtlBtrBoXiZlHCYG9oUh8aRpCfgALPHMi8BZDjnStRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957931; c=relaxed/simple;
	bh=ayMs7rTrr+basmWiqnfr8YqzPWoHnegCM62R+EXmygk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U2AYsQcvcMw7Xxu9gNWVkch/eVQtFcsn0Da2D3I3aly4VlGrmI7n4KE3NRqDPcb5wOfa0+UPgpOhH6rAa/ty6LCkzjf1sd0rVP7KjdN9dWH+5wYHqukK24OoCsN+qNpCSjjsfhCdgMQsAPem5VBNtm5fNFesW7G1yyfWLFpPMQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qdqe9MWk; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qdqe9MWk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx9OtIDT9P1h2u01iHPVtEbkbVomzHuA3LR+D3WvoJL/hjrfsTbT01NiQIppAPS+WjxDn/a8bH4KDJAgWHWOeZdY5iA8uH82c4JxG0Gu5UupC7FgQLL2LSu0W9Ov9wM1UsZ91fPvxpagnELUIWz8bCWVujndOPCJ/p5HdIh2e5yhPO5XYHDeJGG0U+r4oVOfYmy8DON+zc5n+zibhkA9kdipIX4J+M08L2HoET+Sk69fL7YwITc1J9rk45w1M6g086WwB258ORWtjkV/3sNvfwMHuvrOKhPdcqXgeIkWdm1xiAjx3PgizOnUXD2kBducfJd3Aezl4Ty8UIrW09XQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JucarmgM61ZZz39abVmKCgy4MqvBXK20sMprfGBqb8=;
 b=fFoIpyOChrZlygmhVABP0n0GFeP0HZJ8+hKI0GjeOF0u08d9Bwn3j1Z0WsC38qPLYfXYzO2sGEnuvn+VU9KK0H7FWcNdNZKqZKvw7tmO/Jzxps78//zHtLvbKB7MkirQS12u6Hl1UaYDEm7nT10652c2cGCYzBOqIbuBPZH/xgPESyTQ/7ZgiJpH7Rtfe35DujgCsMUemSeElpduYA71bnEAZCj/PMqWxM/IZ8fcRrVHr8vuYhFTwFe+OJjgcp01ify43mb/kH6qwKBOm8rJuXZGTJwbGFMRNLEC8HthH9NBaYvvsrBR5LTYv2DxiDRxPOqKzqIPgXCk99qpzTtP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JucarmgM61ZZz39abVmKCgy4MqvBXK20sMprfGBqb8=;
 b=qdqe9MWkMwLCkndQJJv6YXbLphuQwlgYZHoSvdJH14+DKYrjxagUMfg8D/nSG9tZ96UGFkaem/qhrEs9QUOSJJJcqwshSz8psNhvKP3Mi7rn9sTiMTXJxQ1TeGoeoM8PHg8YRXBs+RFfNlTwPLJFmvPP8YutXPf/kFEPfiNwGJQ=
Received: from SA1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:2ce::26)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 11:25:20 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::df) by SA1PR04CA0019.outlook.office365.com
 (2603:10b6:806:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 11:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 11:25:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 05:25:19 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 03:25:19 -0800
Received: from [10.136.42.229] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 03:25:07 -0800
Message-ID: <4e9d2241-0794-43c5-b13c-49e86e5f83ed@amd.com>
Date: Fri, 9 Jan 2026 16:55:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 07/11] perf sched stats: Add support for report
 subcommand
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
 <20250909114227.58802-8-swapnil.sapkal@amd.com> <aVhIJmmPGqa77YFR@google.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aVhIJmmPGqa77YFR@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: a2546676-9f59-4f8c-b7da-08de4f71c5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUpoVjRreTNNeVBrMXBXL3NraGFJY1ZTb1VobU82VW9iRk5sb0loUzFZZldh?=
 =?utf-8?B?YVdRYlE1RUgzM3pPSXdyLy9lUnlNNXRmRzYvQ2gyQ2NUWktKQXpRNlJoNUtS?=
 =?utf-8?B?VkorNGRIRU9rM0UvcE9LWWtVRjhmSENickVUTXlDWUJBWVZYenhndm0xSGpo?=
 =?utf-8?B?TnJZbFFmUkptdnpDQ3BEcEpnU0xuc3VhMDVFdUNUbi9XQk1EeUtjalgwWkVL?=
 =?utf-8?B?R2RXczBnYzZOeVJla1dvVEtqaElmb3RlQzFBUWh4TGkwYTdMVmN4OGl2Wlg0?=
 =?utf-8?B?TzNPaThBV001QUYrS2N0Zm1kNUxtVkpvbkUrSXBjMVZ3eXNIckdML1RaK0JR?=
 =?utf-8?B?aU1KdDFGVEJhR2NxTk5POUVGQ2t6azFrRk5JV2NGZXNneHJqZ2FMTk9ZREdk?=
 =?utf-8?B?N290VjhxbGRwL1pGd2RiU1NFNldEVEZvbWFrdDZsekNSZE1RK0NoNlIxS21P?=
 =?utf-8?B?ZlVkdHhxMFI5YTVJZ3BsMGk4MnZIVkN3cUFUdDl4V1p2R3FBMFZqMWJSRnFt?=
 =?utf-8?B?Q0prUXpGUTdGSWpkdGRUYVNjOE51Q3E0Tk9zWlZ2aXU0U29pYW9TN1dBRmMy?=
 =?utf-8?B?YUNXam9XWGw3UitrYVdMVSt3OFFpNlhXT0J6ZmxyZ04zVGVxaDEzOE1QeDVw?=
 =?utf-8?B?UHVsWkhUUE9jZWZZZGtQdnZ5djdxdDRTdE50MDlmYzZpSUxkUnI0Y3ZuWEVW?=
 =?utf-8?B?WnhyR3FWSEpDYzNJNkFVazF3WkVUNm8zUEhiSDRMUTNCZGsrN1YzLytiY0lQ?=
 =?utf-8?B?VmhURU96Qm9jRW9uNE5aeGkyNmNnalpsSUcvUlNmQ1l5cTMvbHp0dGdEdUkv?=
 =?utf-8?B?Y0VwdXlwYkpUSTdrWnkxTjN5NDNmTXRvanVseEVyWG9SOS9vMVh4RVZYK2Y5?=
 =?utf-8?B?RXplRWxBR3lFcjZRQ1p5RDN3UEd6NjNMZ0pFQ2RlTVhHbGNXcEdqU1gvMnpa?=
 =?utf-8?B?WHRzQVQ1TXRaeFgzTTh4Z1Z4dFNaSTMyUGlrRFNWM2NTOTREYjZGU1ArZDdh?=
 =?utf-8?B?TXFKVTluL0tnazdma1MrNHhsSWVrY1RvYzdpQjZ5aVQ4VGVSbFF3MzV6SjAy?=
 =?utf-8?B?Q2o0ZEJnakF2a00zUHJXVmZFVlpqZThPV0UzdzVjUG12a1Fid2RCeVpFMUJh?=
 =?utf-8?B?Uk00d01Qc01VdG9id2lwUHVsNEtDclFFUSt0Y2JzMVFDRVFtSlNkVVJKS00r?=
 =?utf-8?B?QVg0VUJUWWNxOHAvNk1CYWZDRWRQZFZHdHc4NFE4emt0YVZnZnZsK000QmE0?=
 =?utf-8?B?amlKOWhIQ25JV1hLWVVmaTRXZ3VFRjBIbnBSbjNHSGRRRFQ1OHdXTnN0MytV?=
 =?utf-8?B?Qnp2RmlZdTE0T2IyWWVLWlFNMVY2bVY4d0Y0aHh6aVN0QmZDejJlY2N4TC9n?=
 =?utf-8?B?SlZsV0plZVIydy8wUEhJUi9JekZpWHp3ZVF3YVI1ZjQ3WnU5Z3UxcUhJOEdH?=
 =?utf-8?B?UUJJNC9TRnhtRm9CYld1OTdKNUlQeHBhWmMraTkrc1VIalBKYjM4T2dtVEF5?=
 =?utf-8?B?c0kxdXN2blRyVHFuUlpzM0tjS2pWanZmeGxSY0hCSUF2ZXZqSE14VXNYdncz?=
 =?utf-8?B?VElmZmlsR0RjUnhxMk9OS3d1SVBuT1NTcVpxUTJpVUl6Vm9GVlJYU2QvckNO?=
 =?utf-8?B?MDN4S2dXb0VJOFZ1U2dBYlFpOEtmMEliMi9rRlFvc3FqOWZDSk4vbm9iYmZ2?=
 =?utf-8?B?b0FHT0xjdkp6SlJPMzRRZkd6ZXV6SEN6ZEt3ZmlVTnJLRFpqemROZU80OUth?=
 =?utf-8?B?VDZTOEhXQllPQTBhRUtESUpaZE9XY281bDJUQkpmYlcwMmN3NWY3clhPbW9V?=
 =?utf-8?B?TUx1aVQ5eDdCSzI2bUk4WDk2N2RUNkFYeStUcHFkY0JYTFJkTyt5NVpobUNV?=
 =?utf-8?B?eUh3MFRBTXdMTFBRcmZ2dTFKSnJGYWJ0UVRKUjJ2LzZkOE83elVjMEVNdUoy?=
 =?utf-8?B?aFZ6dWcvb2IzejY0dkxFTEpKVURuMmRLVGZpdnQzbGFJSzZYMThMSlZKd2Vh?=
 =?utf-8?B?b1BHTFN5UWViOTZ5UGdZaTZHY0FmemNXNnBpOGN3dWFmWEtmbWw5Z0tPTVVY?=
 =?utf-8?B?WGcyWFd5dmZianhzemFuSjBjL2swZzgwdDZqQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:25:20.1036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2546676-9f59-4f8c-b7da-08de4f71c5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

Hello Namhyung,

On 03-01-2026 04:05, Namhyung Kim wrote:
> On Tue, Sep 09, 2025 at 11:42:23AM +0000, Swapnil Sapkal wrote:
>> `perf sched stats record` captures two sets of samples. For workload
>> profile, first set right before workload starts and second set after
>> workload finishes. For the systemwide profile, first set at the
>> beginning of profile and second set on receiving SIGINT signal.
>>
>> Add `perf sched stats report` subcommand that will read both the set
>> of samples, get the diff and render a final report. Final report prints
>> scheduler stat at cpu granularity as well as sched domain granularity.
>>
>> Example usage:
>>
>>    # perf sched stats record
>>    # perf sched stats report
> 
> It'd be great if you could add an example output as well.
> 

Sure, will do.

>>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Tested-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/perf/builtin-sched.c | 509 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 508 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 2573491fa5f8..e23018798f5b 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3940,6 +3940,505 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
>>   	return err;
>>   }
>>   
>> +struct schedstat_domain {
>> +	struct list_head domain_list;
>> +	struct perf_record_schedstat_domain *domain_data;
>> +};
>> +
>> +struct schedstat_cpu {
>> +	struct list_head cpu_list;
>> +	struct list_head domain_head;
>> +	struct perf_record_schedstat_cpu *cpu_data;
>> +};
>> +
>> +static struct list_head cpu_head = LIST_HEAD_INIT(cpu_head);
>> +static struct schedstat_cpu *cpu_second_pass;
>> +static struct schedstat_domain *domain_second_pass;
>> +static bool after_workload_flag;
>> +static bool verbose_field;
>> +
>> +static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
>> +{
>> +	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
>> +	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
>> +	__u16 version = after_workload->cpu_data->version;
>> +
>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
>> +	(before->_ver._name = after->_ver._name - before->_ver._name)
>> +
>> +	if (version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +
>> +#undef CPU_FIELD
>> +}
>> +
>> +static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
>> +{
>> +	struct perf_record_schedstat_domain *before = domain_second_pass->domain_data;
>> +	struct perf_record_schedstat_domain *after = after_workload->domain_data;
>> +	__u16 version = after_workload->domain_data->version;
>> +
>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
>> +	(before->_ver._name = after->_ver._name - before->_ver._name)
>> +
>> +	if (version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +#undef DOMAIN_FIELD
>> +}
>> +
>> +static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
>> +{
>> +	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
>> +	printf("%.*s\n", 100, graph_dotted_line);
>> +
>> +#define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
>> +
>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
>> +	do {									\
>> +		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
>> +		       cs->_ver._name);						\
>> +		if (_is_pct) {							\
>> +			printf("  ( %8.2lf%% )",				\
>> +			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
>> +		}								\
>> +		printf("\n");							\
>> +	} while (0)
>> +
>> +	if (cs->version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (cs->version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (cs->version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +
>> +#undef CPU_FIELD
>> +#undef CALC_PCT
>> +}
>> +
>> +static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
>> +				      __u64 jiffies)
>> +{
>> +	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
>> +
>> +#define DOMAIN_CATEGORY(_desc)							\
>> +	do {									\
>> +		size_t _len = strlen(_desc);					\
>> +		size_t _pre_dash_cnt = (100 - _len) / 2;			\
>> +		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
>> +		print_separator((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
>> +	} while (0)
>> +
>> +#define CALC_AVG(_x, _y)	((_y) ? (long double)(_x) / (_y) : 0.0)
>> +
>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
>> +	do {									\
>> +		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
>> +		       ds->_ver._name);						\
>> +		if (_is_jiffies) {						\
>> +			printf("  $ %11.2Lf $",					\
>> +			       CALC_AVG(jiffies, ds->_ver._name));		\
>> +		}								\
>> +		printf("\n");							\
>> +	} while (0)
>> +
>> +#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
>> +	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
>> +	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
>> +
>> +#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
>> +	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
>> +	       CALC_AVG(ds->_ver._w,						\
>> +			((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
>> +
>> +	if (ds->version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (ds->version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (ds->version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +
>> +#undef DERIVED_AVG_FIELD
>> +#undef DERIVED_CNT_FIELD
>> +#undef DOMAIN_FIELD
>> +#undef CALC_AVG
>> +#undef DOMAIN_CATEGORY
>> +}
>> +
>> +static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
>> +				    struct schedstat_cpu *cptr,
>> +				    int cnt, bool is_last)
>> +{
>> +	struct perf_record_schedstat_cpu *summary_cs = summary_cpu->cpu_data,
>> +					 *temp_cs = cptr->cpu_data;
>> +
>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
>> +	do {									\
>> +		summary_cs->_ver._name += temp_cs->_ver._name;			\
>> +		if (is_last)							\
>> +			summary_cs->_ver._name /= cnt;				\
>> +	} while (0)
>> +
>> +	if (cptr->cpu_data->version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (cptr->cpu_data->version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (cptr->cpu_data->version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +#undef CPU_FIELD
>> +}
>> +
>> +static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
>> +				       struct schedstat_domain *dptr,
>> +				       int cnt, bool is_last)
>> +{
>> +	struct perf_record_schedstat_domain *summary_ds = summary_domain->domain_data,
>> +					    *temp_ds = dptr->domain_data;
>> +
>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
>> +	do {									\
>> +		summary_ds->_ver._name += temp_ds->_ver._name;			\
>> +		if (is_last)							\
>> +			summary_ds->_ver._name /= cnt;				\
>> +	} while (0)
>> +
>> +	if (dptr->domain_data->version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (dptr->domain_data->version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (dptr->domain_data->version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +#undef DOMAIN_FIELD
>> +}
>> +
>> +static int get_all_cpu_stats(struct list_head *head)
>> +{
>> +	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
>> +	struct schedstat_cpu *summary_head = NULL;
>> +	struct perf_record_schedstat_domain *ds;
>> +	struct perf_record_schedstat_cpu *cs;
>> +	struct schedstat_domain *dptr, *tdptr;
>> +	bool is_last = false;
>> +	int cnt = 1;
>> +	int ret = 0;
>> +
>> +	if (cptr) {
>> +		summary_head = zalloc(sizeof(*summary_head));
>> +		if (!summary_head)
>> +			return -ENOMEM;
>> +
>> +		summary_head->cpu_data = zalloc(sizeof(*cs));
>> +		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
>> +
>> +		INIT_LIST_HEAD(&summary_head->domain_head);
>> +
>> +		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>> +			tdptr = zalloc(sizeof(*tdptr));
>> +			if (!tdptr)
>> +				return -ENOMEM;
>> +
>> +			tdptr->domain_data = zalloc(sizeof(*ds));
>> +			if (!tdptr->domain_data)
>> +				return -ENOMEM;
> 
> Please free tdptr too.
> 

Ack.

>> +
>> +			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
>> +			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
>> +		}
>> +	}
>> +
>> +
>> +	list_for_each_entry(cptr, head, cpu_list) {
>> +		if (list_is_first(&cptr->cpu_list, head))
>> +			continue;
>> +
>> +		if (list_is_last(&cptr->cpu_list, head))
>> +			is_last = true;
>> +
>> +		cnt++;
>> +		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
>> +		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
>> +					 domain_list);
>> +
>> +		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>> +			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
>> +			tdptr = list_next_entry(tdptr, domain_list);
>> +		}
>> +	}
>> +
>> +	list_add(&summary_head->cpu_list, head);
>> +
>> +	return ret;
>> +}
>> +
>> +static void print_field_description(struct schedstat_cpu *cptr)
>> +{
>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
>> +		printf("%-30s-> %s\n", #_name, _desc)				\
>> +
>> +#define DOMAIN_CATEGORY(_desc)							\
>> +	do {									\
>> +		size_t _len = strlen(_desc);					\
>> +		size_t _pre_dash_cnt = (100 - _len) / 2;			\
>> +		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
>> +		print_separator((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
>> +	} while (0)
>> +
>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
>> +		printf("%-30s-> %s\n", #_name, _desc)				\
>> +
>> +#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
>> +		printf("*%-29s-> %s\n", #_name, _desc)				\
>> +
>> +#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
>> +		printf("*%-29s-> %s\n", #_name, _desc)				\
>> +
>> +	if (cptr->cpu_data->version == 15) {
>> +#include <perf/schedstat-v15.h>
>> +	} else if (cptr->cpu_data->version == 16) {
>> +#include <perf/schedstat-v16.h>
>> +	} else if (cptr->cpu_data->version == 17) {
>> +#include <perf/schedstat-v17.h>
>> +	}
>> +#undef CPU_FIELD
>> +#undef DOMAIN_CATEGORY
>> +#undef DERIVED_CNT_FIELD
>> +#undef DERIVED_AVG_FIELD
>> +#undef DOMAIN_FIELD
>> +}
>> +
>> +static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **cd_map)
>> +{
>> +	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
>> +	__u64 jiffies = cptr->cpu_data->timestamp;
>> +	struct perf_record_schedstat_domain *ds;
>> +	struct perf_record_schedstat_cpu *cs;
>> +	struct schedstat_domain *dptr;
>> +	bool is_summary = true;
>> +	int ret = 0;
>> +
>> +	printf("Description\n");
>> +	print_separator(100, "", 0);
>> +	printf("%-30s-> %s\n", "DESC", "Description of the field");
>> +	printf("%-30s-> %s\n", "COUNT", "Value of the field");
>> +	printf("%-30s-> %s\n", "PCT_CHANGE", "Percent change with corresponding base value");
>> +	printf("%-30s-> %s\n", "AVG_JIFFIES",
>> +	       "Avg time in jiffies between two consecutive occurrence of event");
>> +
>> +	if (!verbose_field) {
>> +		print_separator(100, "", 0);
>> +		print_field_description(cptr);
>> +	}
>> +
>> +	print_separator(100, "", 0);
>> +	printf("\n");
>> +
>> +	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
>> +	print_separator(100, "", 0);
>> +
>> +	ret = get_all_cpu_stats(head);
>> +
>> +	list_for_each_entry(cptr, head, cpu_list) {
>> +		cs = cptr->cpu_data;
>> +		printf("\n");
>> +		print_separator(100, "", 0);
>> +
>> +		if (is_summary)
>> +			printf("CPU <ALL CPUS SUMMARY>\n");
>> +		else
>> +			printf("CPU %d\n", cs->cpu);
>> +
>> +		print_separator(100, "", 0);
>> +		print_cpu_stats(cs);
>> +		print_separator(100, "", 0);
>> +
>> +		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>> +			struct domain_info *dinfo;
>> +
>> +			ds = dptr->domain_data;
>> +			dinfo = cd_map[ds->cpu]->domains[ds->domain];
>> +			if (is_summary)
> 
> Please add a pair of braces for multiline statements.
> 

Ack.

> 
>> +				if (dinfo->dname)
>> +					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo->dname);
>> +				else
>> +					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo->domain);
>> +			else {
>> +				if (dinfo->dname)
>> +					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, dinfo->dname);
>> +				else
>> +					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, dinfo->domain);
>> +
>> +				printf("%s\n", dinfo->cpulist);
>> +			}
>> +			print_separator(100, "", 0);
>> +			print_domain_stats(ds, jiffies);
>> +			print_separator(100, "", 0);
>> +		}
>> +		is_summary = false;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int perf_sched__process_schedstat(struct perf_session *session __maybe_unused,
>> +					 union perf_event *event)
>> +{
>> +	struct perf_cpu this_cpu;
>> +	static __u32 initial_cpu;
>> +
>> +	switch (event->header.type) {
>> +	case PERF_RECORD_SCHEDSTAT_CPU:
>> +		this_cpu.cpu = event->schedstat_cpu.cpu;
>> +		break;
>> +	case PERF_RECORD_SCHEDSTAT_DOMAIN:
>> +		this_cpu.cpu = event->schedstat_domain.cpu;
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
>> +		return 0;
>> +
>> +	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
>> +		struct schedstat_cpu *temp = zalloc(sizeof(*temp));
>> +
>> +		if (!temp)
>> +			return -ENOMEM;
>> +
>> +		temp->cpu_data = zalloc(sizeof(*temp->cpu_data));
>> +		if (!temp->cpu_data)
>> +			return -ENOMEM;
> 
> Please free temp as well.
> 

Ack.

>> +
>> +		memcpy(temp->cpu_data, &event->schedstat_cpu, sizeof(*temp->cpu_data));
>> +
>> +		if (!list_empty(&cpu_head) && temp->cpu_data->cpu == initial_cpu)
>> +			after_workload_flag = true;
>> +
>> +		if (!after_workload_flag) {
>> +			if (list_empty(&cpu_head))
>> +				initial_cpu = temp->cpu_data->cpu;
>> +
>> +			list_add_tail(&temp->cpu_list, &cpu_head);
>> +			INIT_LIST_HEAD(&temp->domain_head);
>> +		} else {
>> +			if (temp->cpu_data->cpu == initial_cpu) {
>> +				cpu_second_pass = list_first_entry(&cpu_head, struct schedstat_cpu,
>> +								   cpu_list);
>> +				cpu_second_pass->cpu_data->timestamp =
>> +					temp->cpu_data->timestamp - cpu_second_pass->cpu_data->timestamp;
>> +			} else {
>> +				cpu_second_pass = list_next_entry(cpu_second_pass, cpu_list);
>> +			}
>> +			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
>> +							      struct schedstat_domain, domain_list);
>> +			store_schedtstat_cpu_diff(temp);
>> +			free(temp);
> 
> What about temp->cpu_data?
> 

Sure, will free it.

> 
>> +		}
>> +	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
>> +		struct schedstat_cpu *cpu_tail;
>> +		struct schedstat_domain *temp = zalloc(sizeof(*temp));
>> +
>> +		if (!temp)
>> +			return -ENOMEM;
>> +
>> +		temp->domain_data = zalloc(sizeof(*temp->domain_data));
>> +		if (!temp->domain_data)
>> +			return -ENOMEM;
> 
> Ditto.
> 

Ack.

>> +
>> +		memcpy(temp->domain_data, &event->schedstat_domain, sizeof(*temp->domain_data));
>> +
>> +		if (!after_workload_flag) {
>> +			cpu_tail = list_last_entry(&cpu_head, struct schedstat_cpu, cpu_list);
>> +			list_add_tail(&temp->domain_list, &cpu_tail->domain_head);
>> +		} else {
>> +			store_schedstat_domain_diff(temp);
>> +			domain_second_pass = list_next_entry(domain_second_pass, domain_list);
>> +			free(temp);
> 
> Ditto.
> 

Ack.

--
Thanks and Regards,
Swapnil

> Thanks,
> Namhyung
> 
