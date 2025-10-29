Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9C33A01E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753399; cv=none; b=t6XK1SpVhD+DaP0/6A3bGPLreExYy4LgCcndi0kY/btB0mv+f4FgRyjf8e1lnyLKPTdoH+NtloISE1GZHLlo5dDpOtE9HGXikAWtaOpYKbXxjUMAGj1C3L+o/5THGROruhHJrjbYVTtL1eDPOZQ32KOsf+2YXvwu6JA9aMVCfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753399; c=relaxed/simple;
	bh=Bunns/O6fRUMSYmXEKL/YjRNRHnPkynh5/f+JbqokQg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EQ3byaNcarfPHhyq7JcgYjzRvf+YvJzuoFn2K4Xz5bJCTNHH+xA1cR9lUWmS7g1LQEMxuDHpRGMnwxIJD7piZLZULIjJQdjOW/QJjBZiE4OTYI4q75Jdm4Ua/d1waKVtc0q0eRLX+bfS7SZdC4bANRniXtkCWrDUH/+N6dXxbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOO9t6hu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOO9t6hu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBgAXn008800
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9knZbB
	gnTP2NgDzmTcYlkpOC/UzoORkvMBnayhCYeS4=; b=lOO9t6huD7zKvxIlK/0Atd
	Ie3F+s+XnLBJ2K4Kg1XJsDWI8OzEuS18dP+Vv5RqEcqmxkJDz+Z9XQKf6vuRDy0N
	/gkHVGhXwggvRe0XSacPEg0ilr6Khs9/AztNaIZn9dd+54oXMXEDhTtEg21Y7rYH
	hXg2B+tAD9k+I8j29Nt5a69x3q3ndBdxzamQ80vWpfSLMOcZnMAGtUJIy/ekjV6w
	drRYKfGjE46mtTUzt1vRmE1zTlG1s3vSpJxEKx/J+0JQ3Z4FTkt9BKDK24l07uiQ
	FcMsJ2q3YAzDvLwDMEt9pbdn7o6Oh+lCBFarOtI58vUxLsFlhpGCtKfqfKl4ZP2g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34afc8eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:56:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TDl3Qd019916
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:56:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy46du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:56:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TFuVvK44892632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 15:56:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E29220043;
	Wed, 29 Oct 2025 15:56:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80B6820040;
	Wed, 29 Oct 2025 15:56:31 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 15:56:31 +0000 (GMT)
Message-ID: <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
Date: Wed, 29 Oct 2025 16:56:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next] perf report runtime extremely long
From: Thomas Richter <tmricht@linux.ibm.com>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
Content-Language: en-US
Organization: IBM
In-Reply-To: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hBJScETm7JyFjgFIX7HAWjdnlEFbFLLK
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=69023934 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KByoUL483hSIROooWq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX8V6wZbnAk7tL
 8PvWlhrfJGPLliCUZ//4zMLhpX5DokE0aAlMEPxzNI8KOPkkgc7apCN84LV2G7bkfxknqVdpIR9
 7WrAWJAzWc3zFCgbtCkYWN3aro6exALDLpME0TFJoXMD4CXxtVVmYTjQbNbgdpURglH1rC0z3Bp
 ZalOxu+DgEQxOYlf9rtV8Bv7d3s80mgfFdvgHfVpNQZya2SJy78INhYtgBDR1NSD67A+I96RpXb
 ZCKxOV8BSn9OSeV+SfEhO6WPH0ApdY0VXO7AGCwBnbgbxVcwblVcajD5EfU1Ny1OZ49lL6ZfoVT
 p4/yOfLNik64/sZH2z5oay0b2vGz6+SMo3aBCuV2F6eD0u+haztIDN0EDeWJe111lDqhDpulNDS
 S5pMokoIV09nuF0VuLq0q42e0WONKA==
X-Proofpoint-ORIG-GUID: hBJScETm7JyFjgFIX7HAWjdnlEFbFLLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On 10/29/25 09:03, Thomas Richter wrote:
> Hi all,
> 
> has something changed recently in perf report in linux-next repo?
> 
> I run perf report -i <file> -D | grep something
> on s390 with 2 different kernels:
> 
> master 6.18.0rc3:
> # uname -a
> Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET 2025 s390x GNU/Linux
> # ll /tmp/perf2-eSso2q-2
> -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
> 
> real	0m22.262s
> user	0m22.068s
> sys	0m0.200s
> # 
> 
> This runtime is ok for the perf.data file size.
> 
> linux-next:
> # uname -a
> Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
> #ll /tmp/perf2-eSso2q-2
> -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
> 
> real	2m53.601s
> user	2m52.938s
> sys	0m0.575s
> #
> 
> Same perf.data file and run time increased from 22 seconds to nearly 300 seconds, roughly 14 times longer
> for the same input!
> 
> Has anybody similar observations?
> 
> Thanks a lot
> 

Ian,

sorry sent button pushed too early...

here is a second try without option -D.

This is much better:

root in 🌐 s83lp47 in ~ 
❯ ll perf1.data 
-rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data

root in 🌐 s83lp47 in ~ 
❯ time perf record -- perf report -i perf1.data  > /dev/null
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.027 MB perf.data (246 samples) ]

real	0m1.097s
user	0m0.082s
sys	0m0.167s

root in 🌐 s83lp47 in ~ 
❯ perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 246  of event 'cpum_cf/cycles/P'
# Event count (approx.): 307500000
#
# Overhead  Command  Shared Object        Symbol                                            
# ........  .......  ...................  ..................................................
#
     9.35%  perf     perf                 [.] reader__read_event
     4.47%  perf     perf                 [.] perf_env__arch
     2.85%  perf     ld64.so.1            [.] _dl_relocate_object_no_relro
     2.44%  perf     ld64.so.1            [.] _dl_lookup_symbol_x
     2.44%  perf     ld64.so.1            [.] do_lookup_x
     2.44%  perf     perf                 [.] down_read
     2.03%  perf     perf                 [.] hists__findnew_entry
     2.03%  perf     perf                 [.] perf_hpp__is_dynamic_entry
     1.63%  perf     [kernel.kallsyms]    [k] __s390_indirect_jump_r14
     1.63%  perf     [kernel.kallsyms]    [k] format_decode
     1.63%  perf     libc.so.6            [.] cfree@GLIBC_2.2
     1.63%  perf     perf                 [.] evsel__parse_sample
     1.63%  perf     perf                 [.] map__put
     1.63%  perf     perf                 [.] sort__comm_cmp
     1.63%  perf     perf                 [.] thread__put
     1.22%  perf     [kernel.kallsyms]    [k] folio_add_file_rmap_ptes
     1.22%  perf     [kernel.kallsyms]    [k] get_page_from_freelist
     1.22%  perf     ld64.so.1            [.] _dl_name_match_p
     1.22%  perf     perf                 [.] dump_printf
     1.22%  perf     perf                 [.] evlist__event2evsel
     1.22%  perf     perf                 [.] hashmap_find
     1.22%  perf     perf                 [.] perf_session__deliver_event

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
