Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3015B115;
	Fri, 24 Jan 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734970; cv=none; b=N/h8Tb5bnjU6OEvFGfMjouNq3W46Aif8W/X4ORwBITVRElQ7ElBMd+1KIb/EwiTXzaZM6xAGCVxO4faT6PZCrJz1sOIkxHEnQv/oAiQ89ziFmWpLgJ63Lg93UBsDemsLYE1GGphrhKXongA4RYQXOdS4LeWLwtG7NwK2VEPweuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734970; c=relaxed/simple;
	bh=HVI25fjOH2C7M8+gcWCvhC3aP1kwICzlacssh67kEro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8/qhGua3bFECmHLRa6q8Xv9eqnXFeo4cskMV1tGfI2LGSefWMg2njfdb3/DhToPgrpgKJgNMeshWUzFOSaawbKMopz4+1yxPVOCEOdQBHQIIy8NcGVPTrhSvE46AlmbPXUGLNBYsLCinA5vw0CUgRJFTYbuU6agcQKAehZ0KFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eUKq2vPR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eUKq2vPR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7XScr022153;
	Fri, 24 Jan 2025 16:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bqfMT6
	BLvbYuJx/IRIK+b0AiEYmksgychL+p8MOATFQ=; b=eUKq2vPRmKnMSwNixrOYTQ
	BqEk9dumbKdXQjE17QmvBhcEYNMf4vl3yGDyG662U8c686U+mKTTmlLjk9KgeNv5
	X/cyiNPeL1N5HJ56yFWJK8ZvbdWUFdqeYuDG3+oV7wG4kpg+P3jlBXLaw4yN7xlf
	yVgSxhwG4EVeNULX9Ry1rq8B3y3sUoC989SD2W6CIhrZtuvlXMM5Q9DIBzW6quS/
	MEamXbd40uPaTVP3DSpg9TS6zok25WFBpxMcRAStJ7Kp06pOOtEg2jzRLDNJwUMF
	430vMVauabkHuH5J0Of0Kih+RfGUKI+Z87srJHGEoFQ5maY52XKOKVVEbRgZ/pLQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnj89n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:09:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50OG5X4L004854;
	Fri, 24 Jan 2025 16:09:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnj89k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:09:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFUSkN029595;
	Fri, 24 Jan 2025 16:09:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnv6r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:09:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OG8xSF42991898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 16:08:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C760200DD;
	Fri, 24 Jan 2025 16:08:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AD7F200DE;
	Fri, 24 Jan 2025 16:08:58 +0000 (GMT)
Received: from [9.171.221.90] (unknown [9.171.221.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 16:08:58 +0000 (GMT)
Message-ID: <e5008073-f779-492b-807f-d14c39ec0ba3@linux.ibm.com>
Date: Fri, 24 Jan 2025 17:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/39] x86/asm: Avoid emitting DWARF CFI for non-VDSO
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
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
 <0c6c20d81164ba1dd375465f31bd51a8e1af164d.1737511963.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <0c6c20d81164ba1dd375465f31bd51a8e1af164d.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jpxt0Sw2yti754DZaOqZOtMFrSNOvZzZ
X-Proofpoint-ORIG-GUID: Mzfb_EePB27bva33DMSi0e6P1BbP-ZRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=858 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240113

On 22.01.2025 03:30, Josh Poimboeuf wrote:
> It was decided years ago that .cfi_* annotations aren't maintainable in
> the kernel.  They were replaced by objtool unwind hints.  For the kernel
> proper, ensure the CFI_* macros don't do anything.
> 
> On the other hand the VDSO library *does* use them, so user space can
> unwind through it.
> 
> Make sure these macros only work for VDSO.  They aren't actually being
> used outside of VDSO anyway, so there's no functional change.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h

> -#ifndef BUILD_VDSO
> -	/*
> -	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
> -	 * The latter we currently just discard since we don't do DWARF
> -	 * unwinding at runtime.  So only the offline DWARF information is
> -	 * useful to anyone.  Note we should not use this directive if we
> -	 * ever decide to enable DWARF unwinding at runtime.
> -	 */
> -	.cfi_sections .debug_frame
> -#else
> -	 /*
> -	  * For the vDSO, emit both runtime unwind information and debug
> -	  * symbols for the .dbg file.
> -	  */
> -	.cfi_sections .eh_frame, .debug_frame
> -#endif
> +#else /* !BUILD_VDSO */
> +

Did you remove ".cfi_sections .debug_frame" on purpose from the
!BUILD_VDSO path compared to V3? Presumably to not only not emit
DWARF CFI from assembler, but any source?

> +/*
> + * On x86, these macros aren't used outside VDSO.  As well they shouldn't be:
> + * they're fragile and very difficult to maintain.
> + */

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

