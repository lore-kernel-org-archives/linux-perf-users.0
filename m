Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC585260;
	Fri,  4 Oct 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728025119; cv=none; b=sSko7DSTa3pOFeL8aMka4oYsYjIJxzDt9Tg/l3/y6Rj2Iomiwin0KgzhtbjS9BL2ZFpSmAqasIApv2AWYJ2E17OaTvX0tQn5lEJRBNsmKIvZ1QVvB51JmTVsRWtDVIreX92sDTTzrSrN68Q6D4/oLSlD6lV8lGgznjO7sBxxi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728025119; c=relaxed/simple;
	bh=u48eQTX/WHkpEDYLAIEhtqa6F+4Iys/9AYls623WqFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDkN3RyY6LS0U/aaE8ciIoyfnAEA1ooSAblRQMEKdXAckkL50aymXqxlxt6bv3fzyiZFnACqS8jImRQgulZPUzwQt7rVCjJmn5K6aMATkWKnIy+5Rqh9hFOl/YLPM/R2Z61XADuEkeUu5xcZ3esiz2xkpLGdrL0tUgDSf108dH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G1vGtGfY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G1vGtGfY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4946oJhs007898;
	Fri, 4 Oct 2024 06:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	7rAK+Z75vwEg/epbULKL3on+0/wxXnJe1OX/wY9VGg=; b=G1vGtGfYi39F63pmt
	gQLltgF4VnEItUwgk+fzQRKUKqMAbewIT7jBZk4KLehHP8JUXiUeXE6OSY936xSY
	z2rlguW8b4e9CBUuk4fTNomUhZJWb0TACzwSvIriLukPl7zR54Vkaiky1mvup4Qs
	apcQuf5QVEszaweD1P0AkhGYXivxmlgRz0NTqE48jgKFPaC1G2TXrdF56vZR7eJG
	jVxBrZ7I+DoE/sK5mvoHJfO8sseRspIULOQhfw/sZQUZAJ3NbmNcHkPOH0wBNFWl
	8NJdjESYw0mkmpCaJximSJs+MoxVy7GWCJfde6dQ2bMhPZKxywSa7NrHKL//lAyb
	/ubaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422bet01bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 06:58:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4946tjCt019967;
	Fri, 4 Oct 2024 06:58:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422bet01bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 06:58:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4942euq7001726;
	Fri, 4 Oct 2024 06:58:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42207k2kmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 06:58:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4946wN1Q48497138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 06:58:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C37958062;
	Fri,  4 Oct 2024 06:58:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B626658058;
	Fri,  4 Oct 2024 06:58:13 +0000 (GMT)
Received: from [9.43.3.148] (unknown [9.43.3.148])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Oct 2024 06:58:13 +0000 (GMT)
Message-ID: <28359234-e818-4e3c-a99d-5c2306c15f9a@linux.ibm.com>
Date: Fri, 4 Oct 2024 12:28:11 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf sched timehist: Add pre-migration wait time
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241002163917.33781-1-vineethr@linux.ibm.com>
 <05c572743f8cefd0da65a56d9b110697eba5529e.camel@linux.intel.com>
 <Zv8YiooRdcT-x8iN@google.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <Zv8YiooRdcT-x8iN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l_BcwlGE7xqq6Vm_isoaPdaSEWWkimBY
X-Proofpoint-GUID: GuYVrjHYq30yUgRmTtHH94qFq8QpMFgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_05,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=506 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040044

On 04/10/24 03:49, Namhyung Kim wrote:
> On Thu, Oct 03, 2024 at 03:04:28PM -0700, Tim Chen wrote:
>> On Wed, 2024-10-02 at 22:09 +0530, Madadi Vineeth Reddy wrote:
>>> pre-migration wait time is the time that a task unnecessarily spends
>>> on the runqueue of a CPU but doesn't get switched-in there. In terms
>>> of tracepoints, it is the time between sched:sched_wakeup and
>>> sched:sched_migrate_task.
>>>
>>> Let's say a task woke up on CPU2, then it got migrated to CPU4 and
>>> then it's switched-in to CPU4. So, here pre-migration wait time is
>>> time that it was waiting on runqueue of CPU2 after it is woken up.
>>>
>>> The general pattern for pre-migration to occur is:
>>> sched:sched_wakeup
>>> sched:sched_migrate_task
>>> sched:sched_switch
>>
>> If a task migrate from CPU A to CPU B, but is unlucky that
>> someone took CPU B and it has to wait. Then it is yet again migrated to CPU C.
>> Do you only compute pre-mig time as 
>> t_sched_migrate_task_CPU_A - t_sched_migrate_task_CPU_A?
>>
>> The task also spend some pre-mig time on CPU_B that probably
>> should be included.  And that time is when it migrates to B
>> till it is migrated away from B.  Do you take that into
>> account?
> 
> Hmm.. right.  The current code updates the migrate time only if it's 0.
> But I think it can just always update the time to get the latest one.
> 

Right. I’ll update the code to always pick the latest migrate time, ensuring
that scenarios with multiple migrations in between are handled correctly.

Thanks,
Madadi Vineeth Reddy

> Thanks,
> Namhyung

