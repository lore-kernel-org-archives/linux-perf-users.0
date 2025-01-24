Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA05155303;
	Fri, 24 Jan 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736919; cv=none; b=EpXtlFTWiR/CriyjcaO3RdceHB6tMMAYK4R333xa9/C3s2maKzw4yBkVsIaVHX+5x/ZeiRmBz90G8uLjQ3gjsMWTfadVIHkpFIqxSV8GlC+ZC0ACDk2UInueCY5PqywIQWaEuGxMT5i5Ewv3/I+8jRFEvF1tJEHdfCFsPeZPyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736919; c=relaxed/simple;
	bh=6JD/U0vSCSf5FByqv5E5yVz2q0xRMgvFOC7GczCr4g4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TRlQelq9NuMKp2PMlmeE3jRPn5M7YM9d8tiLOionWWNrt8LOkNg0xPalqo9GYPVqFRwKznxZnYUm/LjwMhZVB3A7TsIrhCFWIfgBheg4Bc2NZ2f77sSB4HOdjx2GPgBWGLJRkb7RKjBxAlksVBEIPnYvIt+nNkALAKkGM1xnmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V36v+SET; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V36v+SET"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFdVMw013414;
	Fri, 24 Jan 2025 16:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lnhb1A
	kbtWKA6sF7rjVPbzyDrNEh7Hslec4w/pbF6DY=; b=V36v+SETrts5Gh5Rn8xOyq
	mMuo/zALDFv9oSfR5vjd7VisCtcrmzpL85EHR43SgHxRoLEUhWyWVZnuWPOdm8QC
	x6nTR8BuWXOwt40ouA/M2mSNXpscNG84XujPFIF8plfK4slhKPOndYc6EJJ1DxbG
	f5UE0Aurmy2tzKZkFRPinwSHjVnI9lQsKPcFWaWv6D43bM7gMGVxMxjDxFbMli27
	SpazAeBnlImfnOAVMLSQ+dkYIHztQQzxqWYX0sf8IEEA8awKO1+PnwT6pV0Kh5Wo
	4M2Y4sqXoQEGbkFyeE0C4nJzgGoJ1j7wX932PPcRFVjE93/HbiM+gtrCwyKJsavA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cdptr9rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:41:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50OGfdFO010977;
	Fri, 24 Jan 2025 16:41:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cdptr9ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:41:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFj8LF019266;
	Fri, 24 Jan 2025 16:41:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsvg3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 16:41:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OGfZjT41550316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 16:41:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 334712004E;
	Fri, 24 Jan 2025 16:41:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74ED920063;
	Fri, 24 Jan 2025 16:41:30 +0000 (GMT)
Received: from [9.171.221.90] (unknown [9.171.221.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 16:41:30 +0000 (GMT)
Message-ID: <a02d7751-2e55-47fa-8e97-c9fd803640a1@linux.ibm.com>
Date: Fri, 24 Jan 2025 17:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [PATCH v4 11/39] unwind_user: Add user space unwinding API
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
 <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wbSlex12wuwgX1COk8JMgE6oZ_9p0UQ3
X-Proofpoint-GUID: mhh1lIdnBO30qN-S9J-fB9OrNsalXKP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240116

On 22.01.2025 03:31, Josh Poimboeuf wrote:

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> +* Generic interfaces for unwinding user space
> +*/
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
> +#include <linux/unwind_user.h>
> +
> +int unwind_user_next(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame _frame;
> +	struct unwind_user_frame *frame = &_frame;
> +	unsigned long cfa = 0, fp, ra = 0;

Why are cfa and ra initialized to zero? Where is that important in
subsequent patches?

"[PATCH v4 12/39] unwind_user: Add frame pointer support" does either
unconditionally set both cfa and ra or bail out.

> +
> +	/* no implementation yet */
> +	-EINVAL;
> +}

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

