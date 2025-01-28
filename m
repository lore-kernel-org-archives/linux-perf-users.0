Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AC19DF4F;
	Tue, 28 Jan 2025 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061461; cv=none; b=XmE3DsA75kEXsX+uDyK+s6eN1QfnR/5n/jBpOC6FtmK62ymrAtEVKVm4xjq3hk+eZkbBlqoCh7AtUz6NpNWwDxMGvIVSxLPdHPc1V8TQYInRf75dpmVlAJq5jz5DpBf6it7XL/Fl55pApnofHnvSUwdf2cpjXiB7pggNYhu9jXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061461; c=relaxed/simple;
	bh=Fmckq6eLrCsTVvHraxN+jtJZV3xsnJsHxJ1AoOqAMMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7JHwYaci7pNxYekQV3OFV1JdqgWNbpugV6Gzev3qrpgBoLeCbbqT3nI5gmNa1yxyZ6ZGKkELw6tgL4gux12IdIxQM/VlrDXY9TpiTPH47HLuRxQ4VxXINWVAv+v/6s3l7ca2PqRnbL8antb1ZIMKJ2LjEvoHfqlo2obh7dlWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QMBIsfhd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QMBIsfhd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLIScW009888;
	Tue, 28 Jan 2025 10:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NrNcpE
	fDgCysWZuUGE5E/DhhI7cTkATbuiP5HwIgKdM=; b=QMBIsfhd/6d51n08FCT2vS
	eG6nf8QX+stSoikVqDwNPkUAR+Ej0cnIB1GFoy5ZtPyZU8CBiiMQfoCoDm8+nvF5
	YUswC6NVFD5Ae2tNWL3uEG11i9BcYBmNohf6TSZdLRUl0d/KzojRXYuiYByG7j01
	TBosM4mY5SN3QtTU8WLkk9UJeGh2K0WuVrbpHDHDF8nS+C3xIZmbAly2sfRAtnYv
	XjDiF0oyJmkAWkBVCvIRuf8y4rewY81BxnsR1kLoA+ZgpobfwGJlfVmF562UCUpa
	CC4Qs2CQ/biaNwd3MY8+FGQScjr8IVfLFklR1aQjR4UMFISUY0U4PwcrbILZNlqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycubb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 10:50:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SAk57N012730;
	Tue, 28 Jan 2025 10:50:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycub8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 10:50:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAeUP7022172;
	Tue, 28 Jan 2025 10:50:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjjjmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 10:50:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SAoXrc56361376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 10:50:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 626EB20214;
	Tue, 28 Jan 2025 10:50:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20755201F1;
	Tue, 28 Jan 2025 10:50:26 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 10:50:26 +0000 (GMT)
Message-ID: <672a4d84-219c-4d45-b3a7-8d9d96e90e01@linux.ibm.com>
Date: Tue, 28 Jan 2025 11:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>,
        heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <CAEf4Bzb=YFhsLFuK2Zowb1dsXnQPA1uyQUuQ0yXXQbEpeeyDaw@mail.gmail.com>
 <20250124214107.ycccp4gapbdudzux@jpoimboe>
 <CAEf4BzYqDk5pGbmCz3XX1a-RXRKSLw9QwD+wUEABinVG+HZ1qQ@mail.gmail.com>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <CAEf4BzYqDk5pGbmCz3XX1a-RXRKSLw9QwD+wUEABinVG+HZ1qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jf3DGzU5Ec_3YVf9446Filh3w1fdaaGJ
X-Proofpoint-ORIG-GUID: jJorG7VDgbyLEkM_bvHWA7VsVRorC6dN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280077

On 28.01.2025 01:39, Andrii Nakryiko wrote:
> On Fri, Jan 24, 2025 at 1:41 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>> On Fri, Jan 24, 2025 at 10:02:46AM -0800, Andrii Nakryiko wrote:
>>> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:

>>>> +       UNSAFE_GET_USER_INC(info, cur, 1, Efault);
>>>> +       offset_count = SFRAME_FRE_OFFSET_COUNT(info);
>>>> +       offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
>>>> +       if (!offset_count || !offset_size)
>>>> +               return -EFAULT;
>>>> +
>>>> +       if (cur + (offset_count * offset_size) > sec->fres_end)
>>>
>>> offset_count * offset_size done in u8 can overflow, no? maybe upcast
>>> to unsigned long or use check_add_overflow?

The maximum offset_count * offset_size is 15 * 4 = 60 if I am not wrong:

>> offset_size is <= 2 as returned by offset_size_enum_to_size().

SFrame V2 FRE offset sizes are either 1, 2, or 4 bytes.  This is also
reflected in offset_size_enum_to_size().

>> offset_count is expected to be <= 3, enforced by the !offset_count check
>> at the bottom.

SFrame V2 FRE offset count is 4 bits unsigned, so 0 <= offset_count <= 15.
  
>> An overflow here would be harmless as it would be caught by the
>> !offset_count anyway.  Though I also notice offset_count isn't big
>> enough to hold the 2-byte SFRAME_FRE_OFFSET_COUNT() value.  Which is
>> harmless for the same reason, but yeah I'll make offset_count an
>> unsigned int.

As mentioned above the FRE offset count is 4 bits, not 2 bytes.  This is
also reflected in SFRAME_FRE_OFFSET_COUNT().

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

