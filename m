Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC355153BF6;
	Fri,  7 Jun 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744953; cv=none; b=ABJITls0Jz8ir24IPnGFXLWXjcVadHuAHpjnBQjfGGCQ1TZKgGB6yX1MZEktXMVsmfGys/0BnPHQyhEakp6ZykSCg6e8NjN0tgFP6cpiF3AHQ6+GhQfQUyASQKkn3QLP2BfwCuXaGnLkunTaAe5d1FsI0g+vbniyV3ALzX/g6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744953; c=relaxed/simple;
	bh=8FgdtkmI6xFEuhnErHtI49QG7efrDkPTcNTO2g4FoXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFgIN53B/V1bYvY/sVDBj8Lf3r/Rgq42PI6y28aD3fM3dWT+6lghULbgfXW3ttSHQyLmX/FfGlAHnuZYkwaPcN1BbWCH2G8i3gEz1yHIJqI/dfA7bp321TfEoJ/LOvAWJyTBZcfLmgZ32pNyrL2DFApGZ2r2OX+4tdiF+tcr6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7RHFVQ7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7RHFVQ7"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4576wO5u014427;
	Fri, 7 Jun 2024 07:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=fFJS4yh38VY53xVb/V9wThVVeVXDCBlv8lVrbQejh/0=;
 b=R7RHFVQ7DhZXg896d6/VmA1daPHUDRKapTYQ2I/xkISHbf3eEjicmZjAo2SB6cmkvUiG
 RCwtsICPdrYHgdCvGBSdz2ZlEV6QfKax61OCgYwLhzWJAdkDSJH+xbv0spuV0Kvh7nC4
 yBqglBXkmeOxtjuFjeMsnAH0pSTwVUalCmMayDP6QLNIYOpGlXBuUL11rUp8WxJBVluK
 IvENIZOf0C+aILvpt+EzbQMtXyzDX2Q5gntODQrS/ETyD97AkGu6jmAF2g5Ne6a7JUni
 p4vAt24F+dGoqqxqJATLahfySXmJ6sTk5mxeOMqN+T9199jOCM0aeGGzqp8asOCAqStg Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykwdb023w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 07:22:16 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4577MGha019157;
	Fri, 7 Jun 2024 07:22:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykwdb023s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 07:22:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4576iS0h022786;
	Fri, 7 Jun 2024 07:22:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6mq2um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 07:22:15 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4577MB7N9962238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 07:22:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63BDD58059;
	Fri,  7 Jun 2024 07:22:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747DC58043;
	Fri,  7 Jun 2024 07:22:02 +0000 (GMT)
Received: from [9.43.49.13] (unknown [9.43.49.13])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 07:22:02 +0000 (GMT)
Message-ID: <54073c0c-62b1-433a-85cc-06e412af44bf@linux.ibm.com>
Date: Fri, 7 Jun 2024 12:52:00 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched map: Add command-name option to filter the
 output map
To: Chen Yu <yu.c.chen@intel.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        acme@redhat.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240417152521.80340-1-vineethr@linux.ibm.com>
 <ZmKtlQdwk5uwha06@chenyu5-mobl2>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ZmKtlQdwk5uwha06@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BDHmvPaXKfg8XF2TqWwANnMnCMhxMX0g
X-Proofpoint-ORIG-GUID: nz61hUFU2PvCFxgGYpciql2kCzpq5rqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070050

Hi Chen Yu,

On 07/06/24 12:19, Chen Yu wrote:
> On 2024-04-17 at 20:55:21 +0530, Madadi Vineeth Reddy wrote:
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
>>
> 
> I've tested on my machine and it looks good. One minor question, can we do
> fuzzy name matching? Say, there are many tasks 'a-taskname-b',
> and we can filter them via
> perf sched map --command-name=taskname

Yes, maybe I will try to find a way to do both fuzzy name matching and exact name matching.
Thanks for taking a look. I will implement it in v2.

Thanks and Regards
Madadi Vineeth Reddy

> 
> thanks,
> Chenyu

