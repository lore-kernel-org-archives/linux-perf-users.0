Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C318C26
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834435; cv=none; b=dc1Vcf2nQLeuchKvoq808pzewX8ZIFK5BKzVJTme67I1083r7OCyyT+k/u0VlqBGN0KCX2Xvh7u56zFQneoN7JAI4SXCZ7Tqp1H80AfloqzteVhzBy2LH+TU9WIw0ak9sPwKal33uWADkVrDtdkSzIt8abEpl7WLthmY0vjtieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834435; c=relaxed/simple;
	bh=mwBOYUT7ri+GfOuVXamt+llwaPk5sB9j5ciyMEsZaWI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hvdjw2vfbBu/5RnD06MOS83E2mMpzsZ9AycKykv60ppPwdoZBYKHgH7/7xnw/jxrKKUA8cMtMqof5MY5GJmNYYBuSATC+xoGZeMCEi9dx6ueYcCp5pz9jKQSoH0cToV8g7MJw+vfpXHoofW69AhSxHaWfXxAkKgg9AHfbHfKp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CvKvlxFw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CvKvlxFw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDClPs030847
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GqabZi
	4llbIDYioTZFSB/tVS/2BjWfaFAW/H9P6SJCk=; b=CvKvlxFwCIQXkdTMfRlwB6
	a2QIsWhEnlK0Yxvq+PWWwSd3MZQxHo35BHmk33pg+q9BoIvhQDy5/piu/oyqZ5bU
	E7xqjUc4OuhFgLphkPxKYXfk+Grpaj6YoHLPVyKoAGUjQt2Vospo+igmORK5FLpp
	OD7qlsPUUndidzw26fCz/vteOVajVqljoMs4X1O7ijKzNGoQKG83E9Y550V8O4QE
	FpJgPQwh5fTGqpYVwbr5ZnTKjES6RXiOGGzrUxIqjQLOlPdnf1G5u9AHBotSOy9g
	x9HYAqnVf14KrX7CUVLMDfrPdTTVVo23IMkRSVx9gLtdo/E/TCQd4+d/Upr59jaw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajrk6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 14:27:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59UEOKHS009027
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 14:27:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajrk6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:27:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDWNpt030759;
	Thu, 30 Oct 2025 14:27:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wws3xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:27:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UER6Xl23462454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:27:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3088020040;
	Thu, 30 Oct 2025 14:27:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D782004D;
	Thu, 30 Oct 2025 14:27:06 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 14:27:05 +0000 (GMT)
Message-ID: <02841ee0-d0b2-48a8-b523-7bcc561ad64f@linux.ibm.com>
Date: Thu, 30 Oct 2025 15:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next] perf report runtime extremely long
From: Thomas Richter <tmricht@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jan Polensky <japo@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
 <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
 <13800bed-1256-4414-ac8b-e99439c748ec@linux.ibm.com>
 <3b86c7e0-5b3e-468c-8077-7efa3959d221@linux.ibm.com>
Content-Language: en-US
Organization: IBM
In-Reply-To: <3b86c7e0-5b3e-468c-8077-7efa3959d221@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=690375bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=LLLzO7aVsSaM2W08DQoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NNDkfnuHzwfrPtujZAL9By0Yc19Ct_-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX7dw1NUwqclfD
 21uQSkVpGBKVUFnYUudCX/SunVnOamRh2+gDHm19AGAqtsdd7Rr5v/7nOeZeBuxUnlTn18yoNNv
 i0Pw0qYGouLAx4RxT/dbsSc47Af/AmtxZViKvSgq9HQErEG+C7M52PoUwZF94uIJbGFOcz0Dm1a
 z8wPgBjReIlXEu8//TLSh4L3jVb7qsVbLxeHEwHA/oaHM+UbrpVWMDtwMyV0fqMWma8L18ga5T+
 WiCv0HXUFsRvHKml0setVOzlyLkiL6j9m7D/uM+8MzUsNYFTxc2W4qWDdpo7OoSK9csN/mt84zx
 1BK+HFdODNY4ifKkQZPqcewClFQNAcSyGcl3i/uzA5+154FvT/hjHmiocM+GklRSdhk51QWCgVi
 MzkqZuxsTWmKzr843waeSJXodj1I7g==
X-Proofpoint-ORIG-GUID: Xu72WujhIZubrxMobGwKvCe4_EAy0HBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166

On 10/30/25 14:25, Thomas Richter wrote:
> On 10/30/25 09:59, Thomas Richter wrote:
>> On 10/29/25 17:47, Ian Rogers wrote:
>>> On Wed, Oct 29, 2025 at 9:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>>
>>>> On 10/29/25 09:03, Thomas Richter wrote:
>>>>> Hi all,
>>>>>
>>>>> has something changed recently in perf report in linux-next repo?
>>>>>
>>>>> I run perf report -i <file> -D | grep something
>>>>> on s390 with 2 different kernels:
>>>>>
>>>>> master 6.18.0rc3:
>>>>> # uname -a
>>>>> Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET 2025 s390x GNU/Linux
>>>>> # ll /tmp/perf2-eSso2q-2
>>>>> -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
>>>>> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
>>>>>
>>>>> real  0m22.262s
>>>>> user  0m22.068s
>>>>> sys   0m0.200s
>>>>> #
>>>>>
>>>>> This runtime is ok for the perf.data file size.
>>>>>
>>>>> linux-next:
>>>>> # uname -a
>>>>> Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
>>>>> #ll /tmp/perf2-eSso2q-2
>>>>> -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
>>>>> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
>>>>>
>>>>> real  2m53.601s
>>>>> user  2m52.938s
>>>>> sys   0m0.575s
>>>>> #
>>>>>
>>>>> Same perf.data file and run time increased from 22 seconds to nearly 300 seconds, roughly 14 times longer
>>>>> for the same input!
>>>>>
>>>>> Has anybody similar observations?
>>>>>
>>>>> Thanks a lot
>>>>>
>>>>
>>>> Ian,
>>>>
>>>> sorry sent button pushed too early...
>>>>
>>>> here is a second try without option -D.
>>>>
>>>> This is much better:
>>>>
>>>> root in 🌐 s83lp47 in ~
>>>> ❯ ll perf1.data
>>>> -rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data
>>>>
>>>> root in 🌐 s83lp47 in ~
>>>> ❯ time perf record -- perf report -i perf1.data  > /dev/null
>>>> [ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.027 MB perf.data (246 samples) ]
>>>>
>>>> real    0m1.097s
>>>> user    0m0.082s
>>>> sys     0m0.167s
>>>>
>>>> root in 🌐 s83lp47 in ~
>>>> ❯ perf report --stdio
>>>> # To display the perf.data header info, please use --header/--header-only options.
>>>> #
>>>> #
>>>> # Total Lost Samples: 0
>>>> #
>>>> # Samples: 246  of event 'cpum_cf/cycles/P'
>>>> # Event count (approx.): 307500000
>>>> #
>>>> # Overhead  Command  Shared Object        Symbol
>>>> # ........  .......  ...................  ..................................................
>>>> #
>>>>      9.35%  perf     perf                 [.] reader__read_event
>>>>      4.47%  perf     perf                 [.] perf_env__arch
>>>>      2.85%  perf     ld64.so.1            [.] _dl_relocate_object_no_relro
>>>>      2.44%  perf     ld64.so.1            [.] _dl_lookup_symbol_x
>>>>      2.44%  perf     ld64.so.1            [.] do_lookup_x
>>>>      2.44%  perf     perf                 [.] down_read
>>>>      2.03%  perf     perf                 [.] hists__findnew_entry
>>>>      2.03%  perf     perf                 [.] perf_hpp__is_dynamic_entry
>>>>      1.63%  perf     [kernel.kallsyms]    [k] __s390_indirect_jump_r14
>>>>      1.63%  perf     [kernel.kallsyms]    [k] format_decode
>>>>      1.63%  perf     libc.so.6            [.] cfree@GLIBC_2.2
>>>>      1.63%  perf     perf                 [.] evsel__parse_sample
>>>>      1.63%  perf     perf                 [.] map__put
>>>>      1.63%  perf     perf                 [.] sort__comm_cmp
>>>>      1.63%  perf     perf                 [.] thread__put
>>>>      1.22%  perf     [kernel.kallsyms]    [k] folio_add_file_rmap_ptes
>>>>      1.22%  perf     [kernel.kallsyms]    [k] get_page_from_freelist
>>>>      1.22%  perf     ld64.so.1            [.] _dl_name_match_p
>>>>      1.22%  perf     perf                 [.] dump_printf
>>>>      1.22%  perf     perf                 [.] evlist__event2evsel
>>>>      1.22%  perf     perf                 [.] hashmap_find
>>>>      1.22%  perf     perf                 [.] perf_session__deliver_event
>>>
>>> Hmm.. for perf_env__arch we could probably cache better:
>>> ```
>>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>>> index f1626d2032cd..2591f71c7c42 100644
>>> --- a/tools/perf/util/env.c
>>> +++ b/tools/perf/util/env.c
>>> @@ -593,17 +593,27 @@ static const char *normalize_arch(char *arch)
>>>
>>> const char *perf_env__arch(struct perf_env *env)
>>> {
>>> -       char *arch_name;
>>> +       if (env && env->arch && env->arch_name_normalized)
>>> +               return env->arch;
>>>
>>>        if (!env || !env->arch) { /* Assume local operation */
>>>                static struct utsname uts = { .machine[0] = '\0', };
>>>                if (uts.machine[0] == '\0' && uname(&uts) < 0)
>>>                        return NULL;
>>> -               arch_name = uts.machine;
>>> -       } else
>>> -               arch_name = env->arch;
>>>
>>> -       return normalize_arch(arch_name);
>>> +               if (!env)
>>> +                       return normalize_arch(uts.machine);
>>> +
>>> +               env->arch = strdup(normalize_arch(uts.machine));
>>> +               env->arch_name_normalized = true;
>>> +       } else {
>>> +               char *normalized = strdup(normalize_arch(env->arch));
>>> +
>>> +               free(env->arch);
>>> +               env->arch = normalized;
>>> +               env->arch_name_normalized = true;
>>> +       }
>>> +       return env->arch;
>>> }
>>>
>>> #if defined(HAVE_LIBTRACEEVENT)
>>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>>> index 9977b85523a8..da20bc3810bd 100644
>>> --- a/tools/perf/util/env.h
>>> +++ b/tools/perf/util/env.h
>>> @@ -61,6 +61,7 @@ struct perf_env {
>>>        char                    *os_release;
>>>        char                    *version;
>>>        char                    *arch;
>>> +       bool                    arch_name_normalized;
>>>        int                     nr_cpus_online;
>>>        int                     nr_cpus_avail;
>>>        char                    *cpu_desc;
>>> ```
>>> or just force the normalize before assignment.
>>>
>>> For reader__read_event and the perf_env these changes may be relevant:
>>> "perf sample: Remove arch notion of sample parsing"
>>> https://lore.kernel.org/r/20250724163302.596743-21-irogers@google.com
>>> "perf env: Remove global perf_env"
>>> https://lore.kernel.org/r/20250724163302.596743-20-irogers@google.com
>>>
>>> I wonder if for some reason the env is NULL in your cases, so we go
>>> slow path a lot.
>>>
>>> The histogram stuff, Namhyung may know more.
>>>
>>> Thanks!
>>> Ian
>>>
>>
>> Thanks Ian,
>>
>> I tested your patch, but there is no big difference:
>> root in 🌐 s83lp47 in ~ 
>> ❯ ll ~/perf.data-test
>> -rw-------. 1 root root 152280778 Oct 30 07:58 /root/perf.data-test
>>
>> here is the output with your patch:
>> root in 🌐 s83lp47 in ~ 
>> ❯ time mirror-linux-next/tools/perf/perf report -D -i ~/perf.data-test > /dev/null
>>
>> real	46m26.350s
>> user	46m17.559s
>> sys	0m7.434s
>>
>>
>> Here is the output from the linux-next perf version:
>>
>> root in 🌐 s83lp47 in ~ took 46m26s 
>> ❯ time perf report -D -i ~/perf.data-test > /dev/null
>>
>> real	49m14.364s
>> user	49m4.872s
>> sys	0m8.037s
>>
>> root in 🌐 s83lp47 in ~ took 49m14s 
>>
>> When I go back history and use:
>>
>> # pwd
>> /root/mirror-linux-next/tools/perf
>> # git branch
>> * (HEAD detached at v6.10)
>>   master
>> ]# ll ~/perf.data-test
>> -rw------- 1 root root 152280778 Oct 30 08:38 /root/perf.data-test
>> # time ./perf report -D -i ~/perf.data-test > /dev/null
>>
>> real	8m49.089s
>> user	8m47.898s
>> sys	0m0.848s
>> # 
>>
>> Thanks for the pointer. Since the issue is with s390 specific code
>> I will do a git bisect and we go from there.
>>
> 
> This is the first bad commit.... (I actually tested it :-(, obviously without -D option )
> 
> commit 0012e0fa221bf9cc54aa6a0e94d848653dc781bb (HEAD)
> Author: Ian Rogers <irogers@google.com>
> Date:   Sun Oct 5 11:24:16 2025 -0700
> 
>     perf jevents: Add legacy-hardware and legacy-cache json
>     
>     The legacy-hardware.json is added containing hardware events similarly
>     to the software.json file. A difference is that for the software PMU
>     the name is known and matches sysfs. In the legacy-hardware.json no
>     Unit/PMU is specified for the events meaning default_core is used and
>     the events will appear for all core PMUs.
>     ......
> 
> What puzzles me is that the above patch does not change anything in
> util/s390-sample-raw.c which handles s390 specific sample interpretation.
> 
> Maybe that patch affects perf_pmus__find()?
> Not sure how to proceed.
> 
> Thanks a lot

Ian,

the issue is within function perf_pmu__for_each_event().
Without calling this function the output is as fast as before.
(Well a bit faster, because I replaced this call by strdup("hardcoded-name");)

I have looked at this code, but I did not understand a thing....
Strange, perf_pmu__for_each_event() did not change in this commit,
but the behavior changed a lot.

What we need for s390 is some way of faster event name lookup,
the PMU is known, its "cpum_cf". Is there no easy way to
find the events on this PMU (given the event number).

Maybe a some sort of table, because this lookup is done
millions of times on a large file with samples including raw data

Ideas?
Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
