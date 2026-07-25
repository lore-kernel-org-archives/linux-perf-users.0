Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB73F788F;
	Sat, 25 Jul 2026 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785003122; cv=none; b=rfCSKBZbCM8pgtHYyIv6J/leKxzz2PYzLQqiM6ZMokf+W+UP6OfLwsl+y/tDR/7J/zdyMVVnE4BUIqRSM5EJzGjr6FQ1opJ4GOhCGwrKYElxn/GbjlmswTdHTja2CJJjjNglA5RggqQZzl3uOIY3/Nq5yVPsACOscmM9aVSzjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785003122; c=relaxed/simple;
	bh=L/ZpVH1x2xHELdbjpIxJbmftD9deFc5Pl04Tq47624Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFyoMQ6Lga8n0Pcf3LfpzLHoWNzS4m90cE+DO6Bz4VIDK1yBqYEBDMOFzxBwQT/g/2uYPFzHR0vwXf8b7Hgz7hGf4baBX6NlAZs0wtwU+2VsRj37mkqmX81z7AW7HOhkegyy3eB+eFO97FeT6RvJoey08r78RqqNssvN4IRSiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QK/5j2VH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QK/5j2VH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHI54P1229321;
	Sat, 25 Jul 2026 18:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0ap4z0
	P3dEX6S4rpWrhCP/EWtfeEZymSWZQRF0DUEgE=; b=QK/5j2VHBjiGL3TseiVpCH
	amsjZtlrWUp+YtDkcbGNTFdwJ1lRqjwxrD/6GiKtCR6zTLDQSk4BPUXtlf4t//Gh
	MuO/46sIwrYviLp5B0KY4RK39rX3jtkvreqBBkJrn5/ppT5HOER9uoalmHBZcttj
	p0WFArVkfXVlsqottMA1wIvkx8drScafiG73Qpvjtpo+JsbYMxL571hUGBJZBhO1
	65WJ0Jsj54BU9KfuzSf3nFFGEF3vL8RYEfFW3puJY4oPczpPKLlUMTt6nmVYvW0y
	QQvrrO4az3j3VCd9+bAStxxIMN4+88qV6TI5lB9OmV+9Qm05q13pHtR1eobQRKAg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0x90gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:11:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PIBIo5026240;
	Sat, 25 Jul 2026 18:11:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12j4e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:11:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PIBuCL9241188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 18:11:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F7E858050;
	Sat, 25 Jul 2026 18:11:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9EF958045;
	Sat, 25 Jul 2026 18:11:52 +0000 (GMT)
Received: from [9.39.22.45] (unknown [9.39.22.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:11:52 +0000 (GMT)
Message-ID: <ed0005f1-be39-414a-9ac9-23440001ae58@linux.ibm.com>
Date: Sat, 25 Jul 2026 23:41:50 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] perf trace-event: Fix heap buffer overflow in
 read_ftrace_printk()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, hbathini@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>, atrajeev@linux.ibm.com
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-5-tshah@linux.ibm.com>
 <20260724145433.944741F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260724145433.944741F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SZmIchF1y9nqOxmdmTG2ZsIZ7eppdlPg
X-Proofpoint-ORIG-GUID: 3xJcQ6KUVNVaDjnJu7qJafGnGVmMK8bt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX7wzJCl+rYFu8
 Sf2QjTqL5kQHIgOkLBvQkkAbZol9MIqusd8zCbnfCIwJ8uvnvTUc8qErROXnYZ+O0toJQlNsno3
 HTxEjezZD73Q7m6yUZsIVAh24PAOQXA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a64fc6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aRRoLgKOAvR5kCXd9xwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX16LIkSoHpwlO
 uIq1T+7milvCxNhd7mpHew4M4pC6wTa41TDNAw5zqt1t6w+rEYBZKaXfhj1drCjWde8g0yxJne1
 HRqh9IuIIydSEy9B7AmYknvLwNBSTY6HbmfkFZeRbwImqy2nv0mEDwPrM3TNIxpYy6EHfjuXHp9
 zHJibdZGG1REwsJOjCg7djgMdvRxRI5d5dJsGrieGvkZL8XhJjdRNnQmgujerf5nL6gUUbqhqU+
 V1VVYLb8FzpNK5uDYgM0J1CbHJ0l1/MvcQP3FtDvbsMUf4Kk9Mlih8bGnwISfwVkgtR4rtFfSvX
 +347c2Cjn2Ynitw7O7XNVCt0i7wOYVtq/PJRfr8EFx9GR9VPU6sx0jUYeiuiVMVT4izB0s73SJb
 B9FYV6+sQsuoqsBQdVv6gZjHLdr4ijOHX7499d7zhT8aDam3eqRNqjTFN3/4G7j32JQjP02+Fpb
 iv5H4NTxC14XVjVNTlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250169

Thanks for the review.

On 24/07/26 20:24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] The patch uses `UINT_MAX` without explicitly including `<limits.h>`, violating musl compatibility guidelines.
> 
> Pre-existing issues:
> - [Critical] The commit patches a heap buffer overflow in `read_ftrace_printk()` by preventing `malloc(size + 1)` from wrapping to 0, but misses an identical vulnerability in `read_saved_cmdline()`.
> --
> 
> --- Patch [4]: [PATCH v3 4/5] perf trace-event: Fix heap buffer overflow in read_ftrace_printk() ---
> commit e35d114b06414be20beac51dfd3a3e158eba2833
> Author: Tanushree Shah <tshah@linux.ibm.com>
> Subject: perf trace-event: Fix heap buffer overflow in read_ftrace_printk()
> 
> Fixes a heap buffer overflow in read_ftrace_printk() by preventing
> malloc(size + 1) from wrapping to 0 when size is UINT_MAX.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index 52ed496d92c3b..147a3b95ce06b 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
> 
> [ ... ]
> 
>> @@ -180,6 +180,11 @@ static int read_ftrace_printk(struct tep_handle *pevent)
>>   	if (!size)
>>   		return 0;
>>   
>> +	if (size == UINT_MAX) {
>> +		pr_debug("invalid ftrace printk size\n");
>> +		return -1;
>> +	}
>> +
> 
> [Severity: Low]
> Does this code need to include <limits.h>?
> 
> The perf tools guidelines for musl compatibility state that we shouldn't rely
> on implicit header inclusions.
> 
> Compiling against musl could fail since UINT_MAX is used without explicitly
> including <limits.h>.

Fair point on musl compatibility. Although it compiles fine without it 
via transitive includes, I will add it explicitly. Will include in v4.
> 
>>   	buf = malloc(size + 1);
>>   	if (buf == NULL)
>>   		return -1;
> 
> [ ... ]
> 
> [Severity: Critical]
> This is a pre-existing issue, but doesn't the exact same wrapping
> issue exist in read_saved_cmdline() in the same file?
> 
> tools/perf/util/trace-event-read.c:read_saved_cmdline() {
> 	unsigned long long size;
> 	char *buf;
> 	ssize_t ret;
> 
> 	/* it can have 0 size */
> 	size = read8(pevent);
> 	if (!size)
> 		return 0;
> 
> 	buf = malloc(size + 1);
> 	if (buf == NULL) {
> 		pr_debug("memory allocation failure\n");
> 		return -1;
> 	}
> 
> 	ret = do_read(buf, size);
> 	...
> }
> 
> If size is ULLONG_MAX, size + 1 wraps to 0.
> 
> This causes malloc(0) to return a minimal allocation while the original
> ULLONG_MAX size is passed to do_read(), leading to a heap buffer overflow.
> 
> Should a similar size check be added here to prevent malicious perf.data files
> from triggering this?
> 
Confirmed, same as noted earlier in this thread ( patch 2 review ). Will 
fix it in v4.

