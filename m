Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049B199E89;
	Wed, 11 Dec 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928843; cv=none; b=nI4zG3uiPBL6qcz3g5jnVdKrRKJhJmQoKEVdQk5pAHCROkYYoqsM7zGWO2pm5qzP0i0vmoXILY5StTD4dd4RXJjIdUxEzhfvZfGMXVLtaOpOkiQ5MF+pIbtI2a8vVmr7lQZUfVaA6+8MY1z2P2bq4pctmRvXDdty+2KlAQOO2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928843; c=relaxed/simple;
	bh=EsdWYItaDbv6MpANJlsjKfpBA98nwzifcsQrBKHC2KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYBPtS6LWMCMoHO9NcQ2rmHPdq7xPXJECyAk2PCynu6DNhow0wMduJXNsz5ryrjIDJKwzqHwoyC7hskgJ1JcE5k6WlyTucikTP9hpAb87VWSCHoNnsk0qIfsZ1kiLNRg6upgFTHCFlFV9ROiC0uzQCd9787cENu4dp9Lk0nSyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MdIF3ycy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MdIF3ycy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBxlSA006028;
	Wed, 11 Dec 2024 14:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sZ+Iop
	A4yI8kINnVSPAUU6Ni8euaYM3axdVMOUtClZg=; b=MdIF3ycygfusMzU220qs47
	U8KzrEeU4+JC11N5dlLdhDVsqHv2s+obYgBRtUZhCyzX4u5tQxR4LChuvKAiTxw6
	4e+q6+0ZYUq+oo+ajPaJknlkNYV1NtR1j4aERZYZ14+9oirOz4gkb0xqIfJUqtl5
	GXF/EZkPYaBpvNsT9U+dbfwh7ANhpUhgZx3CEJAJdJRuiUEAUEVTm0tK/8lATY+J
	qYwJ43ikGbHHp6R/qhJZu4hUgSFa58hM/OAh3KruVkmD2jSj5sBvRqeJDbg3VtT/
	99snkrATbWIuBkoVaASEGQcopxa6pjCjJBPuRbW6mYx7wqEZJnQNY/MqoBAxfTRA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vwy6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 14:53:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBElXti032718;
	Wed, 11 Dec 2024 14:53:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vwy6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 14:53:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBEIIPE023015;
	Wed, 11 Dec 2024 14:53:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wk1qvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 14:53:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBErSxS47776134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 14:53:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3DC82004B;
	Wed, 11 Dec 2024 14:53:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DF320043;
	Wed, 11 Dec 2024 14:53:27 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 14:53:27 +0000 (GMT)
Message-ID: <c74dc535-a09d-48bc-816e-7e465211fa64@linux.ibm.com>
Date: Wed, 11 Dec 2024 15:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/19] unwind: Add user space unwinding API
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
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <f89a9137e983902f22611e5379606062a64b2382.1730150953.git.jpoimboe@kernel.org>
 <978a9ecd-47e9-442b-8daa-aee8f3d93dbb@linux.ibm.com>
 <20241209205458.vzwkh3ubch5sx5c7@jpoimboe>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20241209205458.vzwkh3ubch5sx5c7@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ThWuWFgKpZIZrFlAjEK9-oZRgBM8WVcv
X-Proofpoint-ORIG-GUID: 9nDJ2rh3r0Dv2SQrziE9E-0XYILoEpYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=977
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110105

On 09.12.2024 21:54, Josh Poimboeuf wrote:
> On Fri, Dec 06, 2024 at 11:29:21AM +0100, Jens Remus wrote:
>> On 28.10.2024 22:47, Josh Poimboeuf wrote:
>>> +	if (ra == prev_ip)
>>> +		goto the_end;
>>
>> This seems too restrictive to me, as it effectively prevents
>> unwinding from recursive functions, e.g. Glibc internal merge sort
>> msort_with_tmp():
>>
>> $ perf record -F 9999 --call-graph fp /usr/bin/objdump -wdWF /usr/bin/objdump
>> $ perf script
>> ...
>> objdump    8314 236064.515562:     100010 task-clock:ppp:
>>                   100630a compare_symbols+0x2a (/usr/bin/objdump)
>>               3ffb9e58e7c msort_with_tmp.part.0+0x15c (/usr/lib64/libc.so.6)
>>               3ffb9e58d76 msort_with_tmp.part.0+0x56 (/usr/lib64/libc.so.6)
>> [unwinding unexpectedly stops]
>>
>> Would it be an option to only stop unwinding if both the IP and SP do
>> not change?
>>
>> if (sp == prev_sp && ra == prev_ra)
>> 	gote the_end;
> 
> Good point, I've already fixed that for the next version (not yet
> posted).  I believe the only thing we really need to check here is that
> the unwind is heading in the right direction:
> 
> if (cfa <= state->sp)
> 	goto the_end;

Assuming the x86 definition of the CFA (CFA == SP at call site) this
translates into:

if (sp <= state->sp)
	goto the_end;

That won't work for architectures that pass the return address in a
register instead of on the stack, such as s390. At least in the
topmost frame the unwound SP may be unchanged. For instance when in
the function prologue or when in a leaf function.

One of my patches for s390 support introduces a state->first flag,
indicating whether it is the topmost user space frame. Using that
your check could be extended to:

if ((state->first && sp < state->sp) || (!state->first && sp <= state->sp))
	goto the_end;

Which could be simplified to:

if (sp <= state->sp - state->first)
	goto the_end;

Btw. neither would work for architectures with an upwards-growing
stack, such as hppa. Not sure if that needs to be considered.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

