Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131D5789D;
	Tue, 28 Jan 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061672; cv=none; b=Y/8qAk3zUgiVnCC1HUp3+CowLotvshKfltCVZOgrtKZG33vFzjl7RX6Zu67GwpX9V5mq9ihCKvO+GsRb6ztAb2+hJ5JvBXKJEQnGJf4epZgirbASvV2kqdfdUO0wo9v8Vbm87lt+0+e0ffrbZYjXOTDEIdjI7+J5bzfbTciNYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061672; c=relaxed/simple;
	bh=iC7HvqQ6UHru+N7NxQ958qSLw2xOa49IzeH1GfgxxKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNo9cBifLCRKmaMwCO2wcB3nJfYET2CArE/C0G7otJhnM5XGPmM4CPzpELiNQT7U2mpAGSdkkZsXL0WlzZf0BbLnouuyYvPaKoQHEhmayxGg8hUqBRHEEtBmbzuujBjDH4oj0Mg4TtXr0pFH4k4u6cHnZY5w+Yr1lknuCFAUQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HZ6Z9Nm2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HZ6Z9Nm2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SA6fPG009939;
	Tue, 28 Jan 2025 10:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J1+/22
	Mdi31Fgq0RG8YRwsw37nD6Txx0qMMlsyHg32k=; b=HZ6Z9Nm2V0uOaMIE8TX9x4
	DruoAQCQmQ0cXNB3XXQTwOhNhoaxFwyWTTtZYq1II5u/dLfNdQXrLe6oHa60DQ1n
	KIU0s/XYBNZkVNFSXHLV/7qpK22mKskURia9IL1TEyBc33LE7e7NTBnrblN12qGA
	ntXVpC2RU+0dZP0xBDWQmQiQLQda8pr1SbzQkXVMKBEc+SSXGtrmTISRLp8qwxvM
	lnFvd8EmRwwJVd3ccUSSm2Cw+xr9mpiRf5ssn0HTbwpeQjjpzTKS51ES9Mkag6k8
	mIqDWCPImBCWE6h+0+cHyXhNof1hxu9LrvUC8jFpkR+R+s5J9AN1qP6q1CHk1FLw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycuqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 10:54:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SAjmYj011423;
	Tue, 28 Jan 2025 10:54:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdycuqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 10:54:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S75DcT018889;
	Tue, 28 Jan 2025 10:54:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd01ag57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 10:54:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SAsCgd54985098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 10:54:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 640E4201EE;
	Tue, 28 Jan 2025 10:54:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2DA7201EC;
	Tue, 28 Jan 2025 10:54:11 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 10:54:11 +0000 (GMT)
Message-ID: <bcb5ddee-c8d3-4f2b-9d84-8a2e1f1236fa@linux.ibm.com>
Date: Tue, 28 Jan 2025 11:54:11 +0100
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
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
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
X-Proofpoint-GUID: AXIQR8knhemm6G70G5RyZ_gr5iBVy9i5
X-Proofpoint-ORIG-GUID: EXUZoO8Jxqim8bKyyJptyCnarRLu770P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=732 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280077

On 28.01.2025 01:39, Andrii Nakryiko wrote:
> On Fri, Jan 24, 2025 at 1:41 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>> On Fri, Jan 24, 2025 at 10:02:46AM -0800, Andrii Nakryiko wrote:
>>> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:

>>>> +       fre_addr = sec->fres_start + fde->fres_off;
>>>> +
>>>> +       for (i = 0; i < fde->fres_num; i++) {
>>>
>>> why not binary search? seem more logical to guard against cases with
>>> lots of FREs and be pretty fast in common case anyways.
>>
>> That would be nice, but the FREs are variable-sized and you don't know
>> how big one is until you start reading it.
> 
> ah, another non-obvious thing, yeah... do you think it's worth fixing
> this and making FREs binary searchable in v3?
> 
> Indu, do you have some stats on distribution of FRE count per FDE in practice?
> 
> Tbh, FRE format is bothering me quite a lot... but let's discuss that
> in another thread with you and Indu

I would be interested to be part of that discussion.  I could share some
preliminary stats from my s390 work.

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

