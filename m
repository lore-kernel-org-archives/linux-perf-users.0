Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B0286415;
	Thu,  4 Dec 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834718; cv=none; b=j2nDUzsfyxiLF/dT6rergoqla9YBdA38puGur5yqoYFJejTgIkV0xswXZXjFwNqjrH0VdJRnsykmGEuizHUBMJkYMI6/Tq3DHdSCtjIwxvjkoXBRrWONPQbeFXe4BgU53OxYTVIadoMTMjd9i5qG7m2JgRqegFS/4MrZt/VF1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834718; c=relaxed/simple;
	bh=CLOVtkFj36p+lqKMZytDrQ5E65kZZTX+AdOS5U4BALE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Me445cYvIksS3wGjQj1efy390mH81F7S2H89lS/FG7T1vr3wcAGapLLJOqWPmP62MCEQv80W1HIkgn/feROGmx0ZUerclj80NDNR0k3LNTga+Bl6cmez2aqFvbv8D7lioNaWB1FKK6fm11fLGLlRmt17PgLyEoi2R2peGH7C83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H07qanef; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H07qanef"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3L7Pq9007787;
	Thu, 4 Dec 2025 07:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w6IwQM
	0vQmC3uFb4D8z4GBVWC+9IrDFhfN3E062Y4QM=; b=H07qanefDXdVjYiI0DlFJB
	5BIQB81llkzNZNAz2tCyGmBToag3F96Ucyu2Z7AKrSqqVhaSiKE+LMKg+P0YGZa7
	aczp2mTy/1ykp+0XayBQ7x+llFHL2sk45Kmq6NMS4ut4E6jLytRoAX7kYmiLOjL5
	kx4u00czj28cWFErR9O1S/pYtXCIv+qEaUah5omhknEgHEvjOxQ21lA9+TnrncCQ
	GMbvn09qkL7iYORayU1cNEYaVluG68FK7lvOadI62yddNZNh6LoqFcsH69Eo5MXs
	hpXvohc7risI2P3sW2PA3cBRqhmJgX4N0YBf12T3p94hZPqwDT2VUVCgHrYjD/Gw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q6r91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 07:51:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B47pcb7027178;
	Thu, 4 Dec 2025 07:51:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q6r8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 07:51:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B45EjgV029361;
	Thu, 4 Dec 2025 07:51:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1pap3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 07:51:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B47pZeR16318766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 07:51:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73A722004B;
	Thu,  4 Dec 2025 07:51:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3430C20043;
	Thu,  4 Dec 2025 07:51:35 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 07:51:35 +0000 (GMT)
Message-ID: <1dd3d66f-f770-4f38-80da-51a16f084401@linux.ibm.com>
Date: Thu, 4 Dec 2025 08:51:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related
 fixes/tests
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251203214706.112174-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX5WGZYW76u4ZO
 Gj0dvztsk7ue8BF8leWXtkN0M/8tfMkvARs6NkswC0/LCInJW0tQNAKBipJ3aEAvETBDKTcdOC+
 8QnJYbKoMkEK2ak73a6LNrULiyW0i2sUOuRCqunTDdqILud0d9t51SOM58gN3WqVe+Oz9PL+A86
 pYmKE0d2oqahDdLR0+/yREKZHifwt5HPe17/c8Mmhbbh68Erbc9df0wsujRYzZBm40pEDqQ9Tv1
 dMDfMTjwhDKqspBPzrg/fQ62H2Mjm2t2HMWDkAH6v8Fj+tOwGxlMJh8Wh+9DYejIzuWkLpQOvdN
 ffLuRffZnzBc2P144HnvpsmiFXYdHWZZyBVEPbyJS9okTcZXN5PU2gfDpgoM+L5FSrOElzXOjrP
 d5FotYO+qdo1mF8UZBcLMcZeFP+CnQ==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=69313d8b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=x4kxwI2lhZTCVj833_4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uWpyQVOb9WJlhkbhGRN1DUTWxtdyPIJx
X-Proofpoint-GUID: xc9wQJAt69Bjebo_--1nJpGutYuyLvxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On 12/3/25 22:46, Ian Rogers wrote:
> Ingo reported [1] that `perf stat --null` was segfaulting. Fix the
> underlying issue and add a test to the "perf stat tests". Do some
> related fixing/cleanup in the perf util cpumap code.
> 
> Thomas reported an issue fixed by the same patches [2] but caused by
> giving perf stat an offline CPU. Add test coverage for that and
> improve the "error" message that reports "success".
> 
> Ingo further pointed at broken signal handling in repeat mode [3]. I
> observed we weren't giving the best exit code, 0 rather than the
> expected 128+<signal number>. Add a patch fixing this.
> 
> [1] https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
> [2] https://lore.kernel.org/linux-perf-users/94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com/
> [3] https://lore.kernel.org/lkml/aS5wjmbAM9ka3M2g@gmail.com/
> 
> Ian Rogers (7):
>   perf stat: Allow no events to open if this is a "--null" run
>   libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
>   perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
>   perf tests stat: Add "--null" coverage
>   perf stat: When no events, don't report an error if there is none
>   perf tests stat: Add test for error for an offline CPU
>   perf stat: Improve handling of termination by signal
> 
>  tools/lib/perf/cpumap.c        | 10 +++++----
>  tools/perf/builtin-stat.c      | 29 ++++++++++++++++++-------
>  tools/perf/tests/shell/stat.sh | 39 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/cpumap.c       |  9 ++++++--
>  4 files changed, 73 insertions(+), 14 deletions(-)
> 

For the whole series:

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks for fixing this, Ian

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
