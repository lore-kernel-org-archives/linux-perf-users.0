Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA81A08A4;
	Wed,  2 Oct 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880623; cv=none; b=rzVdDVvSGBagF8LLP7dOevYmI5UncUR0MXcTabh4q2eLEeelxLr1vBf32FOa5giP6RqBOL5RJKmDEBDF3jc1H8FZBnZ659iCS2S+tAU61PzVuk7LX5xGMEoSFYk7NSxLJ3WLQrOiymwk+Iv+ROH4GuVmXJUh5LcF0ah+cMsl14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880623; c=relaxed/simple;
	bh=zWipN2FdOAuMmqVTdtkR6KdfQ4YcU28DCbl31IVjKUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgDCrFLlS7ew1Jjpu8wgh32VLeRyjynmW6g6z4YEppsZhtWyXe9wPnfgo+0CrcNyYM1Xtg2o7dlRlnAVi8IrBTvLKke0zoPzEkKTp5Ml2bTsAH+jZvAl3GGgJ5IUoTuwSfVq7T3ay+vVa0surCIEIFnHMJ3k7rg88HBR+HqL9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A8QaVwdX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A8QaVwdX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492En6Ox006174;
	Wed, 2 Oct 2024 14:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=E
	r1j3PsHdomLJw64Nf1k8GRRAcTeVSQpDOodTyCDeDs=; b=A8QaVwdXM4MGFQ3eQ
	5mhCeB9aEancXBttGuV8JgPblKM9/Sd8LSEU3HLVojEG3/B30zuCldlOF8KOoHo6
	9xFR/d3dpe7sQIj9fe7yI2IFVNeg/wUrEQB9jOROHzhxg5BjUf7kcQGRrU+k02Ig
	VJhoiymMRSwnTg0iGz68WSN/cH6uRWw+uu5mLe4/1C2AlXDfapN7+RH4rmYJkUcq
	5mj8bMXbt1wI/cBFVfGlPAeAICbyLR/PvVRDs9iWVW+tMno42h5kD76koAmCOBMZ
	lxi0F9HNy1Gqn7YjTc6a/BMIA7HCbBUvTSbEoRhXP1y6c4izOqy/LNO5/sXMKbIO
	Vw1MQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421898004a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 14:50:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492Eo6mL009784;
	Wed, 2 Oct 2024 14:50:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4218980047-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 14:50:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492DHx64007957;
	Wed, 2 Oct 2024 14:50:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy31jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 14:50:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492Eo4Ms12452370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 14:50:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7C3858059;
	Wed,  2 Oct 2024 14:50:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C92158058;
	Wed,  2 Oct 2024 14:49:50 +0000 (GMT)
Received: from [9.43.52.239] (unknown [9.43.52.239])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 14:49:49 +0000 (GMT)
Message-ID: <eb218ff7-b3cc-4c51-999f-59641c92c139@linux.ibm.com>
Date: Wed, 2 Oct 2024 20:19:47 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf sched timehist: Add pre-migration wait time
 option
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241001110620.60602-1-vineethr@linux.ibm.com>
 <ZvyW2dXQxhxsJNWt@google.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ZvyW2dXQxhxsJNWt@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: risGA3cm8TlWgISFATMcTiOGO7AD0cw7
X-Proofpoint-ORIG-GUID: oDhBElHLW9sA433zIoUWjE5FH0iMRNlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020106

Hi Namhyung,

On 02/10/24 06:12, Namhyung Kim wrote:
> On Tue, Oct 01, 2024 at 04:36:20PM +0530, Madadi Vineeth Reddy wrote:
>> pre-migration wait time is the time that a task unnecessarily spends
>> on the runqueue of a CPU but doesn't get switched-in there. In terms
>> of tracepoints, it is the time between sched:sched_wakeup and
>> sched:sched_migrate_task.

[snip]

>>  static bool is_idle_sample(struct perf_sample *sample,
>> @@ -2598,13 +2611,19 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
>>  	if (tr == NULL)
>>  		return -1;
>>  
>> -	if (tr->ready_to_run == 0)
>> -		tr->ready_to_run = sample->time;
>> +	if (!strcmp(evsel__name(evsel), "sched:sched_waking")) {
> 
> I guess it won't work when there's no sched_waking event.  Can you
> simply handle pre-migration in sched_waking?
> 

I believe it should still work even without the sched_waking event because
I've updated the condition to ensure that timehist_sched_wakeup_ignore is
not selected when the pre-migration option is enabled.

> Thanks,
> Namhyung
> 
> 
>> +		if (tr->ready_to_run == 0)
>> +			tr->ready_to_run = sample->time;

[snip]

>>  	/* prefer sched_waking if it is captured */
>> -	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
>> +	if (!sched->pre_migrations &&
>> +		evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
>>  		handlers[1].handler = timehist_sched_wakeup_ignore;

In this case, it checks if pre-migration is enabled. If so, the handler will still
use timehist_sched_wakeup_event for the sched:sched_wakeup event.

The reason I initially chose the sched:sched_wakeup tracepoint instead of
sched:sched_waking is that there could be instances where the CPU chosen
during sched_waking may not match the actual CPU where the task ends up running,
as shown in the example below:

      wdavdaemon   14789 [006] 31357.614692: sched:sched_waking: comm=wdavdaemon pid=14778 prio=120 target_cpu=005
	[snip]
         swapper       0 [002] 31357.614695: sched:sched_wakeup: wdavdaemon:14778 [120] CPU:002

However, since we are already accounting for the sched_migrate_task event occurring
between sched_waking and sched_switch and don't need to check target_cpu, switching
to sched_waking should work just as well, with only a very minor time difference.

I'll go ahead and send a v3 with sched_waking. Thanks again for the feedback.

Thanks,
Madadi Vineeth Reddy

>>  
>>  	/* setup per-evsel handlers */
>> @@ -3280,8 +3309,14 @@ static int perf_sched__timehist(struct perf_sched *sched)
>>  		goto out;
>>  	}
>>  
>> -	if (sched->show_migrations &&
>> -	    perf_session__set_tracepoints_handlers(session, migrate_handlers))
>> +	if (sched->pre_migrations && !evlist__find_tracepoint_by_name(session->evlist,
>> +									"sched:sched_wakeup")) {
>> +		pr_err("No sched_wakeup events found. sched_wakeup tracepoint is mandatory for -P option\n");
>> +		goto out;
>> +	}
>> +
>> +	if ((sched->show_migrations || sched->pre_migrations) &&
>> +		perf_session__set_tracepoints_handlers(session, migrate_handlers))
>>  		goto out;
>>  
>>  	/* pre-allocate struct for per-CPU idle stats */
>> @@ -3823,6 +3858,7 @@ int cmd_sched(int argc, const char **argv)
>>  	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
>>  	OPT_STRING(0, "prio", &sched.prio_str, "prio",
>>  		   "analyze events only for given task priority(ies)"),
>> +	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-migration wait time"),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  
>> -- 
>> 2.43.2
>>

