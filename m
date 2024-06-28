Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B3125AC;
	Fri, 28 Jun 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558625; cv=none; b=pB/wUfxQT5yJC9idPyszJj+lVj/pftxEE3deEY08tKBQeZI/9My8M4LgBMP7SEzy+GLAW2Pk+ANs47P24lrnyv84hED0xDWjXpFCepPIs6mPI6nFrBHjQzA6a95fB89dk1zZdF+rH+l58taCPPIYe4IUZeMvQqezHwaS6VBcYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558625; c=relaxed/simple;
	bh=hjz0jRgYOqGYfRv9AAQDNem5gMsVcZ4xMkQ4yoNtnP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vl73Eup3G0lt+2VFhPhTuDIptT3sV+XbJ74GVhbPE6Fp0StbvWJLUP0SSrj50rAoQOpMgFLUbyB+D0J/nMuS600VAvOfeMAH0dkMHjhqnzLohkLcao8w1CZpw4c79rOIYJl7eTWNDMpuirwuohIobFaO+doXuO8E90DRzWLN08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D33Wmqia; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D33Wmqia"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S78n5G024069;
	Fri, 28 Jun 2024 07:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	+LTHS3GFDNvxHMbV7PMh/CffIrKFZ3VBqWTpOkj4ULg=; b=D33Wmqiap4m4ehQ3
	f0mtDZZmOfwdGv8zNkIgpIYiBJbNKnyUyEgmLO/a11GnivSF0U8AGEcglOeQdZpb
	t2ot/RSmsnZIKqmlMQ5KdBwnHjXUXlmuYReP3ze8Bq0J2n5Q2opHaembnP/j5luU
	Uv4KvG5LTxJuOLls/17O8lQZTLFABK//paOP/+cMVES/v6TXn3uhrRZH6E80WIP+
	iE+xqpVYTzeywfYYqU3VMxLH/4IXZF7GU1i5tmseRYJ3aW9ZI5IyPxxxQwBpakJb
	e1yOKQGRUHgMyyPX2NL+6Zdu++XN5qKT1ecNeAcy8ViFmBKWY/JgX+ekDsu4scMU
	h9bKgA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401pm6r7vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:10:12 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S7AC5L025884;
	Fri, 28 Jun 2024 07:10:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401pm6r7vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:10:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S4HVKk000388;
	Fri, 28 Jun 2024 07:10:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3pppf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:10:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S7A8ab50201076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 07:10:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ED7558067;
	Fri, 28 Jun 2024 07:10:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A836458058;
	Fri, 28 Jun 2024 07:09:56 +0000 (GMT)
Received: from [9.43.26.83] (unknown [9.43.26.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 07:09:56 +0000 (GMT)
Message-ID: <8f43368c-dc85-4bcb-8905-294c8e0eec2b@linux.ibm.com>
Date: Fri, 28 Jun 2024 12:39:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf sched replay: Fix -r/--repeat command line option
 for infinity
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Chen Yu <yu.c.chen@intel.com>, Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, James Clark <james.clark@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers
 <irogers@google.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240621171909.24119-1-vineethr@linux.ibm.com>
 <51e9fd2f-7d86-40cb-b307-0b0b396ca32a@linux.ibm.com>
 <Zn4p0kMIsLNlv04X@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zn4p0kMIsLNlv04X@google.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9I5850vpc4kBvtXUHuMFUNMOrjKbKlmK
X-Proofpoint-GUID: nX0T1EWfEL-o3Mr8llprXigVxcdEyzJl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280049

Hi Namhyung,

On 28/06/24 08:41, Namhyung Kim wrote:
> On Fri, Jun 28, 2024 at 08:00:14AM +0530, Madadi Vineeth Reddy wrote:
>> On 21/06/24 22:49, Madadi Vineeth Reddy wrote:
>>> Currently, the -r/--repeat option accepts values from 0 and complains
>>> for -1. The help section specifies:
>>> -r, --repeat <n>      repeat the workload replay N times (-1: infinite)
>>>
>>> The -r -1 option raises an error because replay_repeat is defined as
>>> an unsigned int.
>>>
>>> In the current implementation, the workload is repeated n times when
>>> -r <n> is used, except when n is 0.
>>>
>>> When -r is set to 0, the workload is also repeated once. This happens
>>> because when -r=0, the run_one_test function is not called. (Note that
>>> mutex unlocking, which is essential for child threads spawned to emulate
>>> the workload, happens in run_one_test.) However, mutex unlocking is
>>> still performed in the destroy_tasks function. Thus, -r=0 results in the
>>> workload running once coincidentally.
>>>
>>> To clarify and maintain the existing logic for -r >= 1 (which runs the
>>> workload the specified number of times) and to fix the issue with infinite
>>> runs, make -r=0 perform an infinite run.
>>>
>>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>
>>
>> Hi all,
>> Any suggestions/comments on this patch?
> 
> I think the original intention was to set replay_repeat to UINT_MAX
> using -1.  But it seems to refuse the negative number now.
> 
> Maybe you can simply set it to UNIT_MAX for -r 0.

Thanks for the feedback. I will make the change and send a v3.

Thanks and Regards
Madadi Vineeth Reddy

> 
> Thanks,
> Namhyung
> 
> 
>>> ---
>>> Changes in v2:
>>> - Kept the existing 'for' loop and added a condition for infinite
>>>   looping. (James Clark)
>>> - This change also ensures that integer overflow doesn't occur when
>>>   'replay_repeat' is zero.
>>> - Add Reviewed-by tag from James Clark.
>>> - Rebase against perf-tools-next commit 788c5160526a ("perf vendor
>>>   events: Add westmereex counter information")
>>> - Link to v1: https://lore.kernel.org/all/20240618112907.15131-1-vineethr@linux.ibm.com/
>>>
>>>  tools/perf/Documentation/perf-sched.txt |  7 +++++++
>>>  tools/perf/builtin-sched.c              | 11 ++++++++---
>>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>>> index a216d2991b19..f1be8f0b249e 100644
>>> --- a/tools/perf/Documentation/perf-sched.txt
>>> +++ b/tools/perf/Documentation/perf-sched.txt
>>> @@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
>>>  --state::
>>>  	Show task state when it switched out.
>>>  
>>> +OPTIONS for 'perf sched replay'
>>> +------------------------------
>>> +
>>> +-r::
>>> +--repeat <n>::
>>> +	repeat the workload n times (0: infinite). Default is 10.
>>> +
>>>  SEE ALSO
>>>  --------
>>>  linkperf:perf-record[1]
>>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>>> index 8cdf18139a7e..51b3dea404bc 100644
>>> --- a/tools/perf/builtin-sched.c
>>> +++ b/tools/perf/builtin-sched.c
>>> @@ -3383,8 +3383,13 @@ static int perf_sched__replay(struct perf_sched *sched)
>>>  	sched->thread_funcs_exit = false;
>>>  	create_tasks(sched);
>>>  	printf("------------------------------------------------------------\n");
>>> -	for (i = 0; i < sched->replay_repeat; i++)
>>> -		run_one_test(sched);
>>> +	if (sched->replay_repeat == 0) {
>>> +		while (1)
>>> +			run_one_test(sched);
>>> +	} else {
>>> +		for (i = 0; i < sched->replay_repeat; i++)
>>> +			run_one_test(sched);
>>> +	}
>>>  
>>>  	sched->thread_funcs_exit = true;
>>>  	destroy_tasks(sched);
>>> @@ -3548,7 +3553,7 @@ int cmd_sched(int argc, const char **argv)
>>>  	};
>>>  	const struct option replay_options[] = {
>>>  	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
>>> -		     "repeat the workload replay N times (-1: infinite)"),
>>> +		     "repeat the workload replay N times (0: infinite)"),
>>>  	OPT_PARENT(sched_options)
>>>  	};
>>>  	const struct option map_options[] = {
>>

