Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8D1891C7;
	Wed, 18 Sep 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649787; cv=fail; b=CLv9vMjeZHnORA20YiK2rwxaiW1OVCb4CEw3nWFHkME34zNaCdSvx8OaxoUp5e/lX9PsKegGF+TShtPtbBudQ0vruSuG6hGsJSU6A5AymH4xHf4+IphfNqay7yLiH5DmTVRjH1ZAjUvd6sq29S78Z84JQoWS8ynIOdct8EGhmxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649787; c=relaxed/simple;
	bh=80kcx6WX1ant6SjOkhjollaXAVncYBa16ymfui6xVDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CL99I0HgSiP2m/nwQt3cwBgWtBybmOjVsqVkkjrret4G01c7CiAK3CibFMCrHNaS76fyAZAtC0vh/HEnShKLI/9CCibiV9BE7YMG6H/K++Sw/MTfB4oeBfotUT2Ms9Z4N/VOs0ZHUpHijp/8tCdQI3lUcJrTmkIRjyBg+JcHtM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dtsx4Ki+; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dtsx4Ki+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9W0gGmxiswJRCTJTwPBlgc+LAApsz5E16bKhp2Exq+1cjP6Fr8uDeRGZd0rqFVsM6El0D30AL/l+V0us+atPylNadulR5x7oJCxGbsayLU0g699KPxKAITADhXk86vWRnGubJ1+TrzYwJXLZc7v2FKisL5In7tSEwGRlzCaxF18YuQDThajSabua0c/qhQDmlQqdafh+8j1qatBtn5czPAf4nIbZddHgVwdAWeb6iVgf996lysD/JG4yoAnC1slDI2Qa1Jmsr5RC8plVq8sykS+a4eMGliueUHND1rR1y2ZIThmE8ZrLnqEJ4E2wkNKBoSzDZHUu1QUMQDSJe2SUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=embS5Ke0sivomrzogqD8sav+1UBfiTuYeGLzWCYVeg8=;
 b=s4IkmyPYua4kEd21xSUPHX1cy7NEH8zDd4fgWsg19Rc1u3zNIt+zsFEiXE0AaDxbmXqdCVPmmhxE/XjWk4FImmyYPusf6VjpvZ3H0eqf4z1PZ7qIeZwJumk8Awb3W2UY03EuzVc6Nzo7F39CfqAis1mJQVl6Nwf93TAhC8Z/4wTeo2d1XsKotAY7kAuPbafZb8tjQTss6gg97rAoLvsrSDvBX2b/T+oHyZcDbD9WPkMmu+fJE7CQ6Dgxs47TW8TUVgeHo0N6fj2y0o/CbAYxreOv9ExlM5gjZCZsbwsqGU7Hsmnl/hzcQE8Swo8oVzFvtr1RrUWvJa8xHXAO7w+xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=embS5Ke0sivomrzogqD8sav+1UBfiTuYeGLzWCYVeg8=;
 b=dtsx4Ki+Ab6L28LQllh3Iv2YTF+zRWh3sBTWvKL9yuMyRXtPS8gXPpruoaH0Wph1GsQ9DXkt01tGoYBlxgKdj8qjQMAh4R0PevgVn7aesf/WKqdYQIBAa4BBnbEpBxf8knEcq+mQJ+rqbR0C9/MhyN7Ywumdn1AfR5k0uvdljj0=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 08:56:19 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::a4) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 18 Sep 2024 08:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 08:56:19 +0000
Received: from [10.136.32.87] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 03:53:21 -0500
Message-ID: <ef39150e-902d-4c58-bc9e-efa08ef5447b@amd.com>
Date: Wed, 18 Sep 2024 14:22:53 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] perf sched stats: Add record and rawdump support
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
 <20240916164722.1838-3-ravi.bangoria@amd.com>
 <95e39d9c-7f0e-447b-9b2d-aab5d36b933a@linaro.org>
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <95e39d9c-7f0e-447b-9b2d-aab5d36b933a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: f2906bdf-f0b9-4069-d258-08dcd7bfc369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUZQTDRqc2RvYTJETUlpemU0ZWE1aTJocGdWeDRpWkxxTkVPVXpjQTdGZnNh?=
 =?utf-8?B?MnE5UDFQN3JKUEtZQVFrN0NNOWRXcHRnaWpRTmFKZDZVSlBqUDZEVVJyRi85?=
 =?utf-8?B?eHFhdkt2ZzJoY1JSZWUyM1gwNy9LUC91aVYwUTI4ckZOeEFEdGtCZnRQdVl6?=
 =?utf-8?B?VGl0U21TYy80ZXRPU2dVNEFJU09TaUwwbUdMVEExeXFTMDYva1NTcEVmMkxk?=
 =?utf-8?B?Nk56dDkwL0ozdWZrWWlDQ3o1eXMwb1pGWGZvaEhTamVWcWpGS0NiVDZ4ZmVz?=
 =?utf-8?B?R2dQY2RtU2lBZTR4RTNPc1dSTDBKVVhoVDVrTzZLQmYxamhiSmp2RUFYWkl0?=
 =?utf-8?B?ZjdOQmZJUEJBODg4RkpSNFFrRTBZYXBrUEZtTlFiWXZPQVM5U3kwRkRDRGVG?=
 =?utf-8?B?RWxuaW1YS1VqRUxITXlaalNEYXRvTUNpMjd1bS9UNjBycDlnZmUzL24rRTE3?=
 =?utf-8?B?L3RsY1dRSHVXVkt3QVFub08xYWF0R0x2WDcyV09JMXdhK2dmRVlhQ3JNemVG?=
 =?utf-8?B?bklnWWdYckpIaGh3NDRNQWpsckNBbzY0Nk9rWGZuMzZobVoxYmt1RlNsVHNy?=
 =?utf-8?B?cnduSENDNUgzSU1zZFhIMVBRdzZZY3VYLzNVYmhVQ0lhQjlicUcybHFDZWxT?=
 =?utf-8?B?RkFsazZuaWZJempBdWhIRmx0OE0ySzVZM1NIVDRqMzF2emhsTG1qRmlPVysz?=
 =?utf-8?B?RjY2czVWM3BOVnIzQjNCSWNYMGxrbGRxM3hFUzZCZHpwRjI4OGtqUkZMa0l0?=
 =?utf-8?B?M2JPMnpoMk1XbmNTNzhYaytiWjY4UFlqYjRCaDg5L1Z0V09yN3Yxdml5bE94?=
 =?utf-8?B?ZDVHVzVxZ0pINFNRb1JZcnBKSkxMYXFySHdvZHF5L2JlOVRtMHYwMjZxTlhD?=
 =?utf-8?B?QVFsMStYcGRyUnhWU25USjJRNWljREFCK0tSWC9KVkgvb1pneHRVOG1uRjBh?=
 =?utf-8?B?MzVGNitGSXNia3U5R2c3Z1UyR3I1dlEvdU5ibmsxWWRNNG5uSnpBVFFnNkhG?=
 =?utf-8?B?UjdHMlZVUEVPa2JPbCsxT3RtM3NmUHBlOVF6VGJXZk83RzFuUnFkdEp6dVBO?=
 =?utf-8?B?ZjlpSlZVbGdKREhOM3hhaGVmZnlIaHMvRE5WVHRaTjU1RVZQVmExZXRocXBT?=
 =?utf-8?B?YjhTcWlaZHZqaWJGSGFDUThBSmsydmNiL3Q5ZTltQkY0YWEwZTd0bEh6aVR4?=
 =?utf-8?B?UVlweEVGZDhQRVNEeCs4NnZSdng3WnFSZmVZUnlhZTR1MktqV1B2dEN0aUEw?=
 =?utf-8?B?aDlqZEptTGlDVEYwT2RYbmZnSFVvc3c1Ym1ReGloSi9tL1A4YzAxaTNCQnlD?=
 =?utf-8?B?cUpLY0phc09keU1ZVmE4dTQ0MnJJSEFaQm94WU10STNWeVlYOGhLVnR5Nks3?=
 =?utf-8?B?dE9Ob3BnS21XbEp0TytpcTIrc1NLZTgwYmRqaFF5MkRHUTZhckNRcUwxdnNq?=
 =?utf-8?B?bnJzc3NSNk1uclRQMHBDeTQwc0hoT2liRFpvM0JzWWxUTlFzdjJCTWg0MW5x?=
 =?utf-8?B?SGVpZ1RJV0dtUlRERUs1eWJpRC9GekgrclNMVzNHb3VEcHZOVnFaVVd4Z2hO?=
 =?utf-8?B?RzJVR2NSOUx5aW4xMEgyVTBnMUNkajRIdHZTaVNpaXJVOVlwY1c3Ly9FTFly?=
 =?utf-8?B?Vnh6Mk1BODN6T0U5MXFCdFVCMmRxdldROHd2TTNCcEJpV2d2d01pb3gycUJt?=
 =?utf-8?B?RmdWQk5MZTErMUg2WmdNTm9UQ1plWExCVTJTV29MSjZGZGtsbVlMRVRUbVBZ?=
 =?utf-8?B?bDkxWVNQQU5RY2RuK0hzRFV2bVNwTmRwZ09IT3N6ek5EWkRQQkUrdWNyVHRF?=
 =?utf-8?B?dHB5WmdVVjdReDF3VUpabkZHOXR2dGpUM3czaW9GZFo1Z2dJMUxvK1hXTVdR?=
 =?utf-8?B?S2RNUTBXRFpRNStuTnlqRkVhclFFam9pUTBWVURWVmJZcDVmUlVjRTltdEJJ?=
 =?utf-8?Q?Pg8h8YSlP0gvnSTsbztDW9eJnK53mLDD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 08:56:19.5735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2906bdf-f0b9-4069-d258-08dcd7bfc369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815

Hi James,

Thanks for the review.

On 9/17/2024 4:05 PM, James Clark wrote:
> 
> 
> On 16/09/2024 17:47, Ravi Bangoria wrote:
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
> 
> [...]
> 
>> +int perf_event__synthesize_schedstat(const struct perf_tool *tool,
>> +                     perf_event__handler_t process,
>> +                     struct perf_cpu_map *user_requested_cpus)
>> +{
>> +    union perf_event *event = NULL;
>> +    size_t line_len = 0;
>> +    char *line = NULL;
>> +    char bf[BUFSIZ];
>> +    __u64 timestamp;
>> +    __u16 version;
>> +    struct io io;
>> +    int ret = -1;
>> +    int cpu = -1;
>> +    char ch;
>> +
>> +    io.fd = open("/proc/schedstat", O_RDONLY, 0);
> 
> Other parts of the tool use procfs__mountpoint() for /proc. Although it 
> can only be in one place so it doesn't actually make a difference for 
> this one. Probably worth it for consistency though.
> 
Sure, I will update this in the next version.

>> +    if (io.fd < 0) {
>> +        pr_err("Failed to open /proc/schedstat\n");
> 
> A hint about CONFIG_SCHEDSTAT would be useful here.

Sure, I will update.

--
Thanks and Regards,
Swapnil
