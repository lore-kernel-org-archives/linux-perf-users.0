Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3513346AD
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208376; cv=none; b=YELmld176sy37k0cvchYlHSSwppVgZMGjFb3v5IiFQ/zI3kK2vlOiH34fNvg1aTEuM1xktXUD9VeRsVot5cLRnzfaWla97z0AOrIhu7uxLlrhsdfYzzV+vZf8CAZtwhf+bwX+phys4dyveoj/JAkRTMzVf0sEjmYIPChQIJFWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208376; c=relaxed/simple;
	bh=s//qbL6pcZnGdaqAj/w9gmfCLXiv0YePBWP+1dgU/8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPcThg9icWPBEHbleA9jIiigH93OSQhPRDF8nt9YbdAFSKD1b0UJ5E6DPs/EYawBkrTm8Si1UociYr1P8AlSpeDNVO+3X1P7XOMLnB+yWRx173RIHYYVjRIe/V6t47E8dLeDARgMn+P8BJKHceB3rRamNuMiFWWwfMACvbI8shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GIDSIESH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GIDSIESH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B0itU71679369
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 05:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1YXLpu
	JI1roaLts0NSNlluZqS+rg9LmivTF/LuFmy3c=; b=GIDSIESHpJingsu5jKuOOx
	yRlOvoJQH8cesoCydBQGnKTMM686opsSxusNmA6WH7sqSO0/Yxn1wWFiOqiFCwWQ
	YB2HTP0UPgi2iAFDqNff8fBODvh+PhCPn/qAsmGv9VVZlWWgi3gFUsPbIkbPnXmj
	zfyJfZZWzIMaKd6lJYoXL4Vyoeelp1avbJbX2i2jh+HT/yiMRlFfGd6aKL/HxmbH
	DFpmo4ZT9kL4MIqid6wv5oZ5PZwz2vL9Vm3voLvsstza/FsY9RBuVzVv2DHbL9Bp
	J7LqkxT44xqk08sBAgrfPs11Pfrr/hp88WS9k3vVWmCKyJStqH5B8tRV25qPC64Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcundx65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 05:52:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B5lFsO021172;
	Wed, 11 Mar 2026 05:52:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsvawn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 05:52:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B5qnJ755968002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 05:52:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB302004D;
	Wed, 11 Mar 2026 05:52:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAC302004B;
	Wed, 11 Mar 2026 05:52:48 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 05:52:48 +0000 (GMT)
Message-ID: <898793c5-af93-4449-9780-74908c805907@linux.ibm.com>
Date: Wed, 11 Mar 2026 06:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test case '105: perf stat tests' fails for s390.
To: Ian Rogers <irogers@google.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <61a60089-c0a1-47d8-91c7-c1fe68d19f5e@linux.ibm.com>
 <CAP-5=fUOizFadGmSnLLPv2m+-a0sR4eg8kqBAMeE5k0wpvQ8ag@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fUOizFadGmSnLLPv2m+-a0sR4eg8kqBAMeE5k0wpvQ8ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3AKjp0lr462sfqm5vRZ_CcMA0oGs0_ji
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b10335 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Uxye4tGc_qb5VhK48DoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0NSBTYWx0ZWRfX21VDRVIou+eU
 /yjiTMkuIB9LNlIcV3uN7oqrPEPklnC1vhviOBVqAZfyykJ0kq2xHgSPTpAI+1LsFX2R0Qk8FZG
 p9qk7592eyoiXulM6WowhSx0jXgRPS1KIRcTTB8ZPPyJ6Oz83QdcyU6IglPWi0pwIeOgBZR4uVS
 s4UFVYMOPY0VsdP8ZCJ3x3Y1wE3JXWS3yt58YmP1idDPjpc9WSCI6eYzbqdYzBw4vHUFKC9tkv6
 I6KMBRfXNlDfhUdS96+C7LjBweDt2T1ohjwzxonzDRPU04HjReoTBAiDgLXzFQJMRp8UkqgtB06
 ikDznQ7wOHttA+TyvZHWHRJBKKcTgoiUDKCobo/Sb+kITtsLNutFJ3al0YNnGQB9bPXVRVhhfC4
 V/JmwmyMeetO6d2+wzoZy8dh/a20wOHx1nC33HTyXP6TInOvNPo8wNw3JD/2CkMu6bG7ODqmW/8
 OF9HWgwMAbFrvEDEO5Q==
X-Proofpoint-ORIG-GUID: YIrIV6TNDkoZfKXuQV2OlCrMmjFMWcBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110045

On 3/9/26 19:23, Ian Rogers wrote:
> On Mon, Mar 9, 2026 at 6:04 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> Ian,
>>
>> test case '105: perf stat tests' fails for s390 (linux 7.0.0rc2) . It boils down to this command
>>  # ./perf stat -C 0-31 -a true
>>  Error:
>>  No supported events found.
>>
>> The first bad commit is this one:
>> commit cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID table exists")
>>
>> Before this commit the output of above command is:
>> Output before that commit:
>> ./perf stat -C 0-31 -a true
>>
>>  Performance counter stats for 'system wide':
>>
>>        105      context-switches   #   3579.8 cs/sec  cs_per_second
>>      29.33 msec cpu-clock          #      7.8 CPUs  CPUs_utilized
>>         34      cpu-migrations     #   1159.2 migrations/sec  migrations_per_second
>>         52      page-faults        #   1772.9 faults/sec  page_faults_per_second
>>  5,026,832      cpu-cycles         #      0.2 GHz  cycles_frequency
>>  3,029,266      instructions       #      0.6 instructions  insn_per_cycle
>>
>> 0.000851608 seconds time elapsed
>>
>> Since this is executed on an s390 LPAR, hardware event CPU_CYCLES is available, so it
>> should be used. This is something I will look into.
>>
>> Also some other test cases fail after the bad commit:
>>  ./perf test 2>&1 | grep  FAILED
>>  99: perf stat CSV output linter                                     : FAILED!
>> 102: perf stat JSON output linter                                    : FAILED!
>> 104: perf stat STD output linter                                     : FAILED!
>> 105: perf stat tests                                                 : FAILED!
>> 133: perftool-testsuite_report                                       : FAILED!
>>
>> Before the bad commit the output is
>>  ./perf test 2>&1 | grep FAILED
>> 133: perftool-testsuite_report                                       : FAILED!
>>
>> Any ideas where to look too narrow down the debuggung are very welcome.
> 
> Hi Thomas, sorry for the breakage! I think the issue is a missed
> commit in the v7.0 PR, specifically:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/metricgroup.c?h=perf-tools-next&id=c5a244bf17caf2de22f9e100832b75f72b31d3e6
> This has also shown up as breaking stable backports:
> https://lore.kernel.org/lkml/072e2a07-5c6f-47b5-9695-0a3ffe854ac8@kernel.org/
> 
> Thanks,
> Ian
> 

Ian, Thanks very much!

This is the fix I needed, in case its needed:

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
