Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE7318EDF
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350472; cv=none; b=FoFZhRE10AkKvrsTKDqTZDmptwRpX2nIXs4UQGqU3TxXS8GKVE2RnkEFggMbO/eIW5U1K9dmtei24DiSv1DyCIP0V57xXhQFccFXmSUR8/33IaTXRqVOBdUUhiMAO8p/IISVhGam/kGPCq12gnI/u0p67DTsMbSZy4s0lXEdRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350472; c=relaxed/simple;
	bh=QG+8lD3sXRzohUKO6LV6DWO+gSoLA789GHs4h40/4G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDijMmdFlc3Jl8wb5AvLr2KgMX+mTOPo++S+m4U8hxWmpNBgtM5xlpLb1u4y3u+OdFBsicPmMt1TzYm0jv/mCUSb3nDpMFbw9rtdF5XpBa6XSh9Ola6d/+kt2PW0cBvW7Bu4gJGAH3L5lOVkDINIsQNfJUmsaFTzLguW7j1pJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R5o2FlBF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R5o2FlBF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NJtDbn3111761;
	Tue, 24 Mar 2026 11:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IdJXTy
	EO82Ru1iNtXkchM6iEKX+rtchRpyWzxFwuTEM=; b=R5o2FlBFVT1Ygis2HFv4PM
	5mDU+4fjx6pMKbkPdQCqPoyMEiWsQvQ8dJJC8JyzhRIPrcITqZWe9Ehdv43Oa8Cb
	/dOk3xBfWti2eseUBdx90G9v3/wRRyes/hu/lzIw9E1O0WJbBe7ZCv7VsnxBbjUE
	6+8PItOIKW1Ra0Gq72W4+1GTfj/B01hxbFac5TN1Lv8r2PWF4Zdi60FgxT+6zeKV
	0gsYOMGLFXiS9OIpgixOmQWfFbXEk07SHxIs9TLignwxfBf8IYn8K9a3afw/SR8q
	0MZp9Zhf2NQiU9i5rYJ8m2RqGNing4LvkZ9eYX1+q2UIbeovaI4fKvEgfwY8Qupg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumjhq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 11:07:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O8xCmP004375;
	Tue, 24 Mar 2026 11:07:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2181n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 11:07:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OB7U1G52035878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 11:07:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3792004B;
	Tue, 24 Mar 2026 11:07:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1B8320040;
	Tue, 24 Mar 2026 11:07:29 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 11:07:29 +0000 (GMT)
Message-ID: <cd24821d-2357-4203-85d1-8db37ac11640@linux.ibm.com>
Date: Tue, 24 Mar 2026 12:07:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf symbols: Fix module symbol resolution for non-zero
 .text sh_addr
To: Chuck Lever <cel@kernel.org>, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260323155804.7216-1-cel@kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260323155804.7216-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GS9HO3aOGLMio27LCc3HEH0zb72qDG97
X-Proofpoint-ORIG-GUID: GS9HO3aOGLMio27LCc3HEH0zb72qDG97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4NiBTYWx0ZWRfX/FsZwVJZVcLL
 vtUJkpqEFPstlG9ZSeyNHafHtesd+HgPz1rd0kLogIH7fNLdxz80eccmAYXXvKgAN1nO6cBIDKh
 fVIY6XecuwVNUqftR+boiAWrmZSQDA08rx8TxeCLdj+TBitW/6H/Z8lICz2UashM3jAQLNBwE1g
 hNpLlIZlGtWaw+XxJ7e0KRWC0bNmkpbDEAPc/W+O8XLn6jPS+wvaJFpGGtuBeXSQapcme9W5Zhs
 MBWuKz828msOFyb9umCg3l95O1je1fi1kWRJrE4Ig95QZUhxO0bYrru36/daOuB7hopvfAbJbw6
 fCI4fqjdyoy699ZZF8aMjckJSnimtS+in2vJI82T9SywP98PdPl4dtnmX9SOZE8CH2mK382GaEl
 uPco8kRFykwBEdvo9x8vahHG4GQtF4Mg04Jxj+XQ1qS4SMivTVHKru6zCyVXgUOLDr50nYLWqwK
 n1J96wRsX2w6XEI0+pw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c27074 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=KByoUL483hSIROooWq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240086

On 3/23/26 16:58, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When perf resolves symbols from kernel module ELF files (ET_REL),
> it converts symbol addresses to file offsets so that sample IPs
> can be matched to the correct symbol. The conversion adjusts each
> symbol's st_value:
> 
>   sym->st_value -= shdr->sh_addr - shdr->sh_offset;
> 
> For vmlinux (ET_EXEC), st_value is a virtual address and sh_addr
> is the section's virtual base, so subtracting sh_addr and adding
> sh_offset correctly yields a file offset.
> 
> For kernel modules (ET_REL), st_value is a section-relative
> offset. The module loader ignores sh_addr entirely and places
> symbols at module_base + st_value. Converting to file offset
> requires only adding sh_offset; subtracting sh_addr introduces an
> error equal to sh_addr bytes.
> 
> When .text has sh_addr == 0 -- the historical norm for simple
> modules -- both formulas produce the same result and the bug is
> latent. As modules gain more metadata sections before .text (.note,
> .static_call.text, etc.), the linker assigns .text a non-zero
> sh_addr, exposing the defect. For example, nfsd.ko on this kernel
> has sh_addr=0xa80, kvm-intel.ko has sh_addr=0x1e90.
> 
> The effect is that all .text symbols in affected modules
> shift by sh_addr bytes relative to sample IPs, causing perf
> report to attribute samples to incorrect, nearby symbols. This
> was observed as 13% of LLC-load-miss samples misattributed
> to nfsd_file_get_dio_attrs when the actual hot function was
> nfsd_cache_lookup, approximately 0xa80 bytes away in the symbol
> table.
> 
> Use the existing dso__rel() flag (already set for ET_REL modules)
> to select the correct adjustment: add sh_offset for ET_REL,
> subtract (sh_addr - sh_offset) for ET_EXEC/ET_DYN.
> 
> Fixes: 0131c4ec794a ("perf tools: Make it possible to read object code from kernel modules")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  tools/perf/util/symbol-elf.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 76912c62b6a0..968e269d9be1 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1356,8 +1356,12 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  	char dso_name[PATH_MAX];
>  
>  	/* Adjust symbol to map to file offset */
> -	if (adjust_kernel_syms)
> -		sym->st_value -= shdr->sh_addr - shdr->sh_offset;
> +	if (adjust_kernel_syms) {
> +		if (dso__rel(dso))
> +			sym->st_value += shdr->sh_offset;
> +		else
> +			sym->st_value -= shdr->sh_addr - shdr->sh_offset;
> +	}
>  
>  	if (strcmp(section_name, (dso__short_name(curr_dso) + dso__short_name_len(dso))) == 0)
>  		return 0;

For s390

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
