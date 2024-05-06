Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54492F2C;
	Mon,  6 May 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009724; cv=none; b=Li2FwmUKrMoSxwTjUhCigxKy4WfZApWm87HYl8h6paYDFfuUWLjv1eWPktybPmkoJZm3X3w917KVJC8xLXLFwQe0HBxaq6G11lNbR0sXQ7SCVsf5pRKaKsym5Iq5OQyit4ZM5BLFGzp5ZPWyU7zhk+OO7/Cb3PMRA/ZmBOEldqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009724; c=relaxed/simple;
	bh=lYo//rrrDUiDk8JLNxviUfme0TBZCo3Xp6SdmDV+nC8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKG/8wK0ziVQdIDJLZK4P/3K63QzXZRyZujNeEFoGSlNv58leshL05RybckVEOR+ErhAGfANhwFJrkX7qGwtYu3NBQG499PT2xWFeYOaIvCy9QOckdLy0IZrV3M+g07wQo71reUZ9p0STim0ROt08TJDsPsRMzavEsZLNNQtMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qcVFe/CT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qcVFe/CT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446FIFGx023044;
	Mon, 6 May 2024 15:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wxmOj2iq91mLUwhozzjDt0aJ2qD+YW23qpVgADmcC5k=;
 b=qcVFe/CTxIKn/fDSWnfiZTORZY4fqWEzsFfoaht0HlqZzqyxPCxrHhybhhgKNfhC8g6L
 26bQkUIJQDgyUiQU9yTyR2ARyB9LHPOhv+Axfyx+/rXbfrk8CTT23UvGTO8oa6hq6upa
 dBlTyUWHCgChxxZEGuw0a/sVPVVd5ULvmfXq8Qipke/Co19IV4xa/J9jlUWBwRTSkoKv
 ymprVxm/qnD1L36kD1TRK49B/onrOKjZw5i2ygN7vBmys06thlxOyHP6Q0YMQ8vc+zWd
 RbIXxb7SOID7fnszmhMd4y4zU878JgevgpOjsOiA5CV3BglMkQ8Er2oN7bBq5zS92ru5 sA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy1qp81jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:35:03 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446FZ2m6017285;
	Mon, 6 May 2024 15:35:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy1qp81j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:35:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446ELmPR013959;
	Mon, 6 May 2024 15:35:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222r8c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:35:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446FYwO346596390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 15:35:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 436E52004B;
	Mon,  6 May 2024 15:34:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63FE720040;
	Mon,  6 May 2024 15:34:57 +0000 (GMT)
Received: from [9.179.19.152] (unknown [9.179.19.152])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 15:34:57 +0000 (GMT)
Message-ID: <9cc947ea-4d3d-4d60-8986-cd7c527b3508@linux.ibm.com>
Date: Mon, 6 May 2024 17:34:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] Assume sysfs event names are always the same case
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20240502213507.2339733-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VZqydJjZudOV_NROmu_vOh_5aqULOJpO
X-Proofpoint-GUID: Ks5p9td3XSzu6y-EReEOVWPffqVps1p6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060108

On 5/2/24 23:35, Ian Rogers wrote:
> By assuming sysfs events are either upper or lower case, the case
> insensitive event parsing can probe for the existence of files rather
> then loading all events in a directory. When the event is a json event
> like inst_retired.any on Intel, this reduces the number of openat
> calls on a Tigerlake laptop from 325 down to 255.
> 
> v1 sent as an RFC:
>     https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/
> 
> v2: addresses review feedback from Kan Liang, by updating
>     documentation and adding tests.
> 
> v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
>     that s390 event names are all upper case. Do a lower case probe
>     then an upper case probe, make documentation and tests also agree.
> 
> v4: add checks to write (kernel test robot) and fix a typo.
> 
> v5: Add reviewed-by: Kan Liang and fix potential uninitialized use.
> 
> Ian Rogers (6):
>   perf test pmu-events: Make it clearer that pmu-events tests json
>     events
>   perf Document: Sysfs event names must be lower or upper case
>   perf test pmu: Refactor format test and exposed test APIs
>   perf test pmu: Add an eagerly loaded event test
>   perf test pmu: Test all sysfs PMU event names are the same case
>   perf pmu: Assume sysfs events are always the same case
> 
>  .../sysfs-bus-event_source-devices-events     |   6 +
>  tools/perf/tests/pmu-events.c                 |   2 +-
>  tools/perf/tests/pmu.c                        | 467 ++++++++++++------
>  tools/perf/util/parse-events.c                |   2 +-
>  tools/perf/util/parse-events.h                |   2 +-
>  tools/perf/util/pmu.c                         | 111 +++--
>  tools/perf/util/pmu.h                         |   4 +-
>  tools/perf/util/pmus.c                        |  16 +-
>  tools/perf/util/pmus.h                        |   2 +
>  9 files changed, 415 insertions(+), 197 deletions(-)
> 

I run the perf test suite on s390 and it looks good!

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

