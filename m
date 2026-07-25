Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88772F7EE3;
	Sat, 25 Jul 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785001573; cv=none; b=MjhoaONCKNzMNK1cwC1oNGDQb461z5MWIPF6WcF1bnjTzRwJEyaTUX2k7sGvtDYuvWYY+xNO97GXvGU1QEYRqQpCL5ke6M1kqEPeSaXcxXqDuQ4cGiDVahWJ7ES+JFopw3omHK/P4yYMlZduZe8VsHLWCuoOg34tKIXWngpHyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785001573; c=relaxed/simple;
	bh=q0GzCZuWcGGFn0X61K38eyRMR8SVn/GxuxDImN6skno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvCeC9XLHLbK/LmZwkQVvgQxRtlM6B22aFwQuf1qR5ZZLLvznyHeg2dfY3ty4IhI5N4n+6IqGGX5EbBzttmR7bfxOHk9Mz8BZKmfWi776qV0rVGeZ48TlvsY1cVqFnnpEvnj5bTK4/gCJ66NbBawax16yPjYEMGE91Y2bC8pF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JmRJgpsF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JmRJgpsF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHHfm63527512;
	Sat, 25 Jul 2026 17:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yjf+Or
	6vB0U/BYccXBma3X31iRyGo8KEEAiNCJ36yNE=; b=JmRJgpsFjaPWf0fHWDcHcL
	cKER3Dm46jDNfqz2V8i2/7yBXdT2hmWmPF9ATQ+EKIRNPZfmqs22MhbTYKGmVEss
	qeJaxrJqGn1Nrwenf/nonUxVXeF9ZMot8BJ8a3yuh48z8Kfpegj5YnVDjCNOQqun
	YOLSMhqFCeIE6i6Vh/21sv+FR2edGpVBekH/UiwOlFCIiqh1/b7szQGLMrc5oWdX
	Zx7G+DpXqI82KKQHeFbTUNWTiRNWvPEFvbBgsmw728o9zKr5V5J0Cg8om1C4hAKi
	KyjQhOljaEmHvUlwB85qZgbW+2UJ38ANOG/df+4h639mc+ZgwmUQ3yUw/8i5kVSA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc0xgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:46:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PHfIdL003826;
	Sat, 25 Jul 2026 17:46:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5ha14y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:46:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PHk76H22348426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 17:46:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2264158054;
	Sat, 25 Jul 2026 17:46:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B946D58045;
	Sat, 25 Jul 2026 17:46:03 +0000 (GMT)
Received: from [9.39.22.45] (unknown [9.39.22.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 17:46:03 +0000 (GMT)
Message-ID: <aa5c4592-4412-4d09-8ced-0ef227ac3c38@linux.ibm.com>
Date: Sat, 25 Jul 2026 23:16:01 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] perf trace-event: Fix buffer overflow in
 read_string()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, hbathini@linux.ibm.com,
        maddy@linux.vnet.ibm.com, atrajeev@linux.ibm.com
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-2-tshah@linux.ibm.com>
 <20260724144710.7180C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260724144710.7180C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: J6Alu67CuQGfBkekOil-ge-LoCHU71tY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE2NCBTYWx0ZWRfX9OenscgBWvht
 nmGT6bVPsLq0Z/0tn8pvozya7S9dx54ZjN0mFJo5/js04UgjYbQmP1ntuNYThWIl8WQp3kZLtIO
 QiepymYQlQcsH1UyqeRBorWSfhAvr9fpobNS5BbOu4BcFo+RWjA/8w32KXZHjenW6rsqZJ9ITEU
 tXPkpJ5M1TZlpm4e0jl5JJNvUtqFzWOk4HuffP8yo+x7ZdwroEEA7aOi7NqvGM87SLbU/1ltlhW
 6YtnNU/34VDILIlQdbMz0xeyH4veC8Ibll+gFsP4gfoFKKWUK40N7jBgH+yYGYh8LmbO7sDv4bk
 gKF4dVIgW55YpE02mmBh5Q5tx9zdU3bcQkjwb1Ir6V8XBXQK0ZfErR1E9UVvlC7HjK4Nii3sMuW
 TFz22B5E6XxGhUCuzsHWGexH0OQF+c1zH+ludNvh5dnC31nYN6YsF3Rbzhag1wzuYSKfVsmY7XD
 TtpFFi/zhAFBGUFE78w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE2NCBTYWx0ZWRfX4+zH2opJf65p
 LqQ5p6QHohrHARxQZ4uUyq/OYPtRw7ZnOWGYMe5Z3ZmIDYNj6W3xrYEtIeHJLDCrdBzLSo74Pm5
 hCtb/SU6qkVvlN86JTrUsM/sux/oCSM=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64f661 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gpuuEuwup9TChx9WPhwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Qcb5JjNrip9HFLXcaHJNG3l-GF4MalG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250164

Thanks for the review

On 24/07/26 20:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer truncation when passing 64-bit sizes to do_read() and skip() leads to parser stream corruption and potential out-of-bounds memory reads.
> - [High] read_proc_kallsyms() attempts to skip the kallsyms payload using lseek() but ignores the return value, breaking parsing when perf.data is read from an unseekable stream like a pipe.
> --
> 
> --- Patch [1]: [PATCH v3 1/5] perf trace-event: Fix buffer overflow in read_string() ---
> commit 933d8da6e80dadef6bdc3760f4e01eb9c825faeb
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Fix buffer overflow in read_string()
> 
> This commit adds a bounds check to read_string() to prevent a stack buffer
> overflow when reading strings longer than BUFSIZ from the input. It ensures
> the function returns NULL on overflow, matching other error paths.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index ecbbb93f01853..afd458cf1387d 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential integer truncation
> when passing 64-bit sizes to do_read() and skip().
> 
> In tools/perf/util/trace-event-read.c, do_read() and skip() take an int:
> 
> static int do_read(void *data, int size)
> { ... }
> 
> static void skip(int size)
> { ... }
> 
> But in read_header_files(), a 64-bit size is passed directly to them:
> 
> static int read_header_files(struct tep_handle *pevent)
> {
> 	unsigned long long size;
> 	...
> 	size = read8(pevent);
> 	...
> 	if (do_read(header_page, size) < 0) {
> 	...
> 	size = read8(pevent);
> 	skip(size);
> }
> 
> Could this lead to silent truncation and parser stream corruption if a
> malicious perf.data file provides a large 64-bit size (like 0x100000005)?
> 
> On 32-bit systems, malloc() would allocate a small buffer, while the parser
> uses the full 64-bit size, causing an immediate out-of-bounds read. On 64-bit
> systems, skip() truncates the size, skipping only a few bytes, which might
> desync the parser and allow arbitrary data into subsequent parsing stages.
> 
Thanks, this is already fixed by patch 2 in this series.
> 
> [Severity: High]
> This is also a pre-existing issue, but does read_proc_kallsyms() properly
> handle unseekable streams like pipes?
> 
> In tools/perf/util/trace-event-read.c:read_proc_kallsyms():
> 
> 	lseek(input_fd, size, SEEK_CUR);
> 
> This lseek() is called without checking its return value or providing a
> read-based fallback.
> 
> If a user pipes a perf.data file into the tool (e.g., perf report -i -),
> the stream pointer is not advanced. Could subsequent parser functions
> (like read_ftrace_printk()) interpret ASCII text from the kallsyms payload
> as a 4-byte size header, resulting in massive arbitrary memory allocations
> and tool crashes?
> 
> This appears to violate the subsystem rule which states that pipe streams
> do not support seek and must be properly handled.
> 
Thanks for catching this. This one's unrelated to the rest of this
series (buffer overflows / UAF / leaks).I'll look at it seperately.
