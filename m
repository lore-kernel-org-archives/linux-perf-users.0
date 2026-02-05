Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008692DB792;
	Thu,  5 Feb 2026 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263635; cv=none; b=nBhiz2zS+djEknbrMec60t9I6wnApHBs4I//Hv8mr8o4ULID6qGYY7ZPBDpETZ7508yPo30SRJWTnHCYAJ8ZmHDuNsnt2BB5qRIMeLBCVr7jtO1/SjzXkrYNuFE+cPMUPRaUK96vX8ur4RaPVHm/Azs3XScRZ/bSm3Kj5RXM3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263635; c=relaxed/simple;
	bh=j576Tw3IZWEMhrM/QWalhIW+vLOaGfIzwjuYc2xooXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9Y/Pi/xhaKjlOXobjfyhAbQtBeyL9U7n4KPDDw8p6+LVjEVnvsaic974f5/VWnja7Ulgxs+PfNKz0n5YV5zAT8VRHzUzsa0VGqZDGZwHeA6iNcWI+QLJjlDkj1YIh7T9hfSsAP1QMxC8R2lCoE8aDHrlijRP69wL07uH/5pp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=XlenU/tt; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="XlenU/tt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770263587;
	bh=wm69aKVjK11vnsxnHJGFhJ/kRVDFOCLUX2gZdnB/g8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XlenU/tt4yQUCIrJDC+2/APViDsEw4d00JQvlV0iwlZ2uuiQF7lDbo9uSlSRCNFMr
	 hEMphAOcNd3dtaQbzJ6dxTmO5C9wxtItD+Dxi1uG5bdof0ukAqUOE0EGOupBOvGYLM
	 9iREnwjbv5GQyB688icYQeuRrZkl5gB3n1B6tTnc=
X-QQ-mid: zesmtpgz9t1770263580t421bb8f8
X-QQ-Originating-IP: EPC+6trZL3LdU7ynQgp73ZdxqgtF89P3sFaSDK6EZQ0=
Received: from [10.3.91.191] ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 11:52:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1569306416083050966
Message-ID: <927D288E956D61AD+d1488c72-afff-49d2-bb6b-5ef5ea08b627@linux.spacemit.com>
Date: Thu, 5 Feb 2026 11:52:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] iommu/riscv: Fix WSI mode IRQ number handling
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
 <2ueryrki7uzpjn6rbqz7scy46sjhw76jjilddz2naslz3eyfdp@ycwf42eaw5yy>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <2ueryrki7uzpjn6rbqz7scy46sjhw76jjilddz2naslz3eyfdp@ycwf42eaw5yy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NkcbD1JCaMYVot0ytSeIR7Dz6bzvlckuXTyS4hOhnUigvUCllm6MGiMN
	/BLUvEGgC1Stx1pm62pHC8S4zCGpznfJSMRS2ZTrFHXc+6cFN7T6uDveXanpClvzm6K5r/C
	lmi7fSEfffeQANGGKdohROR+rcsxANxbe6YCgPA8MXWcpM2QfuLD69VWe8NkGBgQQMLXo+A
	5jqITmrz5dQXSKWZP1dN/X5kU0RyUqoKcWdhDzz/vp1HgKXmvS5s7Yukx8QWgSz/EIN1fAW
	KDlepZO49gPVFCu1IC3GX/lVjAG09kSTDXjmMOjxjJ7VeaEHZ9Sm1WFFyfacKHynV0wjIcf
	s2j1uUNvIAh7Oz1QM6y5cEfs8ZBGHcb7yZLB9WK+WwrqDKH3iACiH9nfzZZW1TjPNF3GH5g
	EnHgsuZPx8Xs8axjTAKSgA8b7Ywf/4iZyMNf3aw3qzOx8RZ3F0bpl6MyVzjW2KoeS0R9i0V
	ce409LN0yXuVNpElzLmWY5vxRC7CnEi6cKrF+Pf1wjzAMbhTcAbAf22QuVTdmGwZ0trTp1C
	hVbr+lTcNhRIE6GARbcftpOadWOM7nLwuZKDq8Gdtnhyw8O+73KxKP7fqKF29ByVc8nIWWw
	ZP1UidPBfBXc9fp04xDVq2JPSOmycZUaQ3Ii3jSBB8TzNa50Kh8ygSpaN/Db1YJwAQWE4uO
	K8wjJF7DJ6ienD/rVR5GxWsb/RGRp3of3EQMG4k1nmFEOlt6nmhl5ibqJe313ohvquujU6d
	zDz7QGrCDzMzntK5Txt1fcLvaNPvkLN2c6+Awu4zPWm/TZFg40rOyvtc879pNpqL/dzGvVW
	TNfCNqcL4z/gBRs8j622dAN+YTldYaW3F6gkPVZf66nsSja9NOecU6GBFYvWvQEIH78B30F
	eoXInXTP7yVfImX4YrVBgUD1HhPQrTUGEDUFgXnay6nQLS3bpcLT9yfIojkqQL1BE6/lVSK
	nfw2aXh/Mu0BCtcT4cTGcQVt/8h/wJFvnuuKJw96M/AIsyluDvL2cx1/0mzVkl3hNw4xlFo
	Kbo3xJVdfAeKtUunaOU86X2n4F9AMZjh3P5Van4bd2c2vTRcNC
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On 2/5/2026 1:20 AM, Andrew Jones wrote:
> On Wed, Feb 04, 2026 at 05:08:52PM +0800, Lv Zheng wrote:
>> From: Jingyu Li <joey.li@spacemit.com>
>>
>> In WSI mode, ICVEC doesn't exist, thus reading it returns 0, which
>> causes IOMMU driver to fail to find IRQ numbers from device tree
>> IRQ arrary. The issue is fixed by applying icvec indexes of WSI IRQs.
> 
> ICVEC always exists, however it may be hardwired to zero when an
> implementation only supports a single vector. But, that has nothing
> to do with whether wired interrupts or MSIs are used.
> 
> If ICVEC on this IOMMU is always reading as zero, even when 0xf is
> written to it first, then it should be interpreted as there only
> being a single vector (or that the IOMMU's ICVEC is broken, if the
> number of sources is known to be more).
> 
>>
>> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
>> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
>> ---
>>   drivers/iommu/riscv/iommu.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index d9429097a2b5..26630979473b 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>>   		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
>>   	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
>>   	iommu->icvec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
>> -	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
>> -		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
>> -		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
>> -		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
>> -		return -EINVAL;
>> +	/*
>> +	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
>> +	 * Check if FCTL.WSI is set to determine interrupt mode.
>> +	 */
>> +	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> 
> The behavior of ICVEC does not depend on FCTL.WSI
> 
>> +		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
>> +			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
>> +			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
>> +			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
>> +			return -EINVAL;
>> +	} else {
>> +		/*
>> +		 * WSI mode: ICVEC is not used. Set to identity mapping for
>> +		 * riscv_iommu_queue_vec() to work correctly.
>> +		 */
>> +		iommu->icvec = FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
>> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
>> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
>> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);
> 
> It's certainly not correct to set iommu->icvec to anything that can't be
> written to the IOMMU's WARL ICVEC fields and read back again.

Indeed.
It looks I can keep icvec returned for WSI and keeps the write-and-read 
check logic only for MSI.

Thanks,
Lv

> 
> Thanks,
> drew
> 


