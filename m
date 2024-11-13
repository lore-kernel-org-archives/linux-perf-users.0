Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A831E00A0;
	Wed, 13 Nov 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513418; cv=none; b=SaBZtjihVR27bVWsvDwUPy0+Q6ROTTR7XuS6HgvVs3EmEKNeuPLehiIdk9PlH7kb00E8hhyeWsjgLuG7uP7sVkyLRE7tG52L67dFmmO1LuYLUsEKvEZKR3M3eycygfr2Tat5sQ57ffWZb9ot5euOXPwJToaERGEj50lE8jMDDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513418; c=relaxed/simple;
	bh=5lpp9rExTTYt02p7tdymSALmkbgwkqVm/qZGlFE/iR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IO6NGLj6G86MFS4wIQHNx+vtoZuNQRCDmGx3/geXSGGZhV96tNOpSgmp1jT9+YtkHEOa5L2yVv+fdHm4CKlpXoXT+bfHlReJQnk7VZLXg10S8FItPjUD8A2s1VKfj/9QikHvEVjYLJnqsAT2L4lTA2StHlboFdiyiTc/mp07LXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aYeJyucz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aYeJyucz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADFeEe8022320;
	Wed, 13 Nov 2024 15:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n+TVq1
	pD+9x2QU1nafM68IWIYyIXtJOw0KJ82x9nZjE=; b=aYeJyuczJd6T6yeCisZmX4
	tDSHNu1bbQzbVpKQgGXuB7H4EFb6AoFR6zS622aubrwoDrPeeXSdwW/RS9KlC4Nw
	VVK5vGQBbUCZv5BuCm7CB3OW7QtUmoWwh2fWFVChReOLw8w/rDXjakpMfnTk8GTa
	3q+ZbFi4o8woZVdVi1wWK1+S0mr+73TsSG6oX3FDpfwm6+uuq8cWzewE7UX6R1aO
	bVzM2LRM8pKs9QvzVLTEfpZuBJtv3G76kDlGyVjz6wQE9z8t/WWER8k0Eim8hk1x
	6wpWNUxChWcH9VkchsmGqBcj282fTmBbG4CkFqTB5x8pHEyPhzLOwOy7sxu+0tow
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vxxxg283-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:56:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ADFuSo0027279;
	Wed, 13 Nov 2024 15:56:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vxxxg280-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:56:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEpHG8029707;
	Wed, 13 Nov 2024 15:56:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjm5myk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:56:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADFuPhu55247346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:56:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EE4F20043;
	Wed, 13 Nov 2024 15:56:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2971520040;
	Wed, 13 Nov 2024 15:56:25 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 15:56:25 +0000 (GMT)
Message-ID: <23ff3782-c192-43eb-99c2-fe2746da7d4c@linux.ibm.com>
Date: Wed, 13 Nov 2024 16:56:25 +0100
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
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BcTPWjRTduHIgWCEk-kqeckBMorC6Sek
X-Proofpoint-GUID: M-DQ_R7AEyiEdfgszaYIg-2XjMWIKiNA
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130131

On 28.10.2024 22:47, Josh Poimboeuf wrote:

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

> @@ -68,7 +83,12 @@ int unwind_user_start(struct unwind_user_state *state)
>   		return -EINVAL;
>   	}
>   
> -	state->type = UNWIND_USER_TYPE_FP;
> +	if (current_has_sframe())
> +		state->type = UNWIND_USER_TYPE_SFRAME;
> +	else if (IS_ENABLED(CONFIG_UNWIND_USER_FP))

The test must be for CONFIG_HAVE_UNWIND_USER_FP. :-)

> +		state->type = UNWIND_USER_TYPE_FP;
> +	else
> +		state->type = UNWIND_USER_TYPE_NONE;
>   
>   	state->sp = user_stack_pointer(regs);
>   	state->ip = instruction_pointer(regs);

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

