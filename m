Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13522A4E4;
	Wed,  5 Feb 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748943; cv=none; b=XNCe+74KH4c0d+vDpMS4ygJrOxb5NhQM+xKa8XwvnlbxI+TXPHUVlDudOCfSoDpv2D6WD5oAZ3UH/w6cCvt7MwP/rSPY4MQN3sJP4O3fHis+CBsfs3RhaTo9sEooNfRL/6+vLJBeQyonGIJxfwBeqgb0dcWz7jO8F1CIo73iIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748943; c=relaxed/simple;
	bh=xRu2zg0ybR/jC1c8Z/n8MS6efWbFo0dqhH3MX4A/TJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+7qBjCMoQmW5BtH6b8emIdr8TcT55XWrAyc1/GZBaVxy1EQpXKH3kGigCmcQKsuj3srxu1imkLvXqdckl6yS5pyqvDSVDjcAM3m4xOVH3+85L+5k5NsW0Tqhmhkfz/HlbfO4QK9ehZnHd8Km/JMC2MT9KZwLi/OXWSrV9TM/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WcXcs2CE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WcXcs2CE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51555xZk023240;
	Wed, 5 Feb 2025 09:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KoMTPO
	fTGUJ3D7aK/EXCHQAUdLgDeta4XBrLWtEwo3E=; b=WcXcs2CEHSIrNoXmduEdut
	rqzbq1ijTeYZKtQKJbhlYlB+uGOkGAh6Yl0rqwtP5JbHfOlNGVHuWiw8CM8Wzj9R
	ign2wmmqGaQXuj/hLsqhkmDayGd5zmfRt3MKMF/FkDocehrPrNfkrh/G23VZ0pe1
	2hYeZd04+hC5f/MIjAQJGEp8xle/4CqFmKLPhiIC4mQX5O+xYU8I0LzEp4A892+a
	Z4979ZOC3vuXi1KkNcLYOUksX021UYR56GCrGxfARUR+oJo7QrfdE8Zi8MV3Eha4
	OmHclJL18R3udhdUVh6OtZsUUWaOhC+5mzLM1zOYjXIo9ElOuJVus6MyR9ALcW5g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62mv8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:48:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5159jlkt011948;
	Wed, 5 Feb 2025 09:48:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62mv8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:48:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5158aLBw024461;
	Wed, 5 Feb 2025 09:48:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn8470-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:48:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5159m0lq45351422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 09:48:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D2F520040;
	Wed,  5 Feb 2025 09:48:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC0F32004F;
	Wed,  5 Feb 2025 09:47:58 +0000 (GMT)
Received: from [9.171.163.71] (unknown [9.171.163.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 09:47:58 +0000 (GMT)
Message-ID: <d2345191-0b73-4860-89be-9a189078d85e@linux.ibm.com>
Date: Wed, 5 Feb 2025 10:47:58 +0100
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
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250204185121.jt5ylxsouqi5dyie@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JUYyYdunAg3NquC3r-liJGhpDvkhnBnN
X-Proofpoint-ORIG-GUID: FHoTaAZdZ0mVaiD_50taZTUqn4mKyl5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050075

On 04.02.2025 19:51, Josh Poimboeuf wrote:
> On Thu, Jan 30, 2025 at 04:47:00PM +0100, Jens Remus wrote:
>> On 22.01.2025 03:31, Josh Poimboeuf wrote:

>>> +#define __UNSAFE_GET_USER_INC(to, from, type, label)			\
>>> +({									\
>>> +	type __to;							\
>>> +	unsafe_get_user(__to, (type __user *)from, label);		\
>>> +	from += sizeof(__to);						\
>>> +	to = (typeof(to))__to;							\
>>> +})
>>> +
>>> +#define UNSAFE_GET_USER_INC(to, from, size, label)			\
>>> +({									\
>>> +	switch (size) {							\
>>> +	case 1:								\
>>> +		__UNSAFE_GET_USER_INC(to, from, u8, label);		\
>>> +		break;							\
>>> +	case 2:								\
>>> +		__UNSAFE_GET_USER_INC(to, from, u16, label);		\
>>> +		break;							\
>>> +	case 4:								\
>>> +		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
>>> +		break;							\
>>> +	default:							\
>>> +		return -EFAULT;						\
>>> +	}								\
>>> +})
>>
>> This does not work for the signed SFrame fields, such as the FRE CFA,
>> RA, and FP offsets, as it does not perform the required sign extension.
>> One option would be to rename to UNSAFE_GET_USER_UNSIGNED_INC() and
>> re-introduce UNSAFE_GET_USER_SIGNED_INC() using s8, s16, and s32.
> 
> See the following line in __UNSAFE_GET_USER_INC():
> 
> 	to = (typeof(to))__to;
> 
> Does that not do the sign extension?

No. In practice with my proposed changes reverted and the following
debugging code added:

@@ -293,6 +293,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
                 return -EINVAL;
         fre = prev_fre;

+       dbg_sec_uaccess("fre: ip_off=%u, cfa_off=%d, ra_off=%d, fp_off=%d, use_fp=%s, sp_val_off=%d\n",
+                       fre->ip_off, fre->cfa_off, fre->ra_off, fre->fp_off,
+                       SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP ? "y" : "n",
+                       sframe_sp_val_off());

Excerpt from dmesg:

sframe: /usr/lib/ld64.so.1: fre: ip_off=16, cfa_off=440, ra_off=208, fp_off=184, use_fp=n, sp_val_off=-160
sframe: /usr/lib/ld64.so.1: fre: ip_off=2600, cfa_off=672, ra_off=208, fp_off=184, use_fp=y, sp_val_off=-160
sframe: /usr/lib/ld64.so.1: fre: ip_off=10, cfa_off=368, ra_off=0, fp_off=0, use_fp=n, sp_val_off=-160
sframe: /usr/lib/ld64.so.1: fre: ip_off=722, cfa_off=672, ra_off=208, fp_off=184, use_fp=y, sp_val_off=-160

On s390 the register save slots have negative offsets from CFA (due to
the CFA to be defined as SP at call site + 160).  The RA, if saved,
would be saved at CFA-48 on the stack.  I.e. ra_off=-48 instead of
ra_off=208 would have been correct.

208 = 0xd0 (unsigned) = -48 (signed)


Looking at the code:

UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);

With offset_size=1 expands into:

__UNSAFE_GET_USER_INC(/*to=*/ra_off, /*from=*cur, /*type=*/u8, /*label=*/Efault);

Expands into:

{
	u8 __to;
	unsafe_get_user(__to, (u8 __user *)cur, Efault);
	cur += sizeof(__to);
	ra_off = (typeof(ra_off))__to;
}

The issue is that on the last line __to is u8 instead of s8 and thus
u8 gets casted to s32, which is performed without sign extension.  __to
would need to be s8 or get casted to s8 for sign extension to take
place.

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

