Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B92AEE1;
	Sun, 30 Jun 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729208; cv=none; b=g4RdLQzvuD/CZss0ghsQ1JTg/9S2oKMSlprmHlHg6/mH34rsYmj5Ne+gADHNny7IbAI6SkuplN292RC9eZDShGXgAcZ80FKPldBTmhocP20i+WWHxMcZ/n5/pRLxuQXyXxIRDU8+GoSv6AwYBvn13ollL/qjRlCRCoq860Itk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729208; c=relaxed/simple;
	bh=HBgKbzkj0SkReyrrdt7Vez/Qcb+RbShgw6yjHP91ATQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EL+g+Iwl1CpIVXCdQY3BBNHbIfnBZmyOxg51WU7yDMlJaR5CYz0ZFr8tmr1Bsz4+NPoLLJ/9LglHiiYEMlQ2NU/glmdLGLV7VbCbLRmhF+uNeO74Wwxqe1WDQxQXmqH55BPRUAG+4wUNVBPspc6xEKSXQrDKfFQ376h8OfuuLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gnFpJMZt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gnFpJMZt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45U6R6Dm026200;
	Sun, 30 Jun 2024 06:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=4
	Q4u3kImCKhiZGpQGm/yMSvwiDugnXBEQTHE858CdQQ=; b=gnFpJMZtAtSXXExbQ
	mofefSEkVtBaEFhRYquf2uvMXXg8pLjq32/e4BSqhmLkxUVeu+dZo3kvImhSmJn+
	GPquyKBwS0w9u+cPWf8408ru8R+//s0akhvRVlGA16XDdlQ9KqrYvuAa1zM84T8n
	hGJGc1Z+qG4hkgVe6jP2dIVeNza9fBuFhkji02RbsodHCyG23xu9gC42G6ysBfbA
	p5cX7vv4OjUWl7tToahqRjdowsFJMlEhEEc9csWeiXPBQzCq6izy0sK1ZF6dSYO5
	lAImCXOH0ODcIILRBC2fV309lA42OWyPrb9yPoBwpWrlzxgvdhXK9eHzFFfPKg48
	Ys0xA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 402yw6g8a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:33:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45U6XAUl002375;
	Sun, 30 Jun 2024 06:33:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 402yw6g89x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:33:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U4npXO005985;
	Sun, 30 Jun 2024 06:33:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vkts6kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:33:09 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45U6X6CE13763156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 06:33:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0E6D5805D;
	Sun, 30 Jun 2024 06:33:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BA1958054;
	Sun, 30 Jun 2024 06:32:55 +0000 (GMT)
Received: from [9.43.35.135] (unknown [9.43.35.135])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Jun 2024 06:32:54 +0000 (GMT)
Message-ID: <1b9ab802-d825-4826-b298-b69ef844063b@linux.ibm.com>
Date: Sun, 30 Jun 2024 12:02:52 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] perf sched map: Add task-name option to filter the
 output map
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>,
        Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
 <20240626091550.46707-2-vineethr@linux.ibm.com> <Zn3yFucQlvxyhzki@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zn3yFucQlvxyhzki@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F5tRQ0hpv59dhcSIP31E8ZwBa8eHAwaL
X-Proofpoint-ORIG-GUID: KusDrHI9Awr5TPsNlbwPRAUHg0C8mBMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300047

Hi Namhyung,

On 28/06/24 04:43, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Jun 26, 2024 at 02:45:48PM +0530, Madadi Vineeth Reddy wrote:
>> By default, perf sched map prints sched-in events for all the tasks
>> which may not be required all the time as it prints lot of symbols
>> and rows to the terminal.
>>
>> With --task-name option, one could specify the specific task name
>> for which the map has to be shown. This would help in analyzing the
>> CPU usage patterns easier for that specific task. Since multiple
>> PID's might have the same task name, using task-name filter
>> would be more useful for debugging.
>>
>> For other tasks, instead of printing the symbol, '-' is printed and
>> the same '.' is used to represent idle. '-' is used instead of symbol
>> for other tasks because it helps in clear visualization of task
>> of interest and secondly the symbol itself doesn't mean anything
>> because the sched-in of that symbol will not be printed(first sched-in
>> contains pid and the corresponding symbol).
>>
>> When using the --task-name option, the sched-out time is represented
>> by a '*-'. Since not all task sched-in events are printed, the sched-out
>> time of the relevant task might be lost. This representation ensures
>> that the sched-out time of the interested task is not overlooked.
>>
>> 6.10.0-rc1
>> ==========
>> *A0                              131040.639793 secs A0 => migration/0:19
>> *.                               131040.639801 secs .  => swapper:0
>>  .  *B0                          131040.639830 secs B0 => migration/1:24
>>  .  *.                           131040.639836 secs
>>  .   .  *C0                      131040.640108 secs C0 => migration/2:30
>>  .   .  *.                       131040.640163 secs
>>  .   .   .  *D0                  131040.640386 secs D0 => migration/3:36
>>  .   .   .  *.                   131040.640395 secs
>>
>> 6.10.0-rc1 + patch (--task-name wdavdaemon)
>> =============
>>  .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
>>  .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
>>  -  *-   -   -   -   -   -   -   131040.641379 secs
>> *C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
>>  C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
>>  C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
>> *-   -   -   -   -   -   -   -   131040.641581 secs
>>  -   -   -   -   -   -  *-   -   131040.641583 secs
> 
> It seems the last two lines should be like below..
> 
>   *-   -   B0  -   D0  -   E0  -   131040.641581 secs
>    -   -   B0  -   D0  -  *-   -   131040.641583 secs
> 

Sure, I included the line only for sched-out, but I will change it.

>>
>> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf-sched.txt |   6 +
>>  tools/perf/builtin-sched.c              | 161 ++++++++++++++++++------
>>  2 files changed, 131 insertions(+), 36 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index 74c812f7a4a4..3255e5b8e74b 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -130,6 +130,12 @@ OPTIONS for 'perf sched map'
>>  --color-pids::
>>  	Highlight the given pids.
>>  
>> +--task-name <task>::
>> +	Map output only for the given task name. The sched-out
>> +	time is printed and is represented by '*-' for the given
>> +	task name
>> +	('-' indicates other tasks while '.' is idle).
>> +
>>  OPTIONS for 'perf sched timehist'
>>  ---------------------------------
>>  -k::
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index aa59f763ca46..57f166662d54 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -156,6 +156,7 @@ struct perf_sched_map {
>>  	const char		*color_pids_str;
>>  	struct perf_cpu_map	*color_cpus;
>>  	const char		*color_cpus_str;
>> +	const char		*task_name;
>>  	struct perf_cpu_map	*cpus;
>>  	const char		*cpus_str;
>>  };
>> @@ -177,6 +178,7 @@ struct perf_sched {
>>  	struct perf_cpu	 max_cpu;
>>  	u32		 *curr_pid;
>>  	struct thread	 **curr_thread;
>> +	struct thread	 **curr_out_thread;
>>  	char		 next_shortname1;
>>  	char		 next_shortname2;
>>  	unsigned int	 replay_repeat;
>> @@ -1538,23 +1540,89 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
>>  	return thread;
>>  }
>>  
>> +static bool sched_match_task(const char *comm_str, const char *commands)
> 
> It'd be easier if you pass the sched pointer.
> 
> static bool sched_match_task(struct perf_sched *sched, const char *comm_str)
> {
>    ...
> 

Sure.

> 
>> +{
>> +	char *commands_copy = NULL;
>> +	char *token = NULL;
>> +	bool match_found = false;
>> +
>> +	commands_copy = strdup(commands);
>> +	if (commands_copy == NULL)
>> +		return NULL;
>> +
>> +	token = strtok(commands_copy, ",");
>> +
>> +	while (token != NULL && !match_found) {
>> +		match_found = !strcmp(comm_str, token);
>> +		token = strtok(NULL, ",");
>> +	}
>> +
>> +	free(commands_copy);
> 
> Why is this needed?  I think we only support a single command and then
> simply check with strcmp().
> 

Sorry about that, I got confused while splitting into different commits. I'll fix it.

> Also if you add multiple string support, you need to parse the string
> when you parse the command line arguments, not when you match.
> 

Right. Will do that.

> 
>> +	return match_found;
>> +}
>> +
>> +static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu, int cpus_nr,
>> +								const char *color, bool sched_out)
>> +{
>> +	for (int i = 0; i < cpus_nr; i++) {
>> +		struct perf_cpu cpu = {
>> +		.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> 
> Please fix the indentation.
> 

Sure. Thank you for the review.

Thanks and Regards
Madadi Vineeth Reddy

> Thanks,
> Namhyung
> 
> 
>> +		};
>> +		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
>> +		struct thread *curr_out_thread = sched->curr_out_thread[cpu.cpu];
>> +		struct thread_runtime *curr_tr;
>> +		const char *pid_color = color;
>> +		const char *cpu_color = color;
>> +		char symbol = ' ';
>> +		struct thread *thread_to_check = sched_out ? curr_out_thread : curr_thread;
>> +
>> +		if (thread_to_check && thread__has_color(thread_to_check))
>> +			pid_color = COLOR_PIDS;
>> +
>> +		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
>> +			cpu_color = COLOR_CPUS;
>> +
>> +		if (cpu.cpu == this_cpu.cpu)
>> +			symbol = '*';
>> +
>> +		color_fprintf(stdout, cpu.cpu != this_cpu.cpu ? color : cpu_color, "%c", symbol);
>> +
>> +		thread_to_check = sched_out ? sched->curr_out_thread[cpu.cpu] :
>> +								sched->curr_thread[cpu.cpu];
>> +
>> +		if (thread_to_check) {
>> +			curr_tr = thread__get_runtime(thread_to_check);
>> +			if (curr_tr == NULL)
>> +				return;
>> +
>> +			if (sched_out)
>> +				color_fprintf(stdout, color, "-  ");
>> +			else
>> +				color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
>> +		} else
>> +			color_fprintf(stdout, color, "   ");
>> +	}
>> +}
>> +
>>  static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			    struct perf_sample *sample, struct machine *machine)
>>  {
>>  	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
>> -	struct thread *sched_in;
>> +	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid");
>> +	struct thread *sched_in, *sched_out;
>>  	struct thread_runtime *tr;
>>  	int new_shortname;
>>  	u64 timestamp0, timestamp = sample->time;
>>  	s64 delta;
>> -	int i;
>>  	struct perf_cpu this_cpu = {
>>  		.cpu = sample->cpu,
>>  	};
>>  	int cpus_nr;
>> +	int proceed;
>>  	bool new_cpu = false;
>>  	const char *color = PERF_COLOR_NORMAL;
>>  	char stimestamp[32];
>> +	const char *str;
>>  
>>  	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
>>  
>> @@ -1583,7 +1651,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	}
>>  
>>  	sched_in = map__findnew_thread(sched, machine, -1, next_pid);
>> -	if (sched_in == NULL)
>> +	sched_out = map__findnew_thread(sched, machine, -1, prev_pid);
>> +	if (sched_in == NULL || sched_out == NULL)
>>  		return -1;
>>  
>>  	tr = thread__get_runtime(sched_in);
>> @@ -1593,6 +1662,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	}
>>  
>>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>> +	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
>>  
>>  	new_shortname = 0;
>>  	if (!tr->shortname[0]) {
>> @@ -1603,7 +1673,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			 */
>>  			tr->shortname[0] = '.';
>>  			tr->shortname[1] = ' ';
>> -		} else {
>> +		} else if (!sched->map.task_name || sched_match_task(thread__comm_str(sched_in),
>> +								sched->map.task_name)) {
>>  			tr->shortname[0] = sched->next_shortname1;
>>  			tr->shortname[1] = sched->next_shortname2;
>>  
>> @@ -1616,6 +1687,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  				else
>>  					sched->next_shortname2 = '0';
>>  			}
>> +		} else {
>> +			tr->shortname[0] = '-';
>> +			tr->shortname[1] = ' ';
>>  		}
>>  		new_shortname = 1;
>>  	}
>> @@ -1623,42 +1697,28 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
>>  		goto out;
>>  
>> -	printf("  ");
>> -
>> -	for (i = 0; i < cpus_nr; i++) {
>> -		struct perf_cpu cpu = {
>> -			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
>> -		};
>> -		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
>> -		struct thread_runtime *curr_tr;
>> -		const char *pid_color = color;
>> -		const char *cpu_color = color;
>> -
>> -		if (curr_thread && thread__has_color(curr_thread))
>> -			pid_color = COLOR_PIDS;
>> -
>> -		if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, cpu))
>> -			continue;
>> -
>> -		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
>> -			cpu_color = COLOR_CPUS;
>> -
>> -		if (cpu.cpu != this_cpu.cpu)
>> -			color_fprintf(stdout, color, " ");
>> +	proceed = 0;
>> +	str = thread__comm_str(sched_in);
>> +	/*
>> +	 * Check which of sched_in and sched_out matches the passed --task-name
>> +	 * arguments and call the corresponding print_sched_map.
>> +	 */
>> +	if (sched->map.task_name && !sched_match_task(str, sched->map.task_name)) {
>> +		if (!sched_match_task(thread__comm_str(sched_out), sched->map.task_name))
>> +			goto out;
>>  		else
>> -			color_fprintf(stdout, cpu_color, "*");
>> +			goto sched_out;
>>  
>> -		if (sched->curr_thread[cpu.cpu]) {
>> -			curr_tr = thread__get_runtime(sched->curr_thread[cpu.cpu]);
>> -			if (curr_tr == NULL) {
>> -				thread__put(sched_in);
>> -				return -1;
>> -			}
>> -			color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
>> -		} else
>> -			color_fprintf(stdout, color, "   ");
>> +	} else {
>> +		str = thread__comm_str(sched_out);
>> +		if (!(sched->map.task_name && !sched_match_task(str, sched->map.task_name)))
>> +			proceed = 1;
>>  	}
>>  
>> +	printf("  ");
>> +
>> +	print_sched_map(sched, this_cpu, cpus_nr, color, false);
>> +
>>  	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
>>  	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
>>  	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
>> @@ -1675,9 +1735,32 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	if (sched->map.comp && new_cpu)
>>  		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
>>  
>> +	if (proceed != 1) {
>> +		color_fprintf(stdout, color, "\n");
>> +		goto out;
>> +	}
>> +
>> +sched_out:
>> +	if (sched->map.task_name) {
>> +		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
>> +		if (strcmp(tr->shortname, "") == 0)
>> +			goto out;
>> +
>> +		if (proceed == 1)
>> +			color_fprintf(stdout, color, "\n");
>> +
>> +		printf("  ");
>> +		print_sched_map(sched, this_cpu, cpus_nr, color, true);
>> +		timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
>> +		color_fprintf(stdout, color, "  %12s secs ", stimestamp);
>> +	}
>> +
>>  	color_fprintf(stdout, color, "\n");
>>  
>>  out:
>> +	if (sched->map.task_name)
>> +		thread__put(sched_out);
>> +
>>  	thread__put(sched_in);
>>  
>>  	return 0;
>> @@ -3310,6 +3393,10 @@ static int perf_sched__map(struct perf_sched *sched)
>>  	if (!sched->curr_thread)
>>  		return rc;
>>  
>> +	sched->curr_out_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_out_thread)));
>> +	if (!sched->curr_out_thread)
>> +		return rc;
>> +
>>  	if (setup_cpus_switch_event(sched))
>>  		goto out_free_curr_thread;
>>  
>> @@ -3563,6 +3650,8 @@ int cmd_sched(int argc, const char **argv)
>>                      "highlight given CPUs in map"),
>>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>>                      "display given CPUs in map"),
>> +	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
>> +		"map output only for the given task name"),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  	const struct option timehist_options[] = {
>> -- 
>> 2.43.2
>>

