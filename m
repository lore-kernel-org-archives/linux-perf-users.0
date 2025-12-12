Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1A1339B1;
	Fri, 12 Dec 2025 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511034; cv=fail; b=RWyR27L2XG5/Z7S5OkQ7JPAFCbwzN5ShUWMj/W7VM3Q8EzAJYSBU3ERR/TAYJ3j9WNN7YvAWf1pr9g/bWUZcc+zpt9r/MIfIptgb+XNPUFaUxDPwuqCTzQXaghK19tg2uEnVPekAjb4ZMh8FGdLxVqVnn8NCfGslwcrmvE3LUug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511034; c=relaxed/simple;
	bh=5niHCADGpINFbT+PusHAzoe6uHF+HyVdnWIhB1aYdmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kZRGjIoVB84dBfPsM34Mg5i8SHY94vRltPd7KcZtgy+BLlmBDelIzxd/vgc1kw/LuKsIyNVZj1y89uOKtSYVKp7x6CiWvQu33hmQkQ9/lbrTYf2HUDuWZ00MPPqz17svv8RQ7cnLAPD5k/LhG63mtPb4HrGGBRsLXsQxgOCmNvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YeJ3c3SA; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YeJ3c3SA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYpkTsou7E5DPVYO1mnDHYEQbbK/68PzZsoFjav7Gb+0BOwsRAWeY8zUKSV7PmhKrq1GjTfq4vLPXjMqP8zR5s3eh+o4TK/YzknMQGwioZ3MlHaRK/1Wd1hvnPqtPbH+mfwaqMILkIsuV6vPdCFdS5KPt1aYRw/2vfUP8N/TD+oYSApTM03VsgpwDDMvzXnSwxQngapBk9ZDVArANyZwrFjMYhUGRLmmCjHVpOYHUCvxqSGDja0DlGJ3NydXgW0tx5CHYtQYFeGHsaRyLhfHqFu0HuGDxi5ksNxydOUVKa2cl5NN/0zb+cfIib8OAInTY27jnHnh5t0Ltoj/j6ERxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7c6GqDExzd5GomVp6fuxVnJsIB/+JPXO+Iym9ouQ6o=;
 b=gp8ZfzGqIp3RMRL1hXPkx5FUktsUE7Ub+PBv5DY41Mjiv/OtIB+SiLVSEbDK5Ssng2slYv+9RfxuQIPNXpdgH1ididmYd7dgVBE/sEBV4vuKZAi8cvME9aYnb3s4nguxq0Y+TGXLyjWtS6FWGTpF3ivPhxuyjy1ghxrRnTlzJKV/FiUrSuuAdUyIXtfxrBoU0VM1KL8k8c5HO67CyWQVizCdCA86V3Sqgo9/Qx5aWtjn8i0YGtkcTG1YEBRgcx21q0QuvgqZEXRd+qjFmLOEEhD0gxssVDjb/CNf7PO+9nLk3VVIW1etLkgmaSvDLiCepiUzT+gyGZqsPsNe0kQZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7c6GqDExzd5GomVp6fuxVnJsIB/+JPXO+Iym9ouQ6o=;
 b=YeJ3c3SACuXTOC0mZpyEnnQ50EIqtNjQoFd/jLJWOBMR/o8MWW+eVWn2Q1jTa66O0RAOfzPqkrfcQXmZ2iA2cfNKZcQMyAY/VZXSt1zHDlzKoHrgWgWLrXFKuKnbK+IThrv3RhwM7i9AvyLj+u9ojqA5mQUT7RKdYT48h0v7aUk=
Received: from BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::13)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 03:43:48 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:5b5:cafe::e0) by BL1P221CA0043.outlook.office365.com
 (2603:10b6:208:5b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 03:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Fri, 12 Dec 2025 03:43:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 11 Dec
 2025 21:43:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Dec
 2025 21:43:47 -0600
Received: from [10.136.32.146] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Dec 2025 19:43:41 -0800
Message-ID: <4f231fbb-d38b-4c0e-82dc-6b334f340943@amd.com>
Date: Fri, 12 Dec 2025 09:13:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] perf sched: Introduce stats tool
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <james.clark@arm.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<sandipan.das@amd.com>, Cristian Prundeanu <cpru@amazon.com>, "Sapkal,
 Swapnil" <swapnil.sapkal@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
 <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com>
 <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: ravi.bangoria@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d3d5e6-429c-4136-b467-08de3930a8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm1zUVpiZzg3M2Q1Z3JXMkNQZHdaL1AvcDc4VEZjWFBKNVltZi9QZEdWckVW?=
 =?utf-8?B?RDluKytkUTFNQlFKbFVTSUUxL1BEZkhZYnNzeXA3Z2lNRE1YaUJQL1ZGM1NQ?=
 =?utf-8?B?aXpsemxYRkwrWXNlMjhiMXpEVW1hbG5DSmlaTXpibEQ2bTlYOHNSbjRad0tQ?=
 =?utf-8?B?MWRVUmZiRmplY3h4aldUWG5DV1FNOXJZTnBzckNUUyt2WWRPczExODV4MnBz?=
 =?utf-8?B?VHFFN1FUalNPU0JmQ1dtbWFFQVJ4MlRyTEZGcGNva0tuU0VEQXRqK0hQMlVJ?=
 =?utf-8?B?ZG5KaTZUVnhXcjlydWU5eWZETFRDWm00WVIwUFV1MUMvYmYrdFAzN1QycXdE?=
 =?utf-8?B?QXl6RzMrUkNuYXNBdXRhVVdwby93bzB6YjA3ekJ4Q1lSaStodVI3ejhCTUlL?=
 =?utf-8?B?NkhaYXdQOFFrcFQ0KzcrbjFsS0plQ2xvZjlPR2toMjJlMUgwb3FNckp3WldK?=
 =?utf-8?B?VTR4MEhhblg4YWlqUUhiMkZuNmhxRVlUa3BhZW9JU3lnSVpiN1JJR2ZuZDBp?=
 =?utf-8?B?aWFpZXpGQlhqYm1nUUdrN1RtVDZRWUlLam5mcWdhQlNoM0tqTTJEQm9xMjFF?=
 =?utf-8?B?SnpCWXpOSU9vSUdJUTdmRWtaTHRHa1BlT0h5THUwdVdHaWEzWHQ3MGdWRmRE?=
 =?utf-8?B?cmJQSmYvb2ZQckdYTjQ2SzhqMFRvdEpLYy9YS25mYlFZNnVqUjZiNG1iWGll?=
 =?utf-8?B?RE1HTUVYZEtpTnN6L2wxZFk4eEszYnc4aVMyNE1iMG1ZbVZJQVZpbVBYQ0hj?=
 =?utf-8?B?d3Q5SkdYWnM2elNJeHBwMUJEUVYvTTgzRGxKbEp2MlRSdG9oKzByVzVEdytQ?=
 =?utf-8?B?bEJqa01tWWtMQ3RsT0lIa3dHTzkzRVY2dlJweWtyY1ZPWllMbW45NmpzMjAv?=
 =?utf-8?B?T3AxOVBDTlQzak9vV1VMcVhYcUI0VlVDYTZSVlpJc1dMTjc1NGJRWmNVSm1o?=
 =?utf-8?B?TmM4UnZwNXhHZ2FsRGRITDVkbkJQemZDemJmOTJvUU1HQng4OC9pRFMrQzV3?=
 =?utf-8?B?U1l1VEpxVVRaVnoxMUpNTmc4MmplVXNXMmNremVBY09yekRhQXpzL0hiNW1u?=
 =?utf-8?B?allsNGNlMll3cG9aNkFxMkswZVRpc1ZEZk1CT2xHNk1hQlI2N2N2QkZOcW90?=
 =?utf-8?B?bS9MT2l4YmxWOGpCVlFKNlZ6S1E2aEVUVWh1NHhqcjNPL3k1Y1ZJTEJqM04w?=
 =?utf-8?B?NEE5bHFLMjlldzRobEhHaGVOZk14VVBjWW9zOVNJYzNWdUswbnV2WEhEbnZ3?=
 =?utf-8?B?RUpXQ2kwMUtKeEs0dDZWS05sQkFiQXJkUVh4ZVlpVmtXbnk0ZUdwdHFsK05C?=
 =?utf-8?B?NGFnbFFJRlBwN1dFZzVUTk4zTHBqbUY1T2RoRE5aT0lSc2xaejRWWG8rOGVL?=
 =?utf-8?B?UzB0am5aWERaa1c5YmpVNUN6VGJmeE1qNTJkYXFtR1podFVyQmtkRTYzc09p?=
 =?utf-8?B?Z1grTVEwTlFiaThPTGhhUjNKU0Mvc0p3RXg4RjVPVE5WdWpEMkY3UGhlZ2dq?=
 =?utf-8?B?RG8xQXdhbStyL09vd1Z0T2lDMTRTdTdLZ1g4dEZqM2xZaS9OVCtsalM5T3RY?=
 =?utf-8?B?azMwcTFnSXpXaldGbkgvWndlMDF6ZW1sQ1hDZ1Z6L1ZWS1N1YjBIZFM0b05a?=
 =?utf-8?B?STdnYjZJcEs0ZDczUWZURnNLcG9aVzA5bDVMbndRdlFCL1Bob2VnQjJrWTNy?=
 =?utf-8?B?NDNHYXB1ZUEyNTV3TmZwL3kyekhWVm5Md00rQUkxWWFwdmw5bm1wcHd0MHdH?=
 =?utf-8?B?cHU5YXAxRVVtRXh4cTdZS3lQRFppdDIxWFhaaFBzek9GQkVaZjJ4ZkNMVzYw?=
 =?utf-8?B?VUhrajJHeTJpNGJLOTh1QUU2RjBkY05xdy9WUlU1UUs2VnVzYmd1dEtPTUNq?=
 =?utf-8?B?WDQ3MVVXcnJBZEpoM2pYRnVZc1B5K29vZml3S3k5ZDl4Z3UwS0cxdVRYL2dr?=
 =?utf-8?B?akR6RkNFNFdBenJYcEJkQWhtUFp0NDRYMVdFcUxJMkEyUGVVQ3JESG5yNUpO?=
 =?utf-8?B?YUhQV2tBeVgyTnJmWm5OU1N2V2JTcTBqSXRKVFdFaG42M0UxWXZWdnUrNlJS?=
 =?utf-8?B?R3dHMk4vMnI3R29XaVRIVjRrU204eDA4NGZRK0FsRzJRSHdwWHdlYzZraHZt?=
 =?utf-8?Q?vvH8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 03:43:48.3486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d3d5e6-429c-4136-b467-08de3930a8a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Hi Ian,

>>> Next is CPU scheduling statistics. These are simple diffs of
>>> /proc/schedstat CPU lines along with description. The report also
>>> prints % relative to base stat.
> 
> I wonder if this is similar to user_time and system_time:
> ```
> $ perf list
> ...
> tool:
> ...
>  system_time
>       [System/kernel time in nanoseconds. Unit: tool]
> ...
>  user_time
>       [User (non-kernel) time in nanoseconds. Unit: tool]
> ...
> ```
> These events are implemented by reading /proc/stat and /proc/pid/stat:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/tool_pmu.c?h=perf-tools-next#n267
> 
> As they are events then they can appear in perf stat output and also
> within metrics.

Create synthesized events for each field of /proc/schedstat?

Your idea is interesting and, I suppose, will work best when we care
about individual counters. However, for the "perf sched stats" tool,
I see atleast two challenges:

1. One of the design goal of "perf sched stats" was to keep the
   overhead low. Currently, it reads /proc/schedstat once at the
   beginning and once at the end. Switching to per-counter events
   would require opening, reading and closing a large number of
   events which would incur significant overhead.

2. Taking a snapshot in one go allows us to correlate counts easily.
   Using synthetic events would force us to read each counter
   individually, making cross-counter correlation impossible.

Thanks,
Ravi
