Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7229BDB0
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898841; cv=none; b=nJUhaCK+uBo5frT5YnufURM3SdbW19jkDG38O2CvgAzpwgH6yiu7DZKisv5FEMEEK1hmr09j0aB7rwYcIgmQOVfKrF2SOhdh4pMByOthZdc99QjR+IWKHkHI1u5rz/CNPb+0fmluAamooDW0Nb8j/I1PFzkcIonRSbz8czbM9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898841; c=relaxed/simple;
	bh=7xgc0Q67nRMBchJFwMzOMtdA/9AEOAwHr7uY/iVRglI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbQIxIqfz7Ll4OrtRZbKPBm8uSfTOCFkrOSxNbIMOg9AS9G6Wu3rNW61HSX7GC7GZ1h8jkt4VE4BPa1guvmvSHmjiWmbxusTnaALOcSOOAm8jnvrAYSpEbOanAldBmMFa2NkpGExTRe9O4lEJdFNff+NPatKRk8DglK9zJsVI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A56TB1uQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A56TB1uQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ULHtqK026059
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 08:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RVuDYh
	/LA5VR32s5abBCQNuBZJWmNMMJXKKVpqO5PJg=; b=A56TB1uQCL0TbPCFNZqqI5
	u0/JyeVcngoIdVZ9OAJFX1C79lkXrvprru7IN/PHTzb9NMZ8fODXvMtcBzXeexV2
	3gEbfi8c+UK9RF50Z5AUlosSXMjjeBVuBRxGs9zQJ8bHTKpsoyueYfOSYfSPCCG3
	KqC2afR8domV4mzhxT5Z/YIzCadyzjzZd/i8OT/2j4Dc7VQ+1VQbfIL0VOuM8ZmU
	UvTGM3iEZc14HBUkL3UMkm5tGcx++w0xlxEwOwrxy19fEe+QJQ0Smcekjy73Afwg
	xHV/yrWGDSnU4tPon0Pv6gf0j3YHCKDT83aRMW88uuD1vIsoQdt5W3/sA1yLZCpg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aavka6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 08:20:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59V7rAbJ029435
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 08:20:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aavka5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 08:20:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59V41J86019567;
	Fri, 31 Oct 2025 08:20:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xyd8rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 08:20:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59V8KXE042533134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 08:20:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6F122004E;
	Fri, 31 Oct 2025 08:20:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB532004B;
	Fri, 31 Oct 2025 08:20:33 +0000 (GMT)
Received: from [9.87.152.126] (unknown [9.87.152.126])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Oct 2025 08:20:33 +0000 (GMT)
Message-ID: <0d4b605b-64ab-48a0-bd95-8465dabbbae3@linux.ibm.com>
Date: Fri, 31 Oct 2025 09:20:33 +0100
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
 <13800bed-1256-4414-ac8b-e99439c748ec@linux.ibm.com>
 <3b86c7e0-5b3e-468c-8077-7efa3959d221@linux.ibm.com>
 <02841ee0-d0b2-48a8-b523-7bcc561ad64f@linux.ibm.com>
 <CAP-5=fUKaX0b5b3QYarL9qUK4Z=u0zpKnB9XVm-_bOKap7sJag@mail.gmail.com>
 <CAP-5=fVLSML-B111RDGcKAE=ZrF1sZ6oGt_z=GQeePQLcZs-KA@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fVLSML-B111RDGcKAE=ZrF1sZ6oGt_z=GQeePQLcZs-KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=69047156 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=QxwrVYeC9J_nEmSfvY4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rXgI5Pwo0WopAlcRvTHwQ2HGzT3z52pf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXwX96IPGdB8OU
 8WlkdM5h0B3hd2SJLN8uu50Z1J4F/VX9x32n63aIW5QgKUYZo1NTCkX5UAWHzY1JWbBk/SXpegU
 l+6e4ZDASmaOPBc+1zuhAOmeOHjkBbKOFkbn+O/CUdQTYFJtx5KIsI/RrtqtzSC1G/Vf3TpS61e
 DIvVB7rR6n726uN06XIT9cickUndQz2r4/6Blgtkk0hkZbS10vq7H9FJf+F/zsATv0DbKmgEbP6
 9goE9Sir7E8RtXdoRd366UMLUbWyL6mNnmbsSSZClOwklS5h+THTC3iv9UqIr9j/H72QdzOw3dM
 WMDLyTz3JIGUb4deAJfAcNdodkSWxb0aXVk6ZU2v42dzxhXJvngoMbEXJMRDmHkkLwT/nM9+wVM
 m/FO0zhbDX2TK1sKpj3eaqB3nSY2Lw==
X-Proofpoint-GUID: 94W5W_Y53gW15i8i-SpdjSy88H5JYA41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On 10/30/25 18:14, Ian Rogers wrote:
> On Thu, Oct 30, 2025 at 8:57 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Oct 30, 2025 at 7:27 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> On 10/30/25 14:25, Thomas Richter wrote:
>>>> On 10/30/25 09:59, Thomas Richter wrote:
>>>> This is the first bad commit.... (I actually tested it :-(, obviously without -D option )
>>>>
>>>> commit 0012e0fa221bf9cc54aa6a0e94d848653dc781bb (HEAD)
>>>> Author: Ian Rogers <irogers@google.com>
>>>> Date:   Sun Oct 5 11:24:16 2025 -0700
>>>>
>>>>     perf jevents: Add legacy-hardware and legacy-cache json
>>>>
>>>>     The legacy-hardware.json is added containing hardware events similarly
>>>>     to the software.json file. A difference is that for the software PMU
>>>>     the name is known and matches sysfs. In the legacy-hardware.json no
>>>>     Unit/PMU is specified for the events meaning default_core is used and
>>>>     the events will appear for all core PMUs.
>>>>     ......
>>>>
>>>> What puzzles me is that the above patch does not change anything in
>>>> util/s390-sample-raw.c which handles s390 specific sample interpretation.
>>>>
>>>> Maybe that patch affects perf_pmus__find()?
>>>> Not sure how to proceed.
>>>>
>>>> Thanks a lot
>>>
>>> Ian,
>>>
>>> the issue is within function perf_pmu__for_each_event().
>>> Without calling this function the output is as fast as before.
>>> (Well a bit faster, because I replaced this call by strdup("hardcoded-name");)
>>>
>>> I have looked at this code, but I did not understand a thing....
>>> Strange, perf_pmu__for_each_event() did not change in this commit,
>>> but the behavior changed a lot.
>>>
>>> What we need for s390 is some way of faster event name lookup,
>>> the PMU is known, its "cpum_cf". Is there no easy way to
>>> find the events on this PMU (given the event number).
>>>
>>> Maybe a some sort of table, because this lookup is done
>>> millions of times on a large file with samples including raw data
>>>
>>> Ideas?
>>
>> Thanks Thomas!
>>
>> The bisect and the behavior make sense now. Previously the legacy
>> events weren't part of perf_pmu__for_each_event and now with the
>> legacy-hardware.json they are. The events were parsed by matching
>> explicitly in the parse-events.l lex parser, but for lots of reasons
>> the json is better. Anyway, there is common functionality for
>> reversing a perf_event_attr.config to an event name in
>> perf_pmu__name_from_config:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.h?h=perf-tools-next#n306
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n2728
>>
>> The normal case for a PMU is that we want to see if it has an event by
>> name, so we have a hashmap from name to the "alias" information (I
>> don't really like the name "alias", it is information about an event
>> we want to encode):
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n58
>>
>> The use-case for perf_pmu__name_from_config is generally debug output,
>> so there isn't a fast path config to name lookup. Is config to name
>> lookup sufficient in s390-sample-raw.c? I notice that the code is
>> matching the "event=" part of the encoding, which is a sub-part of the
>> config (and may actually be a value in config2 or config3).
>>
>> I wonder if it would be easier to add a cache of matched names in
>> s390-sample-raw.c? So a global/static hashmap in that C file with a
>> key of set and nr as per get_counter_name (it seems the PMU can be
>> implied to always only be the core PMU) and a value of a strdup-ed
>> counter name.
>>
>> Let me know what you think and I can send you a patch if you like.
> 
> So:
> https://lore.kernel.org/lkml/20251030171211.1109480-1-irogers@google.com/
> should cover it. Let me know what you think.
> 
> Thanks,
> Ian

Great work, I downloaded and tested your patch

# time perf report -D -i ~/perf.data-test > /dev/null

real	9m16.125s
user	9m14.838s
sys	0m0.912s
[root@b83lp65 perf]# ll ~/perf.data-test
-rw------- 1 root root 152280778 Oct 30 08:38 /root/perf.data-390raw
# 

This is back to what is was before. Much better than the ~50 minutes.
If there is need for further improvement, we can go for an array solution.

Please submit this patch to the mailing list.

Thank you very much for your help.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
