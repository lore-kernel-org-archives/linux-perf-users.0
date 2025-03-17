Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E923F40D;
	Mon, 17 Mar 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218346; cv=fail; b=YQSgy/IBSorhX6fqklXDX2RgLAbdrLDIXstbFhQqVPtg6TT6g+OIJqigwAIdyaPjxJppZDOl9c8lyUDkgECrI1NyFEH/SJoZJe2RRahh5Ai5CzlAIF/UH0DaP/YJPHf8alfYR56wcTZOCOhhWlV0rAu/HhfxwJDtzy9kr9aeNn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218346; c=relaxed/simple;
	bh=G3hYa7CqM/Pst5NaOE3J6nSfKCHlT39WGDk3wlpwP/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tUmS+GgGcvtY0F6afdW8q/vOS28hj1VwM8EQTSFTlBL45FifA3ctFzdC/MyGEAtblhcvGLxCJ7q2iBjLBFJ2d9hQcVWb6Ed2/s6+rUHYKQVNRhweScjT5tyZhvmD0aRa8M1A5iRLrTSUqxZWZ6AYv8YylCNpQerg1vdZ023MtE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qm6mLp8K; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qm6mLp8K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pm0AaOy1yC/5ZmAZu+Rwvx8DgUyoJ77kWsr2tE1MKw3Kj9pwSs8781UU7Kx56mtseVdPWcF5gOTwVLRaodGhqUf9V8NCzn0O7uojdey2KmX5hq32Ai6RwSMt4oklU0bRkVC7BaGekVQ9DOWIGMSwethyDroHkT2h4jQfuWSpzLL4r/xMAwsaj10qlvtzbZnfW+4SaVQwQO97xV4JdDMXWztwsZYfQbei/zwcCJkX29gvYGvd4hLqcHtE8U1qM8LxYdO3vhYTiMdDg0X+BN8xIWXcQGAowT73/P28nmlmHp4IPz5U3Kx7orFQl1dKobFmNWZNocaL5RUcDTwlJZ0cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxCoKv1z/6huzBJWcm+pODQanS4VwAHCBT1cfJd9s90=;
 b=dgpHB93VdSjpqTpKgMD/nLr1/iyOjH+OBSHht5wn7Oykyzz16cOtd2x9z/aKqvlTuU79ck/KpY3a/zhZKNiMNMDFngSmxmaj8v6ILrzxp/WZhoUyilRqvG5JuZt76/PAgqbTaA6yg4LNCM61GuwT5nTiNL5wWqSrCXbEPNsn2fYXi9yi7ljMw/LEgXl4q87mi2y+d+VqwCyViFpvMXiIZlU2aC57aJrDmbOb2U9MVNwYVGdFwJZqmNyC4uqQX5H5lCZtORkcFzJvhRvuBHVGvvWilmtbntxPqqIBATBPG+cC2EjLJsWYWYJrouaKGvtLbuwPncMs7vB7NI2joNvDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxCoKv1z/6huzBJWcm+pODQanS4VwAHCBT1cfJd9s90=;
 b=Qm6mLp8Kw0HJNhTEmsaCB2eDKr9aWqI/GlrMBZvhbblEQ8U1x1LOq2kna5DBti5vlofAp+DsK8G3oXU6LMY/KTvaUtykZCEUitDQA27sP62QjfTEfmJF7K2+zf6TlO7+5J0ta9zRj80xVksTeKoxR3OGchhad6gngMSiUBbmc8Q=
Received: from BL1PR13CA0450.namprd13.prod.outlook.com (2603:10b6:208:2c3::35)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:32:16 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::fe) by BL1PR13CA0450.outlook.office365.com
 (2603:10b6:208:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 13:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 13:32:15 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 08:32:08 -0500
Message-ID: <c7ebab9d-536c-4e3d-a916-30f45fb2e5f6@amd.com>
Date: Mon, 17 Mar 2025 19:02:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] perf sched stats: Add schedstat v17 support
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
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-4-swapnil.sapkal@amd.com> <Z9Tljo_cyid7NCgV@google.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <Z9Tljo_cyid7NCgV@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac114bb-f5e2-46d1-f9a4-08dd65582210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUpTejJyWkVVUUI1ODhDS1FTbXB2b2xtaWc4dGtZMENHd3pPK0NMZjZJSlZF?=
 =?utf-8?B?T1ZKdklybFN6LzNZeVl2R2hFVkN3UDlCUCtJT1JIdFVXdHl0aEUydnlYNUN6?=
 =?utf-8?B?cEFITVdDMDhUUnhIbFN6aUhubHFhWkYrajR6b1hSYkhrNTRMT1dlS1U2VVlN?=
 =?utf-8?B?cy9TWFRVREJzMnU1S0YybXc2SFVGUTVacGJ4T09vMDBhOVhRcUtZKzhiY2Fy?=
 =?utf-8?B?N21yaUFZTUY0UHlVZis0ay9hWGRaZ2tCd3F6S3g2K3RqYnVPSXlFbWdFblB3?=
 =?utf-8?B?d1pHTkZpWWhpM1dscVo4ZzYybld2VjFUS085Vi9QSXRRM2F1ZWdEZmlITVpw?=
 =?utf-8?B?M0dvWTJ4V1E0MkRZMWpkbUdNY3VaOVdONEplZmJZTUVWeURHSFRBWElUaFUy?=
 =?utf-8?B?ZW00SXFKWlM0Y3MyUTZIdjNWL3hmYnZIMGJ3Z2VqbG84RUtWdDhDMFZRTXNs?=
 =?utf-8?B?K1ZIeG1heTE0Nm9EeEZDVmlyWEtDVXRKR1U4c1BhZEhqWWhDMlZZaC8yTVBp?=
 =?utf-8?B?SWhlTUJSdk1TNmVmWkJYL0tGdGJCMVFGaGRUbk8rK29DemJuektOWWl5U0RX?=
 =?utf-8?B?M3IyN3dkQzgveEwrUGswaDZ5TjQyTDJZZTRGcjk0aHo2OFdBN0RlZUJDd1Bj?=
 =?utf-8?B?VVBGTjJpUlBNcnVSYVNaREtxUUI3eDM0bS9JNVIxakFiWm1ZckJjL3VzNEQ0?=
 =?utf-8?B?ZHp3cGNJdkh6cnp1VHhJam5mNFNTd3h0VU5sbzJLd1JkMTJ0NU5OaG5DdFcx?=
 =?utf-8?B?SThmanprQUtnOTRMYXh5enZ2YitXVmZJR2NpcXVCdG1hUzYxQmNwT0YzWS9R?=
 =?utf-8?B?WGpHNEFua0lWcFJNOFZ2SzFpeXJvMW03RGoxcnFSbDRwc2VKRkRnTTBqZWt6?=
 =?utf-8?B?cjBoUjVMeWdtV1MxY1lZTFViUUZxaTBBUjV4SGNqQnJEMXU4UnlkZCtnSFRn?=
 =?utf-8?B?ZWJUZmYraGxNUGlCR0srYnZNU2RyWEtMenlteE5JKzZBaDlrTzNlWmUySW1U?=
 =?utf-8?B?YkJlTmV1bFIvQzVmdFY4RlRlTzRCK1hKaENaODFQR0xwQWtqMXl5eWlmbERO?=
 =?utf-8?B?c29zczFVRjVmOFpUY29wMEljZGFFZm9IWngwQ0Q5VUNMNUJNR3hMZ3JFMEJU?=
 =?utf-8?B?SjNId0NDSEZhZDRBTy8wL2NXdTZ4dm1vUDB5c29DU1ZoMDNvVUJEZDhXZVFi?=
 =?utf-8?B?NHRLM09EMjJGMTE0QStOTWVSejdvMDRGb0orY3h6aERqQ0pieEIwY2ZNS3lr?=
 =?utf-8?B?ckZPM3RpamprZE1jdmFLM0hFdldPMSttWGdvQURaTGh5T0VvVEV4SHpOME0r?=
 =?utf-8?B?WDVKNExoeEw5ZGljZDlndFMwWUlrbU80NmwrRXhRSEo4aThBdFlVc0NHMm9j?=
 =?utf-8?B?Zm90bUNrKy92MVd2MFAwditzK1RpKzJYTC84VThtdmR2Y3B4YUF4cW1YdGRx?=
 =?utf-8?B?M1RtNHNyVG13WjA2cHk1Y1d1WkJOSjk3TG5KbzgrdTBUWWR4b2FMdjNsK2lq?=
 =?utf-8?B?NzV1VkJ5TUExcW5pdmlrSmxscndiOFFvbFFONGFGVDNOWHNsNG9DRVRFL0VM?=
 =?utf-8?B?Q2owbHB0WlJlblloTU5qdHJHeHdJam5tNVVmcVU3ZXgwWERaSWUyTFFpR0tP?=
 =?utf-8?B?SzVyQzlneEdMdUV1SnFRNU4wY1ArdWZCU0hzRFFnZHNheEFSR0cyWFBibE9z?=
 =?utf-8?B?bzdIS1pibldIRHZ3OHhBb3Z0Q2NHZDRIL1RwZ1FySFJXanZ4UjRVcXVOREM1?=
 =?utf-8?B?TVhJOE1BclR6WnBDQWkrTXhwQ1lnRTByYXVWZnNLMVJSa0hkRmFRT0xjWTZ4?=
 =?utf-8?B?eDJtd3hDL2c4VUtiNTUrenpqZDJvNjFzNldjNFlETmZJTXlJSXlHY0lzTE5n?=
 =?utf-8?B?YU9FaDdKbWpUOHJKb2NUSlhCcVVaRG9obHl3TDRWbVRWMm1QdWlLZHdTTGls?=
 =?utf-8?B?SWowS2pXYk9LSjlzSDBRSjVCblpFb1FqazIxeEVaZWp2enBoelpoVEJCdmhH?=
 =?utf-8?Q?IFWpW/SECW432X8nto761WIvkbniPU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:32:15.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac114bb-f5e2-46d1-f9a4-08dd65582210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

Hello Namhyung,

On 3/15/2025 7:57 AM, Namhyung Kim wrote:
> On Tue, Mar 11, 2025 at 12:02:25PM +0000, Swapnil Sapkal wrote:
>> /proc/schedstat file output is standardized with version number.
>> Add support to record and raw dump v17 version layout.
>>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/lib/perf/Makefile                     |  2 +-
>>   tools/lib/perf/include/perf/event.h         | 14 +++++
>>   tools/lib/perf/include/perf/schedstat-v17.h | 61 +++++++++++++++++++++
>>   tools/perf/util/event.c                     |  6 ++
>>   tools/perf/util/synthetic-events.c          | 15 +++++
>>   5 files changed, 97 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
>>
>> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
>> index d0506a13a97f..30712ce8b6b1 100644
>> --- a/tools/lib/perf/Makefile
>> +++ b/tools/lib/perf/Makefile
>> @@ -174,7 +174,7 @@ install_lib: libs
>>   		$(call do_install_mkdir,$(libdir_SQ)); \
>>   		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>>   
>> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h
>> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h schedstat-v17.h
> 
> Please put them in a separate line like
> 
> HDRS += schedstat-v15.h schedstat-v16.h schedstat-v17.h
> 

Sure, Will change accordingly.

> Thanks,
> Namhyung
> 

--
Thanks and Regards,
Swapnil


