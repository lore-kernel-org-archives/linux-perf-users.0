Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70861163
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165481; cv=none; b=NkPyJ6zUOMwi9swpP3gLtZwLRYPWSMomGf+Q6Ol7Pw2oFOhZHaHXCXq6wWqWWYQHPtmB19XR8Fl+bkDELGw4oaOPPrg0rTuyZv50RojxJKw4eR6qbHg01vXTlhEVpaCvJ3xVTDYun1iDMQUJ72j6Q27ECWzLDOhsvkNfj0JzryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165481; c=relaxed/simple;
	bh=wXzaj5P/tdA4Njw7usjZTVIrc74ZHsjBkUT4KFtPsVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2/2auY6JfZR4YS5HkpM9CvXoUWgW2lmRZN+TgHBRCJe/7nig7luQP7nyfWhHhjmxuhHDxP1H2AfJ+l/g0aG86cwiyrqfS4FuQ9PNa0+sg9DWvHrtoJCYi9vp+nBylvsxtNzCgwMfYn/FxiD9Gxet3NDV9xUe87cXQRsKcbg76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VmW5at8q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SPKiN0BI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmW5at8q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SPKiN0BI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613LJkwM3515125
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2026 00:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tkT8dBk1JcFJK8y0KkFaCtb2
	feCXfoj1NqY5blcEHqA=; b=VmW5at8q2VUnrKiboFseYw8SdR8392HpZha05thu
	57y3yj/QVUkYSK+5z8+U6xhhwri/9+RQKC6PQqqIBNPuoVu7p/L9Y7EF/aYoZkIj
	bnzPmgV5/uK8Z5/jiv3E5vH7xFaC/fD7IRWh6nyZE0++nNwSqwug8bLG29JPavAm
	ceHDkwls1z49Ka55lqfD6kL44jBMHjY/snZ5avOX5SrK0S9WtXqx4RsmjGJEqwQe
	nJwIHfKazhc/tWF2vhqZqqBuncB6TJMRh1syDHByOO1oEnqyyHbkfA97tAjZs4L9
	M3P339QCTFRaKSHtDqGxUMNNA0BCU8KKz+JTkUDc4l3/VQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ru98gwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 00:37:59 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-124a95b6f61so22865661c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 16:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770165479; x=1770770279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkT8dBk1JcFJK8y0KkFaCtb2feCXfoj1NqY5blcEHqA=;
        b=SPKiN0BICtivX+WlWHPtDOlN8frGq9vtA3UlnCYcfx1ARROVygdh1gU3OcPBhmK3h3
         qMlzLzPxh7eXFbGOZL3Z2626X4WIPTq8yXGv80qGLoZjWXLxhKwOMzq8sG6AAHqVwZWu
         bSTDuRPXWHjz28fJhWvnNsoXBjm3Vqy/tC1+ylApLIvmGDwBTXT7/nPYriEJBBKmb6K3
         Xlqz3IaLh+/OL7oegY3F6nN1B8745Zfc/FUUjwOF5j5ozeRfcVAPDlW3f7q657I0KdTX
         Bcs/7zQVJ+oA0bXZB+hP7IR9efDDcUUOkYbfIm6Zo550zazgudZMQQOOGiXNxGHVdi3/
         B3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165479; x=1770770279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkT8dBk1JcFJK8y0KkFaCtb2feCXfoj1NqY5blcEHqA=;
        b=XOi5SHJwkLFQKU8xxz8rhZj+3UcztsxQn1Qlzc7KyNJo829SSxyLsWA0tdy++xrMD+
         3enSEGMCWWW2Fg0SiODV0chzFro2NOiGAA8B6iMrDjYI5FLPuWSiCrF/+k8eQ+kkPp4Z
         aVulJC20SWCirJ9kq4zT7Kn4SJGiB2X6pnUCCDYlp4N5ggjOhrJ8wuZi+iL3WLXRTOlz
         xwQyEuSRhhaOMGmeNZzh0kg+p3kXJwlduJJ5YxDMDwgwpgvB4E8pcSNIH8k6M60Q5Nns
         Bp6CFApJldzIntF6829CsKILQSiRQVxYbkX/FiwHOOM2TGYboB0UOZDDEkfohj4WZ40e
         LTOA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPqHaSx26lz6RTIKUy8mmDbVBFzKvG6u+xV4yHJsF/tJiSNdIntDA/fixsUCMWjJLkkvVfGACvw9b9LFfkWNF@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJT+9V2rozYPJHeR1tuvaTHgCoecMA0YGa6+F9R6DoqU5240O
	b0P/7zB8PEa7+E7/S1NU8GfGGCNbTRr/ms0w9/k2MGnVQv7rYkv0xEq2zZGzQIaT9yofxIjCnXl
	GDXnKeWaeuD8Zs0LiFbgGFMg7T/0MAr3rnHrAxtUk7jTCnXmSCp2RgtcEaBTyW7mn/HAnS4F9
X-Gm-Gg: AZuq6aIkcoaYP8yoYVs06g0S0PJ//oOCQSCPeouKKmdL+vCJTOLJuAw8toM9btW5RAE
	yo2HDZc3z8HiWPOPdFsi5B61SYwvKUP4TKwkpp5f61MxO2/+KmaeIle4qV1TtddDgSOxk6UaYBS
	ICKKoSip68RwxKlRm2kKlJ5M6kQEA5jep1s/XCLMxh4NiU59kdLe3QMou4nhsZ66H8i+C7nru/H
	wEDF3O0BeCGpf0QQ1QZJ/zNlVMveqeUCGChGuoXpD3h1MsgvnyV2eO9BxEfxvv9APuupCcbZ3xq
	gUdQXmQHie+sWBPGCn/X0fG5ouPDCaRGf0K7GOxB7NjV2Z4mmDt7/80NTWZDfNPu8/9oss2RElk
	Cufr72CzaEljP33mephU=
X-Received: by 2002:a05:7022:325:b0:11d:e25a:d9ca with SMTP id a92af1059eb24-126f47bd21cmr515406c88.26.1770165478836;
        Tue, 03 Feb 2026 16:37:58 -0800 (PST)
X-Received: by 2002:a05:7022:325:b0:11d:e25a:d9ca with SMTP id a92af1059eb24-126f47bd21cmr515381c88.26.1770165478293;
        Tue, 03 Feb 2026 16:37:58 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e05ce7sm737561c88.1.2026.02.03.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:37:57 -0800 (PST)
Date: Tue, 3 Feb 2026 18:37:56 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: "qingwei.hu" <qingwei.hu@bytedance.com>
Cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Skip stopping cycle counter
Message-ID: <n4wxcfjzykkinijm4ci7k6yg6k6bz5owqidldeu2qhiraec7jp@swa2thx5rvbg>
References: <20260202111728.4067036-1-qingwei.hu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202111728.4067036-1-qingwei.hu@bytedance.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwMSBTYWx0ZWRfXxF4xc5sY4QZ/
 w9MYxIxvHUSVfY7wV0bcwBrtEXZ1Ojs9Qnb0o8cMTaRF2Nq8UF4Ap2L2emJBLUkPOUZUkuW6L+N
 HRcESoE4qVHCb4MJnOGjX8CTtHSuAEcuiRfWu22hBY3XCH8Kprrq3pQcX+H7f+m8M1z5cuA6IZu
 zG3m3l9ybciAVfA6GT5UaPcx8/7cJB6t5Y6/73H3cLwG36lXjF/2z5j1WZZitLqVj1qA03LM3YT
 bn07kPf4c8BZKT7fJtGBMgo1WEhJWUh2uwz99HIp2WB03fv4TpV4IjZ3e12rdvGj2RcM84rvVyT
 k9R3u7o8u8a0gCaloRxBgT57ypvfSewBJ1iKRFpxvOffTimBuYtDeBy3x9uRwpXOcO0QTWS5AiO
 msVp84cdvXRr0JScEo2iqX6NUrCtEr7JlNHsHDZEGePB94KF74gtIYyc8Da+GtAhnRBbqqrKWXq
 H5Q+Zc8Usj0Ki9a/jCQ==
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=698294e7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=JfrnYn6hAAAA:8
 a=968KyxNXAAAA:8 a=-qhuNgR9Vo-gAdm-t_sA:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: yl-NJnjYJdkYd62kPhKGJZpm4i_PUjKS
X-Proofpoint-ORIG-GUID: yl-NJnjYJdkYd62kPhKGJZpm4i_PUjKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040001

On Mon, Feb 02, 2026 at 07:17:28PM +0800, qingwei.hu wrote:
> From: Qingwei Hu <qingwei.hu@bytedance.com>
> 
> In the riscv_pmu_sbi driver, pmu_sbi_stop_all() is intended to stop
> all available counters. However, counter 0 (the cycle counter) should
> be excluded from this operation because the counter may be used in
> user mode by rdcycle.

Hi Qingwei,

It looks like Chen Pei beat you to this[1], but that patch also avoids
stopping TIME and INSTRET.

[1] https://lore.kernel.org/all/20260131112440.2915-1-cp0613@linux.alibaba.com/

Thanks,
drew

> 
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7dd282da67ce..2bc0050dabd2 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -900,11 +900,15 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
>  static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  {
>  	/*
> -	 * No need to check the error because we are disabling all the counters
> -	 * which may include counters that are not enabled yet.
> +	 * No need to check the error because we are disabling all available
> +	 * counters (except the cycle counter) which may include counters
> +	 * that are not enabled yet.
> +	 *
> +	 * Cycle counter is excluded because it might be accessed by user
> +	 * mode via rdcycle.
>  	 */
>  	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> -		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> +		  0, pmu->cmask & ~BIT(0), SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>  }
>  
>  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> -- 
> 2.39.5
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
