Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DA1C4616;
	Wed, 30 Oct 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312473; cv=none; b=gPIrJQHtZcn+2kzNNNvwI4PhyMxIgIIw3t6dFXbJm7BCrCZ58bsWzmGb4iM7hp1UtUyXcs3jKAekOCT54Pf5QsjA2oYOJqofagqNu22MY+lw9AH1l9aTxebJ0QcjvipHyHn3icuMzpDtiM/le7RbrVRYDtGNMak1n04NMplnclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312473; c=relaxed/simple;
	bh=XAlAAQuCCo4hw3RB/nLNvUcS3LFHrYtwoU9Pg4fGpCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HFlxopE2SRIZ2+h9nB82jgK1ckrNODAY3qNDkaH9Ib+2CetqrOHVfZO+HKIk3SDWa2YUK+ILT+tJFTC04KfTjg+OuKo33J02pO/im9uRPGG6EurdVfxh/MJSJod3NgPfEg6XTTwG9TaFHMZ30C8nJqRu1sNfkZs0qVhIJEHZoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DOgphJ4u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DOgphJ4u"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UHTrkL025454;
	Wed, 30 Oct 2024 18:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ee6E7+
	ennRHMEZMdBfnyZdFvi8P6NNf/X8zOfEfVALE=; b=DOgphJ4unvTk1vVIAahDcx
	PGfKwW7t9eYgWLR0TGjHArjFUu0ntcR9Q5Kilk7FJc7MFyc56lr5mzf/CP9m8qX5
	2YxCy+TU9pn94LtfDnEay/M5w5AmwtTSprqm6stfOa2YucdVGKgIItN4X4ma9R6M
	C+3qDSMxzmyxDy/2Y2t9CEc/Li+HJY3p9cR/Xqyk0RWSoY5o8ezae+rSbylaRO/N
	Goj5M25n6ctbhpNWbgTILAIocvHW6JAKOoVLGR2REjZiggdsXYUv0hBqgufGWM7u
	5k1afAk6OefdT3WBHRhLtzJPkmxJvngEQf8wuBweUL53hE4+4aF+xp/v2PpiNpPg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42kqnarr19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 18:20:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49UIIh5C032073;
	Wed, 30 Oct 2024 18:20:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42kqnarr15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 18:20:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49UFj9v7013520;
	Wed, 30 Oct 2024 18:20:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hbrn199h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 18:20:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49UIKAsR54722894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 18:20:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4031520043;
	Wed, 30 Oct 2024 18:20:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E09DF20040;
	Wed, 30 Oct 2024 18:20:08 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 18:20:08 +0000 (GMT)
Message-ID: <b89bcb68-d010-4041-aacf-15b934675705@linux.ibm.com>
Date: Wed, 30 Oct 2024 19:20:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] x86/vdso: Enable sframe generation in VDSO
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
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <ebc4e4a51af47cd1e9a1c515407410e1f69d224f.1730150953.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <ebc4e4a51af47cd1e9a1c515407410e1f69d224f.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vjGwUuf-Mv_eIdBx_pALhJ5m8BxM9DLb
X-Proofpoint-ORIG-GUID: 6rV1BhVlk8IjXc0_g1tqdwJ3hYzcPF8z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300141

On 28.10.2024 22:47, Josh Poimboeuf wrote:
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.

...

Applying similar changes to s390 and using the current binutils release without SFrame support on s390 results in build errors.

AFAIK the kernel has a minimum binutils requirement of 2.25 [1] and the assembler option "--gsframe was introduced with 2.40.

> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index c9216ac4fb1e..75ae9e093a2d 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -47,13 +47,15 @@ quiet_cmd_vdso2c = VDSO2C  $@
>   $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
>   	$(call if_changed,vdso2c)
>   
> +SFRAME_CFLAGS := $(call as-option,-Wa$(comma)-gsframe,)

I have the impression this test might not work as expected. On s390 the assembler accepts option --gsframe and only generates an error when the assembler code actually contains any CFI directives:

$ cat test-nocfi.a
         la      %r1,42
$ as --gsframe test-nocfi.a
$ echo $?
0

$ cat test-cfi.a
         .cfi_startproc
         .cfi_endproc
$ as --gsframe test-cfi.a
test-cfi.a: Assembler messages:
test-cfi.a: Error: .sframe not supported for target
$ echo $?
1

But the following assembler code triggers an error:

$ cat test-sframe.a
         .cfi_sections .sframe
         .cfi_startproc
         .cfi_endproc
$ as test-sframe.a
test-sframe.a: Assembler messages:
test-sframe.a: Error: .sframe not supported for target
$ echo $?
1

Maybe the following would be an alternative test in the Makefile?

SFRAME_CFLAGS := $(call as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_SFRAME=1)
ifneq ($(SFRAME_CFLAGS),)
        SFRAME_CFLAGS += -Wa,--gsframe
endif

> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index b1aa3fcd5bca..1a49492817a1 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -12,8 +12,11 @@
>   	 * For the vDSO, emit both runtime unwind information and debug
>   	 * symbols for the .dbg file.
>   	 */
> -
> +#ifdef __x86_64__

#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)

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
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

