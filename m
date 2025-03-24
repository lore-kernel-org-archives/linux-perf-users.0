Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477A3FD1;
	Mon, 24 Mar 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807775; cv=fail; b=lfOrzCxgVhPZLu5NJcaygy1hQywqIV939iWQ6Wmxg8pd19dX4VdOirHA+pGFi9t7HtwqIPadcTwn9YHLwBHF+ZfN7Y7d2BxoMbDvVNlebNG47mdnaEjZdSES4Zlx4JN2CQqFzbm25coiG1AkMlhwobpfElRC6a3L4adopUphBDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807775; c=relaxed/simple;
	bh=6sY+2xPzlWphig9NrM6faInrnQT1Gy6ccQ7e7i00WPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LlJZGn2XFYhYPOZp9NSFYRX8hYWZOB9VgIwFe7esgJp/4ovLucuPCaF0O3WJskjO9ap2IaJjpMQfQB3lqA559w5QbStkQwURZJHfi8AQHj6PAcck/WC7KTfRjcvuv4fIVqK1bjlZTpSOjY+lysnJtZhchl7sPrEXYJjftDieOFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZUdAWQXQ; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZUdAWQXQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV6Zqe9wmV8KaxYnfNqlSjfFI+JL6zFMbWsBoUXtpvq/snJ58VhvmyLZbnIBBa/3u5KERTbqJATC/Dt0SCAC4WOquphjLf4HEYtfXm4MFXhB2EDjl/Ri79OPj63dY9o5/6gVrWABbUYT0n2ViAL9gFZc1qDxXkzPY1Iu+DlcaqvE1N6U2IzCybt0CqFsYyAp7H0lrTBwFjF2FT0nD0HJ/VED5GByPAPhjmlxSJKGpPTG9EPWZ/GLDtd9d25Z865rBLZ4gyF0C/OtR/Mlf7aSPwoyAO3d3GHzyg/NCuPoq33YUhOE7DOM0iu8v1nIaumFJA/9R5kTnMj/DHOw/82dPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyxa8xf/BOAQzh5Xcde9M0pvjBp5WyMXsCJE7G96Mo0=;
 b=sJnVDng3z/QnS1Smy7gonyP6jQtSFSdb/Hs4P4iHY8MheRw+dAPx3eZY0FaT+CP3MSc9ZpDKuLsKqfT9WneBa6RBhzXyEIgBWRnS9TriMRv1VEXNd50fStM2ILdATbTyg6mjZUHjZEhutOPRnvx8H3NogQ13Xg0YIW3Em9BPa7c1XcspdvodLb48AVOoB2DpXwRFP/Lp/6gwVTmIhz5YICNO4Bhnae1kWCMXeFIe5Plx78dbdzYY6hzraMrDdi4YIzhhRpm5SlOOsEHc/J21p+XHIuijE5ofdCP8zG+FzieYbWWPtPlEmv9PZjoDtFdkad/JOFybcOo6p0PHe+I+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyxa8xf/BOAQzh5Xcde9M0pvjBp5WyMXsCJE7G96Mo0=;
 b=ZUdAWQXQPUCfGAdu7uLvx+M8rxl73Z+lJX983VaUCKJKfwOHhn5oTlVrQRsBepNbHNnA6/GH6jvWB5frgJ7kNAJQkYtp+wkhmtZrVV6UJwrDEcFsmgrfsDuyDZNtM1F7ucrmgHvcFWyeMkzZetUHP8y5aXBw6tas2DseQ+rBR3s=
Received: from BL1PR13CA0339.namprd13.prod.outlook.com (2603:10b6:208:2c6::14)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:16:09 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::9e) by BL1PR13CA0339.outlook.office365.com
 (2603:10b6:208:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 09:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 09:16:09 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 04:16:00 -0500
Message-ID: <01671eda-c8f3-4093-a782-2c73b4a73b12@amd.com>
Date: Mon, 24 Mar 2025 14:45:51 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] perf sched stats: Add support for live mode
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
 <20250311120230.61774-6-swapnil.sapkal@amd.com> <Z9UGEaypiEbOuhHv@google.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <Z9UGEaypiEbOuhHv@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d51035b-5925-4038-6291-08dd6ab483ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGhDaHZ1MFdPeUpXd0h5YVVObmZIN2ZKc0R0RS9BbkdJR1UrbTUxZkQ1RVl0?=
 =?utf-8?B?dnBRZjhzaGNlWmlkdWp2MS9xcXAzcVQ3ZyttU0RFL1hQaE5PU2w5TkMzc2pY?=
 =?utf-8?B?OXVHa0c0WXlvWVV2b3pGRHNucXFHejF0R1NYZUhtSmRuUFd3OW9JRVZyUjV5?=
 =?utf-8?B?SnFMQmRtZHh3TVAwejNNd1FqVDBReTRIVzZZYzBOMVFjRlRaQnR4Nks1RjJa?=
 =?utf-8?B?MXhxcVFobWVMb2lpQlpKbHdXb1NIZGF1S2lybWhJYjFrdkR0UWhyMHBLUFdj?=
 =?utf-8?B?WUpQZ1NTUUR5REVISFZaUW5JUUhqMEJWNGYrV2R1Z2g4L3BCZnN0ZXNpbFBT?=
 =?utf-8?B?OENxS1huU1NEYlpGWFFVc2FQUmhCN05zWE5yUHpPSUgzWEhTaWlvcUVvNEhh?=
 =?utf-8?B?S2RnazVyWkgvOWlXam5hOVM3QWFDZFNKdkJ5U0FDcVgxYmZtMTF2dytURHE2?=
 =?utf-8?B?OHVwNXdvTTFxWHNvRFkxVE9iWGNrMnNHKy95ODJFZVZxUzBNNHBwK0pmYmht?=
 =?utf-8?B?VkhlL2gzbDBvOW5yNWFuWVlTbFZ4bkNsM1pWeWx1a0l2Y0tTVkJPcis1Q01S?=
 =?utf-8?B?bVJaYkIxUStaalltREFJZWRGYTNtbkY2YVp4eXgrZkdzQ202ZllSTjh4NFZp?=
 =?utf-8?B?YnBqSXdWSTUwUjlyc2FtTVl4T0VRaklKSG9FY2NIV1JuUk8wWmdIMVhtdFFS?=
 =?utf-8?B?alQyUU1maWdpRDV3OGlYY0UrVGpobFBzYXE3V3dBM2N3ZlFqS0d2NlZJd1VU?=
 =?utf-8?B?Q0JkeW4veG9IRUFQNkthaE8vbEVydEo1aEtnc29wSSs3U0dOZUJzemhpL1hQ?=
 =?utf-8?B?cFlOWThkQW5GZFJrUTNzKy8zY1JYeHdNc1dLQi9CbjhWYkN0Q2FPV2o5TGcv?=
 =?utf-8?B?OXRlTDh2UUdqS3RCZ2hBd25ZMWJaQWMxM1NFYXhiN1o4ZGcrNzBsRGQ0Z3g0?=
 =?utf-8?B?QTZmMEZ0aTdyUFZwUExYZk5BWlYxL0tMV085RU1YUnFQM1BoNTg0RmI2S3ZR?=
 =?utf-8?B?WTBva2lMWWwwZys4Zjg2YjI4ZEwwQm1kQ0RFdTl1cTFHZmNNbEVUV2RJdFpw?=
 =?utf-8?B?SGdVOHBRb0s5c0MwRnhQNXN6OVp6cWczaWxDaTRRWCsybjkrVEhGOTZtMzF1?=
 =?utf-8?B?eUkxa2IzY2lIZnNNTzBaSW1sVW1VdmtUZ0txY0ZTRE5LcC9LMS92Z1htWjZp?=
 =?utf-8?B?L3JRa1NQWlRHaHJFbXN0RGFKNGFrTEI1dkwweWJKZHFxVUFYSEFINm1RQTU4?=
 =?utf-8?B?QVF0Uk1RQ09oNE5LUHJqN1A2dG5pWkpFc1dKbWNEQlcvelNQM3RpUVM0OTJ2?=
 =?utf-8?B?MzIxTTg1R2tJSjVBdS9pMytuUDRBaTN4SzV6aHp0dTFYblpzai9lUTNUWTlx?=
 =?utf-8?B?VmNreGpwNm14cTY0WTdVQ2xhUlpVMjlVVWRSOUJzcW9zeXgrYU1NdVlUelRI?=
 =?utf-8?B?RWJDSVp4MmpzVjBDNWJWeERlZlJMN3Y5Y0g2MUhTUTduQlIvc0Zrd3hNL0dx?=
 =?utf-8?B?UVNBWDd5SG1aa3BFSXB4Z0laOXJQLzNGQmhLdlg2NEZ1QUptVHE1V1hSRjVl?=
 =?utf-8?B?VjNPM01kZ20rZlpWU3NscElmUGpNNUxid0ZadXluOE0zNnh1M01xRU04Mnkz?=
 =?utf-8?B?ZnNjYytuSmRiSEptSGVTK2sybGZ5aEdtVVB3cjE4ZkZhR3NGeENzRVI4cndP?=
 =?utf-8?B?bld2VkE0WjFxNDNQZm1udHZNeHNwa2txVXBTYjdUUktZa3RJSno4Q2NXNDc0?=
 =?utf-8?B?TXJLdDBYaTViYzNQcU41bHROL3hBNFcwdjJscWd2TFFJR2tHY2txdFhyQ084?=
 =?utf-8?B?a2N3cDJFZTNIaDRnWWVnTDFBMnhPTTdYb2FEdE9YTUw5NWxNRmZMYWpTVHo5?=
 =?utf-8?B?TWtFMk40MzdjTFNkK2dhZjFodGcxbWJhWjJ2Z2ZKOHZ4QVZPaHdzcUtJU0tM?=
 =?utf-8?B?VVZBbEFEZGdmWHUwVElDTGdyMlBCSHgvRi9HMG9Id3VWQUpCS296cDJRcUhF?=
 =?utf-8?Q?rqsInzMNYnkRA5jQlrOlHqgDER+Gjg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:16:09.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d51035b-5925-4038-6291-08dd6ab483ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567

Hi Namhyung,

Sorry for the delay in response.

On 3/15/2025 10:16 AM, Namhyung Kim wrote:
> On Tue, Mar 11, 2025 at 12:02:27PM +0000, Swapnil Sapkal wrote:
>> The live mode works similar to simple `perf stat` command, by profiling
>> the target and printing results on the terminal as soon as the target
>> finishes.
>>
>> Example usage:
>>
>>    # perf sched stats -- sleep 10
>>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Tested-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/perf/builtin-sched.c | 87 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 86 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index e2e7dbc4f0aa..9813e25b54b8 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -4364,6 +4364,91 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
>>   	return err;
>>   }
>>   
>> +static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
>> +					  union perf_event *event,
>> +					  struct perf_sample *sample __maybe_unused,
>> +					  struct machine *machine __maybe_unused)
>> +{
>> +	return perf_sched__process_schedstat(NULL, event);
>> +}
>> +
>> +static int perf_sched__schedstat_live(struct perf_sched *sched,
>> +				      int argc, const char **argv)
>> +{
>> +	struct evlist *evlist;
>> +	struct target *target;
>> +	int reset = 0;
>> +	int err = 0;
>> +
>> +	signal(SIGINT, sighandler);
>> +	signal(SIGCHLD, sighandler);
>> +	signal(SIGTERM, sighandler);
>> +
>> +	evlist = evlist__new();
>> +	if (!evlist)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * `perf sched schedstat` does not support workload profiling (-p pid)
>> +	 * since /proc/schedstat file contains cpu specific data only. Hence, a
>> +	 * profile target is either set of cpus or systemwide, never a process.
>> +	 * Note that, although `-- <workload>` is supported, profile data are
>> +	 * still cpu/systemwide.
>> +	 */
>> +	target = zalloc(sizeof(struct target));
> 
> As I said, you can put it on stack.
> 

Sure.

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
>> +		if (!user_requested_cpus)
>> +			goto out_target;
>> +	}
> 
> How about this instead?
> 
> 	evlist__create_maps(evlist, target);
> 

Sure, will use evlist__create_maps(evlist, target).

>> +
>> +	err = perf_event__synthesize_schedstat(&(sched->tool),
>> +					       process_synthesized_event_live,
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
>> +					       process_synthesized_event_live,
>> +					       user_requested_cpus);
>> +	if (err)
>> +		goto out_target;
>> +
>> +	setup_pager();
>> +	show_schedstat_data(cpu_head);
>> +	free_schedstat(cpu_head);
>> +out_target:
>> +	free(target);
> 
> 	evlist__delete(evlist);
> 
> and unless you use evlist__create_maps().
> 

Ack.

> 	perf_cpu_map__put(user_requested_cpus);
> 
> Thanks,
> Namhyung
> 
> 
>> +	return err;
>> +}
>> +
>>   static bool schedstat_events_exposed(void)
>>   {
>>   	/*
>> @@ -4686,7 +4771,7 @@ int cmd_sched(int argc, const char **argv)
>>   						     stats_usage, 0);
>>   			return perf_sched__schedstat_report(&sched);
>>   		}
>> -		usage_with_options(stats_usage, stats_options);
>> +		return perf_sched__schedstat_live(&sched, argc, argv);
>>   	} else {
>>   		usage_with_options(sched_usage, sched_options);
>>   	}
>> -- 
>> 2.43.0
>>
--
Thanks and Regards,
Swapnil
