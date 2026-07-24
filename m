Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9741F5F9;
	Fri, 24 Jul 2026 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888314; cv=none; b=YPr0VDOM4JfxRBEu8g+lnzs7fyqPVPntB8kikVa69gnK7jGpFXldj6j8FsMMzBQExtAKHV3+eBYhh7WBOM/3P4QG6HCD9JISEABXEbLhwvu8jyMUHhVxVs/zQXETEc9jmYX7TNX7IC3ec3HnmTjlTesElFmAloEx8hAau19K1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888314; c=relaxed/simple;
	bh=aor8XH4UMnmAUyatRH2EkbaawyXON09I1vLZ62w171c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxcqQ8ik32QnFXJhq0RJsN288d/RR5blrh45a+8Thk9wcRNAHinySyknojmSyKcUcwY4BVAhPwFyF2IJh8PxsCP9ZSaHo6VuDWM/HVQ1XNCyaCrk8QHV7w29VTDSRTAkOn4Svx8Gz9zuSwCWIpzn2UWC7K4mDXNTqHBlrpUMbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kUcZXnE/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kUcZXnE/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADYIJ3851937;
	Fri, 24 Jul 2026 10:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uoyBC8
	hR/w64dLY47L6pyZOZTyV5q2j/53rRZdNSMnc=; b=kUcZXnE/Y/e2KeGh5f7M6S
	HdANbd2SFgRaaQpxzM/zqu7J/kQrSHoo1rGMkBdRn+feLYTwZuNbsguapGTnT7os
	oHWWMB1ujPR3vahU2pZfr8FrXjA1z54cdI09QndmI9iWSdQWBLeWQq7oCWBCSjPA
	df7UXeBMuKwVBsZCxWsN+y+IVdWFmsE6YgZL/AwYlYQjzPz2OKPB9oEX/JstsxIj
	Vt07BxeIRhrWX05NZt0XI4kbPho6mcrrl++ZYszNKkfr8sUBdXQJSvmdsM2+YNdp
	brQ9vPT7zzQvJK8QYKPBzD84sxIYwQ4cW8nKt6sVUvE3uSwXxqMgwCaH98K32Elw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77av5rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:18:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OA4cG5017087;
	Fri, 24 Jul 2026 10:18:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahgd0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:18:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OAIIJn28443328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:18:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0BC5805C;
	Fri, 24 Jul 2026 10:18:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40DB058059;
	Fri, 24 Jul 2026 10:18:15 +0000 (GMT)
Received: from [9.39.22.211] (unknown [9.39.22.211])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 10:18:14 +0000 (GMT)
Message-ID: <d8931a48-4652-4026-a9ca-a0d91abc6913@linux.ibm.com>
Date: Fri, 24 Jul 2026 15:48:13 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf trace-event: Fix buffer overflow in
 read_string()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>, hbathini@linux.ibm.com
References: <20260723093958.416650-3-tshah@linux.ibm.com>
 <20260723093958.416650-5-tshah@linux.ibm.com>
 <20260723095827.659211F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260723095827.659211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3OgqbkFmZnA7PemLCGnBsC5Mq33ydJKX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX34hsiBt6okqS
 k0THveXe/zxueXQ9W3hjfn9Fd6+F0VbIQ0omG+mPpRRBqGIkfmGEisvoVrHXLPvg/R94KDmHQiD
 KeU1fSRApxjQHUQfDaO1b09V3ovBGow=
X-Proofpoint-GUID: Eppr17wOPVT702bTUo0ejT1ZkTmhg4Mi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX08/Kq/L45m2K
 DLbY+9ydYd4hdOucaaNypgt7aQZUozgOAov69kT2a216OJzO+y+PiUzuJhMv/PCWMqM6kWln0RL
 gNUUnxN56xrQfZTtntzK39nfJe7K+59bzFT4micgydcbamhfjOJ9nZjUI81K8t/0VkQnJxMF9Hl
 bJXAFQ6k4os+ESqEcqO0q6cS40yRyopc/Y6JJQaw5flaNKX2Xa8JfSMMCleCsFYECcNbunumHCb
 1a5MBYnuCrmg0wHVyrLyvL5LQm+yCydRFDsJyFWmK983wYk0u3sy3NIaWu758E4XAMSNv+FyG5P
 0NgIAfYIWLQ3/CvCzTaCHXRyHQ1ykb/QkM+dkpGX/C84U67tnvjeyaA6USbby5XF4bEY7jDtwoY
 ZzR4TUYffgixgW9APPthlqu2zw0c9N7z9y5QMBK3n+x5mlb3dbsKMYiWhdsHbC/n9zWtyzwN46o
 YFBQLIAp9FPfJbxVUlQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a633bed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VhAqebHHZSCiwM_HGQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240093



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
