Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D01BD9E1;
	Wed, 30 Oct 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308828; cv=none; b=NyBr4jrxoJdNnZ/AOZlC+4abfWTdfj2S9Q3PJcMqBAc9+AF4HVx/bGWigKTp44PRg8QV468gN0foUsQXl8Osh9m8Ww9GPTWbDZYileui5/zHRuhackuZ3KFKrsfioPhdrnNtIX6/yx8m3i025YD3yyxB7OpDp+kQttt5GD4Qbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308828; c=relaxed/simple;
	bh=gPvRKtAXej/ewWl/fjGW/D4StdBtkZ0b3vbbbeH99bs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ASwNps/fzdBxyX72NvvSXVa+DUnUUsExBqjd94dzPdPwBJl7ZZ6RXZUr1O2OrMvCAuc2bFn28Jzy5qLJfuUXGFFE0CVNFsucRhhKXD1YiqNmYEIEsac6uIBgZA0XVNVPksIqWLeyHsNQup/cWJaOPc62RQUBo+9PqKJcD67HKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NztwbQTu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NztwbQTu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UDw5fc029735;
	Wed, 30 Oct 2024 17:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p+cqmA
	onCY4nmgO2KSbInGQx6L3yEPEuBmdD9Mqk8bA=; b=NztwbQTuJO5McWvvQmtS9L
	/WW1P7Q2wQhvXxwW56clGxEcF+vwN+2N2g/PYdPLDtKiR1p1bxdRbtwQd+u1ZcsC
	sWgSGgUjaNYA+MVkassGzWx36Q0OXhAIHGjLKDIf0SyMMOZZqbs4CKIM6VVx4Xen
	CXk8ACsum+4PAOgH6IWMcFt2R+lQj1fecM1CxI2e4NzB7QfBtVtY1+TCaYQsJ5EQ
	gz8G0GsUg1STjxLgFZHeJQCmp9xCUQ8H2BriRlcWOWnv+NzMr3s34MA2iQWeTCPg
	CnSqRFKXhdLly76Twx9LmBzDCWd5H3M5eWJWAVQ1wnyV9QSzmuycbLzDTEViVCUg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nt0jqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 17:19:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49UHJnq1031593;
	Wed, 30 Oct 2024 17:19:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nt0jqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 17:19:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49UDhTqF015836;
	Wed, 30 Oct 2024 17:19:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hdf1gpew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 17:19:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49UHJkVd51642624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 17:19:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32BA420043;
	Wed, 30 Oct 2024 17:19:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 362CA20040;
	Wed, 30 Oct 2024 17:19:44 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 17:19:44 +0000 (GMT)
Message-ID: <6796952b-22cf-4477-a4da-70ce9c3962eb@linux.ibm.com>
Date: Wed, 30 Oct 2024 18:19:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] x86/asm: Avoid emitting DWARF CFI for non-VDSO
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
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <f2dcdcf95240149bfd21e118209bf3b94efad857.1730150953.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <f2dcdcf95240149bfd21e118209bf3b94efad857.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PVjsC7cvsXe1CKEspuSOqTyT5CrLjFrP
X-Proofpoint-GUID: CzJH1swJcieoaEpkNG7NTCqRH0bRx6cP
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=895 clxscore=1011 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300135

On 28.10.2024 22:47, Josh Poimboeuf wrote:
> VDSO is the only part of the "kernel" using DWARF CFI directives.  For
> the kernel proper, ensure the CFI_* macros don't do anything.
> 
> These macros aren't yet being used outside of VDSO, so there's no
> functional change.

...

> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index 430fca13bb56..b1aa3fcd5bca 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
...
> @@ -29,13 +39,24 @@
>   	 * useful to anyone.  Note we should not use this directive if we
>   	 * ever decide to enable DWARF unwinding at runtime.
>   	 */
> +
>   	.cfi_sections .debug_frame
> -#else
> -	 /*
> -	  * For the vDSO, emit both runtime unwind information and debug
> -	  * symbols for the .dbg file.
> -	  */
> -	.cfi_sections .eh_frame, .debug_frame
> -#endif
> +
> +#define CFI_STARTPROC
> +#define CFI_ENDPROC
> +#define CFI_DEF_CFA
> +#define CFI_DEF_CFA_REGISTER
> +#define CFI_DEF_CFA_OFFSET
> +#define CFI_ADJUST_CFA_OFFSET
> +#define CFI_OFFSET
> +#define CFI_REL_OFFSET
> +#define CFI_REGISTER
> +#define CFI_RESTORE
> +#define CFI_REMEMBER_STATE
> +#define CFI_RESTORE_STATE
> +#define CFI_UNDEFINED
> +#define CFI_ESCAPE

Don't all of the above need to be defined to "#", so that they change 
any parameters into an assembler comment? For example:

#define CFI_STARTPROC		#

> +
> +#endif /* !BUILD_VDSO */
>   
>   #endif /* _ASM_X86_DWARF2_H */

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des 
Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der 
Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

