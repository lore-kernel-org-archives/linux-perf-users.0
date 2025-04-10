Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA928D843;
	Thu, 10 Apr 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296770; cv=none; b=PbOvf1VJFW2WuWHRwKO0wB5jqaPLORXb6IjRh8D0Da1V2YoE4S26tPeriptN4od/TAm2C1iB8qV29KK6ciLZEAeonAu3IV2kpr0fcD9d5YXYnM9tKNsRN+yNbvnvYtvlkYut3l89/yYisjf4acSdCBJJTcWj7sQo7GeX/CER5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296770; c=relaxed/simple;
	bh=aSYm352NYQE/MH42KBzKOunEV66VU7o3gTe2n5QcI/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clK7Cj750lN2OyaXXUpmN/hBze0P1RoadhubjO1/8VqL2LDFW3+/6crbacf2polcZquKN5JNOq2KUCSXnOipWlcf+U5u1IL7UaB1YeMdNgpD/TAel6mDtzEHsduHLmyqBl/74rvcW6lzXA5avNjPlSgkKywfFnpVJDUbXDS9Ux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iK/X5qDc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iK/X5qDc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACS4q4003729;
	Thu, 10 Apr 2025 14:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uflz3f
	r3zEACVSkwKO4Va1H+S1fg8ckXpdeZfNdcP8o=; b=iK/X5qDcbiy/4DvQ6zItmp
	svmd/iSsZfTQyuGPdUOtRLnXD/DhXlBlQa/HTq/UDqhr/oVcWnzy9BXAZSCEt02h
	qipkWeLVuiCKppakrrK05WGtPZRyR6Y7JB0+p+JSQH3L5dNSDWctPwZoJUJeP3Fs
	x3SJjo9Dq8fcmKsdOWLW19LYYimqbTCaLHabvD5GWNKK5teA2IHbPD4Bmq4WWO/p
	ja8ALCcbK246ZKw1JQJGK2INYlovUlVkXXr7wIHPhhk1XLmUsdXJo9/SQnRr9Drn
	nmOAA4PMiiJ9fUb/lv6kIkyyA/7hvMk4+EBtu88r5VMl2qrT6P4JsMYlh4cfjvkg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13rses-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:52:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53AERUNI032200;
	Thu, 10 Apr 2025 14:52:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13rsem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:52:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ABxe9i011518;
	Thu, 10 Apr 2025 14:52:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yxm3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:52:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AEqD3p18743772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 14:52:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 210BA2004E;
	Thu, 10 Apr 2025 14:52:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51F4B20040;
	Thu, 10 Apr 2025 14:52:09 +0000 (GMT)
Received: from [9.124.208.29] (unknown [9.124.208.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 14:52:09 +0000 (GMT)
Message-ID: <ced9c08c-a017-495f-978b-0c4d13992e5e@linux.ibm.com>
Date: Thu, 10 Apr 2025 20:22:08 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/19] futex: Allow to make the private hash
 immutable.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
References: <20250407155742.968816-1-bigeasy@linutronix.de>
 <20250407155742.968816-20-bigeasy@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250407155742.968816-20-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jG7D2iyp0IGqO0wGXDWjpA0Vl-eqlvRh
X-Proofpoint-GUID: v5iaql_bpxC1ikhaGGlq4VbP7C1y8M_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100105

Hi Sebastian.

On 4/7/25 21:27, Sebastian Andrzej Siewior wrote:
> My initial testing showed that
> 	perf bench futex hash
> 
> reported less operations/sec with private hash. After using the same
> amount of buckets in the private hash as used by the global hash then
> the operations/sec were about the same.
> 
> This changed once the private hash became resizable. This feature added
> a RCU section and reference counting via atomic inc+dec operation into
> the hot path.
> The reference counting can be avoided if the private hash is made
> immutable.
> Extend PR_FUTEX_HASH_SET_SLOTS by a fourth argument which denotes if the
> private should be made immutable. Once set (to true) the a further
> resize is not allowed (same if set to global hash).
> Add PR_FUTEX_HASH_GET_IMMUTABLE which returns true if the hash can not
> be changed.
> Update "perf bench" suite.
> 

It would be good option for the application to decide if it needs this.
Using this option makes the perf regression goes away using previous number of buckets.

Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>

base:
./perf bench futex hash
Averaged 1556023 operations/sec (+- 0.08%), total secs = 10  <<-- 1.5M

with series:
./perf bench futex hash -b32768
Averaged 126499 operations/sec (+- 0.41%), total secs = 10   <<-- .12M

./perf bench futex hash -Ib32768
Averaged 1549339 operations/sec (+- 0.08%), total secs = 10  <<-- 1.5M


> For comparison, results of "perf bench futex hash -s":
> - Xeon CPU E5-2650, 2 NUMA nodes, total 32 CPUs:
>    - Before the introducing task local hash
>      shared  Averaged 1.487.148 operations/sec (+- 0,53%), total secs = 10
>      private Averaged 2.192.405 operations/sec (+- 0,07%), total secs = 10
> 
>    - With the series
>      shared  Averaged 1.326.342 operations/sec (+- 0,41%), total secs = 10
>      -b128   Averaged   141.394 operations/sec (+- 1,15%), total secs = 10
>      -Ib128  Averaged   851.490 operations/sec (+- 0,67%), total secs = 10
>      -b8192  Averaged   131.321 operations/sec (+- 2,13%), total secs = 10
>      -Ib8192 Averaged 1.923.077 operations/sec (+- 0,61%), total secs = 10
>      128 is the default allocation of hash buckets.
>      8192 was the previous amount of allocated hash buckets.
> 
> - Xeon(R) CPU E7-8890 v3, 4 NUMA nodes, total 144 CPUs:
>    - Before the introducing task local hash
>      shared   Averaged 1.810.936 operations/sec (+- 0,26%), total secs = 20
>      private  Averaged 2.505.801 operations/sec (+- 0,05%), total secs = 20
> 
>    - With the series
>      shared   Averaged 1.589.002 operations/sec (+- 0,25%), total secs = 20
>      -b1024   Averaged    42.410 operations/sec (+- 0,20%), total secs = 20
>      -Ib1024  Averaged   740.638 operations/sec (+- 1,51%), total secs = 20
>      -b65536  Averaged    48.811 operations/sec (+- 1,35%), total secs = 20
>      -Ib65536 Averaged 1.963.165 operations/sec (+- 0,18%), total secs = 20
>      1024 is the default allocation of hash buckets.
>      65536 was the previous amount of allocated hash buckets.
> 
> Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/futex.h                  |  2 +-
>   include/uapi/linux/prctl.h             |  1 +
>   kernel/futex/core.c                    | 42 ++++++++++++++++++++++----
>   kernel/sys.c                           |  2 +-
>   tools/include/uapi/linux/prctl.h       |  1 +
>   tools/perf/bench/futex-hash.c          |  1 +
>   tools/perf/bench/futex-lock-pi.c       |  1 +
>   tools/perf/bench/futex-requeue.c       |  1 +
>   tools/perf/bench/futex-wake-parallel.c |  1 +
>   tools/perf/bench/futex-wake.c          |  1 +
>   tools/perf/bench/futex.c               |  8 +++--
>   tools/perf/bench/futex.h               |  1 +
>   12 files changed, 51 insertions(+), 11 deletions(-)
> 

nit: Does it makes sense to split this patch into futex and perf?
