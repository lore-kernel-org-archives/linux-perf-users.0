Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6A33FE;
	Sun, 30 Jun 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729359; cv=none; b=WyiLIjV3DYS7ozRUHm9gUfvxx1Vvd625jAG2Nj1Jo9Cbe5i5U1ygiYCSRnpKTBdmVzIPZvjx3rXjSx/cMNfqyfpANTAkkjogyK8jCSH6Uwa637Ve7xBby1kbuJbw1cqzPYQVKEspSORe36YXuhl3SYzoINRoAsLJnk6FeTWKccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729359; c=relaxed/simple;
	bh=9fbSpeihEUvtV6wPaS9mcAuPAZTWA1ZUDMHkIYbSECU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wez7KE/vU5skIh9mObiGspAr0vWlN/OHbsQVSwd+OQlaHAqyjbQW5tmru+hUcHkqEFjt9GT1ipDDsM8aZF4DlaCbArD5T2HTYteWOJKKBmFqq0kZdaE+IjIJ8ycJqBliD/NGD8OJ8HqIKxnTX336tOGf52CUuzscYsHYVsDXx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ux+ULKZr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ux+ULKZr"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45U6RGpt028545;
	Sun, 30 Jun 2024 06:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=v
	3/VW5U+CQJyvDd1ODBARt4Wmtef/v4wx8wp5jbuQ8c=; b=Ux+ULKZreHnKDskXi
	J54rvmWH/xdsXBpeGJBHL30Z89rM44o0LvBmRrzA4friRp8oXHP4u1pGf/EeRJjz
	zJ4JHkV40FAbKIblIkayW3oT2LS4UOcu5ZVrmkocvvKbVuO6YcLsnvrgYSfqtV78
	Lirp0U3UuhE9V91kLf7o7Kh9wJUTI1M1S9klxkUXboyMFtRk+VbkkUqOniCu+4II
	mnVL5Kx1M2fwkXs4OL6hq0IFRUWclQPtAjjROVBQbEotpDSaJ8gNc4iKSr47OM7U
	34tjjXoRX9PVan2tnj0gczJenSVltcxVrCUxLoqxdb6QGtgpP7TC/EAhCRXooWj/
	qHHfQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40318ng2p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:35:46 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45U6Zjx3009380;
	Sun, 30 Jun 2024 06:35:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40318ng2p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:35:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U4t7RP005953;
	Sun, 30 Jun 2024 06:35:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vkts6t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:35:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45U6Zfso63963500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 06:35:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA0015805A;
	Sun, 30 Jun 2024 06:35:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4564858054;
	Sun, 30 Jun 2024 06:35:31 +0000 (GMT)
Received: from [9.43.35.135] (unknown [9.43.35.135])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Jun 2024 06:35:30 +0000 (GMT)
Message-ID: <ca5a13b1-6931-4237-b588-324889c241f1@linux.ibm.com>
Date: Sun, 30 Jun 2024 12:05:28 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] perf sched map: Add support for multiple task
 names using CSV
Content-Language: en-US
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
        LKML <linux-kernel@vger.kernel.org>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
 <20240626091550.46707-3-vineethr@linux.ibm.com> <Zn33dkUPuDdVD8KV@google.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zn33dkUPuDdVD8KV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bu_Mpb-rSEW2WinIQEMzOcKpI8KHKQke
X-Proofpoint-GUID: mXYZbHFocmllJVjrsH3QE1sgOZ3xyJxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300047

Hi Namhyung,

On 28/06/24 05:06, Namhyung Kim wrote:
> On Wed, Jun 26, 2024 at 02:45:49PM +0530, Madadi Vineeth Reddy wrote:
>> To track the scheduling patterns of multiple tasks simultaneously,
>> multiple task names can be specified using a comma separator
>> without any whitespace.
>>
>> Sample output for --task-name perf,wdavdaemon
>> =============
>>  .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
>>  .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
>>  -  *-   -   -   -   -   -   -   131040.641379 secs
>> *C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
>>
>> ...
>>
>>  -  *-   -   -   -   -   -   -   131041.395649 secs
>>  .   .   .   .   .   .   .  *X2  131041.403969 secs X2 => perf:70211
>>  -   -   -   -   -   -   -  *-   131041.404006 secs
>>
>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
>> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf-sched.txt |  5 +-
>>  tools/perf/builtin-sched.c              | 77 +++++++++++++++++++++----
>>  2 files changed, 69 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index 3255e5b8e74b..3095e280eb92 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -131,9 +131,10 @@ OPTIONS for 'perf sched map'
>>  	Highlight the given pids.
>>  
>>  --task-name <task>::
>> -	Map output only for the given task name. The sched-out
>> +	Map output only for the given task name(s). Separate the
>> +	task names with a comma (without whitespace). The sched-out
>>  	time is printed and is represented by '*-' for the given
>> -	task name
>> +	task name(s).
>>  	('-' indicates other tasks while '.' is idle).
>>  
>>  OPTIONS for 'perf sched timehist'
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 57f166662d54..ecb43deb9d74 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -1540,24 +1540,72 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
>>  	return thread;
>>  }
>>  
>> -static bool sched_match_task(const char *comm_str, const char *commands)
>> +struct CommandList {
> 
> Please don't use camel case.
> 

Sure.

>> +	char **command_list;
>> +	int command_count;
> 
> If you name the list as commands (or cmds) you can remove the prefix and
> use it like commands->list or cmds->count.
> 
> Actually I was thinking about strlist API and it'd do most of the work
> you did here.  You may want to add the fuzzy (or substring) matching
> there.
>

OK, thanks for the suggestion. Will use that.
 
>> +};
>> +
>> +static void free_command_list(struct CommandList *cmd_list)
>> +{
>> +	if (cmd_list) {
>> +		for (int i = 0; i < cmd_list->command_count; i++)
>> +			free(cmd_list->command_list[i]);
>> +		free(cmd_list->command_list);
>> +		free(cmd_list);
>> +	}
> 
> Then it could be just strlist__delete().
> 
> 
>> +}
>> +
>> +static struct CommandList *parse_commands(const char *commands)
>>  {
>>  	char *commands_copy = NULL;
>> +	struct CommandList *cmd_list = NULL;
>>  	char *token = NULL;
>> -	bool match_found = false;
>>  
>>  	commands_copy = strdup(commands);
>>  	if (commands_copy == NULL)
>>  		return NULL;
>>  
>> +	cmd_list = malloc(sizeof(struct CommandList));
>> +	if (cmd_list == NULL) {
>> +		free(commands_copy);
>> +		return NULL;
>> +	}
>> +
>> +	cmd_list->command_count = 0;
>> +	cmd_list->command_list = NULL;
> 
> You can use zalloc() and remove the zero initialization.
>

Sure.
 
> 
>> +
>>  	token = strtok(commands_copy, ",");
>> +	while (token != NULL) {
>> +		cmd_list->command_list = realloc(cmd_list->command_list, sizeof(char *)
>> +							*(cmd_list->command_count + 1));
>> +		if (cmd_list->command_list == NULL) {
>> +			free_command_list(cmd_list);
>> +			free(commands_copy);
>> +			return NULL;
>> +		}
>>  
>> -	while (token != NULL && !match_found) {
>> -		match_found = !strcmp(comm_str, token);
>> +		cmd_list->command_list[cmd_list->command_count] = strdup(token);
>> +		if (cmd_list->command_list[cmd_list->command_count] == NULL) {
>> +			free_command_list(cmd_list);
>> +			free(commands_copy);
>> +			return NULL;
>> +		}
>> +
>> +		cmd_list->command_count++;
>>  		token = strtok(NULL, ",");
>>  	}
>>  
>>  	free(commands_copy);
>> +	return cmd_list;
> 
> And this could be just `strlist__new(commands, NULL)`.
> 

Thank you for the feedback. I will fix them in v6.

Thanks and Regards
Madadi Vineeth Reddy

> Thanks,
> Namhyung
> 
> 
>> +}
>> +
>> +static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list)
>> +{
>> +	bool match_found = false;
>> +
>> +	for (int i = 0; i < cmd_list->command_count && !match_found; i++)
>> +		match_found = !strcmp(comm_str, cmd_list->command_list[i]);
>> +
>>  	return match_found;
>>  }
>>  
>> @@ -1624,6 +1672,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	char stimestamp[32];
>>  	const char *str;
>>  
>> +	struct CommandList *cmd_list = NULL;
>> +
>>  	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
>>  
>>  	if (this_cpu.cpu > sched->max_cpu.cpu)
>> @@ -1664,7 +1714,11 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>>  	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
>>  
>> +	if (sched->map.task_name)
>> +		cmd_list = parse_commands(sched->map.task_name);
>> +
>>  	new_shortname = 0;
>> +	str = thread__comm_str(sched_in);
>>  	if (!tr->shortname[0]) {
>>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
>>  			/*
>> @@ -1673,8 +1727,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			 */
>>  			tr->shortname[0] = '.';
>>  			tr->shortname[1] = ' ';
>> -		} else if (!sched->map.task_name || sched_match_task(thread__comm_str(sched_in),
>> -								sched->map.task_name)) {
>> +		} else if (!sched->map.task_name || sched_match_task(str, cmd_list)) {
>>  			tr->shortname[0] = sched->next_shortname1;
>>  			tr->shortname[1] = sched->next_shortname2;
>>  
>> @@ -1703,15 +1756,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	 * Check which of sched_in and sched_out matches the passed --task-name
>>  	 * arguments and call the corresponding print_sched_map.
>>  	 */
>> -	if (sched->map.task_name && !sched_match_task(str, sched->map.task_name)) {
>> -		if (!sched_match_task(thread__comm_str(sched_out), sched->map.task_name))
>> +	if (sched->map.task_name && !sched_match_task(str, cmd_list)) {
>> +		if (!sched_match_task(thread__comm_str(sched_out), cmd_list))
>>  			goto out;
>>  		else
>>  			goto sched_out;
>>  
>>  	} else {
>>  		str = thread__comm_str(sched_out);
>> -		if (!(sched->map.task_name && !sched_match_task(str, sched->map.task_name)))
>> +		if (!(sched->map.task_name && !sched_match_task(str, cmd_list)))
>>  			proceed = 1;
>>  	}
>>  
>> @@ -1758,8 +1811,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	color_fprintf(stdout, color, "\n");
>>  
>>  out:
>> -	if (sched->map.task_name)
>> +	if (sched->map.task_name) {
>> +		free_command_list(cmd_list);
>>  		thread__put(sched_out);
>> +	}
>>  
>>  	thread__put(sched_in);
>>  
>> @@ -3651,7 +3706,7 @@ int cmd_sched(int argc, const char **argv)
>>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>>                      "display given CPUs in map"),
>>  	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
>> -		"map output only for the given task name"),
>> +		"map output only for the given task name(s)."),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  	const struct option timehist_options[] = {
>> -- 
>> 2.43.2
>>

