Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B251FCD1E;
	Fri,  6 Dec 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480995; cv=none; b=bIKZCfeBltlxTARwxPR/Y2nB1dt1GTQTZIic/Dc89mrhoZ72erJoWwwg1a8sVmKHdCLSLIkE9ANFSDgEJkhjHsr1d2HjmJAdMZAr2UDGgQI1qWXQPF8AfuS+fcyEOy5EIN3ri0lVYvaVgbf9DuB1VV6RPteV3gvFa6nnRipVrdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480995; c=relaxed/simple;
	bh=gp+daHvydwL9L3y98wTUrmvfaExcYO2fEUSPqFoPw7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2lDuSOFnhJFoTk8tlQmX93Yd0S1fEEJcFMGmRDcO6rVETw8Jfwwrk4VHytW4UwZho1cSuxF9ACHDchpmi7MKxZCiYa+svcdCFlUNKCZReMna3gC7wdhWANu/goICJOMOh8cN5o8lw/LIWGu62DrYResF80llzVYZARQdPsDtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n9cgGz64; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n9cgGz64"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B68HHaG010665;
	Fri, 6 Dec 2024 10:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oCucej
	0dSF5GETRmWu6mfKUjp15NQzH2Lkd2dTmLQ4U=; b=n9cgGz646TyxyuDH6BlBR4
	MRJ0kkmslRloN0Hrw4tsJAFQVbynl6TfaYfR+Urga4+gb4H6++BVnMgyvyS8ksBy
	pdWGti8ZR3x+LXJrVW1/YNHawyDWq79JWG5EXSe+Fi3bMIqnZogymPyoKleD4O9W
	DOy4NUCQvJtUZUx8QNK0wk7lFMDgmwoCPzdAA8cFiuigMC67UEvv97jS2dU2/73p
	94nhzLEVRI/PKI0IwiZdHh6DB05j9Vbt8/aUX7G7N0j4pnPad8BFu/f+nvalp2iv
	S794X5WU5DIfWUGKOdRUkx71Sk1PucXdn6ENJmXDPYQ+US9sCKjyy9Td0+RDV13A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24rgftb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:29:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6AOXTZ026632;
	Fri, 6 Dec 2024 10:29:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24rgft5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:29:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69Od0s005544;
	Fri, 6 Dec 2024 10:29:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1x9m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:29:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6ATMxZ17301834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 10:29:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5E9520040;
	Fri,  6 Dec 2024 10:29:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D786820049;
	Fri,  6 Dec 2024 10:29:20 +0000 (GMT)
Received: from [9.171.37.165] (unknown [9.171.37.165])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 10:29:20 +0000 (GMT)
Message-ID: <978a9ecd-47e9-442b-8daa-aee8f3d93dbb@linux.ibm.com>
Date: Fri, 6 Dec 2024 11:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/19] unwind: Add user space unwinding API
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
 <f89a9137e983902f22611e5379606062a64b2382.1730150953.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <f89a9137e983902f22611e5379606062a64b2382.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k71KKQ7DK_6bqgXO1_8PxnshXvpZGltg
X-Proofpoint-ORIG-GUID: MS5ESTP1TIaET9Dps_VkxhOz71J-7aO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060076

On 28.10.2024 22:47, Josh Poimboeuf wrote:
> Introduce a user space unwinder API which provides a generic way to
> unwind user stacks.

...

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

...

> +int unwind_user_next(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame _frame;
> +	struct unwind_user_frame *frame = &_frame;
> +	unsigned long prev_ip, cfa, fp, ra = 0;
> +
> +	if (state->done)
> +		return -EINVAL;
> +
> +	prev_ip = state->ip;
> +
> +	switch (state->type) {
> +	case UNWIND_USER_TYPE_FP:
> +		frame = &fp_frame;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
> +
> +	if (frame->ra_off && get_user(ra, (unsigned long __user *)(cfa + frame->ra_off)))
> +		goto the_end;
> +
> +	if (ra == prev_ip)
> +		goto the_end;

This seems too restrictive to me, as it effectively prevents
unwinding from recursive functions, e.g. Glibc internal merge sort
msort_with_tmp():

$ perf record -F 9999 --call-graph fp /usr/bin/objdump -wdWF /usr/bin/objdump
$ perf script
...
objdump    8314 236064.515562:     100010 task-clock:ppp:
                  100630a compare_symbols+0x2a (/usr/bin/objdump)
              3ffb9e58e7c msort_with_tmp.part.0+0x15c (/usr/lib64/libc.so.6)
              3ffb9e58d76 msort_with_tmp.part.0+0x56 (/usr/lib64/libc.so.6)
[unwinding unexpectedly stops]

Would it be an option to only stop unwinding if both the IP and SP do
not change?

if (sp == prev_sp && ra == prev_ra)
	gote the_end;

> +
> +	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +		goto the_end;
> +
> +	state->sp = cfa;
> +	state->ip = ra;
> +	if (frame->fp_off)
> +		state->fp = fp;
> +
> +	return 0;
> +
> +the_end:
> +	state->done = true;
> +	return -EINVAL;
> +}

...

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

