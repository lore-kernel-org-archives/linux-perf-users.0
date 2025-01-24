Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59149143C72;
	Fri, 24 Jan 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736267; cv=none; b=ikNWahc7kIEHACCAw7vI+ppjdOZ+ap+zOPJ0OCzlCzHgnL4owSpeXqpoZC/km1HWGjAhIhoaPiKBybdCbkcsjxVUCakTWDUPRUZ9s3jEMUxXjvBRFniEKhg+knEii/oaf+4v8Q+H01UzlzQ4kqbBjh5zJjfhbtPSRU8fdtIPn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736267; c=relaxed/simple;
	bh=My/NgVlsfM9m1EHir9BZjUY7b/1aO2dM12MwUx2s2EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E417ymDo3XowrSvk6UCRxkA9SYYQopv1TSfrQkCQZSfpKb0KAFOBdc9lRQhevu5eiUCy1RsZfvS/VpzAId78mb2KVy2I/a6zfqiTqJtaX891RHz7SRjZd3tBgzTiGUA3rVsVwHUaVPQQaomPllovADZLwMrPWyRihVDk001z6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DZ2eQ9pW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZ2eQ9pW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OF1LtX017673;
	Fri, 24 Jan 2025 16:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zk00LT
	UVLzTsoBQTcK9Ve9nVCx9oz9h/YhvC0U1pe3k=; b=DZ2eQ9pW+Ak9pBPqpbUX8J
	73RKGSEtI3dCdHs3Rjp4KC5ZnXQO6O3R4/Cx9aNqkGZ2eqFT0Z7dZzj2UG4mDIjp
	8T4Fof+Fob/c8ST8WqgYBSBKqj0Yd4qigYzhNUSvtvil3d1FPFt4104O2L+l2ANf
	o+YECnsf4mTXamH/NuUKUqyu98og30Iw1Qme96if0K7iJm8Av1IC8H/3X82j3I/i
	tpm/R2jUYSvmK3PlR6aolHjtFsm4aOA3S5R6dB0OA+Gr7pozwXoOrOHcyqHFf262
	0JhMdEPNluntzQkQLf88fRDNWRk46q9PKAdw3b3qRmV6CjOBpy9jOOpjdtfcafTw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cd4ygee5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:30:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50OGCnTR001077;
	Fri, 24 Jan 2025 16:30:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cd4ygee0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:30:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OE34BC032290;
	Fri, 24 Jan 2025 16:30:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk3w22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:30:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OGUcQK59376076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 16:30:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB5B2004B;
	Fri, 24 Jan 2025 16:30:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E482320043;
	Fri, 24 Jan 2025 16:30:36 +0000 (GMT)
Received: from [9.171.221.90] (unknown [9.171.221.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 16:30:36 +0000 (GMT)
Message-ID: <05ae2b86-ba4c-4eaf-9c5f-726fc57c7a2d@linux.ibm.com>
Date: Fri, 24 Jan 2025 17:30:36 +0100
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
X-Proofpoint-GUID: bikYxHPLBWcNf5UbDFd6U3U2b224bvoW
X-Proofpoint-ORIG-GUID: E1ADdeo2PSESPzMaaWlXKyPuOsXuStlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240116

On 22.01.2025 03:31, Josh Poimboeuf wrote:
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile

> @@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
>   $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
>   	$(call if_changed,vdso2c)
>   
> +#ifdef CONFIG_AS_SFRAME
> +SFRAME_CFLAGS := -Wa$(comma)-gsframe
> +#endif
> +

You probably erroneously mixed up C preprocessor and Makefile syntax? :-)

ifeq ($(CONFIG_AS_SFRAME),y)
        SFRAME_CFLAGS := -Wa,--gsframe
endif

$(comma) does not appear to be required in this context.

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

