Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087B1DA5F;
	Thu, 30 Jan 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255160; cv=none; b=ckcFqLv16c7TVZnv0Ljz8I1kXmyqOWtlN9dYanzKh0mkt1IWOJQ24shUZx4fkOBDhua8q0/MEK9FQKwq+RMQ8SJ9T6JD938WH3/bbdpPjlfKeHSFdHVOvwNE2cuKpazPtZK4rfIrW+1GYbDkoCAYi0XwwkbGInM8QS398iKC9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255160; c=relaxed/simple;
	bh=0Isufwi/Vgl2B6yLxZbTuWN6WZZj84rWZAtmvqaHWIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2EZ5VO3rPCFI3OYOCYWMWMq3DUSJT//QX2Vadlwxvoj6o8V9hj2txD+XFh+rbPJMK/+PHTEv6C4zXTFMbRDowj8jnPc1J7KG3h+CWgkypJk2LsT+Csobqg5V6p9mErIL66J7hpCy8B6JMs0wE4xWNNSot+5KZuYNH9VbcvdFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IBUG4ShM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IBUG4ShM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UFdQAe010027;
	Thu, 30 Jan 2025 16:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FqYKzo
	UiU8AE96roYOs5tofbhVt4DgoDku8NwKj7qTg=; b=IBUG4ShMLT4KYKAw5ij2x+
	jlQp6/oH/OVpUP4u9eR5l2vI4hj1bTW6cAPLBfavxcnM9JCq8CqhloZo0es8rIOn
	Z47yVWc16hB60rGNn748QAm81u2Sg+UJEbq2VsTqgBYPzsbfVhmDRlCRh+9q7O19
	VluYw0SX4f6QItLEm1TotSePoEkeKAWgA/O6EJ+Nfr6fLhV9Qot5Ms9qnDJXWJh3
	YfbtuxJARcz02NG16GqKft+LHebCwO1j4eAhJ15t6Rc7QJ1vd2OH/7/OhHJGDmaY
	KkiGu3Q6ih8StWgVVGp+5s1HQ+f7xMuuQIzwRopAId1pzieTg00kMZM/v9JyPf+Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gc8tr8g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 16:38:30 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50UGbbKF005418;
	Thu, 30 Jan 2025 16:38:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gc8tr8g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 16:38:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UFAKH3012444;
	Thu, 30 Jan 2025 16:38:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44danyf4e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 16:38:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UGcP1s46006628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 16:38:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5012A20089;
	Thu, 30 Jan 2025 16:38:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C265520088;
	Thu, 30 Jan 2025 16:38:24 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 16:38:24 +0000 (GMT)
Message-ID: <b0193d69-d328-432d-86af-54fac7cef711@linux.ibm.com>
Date: Thu, 30 Jan 2025 17:38:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/39] unwind_user/sframe: Enable debugging in uaccess
 regions
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
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <990b28ae7855b67c5e6d6385b9de78ffa336dd73.1737511963.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <990b28ae7855b67c5e6d6385b9de78ffa336dd73.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K_c2hM8ukamBh75YQApb_Rgur0BqSUJI
X-Proofpoint-GUID: WtxoNUNAKifqK37qQW2DZUi8svSipZdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_07,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=959 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300125

On 22.01.2025 03:31, Josh Poimboeuf wrote:
> Objtool warns about calling pr_debug() from uaccess-enabled regions, and
> rightfully so.  Add a dbg_sec_uaccess() macro which temporarily disables
> uaccess before doing the dynamic printk, and use that to add debug
> messages throughout the uaccess-enabled regions.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

> @@ -53,12 +53,15 @@ static __always_inline int __read_fde(struct sframe_section *sec,
>   			      sizeof(struct sframe_fde), Efault);
>   
>   	ip = sec->sframe_start + fde->start_addr;
> -	if (ip < sec->text_start || ip > sec->text_end)
> +	if (ip < sec->text_start || ip > sec->text_end) {
> +		dbg_sec_uaccess("bad fde num %d\n", fde_num);
>   		return -EINVAL;
> +	}
>   
>   	return 0;
>   
>   Efault:
> +	dbg_sec_uaccess("fde %d usercopy failed\n", fde_num);
>   	return -EFAULT;
>   }

Add a similar debug message for SFRame FDE user copy failures?

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

@@ -125,6 +125,7 @@ static __always_inline int __find_fde(struct sframe_section *sec,
         return 0;

  Efault:
+       dbg_sec_uaccess("fde usercopy failed\n");
         return -EFAULT;
  }


Printing the IP is probably not an option due to security concerns?
Printing the the CFA, FP, and RA offsets is too much traffic?  To debug
issues on s390 I had to add tons of additional debug messages to make
sense of what was actually going on.

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

