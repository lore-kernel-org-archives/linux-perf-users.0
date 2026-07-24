Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A731AF24;
	Fri, 24 Jul 2026 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882433; cv=none; b=n2NX92wQCGGcU5D+p1pKJ6h48BKeeMC7g8xV5jEt9P0PFZI3WZMjv3NInKbzLr5rLJJrVMKjG27C/OdHquZMoqUkwMiQxVVM+zcpEz/aRB2QUPVzmxE0JxXj+PDxv7CrxPmAkqx8/Gz3viHPl+YTvB62664tKAx7Cvqlpyowo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882433; c=relaxed/simple;
	bh=M23a556lhjGEqPR1JiIdAz2y21O1sGRd3NIVW/6RWDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QX1laOZuBTBpA+TjNeh4HcaEvxe7Y6TuYZitZjsYV1jPk0kdHdceIPjt7H47N16uqEA2yD9h7M6jQ0qFFX1Oq40GA4vdIY03rlu5MhczqZJIUcERFTmV+jbquVqD7y9jtrdtPejCf5sLN9OjGuZUMs/iQt3SZu0lmD2FKyMyH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NNKWjGLx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NNKWjGLx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5CBK2827098;
	Fri, 24 Jul 2026 08:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ft4aYZ
	V3G4t54yd6e6naTXVwTlhGz6U2GSS2i/UtgME=; b=NNKWjGLxfKsNz52YN9ZTwl
	d2Sm8lW0CRCRYk2JnZAu93J/zdnqA9SblD6vMLKQ8FFz7BLLOm9uaBUmCfa6GuD4
	uJzyFuXd4j0SnzOBqRCk7NZmYM5x1ZIb+Iwj2oS0Qh6kdfz1dLBPZUN6hNWajV41
	FOqpDVE+vo5Jm+yFH+d02y6/q+KAO4ZxtO5LCQALTA5YdjgBAcPkHDkiL4JD4dRH
	wrS6cbNcwaQGqBJpf6CWpMWgK+YYvxgzH9DWIloqyBOgB0B/vmT2aGpV8rAhKAkO
	Kv2gofhWyNkw/seIeczPvaFBslMdo+QpgdljNpYTa87T9KVYOsmuoV00ftA7pRVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kk797-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:40:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8YapT014393;
	Fri, 24 Jul 2026 08:40:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wg7q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:40:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8ePXD56295724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:40:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB52358056;
	Fri, 24 Jul 2026 08:40:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B84CF58052;
	Fri, 24 Jul 2026 08:40:22 +0000 (GMT)
Received: from [9.124.221.69] (unknown [9.124.221.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 08:40:22 +0000 (GMT)
Message-ID: <38deb2cd-c770-4018-8dc0-4da6124d8937@linux.ibm.com>
Date: Fri, 24 Jul 2026 14:10:21 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf trace-event: Fix integer truncation in
 do_read() and skip()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>, hbathini@linux.ibm.com,
        atrajeev@linux.ibm.com
References: <20260723093958.416650-3-tshah@linux.ibm.com>
 <20260723093958.416650-6-tshah@linux.ibm.com>
 <20260723101054.09ABE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260723101054.09ABE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6324fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5-z-NcgFbdBiZNMltKoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3MyBTYWx0ZWRfX9nzmZnXbICqY
 Wdd7AHKcO3OSE7wIR2JFnRIrY9q+lDPr4+PnBcHUocHnlI1BPKS+Ze8nRNtMSKT6xGo9HhcJtrr
 zvDW3axzr/bl+3ezgEm5JY0dKg5ZQXihrDYpqRtooySMeKXnSAlwOk+Pvu2G43sRgJKt/JDQ5/5
 3PwIGo6x5aYVL3xlOcJy+nISRgLCSFhmlq9pf+GbQlB9SFUKX+bywvcNmaO5A2UrNZM0oUmPnIT
 AhYow+04iqjmExKW1FLjD1hYAoajnzCk4ekz78E6YXdIh2lFkcVsP3Gveo7VNqxfzb7Pzr3T0jn
 qtQV/my0WQEjwc4JCryxbQLRu7HWHEb1ofrut1/a+ly502H6b3ywYvzMfwK7S0EtQfyWoAw+6/T
 ognPVYpxEnt3fAMZHpqmszL7iYBwPaZAndVNkMrSFGlj49QucYHvvSMxr5I8uWEGKOScnGsiW/u
 gv525ONWJJb4mnZmy2Q==
X-Proofpoint-ORIG-GUID: f1NomfSIuzE2fO9y_DOFh-ZqFDhYfnzZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3MyBTYWx0ZWRfX6KcImtQUlSaM
 feqi3i/lSBG4qvX6jZitbCL4fEDDgxEFIx4aI6BrOHcNWQY4uvgKW6hFsiYvn6Ukr3kJunwf+wJ
 4o+rZJ/4/skGXZ//eXt7de9jmaYZ/ig=
X-Proofpoint-GUID: E-G7f0TBjNf16yDSnURBTIQJrLOOWDyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240073

Thank you for the review.

On 23/07/26 15:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Heap buffer overflow in `read_ftrace_printk` unmasked by `size_t` conversion.
> - [High] Infinite loop in `skip()` leading to Denial of Service.
> --
> 
> --- Patch [2]: [PATCH v2 2/2] perf trace-event: Fix integer truncation in do_read() and skip() ---
> commit b30cf605f4d2ba7957c47c5106a821726355dd7e
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Fix integer truncation in do_read() and skip()
> 
> This commit modifies do_read(), __do_read(), and skip() to use size_t and
> ssize_t instead of int for sizes and return values. This addresses integer
> truncation of 64-bit sizes, fixing uninitialized memory dumps and out-of-bounds
> reads in the perf tools.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index afd458cf1387d..52ed496d92c3b 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
>> @@ -51,13 +51,13 @@ static int __do_read(int fd, void *buf, int size)
>>   	return rsize;
>>   }
>>   
>> -static int do_read(void *data, int size)
>> +static ssize_t do_read(void *data, size_t size)
> 
> [Severity: Critical]
> Does changing the size parameter to size_t unmask a heap buffer overflow in
> read_ftrace_printk()?
> 
> If a crafted file supplies 0xFFFFFFFF, it triggers an overflow in
> read_ftrace_printk():
> 
> read_ftrace_printk() {
>          size = read4(pevent);
>          ...
>          buf = malloc(size + 1);
>          if (buf == NULL)
>                  return -1;
> 
>          if (do_read(buf, size) < 0) {
>          ...
> }
> 
> Because size + 1 overflows to 0, malloc(0) returns a minimal heap chunk.
> 
> Previously, passing 0xFFFFFFFF to do_read() truncated the size parameter
> to -1. When this -1 was passed to the read() syscall on 64-bit systems,
> it became ULLONG_MAX. This failed boundary checks against TASK_SIZE_MAX,
> causing the kernel to immediately return -EFAULT and preventing the read.
> 
> With size now being size_t, 0xFFFFFFFF is passed directly to the read()
> syscall as 4294967295ULL. Because this is below the 64-bit TASK_SIZE_MAX
> limit, the kernel will read up to MAX_RW_COUNT of file data into the tiny
> allocated buffer.
> 
> Could this be prevented by adding a bounds check before the allocation?

Thanks for catching this. yes, this is a real heap overflow.

size is attacker-controlled, and size + 1 can overflow to 0,
causing a tiny buffer to be allocated while a huge read is still
performed into it.

Fix: reject, size == UINT_MAX before it's used, so the overflow
can't happen. Will include this in v3.
> 
>>   {
>> -	int r;
>> +	ssize_t r;
>>   
>>   	r = __do_read(input_fd, data, size);
> 
> [ ... ]
> 
>>   /* If it fails, the next read will report it */
>> -static void skip(int size)
>> +static void skip(size_t size)
>>   {
>>   	char buf[BUFSIZ];
>> -	int r;
>> +	size_t r;
>>   
>>   	while (size) {
>>   		r = size > BUFSIZ ? BUFSIZ : size;
>>   		do_read(buf, r);
>>   		size -= r;
>>   	}
>>   }
> 
> [Severity: High]
> Does this change introduce an infinite loop when a maliciously crafted
> perf.data file provides a massive 64-bit size?
> 
> Before the patch, passing ULLONG_MAX was implicitly truncated to -1.
> In the first loop iteration, r = size > BUFSIZ ? BUFSIZ : size evaluated
> -1 > 8192 as false, setting r = -1. Then size -= r set size to 0,
> terminating the loop immediately.
> 
> Now that size is widened to size_t, skip() will continuously subtract
> BUFSIZ from ULLONG_MAX. Because skip() ignores the return value of
> do_read(), does this cause the perf process to spin endlessly even
> after reaching EOF?
> 
Yes, its right that widening size to size_t removes the accidental 
truncation that was previously capping the loop early on bogus input, 
and the missing check on do_read()'s return value turns that into a real 
infinite loop  on a malicious size

Fix: Check do_read()'s return value and break out on failure/EOF instead 
of blindly subtracting the requested length. Will include this in v3.


Thanks
Tanushree Shah
