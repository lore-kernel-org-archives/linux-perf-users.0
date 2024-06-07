Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0117BB4;
	Fri,  7 Jun 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739390; cv=none; b=tvmfcqZK69LNMMxfVPwlXIGKlf26jebHq3aJ1f7GGwBG9oihNNnimBmOEYxYfxL/wPSQJheu8pJvy514A3DHmsfg24c8eUI7XD2pEQZkug3akXHfY4+qwk1CMGgEutvIZY1OG0KU3RMC4vsDmcrhEU3x/OstSNkZzL/QVHw13Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739390; c=relaxed/simple;
	bh=XiBtJnLVeyxhEzPOeggSEQxEAMUe2TXzU0ZdbBv5fdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPfErEN8F+jkq457mwPJxXsqL7aKG+9zWqeZJobUrx1q14/FWYwZrkHDEC4S3TjKVQ/jLWA26fURCKLXV83ELVZrmesU8jKIc0aivV7qJWnbPsmb9OWHklfWEhHbTSALoW7nmLFa1f4DJoxWP2TQ8zZh4Kp0pklN9x2YiNXQSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nZdam5Vg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nZdam5Vg"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4575jUbm018926;
	Fri, 7 Jun 2024 05:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=4HOwn+XtHSMKKOd7gC4pg45pnsFw7RcpkPDFG6rOuzM=;
 b=nZdam5Vg8btDQolpTYC/fxb9JCXdSL0JNb4RqsNV9VmEXTsen1ZnPLSFGrYrc+lmkk0D
 PXd5VthnZuzUQ0zQZis6+bprh9Eexc/AsqXk9SsETa+J8l2MANhIiej4aZKkY+4FFH27
 XaVhBwnwxZscvs7GFHw7QkrGEeV96W1yrNKIhoreB9a585MJFqhbUPlKvJSYuh2uc3MK
 wbUXNmF0AwdTRHAn266saM6GRTqREGaiL/C09lNckRgCLsKzBxJ9r+qbtiX4s61DDbOg
 yyPNai89Hy49NlZjiuPoTpQ9SZ+8d/nDzltY92+02Bf275Pm1qZBXqNr1+ERZpZW2qO6 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykv2k019j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:49:35 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4575nZHH025973;
	Fri, 7 Jun 2024 05:49:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykv2k019f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:49:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4573Ng32022794;
	Fri, 7 Jun 2024 05:49:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6mpn7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:49:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4575nUKu56426946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 05:49:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68AB258066;
	Fri,  7 Jun 2024 05:49:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1495758057;
	Fri,  7 Jun 2024 05:49:22 +0000 (GMT)
Received: from [9.43.92.107] (unknown [9.43.92.107])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 05:49:21 +0000 (GMT)
Message-ID: <648c5622-1636-4878-83ce-d33c20ee790a@linux.ibm.com>
Date: Fri, 7 Jun 2024 11:19:19 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched map: Add command-name option to filter the
 output map
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, acme@redhat.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240417152521.80340-1-vineethr@linux.ibm.com>
 <ZmJZULPzy0C4aPiO@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ZmJZULPzy0C4aPiO@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eOno0oySyIiwayYyQxZe3CwYElIbzrRW
X-Proofpoint-GUID: ugJ4a11YyYtaeinM16BNqHHqACc7XnMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406070039

Hi Namhyung,

On 07/06/24 06:20, Namhyung Kim wrote:
> Hello,
> 
> Sorry for the late reply.
> 
> On Wed, Apr 17, 2024 at 08:55:21PM +0530, Madadi Vineeth Reddy wrote:
>> By default, perf sched map prints sched-in events for all the tasks
>> which may not be required all the time as it prints lot of symbols
>> and rows to the terminal.
>>
>> With --command-name option, one could specify the specific command
>> for which the map has to be shown. This would help in analyzing the
>> CPU usage patterns easier for that specific command. Since multiple
>> PID's might have the same command name, using command-name filter
>> would be more useful for debugging.
>>
>> For other tasks, instead of printing the symbol, ** is printed and
>> the same . is used to represent idle. ** is used instead of symbol
>> for other tasks because it helps in clear visualization of command
>> of interest and secondly the symbol itself doesn't mean anything
>> because the sched-in of that symbol will not be printed(first sched-in
>> contains pid and the corresponding symbol).
>>
>> 6.8.0
>> ======
>>   *A0                   213864.670142 secs A0 => migration/0:18
>>   *.                    213864.670148 secs .  => swapper:0
>>    .  *B0               213864.670217 secs B0 => migration/1:21
>>    .  *.                213864.670223 secs
>>    .   .  *C0           213864.670247 secs C0 => migration/2:26
>>    .   .  *.            213864.670252 secs
>>
>> 6.8.0 + patch (--command-name = schbench)
>> =============
>>    **  .   ** *A0       213864.671055 secs A0 => schbench:104834
>>   *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
>>   *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
>>   *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
>>   *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
>>    E0  .  *D0  A0
>>
>> This helps in visualizing how a benchmark like schbench is spread over
>> the available cpus while also knowing which cpus are idle(.) and which
>> are not(**). This will be more useful as number of CPUs increase.
> 
> Yeah I think this is good!  Thanks for working on this.
> 
> But I guess people want to see when the tasks were sched out as well.
> Can you please add that too?
> 

In the current implementation, we will know when a task is scheduled out
implicitly.

For instance, from the above example,

 **  .   ** *A0       213864.671055 secs A0 => schbench:104834
*B0  .   .   A0       213864.671156 secs B0 => schbench:104835
*C0  .   .   A0       213864.671187 secs C0 => schbench:104836

In CPU0 (first column), the sched-in of C0 in last line indicates that
B0 is scheduled out. Similarly down the line if A0 is scheduled out,
we will know it by some other task being scheduled-in.

I hope this is fine. Let me know if you have any ideas or suggestions.

>>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf-sched.txt |  4 ++++
>>  tools/perf/builtin-sched.c              | 17 ++++++++++++++---
>>  2 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index 5fbe42bd599b..b04a37560935 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -94,6 +94,10 @@ OPTIONS for 'perf sched map'
>>  --color-pids::
>>  	Highlight the given pids.
>>  
>> +--command-name::
>> +	Map output only for the given command name.
>> +	(** indicates other tasks while . is idle).
> 
> Probably we can support multiple names in CSV.
> 

Yes, that's a good idea. I will implement it in v2. Thank you for taking a look.

Thanks and Regards
Madadi Vineeth Reddy

> Thanks,
> Namhyung
> 
> 
>> +
>>  OPTIONS for 'perf sched timehist'
>>  ---------------------------------
>>  -k::
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 0fce7d8986c0..e60836da53e5 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -156,6 +156,7 @@ struct perf_sched_map {
>>  	const char		*color_pids_str;
>>  	struct perf_cpu_map	*color_cpus;
>>  	const char		*color_cpus_str;
>> +	const char		*command;
>>  	struct perf_cpu_map	*cpus;
>>  	const char		*cpus_str;
>>  };
>> @@ -1594,8 +1595,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  
>>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>>  
>> -	printf("  ");
>> -
>>  	new_shortname = 0;
>>  	if (!tr->shortname[0]) {
>>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
>> @@ -1605,7 +1604,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  			 */
>>  			tr->shortname[0] = '.';
>>  			tr->shortname[1] = ' ';
>> -		} else {
>> +		} else if (!sched->map.command || !strcmp(thread__comm_str(sched_in),
>> +								sched->map.command)) {
>>  			tr->shortname[0] = sched->next_shortname1;
>>  			tr->shortname[1] = sched->next_shortname2;
>>  
>> @@ -1618,10 +1618,18 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
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
>> +	if (sched->map.command && strcmp(thread__comm_str(sched_in), sched->map.command))
>> +		goto skip;
>> +
>> +	printf("  ");
>> +
>>  	for (i = 0; i < cpus_nr; i++) {
>>  		struct perf_cpu cpu = {
>>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
>> @@ -1678,6 +1686,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>>  out:
>>  	color_fprintf(stdout, color, "\n");
>>  
>> +skip:
>>  	thread__put(sched_in);
>>  
>>  	return 0;
>> @@ -3560,6 +3569,8 @@ int cmd_sched(int argc, const char **argv)
>>                      "highlight given CPUs in map"),
>>  	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
>>                      "display given CPUs in map"),
>> +	OPT_STRING(0, "command-name", &sched.map.command, "command",
>> +		"map output only for the given command name"),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  	const struct option timehist_options[] = {
>> -- 
>> 2.39.1
>>

