Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989233EDAB3;
	Thu, 11 Jun 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181271; cv=none; b=f8Idss40KoFBxGNtJAzq9rrixd2PyPrIg+5Ev4SSxy1zwLjQtRPCer4RldCvaaUj5WFOZ9TP0ekpa1BE8Z8ZSGYx/xc+bKweBkQfw3HwAQn2OM1kINpNXcV5tUydsnPQ4gmA8OdnqyeRLzGyIN0XZ/p3CjcCkrLJdgviUW5RbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181271; c=relaxed/simple;
	bh=v9oopA01v+bowqa2CZtgvVOhMj7Mrcafb1n9eJIaq48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWjhHDR4X7Dh+4v2CnydU7xH1khMIY8u//n6BrZeE3srtrTNM/TTNiXAa2hd465qPk0X8k6LQdAFfcrv0k361u29gW5vTL9l8bX0Wy/35IzsOHzWPAdAa15m3X40tE7k+NaBRdNgfhpj7ZqoRsu27ze9o9eRxJc46ICpjxL+Vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=obrZwMSJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="obrZwMSJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BC30oM3872814;
	Thu, 11 Jun 2026 12:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a9TcYe
	X6xQ3G4Kbzk2V5B+E8LaoXRFCExKkKPHNgmHI=; b=obrZwMSJSKAmHpI+LtMlld
	vr/wx8yAsND4gD6+AuJc6D4p1rdsFwWIS2J+oC8GVs63IIoFQaSDBXLMy62LFHDg
	c1fcFiYDbfmdO2V0gBFN5n5Lx31oJVaPT1jq0TXWzxglblMG/Vq9bdPWUaCOCekj
	g0Nxl5wVPxKpSMvgWIMhSyTvF+J4x37SKdS3PjpqwjQD713NusPdxVQYa5/8w8c7
	d982WUIRpv36AvHdQOIkNcvjImDV1PZbO01BDyFwZZd5Y+QjJPVS4AJ723bpQClR
	D1mAZ5hF5kQylWpcYous09E33jKKDR5aw2/+KWFdyGemmKgahBxmisM8ICqEQLWw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8euf27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 12:34:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BCJa9Y023978;
	Thu, 11 Jun 2026 12:34:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09k50e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 12:34:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BCYQJm5964540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 12:34:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 951B858056;
	Thu, 11 Jun 2026 12:34:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9360A58052;
	Thu, 11 Jun 2026 12:34:24 +0000 (GMT)
Received: from [9.39.28.34] (unknown [9.39.28.34])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 12:34:24 +0000 (GMT)
Message-ID: <714f2022-879e-4f6a-9b1c-cce06be6db65@linux.ibm.com>
Date: Thu, 11 Jun 2026 18:04:23 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf dso: Fix kallsyms DSO detection with fallback
 logic
To: sashiko@lists.linux.dev, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
References: <20260416091657.578429-2-tshah@linux.ibm.com>
 <20260416110905.3A68AC2BCAF@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260416110905.3A68AC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMiBTYWx0ZWRfXxIfSchAZ19m1
 t5iLhO1n2Cb1lLIDPAPmZrjpSF8GdWYh0wt9YDftzSYJGrdE0iMI1Y1qcz3LDqE9cpOfsu5qg9X
 EVNCdJ9kwaKm2Nfkg9ZVw1MjbMz6ivGxuY4nZ4RCEp5hyzv7oD6Fmvmnw0V3Gd3d2P0B4oiixlU
 EfCnNRRuXr3pXYWQJj01qteS3vJIDwcMO9rlX0tvMOJ/kGhLt0vOUxilwQhztpZHE/cIhKy0UHs
 T/2QRM7P7SfwcCGQJ1nYVoarkO1rgdo5cJPeA0sSr1cOFhuc5I+q8pioR8B1Ex25EU4HdgGsgkw
 597UY12XhuwLyyzUZSMSUQIaPI0IGwJEW6FSQzieYExg9brgvIejZTNXjVKavWmb8z4XVy2YHoU
 DSsyueoqoZpJax4Uq2Ezfks1mFhRInpAhXnhPapp1Q0j/wxBtZfPOIFLMCNRkIL410+MVnQqbEa
 zSp6IZ9KggIGAlgbJkA==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2aab54 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pYMxprL7IShqr10o3WwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2e2KJJT-BPB0xH0JtDnRILrYmFdBprtC
X-Proofpoint-GUID: -_Vyr6AeAQt6fi7a6e97QELXn4VY8i9A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMiBTYWx0ZWRfXzQF3ruzMQ06f
 MDrOfjPCCKuT0ImuXXeoQnV31cI/RBSCu+6RUbp2tlp9l8gkTTik451MHNjzbu/utHomG5uqqCb
 07d3WFeCn/YkOGm9SCnlji6qhZreSEU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110122



On 16/04/26 16:39, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Path Traversal and Information Disclosure due to `strncmp` matching any prefix.
> - [Medium] Incomplete fix: Fallback logic is missing from `dso__is_kcore()` and `dso__is_vmlinux()`.
> --
> 
> commit 9ee80283f13c6a0a5235a2add7a94736c1dfcbba
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf dso: Fix kallsyms DSO detection with fallback logic
> 
> This commit fixes an issue where kallsyms DSOs are not correctly identified
> during build-id injection because the dso_binary_type is not yet set. It
> adds a fallback string matching check against the DSO's long_name.
> 
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index ede691e9a2495..515ab6e95b0e4 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
> 
> [ ... ]
> 
>> @@ -915,6 +917,14 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
>>   {
>>   	enum dso_binary_type bt = dso__binary_type(dso);
>>   
>> +	if (bt == DSO_BINARY_TYPE__NOT_FOUND) {
> 
> Since the fallback logic was added here because dso_binary_type(dso) is
> DSO_BINARY_TYPE__NOT_FOUND during perf record and inject, do dso__is_kcore()
> and dso__is_vmlinux() require a similar fallback?
> 
> Looking at dso__cache_build_id(), it relies on dso__is_kcore() to flag the
> DSO for special caching logic. If dso__is_kcore() returns false during
> build-id caching, kcore DSOs are treated as regular files, which causes
> nsinfo__realpath() to fail and breaks perf archive for kcore sessions.
> 
>> +		return RC_CHK_ACCESS(dso)->kernel &&
>> +			((strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_KALLSYMS,
>> +				strlen(DSO__NAME_KALLSYMS)) == 0) ||
> 
> Does using strncmp() here allow a path traversal if long_name is
> intentionally crafted?
> 
> If a malicious perf.data file contains an MMAP event with a filename like
> "[kernel.kallsyms]/../../../../tmp/leak", this prefix check evaluates
> to true.
> 
> Could this allow build_id_cache__cachedir() to construct a cache directory
> using this malicious path, causing build_id_cache__add() to unconditionally
> copy the host's /proc/kallsyms into an attacker-controlled directory?

Hello,
The current code relies on dso_binary_type to check if its a kallsyms 
dso. While running perf archive, the code calls dso__is_kallsyms check 
to create a build-id dir. But till that time, dso_binary_type is not 
getting set yet. Hence, this patch introduced usage of dso->long_name to 
check if it is kallsyms. But based on the above review from Sashiko, it 
seems that this may create a security concern.

I tried to check for the possibility to set the dso binary type before
dso__is_kallsyms gets called. But, I found that dso binary type is 
getting set based on dso__is_kallsyms only.

So, I am looking for suggestions/approach that we can take here.

Thanks
Tanushree Shah

> 
>> +			(strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__PREFIX_GUEST_KALLSYMS,
>> +				strlen(DSO__PREFIX_GUEST_KALLSYMS)) == 0));
>> +	}
>> +
>>   	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
>>   }
> 

