Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B936E496;
	Mon, 19 Jan 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847764; cv=fail; b=QO6/mFnyg24r30ZcErokvwwqXvJKuRb9of5Rc2vm4ySMTQh+lR39Fc5RokUjJ2uqJfIlsLZGE5O63Sbryjnj/rL/jXoa+sIy9J7Zc3j5IAyihUSr9fGKblRnmgQTy1LPxoaNByfbdg80g/voUIHL4WQEATtIPWGxBHMDpTxbpkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847764; c=relaxed/simple;
	bh=TS0IQfw8wxEtINFZ71x5Uz+8in1K9gONj31vjLFc4qI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=XYFHlGeRH3NAhihfsWDWzO9pSd7KDH/Pf9yRoQaQfq+GXQ/CS7QU1l6Ud4K+q/+1vvPTC6snNRVDUem56lR5o9KuMJrJ3cX0BVKd4sTFIwyriNKJiSIaqPlnjvfGEcl8BPfn2BrTzLEnwuhiXHcnREBmI/2A2PnyBdfMGYrB6T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YO7Lq507; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YO7Lq507"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3VruD647ruHQD2WvS8jRXyijMrWpWbN4ECMhtnhFOZEHoWFWK5PVUOMrc5fiMqjDw56hX0uJxMZuUZjTYAet0OvdJwk1unf4x/4V3J8geX8Sifw6TQFjXVXrO/j18LMpAVgYAiEuDuUIptpOaBAByESxfJueok5yXbyPWUtRrOsDv1vOQn/mLUK0DssJZBRjP55rMqyooqXL1DnQZ7JrMG/rlsPZR8Hha2aytQDDrrPou6hrQ84mRPqWGhdAJyaBre03v9/Zhdki7EpZ+mprDqL3IKdelmbEP67ocVeNiZBrenMnxDSbeCyM3jHg+O34tk/UE/ZinSBzXKg9m3vxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl2enQ8c2r0MUzFUCsOaV+CghmYIY8K5Qzo6yj0jNNo=;
 b=TNaIfzar0+c/9qvFy4QnVdHM2Oi6kXf9wSOecLfISd8H66lzpcPXGJalULTLskS/ivtvJjP9hN6loQD4sEXmSk8ey7PR2jx0eV1oAhjPPQ5sleI03Xuzz4UdYGZhrl0EtVJJei2mZ3/2nFPuPdRNv0HAP98q3aObVr4doUpDf86/B1A+Z2fPzRY6anbdu17+pxJw4u1lM0QWP8jKG0dhL6bWCnOkNSVQDnAhr3Y4Lv+fW9+6cSALOJMqH5XSZ6fTcGsazCeyn8MxgZfR83jeNyFJT56eIHkk2nPyPY29uvNQFIYtDGgMQ9AqXkxqzDsB1fElDd8s76/QiWIgEyb6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl2enQ8c2r0MUzFUCsOaV+CghmYIY8K5Qzo6yj0jNNo=;
 b=YO7Lq507m2ASmGdmQ/RROcULZO4+1ymWUffaWup/S/2vjm/lvL1YcmhWdxsq7+IR61NsxLT8tezPuqb7SpU9AgjdjU6AEqLG1ST33hPYbDYbCo39/5imEUNfzPn6bUeWpubRsYG1cg5yAEnZHjLRpblXj+T5dmJCpClEHYjTlXA=
Received: from MN2PR15CA0032.namprd15.prod.outlook.com (2603:10b6:208:1b4::45)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 18:35:52 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::13) by MN2PR15CA0032.outlook.office365.com
 (2603:10b6:208:1b4::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:35:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:35:51 -0600
Received: from [172.31.155.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 12:35:38 -0600
Message-ID: <3e7a84c0-a549-4e83-ba1f-beb0fe8a2930@amd.com>
Date: Tue, 20 Jan 2026 00:05:37 +0530
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
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
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
 <4e9d2241-0794-43c5-b13c-49e86e5f83ed@amd.com>
In-Reply-To: <4e9d2241-0794-43c5-b13c-49e86e5f83ed@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 387db961-a7a6-4033-f992-08de57899349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUFhc09qaWFnOXRTMEdYajlLcWZkb1hIMlQ2KzdlVTlxa1JkSDA5cWNoUXFT?=
 =?utf-8?B?eVVSRlRoVkgxNk5tNFZuSFdQaHhFaFdnUEZ6YUtqN3FlTzNsdXpzMkNyODlr?=
 =?utf-8?B?TzJ2U1MzeDhod0QwR0dPczVqdk1pMEdmS1k1SlBadXducTE0ckRvVnNIaXRL?=
 =?utf-8?B?WEV3dkJaMHhoSUQzNVhtR1QrTUw4cjY5S2FEZTEySlVFY2dtQkxENEZ1Rmty?=
 =?utf-8?B?RHFpSWdFNVl0THhXMHJvTkRYRHF2NTUva2Y0UUtOeE5pY29Dc1I5bFhFbWxm?=
 =?utf-8?B?SHdmR3RtMzFRWXJrV3NTcjk3WjQrYWlSV3hMeW9Hem10d0dwbldmYzZOYW9o?=
 =?utf-8?B?WHMrM1lvVUx5bU9xQXYrSE5lQ0lOd2REUU95WWorNzJ0WW5hand3dTRWcG42?=
 =?utf-8?B?NHR6aENmN2E1YTNHQ0hqbGhtcFpHTTh1NFZjaG1kdFRNZ2NFa2FIUGx3aTNS?=
 =?utf-8?B?dUJhdjdvRnE0Y2ZpRVB1VmM3TFg1aUZZdXR6eXZLbW1jOUxiQ0ZxenJ3a2F5?=
 =?utf-8?B?OEd2TUJzTTUwRG9CTm83TGZkS2dYSDlTRTM3ZWNUN1JydjVJb1VJK2FvanNl?=
 =?utf-8?B?RzVPMGF0amVObmlwZ0FRblZrNUpSOXl3eGZ0N0RmWm52Q241U01Pd05vMThy?=
 =?utf-8?B?c3luYlJGOUs3Q3JjTmFZN0pBNi9qVWlGT00vT1NEcHhsT1JBZkorWEU5SVR4?=
 =?utf-8?B?Q2lHWHVtTUpDWjA5a2pRdWw0aVdoSFVGV2xzeDlIKzg3elh1dlNLZTJjSnF5?=
 =?utf-8?B?ZlFVcC9LY01kTXZPLzZlYUNNWCtlZkNBWURUbmFxbWl6UC9NZ2xnRXFiNVJ6?=
 =?utf-8?B?ZTdyNlhpTFM4Y2FsZkhKRXg4QVR3YllkNVl5MDUyTkY1enB4U3Jpd2Zzbis1?=
 =?utf-8?B?clE5WWk3MlFtcjh5dHh0Zm5JZnZVVFZvSUhQMzlmeHB5VURZdmJySm9SekVK?=
 =?utf-8?B?bmxiTC8xVEhXSldRSXVMMFRzcXkrVnAzY3laTkh3NWlXS3BUU2pQYUY0RytH?=
 =?utf-8?B?Y3J5NEl4RStWYklmMkYxc2dkaCsxMVhMZm5mTFV5TTRmVlFiVlkvRElkZEc2?=
 =?utf-8?B?UEJpNHBOaUk5ODNaK0F4RzdmVGszM2FUNlpBRHlXbnUrUU56UytFM3habXZB?=
 =?utf-8?B?ZmhjQ0VXT3N0V3FzQklad3dEeStOV3JpZVF6ZDEyV2tVSFVRVjlhYTM2WEVn?=
 =?utf-8?B?TWZraUp3aERmVUlNZmVxTVY3cVgzTlJvL3lLazNGRStpQUxxV2w0aXhnb0VW?=
 =?utf-8?B?N0k3clNBVXF2SmpuTElKaDBCcngrY3lzNmJCSXgxTUtVVG9RdnJGZGtZejNx?=
 =?utf-8?B?Lzh0VUxhSnlvOEo1dlRBNitRY05TdHovRFZlQlNrdFZVRVJwT3hMb0xZNHV2?=
 =?utf-8?B?UmVubHJPK01mN2lpR2V1U1RSdHdlcGFYTVh2Z1dLejd2d29saTVibmovZ2xK?=
 =?utf-8?B?V2NodVozR3lDK3lOYk5tNmJaNnFmNnJ6bEFhVHhKMFF6RWZ1cWVNUDJONko1?=
 =?utf-8?B?WjBNNDlxVHQyd1dsUHlmUExuUjV0VDlYa3B1emdjSzhjZkRRZmFiVFg0UjYv?=
 =?utf-8?B?OW9tNFBwZ1EwcEx5M3JHb2pOeGRyZGRueUQwRzRQellhbUNDcCtDT2pZaWxq?=
 =?utf-8?B?QmJLS2VTQTZjK25yVmRGYUt5UzQyR0ozd0FOOEswNkxzSnM0MHZiUlRMcFRl?=
 =?utf-8?B?SlhoK2lDSy9id1FMODQ4QTY0TmVTVUlzRDFITFc3SUM5UTA1UWpGb0pGNjVX?=
 =?utf-8?B?WTg4SU9aMVg0ek9DV0dQeFJIeW9oNzByTkNTb1pXNHRyeDZNeGVadGlqT29X?=
 =?utf-8?B?eVBtQXlvbGRNdDRhcFpJVVJpVmxQc21zZTN1YmpkSzJhM2tqamI2Zm5QUVNF?=
 =?utf-8?B?RExBdDdycFZEMm85cU1DcllNeG1QVVF1L1RvU0wrNGgzUlJrNk02ZzZuWFBJ?=
 =?utf-8?B?YTlNbVV1MFFERUZYZlpvTllJQVZpOUFjMDBmMHRQUVE1V2N0NTYwcGh6N3Zn?=
 =?utf-8?B?WGpiYTVwcnhTUjR4QmZsT1Q2KzJ6cjRyZ2lPYmx4ZFJTTGZFOHY2Q1QvN0lt?=
 =?utf-8?B?UC8xTit4RmtvWVNIV1pZRC94bUp3Tk5yeU9yU3MxSEFTMU1aTzZ3UGtLRllj?=
 =?utf-8?B?SWljVDhLQWkxV1k2S0V0d2dkNkJpZm92dWFPQ0JPQW5RNk1MNlA0UzdqWW5W?=
 =?utf-8?Q?fng7Kc4SNnfiyvUDnofNAr3ppCm1YeOCIJ/sN2RsLrzP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:35:52.6001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 387db961-a7a6-4033-f992-08de57899349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

Hi Namhyung,

On 09-01-2026 16:55, Swapnil Sapkal wrote:
> Hello Namhyung,
> 
> On 03-01-2026 04:05, Namhyung Kim wrote:
>> On Tue, Sep 09, 2025 at 11:42:23AM +0000, Swapnil Sapkal wrote:
>>> `perf sched stats record` captures two sets of samples. For workload
>>> profile, first set right before workload starts and second set after
>>> workload finishes. For the systemwide profile, first set at the
>>> beginning of profile and second set on receiving SIGINT signal.
>>>
>>> Add `perf sched stats report` subcommand that will read both the set
>>> of samples, get the diff and render a final report. Final report prints
>>> scheduler stat at cpu granularity as well as sched domain granularity.
>>>
>>> Example usage:
>>>
>>>    # perf sched stats record
>>>    # perf sched stats report
>>
>> It'd be great if you could add an example output as well.
>>
> 
> Sure, will do.
> 
>>>
>>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>> Tested-by: James Clark <james.clark@linaro.org>
>>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>> ---
>>>   tools/perf/builtin-sched.c | 509 ++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 508 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>>> index 2573491fa5f8..e23018798f5b 100644
>>> --- a/tools/perf/builtin-sched.c
>>> +++ b/tools/perf/builtin-sched.c
>>> @@ -3940,6 +3940,505 @@ static int 
>>> perf_sched__schedstat_record(struct perf_sched *sched,
>>>       return err;
>>>   }
>>> +struct schedstat_domain {
>>> +    struct list_head domain_list;
>>> +    struct perf_record_schedstat_domain *domain_data;
>>> +};
>>> +
>>> +struct schedstat_cpu {
>>> +    struct list_head cpu_list;
>>> +    struct list_head domain_head;
>>> +    struct perf_record_schedstat_cpu *cpu_data;
>>> +};
>>> +
>>> +static struct list_head cpu_head = LIST_HEAD_INIT(cpu_head);
>>> +static struct schedstat_cpu *cpu_second_pass;
>>> +static struct schedstat_domain *domain_second_pass;
>>> +static bool after_workload_flag;
>>> +static bool verbose_field;
>>> +
>>> +static void store_schedtstat_cpu_diff(struct schedstat_cpu 
>>> *after_workload)
>>> +{
>>> +    struct perf_record_schedstat_cpu *before = cpu_second_pass- 
>>> >cpu_data;
>>> +    struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
>>> +    __u16 version = after_workload->cpu_data->version;
>>> +
>>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, 
>>> _ver)    \
>>> +    (before->_ver._name = after->_ver._name - before->_ver._name)
>>> +
>>> +    if (version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +
>>> +#undef CPU_FIELD
>>> +}
>>> +
>>> +static void store_schedstat_domain_diff(struct schedstat_domain 
>>> *after_workload)
>>> +{
>>> +    struct perf_record_schedstat_domain *before = 
>>> domain_second_pass->domain_data;
>>> +    struct perf_record_schedstat_domain *after = after_workload- 
>>> >domain_data;
>>> +    __u16 version = after_workload->domain_data->version;
>>> +
>>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, 
>>> _ver)    \
>>> +    (before->_ver._name = after->_ver._name - before->_ver._name)
>>> +
>>> +    if (version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +#undef DOMAIN_FIELD
>>> +}
>>> +
>>> +static inline void print_cpu_stats(struct perf_record_schedstat_cpu 
>>> *cs)
>>> +{
>>> +    printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
>>> +    printf("%.*s\n", 100, graph_dotted_line);
>>> +
>>> +#define CALC_PCT(_x, _y)    ((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
>>> +
>>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, 
>>> _ver)        \
>>> +    do {                                    \
>>> +        printf("%-65s: " _format, verbose_field ? _desc : #_name,    \
>>> +               cs->_ver._name);                        \
>>> +        if (_is_pct) {                            \
>>> +            printf("  ( %8.2lf%% )",                \
>>> +                   CALC_PCT(cs->_ver._name, cs->_ver._pct_of));    \
>>> +        }                                \
>>> +        printf("\n");                            \
>>> +    } while (0)
>>> +
>>> +    if (cs->version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (cs->version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (cs->version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +
>>> +#undef CPU_FIELD
>>> +#undef CALC_PCT
>>> +}
>>> +
>>> +static inline void print_domain_stats(struct 
>>> perf_record_schedstat_domain *ds,
>>> +                      __u64 jiffies)
>>> +{
>>> +    printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
>>> +
>>> +#define DOMAIN_CATEGORY(_desc)                            \
>>> +    do {                                    \
>>> +        size_t _len = strlen(_desc);                    \
>>> +        size_t _pre_dash_cnt = (100 - _len) / 2;            \
>>> +        size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;        \
>>> +        print_separator((int)_pre_dash_cnt, _desc, 
>>> (int)_post_dash_cnt);\
>>> +    } while (0)
>>> +
>>> +#define CALC_AVG(_x, _y)    ((_y) ? (long double)(_x) / (_y) : 0.0)
>>> +
>>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, 
>>> _ver)        \
>>> +    do {                                    \
>>> +        printf("%-65s: " _format, verbose_field ? _desc : #_name,    \
>>> +               ds->_ver._name);                        \
>>> +        if (_is_jiffies) {                        \
>>> +            printf("  $ %11.2Lf $",                    \
>>> +                   CALC_AVG(jiffies, ds->_ver._name));        \
>>> +        }                                \
>>> +        printf("\n");                            \
>>> +    } while (0)
>>> +
>>> +#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, 
>>> _ver)        \
>>> +    printf("*%-64s: " _format "\n", verbose_field ? _desc : 
>>> #_name,        \
>>> +           (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
>>> +
>>> +#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, 
>>> _ver)        \
>>> +    printf("*%-64s: " _format "\n", verbose_field ? _desc : 
>>> #_name,        \
>>> +           CALC_AVG(ds->_ver._w,                        \
>>> +            ((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
>>> +
>>> +    if (ds->version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (ds->version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (ds->version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +
>>> +#undef DERIVED_AVG_FIELD
>>> +#undef DERIVED_CNT_FIELD
>>> +#undef DOMAIN_FIELD
>>> +#undef CALC_AVG
>>> +#undef DOMAIN_CATEGORY
>>> +}
>>> +
>>> +static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
>>> +                    struct schedstat_cpu *cptr,
>>> +                    int cnt, bool is_last)
>>> +{
>>> +    struct perf_record_schedstat_cpu *summary_cs = summary_cpu- 
>>> >cpu_data,
>>> +                     *temp_cs = cptr->cpu_data;
>>> +
>>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, 
>>> _ver)        \
>>> +    do {                                    \
>>> +        summary_cs->_ver._name += temp_cs->_ver._name;            \
>>> +        if (is_last)                            \
>>> +            summary_cs->_ver._name /= cnt;                \
>>> +    } while (0)
>>> +
>>> +    if (cptr->cpu_data->version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (cptr->cpu_data->version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (cptr->cpu_data->version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +#undef CPU_FIELD
>>> +}
>>> +
>>> +static void summarize_schedstat_domain(struct schedstat_domain 
>>> *summary_domain,
>>> +                       struct schedstat_domain *dptr,
>>> +                       int cnt, bool is_last)
>>> +{
>>> +    struct perf_record_schedstat_domain *summary_ds = 
>>> summary_domain->domain_data,
>>> +                        *temp_ds = dptr->domain_data;
>>> +
>>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, 
>>> _ver)        \
>>> +    do {                                    \
>>> +        summary_ds->_ver._name += temp_ds->_ver._name;            \
>>> +        if (is_last)                            \
>>> +            summary_ds->_ver._name /= cnt;                \
>>> +    } while (0)
>>> +
>>> +    if (dptr->domain_data->version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (dptr->domain_data->version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (dptr->domain_data->version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +#undef DOMAIN_FIELD
>>> +}
>>> +
>>> +static int get_all_cpu_stats(struct list_head *head)
>>> +{
>>> +    struct schedstat_cpu *cptr = list_first_entry(head, struct 
>>> schedstat_cpu, cpu_list);
>>> +    struct schedstat_cpu *summary_head = NULL;
>>> +    struct perf_record_schedstat_domain *ds;
>>> +    struct perf_record_schedstat_cpu *cs;
>>> +    struct schedstat_domain *dptr, *tdptr;
>>> +    bool is_last = false;
>>> +    int cnt = 1;
>>> +    int ret = 0;
>>> +
>>> +    if (cptr) {
>>> +        summary_head = zalloc(sizeof(*summary_head));
>>> +        if (!summary_head)
>>> +            return -ENOMEM;
>>> +
>>> +        summary_head->cpu_data = zalloc(sizeof(*cs));
>>> +        memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
>>> +
>>> +        INIT_LIST_HEAD(&summary_head->domain_head);
>>> +
>>> +        list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>>> +            tdptr = zalloc(sizeof(*tdptr));
>>> +            if (!tdptr)
>>> +                return -ENOMEM;
>>> +
>>> +            tdptr->domain_data = zalloc(sizeof(*ds));
>>> +            if (!tdptr->domain_data)
>>> +                return -ENOMEM;
>>
>> Please free tdptr too.
>>
> 
> Ack.

Apologies for not including this in my previous comment. The memory 
allocated for tdptr and tdptr->domain_data is part of a list created to 
store CPU and domain related information. In the next version, I've 
added comment to represent this list. This list is used by the 
show_schedstat_data() function to print the output and later it is freed 
by the free_schedstat() function. Because of which I did not address 
this in version 5.

> 
>>> +
>>> +            memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
>>> +            list_add_tail(&tdptr->domain_list, &summary_head- 
>>> >domain_head);
>>> +        }
>>> +    }
>>> +
>>> +
>>> +    list_for_each_entry(cptr, head, cpu_list) {
>>> +        if (list_is_first(&cptr->cpu_list, head))
>>> +            continue;
>>> +
>>> +        if (list_is_last(&cptr->cpu_list, head))
>>> +            is_last = true;
>>> +
>>> +        cnt++;
>>> +        summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
>>> +        tdptr = list_first_entry(&summary_head->domain_head, struct 
>>> schedstat_domain,
>>> +                     domain_list);
>>> +
>>> +        list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>>> +            summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
>>> +            tdptr = list_next_entry(tdptr, domain_list);
>>> +        }
>>> +    }
>>> +
>>> +    list_add(&summary_head->cpu_list, head);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void print_field_description(struct schedstat_cpu *cptr)
>>> +{
>>> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, 
>>> _ver)        \
>>> +        printf("%-30s-> %s\n", #_name, _desc)                \
>>> +
>>> +#define DOMAIN_CATEGORY(_desc)                            \
>>> +    do {                                    \
>>> +        size_t _len = strlen(_desc);                    \
>>> +        size_t _pre_dash_cnt = (100 - _len) / 2;            \
>>> +        size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;        \
>>> +        print_separator((int)_pre_dash_cnt, _desc, 
>>> (int)_post_dash_cnt);\
>>> +    } while (0)
>>> +
>>> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, 
>>> _ver)        \
>>> +        printf("%-30s-> %s\n", #_name, _desc)                \
>>> +
>>> +#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, 
>>> _ver)        \
>>> +        printf("*%-29s-> %s\n", #_name, _desc)                \
>>> +
>>> +#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, 
>>> _ver)        \
>>> +        printf("*%-29s-> %s\n", #_name, _desc)                \
>>> +
>>> +    if (cptr->cpu_data->version == 15) {
>>> +#include <perf/schedstat-v15.h>
>>> +    } else if (cptr->cpu_data->version == 16) {
>>> +#include <perf/schedstat-v16.h>
>>> +    } else if (cptr->cpu_data->version == 17) {
>>> +#include <perf/schedstat-v17.h>
>>> +    }
>>> +#undef CPU_FIELD
>>> +#undef DOMAIN_CATEGORY
>>> +#undef DERIVED_CNT_FIELD
>>> +#undef DERIVED_AVG_FIELD
>>> +#undef DOMAIN_FIELD
>>> +}
>>> +
>>> +static int show_schedstat_data(struct list_head *head, struct 
>>> cpu_domain_map **cd_map)
>>> +{
>>> +    struct schedstat_cpu *cptr = list_first_entry(head, struct 
>>> schedstat_cpu, cpu_list);
>>> +    __u64 jiffies = cptr->cpu_data->timestamp;
>>> +    struct perf_record_schedstat_domain *ds;
>>> +    struct perf_record_schedstat_cpu *cs;
>>> +    struct schedstat_domain *dptr;
>>> +    bool is_summary = true;
>>> +    int ret = 0;
>>> +
>>> +    printf("Description\n");
>>> +    print_separator(100, "", 0);
>>> +    printf("%-30s-> %s\n", "DESC", "Description of the field");
>>> +    printf("%-30s-> %s\n", "COUNT", "Value of the field");
>>> +    printf("%-30s-> %s\n", "PCT_CHANGE", "Percent change with 
>>> corresponding base value");
>>> +    printf("%-30s-> %s\n", "AVG_JIFFIES",
>>> +           "Avg time in jiffies between two consecutive occurrence 
>>> of event");
>>> +
>>> +    if (!verbose_field) {
>>> +        print_separator(100, "", 0);
>>> +        print_field_description(cptr);
>>> +    }
>>> +
>>> +    print_separator(100, "", 0);
>>> +    printf("\n");
>>> +
>>> +    printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
>>> +    print_separator(100, "", 0);
>>> +
>>> +    ret = get_all_cpu_stats(head);
>>> +
>>> +    list_for_each_entry(cptr, head, cpu_list) {
>>> +        cs = cptr->cpu_data;
>>> +        printf("\n");
>>> +        print_separator(100, "", 0);
>>> +
>>> +        if (is_summary)
>>> +            printf("CPU <ALL CPUS SUMMARY>\n");
>>> +        else
>>> +            printf("CPU %d\n", cs->cpu);
>>> +
>>> +        print_separator(100, "", 0);
>>> +        print_cpu_stats(cs);
>>> +        print_separator(100, "", 0);
>>> +
>>> +        list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
>>> +            struct domain_info *dinfo;
>>> +
>>> +            ds = dptr->domain_data;
>>> +            dinfo = cd_map[ds->cpu]->domains[ds->domain];
>>> +            if (is_summary)
>>
>> Please add a pair of braces for multiline statements.
>>
> 
> Ack.
> 
>>
>>> +                if (dinfo->dname)
>>> +                    printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", 
>>> dinfo->dname);
>>> +                else
>>> +                    printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", 
>>> dinfo->domain);
>>> +            else {
>>> +                if (dinfo->dname)
>>> +                    printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, 
>>> dinfo->dname);
>>> +                else
>>> +                    printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, 
>>> dinfo->domain);
>>> +
>>> +                printf("%s\n", dinfo->cpulist);
>>> +            }
>>> +            print_separator(100, "", 0);
>>> +            print_domain_stats(ds, jiffies);
>>> +            print_separator(100, "", 0);
>>> +        }
>>> +        is_summary = false;
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +static int perf_sched__process_schedstat(struct perf_session 
>>> *session __maybe_unused,
>>> +                     union perf_event *event)
>>> +{
>>> +    struct perf_cpu this_cpu;
>>> +    static __u32 initial_cpu;
>>> +
>>> +    switch (event->header.type) {
>>> +    case PERF_RECORD_SCHEDSTAT_CPU:
>>> +        this_cpu.cpu = event->schedstat_cpu.cpu;
>>> +        break;
>>> +    case PERF_RECORD_SCHEDSTAT_DOMAIN:
>>> +        this_cpu.cpu = event->schedstat_domain.cpu;
>>> +        break;
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (user_requested_cpus && ! 
>>> perf_cpu_map__has(user_requested_cpus, this_cpu))
>>> +        return 0;
>>> +
>>> +    if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
>>> +        struct schedstat_cpu *temp = zalloc(sizeof(*temp));
>>> +
>>> +        if (!temp)
>>> +            return -ENOMEM;
>>> +
>>> +        temp->cpu_data = zalloc(sizeof(*temp->cpu_data));
>>> +        if (!temp->cpu_data)
>>> +            return -ENOMEM;
>>
>> Please free temp as well.
>>
> 
> Ack.

As mentioned above this is also freed by free_schedstat() function.

> 
>>> +
>>> +        memcpy(temp->cpu_data, &event->schedstat_cpu, sizeof(*temp- 
>>> >cpu_data));
>>> +
>>> +        if (!list_empty(&cpu_head) && temp->cpu_data->cpu == 
>>> initial_cpu)
>>> +            after_workload_flag = true;
>>> +
>>> +        if (!after_workload_flag) {
>>> +            if (list_empty(&cpu_head))
>>> +                initial_cpu = temp->cpu_data->cpu;
>>> +
>>> +            list_add_tail(&temp->cpu_list, &cpu_head);
>>> +            INIT_LIST_HEAD(&temp->domain_head);
>>> +        } else {
>>> +            if (temp->cpu_data->cpu == initial_cpu) {
>>> +                cpu_second_pass = list_first_entry(&cpu_head, struct 
>>> schedstat_cpu,
>>> +                                   cpu_list);
>>> +                cpu_second_pass->cpu_data->timestamp =
>>> +                    temp->cpu_data->timestamp - cpu_second_pass- 
>>> >cpu_data->timestamp;
>>> +            } else {
>>> +                cpu_second_pass = list_next_entry(cpu_second_pass, 
>>> cpu_list);
>>> +            }
>>> +            domain_second_pass = list_first_entry(&cpu_second_pass- 
>>> >domain_head,
>>> +                                  struct schedstat_domain, 
>>> domain_list);
>>> +            store_schedtstat_cpu_diff(temp);
>>> +            free(temp);
>>
>> What about temp->cpu_data?
>>
> 
> Sure, will free it.
> 

Same here.

>>
>>> +        }
>>> +    } else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
>>> +        struct schedstat_cpu *cpu_tail;
>>> +        struct schedstat_domain *temp = zalloc(sizeof(*temp));
>>> +
>>> +        if (!temp)
>>> +            return -ENOMEM;
>>> +
>>> +        temp->domain_data = zalloc(sizeof(*temp->domain_data));
>>> +        if (!temp->domain_data)
>>> +            return -ENOMEM;
>>
>> Ditto.
>>
> 
> Ack.

Same here.

> 
>>> +
>>> +        memcpy(temp->domain_data, &event->schedstat_domain, 
>>> sizeof(*temp->domain_data));
>>> +
>>> +        if (!after_workload_flag) {
>>> +            cpu_tail = list_last_entry(&cpu_head, struct 
>>> schedstat_cpu, cpu_list);
>>> +            list_add_tail(&temp->domain_list, &cpu_tail->domain_head);
>>> +        } else {
>>> +            store_schedstat_domain_diff(temp);
>>> +            domain_second_pass = list_next_entry(domain_second_pass, 
>>> domain_list);
>>> +            free(temp);
>>
>> Ditto.
>>
> 
> Ack.
> 

Same here.

> -- 
> Thanks and Regards,
> Swapnil
> 
>> Thanks,
>> Namhyung
>>
--
Thanks and Regards,
Swapnil
