Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3D38DF9;
	Sun, 30 Jun 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729426; cv=none; b=a/dqtGpB7IzdeIyqdhKAHcZEpfOiUKBTp3p1Lq/lVyyNYcgG5VAsQmgM1iPnQQQv6bqkYaThJ5kV7i1BT78o/eaT4JWroWuSNkMeai5UZ9XIQ+wdrsOB+JUdKW17c+q6+RGNLI+JN5TWS/nHZQGZn+SS3ZXE0NsLRCCf7oABAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729426; c=relaxed/simple;
	bh=jEUDuUEkZQcBX7wCGT05A6QqljKXyMusCq8WZ/RSbog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPrap3eTIGLOP5oFoMRkNBe8dUtl0ZDPC7lHLiRdcy2WxTIsmkymtQiDkW/Q39+Af87du5dnQOc4/in44PxmJEq9q8kfhI0nT/b3cshmcBAM5WLHrYComnEZbDwHFpPUd5gymym/dfOm3cdaQ8ZFlSqC5m+nYpu/zVXJjlStMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tmuhM4PL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tmuhM4PL"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45U6U16E013777;
	Sun, 30 Jun 2024 06:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	FHlskbbd355KHmfVN/F3O+IlnsRZyEsDSWLKE/XXmQ=; b=tmuhM4PLEoZFDV30s
	mVNBRcs4HAfRj/w+mPXUdsNw2rk6/+FP06Ct8QcKIwUNXxgGgVtLEa6fS+Yqm8mY
	mR0OxdALS3tcdUjCWMfVua2TnnwBOfJQgHetsIhRcOWEBvFLueQ3PwL5Vr6TGBYj
	iachxWuHzipX7YrVZniDcsHHi1LGJAoQPCDO0kV3+exYz/srv76PZFauLwh8WauD
	rl0LehlZdkwFrijg2xp96J4eLkYYRCz0xQaWS1j6OYoVP1OWU1/v6YTWFPZ0LIM2
	CjkBa5qUwmBYJeg4Lnt2DSdAMQ+B2bHEDnbi6EdVvYpHAOLelCvklKLnaZn+x4Pe
	kVZaw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40324hr08f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:36:54 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45U6arVb023395;
	Sun, 30 Jun 2024 06:36:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40324hr08a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:36:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U57Thb009152;
	Sun, 30 Jun 2024 06:36:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w0094ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 06:36:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45U6anTW20382416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 06:36:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3223A58054;
	Sun, 30 Jun 2024 06:36:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D932658062;
	Sun, 30 Jun 2024 06:36:37 +0000 (GMT)
Received: from [9.43.35.135] (unknown [9.43.35.135])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Jun 2024 06:36:37 +0000 (GMT)
Message-ID: <cea69b48-7c9b-42e2-9281-238988f617ed@linux.ibm.com>
Date: Sun, 30 Jun 2024 12:06:36 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] perf sched map: Add --fuzzy-name option for fuzzy
 matching in task names
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
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
 <20240626091550.46707-4-vineethr@linux.ibm.com> <Zn34FZxPLh3llxy9@google.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zn34FZxPLh3llxy9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ybpRwZdJisQM_n6OJZLMkocZfvry0MKZ
X-Proofpoint-ORIG-GUID: vhfmfNbsWqJmTora7BjBaFcLrARP0aRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406300047

Hi Namhyung,

On 28/06/24 05:09, Namhyung Kim wrote:
> On Wed, Jun 26, 2024 at 02:45:50PM +0530, Madadi Vineeth Reddy wrote:
>> The --fuzzy-name option can be used if fuzzy name matching is required.
>> For example, "taskname" can be matched to any string that contains
>> "taskname" as its substring.
>>
>> Sample output for --task-name wdav --fuzzy-name
>> =============
>>  .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
>>  .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
>>  -  *-   -   -   -   -   -   -   131040.641379 secs
> 
>    -  *-   B0  -   -   -   -   -   131040.641379 secs
> 
>> *C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
>>  C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
>>  C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
>> *-   -   -   -   -   -   -   -   131040.641581 secs
> 
>   *-   -   B0  -   D0  -   E0  -   131040.641581 secs
> 

Understood. Thank you for the review.

Thanks and Regards
Madadi Vineeth Reddy

> Thanks,
> Namhyung
> 
>>
>> Suggested-by: Chen Yu <yu.c.chen@intel.com>
>> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf-sched.txt |  3 +++
>>  tools/perf/builtin-sched.c              | 22 +++++++++++++++-------
>>  2 files changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index 3095e280eb92..938b41a3befa 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -137,6 +137,9 @@ OPTIONS for 'perf sched map'
>>  	task name(s).
>>  	('-' indicates other tasks while '.' is idle).
>>  
>> +--fuzzy-name::
>> +	Given task name(s) can be partially matched (fuzzy matching).
>> +
>>  OPTIONS for 'perf sched timehist'
>>  ---------------------------------
>>  -k::
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index ecb43deb9d74..c801c38e8b9a 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -157,6 +157,7 @@ struct perf_sched_map {
>>  	struct perf_cpu_map	*color_cpus;
>>  	const char		*color_cpus_str;
>>  	const char		*task_name;
>> +	bool			fuzzy;
>>  	struct perf_cpu_map	*cpus;
>>  	const char		*cpus_str;
>>  };
>> @@ -1599,12 +1600,16 @@ static struct CommandList *parse_commands(const char *commands)
>>  	return cmd_list;
>>  }
>>  
>> -static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list)
>> +static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list, bool fuzzy_match)
>>  {
>>  	bool match_found = false;
>>  
>> -	for (int i = 0; i < cmd_list->command_count && !match_found; i++)
>> -		match_found = !strcmp(comm_str, cmd_list->command_list[i]);
>> +	for (int i = 0; i < cmd_list->command_count && !match_found; i++) {
>> +		if (fuzzy_match)
>> +			match_found = !!strstr(comm_str, cmd_list->command_list[i]);
>> +		else
>> +			match_found = !strcmp(comm_str, cmd_list->command_list[i]);
>> +	}
>>  
>>  	return match_found;
>>  }
>> @@ -1727,7 +1732,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			 */
>>  			tr->shortname[0] = '.';
>>  			tr->shortname[1] = ' ';
>> -		} else if (!sched->map.task_name || sched_match_task(str, cmd_list)) {
>> +		} else if (!sched->map.task_name || sched_match_task(str, cmd_list,
>> +								sched->map.fuzzy)) {
>>  			tr->shortname[0] = sched->next_shortname1;
>>  			tr->shortname[1] = sched->next_shortname2;
>>  
>> @@ -1756,15 +1762,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  	 * Check which of sched_in and sched_out matches the passed --task-name
>>  	 * arguments and call the corresponding print_sched_map.
>>  	 */
>> -	if (sched->map.task_name && !sched_match_task(str, cmd_list)) {
>> -		if (!sched_match_task(thread__comm_str(sched_out), cmd_list))
>> +	if (sched->map.task_name && !sched_match_task(str, cmd_list, sched->map.fuzzy)) {
>> +		if (!sched_match_task(thread__comm_str(sched_out), cmd_list, sched->map.fuzzy))
>>  			goto out;
>>  		else
>>  			goto sched_out;
>>  
>>  	} else {
>>  		str = thread__comm_str(sched_out);
>> -		if (!(sched->map.task_name && !sched_match_task(str, cmd_list)))
>> +		if (!(sched->map.task_name && !sched_match_task(str, cmd_list, sched->map.fuzzy)))
>>  			proceed = 1;
>>  	}
>>  
>> @@ -3707,6 +3713,8 @@ int cmd_sched(int argc, const char **argv)
>>                      "display given CPUs in map"),
>>  	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
>>  		"map output only for the given task name(s)."),
>> +	OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
>> +		"given command name can be partially matched (fuzzy matching)"),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  	const struct option timehist_options[] = {
>> -- 
>> 2.43.2
>>

