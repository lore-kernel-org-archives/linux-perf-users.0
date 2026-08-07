Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5F376BD1;
	Fri,  7 Aug 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121360; cv=none; b=XF2z/y3sRBElPWVp/B3OKBsSnUfDTQrMcrZj976i6x0tf30agSoX8VDiRqtRzELPylAuldLQjt1QxkHFjkXnbJF/A0yKKxQ7/WVegQzbDTDX8Nuvkxm0MAeRwXEWxodFmRgsVDKVnQFWRAKpm4COiTzih2Ie9FM0MyBj/+vWJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121360; c=relaxed/simple;
	bh=yTH89Ygm7NMs+En5edfrdgWhElRIBOp+Qi88o0jxhrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FleYE66I0m3VaV3TLPaguuLi74H0s/nSXrp6pTaVS/FtydCQpI31lFvuWmsHD29IfFHTzlKBPtFQ3UwMF5td/Q0aEDiDIhp4HJcrwsOZiRglO6j2prj1f3jy397OoOtius1EAkdE0tPbhzKYQGHzskm7F6SfRUjHqOJU7x94Ks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CBd0YD5G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CBd0YD5G"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Gm4oE1938165;
	Fri, 7 Aug 2026 16:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8G9K1Y
	fzPAOpp9kuqfWMV8+X6TOB8LCoW+SxJKq4qfg=; b=CBd0YD5G2W4nQR9rNecXSw
	qDPTnBNOEqNe52g9BtR505MpxK9Gpt1j+VMxS8YsvMvHdYnEthoEu2FT2hrjOcvx
	LXnyDqQUz6TIUfMzI28MsRFp08749LicxuvLxQLjDlrt9qJ4AJyDMPbQB9S8xCdA
	Y7lh6q764NZ0wjqEVQy4XAvleXqIroBUoKxGEdJD/Wfo3I71NWkzN+R3eKGI4yeN
	JgoGz4zNpqtYr7JWHLyiwMAk9H3XBP2w1ahdKg8Nx7o5k1YliE0PVNXbZZXtfDoM
	N7yiP65d525p3Xr4FVUFIyGIrBFiAPqI+Asu0jq0KrjJ5zffLnVmEpiW9LqfhZtQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy024rg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:49:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GfH8j017348;
	Fri, 7 Aug 2026 16:49:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwgkh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:49:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677GnElr15204916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 16:49:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E41C358054;
	Fri,  7 Aug 2026 16:49:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455675804E;
	Fri,  7 Aug 2026 16:49:11 +0000 (GMT)
Received: from [9.124.215.12] (unknown [9.124.215.12])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 16:49:10 +0000 (GMT)
Message-ID: <5575bfe9-6ccf-4462-9ab2-713f6d5f6b77@linux.ibm.com>
Date: Fri, 7 Aug 2026 22:19:09 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixes tags need work in the perf tree
To: Namhyung Kim <namhyung@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <anXtnqxN5PN4ULmF@sirena.org.uk> <anYKNuAVxu6TyJ4w@google.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <anYKNuAVxu6TyJ4w@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: XdprFF_GdUFEsFBSB5220g4LDaJHLtW2
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a760c8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=RNl8BxoyZRO5kRr5AS4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oN7SFVew9kYolzTxDG3BmFg5oHAcGpsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX46vtvKO5ulWX
 VdyABiAIHbRcuVcYx2b9nmMj0Do2LWri/Nhcgt85x4FFxR+GZKVUN8PsnqtYdAYz03FUe2y4tEH
 OPaCahoAVvnkgLuoVV0lXCHFnjMkD36VlGAG6DF1daX7SMl3wEzxcfRKVKgeuumGCUC6OPrTVCO
 eo73PwUI8LlMy37gbrCX1Vj6AlDZhaTfVSO0zRWQz866DDyqaZpmqYiBot3EHkUXWjSaB3jNv2m
 UoxTcMgUV1c+knfB+6h37nyBgZfQe5X3sts4eoM6LJBXB/zUJCuVQkbuhIXL6mCyqQjJRg41p8c
 Vk9DDLDJiuEgmI56mBZzsmANjo93sj+ELVN6Iiq72pMdAiLHWTTgBQxYJvc2iUQ6eBPfVf2MXVJ
 73flILGP+msPRXsmSkU8IuitXy0BjUaZ+uqnq7SxyVFgsqasfC3jcJdJ60itI/CUHhEfv03CegP
 2wigIFCTU/jthmypU5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX0gcdeJEaja66
 EuCKwDFZz7X8x28Gq6/ynwW8hXpCPWMYELekbCulSCTP6E91CPJcezDROzqfcax9s2REVj+us42
 gPzCHEcSqEn+qJ4XZ/JUwaznzmSU+KA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1011 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070131

Apologies for the incorrect Fixes tag. Will be more careful next time.


Thanks
Tanushree Shah
On 07/08/26 22:09, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Aug 07, 2026 at 03:37:18PM +0100, Mark Brown wrote:
>> In commit
>>
>>    8782a10c74e85 ("perf trace-event: Fix integer truncation in do_read() and skip()")
>>
>> Fixes tag
>>
>>    Fixes: 454c407ec17a ("perf tools: Get rid of read_or_die() in trace-event-read.c")
>>
>> has these problem(s):
>>
>>    - Subject does not match target commit subject
>>      Just use
>> 	git log -1 --format='Fixes: %h ("%s")'
> 
> Sorry about this, I should have checked it more carefully.
> I'll fix the tag and force push the branch soon.
> 
> Thanks,
> Namhyung
> 

