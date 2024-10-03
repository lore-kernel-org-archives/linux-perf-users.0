Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CE1A76B9;
	Thu,  3 Oct 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981477; cv=none; b=efS5ebTilpZymJ6nCWiEhlMb1zG3vYx2TJzmx03V/ZfDnb8aP17DV721SBz06pfhPshZThMlVbeFzvzMexCTHBQQhvZYm8BQ+X0XqEcBDuCPHxXj5YYLe5JW5ZbvePTMkta43QpkDNCrlY9RCXVVmuATq8eMtmlDfQVv9bPP4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981477; c=relaxed/simple;
	bh=GGGK1a72/t5AaZfKs37WLY4Av8JNCOoUmvQlvbTp3Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD/652IEYRRjLVhs2vXdLov1q7RSIOGwMc95auFC8khl2OYl3zWvTIS083cgdyWcQ9yx/kUUxo2Vop7U2FvJkBBJrtKneuo6nvOIJEgnK0R+gTsGPACcq6QEvTfYkoZY8TCed8cT1EQ1V64ea6QqYtdSNj4jmoxY8hab2pna6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MJ9xTErp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MJ9xTErp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493IK1k2003412;
	Thu, 3 Oct 2024 18:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
	WzzeG8yV6FJxbFhOv67kxHPmiK/cbC9wo/Oe1EqONc=; b=MJ9xTErpwp/G+sroM
	C76JwOWmABxmkY99p8g5J6h6dpY4mS7TUM70AmXx1MyaiyliUD+YgzJZlHJXWJyB
	K9R1TgERJBFrW5I16cG3WfXlHdXS7A54w9TtUUNDwloyOPRARnKHznC9NPPABFhO
	Redrch7eW41w7Rf905AeZdOxpnwL7FBNEKuiAWuPGXbcVCGIlIlrCt3m6CC/sp71
	Hz4NfdviDr716+cPMAT++KRwUv4iIXeVSqaozYLZwgCbUMABNxA29sjMMo3Rs+Ls
	aE9dxcbzWq5pqwiWQRpf0Kg8F7z+dRZDU/2b4D9CKIhuwPCfuiBQuhMJBf7y9I9I
	rhKRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4220f004pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 18:51:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493Ip12N004420;
	Thu, 3 Oct 2024 18:51:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4220f004pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 18:51:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493I3r9p009416;
	Thu, 3 Oct 2024 18:50:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42207hg6qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 18:50:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493IoxnG48234796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 18:50:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C52758061;
	Thu,  3 Oct 2024 18:50:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF0C058057;
	Thu,  3 Oct 2024 18:50:48 +0000 (GMT)
Received: from [9.43.2.223] (unknown [9.43.2.223])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 18:50:48 +0000 (GMT)
Message-ID: <2b219313-f2ac-4228-b61f-f629d99c4a55@linux.ibm.com>
Date: Fri, 4 Oct 2024 00:20:46 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf sched timehist: Add pre-migration wait time
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
References: <20241003025914.12220-1-vineethr@linux.ibm.com>
 <Zv7NTCajLTlykn_I@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zv7NTCajLTlykn_I@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DCUkXOnHxE9zR1PmwH4Y5QX_YYNQS7uK
X-Proofpoint-ORIG-GUID: Vs574YK8_qup_EadA1j8F8cG5b9k184_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_16,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410030132

Hi Namhyung,

On 03/10/24 22:28, Namhyung Kim wrote:
> On Thu, Oct 03, 2024 at 08:29:14AM +0530, Madadi Vineeth Reddy wrote:
>> pre-migration wait time is the time that a task unnecessarily spends
>> on the runqueue of a CPU but doesn't get switched-in there. In terms
>> of tracepoints, it is the time between sched:sched_wakeup and
>> sched:sched_migrate_task.

[snip]

>> @@ -2239,6 +2244,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
> 
> One last thing, please update the ASCII art in the function comment on
> timehist_update_runtime_stats() to contain dt_pre_mig as well.

Sure, will do that in v5. Thanks for the feedback.

Thanks,
Madadi Vineeth Reddy

> 
> Thanks,
> Namhyung
> 
> 
>>  	r->dt_iowait  = 0;
>>  	r->dt_preempt = 0;
>>  	r->dt_run     = 0;
>> +	r->dt_pre_mig = 0;
>>  
>>  	if (tprev) {
>>  		r->dt_run = t - tprev;
>> @@ -2247,6 +2253,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>>  				pr_debug("time travel: wakeup time for task > previous sched_switch event\n");
>>  			else
>>  				r->dt_delay = tprev - r->ready_to_run;
>> +
>> +			if ((r->migrated > r->ready_to_run) && (r->migrated < tprev))
>> +				r->dt_pre_mig = r->migrated - r->ready_to_run;
>>  		}
>>  
>>  		if (r->last_time > tprev)
>> @@ -2270,6 +2279,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>>  	r->total_sleep_time   += r->dt_sleep;
>>  	r->total_iowait_time  += r->dt_iowait;
>>  	r->total_preempt_time += r->dt_preempt;
>> +	r->total_pre_mig_time += r->dt_pre_mig;
>>  }
>>  
>>  static bool is_idle_sample(struct perf_sample *sample,
>> @@ -2684,8 +2694,14 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
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
>> @@ -2836,11 +2852,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
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
>> @@ -3280,8 +3298,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
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
>> @@ -3823,6 +3841,7 @@ int cmd_sched(int argc, const char **argv)
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

