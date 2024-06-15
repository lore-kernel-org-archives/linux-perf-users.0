Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78A14AB8;
	Sat, 15 Jun 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482079; cv=none; b=uNeULkLtfw8vJrIYgPBILCFSlamnF/iQI+J5/wVIs6KsOTz0MrJ88aJmfvDMo0aKJW+OXMZ72L8W+94XDO0PCCOvscqY1bcx9lLAFlUO2vEnUfm1EfWAFlpMhrVkMU+BOVcC+cEV9cEnvOkd9C8G/7D1GvTnQoxPS2SGJ5Bzgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482079; c=relaxed/simple;
	bh=YCu/peyDaI+A0hkMSIIXqQ1/fDb1mOM43Cm8uIckWzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qti5j+n027rZ9deFJM8zDIkGFS6HtXO3UCc9GgPvjx1EyHNKqZYFYTASOW8ryVxZYOMUUKQ5lpa7tDCesN1zv1IeEMszvIgV0Z2NyYYDtCloJmzkS9nLRzcc19+JMXCzItwBabQBBOkIdg5H1idmY8LbmB+L+ZwhGlrf+HpG65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HwCG9fGF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HwCG9fGF"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FJweZe001312;
	Sat, 15 Jun 2024 20:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=tOhCydZZ5KzFGYGUnWlC9gH/RCkowUVJe96HDywTcLk=; b=HwCG9fGFMJxJ
	P0Qbx9XirgVUdunBqD+YN1TCyLfBMKxPz+oR3J3Olwn1DzFEC+8rd+UScaLLyNti
	FcLLXRyHRPGjQNzsmM7mxjxZWuD05w7YObDKufK41WbW7UsfVqK7yXZR54VHW3Z8
	xdUJJQjjtCt4+BZRr4BLnEEYB++HLf0d0fe3q31hp6Sms0KpX8pqo/tDr1oF3KAZ
	UvrP3wJ5P5tU9KbbVSDr4f93c6zkUYuoShS1B/l1ajyeIWRGztEHW20AVj+rw9W3
	o44QhCa7s3fF+cvDGCkY8jA1SQ3mT9iJ5LJXeLB3YwXGOfzQpwKLi/KZIlyBL+Kg
	cNY9p7k7Zw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yshk480bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:07:43 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45FK7hf4015145;
	Sat, 15 Jun 2024 20:07:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yshk480bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:07:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45FGwuAg032220;
	Sat, 15 Jun 2024 20:07:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mvb8fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 20:07:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45FK7dK035455302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 20:07:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E41A358052;
	Sat, 15 Jun 2024 20:07:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3475C58064;
	Sat, 15 Jun 2024 20:07:34 +0000 (GMT)
Received: from [9.43.66.127] (unknown [9.43.66.127])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Jun 2024 20:07:33 +0000 (GMT)
Message-ID: <cc77571e-89d0-490b-9cb5-0f7520ae9ad9@linux.ibm.com>
Date: Sun, 16 Jun 2024 01:37:31 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: sched map skips redundant lines with cpu filters
Content-Language: en-US
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240614073517.94974-1-sieberf@amazon.com>
Reply-To: 20240614073517.94974-1-sieberf@amazon.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240614073517.94974-1-sieberf@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fif73C9KZPtM0iD1zQiYbIR7MOlUPw7s
X-Proofpoint-GUID: y3XYwono5dA_E3kP3VX8-AFIOoRi2Vkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_14,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150152

Hi Fernand,

On 14/06/24 13:05, Fernand Sieber wrote:
> perf sched map supports cpu filter.
> However, even with cpu filters active, any context switch currently
> corresponds to a separate line.
> As result, context switches on irrelevant cpus result to redundant lines,
> which makes the output particlularly difficult to read on wide
> architectures.
> 
> Fix it by skipping printing for irrelevant CPUs.
> 
> Example snippet of output before fix:
> 
>   *B0       1.461147 secs
>    B0
>    B0
>    B0
>   *G0       1.517139 secs
> 
> After fix:
> 
>   *B0       1.461147 secs
>   *G0       1.517139 secs

Yes, this makes sense. The current implementation doesn't even print timestamp
for the redundant lines as shown in the example below.

   .  *F0   708529.114889 secs F0 => schbench:278841
   .   F0 
   .   F0 
   .  *.    708529.114919 secs 

It makes sense to remove them entirely since we can still infer the sched-out
time for the selected CPUs implicitly.

Reviewed-and-tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy

> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/perf/builtin-sched.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7422c930abaf..aa59f763ca46 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1594,8 +1594,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  
> -	printf("  ");
> -
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1622,6 +1620,11 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  		new_shortname = 1;
>  	}
>  
> +	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
> +		goto out;
> +
> +	printf("  ");
> +
>  	for (i = 0; i < cpus_nr; i++) {
>  		struct perf_cpu cpu = {
>  			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
> @@ -1656,9 +1659,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			color_fprintf(stdout, color, "   ");
>  	}
>  
> -	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
> -		goto out;
> -
>  	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
>  	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
>  	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
> @@ -1675,9 +1675,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  	if (sched->map.comp && new_cpu)
>  		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
>  
> -out:
>  	color_fprintf(stdout, color, "\n");
>  
> +out:
>  	thread__put(sched_in);
>  
>  	return 0;

