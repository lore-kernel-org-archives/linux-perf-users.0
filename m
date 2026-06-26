Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0B3E0234;
	Fri, 26 Jun 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488319; cv=none; b=ZYqcghOn1+Sxjh+m1LYiaa8Egkud24BZdUYq/F1NowFg43or882dQ3keAkfyqsiKti6m5IhHpTzD4kkHSMIRX/sra2Dm3/zOTSW/TGbm2gulFEsLH6yWH3SUsRsYDhbOCaojMb5hDQI0KlclhJ7FQ5kdE0wpw2u0jAWqWdAST14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488319; c=relaxed/simple;
	bh=M2QWtGBmg9P/yJMY7zTMOQRY99YLRtA2GtYBqmv6fcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEf8QmQXU4w3gUtRJlqluCMbHS9sc6RxZt8EOQwFRlXGI+tXeu+CBBwcwLcNmYap58N7NT6RcLt8froc5yMtyM/8tjdiKCNh2Yz355GWDyKVP9wvQN2ZBtHRecULMKPyJNcWp9V5yacy2V5yhbVsimrisBmZkjYOrAV+lG4zfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r+a2bVmZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r+a2bVmZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFIJCg3555346;
	Fri, 26 Jun 2026 15:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ieQQ59
	4hIHktNShyhA33bh90gKxBbfEwMWg/CI4yNN0=; b=r+a2bVmZGpol7sUX8kprQf
	aze97a9DT4ay2ry5c5vmXNYom0JmtrhtVZIs/M0NSwwHC1lQrVYtcOyFQAYHLC59
	0IKLhCa+5TmE7abdUH18H2dIgwFwDV+fquwx322YfEIcsPQv5nLrlzGMlVE50qnm
	BZM95dTzgScDY/cGq97PzuFg01Kds7NiEfCUsXVYDd6i08IPKECI84lFonFCKmKx
	2nnDeQaCsR5UfzV/pDnj8L3SDQ3ZxiRLAl6MNslNCSnEy1+ufOAuCtwVwRvDfhh/
	2Kh9dkXv2YyF51F7umF++b3u3gG0Oiest+R8PT3y/JDYB8PRz9zzrfIYb+PXw4sg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr7pkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:38:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QFYdto002097;
	Fri, 26 Jun 2026 15:38:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwuvf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:38:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QFcXZd21561870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 15:38:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC34F58058;
	Fri, 26 Jun 2026 15:38:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7693158059;
	Fri, 26 Jun 2026 15:38:31 +0000 (GMT)
Received: from [9.124.221.251] (unknown [9.124.221.251])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 15:38:31 +0000 (GMT)
Message-ID: <45ccef84-be0d-4c5f-b686-358ff29a7290@linux.ibm.com>
Date: Fri, 26 Jun 2026 21:08:29 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf dso: Fix kallsyms DSO detection with fallback
 logic
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
References: <20260416091657.578429-2-tshah@linux.ibm.com>
 <20260416110905.3A68AC2BCAF@smtp.kernel.org>
 <714f2022-879e-4f6a-9b1c-cce06be6db65@linux.ibm.com>
 <ajw1-ivLfQo3psZa@google.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <ajw1-ivLfQo3psZa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3e9cfb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=whIH0kqEkjxX7mCK2xEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX9CZzAd5RhNK6
 CQQLOmFaa8+p0moqmA3EkjmYD8KtrTS8ro479jnLtxFvmxPT5AJG2hyS9c262/jyPY4JUgbvKhm
 tqMoXEZxYyylUSF6/wbDfhuI6YG113ENw4wpili5/NWAoLhVkqr36erc+81iCPxYTX51JnbtzL6
 QImuGjOXWcYN1qJmyHKQgpXwIJmCgpYJf8ovo0T4rbqqoUCN+i25ZV+iLBqdbiBKvw4zZzEsU2j
 FbUzKl+NFDwMfppVAtFH6BOuCIP0qoR0NRPZkeC5DX0CCDtiIGqHiGCgICPg1Va+rUnUS1fU2M+
 w87oWMRXOuKdU/G8Zx3VDfm3O4KCMuPGIkzW4csjeSIG8eifWHsFYg/V4nZGtNJuOnyv0W2+1Ox
 Up+AqatpxZJ6JAr/g7uxZH7DEnfBzjHQQUX+6lohZv6r+MDqp6UVw0O15xNSoOpe9tq0krP6pSa
 pdTlz+JzgBu+Xs8uH+w==
X-Proofpoint-GUID: VtoDwTUC_2d6qHT2m-k1ios1dQYSiTEy
X-Proofpoint-ORIG-GUID: KJN2G3GI3YxQtBPMFa1kz4YJEHBOycs7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX7Gb+shb/5gBj
 eDCU5YuZqOmVjUmK6oaGCwOdsfPGBQVbirzuOyVAslrls9c2UxJgLaCgVqkf5Vm8cCOeVvTEWmx
 u7fhubWB7/dsTrZACmYlJ8wQV55Cu/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260126

Thank you for the suggestion. The reason strcmp() was not used before 
was due to different variations of guest kallsyms. I further did a bit 
more analysis and identified that kallsyms can be in three formats:

"[kernel.kallsyms]"
"[guest.kernel.kallsyms]"
"[guest.kernel.kallsyms.<pid>]"

I will implement v3 based on this.

Thanks,
Tanushree Shah

On 25/06/26 01:24, Namhyung Kim wrote:
> On Thu, Jun 11, 2026 at 06:04:23PM +0530, Tanushree Shah wrote:
>>
>> On 16/04/26 16:39,sashiko-bot@kernel.org wrote:
>>> Sashiko AI review found 2 potential issue(s):
>>> - [High] Path Traversal and Information Disclosure due to `strncmp` matching any prefix.
>>> - [Medium] Incomplete fix: Fallback logic is missing from `dso__is_kcore()` and `dso__is_vmlinux()`.
>>> --
>>>
>>> commit 9ee80283f13c6a0a5235a2add7a94736c1dfcbba
>>> Author: Tanushree Shah<tshah@linux.ibm.com>
>>>
>>> perf dso: Fix kallsyms DSO detection with fallback logic
>>>
>>> This commit fixes an issue where kallsyms DSOs are not correctly identified
>>> during build-id injection because the dso_binary_type is not yet set. It
>>> adds a fallback string matching check against the DSO's long_name.
>>>
>>>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>>>> index ede691e9a2495..515ab6e95b0e4 100644
>>>> --- a/tools/perf/util/dso.h
>>>> +++ b/tools/perf/util/dso.h
>>> [ ... ]
>>>
>>>> @@ -915,6 +917,14 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
>>>>    {
>>>>    	enum dso_binary_type bt = dso__binary_type(dso);
>>>> +	if (bt == DSO_BINARY_TYPE__NOT_FOUND) {
>>> Since the fallback logic was added here because dso_binary_type(dso) is
>>> DSO_BINARY_TYPE__NOT_FOUND during perf record and inject, do dso__is_kcore()
>>> and dso__is_vmlinux() require a similar fallback?
>>>
>>> Looking at dso__cache_build_id(), it relies on dso__is_kcore() to flag the
>>> DSO for special caching logic. If dso__is_kcore() returns false during
>>> build-id caching, kcore DSOs are treated as regular files, which causes
>>> nsinfo__realpath() to fail and breaks perf archive for kcore sessions.
>>>
>>>> +		return RC_CHK_ACCESS(dso)->kernel &&
>>>> +			((strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_KALLSYMS,
>>>> +				strlen(DSO__NAME_KALLSYMS)) == 0) ||
>>> Does using strncmp() here allow a path traversal if long_name is
>>> intentionally crafted?
>>>
>>> If a malicious perf.data file contains an MMAP event with a filename like
>>> "[kernel.kallsyms]/../../../../tmp/leak", this prefix check evaluates
>>> to true.
>>>
>>> Could this allow build_id_cache__cachedir() to construct a cache directory
>>> using this malicious path, causing build_id_cache__add() to unconditionally
>>> copy the host's /proc/kallsyms into an attacker-controlled directory?
>> Hello,
>> The current code relies on dso_binary_type to check if its a kallsyms dso.
>> While running perf archive, the code calls dso__is_kallsyms check to create
>> a build-id dir. But till that time, dso_binary_type is not getting set yet.
>> Hence, this patch introduced usage of dso->long_name to check if it is
>> kallsyms. But based on the above review from Sashiko, it seems that this may
>> create a security concern.
>>
>> I tried to check for the possibility to set the dso binary type before
>> dso__is_kallsyms gets called. But, I found that dso binary type is getting
>> set based on dso__is_kallsyms only.
>>
>> So, I am looking for suggestions/approach that we can take here.
> Can we simply check with strcmp() for the whole string?
> 
> Thanks,
> Namhyung
> 
> 

