Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1939448A;
	Fri, 27 Feb 2026 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772171819; cv=none; b=BDJgWdQ263/Rwkq/DU82bBx59mp0aKSszXCOJUJvPczyFPb//kXaOe+KLm+cYR82aX8n7iMdsPluEnZfZKY2uL9SEgoVTj8ZgQozWU7uDd72nTydbqG+qgYMD4bj60tr4UZcCw8JmbxFRaJ84n0ktDKrYqCYsAtcZxoUttyqmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772171819; c=relaxed/simple;
	bh=YI3Lqou24OzJ6XspOaePodbUgk21I6kVmOQYtT0IBQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ9k+seBkCF/gbphDSGc+rvFsomqF8+N8X0yLPd9cvyETLGodZLDYRsT7gj93qlKz+NCcimJdHjzFRRhVefgFa2Kmnet7J/uabVhOFlSp6abu7HPXiH62OBBZPuqKD6HWzmAKZgRqgtGA4ZGRP/HEtPc2J329GpDHvWGNz9KyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gpt9gYD7; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gpt9gYD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772171746;
	bh=Y2KhPymngzGSQBE6OR3Anz/5+GL7wtEraMjjl76OOn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gpt9gYD75clUIWlRXu8niAXnfyIExLdxUP4kU8aILOKs6F0Au2zJtt02JXZ50rkZn
	 D/8TC0rr78MHohNX+Lvurxc7k2WF5VueeJZxQHrjFFQ1fHdIOQmxBnqvi7aFNNtP+r
	 0Cykd6bfQovmAVnsdLalPu2V+dLlnM5ySFozw7p0=
X-QQ-mid: esmtpgz16t1772171738t10cc486f
X-QQ-Originating-IP: eGIBuzSkTpesFVA6QPbkBaPKQDnm5sd6Q0EQNVNElTk=
Received: from [10.3.91.191] ( [101.70.127.119])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 13:55:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10523106758613680728
Message-ID: <81DC457427F3336D+a6fef8d6-cb0c-4ac0-bb18-49d22ccda4b3@linux.spacemit.com>
Date: Fri, 27 Feb 2026 13:55:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] iommu/riscv: Add HPM support for RISC-V IOMMU
To: Yixun Lan <dlan@gentoo.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
 Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <F9748E3984D2A6F9+cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <a9d9f43a-edf3-419b-bdf7-dbd6bf9e978f@kernel.org>
 <605D8D5AE96AEF8F+31d65ad3-3956-49ae-8d9f-589747a5086c@linux.spacemit.com>
 <20260213222135-GYB164498@gentoo.org>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <20260213222135-GYB164498@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NImvdRhE6fHpILLafS3PSInYXCirFRrcim74DrthE4tImMH7+Ah1KPjf
	xh+RnTjZBd50C381F9C5FqgcThZzAeutLJ4kvjcQK5CUUxZjnCW21z2bW111x6R0hNkDAw0
	6hMD+G37d8kRaHULK3/0kZdJcKl0DzycCFSOZgaKUXY6MnfIln+byPfupClfFyCcSdEeIDA
	bxS7kG/xmKWDOwgOJb+pUSeQaOKWm4FwjNXY4RkPBySkoceLClInaAoSdZ6P3xYTtEJpgPv
	n4OMckLy1oSfLM/hkzTdTfo1KPMaXO66SduqjrQgmvoxu/sLIiGd4yPvO3+ne/DaEqYH1hI
	DxPSonjNQ/nJhiQ0dXbgmcE9MKZlwzcdGw9IkBDFROu0m3N+b9t6hS+skVHxctiWNjg2tSG
	GxGXeNm33vWvk6EamBKVcObAd+fwTjB7x7WO7daV/Mezg8p7vtvdI2xBjGLgcOjDb0KgALp
	iBls3bhGKB4rnWr2+yTa8Fby5VqonR0POABlVGF9hPPkbK50cuhWV8dCiH0jJnKRXH8EIVJ
	K2NLjb2rOLMjeLHC86H2eNzMQizfDpn8SgMbLRrw97vVE3zz2bELUwA1rvP70X6HRNums2t
	ligWvQ1dYFw+ZpXZeX4SlrU2glo7efdo+iw4BHClVyWr3YIYBp2NY/S7y5agE1pJlhbHayD
	4UhBKwItWQw8TMeOgxOWV8DJZz9fkLV+j6ISQktrcvVMRZJIpdUmv86t1d4LSk9yMggBgSb
	P+chjbsgb68bEJsyOPD6LPHjdNUpUMeUqmhWI6fu8wTZYxQ65ztXbopWS4QLHoTsRhLgsFn
	kaNb242Y30F2KcMqdYC4Zr2ClcLhnaRfAxp+1k3+bWUbD5Ss0ebervj2dJ1lJxDcmgzFkM1
	wXPhbT6awwM5iSxI9lbsPCQuioOaqS7nA4GtjJN/tYQ5OlAm3+YtWOORXAg2k0cC3LcvqXh
	oq6jynVTR0o2bvH7xz1W8Rw8+p01p1z8dnB4ZnhhLD3sOjoZMaA3HJF03yUvM+pNUbGItZ4
	zC9KJ7mqS9pmHw0x6YXFNeSaQ6AmVIPHtw/DRWPYma0Sz7niux1lEyHEc1EGA=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On 2/14/2026 6:21 AM, Yixun Lan wrote:
> Hi Lv,
> 
> On 11:41 Sat 07 Feb     , Lv Zheng wrote:
>> On 2/6/2026 6:44 PM, Krzysztof Kozlowski wrote:
>>> On 04/02/2026 10:08, Lv Zheng wrote:
>>>> Includes HPM support for RISC-V IOMMU. The HPM hardware mechanism can be
>>>> found in the recent announced SpacemiT SoCs (K3, V100), where T100
>>>> (SpacemiT distributed IOMMU) is shipped.
>>>>
>>>> Revisions:
>>>> v1
>>>>    Initial release.
>>>> v2 (sent as v1.1)
>>>>    Split and cleanup DT-bindings.
>>>> v3
>>>>    Refactor using vendor specific compatible.
>>>>
>>>
>>>
>>> Do not attach (thread) your patchsets to some other threads (unrelated
>>> or older versions). This buries them deep in the mailbox and might
>>> interfere with applying entire sets. See also:
>>> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830
>>
>> Got it.
>> I'm still using an old fashioned upstream way to collect all revisions
>> into one thread. Will align to the preferred style.
>>
> Using b4 will automate this procedure, you can also take a look at
> Konstantin's articles, and the b4 doc
> https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1
> https://b4.docs.kernel.org/en/latest/

Yes, we've tried b4, it really can automate this process a lot.

Thanks,
Lv

> 
>> Thanks,
>> Lv
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>>
>>
> 


