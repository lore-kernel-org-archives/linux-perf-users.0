Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374C23DE95;
	Mon, 10 Feb 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203070; cv=none; b=hJWOeAWZ6IDQddsnLpINe5t/s3Gb1AM4/pI5fOFlOaFoTFPr1wXTGsp+KbNhmOvWZqMl1ZCmSKkHvbeDA09peQWA5OAuzejLeOsRXMuwV2XQH2SAuBB9K5uP37PfDRFOcbyAx0ztQaFClSILxErTOIj79M7FPfEAXWIqlAz9iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203070; c=relaxed/simple;
	bh=ngoa/pnNW9MKgFWcNtEvcQHznTvuhl7Mc0/xE2QvkOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5OVGgfubXo0f1KKWhq0JqeQgvkZz/iPBwuogtqxpxoiea/Rd7dZGO6tZgTcB7LtfCTf2tBDkOkZut+C9hUkW8/gVr9PS1/HsuZ7NmZNe2Sna5sfeEn09iptxiu55qWsES8wPWkSFy09opGjADTiJGok2s9vNBVYfFK4QiP/FJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SfqD5Gtq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SfqD5Gtq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9k4RP015298;
	Mon, 10 Feb 2025 15:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JFQg6/
	mm1mCQ9hm1UAMD/WpOw3HzXsccpaFRpJs7log=; b=SfqD5GtqADN9Ps6T/QLBGG
	cc5Vlp1lkLY1VOcvvWOChBIrbnx7HGsw8VVqlrysOfZPGpLiODcQURivlh+27t06
	ohdu0iO87ipKULigC30GsUEkrpgkwtACCerbh4wmv/Glx/B+pXV1ZB4Ouu3LUTJA
	uSVYBovfK3TlQUcgTQQsxufZAkL7QHum6fV/DUX1RV6msphcXZ/V3zAgcbneJ8TS
	Fa//0RGUduVCRn1up5NbbCds/oWeOXlzI1IiWnvMAL4QhDBdvMDHF5XD/a2S8KpE
	a1avWJAWZBzDgxMwzQd8SAwFEHuKz6FgLZIwRY4pK8kK5RTFtDDCtShN5/gsaWGw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gac7ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51AFqaKx029544;
	Mon, 10 Feb 2025 15:56:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gac7ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51AF5LH2028268;
	Mon, 10 Feb 2025 15:56:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyy760s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51AFudfL44564780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 15:56:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5BB20043;
	Mon, 10 Feb 2025 15:56:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67CC720040;
	Mon, 10 Feb 2025 15:56:38 +0000 (GMT)
Received: from [9.171.134.37] (unknown [9.171.134.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 15:56:38 +0000 (GMT)
Message-ID: <465e4bf4-8d81-4d2f-8d50-92032e718fea@linux.ibm.com>
Date: Mon, 10 Feb 2025 16:56:39 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
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
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com>
 <20250204185121.jt5ylxsouqi5dyie@jpoimboe>
 <d2345191-0b73-4860-89be-9a189078d85e@linux.ibm.com>
 <20250207210614.nks6bxad4jhdulwg@jpoimboe>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250207210614.nks6bxad4jhdulwg@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c_VdntBFuYXB9sW5Z0uoy5rIJYlR5mAK
X-Proofpoint-ORIG-GUID: rRqaPihsbnZgi5VN3hTyR-Gv-amt3F5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100128

On 07.02.2025 22:06, Josh Poimboeuf wrote:
> On Wed, Feb 05, 2025 at 10:47:58AM +0100, Jens Remus wrote:
>> UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
>>
>> With offset_size=1 expands into:
>>
>> __UNSAFE_GET_USER_INC(/*to=*/ra_off, /*from=*cur, /*type=*/u8, /*label=*/Efault);
>>
>> Expands into:
>>
>> {
>> 	u8 __to;
>> 	unsafe_get_user(__to, (u8 __user *)cur, Efault);
>> 	cur += sizeof(__to);
>> 	ra_off = (typeof(ra_off))__to;
>> }
>>
>> The issue is that on the last line __to is u8 instead of s8 and thus
>> u8 gets casted to s32, which is performed without sign extension.  __to
>> would need to be s8 or get casted to s8 for sign extension to take
>> place.
> 
> Ah, I get it now, thanks for spelling that out for me.
> 
> Here's what I have at the moment:

Thanks!  Using your new UNSAFE_GET_USER_INC() in all places works great
on s390 when resolving the duplicate macro names (see below).

> 
> #define __UNSAFE_GET_USER_INC(to, from, type, label)			\
> ({									\
> 	type __to;							\
> 	unsafe_get_user(__to, (type __user *)from, label);		\
> 	from += sizeof(__to);						\
> 	to = __to;							\
> })
> 
> #define __UNSAFE_GET_USER_INC(to, from, size, label, u_or_s)		\

That does not compile.  One of the macros needs to be renamed.

   CC      kernel/unwind/sframe.o
kernel/unwind/sframe.c:141:9: warning: "__UNSAFE_GET_USER_INC" redefined
   141 | #define __UNSAFE_GET_USER_INC(to, from, size, label, u_or_s)            \
       |         ^~~~~~~~~~~~~~~~~~~~~
kernel/unwind/sframe.c:133:9: note: this is the location of the previous definition
   133 | #define __UNSAFE_GET_USER_INC(to, from, type, label)                    \
       |         ^~~~~~~~~~~~~~~~~~~~~

> ({									\
> 	switch (size) {							\
> 	case 1:								\
> 		__UNSAFE_GET_USER_INC(to, from, u_or_s##8, label);	\
> 		break;							\
> 	case 2:								\
> 		__UNSAFE_GET_USER_INC(to, from, u_or_s##16, label);	\
> 		break;							\
> 	case 4:								\
> 		__UNSAFE_GET_USER_INC(to, from, u_or_s##32, label);	\
> 		break;							\
> 	default:							\
> 		dbg_sec_uaccess("%d: bad unsafe_get_user() size %u\n",	\
> 				__LINE__, size);			\
> 		return -EFAULT;						\
> 	}								\
> })
> 
> #define UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label)		\
> 	__UNSAFE_GET_USER_INC(to, from, size, label, u)
> 
> #define UNSAFE_GET_USER_SIGNED_INC(to, from, size, label)		\
> 	__UNSAFE_GET_USER_INC(to, from, size, label, s)
> 
> #define UNSAFE_GET_USER_INC(to, from, size, label)				\
> 	_Generic(to,								\
> 		 u8:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
> 		 u16:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
> 		 u32:	UNSAFE_GET_USER_UNSIGNED_INC(to, from, size, label),	\
> 		 s8:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
> 		 s16:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label),	\
> 		 s32:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label))

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

