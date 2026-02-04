Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F093019C5
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225608; cv=none; b=YAWV7Bsu8OJUN/Aar6DqmLsqJbjlDOqA+uB3aUse9vu5a1wjcH7eZNVftvzmDomse2Dkd4mWTQbCUeK4luZybUzVfMdtuRisz/HDZzO5blkFMci0DDgCVxklwemAxG853Bp8i1lnMf4968HZuVSwP28NLrml6biWdYjbTqe/Gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225608; c=relaxed/simple;
	bh=EMpRL583vOWVeU4W0hEVRiaRUtKRmUWLFzWTRy4Ou08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFARDeB0wMzFOhu2n/dAPw9uwUMr1Uy3xT6eoz5K/9D7L4NWzMkcXnM1w4X3wLEUa36NDw4btdikd5X1MptUq3k5+gVxUVJnZxl97Q1sh+Rpn5wePxp8mxtDKD8ldEV/T2UnXxr0l5kKVsbef7f5XNPl/sxlllV/LTUBCyVWPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFXJtpQs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M19LPpot; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFXJtpQs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M19LPpot"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIZx82166692
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2026 17:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VqbAWXuLedjCbn8BYtmfIasp
	H5UsLnVKguhalwtG8iU=; b=RFXJtpQsyEAGCCdZN+tDGI9L+WnvNuqSXFUPk8L9
	lcAV8QvF1PnH9HeHklAPrbDeLaVkFNPfY8c3UgGUI4EC0yeA03RXXmCLgORfy3hL
	KVcJ1zFrs5V+FeyD/jJZtLCaSnblXlrD/e2iMwaTWQ6/lZmbkG2kbAbSB/OchxCI
	rAwqTIFgW1q162Z0LnS9X+2XxBK6yJHYZIqcYsrFbSulI6tRip2YEyjIv508+M/C
	rSXjno9CW8ddAYdTBezoBmT2oNQlpPOMcuxD5OZGgKECkqFnWF3VdjpbrdiIBtQ6
	Hd2zFwgYsoabBkf4R4ISsr6e6dIDNZ41PO5UT6mM/Ohciw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c45nvh22x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 17:20:07 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-124ac76ea5bso849617c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770225606; x=1770830406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqbAWXuLedjCbn8BYtmfIaspH5UsLnVKguhalwtG8iU=;
        b=M19LPpotTWzLtZrca930shBffvHIRCkeCQ2abQastp7yLcmiIIceFjSDBvt0MhbA+i
         aUXSXgQW+Ez952vXmsS6WnQKK03jcXDtMG9Eqk1GGIDqkVQy3I6HBBg1hZyozehUUcaH
         RGM4JuIM4MYL3feizVeuNUm1HKA+3FnM1Gk1fa+TDxbQLyRTJBqMsobXei8FinI63E/F
         DCInCz6PpQQSgw2I4ggAuKCNN/tM/m2gxRfCAwi9qAWMzLb0r300+EA7Iavm/p1JSae5
         C1s2jic0r3EVx/Vnc3V3XpdbbLshzA87iRu+B9EUnD+JDaIgCsnJAcGka031JLFMHR5a
         EREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770225606; x=1770830406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqbAWXuLedjCbn8BYtmfIaspH5UsLnVKguhalwtG8iU=;
        b=leT+gDfqOMHrik4GjiZkjNh1PPH51cy0zYnj1NRsJ/n6G1BFkVyg7JuZOMhaXUdzad
         JoHRClZyoD2qjLELSbyxVAE1xIPhF43S/EZrXyH8Ad60Ta52sbcokjkXdMEDwprbOK3I
         aad7BoE6bhSSv3Pr2N2fHuBMKpyy2mgTIjEA2kk7U2fGEgiT7XYPnAtgYxLayEjv6BK3
         5EF1pm9fnjST30il4/q04+Ss0ijBl46ZxeoMvTcg1B3IvC0ZR/cTb0r1jGmuceyGMTQ/
         ODEvFwnnYlLDZjmzROwiIDhWcs0C238eIxoyXLoA8Ay78wElmLGyT39dGxCo8HEwg2T8
         hE2w==
X-Forwarded-Encrypted: i=1; AJvYcCWxa6vMYDi87Dy6996uZmgAX0b8PhTxDBz8jYXfTBSLgpQCp9Ohu+Z/KPRjbW/FEJnN2J8rDf9+Rs23qRLgWhjA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ILnL4EtOhj6/vGn0noab4gBDF7ryVRPv4FntGTNgQ15K/zWv
	xaxAd4RDt/K14/VVAxEoKEfvDUt/lcu1jw09r5dKdrozn7rWiYl905Jh0EuOdJdxUUEKPFaRJN5
	X0QUJEutpbKRJjnXRH4MQI+ZSg2kPF8KhZAPUy3RtZo8wIGVYK2b/DLgiwxbGERLZzEFiAaoV
X-Gm-Gg: AZuq6aLUK5qiNIATpz2lzL+cl7Ee7hI9avPOtXyQYeRCHqucl65JUK6lOwE/Soz2pHU
	hNaLw8ZO/jxpuT+RT0x1Z8ymkBm2TE553VdO+r2N2utNHOOmCuBYnLXQtVnmKp+ojsXa3MjNZhM
	6fgrdPJH/cLx5wo1Z7m6LbqAYh5DD0Cdnzqu+hJLW8vD0+UXeW7zbi59+g585Bl4aaBGOHRKyEF
	k14pytIiXzY49fUrjFw4yRmGQs4+h+870nsORPeBcqV10S4P1/3qTie5gedXK5UQcnHHbKcsDj0
	ZfiBEr45Vg/WbzGVxm0jFWzrnt2XzlzwZGFeIOeWrucj2+GYZ53Miwf0euP7FzGjsPK+WOgxCFL
	1BNDUb1yeJA/pFWRkeKA=
X-Received: by 2002:a05:7022:69a2:b0:119:e569:fb96 with SMTP id a92af1059eb24-126f4771f0amr1691827c88.5.1770225606330;
        Wed, 04 Feb 2026 09:20:06 -0800 (PST)
X-Received: by 2002:a05:7022:69a2:b0:119:e569:fb96 with SMTP id a92af1059eb24-126f4771f0amr1691793c88.5.1770225605519;
        Wed, 04 Feb 2026 09:20:05 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e107b4sm2433926c88.7.2026.02.04.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:20:05 -0800 (PST)
Date: Wed, 4 Feb 2026 11:20:03 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/riscv: Fix WSI mode IRQ number handling
Message-ID: <2ueryrki7uzpjn6rbqz7scy46sjhw76jjilddz2naslz3eyfdp@ycwf42eaw5yy>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzMiBTYWx0ZWRfXweqLeEahGwsc
 jHEAJqNzLs7RqfmzBzRhMc06tUGt1scuUqXeOmK+sTiTITL4+vaZaRtrfOxzET57PKBoFuBuzfb
 UOg6qdZl/7paYJre7ND68JSUoIxFr91Trrr2sUsSkSuf2/svsu+N0Ois1m0RKpVZw/pdd1R+hWR
 mBHF+/cvqpquJDUGwyYIWlTHa1/o/52IGFPpCfkup9pDk35SQBS77hSiLW/6/Ay/Iv+pElyhuiB
 7t/2SzKMLYKKrzISxdRjGBUJBuRsGYCF0Z8aKYBI1H26OTT3nH7amK7qK/8BnMnNiRHp6oa4toK
 /2DOGCIf5yqdl+L5NuyLd9L27C0HplT6O4770QJmcTLtebLOcxNPzGFA69CChke7SbZlhs8Z+FZ
 /Vg0wVam1HR1BkwzBj8931ZcSYV1faPT+xagQp8rj5j/p5Dn+8xJv+keBbElKcCGM8NLmeaHe2V
 SUx20LbETyxze+BFTqA==
X-Authority-Analysis: v=2.4 cv=DLmCIiNb c=1 sm=1 tr=0 ts=69837fc7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=lv0vYI88AAAA:8 a=vzWCA-T3srDMkzUxSWUA:9
 a=CjuIK1q_8ugA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-GUID: Z53ZcvsIkh-RenAgXVV0AreXLmAxZgdw
X-Proofpoint-ORIG-GUID: Z53ZcvsIkh-RenAgXVV0AreXLmAxZgdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040132

On Wed, Feb 04, 2026 at 05:08:52PM +0800, Lv Zheng wrote:
> From: Jingyu Li <joey.li@spacemit.com>
> 
> In WSI mode, ICVEC doesn't exist, thus reading it returns 0, which
> causes IOMMU driver to fail to find IRQ numbers from device tree
> IRQ arrary. The issue is fixed by applying icvec indexes of WSI IRQs.

ICVEC always exists, however it may be hardwired to zero when an
implementation only supports a single vector. But, that has nothing
to do with whether wired interrupts or MSIs are used.

If ICVEC on this IOMMU is always reading as zero, even when 0xf is
written to it first, then it should be interpreted as there only
being a single vector (or that the IOMMU's ICVEC is broken, if the
number of sources is known to be more).

> 
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> ---
>  drivers/iommu/riscv/iommu.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index d9429097a2b5..26630979473b 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>  		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
>  	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
>  	iommu->icvec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
> -	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> -		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> -		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> -		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> -		return -EINVAL;
> +	/*
> +	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
> +	 * Check if FCTL.WSI is set to determine interrupt mode.
> +	 */
> +	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {

The behavior of ICVEC does not depend on FCTL.WSI

> +		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> +			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> +			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> +			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> +			return -EINVAL;
> +	} else {
> +		/*
> +		 * WSI mode: ICVEC is not used. Set to identity mapping for
> +		 * riscv_iommu_queue_vec() to work correctly.
> +		 */
> +		iommu->icvec = FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
> +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);

It's certainly not correct to set iommu->icvec to anything that can't be
written to the IOMMU's WARL ICVEC fields and read back again.

Thanks,
drew
