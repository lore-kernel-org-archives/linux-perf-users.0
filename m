Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7114A630;
	Wed,  5 Feb 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763854; cv=none; b=J0yH4oaj3ceRmLMYd/+xs2PBNkY/e68t3EAu6JcEe9+SwAPICVNcuqokohQBQMqi89tD5CX4B67o0+tQt04As9WyAofqEry2lP9o6tqTMLWGd7S9An/MxhnpijAi82rr9fNi2rdlEuXuJLx6UVEoJZyKRbepqIc1OthE/L2KXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763854; c=relaxed/simple;
	bh=CuN4O/okRhmL3T/tFN3PX7Pjjfe6bHksYyoSXflNtyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHrQUX63lSDXDUVGyGOcT+fpzYH9/29iv0larrEsVb/Bd8TGGtKR2CEL5+rGRJEWTF83sgKDoe7deT91i25vddXNf4tz7eV2w+WDCgCa5W9hPus1sw0XUbG7YNiND/kE5w/AB3ghmRjVH68Qi7o4KUSWhjRYOMTdgFD+bPAx8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pR5o6rFl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pR5o6rFl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515DZE6l001123;
	Wed, 5 Feb 2025 13:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0NQVCW
	7ciVcsY6yIsEmBk8qk7Ck7u9JVtbUaIlIbdlA=; b=pR5o6rFlCSP4fu40C4ahwc
	wwAMudaG/LpU9mfik7Q7L4rLpcuUsWhJ1SFrw0ZEb3cnigUz32rpfuTlrikqSozK
	i5U5+cnfa+YBX2hI1pdt0zEy9MGwxseHIedbz+PeMcRzVG1T3jeWr71xeIvbitAy
	VKoLRh6xkEfeO+fGh6C3vxJf25Er8IPeb9ggvMy5SCUxOTvHLoHIM3Q5WUHd0PWT
	TE7YXtc85HUYBupRt12BNDHvTaHnKv7aeUW7IQZutG64ffezWcV9rZCkoOwwpMg/
	IwtTUn95Ogv8qieS5mZbMO57cACZt5p8+P449/qIjFzlBfexSwYUf48kp+5gsj0Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m1t82c9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:56:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515Dqmrt008327;
	Wed, 5 Feb 2025 13:56:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m1t82c9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:56:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515CO4pK007139;
	Wed, 5 Feb 2025 13:56:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxays46t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:56:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515DucM948693620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 13:56:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BDA2004B;
	Wed,  5 Feb 2025 13:56:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4B3C20043;
	Wed,  5 Feb 2025 13:56:37 +0000 (GMT)
Received: from [9.171.165.127] (unknown [9.171.165.127])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 13:56:37 +0000 (GMT)
Message-ID: <9a726893-4973-40f0-a2b5-63b2036e2e4e@linux.ibm.com>
Date: Wed, 5 Feb 2025 14:56:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
 <20250129020249.owmklacvuvss7z7n@jpoimboe>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250129020249.owmklacvuvss7z7n@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FoeKv70vsKAME6cJt7w4lE4LUboDqNi8
X-Proofpoint-ORIG-GUID: UmYpWnbvFFL0sEps-RqOV8VpRzmTO1NE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050108

On 29.01.2025 03:02, Josh Poimboeuf wrote:

> Note FDEs aren't even needed here as the unwinder doesn't need to know
> when a function begins/ends.  The only info needed by the unwinder is
> just the fre_data struct.  So a simple binary search of fres[] is all
> that's really needed.

In SFrame V2 FDEs specify ranges bound by function start address and
length.  FREs in contrast specify open ranges bounded by start address.
Their effect ends either with the next FRE becoming into effect or when
their FDE range ends.
This concept enables holes in the .text section which do not have any
valid FDE/FRE information associated.

Your proposal lacks some sort of mechanism to replicate those holes.
It could be FDEs with a flag (or no offsets?) that specifies their
range has no valid information.

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

