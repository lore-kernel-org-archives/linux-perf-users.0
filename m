Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA813BC31;
	Tue, 18 Jun 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727004; cv=none; b=r1lUeUARbUcWClGdfPQ/J6Z7TJE4csz1qaOUDyHng0/gVZs62VYHbeHkHZnpWyhnGwOe0yQyiOVi4dn4ltxI0EY/qdSotNYaOzEmC3cRYcuoMfWs6hdZveuNVa7kFN/3ai15OiMsdG6rMZlNAp1/Th8dhWHOd98+IkWW0GaiiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727004; c=relaxed/simple;
	bh=P7jN1QUgt1wBJSkfffoMPyBDHt7gg3dnEuOkFlInuGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTc61J3r9u5sTQaMTeslqe/izchX/Yn+6aH+KcgSUYyWTBU39fVgDKpJCZZOxLkD2m2FAqdmaVZMHmrY8XEj/Vh85qoYhWBhZMhDS7fpW7bblMjs5iJAtCIyQO3TbaZDfQFewDv+J/YYUD783rrRCZaQvtfnK7MCiaVoevS26fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EkDn0pKb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EkDn0pKb"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IG0D8Z004914;
	Tue, 18 Jun 2024 16:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=5usvpiL+Io5D2h/60jUJrWdD1F7ANVDv+OCowk5LQtY=; b=EkDn0pKbqVxa
	moPy+9gbwrhs0f7kY7pyrxnqG4icUpX5lC1dn/lHZmMHuT9rJf71/8H5x5XC0mMo
	qZfXsXqjwqt91E5Rg8BMbeGEKnX4qUEfWrrN7gnkj165rG1UpBn8obYExri3M+K4
	r/poKqMXjXjBFvU9X+oDN1wvTMUSwJcAl7e+2THkMD9UwbsTFPD+L3YXTD3Efrix
	Bupk87BmNikKCRVcJxvNcRGI/1dZLVZstburQLZfLqKV5iCHPGQlxYQT7/gvcGwW
	dmwdIyX73iwNljkIktlSoBLxDL2twb4nsY4zh7tJhTAPQzC8jKKL2+sLvonZ6ptw
	lBhjJ+Q1Eg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yudc800s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:09:39 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45IG9cHN018365;
	Tue, 18 Jun 2024 16:09:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yudc800s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:09:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45IEgftM019567;
	Tue, 18 Jun 2024 16:09:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp14yva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:09:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45IG9ZIN61211104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:09:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1390E58059;
	Tue, 18 Jun 2024 16:09:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D9D25805B;
	Tue, 18 Jun 2024 16:09:20 +0000 (GMT)
Received: from [9.43.113.104] (unknown [9.43.113.104])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 16:09:20 +0000 (GMT)
Message-ID: <ff2c43e3-31d3-40c8-a597-cd0be751c0f2@linux.ibm.com>
Date: Tue, 18 Jun 2024 21:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched replay: Fix -r/--repeat command line option
 for infinity
To: James Clark <james.clark@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240618112907.15131-1-vineethr@linux.ibm.com>
 <f435e2d2-f864-4a34-bc38-cb06ce140a6f@arm.com>
Content-Language: en-US
Reply-To: f435e2d2-f864-4a34-bc38-cb06ce140a6f@arm.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <f435e2d2-f864-4a34-bc38-cb06ce140a6f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tjFymmwJBwikScJkYRps53WbvyIExxxD
X-Proofpoint-ORIG-GUID: O8JPM7kRh3ip9oMOrOD54XmAo8AxCS6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180119

Hi James,

On 18/06/24 18:34, James Clark wrote:
> 
> 
> On 18/06/2024 12:29, Madadi Vineeth Reddy wrote:
>> Currently, the -r/--repeat option accepts values from 0 and complains
>> for -1. The help section specifies:
>> -r, --repeat <n>      repeat the workload replay N times (-1: infinite)
>>
> 
> I was wondering if this was a regression or was always like this but
> it's at least been broken long before it becomes difficult to build
> Perf for me.
> 
>> The -r -1 option raises an error because replay_repeat is defined as
>> an unsigned int.
>>
>> In the current implementation, the workload is repeated n times when
>> -r <n> is used, except when n is 0.
>>
>> When -r is set to 0, the workload is also repeated once. This happens
>> because when -r=0, the run_one_test function is not called. (Note that
>> mutex unlocking, which is essential for child threads spawned to emulate
>> the workload, happens in run_one_test.) However, mutex unlocking is
>> still performed in the destroy_tasks function. Thus, -r=0 results in the
>> workload running once coincidentally.
>>
> 
> I also saw an intermittent hang waiting in destroy_tasks() which is now
> fixed.
>  
>> To clarify and maintain the existing logic for -r >= 1 (which runs the
>> workload the specified number of times) and to fix the issue with infinite
>> runs, make -r=0 perform an infinite run.
>>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf-sched.txt | 7 +++++++
>>  tools/perf/builtin-sched.c              | 8 ++++++--
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index a216d2991b19..f1be8f0b249e 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
>>  --state::
>>  	Show task state when it switched out.
>>  
>> +OPTIONS for 'perf sched replay'
>> +------------------------------
>> +
>> +-r::
>> +--repeat <n>::
>> +	repeat the workload n times (0: infinite). Default is 10.
>> +
>>  SEE ALSO
>>  --------
>>  linkperf:perf-record[1]
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 8cdf18139a7e..2c4ed5c2d695 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3383,8 +3383,12 @@ static int perf_sched__replay(struct perf_sched *sched)
>>  	sched->thread_funcs_exit = false;
>>  	create_tasks(sched);
>>  	printf("------------------------------------------------------------\n");
>> -	for (i = 0; i < sched->replay_repeat; i++)
>> +
>> +	i = 0;
>> +	while (sched->replay_repeat == 0 || i < sched->replay_repeat) {
> 
> Very minor nit, but you don't really need to remove the for loop, just add
> the new condition to the existing one. Not sure if it's worth re-spinning
> for though.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> 

Thank you for taking a look!

Thanks and Regards
Madadi Vineeth Reddy

>>  		run_one_test(sched);
>> +		i++;
>> +	}
>>  
>>  	sched->thread_funcs_exit = true;
>>  	destroy_tasks(sched);
>> @@ -3548,7 +3552,7 @@ int cmd_sched(int argc, const char **argv)
>>  	};
>>  	const struct option replay_options[] = {
>>  	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
>> -		     "repeat the workload replay N times (-1: infinite)"),
>> +		     "repeat the workload replay N times (0: infinite)"),
>>  	OPT_PARENT(sched_options)
>>  	};
>>  	const struct option map_options[] = {

