Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B8441DDF2;
	Fri, 24 Jul 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888254; cv=none; b=Htet3zF8qpMyDoqhv+sNYiR02XNIjixbPhMFWhAW1GEr7PqJGE9DM+yU1nYE0V54p5DgSd3UQwp4XY1jBYLdH9/6vWwv0ilEcxVP+HSzz4D4etWVsR8+BbwmvoC+9P3u7OrjOlDOQzK+aJTNZ4VkEyeCO89sGNRq/fbchXNdOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888254; c=relaxed/simple;
	bh=aor8XH4UMnmAUyatRH2EkbaawyXON09I1vLZ62w171c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oms9IOAnoS/gUc8GyCl30mTiKuVNRSgRhzT/w+FKVUwZl6qdMJD9M5bjgwzsT7D//d/xJulBEJnq3BhinqqOq8BGrSP2YW3F8LzBW3Hf6C/3x2bZ5AC1DZF6UYlSwDk1XUAGNOJxscjVWcPAPfKLe1Ue5KHGpZjO77LceSn9+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PoGClqHb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PoGClqHb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADO2J1547035;
	Fri, 24 Jul 2026 10:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uoyBC8
	hR/w64dLY47L6pyZOZTyV5q2j/53rRZdNSMnc=; b=PoGClqHbkYfN/Z1mKZU0kI
	S14QzdWHha+3mX4WvhIbRgjTgxYS1E4g4r7IVEph5cXcQhgKc6jqNNezL9Q1gESo
	P+5K0URT4BJUKwQoEoP8QmNvbdkxM4CVrDXG4foar+Jah0KqU9IZHHwRp3MJoySK
	+QFAPL3lAytVVg0IR6mUpASzgXxVTn0S8jiEEBSEZ6xzBeh69o7yCWxoeJuATAZH
	seAvBWmY/omx/cq4Oq0wbFWJK+12GS/3TNrVm0TyloLoCtEizwdEF+e8EtnXSJ1e
	L0OUeQc3k+4KuCh2f8VDlC5BrNkbWxxD5N+I+mKaTiEGfVHH4C/m4xEYsU/3X5Zg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahkgbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:17:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OA4ikL017154;
	Fri, 24 Jul 2026 10:17:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahgcxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:17:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OAHLKG34931440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:17:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EA3C5805E;
	Fri, 24 Jul 2026 10:17:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A73B58058;
	Fri, 24 Jul 2026 10:17:20 +0000 (GMT)
Received: from [9.39.22.211] (unknown [9.39.22.211])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 10:17:19 +0000 (GMT)
Message-ID: <b3724424-f9d9-48e8-8823-94c8004360b9@linux.ibm.com>
Date: Fri, 24 Jul 2026 15:47:18 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf trace-event: Fix buffer overflow in
 read_string()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260723093958.416650-3-tshah@linux.ibm.com>
 <20260723093958.416650-5-tshah@linux.ibm.com>
 <20260723095827.659211F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260723095827.659211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bi01Dg8lzUkG5k4C9zf2hAIgzZOPM__a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX4/B5cWHsy2zC
 yfdji7JXUAQPoCP9Ruhf8FMA/1P7PdOHiJDREP9yaGgWIb7i7rP6EnZ+t9fC72GWi5lvd+Zl5av
 RSB0anGE4Kpi5AAKksCxPneMLTiqm4YcgyTrm2jaO28F9fHBoqPJ0ozox+8gD2ArT5vpcMHKqbg
 KfE9nmkCc4p5D7X4+3rTtBUv8h++McvacdJS4BpLBj1F/ngbAAmOdD/Ge20E3fin5vG37/TIn4a
 ybaHjHjfiZ1VmrRm7W3kJs4fnSwX8dCUIxEZIahLI+/vlu/LsXz8Eqv8+2mL13jv+ry9b89L6ni
 WOfGhE4ZP5hYmRTWSV6LBNaL0r6Rjm77GziOvUWxdjPv4KIXJVyXtM+DmsAhcKCCb3oQa1/Yn7f
 z8A6ZT0his83IvNgDvIJfF+GP9GjsuFpGwY3OgAqpe6r7KO/v+l6JV2paC5hA3eY/YK0rtY0SU6
 e5ra+ad9JZpXk6yWPmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfXzV3ByyCz7YtA
 muE7NQF6QL9wRyVKq5C+FeDaFAhfigTl7L+GTPhfQx+1KypR+kAGClynS7kNwc+inmaMzjB26al
 1mOEmXC2ciV65QcIDAKSoWtTP6NgpIA=
X-Proofpoint-GUID: bi01Dg8lzUkG5k4C9zf2hAIgzZOPM__a
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a633bb2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VhAqebHHZSCiwM_HGQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093



On 23/07/26 15:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Error path in trace_report() leads to a double free of tevent->pevent when session initialization fails.
> - [High] Integer truncation in do_read() allows a malicious trace file to cause the parser to process uninitialized heap memory.
> --
> 
> --- Patch [1]: [PATCH v2 1/2] perf trace-event: Fix buffer overflow in read_string() ---
> commit fca4f0cc3071265252215647838a7b30c9c0baaf
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Fix buffer overflow in read_string()
> 
> This patch fixes a potential stack buffer overflow in read_string() by
> adding a bounds check before writing each byte into the buffer. If the
> string exceeds the buffer size, it logs a debug message and returns NULL,
> matching other error handling paths.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index ecbbb93f01853..afd458cf1387d 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
>> @@ -127,6 +127,11 @@ static char *read_string(void)
>>   			}
>>   		}
>>   
>> +		if (size >= (int)sizeof(buf) - 1) {
>> +			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
>> +			goto out;
> 
> [Severity: High]
> This is a pre-existing issue, but could this error path trigger a double free
> of tevent->pevent?
> 
> If read_string() returns NULL due to the bounds check, the error propagates
> and trace_report() jumps to its error path:
> 
> tools/perf/util/trace-event-read.c:trace_report() {
>      ...
> out:
> 	if (pevent)
> 		trace_event__cleanup(tevent);
>      ...
> }
> 
> trace_event__cleanup() frees t->pevent but leaves the pointer dangling:
> 
> tools/perf/util/trace-event.c:trace_event__cleanup() {
>      ...
> 	tep_free(t->pevent);
>      ...
> }
> 
> Later, during session teardown, perf_session__delete() unconditionally calls
> trace_event__cleanup(&session->tevent), which will attempt to free the same
> pointer again.

Thanks for catching this. trace_report()'s error path and 
perf_session__delete() can both call trace_event__cleanup() on the same 
tevent, with nothing preventing a double-free.

Fix: clear t->pevent to NULL after cleanup, and guard the function to 
no-op if it is already NULL, so a second call is safe.
> 
> [Severity: High]
> This is also a pre-existing issue, but does do_read() suffer from an integer
> truncation issue?
> 
> Functions like read_event_file() allocate memory based on a 64-bit size:
> 
> tools/perf/util/trace-event-read.c:read_event_file() {
>      ...
> 	ret = do_read(buf, size);
> 	if (ret < 0)
> 		goto out;
> 
> 	ret = parse_event_file(pevent, buf, size, sys);
>      ...
> }
> 
> But do_read() takes size as an int:
> 
> tools/perf/util/trace-event-read.c:do_read() {
> static int do_read(void *data, int size)
> ...
> }
> 
> If a maliciously crafted perf.data provides a size larger than 32 bits, the
> size is truncated when passed to do_read(), causing it to read fewer bytes.
> Since read_event_file() only checks if ret < 0 rather than verifying
> ret == size, it will pass the large, mostly uninitialized buffer to
> parse_event_file().
> 
>> +		}
>> +
>>   		buf[size++] = c;
>>   
>>   		if (!c)
> 

Thanks: this is exactly what patch 2 fixes. Widening do_read()'s
size to size_t removes the truncation, so it reads (or fails on)
the full 64-bit size.

do_read() either reads everything or returns -1, so callers only need to 
check ret < 0, no ret == size check needed.

Thanks
Tanushree Shah
