Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBD3CF03E;
	Thu,  9 Apr 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752202; cv=fail; b=TuGUCIwbcfahg8K0K1NFrLVaHK+8X+SUIgPSQl3GljbMErQK4A/6WEnfGmRi30M/wSFdE6sebcOD6j6rqsruYsiAoOY674Vgs6f2+2U1auVzh/UqUBrccUxaISsXpFLtus1eGA2Ro2vY33dq1N4OynUD5cfBsKiszbx70thxHKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752202; c=relaxed/simple;
	bh=fQn7oGoyJ8m/bL3rql4Oy7gBHnei2Cbet8di8Z2F5Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TidutwNA+6S0x9J+FurQfERz43Pczd8t1gDOMUeADrbMuEAWxd5EhnzcOSv5j2mHae/NiWgsNmjaOyYWAMdcF2CapT843Pid9e0cYAc2ThPgYOTMYtsfbCL01ydpE8MV0z0xo5RKjDl69JkIYv3LXcbNW9opgEVw8PTyevXiR3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lrp9ozqP; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lrp9ozqP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkY1zLGpFec3jzOuxwLC/3tiVm68BSINCEykhSWpTvIdffcrv0GIgf52DT+QBplS2qxpIo1NoIxyoPFfnXiEonHbddc7TJ1Y1+zHXzRmOtByx99TKCxjW3dNPSgqpKoyCAjfWvOxsQlIVXGtPbjwaw5vc9YN/1e+0fcwyKh305GGnho1Emm8qhXyxDhJ6gM+jUR2GRDD3+dJZfa8WGzgg5hmRFBsZLRew+uN93nsm4mKW6JLcjdXBMcnqPPAfGVusnqOJTrQRP8OlLu23pc6f9KCQ+mEdNldj+y8PJzk14XEeJbk4VXK6n4YrrVq3qkR6hJvgiOJ5pykF/Ml26h1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k2YTGi8wgx18U5bicJsoylp+NGjO9Dh/1LHWL2h0E8=;
 b=aAsit+XFaNDZxDANbbbXh7Wlxba5LTjKkzVLGFYRvp5u/NA8aUC0PDWU/C9W83vDpqCWERs36k4nEdaVNGCZ9r/fvgBrJo/ZNf1D7mGXH1xzoUuXvZobVAdJFSBAGPs9Wll31WMkNi4vzInX2coJ0Y0l16IGPJ+vVCeJumSJtbrLWaR2i7Eg/IcQAvc/3l4xHNCDgbh/OVXCAqJT6xrV6cJUGnyD7BMw3H2LSebdRFmOL+zm69I1Er/gjgTHBlwHyebz9nADb1VjVENZwcUr3TH5w2FxG70rx1JQhLbk47P2URhHOTEPTfi36IrhKqbnmdOZyUVIQboneH4DCu3Jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k2YTGi8wgx18U5bicJsoylp+NGjO9Dh/1LHWL2h0E8=;
 b=lrp9ozqPlfGtQUzYdgofI9RJ449b+swsTnUuPbR1W5/kINJeU0nzqxfIyOKOrdONsCu6sD76mOs5vLMscS2E/ab5ux4wGOgYV6cs8OSN7S98/EzEP41UsgsP/ChqJe1IPThZ8Dxw0b4juAMgOImF2Vin20NzIrxNP6iOzUyKU20=
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Thu, 9 Apr
 2026 16:29:56 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::f8) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 16:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 16:29:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 11:29:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 11:29:55 -0500
Received: from [10.252.197.136] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 11:29:50 -0500
Message-ID: <f034e394-6597-4fea-be07-69fef438ed29@amd.com>
Date: Thu, 9 Apr 2026 21:59:44 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf sched stats: Fix SIGCHLD race in
 schedstat_record()
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <james.clark@linaro.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <ravi.bangoria@amd.com>, <KPrateek.Nayak@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260401064114.141066-1-swapnil.sapkal@amd.com>
 <20260401064114.141066-2-swapnil.sapkal@amd.com>
 <CAP-5=fWY7X6Zo2xFXHbPtU2Dob=eHguzbkzowHjqyBzsse2+-Q@mail.gmail.com>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <CAP-5=fWY7X6Zo2xFXHbPtU2Dob=eHguzbkzowHjqyBzsse2+-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: swapnil.sapkal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 048f952e-27b7-4898-bfc7-08de96553c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	//XY/YafmTYoao7Nxps6xKq5ciyoe48NkD5JJ1NdMrfBE/tV7wiRGctZdDLadwuuBfWrv62GdJUA2KJvyQ0yaAtmM9g7E14C0FTdVyQo1iQreKCeinPfuk10a7qwk3eCtBqlSABa+LiCnHcLPJf8AIEVKFeHbhzxoCcFd/7pyR7PsHkZHbaoUqsHToN/JCG4CBDUm6/JjuMvcT0WrhgvdOZbhqUuewx+A23f3IDP3DcqrsfFtqzaJhZZoRA82ksL+PcQALu1CwPiIxT4rfq2YGxqbbU+/ZcQEJzuE6vZsmdWEg1xNGeM3GOqHt2tRP7ZJ/FG3GcuK6J3jQR8kGBH6bHy2IA0IigtIuxfBy+foopCgtjT2vAVNkUi2RcD1NWvJqV8oU7RD0E6VtV6QM+mBSqUyZahDBVXbScJARFj0p7VH84SsQ5ep6+FENRbIhCg5CHVjGbl7ALET7c9AD6Yeag7Fdcykpq21ZvgsveQi1zyTuFGuKiIcRSF6nZ1K1uHtw6VbQCTUeBS6YDbU3Su0RMXq+vb9ypeQx4S09XMcnqv0tslEkgUDmoxLgVVbS30/sz7zjVab4LUTY17MbW2LAagkCeZiks1vzW9mlYxEjweKXXtnVojrNrk4CpuOWVMIqb9UHSqJopREtsLArOaHssBEKoQiIR2Iw1WWzKbXQYC5ve5zrK0cNEEbfnnLpHG0rj1N5RdD/wzF35XKW0QBjmblBz9kUC24WMkaZZ/9FA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A3Zl32YlI20loFsRHQLpHlnCXfUiWaMkOt+by7Wltuf4P3ThehkI2/4LwPZscT8cHva9bq3++UY7TykGLkpqncz58aVBBG8pN/6h7Y5IGp/G7y64v75FdbIteQFpGJDKExdW5rFtfo6xofwN8VBbg/kMNEtb2oCprswbVpl0IckHu8ZZRbQ6+AH6jvXg1U5jRRqxWUjGCXjpZiGfnLbnXxmeijU07hSEjAcKhTP9iDQojOLj7iq3zqacI26OSQJDxPgsnvmYIN/trtfN2GVgBeVrjdMqkT9lO0L66p2fkOE7DaQqbEPoMKO1cb8VzMJSFr9GpxJsSaMaw9QnbFthvO3PiJlRnFQBugf7d7AcFjWphPBrLBeRuRazGb5/KoXYCC0gAqzXW8/1wshGUCQW7OPndzyiaMOKYKHCMh/0w3q3cmx2F0v1zhfPYajnap6f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:29:56.0883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f952e-27b7-4898-bfc7-08de96553c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

Hi Ian,

On 01-04-2026 21:56, Ian Rogers wrote:
> On Tue, Mar 31, 2026 at 11:42 PM Swapnil Sapkal <swapnil.sapkal@amd.com> wrote:
>>
>> When a very short-lived workload is used with 'perf sched stats record',
>> the child process can exit and deliver SIGCHLD between
>> evlist__start_workload() and pause(). Since pause() only returns when a
>> signal is received while suspended, and the SIGCHLD has already been
>> delivered and handled by then, pause() blocks indefinitely.
>>
>> Fix this by blocking SIGCHLD before starting the workload and replacing
>> pause() with sigsuspend(). sigsuspend() atomically unblocks SIGCHLD and
>> suspends the process, ensuring no signal is lost regardless of how
>> quickly the child exits.
>>
>> Assisted-by: Claude:claude-opus-4.6
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> Thanks Swapnil! In the Sashiko reviews there were some nits about
> clean up on error paths but also 1 about signals potentially being
> masked in the perf workload:
> https://sashiko.dev/#/patchset/20260401064114.141066-1-swapnil.sapkal%40amd.com
> Could you take a look?
> 

Thank you for directing me to the sashiko reviews. I have addressed the 
review comments in v2.

https://lore.kernel.org/all/20260409162249.25581-1-swapnil.sapkal@amd.com/

--
Thanks and Regards,
Swapnil

> Ian
> 
>> ---
>>   tools/perf/builtin-sched.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 3f509cfdd58c..eb3702d98fd1 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3807,6 +3807,7 @@ const char *output_name;
>>   static int perf_sched__schedstat_record(struct perf_sched *sched,
>>                                          int argc, const char **argv)
>>   {
>> +       sigset_t sigchld_mask, oldmask;
>>          struct perf_session *session;
>>          struct target target = {};
>>          struct evlist *evlist;
>> @@ -3822,6 +3823,15 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
>>          signal(SIGCHLD, sighandler);
>>          signal(SIGTERM, sighandler);
>>
>> +       /*
>> +        * Block SIGCHLD early so that a short-lived workload cannot deliver
>> +        * the signal before we are ready to wait for it. sigsuspend() below
>> +        * will atomically unblock it.
>> +        */
>> +       sigemptyset(&sigchld_mask);
>> +       sigaddset(&sigchld_mask, SIGCHLD);
>> +       sigprocmask(SIG_BLOCK, &sigchld_mask, &oldmask);
>> +
>>          evlist = evlist__new();
>>          if (!evlist)
>>                  return -ENOMEM;
>> @@ -3902,8 +3912,15 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
>>          if (argc)
>>                  evlist__start_workload(evlist);
>>
>> -       /* wait for signal */
>> -       pause();
>> +       /*
>> +        * Use sigsuspend() instead of pause() to avoid a race where a
>> +        * short-lived workload exits and delivers SIGCHLD before pause()
>> +        * is entered, causing it to block indefinitely. sigsuspend()
>> +        * atomically unblocks SIGCHLD (blocked above) and suspends,
>> +        * ensuring no signal is lost.
>> +        */
>> +       sigsuspend(&oldmask);
>> +       sigprocmask(SIG_SETMASK, &oldmask, NULL);
>>
>>          if (reset) {
>>                  err = disable_sched_schedstat();
>> --
>> 2.43.0
>>

