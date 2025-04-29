Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC513D8A3
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903542; cv=none; b=gDVhDnQHNqNM3O9JVe+KOkkn3KGlV4wPc72k9wUa92wH4i4HhBTiURxgGcm4/YrK37zAaXVTtNtCJcfJYQT/t1Bm8jtQtaeF3oROKwJ7nUrgyQ8KHomwJHDKz4ubyetU1tHWRHJL37knxGT2X00lM1fIAhuWhvzA+4vSxugG+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903542; c=relaxed/simple;
	bh=COjCAfNNB14OVUZM8FvFD/Hesv2vqslnX07ctsQOG1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc475P6AHcz2t7d+pZnTuGB0jKmIOSjsw2lycGm72FVi7ejwkdKRHCH3fqXzjimMxg1cCh4QemmD3vdCTWXO+9tZqZ5BAGRMbw18DjErQ7rkm5C/VkONlQ++95HZ5c81+ICDy5nnIVO4o3Ulz3bzt+hlKLvhD/zrcXz5pRi+yPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NUEQ7JuN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NUEQ7JuN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EOKW028151;
	Tue, 29 Apr 2025 05:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hOwTz0
	BxlJ4QAgmS44LEL0RWzQlwr32IjUrntFNmUvE=; b=NUEQ7JuNgIe1WNtYmhq8Jx
	/URxZg5hfBdjpKOrllPpH9z5LuTNE8xJCEW1axaOFPe9sM8lChf46oYxgPV7ahMn
	JG19nQ2ku9dFGn6kUYWyO/WSWCWKykC/X5914AsySTH9PK1BMzvolhv6Wt4x2DPn
	NdGAuqg5NrKq4u6h0WQp8eYx1Q9nhGguSvRyzgchlQEhQ4LXqWVoSCmt01/3iut/
	PYzolTOFBJlQyLNrKQsPTHt8nl951BI5ye/USajTNyrXJei7RmiRVC6+PgX9QLcS
	7H/Swr8cAhps11UEYmLb2nI5xWoXFapeDzOM3zaq11/Q7bRc3LY4m5yesbpd3jMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8m9djk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 05:12:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53T56DLw001662;
	Tue, 29 Apr 2025 05:12:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8m9djf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 05:12:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T1BQ4s024679;
	Tue, 29 Apr 2025 05:12:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m1gtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 05:12:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T5BxAJ34013798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 05:11:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298BC20040;
	Tue, 29 Apr 2025 05:11:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E8720043;
	Tue, 29 Apr 2025 05:11:57 +0000 (GMT)
Received: from [9.199.192.254] (unknown [9.199.192.254])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 05:11:57 +0000 (GMT)
Message-ID: <780bee9f-081d-4d40-b82d-8fd6727f9433@linux.ibm.com>
Date: Tue, 29 Apr 2025 10:41:56 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in
 cpumap.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20250406163412.897313-1-likhitha@linux.ibm.com>
 <E58C5DCA-5F52-4B61-A816-DE932BA40FDA@linux.ibm.com>
 <baad9d65-07b1-4a19-aea6-5ba5d60da98e@linux.ibm.com>
 <1b1450a8-f091-4091-981d-76b27f61be24@linux.ibm.com>
 <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com> <aAvKg8K2fyrZ6zy4@x1>
Content-Language: en-US
From: Likhitha Korrapati <likhitha@linux.ibm.com>
In-Reply-To: <aAvKg8K2fyrZ6zy4@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AZWN7fMJg5JATrtyL13CAj3liSirK_K-
X-Proofpoint-GUID: gvTb79_l8ijvR9FbLk3gxylnZM4snZEQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzNyBTYWx0ZWRfX/ivTIJqqZHM/ JcVJBRCTp+DO362b2sZEWxEx4Bi86FLIzElUy/d2yOOvWQwJoTvyragcuVjoBqa+iLdBTwdJepa 1IMju1S7Xcn8Ycu63vAWQ8akwunYoGNBzkKIpKeNT6/6WN+SMmDpG0aBnvZv/qjjWCi6W/KetHT
 oYm6GW84xj9F5IAd8ZvSTxV/vcXvLcF0O8ZZnEo+gqtQ09rHmJMHtsuhXttpXSsLitxoDXcD/cI XrdqEG0+cTYQVRCr+exyGgwWbrZdx2g2EN+euCWENZBhqzzU9zPjQBuD7utEZlrdObxFwLfI0Nm DfyM/sA27dYyw7rQRw08/1c1TmaCbfzbNeeWlVjV8Sqld60WjHxZON+hnSXLlnCrLTV+obQRwMH
 XE3cJn+FhQnWPCec8WFRa7tdnUIycu1JB95LkZR1VTay18MUzQf5cEqYyeaScsUMQRHcQtlZ
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=68105fa4 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=8XcPMh4SkUfmyqR2tSwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290037

Hi Arnaldo,

On 4/25/25 23:16, Arnaldo Carvalho de Melo wrote:
> On Fri, Apr 25, 2025 at 08:19:02PM +0530, Athira Rajeev wrote:
>>> On 14 Apr 2025, at 7:08 AM, Madhavan Srinivasan <maddy@linux.ibm.com> wrote:
>>> On 4/7/25 5:38 PM, Venkat Rao Bagalkote wrote:
>>>> On 07/04/25 12:10 am, Athira Rajeev wrote:
>>>>>> On 6 Apr 2025, at 10:04 PM, Likhitha Korrapati <likhitha@linux.ibm.com> wrote:
> 
>>>>>> perf build break observed when using gcc 13-3 (FC39 ppc64le)
>>>>>> with the following error.
> 
>>>>>> cpumap.c: In function 'perf_cpu_map__merge':
>>>>>> cpumap.c:414:20: error: argument 1 range [18446744069414584320, 18446744073709551614] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
>>>>>>    414 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
>>>>>>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>> In file included from cpumap.c:4:
>>>>>> /usr/include/stdlib.h:672:14: note: in a call to allocation function 'malloc' declared here
>>>>>>    672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
>>>>>>        |              ^~~~~~
>>>>>> cc1: all warnings being treated as errors
> 
>>>>>> Error happens to be only in gcc13-3 and not in latest gcc 14.
>>>>>> Even though git-bisect pointed bad commit as:
>>>>>> 'commit f5b07010c13c ("libperf: Don't remove -g when EXTRA_CFLAGS are used")',
>>>>>> issue is with tmp_len being "int". It holds number of cpus and making
>>>>>> it "unsigned int" fixes the issues.
> 
>>>>>> After the fix:
> 
>>>>>>    CC      util/pmu-flex.o
>>>>>>    CC      util/expr-flex.o
>>>>>>    LD      util/perf-util-in.o
>>>>>>    LD      perf-util-in.o
>>>>>>    AR      libperf-util.a
>>>>>>    LINK    perf
>>>>>>    GEN     python/perf.cpython-312-powerpc64le-linux-gnu.so
> 
>>>>>> Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
>>>>> Looks good to me
> 
>>>>> Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>
> 
>>>> Tested this patch on perf-tools-next repo, and this patch fixes the issue.
> 
>>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
>>> Arnaldo, Namhyung,
> 
>>> can you consider pulling this fix? since it is breaking the build in gcc13-3 or
>>> if you have any comments do let us know.
> 
> This isn't the only place in that file where this pattern exists:
> 
> ⬢ [acme@toolbx perf-tools-next]$ grep malloc tools/lib/perf/cpumap.c
> 	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
> 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> ⬢ [acme@toolbx perf-tools-next]$
> 
> 
> struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
> {
>          RC_STRUCT(perf_cpu_map) *cpus;
>          struct perf_cpu_map *result;
> 
>          if (nr_cpus == 0)
>                  return NULL;
> 
>          cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
> 
> 
> int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
> {
>          struct perf_cpu *tmp_cpus;
>          int tmp_len;
>          int i, j, k;
>          struct perf_cpu_map *merged;
> 
>          if (perf_cpu_map__is_subset(*orig, other))
>                  return 0;
>          if (perf_cpu_map__is_subset(other, *orig)) {
>                  perf_cpu_map__put(*orig);
>                  *orig = perf_cpu_map__get(other);
>                  return 0;
>          }
> 
>          tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
>          tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> 
> 
> struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
>                                               struct perf_cpu_map *other)
> {
>          struct perf_cpu *tmp_cpus;
>          int tmp_len;
>          int i, j, k;
>          struct perf_cpu_map *merged = NULL;
> 
>          if (perf_cpu_map__is_subset(other, orig))
>                  return perf_cpu_map__get(orig);
>          if (perf_cpu_map__is_subset(orig, other))
>                  return perf_cpu_map__get(other);
> 
>          tmp_len = max(__perf_cpu_map__nr(orig), __perf_cpu_map__nr(other));
>          tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> 
> I'm trying to figure out why its only in perf_cpu_map__merge() that this
> triggers :-\
> 
> Maybe that max() call in perf_cpu_map__intersect() somehow makes the
> compiler happy.
> 
> And in perf_cpu_map__alloc() all calls seems to validate it.
> 
> But wouldn't turning this into a calloc() be better?

I have tried using calloc() instead of malloc() and the issue still 
exists even using calloc().

cpumap.c: In function ‘perf_cpu_map__merge’:
cpumap.c:414:20: error: argument 1 range [18446744071562067968, 
18446744073709551615] exceeds maximum object size 9223372036854775807 
[-Werror=alloc-size-larger-than=]

   414 |         tmp_cpus = calloc(tmp_len , sizeof(struct perf_cpu));

> 
> Like:
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 4454a5987570cfbc..99d21618a252ac0e 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
>          }
>   
>          tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
> -       tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> +       tmp_cpus = calloc(tmp_len, sizeof(struct perf_cpu));
>          if (!tmp_cpus)
>                  return -ENOMEM;
>   
> ⬢ [acme@toolbx perf-tools-next]$
> 
> 
> And better, do the max size that the compiler is trying to help us
> catch?
> 
> - Arnaldo
I have tried using max and it worked. I am doing testing with this 
change and will be posting a V2.

Thanks
Likhitha
