Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED84218B2
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303870; cv=none; b=F7mbEyKGH6afcgny1N0g9pn+lb79u+lmw+5IJyuJZZlURjzjY4r/XYB0wtMAZi13pfC+hfKsnCjgQGdp3ssRZ/DTO+hwzhMpHRsaUbKbBEAE9HygDnAFekDjIzIO9L7zcMhXqpLUMQNh90WuHgLa8BUnV9fANXtbc+gsu3rL99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303870; c=relaxed/simple;
	bh=SUsEwkuyVvNP3vyBu9cxsyIKK9MZJsYqzp9t9GalqBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZDaeEGtHUvf41S9+sQ9Er6sKhzRLKPOGqPOhaS+80U87rp4f9YJk6efOmsJUt315z8fabaGd9CQj4yISQE/Ogu1PJV+O2I9Mgaj275k9uyzKx2mIT5i9sQ/iKvN0R36Tlllg7i9B39VMbiI8FRbn32gxeyI6qanSbbie7RjLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvdZEEh9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIDMILpc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvdZEEh9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIDMILpc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615B40iU176910
	for <linux-perf-users@vger.kernel.org>; Thu, 5 Feb 2026 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KfBltjWFs/4bjLl10PANJ+We
	wubPhQqXLGvIdvHvBRo=; b=OvdZEEh9XkPxnIwQcO8fsStOxA7WybJudPm1SCz+
	XQ+z1brLbXcUFfSgLIZCWzoy2jRfANeM6wwnOxYVNoSDwyBs/y/7x84JC2lwgiU5
	05x9skkTvIdMC6LHpFImXlJMqa0DMau4loxb9fKpXzryA2EovY+LCtU0LJn1iaBp
	Sk2d0uqf2x5NVk5pAB7MCjMzBap09SrJA2KKXacL5/dkW/IaKgDVnAYUQ54h4zuD
	AHX4PVEDKrBviVzdf00Du6PHrYlQvmgwiZcYLcgtVu9GL+0ahE0QPqbCdLPc13Z2
	FFBty+5mqMDEkZzACzI495/LgKdmO/2yd/8QduqH3p9FrQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4t0p0pv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 15:04:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b831ff242eso656374eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 07:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770303868; x=1770908668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfBltjWFs/4bjLl10PANJ+WewubPhQqXLGvIdvHvBRo=;
        b=GIDMILpclx5NclCkKmJLRLQGTY7bG6153xdZic2SqtIYvM2JUFgwWb+d+nrnYQTQUZ
         kXcshOtTkPW7drkF93Wqqp8sB0MMRfhl71Z0fIFdCc/2SHDLJ0k1So0XLVo93/4LQwco
         DZkstFZ/rxfybupQOCt2u1Q3f1gU6sUxN+Ax51VtAeKWDYUbrzNaBxsKKp7SIXampEgH
         jDLUjU/hbBRpqomCoLoFmPQUlRAo+8Zj5Iku46EHqHOMidZjZpKhuoKfoLzXQOiUwLZH
         VO2QMOEpxET56jdq5xdDtAkgR7d0Qt8PgzjoNTkWq1qF1Fvl4+HoD8moS0Viua8mRCV5
         k2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303868; x=1770908668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfBltjWFs/4bjLl10PANJ+WewubPhQqXLGvIdvHvBRo=;
        b=J2S0JXWgdLU3+9DkPnhiqJDdEfAwIM43c+YPNPhxfB/H24I4nM6stDzKTQEtitXG0L
         2Gb0M1haSKAXjoUdJkEyps0zQtrXxAQY94MgWy9l+S+5rGN9KF6+d5/6rfxD6amZUBi/
         QZ2dM++adRfNmv8gwUvKtQiOkXozvaTxCKCooZQfdlwEFhkaPAYRphqGSIFwP8dk46po
         zf6pHccg4JWtKiN8ZewDPFw9i9Q92URrAxpet5smRULFrtDvT0uVDoMpj3gByX3SIMnJ
         EIELniCIaSzlJunsDY84A1W/5zNhbeyzI5j6IhGdM9APOm10jFudTh3xUaZqA+Hl+M60
         5fag==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3qoOpNpviB2ylrv3DIvH+e4Oht/E8NIpKSIIgC/N4WmYy1o490AXXl7QEpzjqR8D11Zy42RyymZvvANUxFKv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+KyYKgeXVZd2AN3qEZgb7sZPZtNI1uOW/YiW679A8sOUkSxyX
	cwG8t4Usot2jesKF8TSFMcAu+RUuYWRWTig3d6UTBab7/C3jsxZlRpikMxgEH6sxtxCQjSrTlaW
	vzkN5Z4StnbPQnZe4CHKubxINQ0KpNWCu8p5eVsMUHhJ+rLibsAIjl5UPqDNRtbm2x/ZrBMu+
X-Gm-Gg: AZuq6aIZMiOUxI20dCbHdMaAcOCv3/givr2YSrp15ga7EOD11T7vhuF5mCppe7w3yxn
	XdsMJT6WU/c5s3n9P+lHufRiAjb8TsU0lxdigIfZ4NOg2WMw8cHMIJ2bQtZJ+ZqwYemHsuCYn5d
	W51vaBwzBRIFDTqUDLTy/vFaK8mF+KOpZI8ZUoKcYe0CkqcipRAAqhrzhzvjFymz+38pEfPFQ4u
	tlV8TIcpbuQIkoqUwHzHNCDTKm9s3TYHcNy/UgC5eaYcwvxLlZ5PG04OzTuzXxiv5Iw4RoREtz5
	b4Lo52uJ9GFpFZ1uZivZwVlZDN5Jk8l5vyih/b8O8XO/tbPXxSql8I9rnVUjPdGEj2TKr581zY7
	PqJcfi6DDqFTvg++IJZU=
X-Received: by 2002:a05:693c:2c0a:b0:2b8:3224:90fc with SMTP id 5a478bee46e88-2b845e48ae3mr1234330eec.5.1770303866785;
        Thu, 05 Feb 2026 07:04:26 -0800 (PST)
X-Received: by 2002:a05:693c:2c0a:b0:2b8:3224:90fc with SMTP id 5a478bee46e88-2b845e48ae3mr1234303eec.5.1770303866168;
        Thu, 05 Feb 2026 07:04:26 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e12845sm3491862eec.5.2026.02.05.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:04:25 -0800 (PST)
Date: Thu, 5 Feb 2026 09:04:24 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/riscv: Fix WSI mode IRQ number handling
Message-ID: <qlnntgtoaatvdpyvusjhe2y3hickopigwf3sobtnsfwpfhwjiu@zi4auf65eepa>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
 <2ueryrki7uzpjn6rbqz7scy46sjhw76jjilddz2naslz3eyfdp@ycwf42eaw5yy>
 <927D288E956D61AD+d1488c72-afff-49d2-bb6b-5ef5ea08b627@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927D288E956D61AD+d1488c72-afff-49d2-bb6b-5ef5ea08b627@linux.spacemit.com>
X-Authority-Analysis: v=2.4 cv=ItITsb/g c=1 sm=1 tr=0 ts=6984b17d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2SqC6Y7SbBa8MZsB_aYA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: C32kqXHt6Gao3_L8Zu1VVKUY_im6duoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExMyBTYWx0ZWRfX6fg9CW6TM3QR
 H/bU7LwwqOUXi94tDg+yyOs1Pda1BewpzB+r5dI4LyK7e9psIEn/+xCDvdYgwqQ139zYPl/eiCQ
 6PvOJc1Fj4wZ516qCIbOlGCjwpg4vPgcJgkeZhc9KbRxzOWYESEUzEpzEKnmbWEebbwUD097McI
 w129uDyC6dnH+HI07wLVl+3cLQ0zwt8Hi7YPbuS74duJ61Z6tZFhuKdwuCvpdsC8V1z3+HM+hA4
 S/pV+RCUVgxpe04QmKXHOvSaw26zWGqoC5dKagrdCRk5ivBg4dKSdTO64U8wPb6+EFSzOWPwYXc
 Sf3SftNgm4Gqlh17X/3lEJcw00w6d42csqdZSRcfW2+Frd3P636P/4oda71EbKNeLKvZ9wvGI3w
 UoFx4HMmVZZZV+iLJZH6hHIPeky5B6/seSIrPdcmzyGZvbvtVhGTjx8B1ExJRXnlElp/7px9R6c
 VD1mkL1s66ksqd2RiSQ==
X-Proofpoint-GUID: C32kqXHt6Gao3_L8Zu1VVKUY_im6duoM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050113

On Thu, Feb 05, 2026 at 11:52:57AM +0800, Lv Zheng wrote:
> On 2/5/2026 1:20 AM, Andrew Jones wrote:
> > On Wed, Feb 04, 2026 at 05:08:52PM +0800, Lv Zheng wrote:
...
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > > index d9429097a2b5..26630979473b 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > >   		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
> > >   	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
> > >   	iommu->icvec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
> > > -	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> > > -		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> > > -		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> > > -		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> > > -		return -EINVAL;
> > > +	/*
> > > +	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
> > > +	 * Check if FCTL.WSI is set to determine interrupt mode.
> > > +	 */
> > > +	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> > 
> > The behavior of ICVEC does not depend on FCTL.WSI
> > 
> > > +		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> > > +			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> > > +			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> > > +			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> > > +			return -EINVAL;
> > > +	} else {
> > > +		/*
> > > +		 * WSI mode: ICVEC is not used. Set to identity mapping for
> > > +		 * riscv_iommu_queue_vec() to work correctly.
> > > +		 */
> > > +		iommu->icvec = FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
> > > +			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
> > > +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
> > > +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);
> > 
> > It's certainly not correct to set iommu->icvec to anything that can't be
> > written to the IOMMU's WARL ICVEC fields and read back again.
> 
> Indeed.
> It looks I can keep icvec returned for WSI and keeps the write-and-read
> check logic only for MSI.
>

You shouldn't need to touch this code at all. I don't see anything to fix
wrt the spec. As I said, if iommu->irqs_count is known to be greater than
one but you're getting zero back from ICVEC even after writing 0xffff to
it first, then ICVEC on your IOMMU is broken. Once you've confirmed that,
then the best you can do is add some workaround for your specific IOMMU
here.

Thanks,
drew
