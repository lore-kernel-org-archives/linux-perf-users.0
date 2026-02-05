Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D99421EFB
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305013; cv=none; b=Av/q0VBUHKk5WNwCtNuRLccUZKQ5y6Mprldn7lXdHg2H7GU14ORvnfTZNh08/JhcXB2kCdSw3levjskO+ecSA9/bxxoF9dxhgxHPrQDfz4rjTe1edwZeM/lv6tGfjTp1cFSCopp3qKzfva93Lgn3UFNp47WGThgYDK0SVFBhsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305013; c=relaxed/simple;
	bh=1/cZNAj5yVrTCSLan/Iqun1mttjNmbzyrzk36Gn+f7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJwc4z93Br0dpvMZa1mApgZYOYinxevJc+5p7t8hH55nlvN/s9YmUlOdbGn8xbhyOge1r4Sj+6251+mWDt4VxHTwQYmI9cRw+vg2Z3HR68JPLoIbs/3MOW8SJJ0bhpf96Az0FN/zxFFKCnGNx6GDCn02jUh2TvMgF86/I4G/0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkqoqxYn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uv2Nc4Q0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkqoqxYn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uv2Nc4Q0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615B41rL176913
	for <linux-perf-users@vger.kernel.org>; Thu, 5 Feb 2026 15:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fo5EChFJxxbLb85YiCCw15lKmFakF/DE4q1kK+Qroqs=; b=CkqoqxYnzOKs9q68
	XFI21yuj+oAFgjbA/X/FNlLGJvtgK8pyCgByoxx+snhxd/mhLWdakQ9+pyc42IWG
	L0zqO3thCvDBTHFtItuCgIbM9OYXlviCfVZZrfMDPotRHWoGOHqLAamu5+hqQU7e
	dMZhruqtC2vyJuz6DPlHAs2DOScm6BcI9wMp4f680ixIfRnG+hj50FclHjgw1arU
	Ax+e2qdRqlxStdL9+5QqU6zulS705p9yB6iY4BmocLizXQHM5IF+f1FVBLxc3xCF
	AtUsKW9dNMhrdFoKFriAuRsSbpnpDu/IfCoatDy4NkZ1z+fSOBCydpQEuq75l9ia
	CFzWgg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4t0p0s3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 15:23:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b71c5826fbso1010753eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770305012; x=1770909812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fo5EChFJxxbLb85YiCCw15lKmFakF/DE4q1kK+Qroqs=;
        b=Uv2Nc4Q0Z/oVnUDFUZSO+ME6iSOBpUkc02UvRgwVPpRdad7CqrI3gwwLr/KvG7y5by
         lw9axk/2laayeq+2B9zGE4FEh31NU8TJhzmGSJjQCAJ88NXRXliWg1soMuElcXyL37bP
         8beRxVXNySnAMxNfqNaUfXCo2QG6cNH916Q16YyZdwbDHq7TxMfgMBaNgPyk2NeEWDAL
         QscdQs2OPHxCS6cFe1QpKLFw8jxMRlcfNuc1uI+7SuzhqX/y/vldDzQP1fcnY7q5ICFn
         cZTqtG/KOBi8lC8N3PJWYGOKsORV2cCaHXuSNy+ilZnhSevzw9vmlyQLXSuH0q4LH0MU
         wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770305012; x=1770909812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo5EChFJxxbLb85YiCCw15lKmFakF/DE4q1kK+Qroqs=;
        b=CWHIm2CbrBtt9fnAtOmMmrRR8uRoyjQ5Cjfs/OLSesfVKZTgwkyiPfPnooJ/fz0aDZ
         AUsufRE5x/Y/6gZdwveGu/wpAPWYMOR3rTEWxmkaqQ1epxVeE/SqYX0Mf1TGAmBCbe56
         ordud1veUWffsuAuaHBVXS/VW+5CZ8yH4bQSOeOFtpZPgUP4+gDMXTYQofDJDajmpkJC
         1eCElQcZRctUwoYG91TBYh4yOU9kC+ikOxQcEFDbR8SlY6OFcWE9ia4ZzV34LmXY/aEz
         5j5ecmrVSOyHzUwPzgpmqs7RKRzwPwASKnuIiNgohXA/jM56c4xlL1kMBbEcESmxL9HN
         wCZw==
X-Forwarded-Encrypted: i=1; AJvYcCWai9Y8EvnMEw2DFAxCr+BsSAsdBOjk0bySesxlHeM4bqkhLD+5naCAoctqpw5q9nCYVsua22Kjo4kfRHsmEp9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtNozAjxOeoFfof4FHku28r4aEiLeCsVhgWiDk/2J7HfUEJPj
	reKWEBJn9BXw++iDV9gT3QzvAg+FIOgobx9OtY2loGx6RpPArNsQVimUgMa4NNpqvrwMyg9TiaA
	iud5Fqxcfl504ttkITz7FpFboVVDcNdHuQsLxQQ4oaZPC8c4PngG1Knr/PSaahn8zhV4EkvgK
X-Gm-Gg: AZuq6aKJs5opDUdvjvuAvjNLpLFClb+myfulCKOt16TCWx99/IwLp6X7hk3/t+cLuNe
	o5EDCIpJ+s1XKu05kv/B1w+mrnn3bF79qWhVrmPo+Lj2+SO9ybDsZ1tAR6mlB5c2ooR5LJD1+hN
	hoy6Gi7bn5cTUkvNIuKu8lh1GzJx2R+G2tsfI8+4ct3PvU7FR/x6YcihevhxnZqGK79zC1bwTVs
	xNVszacEw9/afzfRVqBp+9NrWTJZBQpgJt4TbPhjt8Cpekgqk/zvOffIbx77uKcMlKy31KGnlUO
	eU+sj7700UEyU3lVWj0psiVXaFWZzx6Cut296opNzYjOoivoOeX67qUu5wMi5XsK2mW9+hxeaq/
	1rmd4k1uXR/edWzR4r+M=
X-Received: by 2002:a05:7301:4b03:b0:2b8:1d16:9716 with SMTP id 5a478bee46e88-2b8329e5c13mr2779580eec.20.1770305010045;
        Thu, 05 Feb 2026 07:23:30 -0800 (PST)
X-Received: by 2002:a05:7301:4b03:b0:2b8:1d16:9716 with SMTP id 5a478bee46e88-2b8329e5c13mr2779535eec.20.1770305007985;
        Thu, 05 Feb 2026 07:23:27 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e107b4sm4844489c88.7.2026.02.05.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:23:27 -0800 (PST)
Date: Thu, 5 Feb 2026 09:23:26 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Zong Li <zong.li@sifive.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
Message-ID: <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
X-Authority-Analysis: v=2.4 cv=ItITsb/g c=1 sm=1 tr=0 ts=6984b5f4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=lv0vYI88AAAA:8
 a=yG5aaNEj0tElPYM3_UYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=oJz5jJLG1JtSoe7EL652:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-ORIG-GUID: L9AIrZX1jRMCqa2dNPuS7j6EIN_ovkhg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX8hc98qbhbge1
 MI3HEL6dCyG0aTd2sfKSg//ngku6bTmC8nsigTUMIcFhZ6fdgn4HC+A6z+l4pbAMbm037AaBCYl
 Axzz9/z3xq7JmH/LHu2DpeNRQoTi0IDrpnIng0h3IjLGp769Z8k9xFV1FPPdki6W4brGDxGJ98p
 FG1OItnPsSl4fCbZD/+sxtPEisLUuvjTgPH0gKZ0ygcikQ+mEfC/8c/psIxU47cBLQZXB27BZ5C
 sHRKVy5HoR4q55drC0YyoBogeBLSafuxX8qYHGBYKL6eUvfw4200A/ubmpuxPkb44949i3EdnnW
 FyFNs7wFyPzdz8voXFl/J7Oad1Znl9JMXNME29Z3sx7cDuosu03Dm+W0HQXLXUiKinZKXv80ID1
 MXUlQsNzbogemFSIxPTCmnytXr6AB1dZrZWC2sMBxOyWlFfWayJr7H0PhRcQzSPHM1WKZEbbFKM
 kZmNHHVYQQLKyJsbBCg==
X-Proofpoint-GUID: L9AIrZX1jRMCqa2dNPuS7j6EIN_ovkhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050116

On Thu, Feb 05, 2026 at 02:11:48PM +0800, Lv Zheng wrote:
> On 2/5/2026 11:47 AM, Zong Li wrote:
> > On Thu, Feb 5, 2026 at 11:35 AM Lv Zheng <lv.zheng@linux.spacemit.com> wrote:
> > > 
> > > On 2/5/2026 2:39 AM, Andrew Jones wrote:
> > > > How does this relate to
> > > > 
> > > > https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> > > > 
> > > >   From a quick skim it looks like there's plenty of overlap.
> > > 
> > > We developed the driver in 2024 and demonstrated it in China summit. We
> > > didn't notice that a patch is on-going now in the community.
> > > 
> > > Now it looks our approach solved more issues, and we'll check and update
> > > if there are any community concerns still not addressed in this patchset.
> > > 
> > > We can add Reviewed-by/Tested-by and Signed-off-by of Zong Li to this
> > > patch if he wishes.
> > > 
> > > Thanks,
> > > Lv
> > > 
> > 
> > Perhaps I can first post my next revision to the mailing list (hope it
> > won't waste the community resource), so that you could have a chance
> > to review it and see whether that version is architecturally closer to
> > what the community is looking for, while also addressing your issue.
> > If you also feel that my next revision meets your needs, perhaps you
> > could append your additional implementations on top of it.
> > 
> 
> It seems we all composed the RISC-V iommu HPM support by referencing
> drivers/perf/arm_smmuv3_pmu.
> 
> Robin's comments should all be addressed IMHO.
> 
> > Of course, if the community would prefer to go your version, I’m
> > perfectly fine with that as well.
> 
> OK. If we send a next version, we will add your SOB and please help to
> review and test.

Zong Li's SOB should only be on the patches he authored. Don't put
anybody's SOB on patches they haven't been involved in. See
Documentation/process/submitting-patches.rst
"""
The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.
"""

Since Zong Li's patches were already on the list then your series should
at least discuss them in the cover letter, explaining why you've opted
not to adopt them. But, most likely some of the patches can be adopted,
so those should be extracted from Zong Li's work (with authorship
preserved) and based upon in order to respect that prior work.

Thanks,
drew
