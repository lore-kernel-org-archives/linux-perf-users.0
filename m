Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66421DE4EF;
	Wed,  6 Nov 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912969; cv=none; b=g9n9j9JBdR/l7bOqwjMyWE7FwzaRkQyRt6AJwU4dqO1SuSYXdM2LndfRZQswH3fu3iQ7ygbXJMMQK0wTYM3U5unIMwaHXw1KFZ4BQ+8VKJSG8sGTHuF7l7XFU2xr6X07P9CsYsc4m33diOzQ2kaKagA4bgaFWOn1OK07BXY/cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912969; c=relaxed/simple;
	bh=41LsHXoX987C4fNFtmJj2o2V8wDdrdxLnruf1+GeCrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQPu70ESrQnXA9EHm310+njmJAw4uVnDnB6FhK8+Dad6GgRjWLUJsrIa1LU2BYqLMoTpVarjhTt38JbSrYMM8xe0yMi2dT+0bso5ZBF7bmRI/gAfPsRZusZ/VjpY80ts//5WlGUcN/f5+3CsAm8yWu7V+YkZyZD4XvIKGLOIfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ETlzRxm4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ETlzRxm4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6H6ph6005159;
	Wed, 6 Nov 2024 17:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fevTHl
	45RE9CKA3n1iiJliFCZI5cGe0f+tLLXFWGdpE=; b=ETlzRxm48457iUotNvv2JP
	aaeziDrbsHe0UYOy59PUgFwEGKqNo7Las3duRlVGSGY7ZS58L23oEhsBiCqivafh
	ex9nrSty5gw2qODohqkesfaOT90OCMPxoDH5Rnlnex5Z5hNmWh2J+ESVzwmglJr+
	w1ODkNS6CDqDtNmuf3XrP6R44OJgRejohQyIR0ufob+mawqXN0U+DMOfRKnTWWoE
	b/bCz6ao9nRQ1a8NFci4oLG0ECTROO70/vwsAMCfm5fU6dBaK3RAH+j726dmcjtN
	R9euHZAxt2GMfM/u2eO/dl8ec4VxEMQYcMfGPDKIWp5cncM4fE+2cOQpNu9XNvGw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rba0gk5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 17:08:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A6H6qeD005319;
	Wed, 6 Nov 2024 17:08:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rba0gk32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 17:08:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6FGn5T019085;
	Wed, 6 Nov 2024 17:04:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj6fye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 17:04:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6H48FY47710652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 17:04:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611BA20040;
	Wed,  6 Nov 2024 17:04:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B1320043;
	Wed,  6 Nov 2024 17:04:07 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 17:04:07 +0000 (GMT)
Message-ID: <dc588eb9-f4ec-4ec8-b472-19e894b753e9@linux.ibm.com>
Date: Wed, 6 Nov 2024 18:04:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
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
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZWjQAsrbLnnnQrWJyHlh0lryrAE7UvIA
X-Proofpoint-ORIG-GUID: M9vnOA56mAYv8FrsMXCtZQaJeayKSw9c
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060133

On 28.10.2024 22:47, Josh Poimboeuf wrote:
...

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
...
> +#define __SFRAME_GET_USER(out, user_ptr, type)				\
> +({									\
> +	type __tmp;							\
> +	if (get_user(__tmp, (type __user *)user_ptr))			\
> +		return -EFAULT;						\
> +	user_ptr += sizeof(__tmp);					\
> +	out = __tmp;							\
> +})
> +
> +#define SFRAME_GET_USER(out, user_ptr, size)				\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__SFRAME_GET_USER(out, user_ptr, u8);			\
> +		break;							\
> +	case 2:								\
> +		__SFRAME_GET_USER(out, user_ptr, u16);			\
> +		break;							\
> +	case 4:								\
> +		__SFRAME_GET_USER(out, user_ptr, u32);			\
> +		break;							\
> +	default:							\
> +		return -EINVAL;						\
> +	}								\
> +})
> +
> +static unsigned char fre_type_to_size(unsigned char fre_type)
> +{
> +	if (fre_type > 2)
> +		return 0;
> +	return 1 << fre_type;
> +}
> +
> +static unsigned char offset_size_enum_to_size(unsigned char off_size)
> +{
> +	if (off_size > 2)
> +		return 0;
> +	return 1 << off_size;
> +}
...
> +static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
> +		    unsigned long ip, struct unwind_user_frame *frame)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> +	unsigned char offset_count, offset_size;
> +	s32 cfa_off, ra_off, fp_off, ip_off;
> +	void __user *f, *last_f = NULL;
> +	unsigned char addr_size;
> +	u32 last_fre_ip_off = 0;
> +	u8 fre_info = 0;
> +	int i;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EINVAL;
> +
> +	ip_off = ip - (sec->sframe_addr + fde->start_addr);
> +
> +	f = (void __user *)sec->fres_addr + fde->fres_off;
> +
> +	for (i = 0; i < fde->fres_num; i++) {
> +		u32 fre_ip_off;
> +
> +		SFRAME_GET_USER(fre_ip_off, f, addr_size);
> +
> +		if (fre_ip_off < last_fre_ip_off)
> +			return -EINVAL;
> +
> +		last_fre_ip_off = fre_ip_off;
> +
> +		if (fde_type == SFRAME_FDE_TYPE_PCINC) {
> +			if (ip_off < fre_ip_off)
> +				break;
> +		} else {
> +			/* SFRAME_FDE_TYPE_PCMASK */
> +			if (ip_off % fde->rep_size < fre_ip_off)
> +				break;
> +		}
> +
> +		SFRAME_GET_USER(fre_info, f, 1);
> +
> +		offset_count = SFRAME_FRE_OFFSET_COUNT(fre_info);
> +		offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(fre_info));
> +
> +		if (!offset_count || !offset_size)
> +			return -EINVAL;
> +
> +		last_f = f;
> +		f += offset_count * offset_size;
> +	}
> +
> +	if (!last_f)
> +		return -EINVAL;
> +
> +	f = last_f;
> +
> +	SFRAME_GET_USER(cfa_off, f, offset_size);

SFRAME_GET_USER() does not work for the signed SFrame CFA offset.

> +	offset_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {
> +		if (!offset_count--)
> +			return -EINVAL;
> +
> +		SFRAME_GET_USER(ra_off, f, offset_size);

Likewise for the signed SFrame RA offset.

Excerpt from my added trace. Note the RA_off=65488 (unsigned) = 0xFFD0 = 
-48 (signed):

unwind_user_next: WARNING: RA could not be obtained from user space 
(IP=0x000003ffbb5f4218, CFA=0x000003ffc22f8f10, RA_off=65488)

Excerpt from perf script:

3ffbb5f4218 internal_fnwmatch+0x558 (/usr/lib64/libc.so.6)

Excerpts from objdump -wt --sframe:

00000000000f3cc0 l     F .text  000000000000195c 
internal_fnwmatch

func idx [1715]: pc = 0xf3cc0, size = 6492 bytes
STARTPC         CFA       FP        RA           INFO
00000000000f3cc0  sp+160    u         u            (1*1B)
00000000000f3cc6  sp+160    c-72      c-48         (3*1B)
00000000000f3cd0  sp+4256   c-72      c-48         (3*2B)
00000000000f3cdc  sp+8352   c-72      c-48         (3*2B)
00000000000f3ce8  sp+10792  c-72      c-48         (3*2B)
00000000000f3f7e  sp+160    u         u            (1*1B)
00000000000f3f80  sp+10792  c-72      c-48         (3*2B)

> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && offset_count) {
> +		offset_count--;
> +		SFRAME_GET_USER(fp_off, f, offset_size);

Likewise for the signed SFrame FP offset.

> +	}
> +
> +	if (offset_count)
> +		return -EINVAL;
> +
> +	frame->cfa_off = cfa_off;
> +	frame->ra_off = ra_off;
> +	frame->fp_off = fp_off;
> +	frame->use_fp = SFRAME_FRE_CFA_BASE_REG_ID(fre_info) == SFRAME_BASE_REG_FP;
> +
> +	return 0;
> +}
...

I have verified that reintroducing and using SFRAME_GET_USER_SIGNED() 
works correctly.

Regards,
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

