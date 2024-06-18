Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472E13A248;
	Tue, 18 Jun 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703212; cv=none; b=fOIZy+p6PegsNXATfMhVwBAjpCz0gssKLmMtKK4wJpslXv7jzQYfBtj3+e1mBrkRsU8Z3hyimblaoW8QCnvd9Vz1LesTCwMDgN8p7OLrE4oqcULXTBepkh7zOG9z7qoCQ6jZvjBHQlJoOS3OUysyMbg354kXVqUXfTo+5+2qzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703212; c=relaxed/simple;
	bh=Y4yVcjYnnY7W8lsoQT++en4t/iTVNF7h0Z1wL7oWS/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMAGKJag17XAXsvHJ5INH0Hvvpf3OsyKqpdxvGb4hk6H3+taTKSXwn7fH7uusJxmLobKQp5SvJwJK/V0eL77GLuMd0Qpbn1SETLRInoehLSO5e47yndNdpdV5144PhjAjPiQQoSFVge4Y8I/sorIIkWyiDDjdKySN0QniQdXZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q2YLQ9eU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q2YLQ9eU"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I91GFD013050;
	Tue, 18 Jun 2024 09:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=A
	HwzZj6AgBzBAgYWznsea7PI3942li0K5f+aJcW29/M=; b=Q2YLQ9eUOV9qSqLd4
	/reVoikE6bPfipSQcy8TR32JESn+fLSjGFnQkyJgOJ5uglqrEaXOBR+VPoYdnEMA
	IM5jmmLNJBNJvx4QSKVtQpUvynaRZCNi0U2mHqF0LC63nCyYGS+GZVc2ZAlq//qs
	jR1VIDCnWbAWjdH2cSJBQ7C6kGFft6sAqU872L5Y23Q84XNtb623VKs4gxij5Njc
	YI5jg+u3+RGq2ZDLlL4kqWrnzJLMMyplnWjz+300WlWj1XBooXSHFv2UwKSi948V
	YdJLq688l/lrGFsZZ47QdyZNj7IAZfYcla1YKVFVoLgmyHUjr1lGc4Z6VdY1ImHy
	alh1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu6rkg6qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:23 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I9XMg5001731;
	Tue, 18 Jun 2024 09:33:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu6rkg6qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45I85rcY009478;
	Tue, 18 Jun 2024 09:33:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgmhb0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45I9XJkP48497230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:33:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15C745804B;
	Tue, 18 Jun 2024 09:33:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBFF58059;
	Tue, 18 Jun 2024 09:33:15 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 09:33:15 +0000 (GMT)
Message-ID: <d1282b00-1f5d-43d1-8b4d-cb4ea5840330@linux.ibm.com>
Date: Tue, 18 Jun 2024 15:03:14 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: Timehist account sch delay for scheduled out
 running
Content-Language: en-US
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240618090339.87482-1-sieberf@amazon.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240618090339.87482-1-sieberf@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pXfN1wn1a4Nhaq1tAIc_DccxM17QE9rH
X-Proofpoint-GUID: qziM_9SQu9cRK0ufqwmnIY3IRGzv1EoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180069

Hi Fernand,

On 18/06/24 14:33, Fernand Sieber wrote:
> When using perf timehist, sch delay is only computed for a waking task,
> not for a pre empted task. This patches changes sch delay to account for
> both. This makes sense as testing scheduling policy need to consider the
> effect of scheduling delay globally, not only for waking tasks.
> 
> Example of `perf timehist` report before the patch for `stress` task
> competing with each other.
> 
> First column is wait time, second column sch delay, third column
> runtime.
> 
> 1.492060 [0000]  s    stress[81]                          1.999      0.000      2.000      R  next: stress[83]
> 1.494060 [0000]  s    stress[83]                          2.000      0.000      2.000      R  next: stress[81]
> 1.496060 [0000]  s    stress[81]                          2.000      0.000      2.000      R  next: stress[83]
> 1.498060 [0000]  s    stress[83]                          2.000      0.000      1.999      R  next: stress[81]
> 
> After the patch, it looks like this (note that all wait time is not zero
> anymore):
> 
> 1.492060 [0000]  s    stress[81]                          1.999      1.999      2.000      R  next: stress[83]
> 1.494060 [0000]  s    stress[83]                          2.000      2.000      2.000      R  next: stress[81]
> 1.496060 [0000]  s    stress[81]                          2.000      2.000      2.000      R  next: stress[83]
> 1.498060 [0000]  s    stress[83]                          2.000      2.000      1.999      R  next: stress[81]
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt | 4 ++--
>  tools/perf/builtin-sched.c              | 5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index a216d2991b19..74c812f7a4a4 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -64,8 +64,8 @@ There are several variants of 'perf sched':
>      
>     By default it shows the individual schedule events, including the wait
>     time (time between sched-out and next sched-in events for the task), the
> -   task scheduling delay (time between wakeup and actually running) and run
> -   time for the task:
> +   task scheduling delay (time between runnable and actually running) and
> +   run time for the task:

LGTM.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy

>      
>                  time    cpu  task name             wait time  sch delay   run time
>                               [tid/pid]                (msec)     (msec)     (msec)
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

