Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09117084B;
	Tue, 11 Jun 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095637; cv=none; b=T9lhHORiPGH3RCaitwIXMRMTiZmVcbJ1Kdd0Ok87jECLHbfSJLEZSA4hcwLPDv2d63/qZmARXerkaczxkVcexgMVzJQt/FLa3J3E0ZtCkDoBrIU4wk0n45Z52HmEci1v0LWf/X04TIfcsaBWGKV6h7mN0efYcS1YEC1AZqZWrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095637; c=relaxed/simple;
	bh=5AKYSoK3q8lHYSskDDKGHFDKukD5n4LrrTJAooL+9Kk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWPgxfhBJROK1x1JYdvFvtSFml0YTDZWRZ17AFdFWayos/YMO0Tdb21njBPg2MGqYP+kozJAE3mkqpKuiiv3dpBkCm6m9pJT7FUhINij67uajI1W/wcpZ6SbglT/OYMPEO4DjR8gHhHveTD2q1PUmeetK5yVHrC5RbmqSbXnWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d4FdCRO0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d4FdCRO0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B8Skr5009691;
	Tue, 11 Jun 2024 08:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	tSa5UPBBChj3EY3dtDdAR4DbwLb+5+iA0PlzRfVyBwc=; b=d4FdCRO0ax/RCJ8X
	vOS7D5U8N9ErN79bE8wK/n5ZPTahSeCTsbvnGPhSOeo8t6UQ9QbX1/6ul7ua7BQw
	1/vJG9QV/tM/8McK2BgWOnS+qn8PGWhgKXY3ohge7Qvs1Vf5WZZIV6+g5dxWVlBm
	z/go+8KJERWPxSLxbKAVB0R/OkoNnBHGbMcEGWKUb2aoe5HMRkm+XpJ4rj1Mk6Am
	adp753dnAEZSoay5TU/ed/ELzpXlAP5vFAIs1/sB/ymGoKyUcQIdJHWxrD0wgMTT
	W+OX+qNc4GF4tTkmUUIKXb72oxkviKqQiONbNiAGDG86POBOfsNeZdP4iyI8/kIx
	VNyG8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ypk3wg1gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:44:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45B8iwqX004480;
	Tue, 11 Jun 2024 08:44:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ypk3wg1gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:44:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45B77Wpc003898;
	Tue, 11 Jun 2024 08:44:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mpmufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:44:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45B8isOQ15073902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 08:44:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7626C5805B;
	Tue, 11 Jun 2024 08:44:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165A858055;
	Tue, 11 Jun 2024 08:44:46 +0000 (GMT)
Received: from [9.43.4.139] (unknown [9.43.4.139])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Jun 2024 08:44:45 +0000 (GMT)
Message-ID: <dd2d1e43-8928-4205-9fdb-88208f18c495@linux.ibm.com>
Date: Tue, 11 Jun 2024 14:14:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf sched map: Add command-name, fuzzy-name options
 to filter the output map
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
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240608124915.33860-1-vineethr@linux.ibm.com>
 <ZmeET1yhxU1-D7hy@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ZmeET1yhxU1-D7hy@google.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UpZwDsxkhGlNKdAkHdy-KwFehsUxXGC7
X-Proofpoint-GUID: 0Vcazh0XfVzYQpQi6wqH_U8KH-4CQxsI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406110062

Hi Namhyung,

On 11/06/24 04:25, Namhyung Kim wrote:
> Hello,
> 
> On Sat, Jun 08, 2024 at 06:18:29PM +0530, Madadi Vineeth Reddy wrote:
>> By default, perf sched map prints sched-in events for all the tasks
>> which may not be required all the time as it prints lot of symbols
>> and rows to the terminal.
>>
>> With --command-name option, one could specify the specific command(s)
>> for which the map has to be shown. This would help in analyzing the
>> CPU usage patterns easier for that specific command(s). Since multiple
>> PID's might have the same command name, using command-name filter
>> would be more useful for debugging.
>>
>> Multiple command names can be given with a comma separator without
>> whitespace.
>>
>> The --fuzzy-name option can be used if fuzzy name matching is required.
>> For example, "taskname" can be matched to any string that contains
>> "taskname" as its substring.
>>
>> For other tasks, instead of printing the symbol, ** is printed and
>> the same . is used to represent idle. ** is used instead of symbol
>> for other tasks because it helps in clear visualization of command(s)
>> of interest and secondly the symbol itself doesn't mean anything
>> because the sched-in of that symbol will not be printed(first sched-in
>> contains pid and the corresponding symbol).
>>
>> 6.10.0-rc1
>> ==========
>>   *A0                   213864.670142 secs A0 => migration/0:18
>>   *.                    213864.670148 secs .  => swapper:0
>>    .  *B0               213864.670217 secs B0 => migration/1:21
>>    .  *.                213864.670223 secs
>>    .   .  *C0           213864.670247 secs C0 => migration/2:26
>>    .   .  *.            213864.670252 secs
>>
>> 6.10.0-rc1 + patch (--command-name = schbench)
>> =============
>>    **  .   ** *A0       213864.671055 secs A0 => schbench:104834
>>   *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
>>   *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
> 
> I still think some people are interested in sched-out time.  For
> example, we don't know when B0 was scheduled out in the above.  There
> could be other tasks between B0 and C0 on the CPU 0.

Yes, you are right. When using the --command-name filter, there can be
other tasks in between. This won't be a problem without the --command-name
filtering, as no task will be missed, and we can be sure that the C0 sched-in
time is the B0 sched-out time.

I will add the sched-out time when using the --command-name option in v3.

> 
> 
>>   *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
>>   *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
>>    E0  .  *D0  A0
>>
>> This helps in visualizing how a benchmark like schbench is spread over
>> the available cpus while also knowing which cpus are idle(.) and which
>> are not(**). This will be more useful as number of CPUs increase.
>>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>
>>
>> ---
>> Changes in v2:
>> - Add support for giving multiple command-names in CSV. (Namhyung Kim)
>> - Add fuzzy name matching option. (Chen Yu)
>> - Add Reviewed-and-tested-by tag from Athira Rajeev.
>> - Rebase against perf-tools-next commit d2307fd4f989 ("perf maps: Add/use
>>   a sorted insert for fixup overlap and insert")
>> - Link to v1: https://lore.kernel.org/lkml/20240417152521.80340-1-vineethr@linux.ibm.com/
>> ---
>>  tools/perf/Documentation/perf-sched.txt |  8 +++++
>>  tools/perf/builtin-sched.c              | 41 +++++++++++++++++++++++--
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index a216d2991b19..6901c192eb6f 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -130,6 +130,14 @@ OPTIONS for 'perf sched map'
>>  --color-pids::
>>  	Highlight the given pids.
>>  
>> +--command-name::
>> +	Map output only for the given command name(s). Separate the
>> +	command names with a comma (without whitespace).
>> +	(** indicates other tasks while . is idle).
>> +
>> +--fuzzy-name::
>> +	Given command name can be partially matched (fuzzy matching).
>> +
>>  OPTIONS for 'perf sched timehist'
>>  ---------------------------------
>>  -k::
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 5977c49ae2c7..364f48170e65 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -156,6 +156,8 @@ struct perf_sched_map {
>>  	const char		*color_pids_str;
>>  	struct perf_cpu_map	*color_cpus;
>>  	const char		*color_cpus_str;
>> +	const char		*command;
>> +	bool			fuzzy;
>>  	struct perf_cpu_map	*cpus;
>>  	const char		*cpus_str;
>>  };
>> @@ -1538,6 +1540,26 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
>>  	return thread;
>>  }
>>  
>> +static bool command_matches(const char *comm_str, const char *commands, bool fuzzy_match)
>> +{
>> +	char *commands_copy = strdup(commands);
>> +	char *token = strtok(commands_copy, ",");
> 
> Hmm.. copying and parsing the commands whenever it compares the task
> comm looks inefficient.  I think you can parse the input string once and
> keep the list of names.

Sure, I will do that.

> 
>> +
>> +	bool match_found = false;
>> +
>> +	while (token != NULL) {
>> +		if ((fuzzy_match && strstr(comm_str, token) != NULL) ||
>> +					strcmp(comm_str, token) == 0) {
>> +			match_found = true;
>> +			break;
>> +		}
>> +	token = strtok(NULL, ",");
>> +	}
> 
> It could be:
> 
>     while (token != NULL && !match_found) {
>         if (fuzzy_match)
>             match_found = !!strstr(comm_str, token);
>         else
>             match_found = !strcmp(comm_str, token);
> 
>         token = strtok(NULL, ",");
>     }

This looks much better, will change it in v3. Thank you!

> 
> But as I said, it'd better not to call strtok() here.
> 

Yes, understood.

>> +
>> +	free(commands_copy);
>> +	return match_found;
>> +}
>> +
>>  static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			    struct perf_sample *sample, struct machine *machine)
>>  {
>> @@ -1594,8 +1616,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  
>>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>>  
>> -	printf("  ");
>> -
>>  	new_shortname = 0;
>>  	if (!tr->shortname[0]) {
>>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
>> @@ -1605,7 +1625,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			 */
>>  			tr->shortname[0] = '.';
>>  			tr->shortname[1] = ' ';
>> -		} else {
>> +		} else if (!sched->map.command || command_matches(thread__comm_str(sched_in),
>> +							sched->map.command, sched->map.fuzzy)) {
> 
> We usually align the indentation using the open parenthesis.
> Maybe you can rename the function and pass the sched pointer directly
> to reduce the argument.

Sure, got it.

> 
>   bool sched_match_task(struct perf_sched *sched, const char *comm_str)
>   {
>       ...
>   }
> 
> Or you could pass thread instead of comm_str and possibly support
> matching with TID too.

Do you want me to add another command line option to support matching
with TID?

Thanks for all the suggestions. Will implement them and send v3.

Thanks and Regards
Madadi Vineeth Reddy

> 
> Thanks,
> Namhyung
> 
> 
>>  			tr->shortname[0] = sched->next_shortname1;
>>  			tr->shortname[1] = sched->next_shortname2;
>>  
>> @@ -1618,10 +1639,19 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  				else
>>  					sched->next_shortname2 = '0';
>>  			}
>> +		} else {
>> +			tr->shortname[0] = '*';
>> +			tr->shortname[1] = '*';
>>  		}
>>  		new_shortname = 1;
>>  	}
>>  
>> +	if (sched->map.command && !command_matches(thread__comm_str(sched_in), sched->map.command,
>> +										sched->map.fuzzy))
>> +		goto skip;
>> +
>> +	printf("  ");
>> +
>>  	for (i = 0; i < cpus_nr; i++) {
>>  		struct perf_cpu cpu = {
>>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
>> @@ -1678,6 +1708,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  out:
>>  	color_fprintf(stdout, color, "\n");
>>  
>> +skip:
>>  	thread__put(sched_in);
>>  
>>  	return 0;
>> @@ -3560,6 +3591,10 @@ int cmd_sched(int argc, const char **argv)
>>                      "highlight given CPUs in map"),
>>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>>                      "display given CPUs in map"),
>> +	OPT_STRING(0, "command-name", &sched.map.command, "command",
>> +		"map output only for the given command name(s)"),
>> +	OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
>> +		"given command name can be partially matched (fuzzy matching)"),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  	const struct option timehist_options[] = {
>> -- 
>> 2.31.1
>>

