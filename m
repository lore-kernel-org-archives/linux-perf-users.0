Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF483769F0;
	Sat, 25 Jul 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785002146; cv=none; b=lG21AGyEoVE+VITSXPnyX1x9+dWfRobEqh9SoeCyM9ISXuKAKjCpLYNCbJHqWime5tAuReZj6D553E761f/5PuwHyxU9BaruPMkjptqyGpTDiY3Hv0w0badX5CUo+wkRIW1AqPlJATjEH3uOhH0Fl/jk0DqhDmN1ULYL/cYf/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785002146; c=relaxed/simple;
	bh=HVXSIcNQgvskszgEj2uvUh0ZEvjU/z9whE0IEolBCtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1D/rDmF6vhDvRXsIhlO4Pvzceqb1FUqrpfQvzZcWe6g4VOMznuyhcsDTEEgEGW1WMSG9S9aRjRkpXpHAY3P+sdRX9BfGYGUi2rqz7OExpaw69LbuqxryZt5Ukustf93y6UJFwsdU2/UGoHKI+Jo6CFHF6rfdF88+AL4f4HWmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLOjBQd8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLOjBQd8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHHrha1204799;
	Sat, 25 Jul 2026 17:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sUemA7
	5wCL9FikLUUYV6lBtpNYFQWSUv1GJ/OTiEpXk=; b=fLOjBQd81hHsHX5asz4Y0w
	O1H5dreN0hx8CetgsYhHQA7gREwykhWGh6aOeROrjOx7jngx6uALIkr2hjv0Y7IN
	50aVou1nD2NInkJYs9sFvVAAe/s5eu8WNqbo4SG3In/88pYBoFmguM/xC58/ZaK3
	t40E5w0C+oO8zX5MrlTBF44u789RlV3POqsKYdLkMoqGKaaD04LCnPt+o+o0UhsT
	YucwmAVHPDhsQy1hwDpZwHRocNwu6hApmDQd6Fr1xaWy9A3veyrx0Mz+EVeEd3O+
	Km4w48fPAZmR/Pvb3JVyIkV0+Ztmkzt7sDfAWo+PVIoq2dbOut3G2L+hZUR0m4rg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw70ymy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:55:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PHfFBD003777;
	Sat, 25 Jul 2026 17:55:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5ha1uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:55:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PHteq232375468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 17:55:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F94258056;
	Sat, 25 Jul 2026 17:55:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D93C58045;
	Sat, 25 Jul 2026 17:55:37 +0000 (GMT)
Received: from [9.39.22.45] (unknown [9.39.22.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 17:55:36 +0000 (GMT)
Message-ID: <2caa358c-2127-4739-a2ae-cb7ffa201882@linux.ibm.com>
Date: Sat, 25 Jul 2026 23:25:35 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] perf trace-event: Avoid double free in
 trace_event__cleanup()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>, hbathini@linux.ibm.com,
        atrajeev@linux.ibm.com
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-4-tshah@linux.ibm.com>
 <20260724145514.90C7E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260724145514.90C7E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xPCXebp_PSRcUvtIEoiJy3TH0pJNzCIB
X-Proofpoint-ORIG-GUID: sDhaULdLzLdnmZrt8cQL3h7MJeScjpnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX0d6m8lWhldoi
 txbQtYKjJpXqCZURxGMsMI4/WIOw2yy41Dpczc/jQw+yZs5gMhpkWB83S//91HifcM+DrajqTLX
 Vi+QZK6PTF8eftZ870K0rvhHhGr90Q1jsUrR8GZwbgEcl04ia2uo++5ujlW+DayiDu1JZgJrSH/
 n/rbXhFJMKFWF0YNh38EXbhla49b6wsWpidEBw9eLuXxkbE1QMKHNLwndzuVSGkzJkTDhDP9c8G
 /TJ5OTV66L2pmkiGNOzltZfjlw+ELzNQrmIJov+NceijOV2YfaaFi8SZbxxiISiCFsjNIjLFt8K
 VTT5WSUY73O64lPIaQ400Fwjfzu2dmde2E9oKAH9LD8HcZfNuf4rrq2DqO+WqxCphQlJdw+Pozh
 um5io8kJ98XuQDFn+r0w5H0Y75xlQ5yFzH5gPWhAwfEzoU4Isq/mU52RM3SJ6meUHYDTvqx6DcS
 ZQ2ABAZJvA9m+Jm26ag==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a64f89f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=l53iYGRtcJ9rzQUW14wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfXx/0RtoQC99fH
 oUuvfeu8CJeeyQh1DhaFqujjwXdNLqcZUZNbhHomI5u3COuEnanaEPF6QE/KJIpxjwJYu2gZevH
 SKWtuGQa6+Xfp1aEquig2puUKL2JlyY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250169

Thanks for the review

On 24/07/26 20:25, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Calling trace_event__init() repeatedly on the same struct trace_event leaks the previously allocated tep_handle and plugins.
> --
> 
> --- Patch [3]: [PATCH v3 3/5] perf trace-event: Avoid double free in trace_event__cleanup() ---
> commit 1eb2775370e0095c8df022b4a83dcd46f4b90b94
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Avoid double free in trace_event__cleanup()
> 
> trace_event__cleanup() frees t->pevent but never clears the pointer. It can be
> called twice on the same trace_event: once from trace_report()'s error path,
> and again from perf_session__delete() during session teardown, resulting in a
> double free / use-after-free.
> 
>> diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
>> index 6a8c66c64b705..cf40e98d16177 100644
>> --- a/tools/perf/util/trace-event.c
>> +++ b/tools/perf/util/trace-event.c
>> @@ -63,8 +63,12 @@ int trace_event__register_resolver(struct machine *machine,
>>   
>>   void trace_event__cleanup(struct trace_event *t)
>>   {
>> +	if (!t->pevent)
>> +		return;
>> +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while we are making it safe
> to call trace_event__cleanup() multiple times, should we also call it from
> trace_event__init() to prevent memory leaks?
> 
> If a maliciously crafted perf.data file contains multiple
> PERF_RECORD_HEADER_TRACING_DATA headers, trace_report() can be called
> multiple times on the same session, invoking trace_event__init() repeatedly:

Confirmed, this is a real leak. I'll fold a fix into v4 alongside
the trace_event__cleanup() double-free fix, since the two are
related.
> 
> tools/perf/util/trace-event-read.c:trace_report() {
>      ...
> 	if (trace_event__init(tevent)) {
>      ...
> }
> 
> This overwrites the previously allocated tep_handle and plugins without
> freeing them, leaking the memory:
> 
> tools/perf/util/trace-event.c:trace_event__init() {
>      ...
> 		t->plugin_list = tep_load_plugins(pevent);
> 		t->pevent  = pevent;
>      ...
> }
> 
>>   	tep_unload_plugins(t->plugin_list, t->pevent);
>>   	tep_free(t->pevent);
>> +	t->pevent = NULL;
>>   }
>>   
>>   /*
> 

