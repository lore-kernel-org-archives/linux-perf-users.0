Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BAD22B8D2;
	Wed,  5 Feb 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751172; cv=none; b=BPh9iQxlX2Zk7YGQOf+qq8AEQB6N+KR09c9YG+Q/z3j6g3a3k0SciqQ6YTY2mc9RX3+IOzDTcZ8CL4h3FVkMa5dM1Db7VGIrN+WSbjHrwduQN5iNI4SfnDECQrs7ufnP4Qg6sSGXhuPh72P0W4XKF1xj1M8o31z1Iv4zoRfenZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751172; c=relaxed/simple;
	bh=kNuY9pTiA71TGN0k1KL8rYBqW4XfeUprFTz9eU0Hp1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP0kS/EUfbVjc4urHIs5Kkfr0nTY08nEJCBOGEU7ZATI2gf8JG00ngn5PpBS+VyGPG6D+aReHOcYPwncsT/L6YZp1gFEhd7TaPoSowVWssQeX/Ju4Nz0RdlxyfqTK5FRwEQehQHODBKPi9jWPqauGQ3TMkcJwtxFyrOkmgRMrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dpy0VAf/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dpy0VAf/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51520ium009855;
	Wed, 5 Feb 2025 10:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=39GbDh
	2oCbRcovW+HgpZfevaZM0m5ogCHv73Pk6nFWo=; b=Dpy0VAf/acHdqDOm2ya/z/
	OnEz7BlsnxBuS8heK24YigyGDQgOJhHCVPNpDnwi086+6aABxsdG4RnNkEJesmjQ
	08ipiRYunZX0hxlD/WvgVxmzEv+U+j/+aquuWlTuQIK8JcAWhHvwR1rsNyUZaIkj
	IgOak2GCuyTTz3REWWJSWkotKiu1UPaQo0yQ6J15qLNUdNSmM7q4b+5iOClDNo2e
	X/pfB6b9kdqcDxgS9F3/gsUXznU4/f0BmK3ypIFVxRpMIU1AH/plE5aR2takMShT
	4+ONqpPXm8fwN/9XwX3lS42Ge2qDuieb/4m3OCeAJgiXxM90xxGtVSQB70gyn10g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyhxge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:25:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515AMgDe018856;
	Wed, 5 Feb 2025 10:25:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyhxga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:25:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5159GJuu005292;
	Wed, 5 Feb 2025 10:25:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05k01cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:25:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515APdev20578672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 10:25:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9313720189;
	Wed,  5 Feb 2025 10:04:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D0DE20184;
	Wed,  5 Feb 2025 10:04:55 +0000 (GMT)
Received: from [9.171.163.71] (unknown [9.171.163.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 10:04:55 +0000 (GMT)
Message-ID: <48231957-ef84-4329-9337-411a8fbf5fe6@linux.ibm.com>
Date: Wed, 5 Feb 2025 11:04:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/39] unwind_user/sframe: Show file name in debug
 output
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <7bfb7ffad5fe384fe3dbe6c8ca985f35b98b48bb.1737511963.git.jpoimboe@kernel.org>
 <c9ba301e-8451-441d-8212-2913a76ff32d@linux.ibm.com>
 <20250204191017.iqrew5zgxg7eh4s2@jpoimboe>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250204191017.iqrew5zgxg7eh4s2@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sjoZ26pCl11vMu4rdX37ChXw6CTlE3_A
X-Proofpoint-ORIG-GUID: PcHiUz60VwhfqjfkWBzqnNpy4WiNAGpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050080

On 04.02.2025 20:10, Josh Poimboeuf wrote:
> On Thu, Jan 30, 2025 at 05:17:33PM +0100, Jens Remus wrote:
>> On 22.01.2025 03:31, Josh Poimboeuf wrote:

>>> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
>>
>>> +static inline void dbg_init(struct sframe_section *sec)
>>> +{
>>> +	struct mm_struct *mm = current->mm;
>>> +	struct vm_area_struct *vma;
>>> +
>>> +	guard(mmap_read_lock)(mm);
>>> +	vma = vma_lookup(mm, sec->sframe_start);
>>> +	if (!vma)
>>> +		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
>>> +	else if (vma->vm_file)
>>> +		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
>>> +	else if (!vma->vm_mm)
>>
>> This condition does not appear to work for vdso on s390.
> 
> I had a fix for this which somehow got dropped:
> 
> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
> index 3bb3c5574aee..045e9c0b16c9 100644
> --- a/kernel/unwind/sframe_debug.h
> +++ b/kernel/unwind/sframe_debug.h
> @@ -67,6 +67,10 @@ static inline void dbg_init(struct sframe_section *sec)
>   		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
>   	else if (vma->vm_file)
>   		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
> +	else if (vma->vm_ops && vma->vm_ops->name)
> +		sec->filename = kstrdup(vma->vm_ops->name(vma), GFP_KERNEL);
> +	else if (arch_vma_name(vma))
> +		sec->filename = kstrdup(arch_vma_name(vma), GFP_KERNEL);
>   	else if (!vma->vm_mm)
>   		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
>   	else

Thanks! Your patch works fine on s390:

test_vdso    1087   104.721004:      10000 task-clock:ppp:
              3ffd11f1702 __cvdso_clock_gettime_data.constprop.0+0x52 ([vdso])
              3ffd11f14c6 __kernel_clock_gettime+0x16 ([vdso])
              3ff8f6f113e clock_gettime@@GLIBC_2.17+0x1e (/usr/lib64/libc.so.6)
              3ff8f6e20e8 __gettimeofday+0x38 (/usr/lib64/libc.so.6)
                  100066e main+0x1e (/root/test/vdso/test_vdso)
              3ff8f63459c __libc_start_call_main+0x8c (/usr/lib64/libc.so.6)
              3ff8f63469e __libc_start_main@@GLIBC_2.34+0xae (/usr/lib64/libc.so.6)
                  100073a _start+0x3a (/root/test/vdso/test_vdso)

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

