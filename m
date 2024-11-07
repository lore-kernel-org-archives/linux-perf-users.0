Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943120EA31;
	Thu,  7 Nov 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998810; cv=none; b=SML7pAU3vCDD/JnYPuvk8m8b1cb30R3krAF7gAiRP8m/+twuAW1LIWp0PJwH6ItGDVBzVykkO34iseN3+HuPVtJ0VE8w6ZT8R9Ar0kMFrQJFzQdCYGIZ96MAcXzLOhyDOiSlX7h4NARplRrF7pKNYl+4niFP/WvDwHPXoV85BZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998810; c=relaxed/simple;
	bh=3y7x3t5gVFxOW6z3Jq8Cosco9ze83OAiKthqUh4vERE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uGl6vFVyR+ea3F2I8XziV7a68aHlHOmcVyQMknk8b3wVRjO3Ralbc1ygvVPJYtJU7LyQvFWFfWdmTH8M7OY3wVB4KKE4bSkJ8//OiXATtZoA6wXqFze47jRsvJbjKVk5koI+vB80nCF5yezslIERJdaHF2khkZU/ZdWBbrnKHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JCU8k+Mm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JCU8k+Mm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7GAD2Q015652;
	Thu, 7 Nov 2024 16:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WXFoL5
	zwptAunsfgZklfDDu9wxucMsjwItFltAGzzEE=; b=JCU8k+MmS2s37V0BfkwHRm
	sMk1q/mKung6ovNW5wFht6yAwPNgEntPFm0dgEQoURCe80BesHE+gS+ecQamPUD+
	tzQ1zRGjKBATBnnLR+vDt+wtQutbWD3kx3yDMHTPQGlWQY3jurOxXAvVho5mIEJt
	hPSaf/+NgQEjL4LJpN4PCYYLwFQsCfOkIFLc9RY678hDuztAjVnqF0mI94kXDK6s
	HNkP97IGnjdbs+J58+YzArrvAJal4NyMHMQNxeR9N3WZQiCGtGEA7imgJXCmanHS
	oxXXCKXO4Hwm36SBuXPOuXMZCDc319DGXIh7UPP0N/BMd6PrjDvO9ojhjk+/8V5A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s0u106vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 16:59:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7GxEYk020254;
	Thu, 7 Nov 2024 16:59:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s0u106vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 16:59:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DPaq1012237;
	Thu, 7 Nov 2024 16:59:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p1410g0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 16:59:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7Gx9Za34800160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 16:59:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1A220043;
	Thu,  7 Nov 2024 16:59:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F328220040;
	Thu,  7 Nov 2024 16:59:08 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 16:59:08 +0000 (GMT)
Message-ID: <1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
Date: Thu, 7 Nov 2024 17:59:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Content-Language: en-US
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
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D6BC3dfdxaCvSOwDYqIlspUzLTj5G94D
X-Proofpoint-ORIG-GUID: s0m_uslS-RNTtw7xnE1ZGot58aLVATYM
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411070129

On 28.10.2024 22:47, Josh Poimboeuf wrote:
...
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
...
> +static int find_fde(struct sframe_section *sec, unsigned long ip,
> +		    struct sframe_fde *fde)
> +{
> +	struct sframe_fde __user *first, *last, *found = NULL;
> +	u32 ip_off, func_off_low = 0, func_off_high = -1;
> +
> +	ip_off = ip - sec->sframe_addr;
> +
> +	first = (void __user *)sec->fdes_addr;
> +	last = first + sec->fdes_nr;

Could it be that this needs to be:

	last = first + sec->fdes_nr - 1;

> +	while (first <= last) {
> +		struct sframe_fde __user *mid;
> +		u32 func_off;
> +
> +		mid = first + ((last - first) / 2);
> +
> +		if (get_user(func_off, (s32 __user *)mid))
> +			return -EFAULT;
> +
> +		if (ip_off >= func_off) {
> +			/* validate sort order */
> +			if (func_off < func_off_low)
> +				return -EINVAL;

Otherwise I run into this when the IP is within the function whose FDE 
is the last one in the .sframe section:

find_fde: IP=0x000000000110fbcc: ERROR: func_off < func_off_low 
(func_off=196608, func_off_low=4294224904)

110fbcc dump_sframe+0x2ec (/opt/binutils-sframe2/bin/objdump)

func idx [2275]: pc = 0x110f8e0, size = 3310 bytes <dump_sframe>
STARTPC         CFA       FP        RA           INFO
000000000110f8e0  sp+160    u         u            (1*1B)
000000000110f8e6  sp+160    c-72      c-48         (3*1B)
000000000110f8f6  sp+632    c-72      c-48         (3*1B)
000000000110fa82  sp+160    u         u            (1*1B)
000000000110fa88  sp+632    c-72      c-48         (3*1B)
0000000001110486  sp+160    u         u            (1*1B)
000000000111048c  sp+632    c-72      c-48         (3*1B)
0000000001110574  sp+160    u         u            (1*1B)
000000000111057a  sp+632    c-72      c-48         (3*1B)

> +
> +			func_off_low = func_off;
> +
> +			found = mid;
> +			first = mid + 1;
> +		} else {
> +			/* validate sort order */
> +			if (func_off > func_off_high)
> +				return -EINVAL;
> +
> +			func_off_high = func_off;
> +
> +			last = mid - 1;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	if (copy_from_user(fde, found, sizeof(*fde)))
> +		return -EFAULT;
> +
> +	/* check for gaps */
> +	if (ip_off < fde->start_addr || ip_off >= fde->start_addr + fde->size)
> +		return -EINVAL;
> +
> +	return 0;
> +}

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

