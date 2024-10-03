Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308091BDE6;
	Thu,  3 Oct 2024 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924891; cv=none; b=Kklqfo4jbsR76mwuNPcpkm3pJa4syVc/N3GVY4bLwv+lb3qxBZPWa8KgsPA9Z8+6p2JxFapFeIA1IVmLri6XOiYFEWhVZRed2FJ87idq1wVvK80j1Ok6v+G6dkctuIjzKBhfT9kzzhzPVMh/3qCdSsP6CtlkE6RZozNs4wJ6BOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924891; c=relaxed/simple;
	bh=MM+xL5agRbSolLV7RH1f6fmQr7nqjPon3KmoeG90Jwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLYe147pGEBATgOc1rhGy//PSGtZ/Fx6WZktUj6wUiUsVGLj1P78hq8IZdTPY9zHltn6J8fTzYnaOI/M82J2EUz4pfBvcE6QErmR/VPlJhpVwGqZ+pMN7OVKND5fB4G1CsVNEGIYzrhnTs0RsPE3tfqd7Z94KK/ZI8wO+ujH0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HV3R36R+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HV3R36R+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4932mt2H002304;
	Thu, 3 Oct 2024 03:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=A
	+LdJrbAv1A0e9aVY4KiACPfT1lVFnIxsatGiE+jN/0=; b=HV3R36R+5P6ApSXMr
	jEw+MvAE1H7/pHtbbEdbbwi5hRvZV++tuAopdYxNWQziKn2ECVCFYdOurUWGY8Kj
	kV6SKYxDmJ0y36xe2Q8Ru8ikBMkyuhT2Y5ey+lAizlGbeBP5i7zIWs7dqG3eGufi
	cBUQPKadHo7f47JO0cicJec2q25YHbtjPTpLoDyiUiwz7HcCyY78wmVqO4ZZp8hM
	h+oWWGtrFx6F/uLF8KmZX6zqzMzGFxC3UMgNtIEKGxUTceo6MwEp7D6ipy75LArY
	TCG11l7DERqLb+51kCMck/WAD5a6QBa7F+OhUxTpsM5G7RI+GtzwbOihrw1/dWJJ
	MqPjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421jt7g1fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 03:07:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49337uMG008065;
	Thu, 3 Oct 2024 03:07:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421jt7g1fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 03:07:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492Mt3SL007923;
	Thu, 3 Oct 2024 03:07:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy5v09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 03:07:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49337sOW43123034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 03:07:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 931E458045;
	Thu,  3 Oct 2024 03:07:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 891BD58054;
	Thu,  3 Oct 2024 03:07:45 +0000 (GMT)
Received: from [9.43.26.191] (unknown [9.43.26.191])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 03:07:45 +0000 (GMT)
Message-ID: <60142574-dd07-4aa1-812a-554d58a15dc5@linux.ibm.com>
Date: Thu, 3 Oct 2024 08:37:37 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf sched timehist: Add pre-migration wait time
 option
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
References: <20241002163917.33781-1-vineethr@linux.ibm.com>
 <Zv3myhcbdEPLCAIC@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zv3myhcbdEPLCAIC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wR5iUtWvK4YvaYVVJVVj-8k1M_MYVoPf
X-Proofpoint-GUID: usNZufR-BNNdR93BB1YnnyTSgIqqYe6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_02,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030019

Hi Namhyung,

On 03/10/24 06:05, Namhyung Kim wrote:
> On Wed, Oct 02, 2024 at 10:09:17PM +0530, Madadi Vineeth Reddy wrote:
>> pre-migration wait time is the time that a task unnecessarily spends
>> on the runqueue of a CPU but doesn't get switched-in there. In terms
>> of tracepoints, it is the time between sched:sched_wakeup and
>> sched:sched_migrate_task.
>>

[snip]

>> @@ -2239,6 +2244,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
> 
> It'd be nice if you update the comment on timehist_update_runtime_stats.
> 
> 
>>  	r->dt_iowait  = 0;
>>  	r->dt_preempt = 0;
>>  	r->dt_run     = 0;
>> +	r->dt_pre_mig = 0;
>>  
>>  	if (tprev) {
>>  		r->dt_run = t - tprev;
>> @@ -2247,6 +2253,11 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>>  				pr_debug("time travel: wakeup time for task > previous sched_switch event\n");
>>  			else
>>  				r->dt_delay = tprev - r->ready_to_run;
>> +
>> +			if (r->ready_to_run && r->migrated) {
> 
> At this point r->read_to_run is not zero.  And the r->migrated should
> not be zero when the below condition is met.  So I think you can remove
> this condition.

You're right, my mistake. r->ready_to_run is already checked, and if
r->migrated is zero, it will naturally fail the condition below.

I've removed the redundant check and sent a v4. Thanks for the feedback!

Thanks,
Madadi Vineeth Reddy

> 
> Thanks,
> Namhyung
> 
> 
>> +				if ((r->migrated > r->ready_to_run) && (r->migrated < tprev))
>> +					r->dt_pre_mig = r->migrated - r->ready_to_run;
>> +			}
>>  		}
>>  
>>  		if (r->last_time > tprev)
>> @@ -2270,6 +2281,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>>  	r->total_sleep_time   += r->dt_sleep;
>>  	r->total_iowait_time  += r->dt_iowait;
>>  	r->total_preempt_time += r->dt_preempt;
>> +	r->total_pre_mig_time += r->dt_pre_mig;
>>  }
>>  
>>  static bool is_idle_sample(struct perf_sample *sample,
>> @@ -2684,8 +2696,14 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
>>  
>>  	tr->migrations++;
>>  
>> +	if (tr->migrated == 0)
>> +		tr->migrated = sample->time;
>> +
>>  	/* show migrations if requested */
>> -	timehist_print_migration_event(sched, evsel, sample, machine, thread);
>> +	if (sched->show_migrations) {
>> +		timehist_print_migration_event(sched, evsel, sample,
>> +							machine, thread);
>> +	}
>>  
>>  	return 0;
>>  }
>> @@ -2836,11 +2854,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>>  		/* last state is used to determine where to account wait time */
>>  		tr->last_state = state;
>>  
>> -		/* sched out event for task so reset ready to run time */
>> +		/* sched out event for task so reset ready to run time and migrated time */
>>  		if (state == 'R')
>>  			tr->ready_to_run = t;
>>  		else
>>  			tr->ready_to_run = 0;
>> +
>> +		tr->migrated = 0;
>>  	}
>>  
>>  	evsel__save_time(evsel, sample->time, sample->cpu);
>> @@ -3280,8 +3300,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
>>  		goto out;
>>  	}
>>  
>> -	if (sched->show_migrations &&
>> -	    perf_session__set_tracepoints_handlers(session, migrate_handlers))
>> +	if ((sched->show_migrations || sched->pre_migrations) &&
>> +		perf_session__set_tracepoints_handlers(session, migrate_handlers))
>>  		goto out;
>>  
>>  	/* pre-allocate struct for per-CPU idle stats */
>> @@ -3823,6 +3843,7 @@ int cmd_sched(int argc, const char **argv)
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

