Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF58182D2;
	Fri, 24 Jan 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734467; cv=none; b=QOsczW+jebW2mCJGQKKCdACHyvAqk7ByMGcLxWuMS0QWebFZ58xkvzkW8FmsyXHR6tTLW+ZUlBjXHSGVoK3Vo/V6WQgRuF+Wn+6nE1pFWgFK6LzebJlhT3TpheovFJU270T9FAu8ivBuxP480It5RLHYYD1ANOMWqfRLYDft0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734467; c=relaxed/simple;
	bh=veoMRCS9AgbWvj38/NL9KmB3+dIjDTiiJJrp6pfBJfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC8F6d5oYCR7gIhmFFo69Rw0gd0NyTlWBQy3zQzAkyhfGSdGC6Q6I9NPeTOMPbKS5nNN6LnGm8Ag757kldKUHWwfk2Oz4VDdmk6VwNIbgEUs5vMtObqHNZM9gqpOq4fnhKzZ4HwsA+9APvgWpoQ4GhJBeg9DsWjrSalbx/tl4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmkjdaep; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmkjdaep"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O9mGDD008382;
	Fri, 24 Jan 2025 16:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2EO8/7
	sNjiH6Zcn0pFx21Ct89vfm8r3Jz3b25GvlkMQ=; b=rmkjdaepGt2UtRoTMZ/a1L
	d8fVEuy5MQN9dnzJ+N7tXhsHi12fFnDQ5gxlA0EDWFOFVAmQUezAoFbP3U09/0kE
	vbXQcC+5K6bCBy3jgkqfFwScr5fynodW8FGWMnI/N+hb5Tihr2lvCRQYElOvqkmG
	xTdlTq3AogVLhvFghdeaOW3WS//baZrC/qNHiy5Q5xfAzo1g/dGnECeSuxpDylD+
	xKKzpIYMO+jUnhGCOpe31L924c+Mr86gF+bMx0x4QrH32tgVKFgtdEDtw2juircB
	DtZKX0/6djTGQRu4uqrLpr76NHtrpK6D4DJYUeLjJHpLY85fzrpcH31zqRxzYQJA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c1pyvdjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:00:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50OFoAkf028734;
	Fri, 24 Jan 2025 16:00:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c1pyvdj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:00:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OClIEl029594;
	Fri, 24 Jan 2025 16:00:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnv5gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:00:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OG0Uir20906266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 16:00:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F4043200B8;
	Fri, 24 Jan 2025 16:00:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41A8200B6;
	Fri, 24 Jan 2025 16:00:28 +0000 (GMT)
Received: from [9.171.221.90] (unknown [9.171.221.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 16:00:28 +0000 (GMT)
Message-ID: <cde90a82-6bdd-4a12-872a-7b39edf3eac8@linux.ibm.com>
Date: Fri, 24 Jan 2025 17:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/39] x86/vdso: Enable sframe generation in VDSO
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
 <c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fazN2hOdkcOyVCtUnk1q5i5TGm0LnuOA
X-Proofpoint-GUID: tFvkTVSvnxswfZJKcz3ZPPrupms8Xj7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=882 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240113

On 22.01.2025 03:31, Josh Poimboeuf wrote:
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

...

> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index b195b3c8677e..1c354f648505 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -12,8 +12,11 @@
>   	 * For the vDSO, emit both runtime unwind information and debug
>   	 * symbols for the .dbg file.
>   	 */
> -

Nit: Deleted blank line you introduced in "[PATCH v4 05/39] x86/asm:
Avoid emitting DWARF CFI for non-VDSO".

> +#ifdef __x86_64__

#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)

AFAIK the kernel has a minimum binutils requirement of 2.25 [1]
and assembler option "--gsframe" as well as directive
".cfi_sections .sframe" were introduced with 2.40.

> +	.cfi_sections .eh_frame, .debug_frame, .sframe
> +#else
>   	.cfi_sections .eh_frame, .debug_frame
> +#endif
>   
>   #define CFI_STARTPROC		.cfi_startproc
>   #define CFI_ENDPROC		.cfi_endproc

[1]: https://docs.kernel.org/process/changes.html

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

