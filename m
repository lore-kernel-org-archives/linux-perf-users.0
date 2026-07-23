Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC1378824;
	Thu, 23 Jul 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788906; cv=none; b=lm7nIzBZqtrYdb4JsGmx3nbbg4YCjHdZsnrHy2UYdbT60PbnKXhX8e5D7w2T/VmQC5VsoFEkK+uOWPk3ts5U577y8cpWC9+gxQZ2En0Fwr/q52G8bgs7IWrTiyYYJorTe9RWvkDzLVAV4mEGWhRMW7mqhhSdaixrmO0qXw5KHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788906; c=relaxed/simple;
	bh=RJRq+eP/D4rBS9x/WM0Wt7IQpjo9EzPA+2OxnESejKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQ8AxkPA1PM0/hPQTzXA2loxslUtDo+aaxHPopUoSo8ZgUS8CEf1cwPaijzuAM74GrP31ymbJrR3PR8DRN1a65yBXs4OydaqyfXyXuewS1KytYj2bhgdDk44sJPvm5405mstVih1NaQcwqyi9M7anA04dpK13HYPYRPY386yK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rPCjkPvJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rPCjkPvJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5CF702083632;
	Thu, 23 Jul 2026 06:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LT04tV
	Rbc79KvbxGl7ISGqjJTLkrO8BsOuCpnxfQUmY=; b=rPCjkPvJuoBhCk+zbw2nde
	jDr5n8Y9aZu90Fneg9LOo7ucZakdV7GglyJUZufmkPw+/z0T1YRhCzBS/J2Nh0JB
	JRozea7sZRAXi+iMlDA1E+k571rJy9lHcgUMNQwQOjMaB5lssxWRvzshIZj1wDfC
	SwYL56mt2P6M7Fy6ArmsbWi5MFwn8ec0nE/6jslFUJekFlyRKoey9qIKG3rDRY8e
	KVUq/ZR1uHYlY1FkwIYAhA8mVUTpRLC1d65d0zBulZAxH3YHz6oFfkfYRxrMctUj
	AuNHH7L6Lz1x/KvwdlwKY85LcHbFGz0/kOunSU/dqnjgqmtjgaeDLwNN108LwYXw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7916536-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:41:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N6Ynif011652;
	Thu, 23 Jul 2026 06:41:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk2xb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:41:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N6feX032178856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 06:41:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01A558057;
	Thu, 23 Jul 2026 06:41:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D846E58058;
	Thu, 23 Jul 2026 06:41:37 +0000 (GMT)
Received: from [9.123.15.94] (unknown [9.123.15.94])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 06:41:37 +0000 (GMT)
Message-ID: <c065f14c-f914-4371-97d6-54d3922abcfc@linux.ibm.com>
Date: Thu, 23 Jul 2026 12:11:36 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace-event: Fix buffer overflow in read_string()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>, hbathini@linux.ibm.com,
        atrajeev@linux.ibm.com
References: <20260722113552.191143-3-tshah@linux.ibm.com>
 <20260722115012.E10D41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260722115012.E10D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VOWiYyy4C4-7d7s6QOvnplQ6bOYFjQRr
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a61b7a7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gViIASR_mfVhifJbeO0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NiBTYWx0ZWRfX5gkNQTxkLjDP
 ZN/P7kSrO2B90x77PVcOXh96WhV7ij4WmZtpgl/0ggHIZNgFO3Gb6Lh735S0KqZ7uifh0xsCDM0
 Bet2p74rizAKdqLpNcaxn6H6HkHf4II=
X-Proofpoint-GUID: T1PHUAmveJeI1QC1y7UoA0EOnRD_YAYA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NiBTYWx0ZWRfX2iJ5etPds7gk
 juyeNYxauvbmPkzGsO/5Eo4Gd+mQ0Ud9PraPKTsc9J6lh8OPbdRxyQnUaz6qWBoVhP3W9SoSzgS
 ypufIfECwkJe2cogmjpHXfb7s7e+LoApDaAokmccv3rcTAEeDCegmNn0BW/hNLFQw6h0LTD2YcX
 eoCghpdSkTo8Wm8tnSzBEEZKFFuJRNba+uOQILLBcz7LPp6gF2GSRWBxr7YVH+7L2dMeRw+m9di
 qwene68N8jn3oa5ZIHPKiUXD9c14jNXR4irzVhXfMK35E2sHseJ5sxOyVC1tABkUVmmkTmbegBs
 MZgQ1lWoHvM+MwvbMn09jwAvJfy9LoHZ0uFv4dNUxZ/TTrBcgnrNhuMGeKKmntMfC6MZATUgFjF
 /R/4pfcWMu5lp8C1w/cpfd7ZR21okuIrUtprxPuwUEGOkpe8ZZNOE8d3elCrfFxfpdbxEb2AdGF
 fCx32pG100yWJ/LhVcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230066

Thanks for the review. Yes, this is a pre-existing issue. I will address 
this and send a V2 patch series.
On 22/07/26 17:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but integer truncation when passing a 64-bit size to a 32-bit `do_read` parameter leads to out-of-bounds reads or massive uninitialized memory parsing.
> --
> 
> --- Patch [1]: [PATCH] perf trace-event: Fix buffer overflow in read_string() ---
> commit fd2c84f48dc9adf4455bf50d97942d8f87743ab3
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Fix buffer overflow in read_string()
> 
> This patch adds a bounds check to read_string() before writing to the buffer.
> It ensures that the size does not exceed the bounds of buf, preventing a
> buffer overflow when processing trace events.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index ecbbb93f01853..afd458cf1387d 10064
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
> [ ... ]
>> @@ -127,6 +127,11 @@ static char *read_string(void)
>>   			}
>>   		}
>>   
>> +		if (size >= (int)sizeof(buf) - 1) {
>> +			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
>> +			goto out;
>> +		}
>> +
>>   		buf[size++] = c;
>>   
>>   		if (!c)
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but integer truncation when passing
> a 64-bit size to a 32-bit do_read() parameter can lead to out-of-bounds reads.
> 
> In tools/perf/util/trace-event-read.c, do_read() expects a 32-bit integer:
> 
> static int do_read(void *data, int size)
> {
>      ...
> }
> 
> However, read_ftrace_file() passes an unsigned long long size parameter
> into it:
> 
> static int read_ftrace_file(struct tep_handle *pevent, unsigned long long size)
> {
>      ...
>      buf = malloc(size);
>      if (buf == NULL) {
>          ...
>      }
> 
>      ret = do_read(buf, size);
>      if (ret < 0) {
>          ...
>      }
> 
>      ret = parse_ftrace_file(pevent, buf, size);
>      ...
> }
> 
> If a maliciously crafted trace file provides a size like 0x100000005,
> malloc(size) on 32-bit architectures truncates and allocates only 5 bytes. The
> size parameter in parse_ftrace_file() remains the full 64-bit value, which
> would result in a massive out-of-bounds read.
> 
> On 64-bit architectures, do_read() truncates the size and reads only 5 bytes,
> causing parse_ftrace_file() to process up to 4GB of mostly uninitialized
> memory.
> 
> Does this code need to update do_read() to use size_t or ssize_t to properly
> handle the size parameter?
> 

