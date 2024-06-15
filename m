Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875079F5;
	Sat, 15 Jun 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718484686; cv=none; b=i998Jf1X+ku7kOTVqJywJ5rEdCewF7NU9t7pL+1msnKttilIkKK6vKwtDQeLAH7hSASL6P0f1oPhQ4plA1CNHRUMpwuTlR4OpFFUKpqIGQjhyvZUe3UStUzybz1+f5yUkIrLhgddo/jYCiOOIdZ3oqEZ4A8BoMmNf1uLPE4AjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718484686; c=relaxed/simple;
	bh=MllfFT4mgPDkM6ZAysKsVRs3TNoxQ1YKm9CiWvzX8IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5fZWrbRhpaub/NiE7YHTPxBBpcEkb4RkFIEPSw1Kfa3oA/EuhY8BV/hC1GofXbhv4nRGMDGdofDw8I27rGb5lGUWpPLz4OZODsEPBYgWBXMsdhSgy1vLji5DPfdM3PrI+Mig3XYVc9CxanGlRvaJubdMNXUOUFnt33j6Z9jstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dHXyegPX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dHXyegPX"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FKSxa7011609;
	Sat, 15 Jun 2024 20:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:reply-to:in-reply-to:content-type:content-transfer-encoding; s=
	pp1; bh=ptuXxLf/BO+7rIpZKYNVU6AcIoSgu4Qlmu4JukdaCTE=; b=dHXyegPX
	XO9petkoFJ1LJJz/daBI+ert+oNx658BFrNlFTN0KyFqeL78Sw9jSFW4SqRDER5N
	jkQcOENjVZL0uC1VrJCxsZq358lx+ytfC6pw1QQXDVVrMAi+MfwRrA3CXvpZqPrr
	yra5ajNS0GFh+yXBpSFpgSyp1YGB19LV5oizm4TLTKWdxzpLPtzU1sdMoVoC59Kg
	8DFUXrAyEWyjKXguCK+kcRp4XmH87wNuHqiEzl6N7pVg1KAtkfnSja4w7ty/1z/J
	S4EoNGBx5SQnmZtNuXggNKxWrbvVIS6iWiDl6oLeZoU0OYj2ELQvtYYjyEEtbjy/
	cuHX0J04KdmrFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ysj15r13d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:51:13 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45FKpCKQ012339;
	Sat, 15 Jun 2024 20:51:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ysj15r13b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:51:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45FKB9vW003905;
	Sat, 15 Jun 2024 20:51:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mqu77e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:51:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45FKp9KF42861042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 20:51:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2688D58054;
	Sat, 15 Jun 2024 20:51:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17E7C58045;
	Sat, 15 Jun 2024 20:51:03 +0000 (GMT)
Received: from [9.43.66.127] (unknown [9.43.66.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Jun 2024 20:51:02 +0000 (GMT)
Message-ID: <1bb99f6f-532f-47cb-963c-c5c0262e383c@linux.ibm.com>
Date: Sun, 16 Jun 2024 02:20:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Timehist account sch delay for scheduled out
 running
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240613185906.31082-1-sieberf@amazon.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20240613185906.31082-1-sieberf@amazon.com
In-Reply-To: <20240613185906.31082-1-sieberf@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LrGBZKLrLMXDhACCjYG8xCRUZy_xgdLp
X-Proofpoint-ORIG-GUID: NhlEEo5okCH63B_qU0OwxUDmaIFvTEDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_14,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150155

Hi Fernand,

On 14/06/24 00:29, Fernand Sieber wrote:
> When using perf timehist, sch delay is only computed for a waking task,
> not for a pre empted task. This patches addresses this problem.
> 
> Example of `perf timehist` report before the patch for `stress` task
> competing with each other.
> 
> First column is wait time, second column sch delay, third column
> runtime.
> ```
>        1.492060 [0000]  s    stress[81]                          1.999      0.000      2.000      R  next: stress[83]
>        1.494060 [0000]  s    stress[83]                          2.000      0.000      2.000      R  next: stress[81]
>        1.496060 [0000]  s    stress[81]                          2.000      0.000      2.000      R  next: stress[83]
>        1.498060 [0000]  s    stress[83]                          2.000      0.000      1.999      R  next: stress[81]
> ```
> 
> After the patch, it looks like this (note that all wait time is now sch
> delay instead of zero):
> ```
> 1.492060 [0000]  s    stress[81]                          1.999      1.999      2.000      R  next: stress[83]
> 1.494060 [0000]  s    stress[83]                          2.000      2.000      2.000      R  next: stress[81]
> 1.496060 [0000]  s    stress[81]                          2.000      2.000      2.000      R  next: stress[83]
> 1.498060 [0000]  s    stress[83]                          2.000      2.000      1.999      R  next: stress[81]
> ```
> 
> In timehist:
> * wait time represents the duration waiting for any system resource
> * sch delay represents the duration waiting for cpu system resources

According to the documentation(perf-sched man page), scheduling delay is defined
as the "time between wakeup and actually running."

When a task switches out, if its state is 'R' , then the task would switch-in
again without waking and wakeup in between.Therefore, that duration is not
currently calculated as scheduling delay, which aligns with the man page
description.

I agree that the time a task is preempted involuntarily and is waiting to run
could be considered part of the scheduling delay. The definition is somewhat
vague in this regard.

If you decide to proceed with this change, please ensure the man page is updated
accordingly.

Regarding wait time, the man page defines it as the "time between sched-out and
the next sched-in events for the task." This measurement does not depend on the
task state and includes time spent on a voluntary switch.

Thanks and Regards
Madadi Vineeth Reddy

> 
> This is based on perf comments (dt_wait = wait time, dt_delay = sch
> delay):
> ```
> /*
>  * Explanation of delta-time stats:
>  *
>  *            t = time of current schedule out event
>  *        tprev = time of previous sched out event
>  *                also time of schedule-in event for current task
>  *    last_time = time of last sched change event for current task
>  *                (i.e, time process was last scheduled out)
>  * ready_to_run = time of wakeup for current task
>  *
>  * -----|------------|------------|------------|------
>  *    last         ready        tprev          t
>  *    time         to run
>  *
>  *      |-------- dt_wait --------|
>  *                   |- dt_delay -|-- dt_run --|
>  *
>  *   dt_run = run time of current task
>  *  dt_wait = time between last schedule out event for task and tprev
>  *            represents time spent off the cpu
>  * dt_delay = time between wakeup and schedule-in of task
>  */
>  ```
> 
> The problem with the current logic is that last time is only set when
> waking a task. Therefore it is not set for a pre empted task. To fix
> this, we set last time to the current sample time if a scheduled out
> task (on the switch tracepoint) is in state running.
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/perf/builtin-sched.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 5977c49ae2c7..7422c930abaf 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2659,7 +2659,10 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  		tr->last_state = state;
>  
>  		/* sched out event for task so reset ready to run time */
> -		tr->ready_to_run = 0;
> +		if (state == 'R')
> +			tr->ready_to_run = t;
> +		else
> +			tr->ready_to_run = 0;
>  	}
>  
>  	evsel__save_time(evsel, sample->time, sample->cpu);

