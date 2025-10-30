Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D3299954
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814806; cv=none; b=Bvtjkw2r817fduN9zZBIGa0T23AXH743tGCcnz8004GomatOAtNH1Lp3wV6IBkCNJdqyN536oc17GTCp0aPfRFbGkuDHRzIfTaxBLNybKe8gJMfja8xTZM6OevAdZat7VgIuijjvgy+uw26N//EaYCx3r3c1VdBJCax+m01Kh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814806; c=relaxed/simple;
	bh=ezB6PActscjDJBuQMafuG+VAicCY/Fl1uv/ZzLBMGz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJZxLz8YIPmmYFyjIOmwfZ3o4ZzMYez81cY4+5Igp2+mM1d5Vyg9fubxlgfqzm/k1MPqIcUgynBYIwTRkWXAVgIf70aap5Nw77C7caWijUxJA7xdGpxgZu1/T7v8RyTYRL6Zn2LEgJ+3OJdYepyaMSBklw7v4fSrt3QSR5BdNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4wqcKGC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4wqcKGC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TM7tK8025790
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 09:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TnKY7b
	6o3nIn+fRRnncSbJztn6RL+kcnllR+ealeiL8=; b=A4wqcKGCDzZucZ4ItTb7v1
	/UrB1pWOwEsS2xP9LleXGKLY1C8mR8n2JOpzOSRfIhHMay7SwBO8/h0FkXOLsdkL
	vRTOgOisvmaTPyNSUUHfLMs1FzE1x9Ixl4xCBnga/DNvuSiNFS33k/wdpULxHybD
	JeQQHVJuh0yWfWsECaiEo+MzMXB2jBa6puWHjUv4XKqtKppVWofFXnkg12OXV01P
	OwHSkMHyD1oArCWEqTVXq/TyzmzDB+xKmH7Awlhee16FeYniy/WcXc31Jhl+3u6n
	kxJomNd+UgtQRyRuO0jpkBfuX4v/M/jWmTbIbHOMEk1A/c8FTb4bbqoUrgYfmAMA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acqedx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 09:00:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U8OVtY024178
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 09:00:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acqedq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 09:00:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5p5cJ019555;
	Thu, 30 Oct 2025 09:00:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy7s45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 09:00:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59U8xxgG38207884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:59:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 216462004B;
	Thu, 30 Oct 2025 08:59:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F2220043;
	Thu, 30 Oct 2025 08:59:58 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 08:59:58 +0000 (GMT)
Message-ID: <13800bed-1256-4414-ac8b-e99439c748ec@linux.ibm.com>
Date: Thu, 30 Oct 2025 09:59:58 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next] perf report runtime extremely long
To: Ian Rogers <irogers@google.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jan Polensky <japo@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
 <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69032914 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=9gRBA4dVDdxGy74xXHcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gmG6Els9GNDaoQi0Y42fXTnSpPE038Wi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX9c3pv4JBvfkY
 c5stc+xrvTq6SexJTp08iaOJnknquiqcwJFR5oiTFpWaiEu+nLNtL1C44Et3i0i6RYav3mqbLFW
 P71zWE90gkahDbj2ZL+z2kYtM1eBvE+FZvhIXdUhid8J9i5efEnxkxBi0cM/JBvlJ0gNmVwxivs
 8G8r0Oi5g1qLzzsichzJq2x7YUpkYHvnLjN+npBY8ZMrEaKKg269tDgsjc4qxAYDHAs47Cd3dFK
 SVVeh2+9TwJfNZPMEGjFn00mwqueBhy+2tFjQeO0euUn83a1Ko7ciwFR1GRMBz2jzlT5YszaMEP
 FCVOY+3DZMw24Tw6Hp28tA1clxbbIcEftK/urxDXk2V8IRdq8DpuoBZcfPmQzV6Dkbb8Qw03pcQ
 yATQCy0RPEooY3ZH40PZQiBbqtaIwA==
X-Proofpoint-GUID: bROJ0WJXYURDQsx_K6nNnwPL_PjJfwo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On 10/29/25 17:47, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 9:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 10/29/25 09:03, Thomas Richter wrote:
>>> Hi all,
>>>
>>> has something changed recently in perf report in linux-next repo?
>>>
>>> I run perf report -i <file> -D | grep something
>>> on s390 with 2 different kernels:
>>>
>>> master 6.18.0rc3:
>>> # uname -a
>>> Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET 2025 s390x GNU/Linux
>>> # ll /tmp/perf2-eSso2q-2
>>> -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
>>> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
>>>
>>> real  0m22.262s
>>> user  0m22.068s
>>> sys   0m0.200s
>>> #
>>>
>>> This runtime is ok for the perf.data file size.
>>>
>>> linux-next:
>>> # uname -a
>>> Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
>>> #ll /tmp/perf2-eSso2q-2
>>> -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
>>> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
>>>
>>> real  2m53.601s
>>> user  2m52.938s
>>> sys   0m0.575s
>>> #
>>>
>>> Same perf.data file and run time increased from 22 seconds to nearly 300 seconds, roughly 14 times longer
>>> for the same input!
>>>
>>> Has anybody similar observations?
>>>
>>> Thanks a lot
>>>
>>
>> Ian,
>>
>> sorry sent button pushed too early...
>>
>> here is a second try without option -D.
>>
>> This is much better:
>>
>> root in 🌐 s83lp47 in ~
>> ❯ ll perf1.data
>> -rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data
>>
>> root in 🌐 s83lp47 in ~
>> ❯ time perf record -- perf report -i perf1.data  > /dev/null
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.027 MB perf.data (246 samples) ]
>>
>> real    0m1.097s
>> user    0m0.082s
>> sys     0m0.167s
>>
>> root in 🌐 s83lp47 in ~
>> ❯ perf report --stdio
>> # To display the perf.data header info, please use --header/--header-only options.
>> #
>> #
>> # Total Lost Samples: 0
>> #
>> # Samples: 246  of event 'cpum_cf/cycles/P'
>> # Event count (approx.): 307500000
>> #
>> # Overhead  Command  Shared Object        Symbol
>> # ........  .......  ...................  ..................................................
>> #
>>      9.35%  perf     perf                 [.] reader__read_event
>>      4.47%  perf     perf                 [.] perf_env__arch
>>      2.85%  perf     ld64.so.1            [.] _dl_relocate_object_no_relro
>>      2.44%  perf     ld64.so.1            [.] _dl_lookup_symbol_x
>>      2.44%  perf     ld64.so.1            [.] do_lookup_x
>>      2.44%  perf     perf                 [.] down_read
>>      2.03%  perf     perf                 [.] hists__findnew_entry
>>      2.03%  perf     perf                 [.] perf_hpp__is_dynamic_entry
>>      1.63%  perf     [kernel.kallsyms]    [k] __s390_indirect_jump_r14
>>      1.63%  perf     [kernel.kallsyms]    [k] format_decode
>>      1.63%  perf     libc.so.6            [.] cfree@GLIBC_2.2
>>      1.63%  perf     perf                 [.] evsel__parse_sample
>>      1.63%  perf     perf                 [.] map__put
>>      1.63%  perf     perf                 [.] sort__comm_cmp
>>      1.63%  perf     perf                 [.] thread__put
>>      1.22%  perf     [kernel.kallsyms]    [k] folio_add_file_rmap_ptes
>>      1.22%  perf     [kernel.kallsyms]    [k] get_page_from_freelist
>>      1.22%  perf     ld64.so.1            [.] _dl_name_match_p
>>      1.22%  perf     perf                 [.] dump_printf
>>      1.22%  perf     perf                 [.] evlist__event2evsel
>>      1.22%  perf     perf                 [.] hashmap_find
>>      1.22%  perf     perf                 [.] perf_session__deliver_event
> 
> Hmm.. for perf_env__arch we could probably cache better:
> ```
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index f1626d2032cd..2591f71c7c42 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -593,17 +593,27 @@ static const char *normalize_arch(char *arch)
> 
> const char *perf_env__arch(struct perf_env *env)
> {
> -       char *arch_name;
> +       if (env && env->arch && env->arch_name_normalized)
> +               return env->arch;
> 
>        if (!env || !env->arch) { /* Assume local operation */
>                static struct utsname uts = { .machine[0] = '\0', };
>                if (uts.machine[0] == '\0' && uname(&uts) < 0)
>                        return NULL;
> -               arch_name = uts.machine;
> -       } else
> -               arch_name = env->arch;
> 
> -       return normalize_arch(arch_name);
> +               if (!env)
> +                       return normalize_arch(uts.machine);
> +
> +               env->arch = strdup(normalize_arch(uts.machine));
> +               env->arch_name_normalized = true;
> +       } else {
> +               char *normalized = strdup(normalize_arch(env->arch));
> +
> +               free(env->arch);
> +               env->arch = normalized;
> +               env->arch_name_normalized = true;
> +       }
> +       return env->arch;
> }
> 
> #if defined(HAVE_LIBTRACEEVENT)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 9977b85523a8..da20bc3810bd 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -61,6 +61,7 @@ struct perf_env {
>        char                    *os_release;
>        char                    *version;
>        char                    *arch;
> +       bool                    arch_name_normalized;
>        int                     nr_cpus_online;
>        int                     nr_cpus_avail;
>        char                    *cpu_desc;
> ```
> or just force the normalize before assignment.
> 
> For reader__read_event and the perf_env these changes may be relevant:
> "perf sample: Remove arch notion of sample parsing"
> https://lore.kernel.org/r/20250724163302.596743-21-irogers@google.com
> "perf env: Remove global perf_env"
> https://lore.kernel.org/r/20250724163302.596743-20-irogers@google.com
> 
> I wonder if for some reason the env is NULL in your cases, so we go
> slow path a lot.
> 
> The histogram stuff, Namhyung may know more.
> 
> Thanks!
> Ian
> 

Thanks Ian,

I tested your patch, but there is no big difference:
root in 🌐 s83lp47 in ~ 
❯ ll ~/perf.data-test
-rw-------. 1 root root 152280778 Oct 30 07:58 /root/perf.data-test

here is the output with your patch:
root in 🌐 s83lp47 in ~ 
❯ time mirror-linux-next/tools/perf/perf report -D -i ~/perf.data-test > /dev/null

real	46m26.350s
user	46m17.559s
sys	0m7.434s


Here is the output from the linux-next perf version:

root in 🌐 s83lp47 in ~ took 46m26s 
❯ time perf report -D -i ~/perf.data-test > /dev/null

real	49m14.364s
user	49m4.872s
sys	0m8.037s

root in 🌐 s83lp47 in ~ took 49m14s 

When I go back history and use:

# pwd
/root/mirror-linux-next/tools/perf
# git branch
* (HEAD detached at v6.10)
  master
]# ll ~/perf.data-test
-rw------- 1 root root 152280778 Oct 30 08:38 /root/perf.data-test
# time ./perf report -D -i ~/perf.data-test > /dev/null

real	8m49.089s
user	8m47.898s
sys	0m0.848s
# 

Thanks for the pointer. Since the issue is with s390 specific code
I will do a git bisect and we go from there.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
