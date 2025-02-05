Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0B22A4FC;
	Wed,  5 Feb 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753344; cv=none; b=LkknX81Ec+3Y6kizfvaf1LEyM29yIhmwAMtimmomPgqZ3xkg+OGhajdnZ5TEXUOaa5bel4WXHUMtmdSEY5MY68sj9C6dyeQbAhDgeWedGGAGxOUZhTKL/dABwPYCpcXpmP5c+KoxLQmOhkC4tbNK0K54w57CxBwqLOk813021ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753344; c=relaxed/simple;
	bh=21iZlA3+pBUERxi/Phwgzt2HE4TTIA44xavTnIvfDhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgEcNvunNB4NDrcf+tjuBz6kA0Vq5enMRQUI/Mj7xj/ORlyOKJMJ73DakZlIZyCCOYNJTmAM1aD9Nker+fKsPby/hMrARUnm4Wfqur5UMz9D/y1JiiOs2sNJNw0hgkIDYmEgYQpDT8i1rcfuSYlqT6ZKv41gv8RwpBd7gzc7Tr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rFPyKt5N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rFPyKt5N"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5153ZgaO028577;
	Wed, 5 Feb 2025 11:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rIsNwe
	JAGDoYvayRmwL0H3ULsnZKE6A2R6leZJKDpaQ=; b=rFPyKt5NKlIDZPhbtEkiLi
	99s6/XGfhLSDsCAQksAJhbJSF99E6B/Dv9hgYmUUTrLFeWUkmLl28gNSCZ4pigs8
	K64bJTiNejHnCUxPHOrJ24hpKdvERkzX+DJ371iX8+pHEQ1WfexlWV2giQqriK8w
	Hbl0+dDnkeoKFu0m/En5R4ztUNLkx42249TXKCzKh05DxV5Nz6+XDBY8c7PMc4z2
	WYIGmdOaqRVWwN4etEEwwUpYoI3UBWlPcjkrl+Sge45f3gIWsp3ThxQGp/NMWvFt
	UnutCCp49/em8xhWyuCvhE/YM17XLMWabdAek9AFOHN1SzbXVTsQj/gtX7J4X5mQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtvmv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 11:02:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515AmEmW003041;
	Wed, 5 Feb 2025 11:02:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtvmv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 11:02:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515947qx006543;
	Wed, 5 Feb 2025 11:01:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekgad3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 11:01:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515B1vq735128056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 11:01:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4306B20063;
	Wed,  5 Feb 2025 11:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 551CB20043;
	Wed,  5 Feb 2025 11:01:56 +0000 (GMT)
Received: from [9.171.163.71] (unknown [9.171.163.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 11:01:56 +0000 (GMT)
Message-ID: <0837be81-ec2e-4dac-bc42-91c626c22b9a@linux.ibm.com>
Date: Wed, 5 Feb 2025 12:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TIaRcJkInjtllFxr2tjyWifseTZRUQWg
X-Proofpoint-ORIG-GUID: n0QAURNQRXXTJmkGluYOqBZgqxUv06jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050088

On 28.01.2025 02:10, Andrii Nakryiko wrote:

> So, currently in v2, FREs within FDEs use an array-of-structs layout.
> If we use preudo-C type definitions, it would be something like this
> for FDE + its FREs:
> 
> struct FDE_and_FREs {
>      struct sframe_func_desc_entry fde_metadata;
> 
>      union FRE {
>          struct FRE8 {
>              u8 sfre_start_address;
>              u8 sfre_info;
>              u8|u16|u32 offsets[M];
>          }
>          struct FRE16 {
>              u16 sfre_start_address;
>              u16 sfre_info;
>              u8|u16|u32 offsets[M];
>          }
>          struct FRE32 {
>              u32 sfre_start_address;
>              u32 sfre_info;
>              u8|u16|u32 offsets[M];
>          }
>      } fres[N] __packed;
> };
> 
> where all fres[i]s are one of those FRE8/FRE16/FRE32, so start
> addresses have the same size, but each FRE has potentially different
> offsets sizing, so there is no common alignment, and so everything has
> to be packed and unaligned.

Just for clarification of the SFrame V2 format, as there may be some
misconception. Using pseudo-C type definition:

struct sframe_fre8 {
	u8 sfre_start_address;
	u8 sfre_info;
	s8|s16|s32 offsets[M];
};
struct sframe_fre16 {
	u16 sfre_start_address;
	u8 sfre_info;
	s8|s16|s32 offsets[M];
};
struct sframe_fre32 {
	u32 sfre_start_address;
	u8 sfre_info;
	s8|s16|s32 offsets[M];
};

struct sframe_section {
	/* Headers. */
	struct sframe_preamble preamble;
	struct sframe_header header;
	struct sframe_auxiliary_header auxhdr;

	/* FDEs. */
	struct sframe_fde fdes[N_FDE];

	/* FRE8s / FRE16s / FRE32s per FDE. */
	struct sframe_fre{8|16|32} fres_fde1[N_FRE_FDE1] __packed;
	...
	struct sframe_fre{8|16|32} fres_fdeN[N_FRE_FDEN] __packed;
};

Where:
- fdes[] can be binary searched: All fdes[i] are of equal size and
   sorted on start address.
- Each fdes[i] points at its fres_fdei[].
- fres_fdei[] cannot be binary searched: For each fdes[i] they are
   one of those FRE8/FRE16/FRE32, so start addresses have the same
   size, but each FRE has potentially different offsets sizing, so
   there is no common alignment, and so everything has to be packed
   and unaligned.

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

