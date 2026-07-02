Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63366338910
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976638; cv=none; b=j0y9efK/ZkPNu1SdCJIJ2bRjNiCuK8wvEP0KC/g1gz3Qa3ogLPqXmpuNa88D+OGwW2fpvd1o7dZJK7xlFNrYBu4Unrr3hqZgyfYhl11TXJvijdMQUL43bNzNlDdTEu/mk8OCKqnvmvDfyRFaiuFTsAH4s4/zOjQrNIEni+VTAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976638; c=relaxed/simple;
	bh=MCbw34X9Y660ZAAyGkb8jnmxwHY3K9C/yxyfNVeCaDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j02CtMu7UNDEzSYbdb+N2vFRvtFXu39B99Pqh9GvzOSsEm6RqBjIKhRwh+HCc2oKYNS2vrYAJVfh6a6WnbF6xE0ZFz8qaK239hKYvRq5Lg5FZWOUvRObDcqU1kVWHnKf7tm8jzabkz3bx57TwZ/6YD0BxeT+KxgHp1vWfGur2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iwhgKCa5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iwhgKCa5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KWmc2347149;
	Thu, 2 Jul 2026 07:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NG3+xt
	Xz56VQfjwOkQbBJY41ys0ly/eQuy6E8KfCzJI=; b=iwhgKCa50vN3gyjnZDNuBS
	P2S+TxTIHKjQ1E7KZBEQVhjG3HCRhetk6eFb1Xo02bKxB836eH4VXNtJ5VpAs3to
	LkDo5IjkykKEVZABiEKfeDBNxITO0CZ5oZIpKmmMRlaK+8V+VGFWIAeCg/tQK7/X
	SZ7Z+OTkr2HnTGYKA3r0V0eQgD3xOGn3RngsFJ1MGC/PKZiW+//DTFT9tum2VMY6
	VqTUhTR8BAz/pepuaowtiBeWTLdKxRYqlb11p0aGijAikkfPY5j7FUA6f16Y/u0q
	36lWOgwS+H/j97ev9EY060XwxaDMXOSZ/ao9NMvUetRVBfpOQR8vKO8X1HtEPKzA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk08pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 07:17:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66274lKQ032357;
	Thu, 2 Jul 2026 07:17:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqk4qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 07:17:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6627H1ER26149460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 07:17:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DF545805C;
	Thu,  2 Jul 2026 07:17:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9B658051;
	Thu,  2 Jul 2026 07:16:56 +0000 (GMT)
Received: from [9.123.15.94] (unknown [9.123.15.94])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 07:16:56 +0000 (GMT)
Message-ID: <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>
Date: Thu, 2 Jul 2026 12:46:54 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
        adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1> <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
 <akWEgMBK7Y39sgc8@google.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <akWEgMBK7Y39sgc8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2OCBTYWx0ZWRfX/HFwXSnQGDN3
 BC92Co0rPvetjhZBDoRD2gEnE6d3qNL1xp7JclQ35WExBHdcYjxgwDX3oFIwdla5080JHW7CUGW
 oJylx+UlvaOWFBh0EC7fwrC3X6sLK7BAx0c3rONOLYwrPIYWh5TDg/h5a5ZEDsQ2RAD5OMwzN1Y
 W7t28o4QvoKM0VKuiL2GTXiQv2WuUMg2gPCakKNT11wHZlnWZxgJqilytteOFEdIFXbZv/0+nNO
 evSeduXCV1mZkTUXC9B97xb/6vo892MG7Alsc8JlkYBtgndTPtS8z83r5yqoh82171kLRFXBL4j
 zI0zAWjWFAyrLDb2LN/XpulDkxsuSssOF8/K9UiB5jzs+wZG6rqPNzJ/w05fxtP9xgY66Zr9p2I
 BjfO4F1tmQE9YFdqRW1lN+zyKBf0aT8qh2ifNxSWwDdUbEV+P2nwuHqG4dvmC9fFYLzFR8hUzq1
 yQ006Y54eYV//mf2EQw==
X-Proofpoint-GUID: bNGVK8reAw3Slcxldgndc61Xwf-K-z3g
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a461071 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zBZKncBSZSZn6rxDrEwA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2OCBTYWx0ZWRfX2I/83O3LdYj8
 M5NWPwdC8UpTa22q4XPzBvbcCAMe8cEMiY5zA8cWfVOzDQ3lkajBGa4nvXUA7zpskxYqypDiBZr
 Pw6UTGZi6b5T6g9O9aNIag5pHr/eBGk=
X-Proofpoint-ORIG-GUID: s3NMyxOoKnH6nP66GYEqlQ4w8tzPGUud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020068

Hi Namhyung,

Yes, I was planning to send a v2 based on the review comments to fix the 
pre-existing issue.

However, Arnaldo mentioned that the original patch had already been 
merged before I got to send a v2, so I addressed the pre-existing issue 
in a separate patch instead. The patch is available here:

https://lore.kernel.org/linux-perf-users/20260606121528.406919-2-tshah@linux.ibm.com/

That said, although Arnaldo mentioned that this patch had been merged, I 
don't see it in perf-tools-next yet either. I'll wait for him to clarify 
its current status.

Thanks,
Tanushree Shah

On 02/07/26 02:50, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jun 11, 2026 at 05:23:45PM +0530, Tanushree Shah wrote:
>> Hello Arnaldo
>>
>> Thanks for checking the patch. I cannot see this patch applied on
>> perf-tools-next yet.
> 
> According to the other comment, I guess you're supposed to send v2.  No?
> 
> Thanks,
> Namhyung
> 

