Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3130E82D;
	Wed, 15 Apr 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236207; cv=none; b=I5QyVVIZ8d9QzAeKBDlfb9jayZmK+djhLWEQewW+aPn8Vj7jLlVoFtbxo5YhoYTyJxVE1Ejch1xlvSwFvRUbOe9Jy5XsrD5uy3wSyRO6Z2ig43xpwNWI4tMODyqfIag9M8EiDE4Pkfo3hnpO8dvYHrp+FBbcUMfDH9LvzRE7yKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236207; c=relaxed/simple;
	bh=MVX/vYQurhaopMrf+nsihoTaRYybtqgxwIvNR5JY+4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8IjGJchX8pxmZvBpmQPDI/Eqx6x4E9ZLNxUt1f8mqXCYlKNQS1phCKKOtglT7DtGHABPgfn41gDZDCyXHP31yOOSS9dzUGvuTMWe7ZJoVQ0znPA2z+i1VS1Rgn0v4DCBrZ1Q4Cr+pBS3/zxbYvk3SjdxtrM8ConqHCAkfH8UhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E5K8/ydj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E5K8/ydj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4q1MX1842840;
	Wed, 15 Apr 2026 06:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s7FiuM
	MxGzAPUeniN10CFqtTWCLOjA1F0k5lQ+KohKg=; b=E5K8/ydjsvXET6jBB4QXSt
	8N87lEYR/IPjbGEGW3zLgNI+IBvbI2PI6YOB6ToxpXEn7lFg1w7cS5u9PXdATRMP
	Bceyt2g1WIHd1RPV0Nvo1/hw9ZF1lxCelSgLd/saAo8GgcrxahsyWDpdQqR47AAq
	EFy4Q4y0NFvBHqQpNzDRwsqw1nu/U0YBuoOmRJfR43pXiwdPaqOIy0xdmYHZVUq/
	kQ5Z+SE7GJSkUg7HguwFG3r5gUw4Gfa108Yxp4gBzUlN08qJ36ZObaZOXwwDsxx5
	AYfE0pDwdLdF5N2i+St01EAGWhxHCliT4t+SplvuaxmJi+eMtqkNQ2ejmsTnD14w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mpqms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 06:56:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F4t4JV025801;
	Wed, 15 Apr 2026 06:56:44 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1mtq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 06:56:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F6uhWL15467214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 06:56:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C7A58063;
	Wed, 15 Apr 2026 06:56:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61025804B;
	Wed, 15 Apr 2026 06:56:42 +0000 (GMT)
Received: from [9.39.27.100] (unknown [9.39.27.100])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 06:56:42 +0000 (GMT)
Message-ID: <157c4ffb-0d81-4394-bea5-12a9b8f08307@linux.ibm.com>
Date: Wed, 15 Apr 2026 12:26:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dso: Fix kallsyms DSO detection with fallback logic
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260410071225.708005-2-tshah@linux.ibm.com>
 <20260410081724.69B1EC19421@smtp.kernel.org>
Content-Language: en-US
From: tshah <tshah@linux.ibm.com>
In-Reply-To: <20260410081724.69B1EC19421@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA2MSBTYWx0ZWRfX6r1X3As/AQQN
 hHXkb3PO2eG2+XM0pcDhT4BCas5xlig6PQa0AsprFwRzrhGYdCH6rPSnCcH7tvtQHuK8uIPx7aR
 P0rS1HUKKB8wBThPnXUQrkjo6rHpbxARuHfirHq2/XPDsx0PzetstSKogyW2RyhPyL6jT/NoxWj
 lkx/dWR49zEOXyhp7h5CLQow0Ri6XZ7kCTxt3d0zq1uzjw/+Hdv0qvfDiS0o3WXP6TsUM0m4cIO
 oB9q2TWLM+AwsRsoTeye2699UpunWdCa0pvT/80vRN7bAws/Z1df0IvzAx2CyJ9gQXQuuRsYAmG
 GRhNVZpGr/bv7rs1ia/5GDRtx9hCzd1ioLJ03Sd8iPGmTN6ENBCRG218DU2wWLrcuKo5XZemPjT
 wOmd0XDMYdDo/8035icAFbWAk33zc9T/yhuGDrumaLXCxoSK49PfGEFdeOb3DVhbLSQy2L6JtpF
 mCvP+fZL8Zl0D2m6TLw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69df36ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rFWBiRdqTB6FeBwMLQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DblJSxG3F5sRKTabsH1nI7H2UlsS8guz
X-Proofpoint-ORIG-GUID: DblJSxG3F5sRKTabsH1nI7H2UlsS8guz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150061

Thanks for the suggestion. The missing closing bracket is intentional. I 
Will rename it to DSO__PREFIX_GUEST_KALLSYMS to make this intent 
explicit and avoid confusion with complete name macros like 
DSO__NAME_KALLSYMS

On 10/04/26 13:47, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] The macro `DSO__NAME_GUEST_KALLSYMS` is defined with an unbalanced bracket, which is deceptive and prone to misuse.
> --
> 
> commit bff739892129d9369935f2dfb42b44d83b2f857d
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf dso: Fix kallsyms DSO detection with fallback logic
> 
> This commit fixes kallsyms DSO detection during build-id injection when
> the binary type is not yet explicitly set. It implements a fallback that
> matches the long_name against known kallsyms strings to correctly identify
> the kernel DSO.
> 
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index ede691e9a2495..e44071998c499 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
> [ ... ]
>> @@ -20,6 +21,7 @@ struct perf_env;
>>   
>>   #define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
>>   #define DSO__NAME_KCORE		"[kernel.kcore]"
>> +#define DSO__NAME_GUEST_KALLSYMS	"[guest.kernel.kallsyms"
> 
> This isn't a bug, but there is a missing closing bracket in this macro
> definition.
> 
> While it looks like this was done intentionally to allow prefix matching
> against dynamic guest kallsyms names (which append a PID) using strncmp
> later in the patch, naming it DSO__NAME_GUEST_KALLSYMS implies it represents
> a complete, well-formed identifier like DSO__NAME_KALLSYMS.
> 
> Could this macro be renamed to something like DSO__PREFIX_GUEST_KALLSYMS
> to make its intended use as a prefix clear, preventing it from being
> accidentally used in contexts expecting a full name?
> 

