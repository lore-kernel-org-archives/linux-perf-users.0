Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B745039;
	Sat, 25 Jul 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785001893; cv=none; b=ZOwZ/R0OjjcyAwOAB58fbZuOQBGz/BT6CuFEfgtskJH1nOTlBn4mouejr/ig979aiFD5Tpi3Ow+6WbCYiA02Y84b2/d1mOlj8eXka6RjAzpSosTeMkfvt/FHag9UfanNGXvyVZhOoOJBfEa7JAw1Ed50QeOQPAOYonfUki/jRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785001893; c=relaxed/simple;
	bh=do61F/kKDzjTtvAWKAEQbxwn+QmJ7jsHC4k7lNz8Gc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kj08VgCq39+lm/3kXK+PSvQ+TreDN9YnHIiSsGg51w4m4CA6W6YbjRO2uu33QKtR+QKvbkJEtY8eas/ItuQtZJgwsJJhhJF6dFMveCqgTM+T67cisLxcnd5Ibt0cS+0yL/dH+221wmMwZoMe6S3DwhCuWDRWECVP4tDIUNr0hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k8vNA/Z5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k8vNA/Z5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHI4bO1238949;
	Sat, 25 Jul 2026 17:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FkfapE
	O/+i9Cz+Qc3Tv7mMoZfpvG57Ypp4Dh96Uy4vY=; b=k8vNA/Z52jp0Bn3ZDQMC31
	Uj1Evbb5AG0+eidkOQq4MQbCM8bMQ/Iw2Enc7y95pnyokqTvM6DBpnEbCKA2dhPv
	Xnv+lMRdvdcMbyZL/8Y8rlMlvnEBHbPz3Y08FNQaVSjxTBE1kU4oEMNNn9NJkKZl
	z6rJDXQMWbb3hUXZv3IR3M374HX9BZV9Ufz7TstdwP0APUhq9XonLIlz5aa1Mx4H
	wzRFaZYsaJPcjIDp66bHHlsHENxDTmSjrjcpexRkpoqqt4IsZbbm2+nq4vLD7IEW
	Mq7MdJYXoerbzsBiOxUZBEhR/f1eTPOuX1UN8PSTCgUSc1PEmAYOso5us1ppWOrQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcgwkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:51:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PHfM6U006300;
	Sat, 25 Jul 2026 17:51:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn33223m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:51:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PHpK8t26608172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 17:51:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A56458050;
	Sat, 25 Jul 2026 17:51:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0337D58045;
	Sat, 25 Jul 2026 17:51:17 +0000 (GMT)
Received: from [9.39.22.45] (unknown [9.39.22.45])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 17:51:16 +0000 (GMT)
Message-ID: <7148147b-c2b0-4d97-bf22-b4bdb50e768b@linux.ibm.com>
Date: Sat, 25 Jul 2026 23:21:15 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] perf trace-event: Fix integer truncation in
 do_read() and skip()
To: sashiko-reviews@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>, hbathini@linux.ibm.com,
        atrajeev@linux.ibm.com
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-3-tshah@linux.ibm.com>
 <20260724144741.5D8FE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260724144741.5D8FE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OwBmTsuiC-t70IxqJcHgE9qk3YGSG1EN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX9UFl9zd8R0px
 ScI124CzQABxjj958OYArpf4dN3+MTpf+oprvFyvsNq6i/lXYn6ob5g5xK+GAVAwWzBVN8EzbBg
 PVYArPkSjBtkRIaYC1NLxtDQXAGadDE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a64f79a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=q3s4UKAsdI4kwQSyZB4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE2OSBTYWx0ZWRfX8j31prQaU1zW
 YalQJAkn/mMEQlUgHTgNIVzjOTfFotWtuoKsBeDwQdvqXxNuIsrWBF9WODCas8GhCoOOJ11ja4Z
 GSWnrLsE3fcjx+1b3uIR2NYb9cqlStgbZZDSbUVYw7QfN0tlE/6UWSwjHG522JEFIdPon4qTmwk
 i/MUk59F7mPH6/K2c6r2xRpyZ+NqsvCwyn4DORHP4neGdLJVRI5/cNHKPnPROcMUr79GQld/VWL
 oq8lMrf0Nl5rlx7pfPzHjHQEm5WZggx+SrHJi+7vqSc0Xd7PkjvS8JI6xjOUU4Yk7omO/L8LUr3
 aQROCm8XABI9/Z5o7HGysR8EwQxZpW11fSpaVR+3CxY/YEzUdSbiVM2yVJKqY8mRAYBbyOGXvnh
 dTLIUUrXdBOFX7u1ht7R6qo5X0whVhW89JxcnIlNo3WdvB0Xl5EyrrUNZjoWAu8U2E+8txvJ81c
 eHFJ22JzJrRGweVkGkg==
X-Proofpoint-GUID: yOPdKC0Dp_K_sTehRMy3zh5eHqVnGxfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250169

Thanks for the review

On 24/07/26 20:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Integer overflow in read_saved_cmdline() leads to massive heap buffer overflow
> --
> 
> --- Patch [2]: [PATCH v3 2/5] perf trace-event: Fix integer truncation in do_read() and skip() ---
> commit 907c8b1b7591be61f25cc72141dbcdba5822dfa4
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf trace-event: Fix integer truncation in do_read() and skip()
> 
> The do_read() and skip() functions use 'int' for size parameters,
> truncating 64-bit sizes from callers. This causes two issues:
> 
> 1. Uninitialized memory dump: do_read() reads fewer bytes than
>     allocated, leaving uninitialized heap memory that gets written
>     to output files.
> 
> 2. Out-of-bounds read: Parsing functions process the full 64-bit
>     size while only partial data was read into the buffer.
> 
> Change do_read(), __do_read(), and skip() to use size_t for size
> parameters and ssize_t for return values (where applicable), matching
> read()/write() system calls.
> Update callers to use ssize_t for storing return values.
> 
>> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
>> index afd458cf1387d..52ed496d92c3b 100644
>> --- a/tools/perf/util/trace-event-read.c
>> +++ b/tools/perf/util/trace-event-read.c
> 
> [ ... ]
> 
>> @@ -350,7 +350,7 @@ static int read_saved_cmdline(struct tep_handle *pevent)
>>   {
>>   	unsigned long long size;
>>   	char *buf;
>> -	int ret;
>> +	ssize_t ret;
>>   
>>   	/* it can have 0 size */
>>   	size = read8(pevent);
> 
> [Severity: Critical]
> This is a pre-existing issue, but can this lead to a massive heap buffer
> overflow?
> 
> In read_saved_cmdline(), size is an 8-byte value read directly from the
> untrusted file:
> 
> 	size = read8(pevent);
> 	if (!size)
> 		return 0;
> 
> 	buf = malloc(size + 1);
> 	if (buf == NULL)
> 		return -1;
> 
> 	ret = do_read(buf, size);
> 
> If the size read from the file is ULLONG_MAX (or UINT_MAX on 32-bit systems),
> the size + 1 expression will wrap to 0.
> 
> The malloc(0) call will then succeed and return a small heap chunk, but the
> original unwrapped massive size is passed to do_read(), which will loop and
> read an enormous amount of data directly into the tiny buffer.
> 
Confirmed. will send a v4 with a fix for this.
