Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732B3DA7DC;
	Fri, 27 Feb 2026 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772171763; cv=none; b=FJZX+Qs6fZ4ztLX0kd+RRYp7y7eBdFi87S8xyMHp33nEAktp0qeLLmdIIBCFHAtt72BPJJVlxn8Ixx8/Ci6YP9YKycb95WjKan2XU3N0BFD4lIeMXEtYcjUU2sgPHSk2G1c+1YyFxFhL70ZxjChc6Ra3EuEjzpjQkXMJjyssAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772171763; c=relaxed/simple;
	bh=yeOIPJbgUrc1uxWwrVvE6mQkO5mRvokavu1J3DxbPKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rpk3at7d2PoEBJGMeHJQtd1lU7L3STdm8Zt4UecK3MOmlW+SVVZG1WoJFBaj2//7lqg4I6mugwx7x5P/Rr1UK3bRWRGHTDpu0AOv3Z+J8J4xUQKSrijv9HRVHrenxBDxnfy7hUu0UQDTXFiCn0RULqDBwoTF1NSQgJb/VIZCq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=LZYHo7AS; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="LZYHo7AS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772171658;
	bh=BYVcnLRn5v+cUDho0LUkPdukvb67I+Jv1XckyKd0gtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LZYHo7ASIxLEbyCRB4psngQDbysF1j8g+7HaUij4HMWkkjljEGTM+DBswss03lA71
	 pt68imgi4astxjjG2FZOLgP2fb5miUl0jYKVpBZP/ah+Wknk4shLexVSe14jK20wxt
	 gcwyVn+w3JID0Dzo1CE+3SRC+s35sF2XSPCkEVc0=
X-QQ-mid: esmtpgz10t1772171655t42f02dc3
X-QQ-Originating-IP: pBeg9DsutXave9qSV7etrk0iKgAsjpTita/phqPQrdA=
Received: from [10.3.91.191] ( [101.70.127.119])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 13:54:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13968557730430242067
Message-ID: <E0900342298E5A5F+1e5c6ddb-3049-4488-9af5-ff3f1eb1544b@linux.spacemit.com>
Date: Fri, 27 Feb 2026 13:54:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: yaxing guo <guoyaxing@bosc.ac.cn>, Zong Li <zong.li@sifive.com>,
 tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com,
 conor+dt@kernel.org, krzk@kernel.org, luxu.kernel@bytedance.com,
 andrew.jones@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <20260208063848.3547817-1-zong.li@sifive.com>
 <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
 <1e2b448f-3a2a-4b1f-872d-a34f7bd53696@bosc.ac.cn>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <1e2b448f-3a2a-4b1f-872d-a34f7bd53696@bosc.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MkzizgG39dTmeNimumP83xEw97EsKF3YZlPUgL5vYgddkC2Mwl3brOlN
	BekazWD46ExloUKyLtx8axETI9oGxwFryU3Hkv8UY/NQl+2rYGqojW8tKmmzCc/BpE/plj9
	A4ZGDD24sueNJI9ae5Pg8WWT2nQpnYdnPWbgwmHExfoJxLmbiBwc9F+XPgyyWzBLht5xwpL
	9lrfhwIgw2FI5zMh8FMrgvoUKFE/+8saqYqYbH8fHUbgsfNdhMo9gVsurRIqgnpUovw8Gna
	R+37RqMcf+hML019nnBeiSg62lRGW7jX8khQns+IPqGqDtSbs9jIO0LN2JeWNPm5FqxlF14
	0IeWPqYQBbjhf7sTZB6ddnDuFvNsdjQFIzzWYNzY01zYdQwYoX+G3GjOt3C79RmF75b6lp0
	EgZMEP9ndXl2krnXcOahM5Av7xbBojIq5qP9e0AFR1eiBYt9Jms+FIkPg4zB/Elfy3l++nI
	ifi3DQZ5u0Jh9hRyhWMW/JxrbVNt4WntTvHQdxUm0/3e5DlUqnQdOtlXHQV+Rnr/aVQKCJP
	5/71zSbcJKc4eN0GSqtxk2PeGSjhoYAr0Iz+PWpAmpV9kVeGYrFlmM3K2fXzJdvNQrN0iaM
	orPWfm5P0taVG8L1/Y6//WQwsU3oFS17R7JjzYCU9hdb31XSACkyia9WEtVsilDo2WRiHi4
	9S31c/3znSuWHvYJIxaduRrDxg50Oa2+QnXYZ+j2s5CdcXcVgOBucfwRGw0/EriwuQe57A/
	wdhH90hD07T58ZxQjn2FhJjqM9u5axnfGtlCnl/cd9x+vq9hJrNYkZaeEboAlgjRgwXicBg
	9GJar0QNUPyer4eUr1frxAivhGcVFJNwmqNi1nASS/WlRE+UUERzLF4gfF6vHvWj23/xrOW
	SBjVhDTdedgUMTtJIGJg2kr2WV26wzE+xhifrmkAB7PJTdU4WYInInlBv5Xrfw6SrNDNAu0
	b35GiHycYn2rEvFTWrSQhwcbcyJ4skFHiocUQFPWq2wjy8SeFTUMwPXk2+qV5K0nL2VyHTV
	3vtg0UacxM2me+5ZA4gUeDnldzLjp3NbzG+je1Eg==
X-QQ-XMRINFO: NI4Ajvh11aEjTGfg3rCZA0snif+LPcv00g==
X-QQ-RECHKSPAM: 0

On 2/9/2026 11:21 AM, yaxing guo wrote:
> 
> 
> 在 2026/2/9 9:40, Lv Zheng 写道:
>> On 2/8/2026 2:38 PM, Zong Li wrote:
>>> This series implements support for the RISC-V IOMMU hardware performance
>>> monitor.
>>>
>>> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
>>> created by the parent RISC-V IOMMU driver. The child driver can obtain
>>> resources and information from the parent device, such as the MMIO base
>>> address and IRQ number.
>>>
>>> Custom event support is not included in this series and will be 
>>> submitted
>>> as a separate series. The idea is that custom events will be defined
>>> through the driver data of the auxiliary driver. When the parent IOMMU
>>> driver creates the auxiliary device, it should pass a vendor-specific
>>> name as the device name in order to match the corresponding auxiliary
>>> device ID.
>>>
>>> After my initial RFC and the v1 patch series were posted, similar patch
>>> series also appeared on the mailing list.
>>>
>>> One was from Yaxing Guo:
>>> https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
>>>
>>> and another from Lv Zheng:
>>> https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631- 
>>> ac1c352a469f@linux.spacemit.com/
>>
>> Please do not forget to Cc:
>> Jingyu Li <joey.li@spacemit.com>
>> I only provided T100 specific support in the posted series, and the
>> new approach of the HPM driver in the same series is composed by her.
>>
>>>
>>> Yaxing has agreed to pause his series, as discussed here:
>>> https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd- 
>>> b99e-7358347fc171@bosc.ac.cn/
>>>
>>> The motivation for sending this v2 version is not only to address the
>>> feedback and suggestions from the previous round, but also to introduce
>>> a major structural change: the PMU driver has been moved under
>>> drivers/perf/, which has been mentioned repeatedly by several people.
>>> This results in a different driver structure compared to my earlier
>>> version and the other two series, and I'd like to gather feedback and
>>> suggestions from the community on this approach. If the community would
>>> prefer to go with Lv Zheng’s version instead, I am perfectly fine with
>>> that as well.
>>
>> We'd like to know if there's any comments related to putting IOMMU HPM
>> driver into drivers/perf folder and want to know if this is necessary.
>> We also hesitated if riscv iommu hpm should be put into drivers/perf,
>> and according to the followings, we finally decided to keep it in
>> drivers/iommu:
>> 1. drivers/iommu has already a folder maintaining all IOMMU stuffs.
>> 2. drivers/iommu has already defined HPM related registers.
>> 3. Unlike PMCG of SMMU which is located in a separate namespace, RISC-V
>>     IOMMU only defines 5 registers in the same address space as its
>>     translation schemes.
>> 4. For HPM schemes that is not a standalone device, Intel has put its
>>     perf driver under drivers/iommu/intel/perfmon.c.
>>
> 
> When I previously submitted my RISC-V IOMMU PMU series, Will（Will 
> Deacon<will@kernel.org>） suggested placing the RISC-V IOMMU PMU driver 
> under drivers/perf/, similar to the ARM implementation. He also 
> commented: "I'm sure Robin had fun dealing with shared MMIO regions 
> before" — referring to the discussion here:
>   https://patchwork.kernel.org/project/linux-riscv/ 
> patch/20250915020911.1313-1-guoyaxing@bosc.ac.cn/

Thanks for the information.
We will also follow this suggestion.

Thanks and best regards
Lv

> 
>> Cheers,
>> Lv
>>
> 
> Best regards,
> Guo Yaxing
> 


