Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96318A6C1;
	Tue,  4 Mar 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073866; cv=none; b=QAcXQaJp/5DnM196R6EHuNHdDJS4ahxOXt9hYT6o5T9lykteIjOeIyb0GvmxFM2CHs/QDRKKmv23M/McGEg63rIlEOql/w5wNtfWC3z67BtTv275tbNlZarlbgWCFEwMDyKO58RrEVTrs+vj/sZF07QDHKI8FriBxxikhY0o4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073866; c=relaxed/simple;
	bh=3xnnjsN3RwkAoWlOZBqmc+H1qQ7bpZqY+qEGGCT/1Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4Q8Lpcqv/1bVDLKpwvAkndKoGLH+QhC8dtBW3prg1hJdZ/UNu5z9OwKwXf71aafGL+cR17H+4RA+XuTp9NTQBRmfhznPF2tbQLgG8DKaaho078yg5y+yuL4GFAu45JY7QXRAPkYW5bXbs/B2CYnn7jrWo50VchLjY+TwsudSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WFcZaR1c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFcZaR1c"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523LSusE022851;
	Tue, 4 Mar 2025 07:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v6Z/qv
	q1ZKr7naDgrSX8x1r6TilBTSoJvZa+2P+2cmg=; b=WFcZaR1clkMkKM0C9GVEgw
	MYjR0bKgyTxKP14QszNVywpQCyIQgWLo9pSpdGS9JMGXZzLb2kX/YYvFMb57DBfr
	PBXpRcKPiFJqQGjQkeYGCVhi4w7NdD7R4++cYpRW1paN3lk9kHcS3e446c8Wr1Mc
	AU1y/S/GX71Swv5BnwmNKxO1/tEMVJG//TRmxCUa4mRGXnjC3Aj9DKOkpDc+sJEK
	IT7uCFfn4ejkkrYlqW1teZnCmV+Lf+tRAOQQe0Ysth7tt2PZFxYhw3EGH6hqY5gr
	NveLHaH/B49KOZtMWe/SrXxmCsuwkjYG98LOJoWB81vPbWR3SziqEhQAoYyHqZGw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunw6m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:37:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5247Ppiq002664;
	Tue, 4 Mar 2025 07:37:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunw6m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:37:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52452sns020788;
	Tue, 4 Mar 2025 07:37:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjuwy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:37:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5247bUk454657420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 07:37:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAFE220043;
	Tue,  4 Mar 2025 07:37:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA6920040;
	Tue,  4 Mar 2025 07:37:30 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 07:37:30 +0000 (GMT)
Message-ID: <62f8f2a2-dcd2-4c6a-882f-dfa50482ffb0@linux.ibm.com>
Date: Tue, 4 Mar 2025 08:37:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] perf test: Add timeout to datasym workload
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@arm.com>
References: <20250304022837.1877845-1-namhyung@kernel.org>
 <20250304022837.1877845-6-namhyung@kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250304022837.1877845-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LKvehMKg1Qxr3006ungbJ61q5Sz6L5--
X-Proofpoint-GUID: nATtTWXGvTZ8I25GgvS1qItZMkqm02jP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040062

On 3/4/25 03:28, Namhyung Kim wrote:
> Unlike others it has an infinite loop that make it annoying to call.
> Make it finish after 1 second and handle command-line argument to change
> the setting.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/workloads/datasym.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
> index 8e08fc75a973e5f7..8ddb2aa6a049e343 100644
> --- a/tools/perf/tests/workloads/datasym.c
> +++ b/tools/perf/tests/workloads/datasym.c
> @@ -1,3 +1,6 @@
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include <linux/compiler.h>
>  #include "../tests.h"
>  
> @@ -12,9 +15,25 @@ static buf buf1 = {
>  	.reserved[0] = 1,
>  };
>  
> -static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
> +
> +static int datasym(int argc, const char **argv)
>  {
> -	for (;;) {
> +	int sec = 1;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	while (!done) {
>  		buf1.data1++;
>  		if (buf1.data1 == 123) {
>  			/*

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
