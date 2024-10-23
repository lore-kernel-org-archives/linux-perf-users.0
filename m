Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5D159583;
	Wed, 23 Oct 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689837; cv=none; b=ULw1tVQj4xHOW3vqnpvI7nuchWuNjSYnC7dNiINFHZTomKBXKWbeTC/dItxNDVW51vyBrFBtkTWFsF0+rfPFxTg8F+bYRDROFfpWEewfIrHbQHgoJKN2pe0ZrDQr0aXCpMYjrTw+3gMIiSjVtRze+scrnuYKJzErbc0/t0KNIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689837; c=relaxed/simple;
	bh=I0Hyu34jyHeLojhuCy3w9k6U0crQK/lJ5oAZeTWQCWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jYKnZZnk51TJ8s8m6DQ0BjaDM2leakI4kGU6CumKhEwVzWRQw/JnqB13Etey5X9Q/2fbxImok4//7rAlTxqyLsi2pX1rz73RqmnQJgAs50wQaabkrpwOiMZ6a5NV7m/UfT8PWkTSzdmqE5MMpSCvh6GruXyYVs6kgxE3JL8lYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IV+bwe7V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IV+bwe7V"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0Nh6I026402;
	Wed, 23 Oct 2024 13:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vJg1bk
	avrTLKEXxCZ9zowc0UhQBaAQn+MJDsKXfxz88=; b=IV+bwe7VYnAmv5eW+0rOi6
	/uRl9uuA9SDiXQDF1t0mwGjHNVnKdHfSyd0wIwrzP6dI2vtzwoIbjgPqI2xXG64O
	cTtH7u7RbUFtpi+swi2EzTOb2/HAB5X9XXpuot0btiyz4sEXS+IzIpPD7FkFqlyI
	DhnI9gL8QVIAC/WaKcUihYDjo7Qh9tlzLRln96U7Xfm8XMdS9p2m9u/a1nMhlteo
	IRywupcSB5efuWwRToIlfG5kcxpEve29rWoET8zVS+OtWwO2xkDmnzgwuePvWKr5
	/uDTfDYIV6oeCVvfjLo2XfQZejKVmngOKv/t+nJfECOQ7x73fi91/pLZGaLl+1oQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaeu56y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:22:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NDMf5Y023055;
	Wed, 23 Oct 2024 13:22:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaeu56r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:22:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBd1OM006876;
	Wed, 23 Oct 2024 13:22:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjcu05p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:22:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NDMa9w12517846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:22:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2A9F20043;
	Wed, 23 Oct 2024 13:22:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB9B20040;
	Wed, 23 Oct 2024 13:22:36 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 13:22:36 +0000 (GMT)
Message-ID: <a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>
Date: Wed, 23 Oct 2024 15:22:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
To: Josh Poimboeuf <jpoimboe@kernel.org>
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
        Sam James <sam@gentoo.org>, x86@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CbKkWjQt_IG-VjY2iv7kvICH6O_fLFr4
X-Proofpoint-ORIG-GUID: xF3R5-d-c-t6j991y49RVnVzG6pCV48Z
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230079

Hello Josh!

On 14.09.2024 01:02, Josh Poimboeuf wrote:
> This is a new version of sframe user space unwinding + perf deferred
> callchains.  Better late than never.

...

> These patches add support for unwinding user space from the kernel using
> SFrame with perf.  It should be easy to add user unwinding support for
> other components like ftrace.

...

We are looking forward to implement support for unwinding of user space
using SFrame in kernel/perf on s390. One major concern is that your x86
implementation currently relies on a fallback to unwinding using frame
pointer. On s390 unwinding using frame pointer is unsupported, because
of lack of proper s390x ABI [1] specification and compiler support. In
theory there would be a s390-specific alternative of unwinding using
backchain (compiler option -mbackchain), but this has limitations and
there is currently no distribution where user space is built with
backchain.

How much of an issue would it be if s390 could not provide an unwinding
fallback implementation? Do you see the possibility to get away without?

For s390 support of unwinding using SFrame we would need to make a few
changes to your generic unwinding framework in the kernel:

- Support for architectures that do not define CFA == SP at callsite:
   On s390 the CFA is defined as SP at callsite +160. The stack pointer
   (SP) therefore unwinds as SP = CFA - 160. For that we would introduce
   e.g. a sp_val_off field (SP value offset from CFA) in struct
   user_unwind_frame that would default to 0 on all architectures except
   s390.

- Support for architectures where RA is not necessarily saved on stack:
   On s390 the return address (RA) is not saved (on stack) at function
   entry. In leaf functions it is not necessarily saved at all.

- Support for architectures were RA/FP are saved in registers in leaf
   functions:
   On s390 the frame pointer (FP) and return address (RA) registers can
   be saved in other registers when in leaf functions. In the SFrame
   format we would encode the DWARF register number as offset using the
   least-significant bit as indication: offset = (regnum << 1) | 1.
   Therefore we would need to extend your generic unwinding framework to
   support FP and RA to be restored from registers.

[1]: s390x ELF ABI supplement,
      https://github.com/IBM/s390x-abi/releases

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

