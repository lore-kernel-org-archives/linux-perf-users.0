Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B435F609
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658571; cv=pass; b=tAGa8VffzdldLzlz4rUUMOq7nC7B9LTLf3ZABH9Rnxw7bzQyZJpurr2TSfKVEzRpLgTmHLWdTTjIuzueE/1xsc17pFIz2w7h/VhhB2j4ymlKbKLuxgvKwNQiaDSaGVBLGv5ap2xqcsfvRn09JNIf9PJCP+Y93IqOwEA68V0VN6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658571; c=relaxed/simple;
	bh=4EEaHUl+noahiOlMvyn/DsoSVI7mYTPL+o1VGUZk08g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8tZymFWwmUVpS2h9V01L1ulFD0U5KyK/wrxQMe2Ohcvz+u8jWU6hlKHzswnOeRh6E1b55CtNRcIbYJBf1lNKh4W6mUX4jHX0sDsUSgOiuPNeAdeX623Ksr1fps72PQGpV+RVamCAz5s06H3TMH/zjbhRcm/fgMhJT2qm8qQcOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZ4Jp+HO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hP7JfGlD; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZ4Jp+HO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hP7JfGlD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p6bQ2338776
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 07:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJLLqZjJjturDVwlTJrPVH5Y7VT1T+/P8Hv1cLbJT+A=; b=VZ4Jp+HOWY1qqL3o
	+nhHcLL3HVC8w8z8DbO3wrGafa4b4O2dAqqIwu3qTG/VxV3XOZ57NNqUNOYcunfO
	aVEarsWDj3R8E1SCFluE9Q+hc5jzLwTi6E7KWieVTHibs6t+HobNhv/zq1g8XDC+
	YT1dRUFY6Qqt9I8dcwU2G/AeXxwtm30zPdYwBJAwnIgz1kxOZPZaQqsm77TcGor4
	KUUKdxqSP2/RvhdCg9+cifB8V7f7V2hH6xTwf2ePImae1AueMxX9/t2i2M6opk/I
	E9GWnr3+5BeWiZWCMSGXUhjsyNYo2c0f7vrKrdLQjTYpz7hZppOBFiZIiRElR7EH
	dexQCQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vxab9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 07:49:27 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6963482e03dso1381280eaf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778658567; cv=none;
        d=google.com; s=arc-20240605;
        b=W6YSA7FYQUc8rLt2LPoHddm4ZojbOPMgyXVZ/1HjFDtYJO5W+3E6Zm4TbBRtiSoI40
         L+96ncnd5/jliuCaQ+Z63cBz59tPd/1sYiIVwzzxkcxlX/sWYcYk/q2MRQ3hZW3+gxz+
         7O/cOnaHga6+dfuC9gwFQnZ7dOmaHQBX19rJYo7VGT4+eTYnGdMqa8ttJccDY/BxbI4g
         84fAK4/mvVXQ/s6/6Q4XqaLP+fPGYK9/SIpEXKSRxh5GGyHGxsKMkeM1doDIcsA3Ka7k
         ykroZ+K8sP5XTgx2150nXp3Sa2WriZbTvmazn7hlYfhMWyFebXSdiXAp1ktFdCBOVibZ
         kHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hJLLqZjJjturDVwlTJrPVH5Y7VT1T+/P8Hv1cLbJT+A=;
        fh=NcdmhSVQYZlhxUHhifAp7E4AGw+2XN7N4gE/yYTaMlk=;
        b=Td47odF8X1mikl87F6SDDBQRvsb4avUxd2rq//PKwdEMsQzd80Y95veLYdRkcaXe2W
         48WIGFWYqjKTcRNSG6gyJofK9R+ZDeIySZBZaZUVzKH7WxgY2sEQI+NrHBeFTsCrUqIg
         Pg4r0phzfS+/j1AM8NO8hSPxAQmk9dSUcLlh6PQEy3vFVGAUeoncDBxqNYbc8ico23lb
         jMhfTh9Mc1D+7Q3+sKaU+Umdp0CtxjlwFg3ix+FVli07Osf10B/vVLdwZ4u7+GmcIsW/
         qqQ0h0ghKA/nrBXpL1f+IKx9q1PHAfsfVKULEAEm56wAT4joX5l9MzYPfGh5epxrZgcV
         kddg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778658567; x=1779263367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJLLqZjJjturDVwlTJrPVH5Y7VT1T+/P8Hv1cLbJT+A=;
        b=hP7JfGlDIMU5RpVSUX44odR2Fp3c7J6eiuUud4Lur/ZtS0Iou4Q5RfjZBxQytNnNmC
         wWqf+tuoeOQcZIhTOSDHtVTcTBIQ2b+jcRJkzjpIR/rllAgYE5LwJqoEI848T+64JMAS
         vNCG78YadsU0+SnOdCIWBrYfJE5ezweZZZkzwXQXknE4z8qkwSs9pJY3tNT7AaCmezcr
         CMardTsmlwRMuKV9lHuYjhSkdAd1dAkMtKfQTuMnpG9w+T50QBfuZ2L5ZCuU5jvaozQK
         uX9VeJviWfVbrPBBLycrtNcVxIse+dF3hEzBXblnMWf79OvFnxnNXJUSPwIMjK8A9aI2
         fDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778658567; x=1779263367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJLLqZjJjturDVwlTJrPVH5Y7VT1T+/P8Hv1cLbJT+A=;
        b=AvmJDs641Fv7Du7rDFxH2MN8xoGcA03EGxOk/+cSb0TyQljLqwg/bAh2k45aft9f0i
         PeSOdFDWkeEe8tGT1HasKl5AG/itus0n3PszmyJzVQEfNMwKisZopF0N/4X0MObCBo+2
         czyUAIhdchEoFwbySBgjkqJZQ1Y93dJUtBmLSq0S0QmknYb2Cmj7Py0CUig/zqo9qYBf
         Os2DMnVJVIpcM8C4XHtIEBQtVrfCuQgSoVB4NeXrl5t5BEOndYKUq99/TkvipxLAV3GL
         GHXJRA3O381KcP0jaQc+MSv1xCss1xgUmf29p/e1/O4YTsXY0cghwICVMv50auDu418w
         LtuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9w390sEgkdFv/1+8NSW5JFDbmNWDHxILaXZtms/iP1RNyp4HkEc8WOfeqvm6e3h6v6ork2MWE8RYu44CiqvS3T@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPvNixbDQJnYvU1E2+VVHdhqlON5L3lQrnDimX7H917iS7J3J
	6uDek7MaAgHyn/7dAj3hAgfRHxMMCBZxwnaDssfpTuvG9VT4hksRtGhrdn/x51T9i7K/TKrVoGD
	cchOx2wvqMZcWQoYwbumxwcGAw7n0lQUVq/cThXxGP4bIvb/jl+f1eugpboviJcLJN8ii0Kr9eR
	2HxFvRvZ1DH4fXC76JnuYAWQMKn/OSlxbF04W06h+33quZvSiOUUdiZFU=
X-Gm-Gg: Acq92OHkmRkkJcqO5I2gVvzgjulV0egxzEpd/71EmnCiqycKYQ8JjY3blRvP/d5dH2R
	jIjJagU8TeHfPjPeNIMjkCSgALl8pAJfnu8VvQInGX4aI7d+LDCUld3khi6vaiIHrGEuaHKLBMs
	Zy1gIq6QY6Zao6cvhmhdMfMtYLdo6foBILr9hPSzEPv6PZJ5HczY/2xOcgqlFTUrmnrq70dw81/
	4FwGtc=
X-Received: by 2002:a05:6820:2902:b0:696:2038:82d7 with SMTP id 006d021491bc7-69b78d5922cmr1262867eaf.23.1778658567081;
        Wed, 13 May 2026 00:49:27 -0700 (PDT)
X-Received: by 2002:a05:6820:2902:b0:696:2038:82d7 with SMTP id
 006d021491bc7-69b78d5922cmr1262851eaf.23.1778658566591; Wed, 13 May 2026
 00:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com> <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Wed, 13 May 2026 13:19:13 +0530
X-Gm-Features: AVHnY4JaIfncTrJZixBZoF-HHA2xGrz2H3asLmU26YTZ7hq9mOZD72bhPuy9TX8
Message-ID: <CA+Ht8=bxZicrzVCrHREQubx8DprS69j_Qdv9tpJ0SNNzMpbV7g@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] drivers: firmware: add riscv SSE support
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Himanshu Chauhan <himanshu@thechauhan.dev>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Shuah Khan <shuah@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
        Zhu Yuan <yuanzhu@bytedance.com>,
        Himanshu Chauhan <hchauhan@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -ToO9qaD-04kjiKXmh-Kpr_foYtknaDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3OCBTYWx0ZWRfX2AfN2dkUNSGw
 /ggIFLhjGnuSynQYRBLhEGPIlzn3JlYivijnqQh6gmjTC/8qY4sPuSjWbdRkEeugaPmUc1p8uFu
 a9LgpMXMNK5Kz0hZYbRvI+rJiFEEP4B8LWaULsfy8JaLGFXMqu+JXjZXk+zpM0LJ90mQ3fmV6av
 /6EtWYtevhzM+zK5n3xJQAZBdgZcsreDlx8wTZih6KHY5T5Zjazt6++C09EVLi3z/y41WLReylN
 GUGIHc9CFjsgmt142uj2PHbFd+tZs4B4q+DLqrQocCwsPOJVqrCs/VJTcNawR70YfpVbhSmdJUP
 k47qDEVknUNppJPzkpQzZduKlU4oEWWESivO1TPX1SGFwE0k1wXcdQv3yUHnJfUv/WxzQMbGs8r
 werhPVhuXy/OzS26+YU1rx5H0cxJiAvTOjXag17uooxaL764VMbwsQSNYv1BTSZTU7u6GO0zUEi
 81EsTjfyMeDriWo3GSg==
X-Proofpoint-GUID: -ToO9qaD-04kjiKXmh-Kpr_foYtknaDH
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a042d08 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=968KyxNXAAAA:8 a=h0uksLzaAAAA:8 a=bDdBU3oEAAAA:8
 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=t9496tuAAAAA:8
 a=iLg_rctQe_C71IxxFM8A:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=DN7SgORnOiO7RqxRx1GC:22 a=E8ToXWR_bxluHZ7gmE-Z:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130078

Hi Zhanpeng,

On Sat, May 9, 2026 at 6:41=E2=80=AFPM Zhanpeng Zhang
<zhangzhanpeng.jasper@bytedance.com> wrote:
>
> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>
> Add a driver-level interface for RISC-V SSE support.  The interface lets
> Linux clients register handlers and enable, disable and complete SSE
> events.  It will be used by PMU and GHES drivers.
>
> Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS                            |  16 +
>  drivers/firmware/Kconfig               |   1 +
>  drivers/firmware/Makefile              |   1 +
>  drivers/firmware/riscv/Kconfig         |  15 +
>  drivers/firmware/riscv/Makefile        |   3 +
>  drivers/firmware/riscv/riscv_sbi_sse.c | 694 +++++++++++++++++++++++++
>  include/linux/riscv_sbi_sse.h          |  57 ++
>  7 files changed, 787 insertions(+)
>  create mode 100644 drivers/firmware/riscv/Kconfig
>  create mode 100644 drivers/firmware/riscv/Makefile
>  create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
>  create mode 100644 include/linux/riscv_sbi_sse.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..c247acc56d1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22914,6 +22914,13 @@ T:     git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/iommu/linux.git
>  F:     Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>  F:     drivers/iommu/riscv/
>
> +RISC-V FIRMWARE DRIVERS
> +M:     Conor Dooley <conor@kernel.org>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
> +F:     drivers/firmware/riscv/
> +
>  RISC-V MICROCHIP SUPPORT
>  M:     Conor Dooley <conor.dooley@microchip.com>
>  M:     Daire McNamara <daire.mcnamara@microchip.com>
> @@ -22999,6 +23006,15 @@ F:     arch/riscv/boot/dts/spacemit/
>  N:     spacemit
>  K:     spacemit
>
> +RISC-V SSE DRIVER
> +M:     Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> +R:     Himanshu Chauhan <himanshu@thechauhan.dev>

If Clement is not interested in maintaining the SSE implementation,
please add me as the co-maintainer not just reviewer for SSE.

Regards
Himanshu

> +R:     Yunhui Cui <cuiyunhui@bytedance.com>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +F:     drivers/firmware/riscv/riscv_sbi_sse.c
> +F:     include/linux/riscv_sbi_sse.h
> +
>  RISC-V TENSTORRENT SoC SUPPORT
>  M:     Drew Fustini <dfustini@oss.tenstorrent.com>
>  M:     Joel Stanley <jms@oss.tenstorrent.com>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index bbd2155d8483..1894df87b08e 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
>  source "drivers/firmware/microchip/Kconfig"
>  source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/qcom/Kconfig"
> +source "drivers/firmware/riscv/Kconfig"
>  source "drivers/firmware/samsung/Kconfig"
>  source "drivers/firmware/smccc/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 4ddec2820c96..6cdd84570ea7 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -34,6 +34,7 @@ obj-y                         +=3D efi/
>  obj-y                          +=3D imx/
>  obj-y                          +=3D psci/
>  obj-y                          +=3D qcom/
> +obj-y                          +=3D riscv/
>  obj-y                          +=3D samsung/
>  obj-y                          +=3D smccc/
>  obj-y                          +=3D tegra/
> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kcon=
fig
> new file mode 100644
> index 000000000000..ed5b663ac5f9
> --- /dev/null
> +++ b/drivers/firmware/riscv/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Risc-V Specific firmware drivers"
> +depends on RISCV
> +
> +config RISCV_SBI_SSE
> +       bool "Enable SBI Supervisor Software Events support"
> +       depends on RISCV_SBI
> +       default y
> +       help
> +         The Supervisor Software Events support allows the SBI to delive=
r
> +         NMI-like notifications to the supervisor mode software. When en=
abled,
> +         this option provides support to register callbacks on specific =
SSE
> +         events.
> +
> +endmenu
> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Mak=
efile
> new file mode 100644
> index 000000000000..c8795d4bbb2e
> --- /dev/null
> +++ b/drivers/firmware/riscv/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_RISCV_SBI_SSE)            +=3D riscv_sbi_sse.o
> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/ri=
scv/riscv_sbi_sse.c
> new file mode 100644
> index 000000000000..830011ddd33f
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> @@ -0,0 +1,694 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Rivos Inc.
> + */
> +
> +#define pr_fmt(fmt) "sse: " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/hardirq.h>
> +#include <linux/list.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/reboot.h>
> +#include <linux/riscv_sbi_sse.h>
> +#include <linux/slab.h>
> +
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> +
> +struct sse_event {
> +       struct list_head list;
> +       u32 evt_id;
> +       u32 priority;
> +       sse_event_handler_fn *handler;
> +       void *handler_arg;
> +       /* Only valid for global events */
> +       unsigned int cpu;
> +
> +       union {
> +               struct sse_registered_event *global;
> +               struct sse_registered_event __percpu *local;
> +       };
> +};
> +
> +static int sse_hp_state;
> +static bool sse_available __ro_after_init;
> +static DEFINE_SPINLOCK(events_list_lock);
> +static LIST_HEAD(events);
> +static DEFINE_MUTEX(sse_mutex);
> +
> +struct sse_registered_event {
> +       struct sse_event_arch_data arch;
> +       struct sse_event *event;
> +       unsigned long attr;
> +       bool is_enabled;
> +};
> +
> +void sse_handle_event(struct sse_event_arch_data *arch_event,
> +                     struct pt_regs *regs)
> +{
> +       int ret;
> +       struct sse_registered_event *reg_evt =3D
> +               container_of(arch_event, struct sse_registered_event, arc=
h);
> +       struct sse_event *evt =3D reg_evt->event;
> +
> +       ret =3D evt->handler(evt->evt_id, evt->handler_arg, regs);
> +       if (ret)
> +               pr_warn("event %x handler failed with error %d\n", evt->e=
vt_id, ret);
> +}
> +
> +static struct sse_event *sse_event_get(u32 evt)
> +{
> +       struct sse_event *event =3D NULL;
> +
> +       scoped_guard(spinlock, &events_list_lock) {
> +               list_for_each_entry(event, &events, list) {
> +                       if (event->evt_id =3D=3D evt)
> +                               return event;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static phys_addr_t sse_event_get_attr_phys(struct sse_registered_event *=
reg_evt)
> +{
> +       phys_addr_t phys;
> +       void *addr =3D &reg_evt->attr;
> +
> +       if (sse_event_is_global(reg_evt->event->evt_id))
> +               phys =3D virt_to_phys(addr);
> +       else
> +               phys =3D per_cpu_ptr_to_phys(addr);
> +
> +       return phys;
> +}
> +
> +static struct sse_registered_event *sse_get_reg_evt(struct sse_event *ev=
ent)
> +{
> +       if (sse_event_is_global(event->evt_id))
> +               return event->global;
> +       else
> +               return per_cpu_ptr(event->local, smp_processor_id());
> +}
> +
> +static int sse_sbi_event_func(struct sse_event *event, unsigned long fun=
c)
> +{
> +       struct sbiret ret;
> +       u32 evt =3D event->evt_id;
> +       struct sse_registered_event *reg_evt =3D sse_get_reg_evt(event);
> +
> +       ret =3D sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("Failed to execute func %lx, event %x, error %ld\=
n",
> +                       func, evt, ret.error);
> +               return sbi_err_map_linux_errno(ret.error);
> +       }
> +
> +       if (func =3D=3D SBI_SSE_EVENT_DISABLE)
> +               reg_evt->is_enabled =3D false;
> +       else if (func =3D=3D SBI_SSE_EVENT_ENABLE)
> +               reg_evt->is_enabled =3D true;
> +
> +       return 0;
> +}
> +
> +int sse_event_disable_local(struct sse_event *event)
> +{
> +       return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
> +}
> +EXPORT_SYMBOL_GPL(sse_event_disable_local);
> +
> +int sse_event_enable_local(struct sse_event *event)
> +{
> +       return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(sse_event_enable_local);
> +
> +static int sse_event_attr_get_no_lock(struct sse_registered_event *reg_e=
vt,
> +                                     unsigned long attr_id, unsigned lon=
g *val)
> +{
> +       struct sbiret sret;
> +       u32 evt =3D reg_evt->event->evt_id;
> +       unsigned long phys;
> +
> +       phys =3D sse_event_get_attr_phys(reg_evt);
> +
> +       sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, att=
r_id, 1,
> +                        phys, 0, 0);
> +       if (sret.error) {
> +               pr_debug("Failed to get event %x attr %lx, error %ld\n", =
evt,
> +                        attr_id, sret.error);
> +               return sbi_err_map_linux_errno(sret.error);
> +       }
> +
> +       *val =3D reg_evt->attr;
> +
> +       return 0;
> +}
> +
> +static int sse_event_attr_set_nolock(struct sse_registered_event *reg_ev=
t,
> +                                    unsigned long attr_id, unsigned long=
 val)
> +{
> +       struct sbiret sret;
> +       u32 evt =3D reg_evt->event->evt_id;
> +       unsigned long phys;
> +
> +       reg_evt->attr =3D val;
> +       phys =3D sse_event_get_attr_phys(reg_evt);
> +
> +       sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt, at=
tr_id, 1,
> +                        phys, 0, 0);
> +       if (sret.error)
> +               pr_debug("Failed to set event %x attr %lx, error %ld\n", =
evt,
> +                        attr_id, sret.error);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +static void sse_global_event_update_cpu(struct sse_event *event,
> +                                       unsigned int cpu)
> +{
> +       struct sse_registered_event *reg_evt =3D event->global;
> +
> +       event->cpu =3D cpu;
> +       arch_sse_event_update_cpu(&reg_evt->arch, cpu);
> +}
> +
> +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
> +                                          unsigned int cpu)
> +{
> +       unsigned long hart_id =3D cpuid_to_hartid_map(cpu);
> +       struct sse_registered_event *reg_evt =3D event->global;
> +       u32 evt =3D event->evt_id;
> +       bool was_enabled;
> +       int ret;
> +
> +       if (!sse_event_is_global(evt))
> +               return -EINVAL;
> +
> +       was_enabled =3D reg_evt->is_enabled;
> +       if (was_enabled)
> +               sse_event_disable_local(event);
> +
> +       ret =3D sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED=
_HART,
> +                                       hart_id);
> +       if (ret =3D=3D 0)
> +               sse_global_event_update_cpu(event, cpu);
> +
> +       if (was_enabled)
> +               sse_event_enable_local(event);
> +
> +       return 0;
> +}
> +
> +int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
> +{
> +       int ret;
> +
> +       scoped_guard(mutex, &sse_mutex) {
> +               scoped_guard(cpus_read_lock) {
> +                       if (!cpu_online(cpu))
> +                               return -EINVAL;
> +
> +                       ret =3D sse_event_set_target_cpu_nolock(event, cp=
u);
> +               }
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(sse_event_set_target_cpu);
> +
> +static int sse_event_init_registered(unsigned int cpu,
> +                                    struct sse_registered_event *reg_evt=
,
> +                                    struct sse_event *event)
> +{
> +       reg_evt->event =3D event;
> +
> +       return arch_sse_init_event(&reg_evt->arch, event->evt_id, cpu);
> +}
> +
> +static void sse_event_free_registered(struct sse_registered_event *reg_e=
vt)
> +{
> +       arch_sse_free_event(&reg_evt->arch);
> +}
> +
> +static int sse_event_alloc_global(struct sse_event *event)
> +{
> +       int err;
> +       struct sse_registered_event *reg_evt;
> +
> +       reg_evt =3D kzalloc_obj(*reg_evt, GFP_KERNEL);
> +       if (!reg_evt)
> +               return -ENOMEM;
> +
> +       event->global =3D reg_evt;
> +       err =3D sse_event_init_registered(smp_processor_id(), reg_evt, ev=
ent);
> +       if (err)
> +               kfree(reg_evt);
> +
> +       return err;
> +}
> +
> +static int sse_event_alloc_local(struct sse_event *event)
> +{
> +       int err;
> +       unsigned int cpu, err_cpu;
> +       struct sse_registered_event *reg_evt;
> +       struct sse_registered_event __percpu *reg_evts;
> +
> +       reg_evts =3D alloc_percpu(struct sse_registered_event);
> +       if (!reg_evts)
> +               return -ENOMEM;
> +
> +       event->local =3D reg_evts;
> +
> +       for_each_possible_cpu(cpu) {
> +               reg_evt =3D per_cpu_ptr(reg_evts, cpu);
> +               err =3D sse_event_init_registered(cpu, reg_evt, event);
> +               if (err) {
> +                       err_cpu =3D cpu;
> +                       goto err_free_per_cpu;
> +               }
> +       }
> +
> +       return 0;
> +
> +err_free_per_cpu:
> +       for_each_possible_cpu(cpu) {
> +               if (cpu =3D=3D err_cpu)
> +                       break;
> +               reg_evt =3D per_cpu_ptr(reg_evts, cpu);
> +               sse_event_free_registered(reg_evt);
> +       }
> +
> +       free_percpu(reg_evts);
> +
> +       return err;
> +}
> +
> +static struct sse_event *sse_event_alloc(u32 evt, u32 priority,
> +                                        sse_event_handler_fn *handler,
> +                                        void *arg)
> +{
> +       int err;
> +       struct sse_event *event;
> +
> +       event =3D kzalloc_obj(*event, GFP_KERNEL);
> +       if (!event)
> +               return ERR_PTR(-ENOMEM);
> +
> +       event->evt_id =3D evt;
> +       event->priority =3D priority;
> +       event->handler_arg =3D arg;
> +       event->handler =3D handler;
> +
> +       if (sse_event_is_global(evt))
> +               err =3D sse_event_alloc_global(event);
> +       else
> +               err =3D sse_event_alloc_local(event);
> +
> +       if (err) {
> +               kfree(event);
> +               return ERR_PTR(err);
> +       }
> +
> +       return event;
> +}
> +
> +static int sse_sbi_register_event(struct sse_event *event,
> +                                 struct sse_registered_event *reg_evt)
> +{
> +       int ret;
> +
> +       ret =3D sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
> +                                       event->priority);
> +       if (ret)
> +               return ret;
> +
> +       return arch_sse_register_event(&reg_evt->arch);
> +}
> +
> +static int sse_event_register_local(struct sse_event *event)
> +{
> +       int ret;
> +       struct sse_registered_event *reg_evt;
> +
> +       reg_evt =3D per_cpu_ptr(event->local, smp_processor_id());
> +       ret =3D sse_sbi_register_event(event, reg_evt);
> +       if (ret)
> +               pr_debug("Failed to register event %x: err %d\n", event->=
evt_id,
> +                        ret);
> +
> +       return ret;
> +}
> +
> +static int sse_sbi_unregister_event(struct sse_event *event)
> +{
> +       return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
> +}
> +
> +struct sse_per_cpu_evt {
> +       struct sse_event *event;
> +       unsigned long func;
> +       cpumask_t error;
> +};
> +
> +static void sse_event_per_cpu_func(void *info)
> +{
> +       int ret;
> +       struct sse_per_cpu_evt *cpu_evt =3D info;
> +
> +       if (cpu_evt->func =3D=3D SBI_SSE_EVENT_REGISTER)
> +               ret =3D sse_event_register_local(cpu_evt->event);
> +       else
> +               ret =3D sse_sbi_event_func(cpu_evt->event, cpu_evt->func)=
;
> +
> +       if (ret)
> +               cpumask_set_cpu(smp_processor_id(), &cpu_evt->error);
> +}
> +
> +static void sse_event_free(struct sse_event *event)
> +{
> +       unsigned int cpu;
> +       struct sse_registered_event *reg_evt;
> +
> +       if (sse_event_is_global(event->evt_id)) {
> +               sse_event_free_registered(event->global);
> +               kfree(event->global);
> +       } else {
> +               for_each_possible_cpu(cpu) {
> +                       reg_evt =3D per_cpu_ptr(event->local, cpu);
> +                       sse_event_free_registered(reg_evt);
> +               }
> +               free_percpu(event->local);
> +       }
> +
> +       kfree(event);
> +}
> +
> +static int sse_on_each_cpu(struct sse_event *event, unsigned long func,
> +                          unsigned long revert_func)
> +{
> +       struct sse_per_cpu_evt cpu_evt;
> +
> +       cpu_evt.event =3D event;
> +       cpumask_clear(&cpu_evt.error);
> +       cpu_evt.func =3D func;
> +       on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +       /*
> +        * If there are some error reported by CPUs, revert event state o=
n the
> +        * other ones
> +        */
> +       if (!cpumask_empty(&cpu_evt.error)) {
> +               cpumask_t revert;
> +
> +               cpumask_andnot(&revert, cpu_online_mask, &cpu_evt.error);
> +               cpu_evt.func =3D revert_func;
> +               on_each_cpu_mask(&revert, sse_event_per_cpu_func, &cpu_ev=
t, 1);
> +
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +int sse_event_enable(struct sse_event *event)
> +{
> +       int ret =3D 0;
> +
> +       scoped_guard(mutex, &sse_mutex) {
> +               scoped_guard(cpus_read_lock) {
> +                       if (sse_event_is_global(event->evt_id)) {
> +                               ret =3D sse_event_enable_local(event);
> +                       } else {
> +                               ret =3D sse_on_each_cpu(event,
> +                                                     SBI_SSE_EVENT_ENABL=
E,
> +                                                     SBI_SSE_EVENT_DISAB=
LE);
> +                       }
> +               }
> +       }
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(sse_event_enable);
> +
> +static int sse_events_mask(void)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK, 0, 0, 0, 0, 0, =
0);
> +
> +       return sbi_err_map_linux_errno(ret.error);
> +}
> +
> +static int sse_events_unmask(void)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_UNMASK, 0, 0, 0, 0, 0=
, 0);
> +
> +       return sbi_err_map_linux_errno(ret.error);
> +}
> +
> +static void sse_event_disable_nolock(struct sse_event *event)
> +{
> +       struct sse_per_cpu_evt cpu_evt;
> +
> +       if (sse_event_is_global(event->evt_id)) {
> +               sse_event_disable_local(event);
> +       } else {
> +               cpu_evt.event =3D event;
> +               cpu_evt.func =3D SBI_SSE_EVENT_DISABLE;
> +               on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +       }
> +}
> +
> +void sse_event_disable(struct sse_event *event)
> +{
> +       scoped_guard(mutex, &sse_mutex) {
> +               scoped_guard(cpus_read_lock) {
> +                       sse_event_disable_nolock(event);
> +               }
> +       }
> +}
> +EXPORT_SYMBOL_GPL(sse_event_disable);
> +
> +struct sse_event *sse_event_register(u32 evt, u32 priority,
> +                                    sse_event_handler_fn *handler, void =
*arg)
> +{
> +       struct sse_event *event;
> +       int cpu;
> +       int ret =3D 0;
> +
> +       if (!sse_available)
> +               return ERR_PTR(-EOPNOTSUPP);
> +
> +       guard(mutex)(&sse_mutex);
> +       if (sse_event_get(evt))
> +               return ERR_PTR(-EEXIST);
> +
> +       event =3D sse_event_alloc(evt, priority, handler, arg);
> +       if (IS_ERR(event))
> +               return event;
> +
> +       scoped_guard(cpus_read_lock) {
> +               if (sse_event_is_global(evt)) {
> +                       unsigned long preferred_hart;
> +
> +                       ret =3D sse_event_attr_get_no_lock(event->global,
> +                                                        SBI_SSE_ATTR_PRE=
FERRED_HART,
> +                                                        &preferred_hart)=
;
> +                       if (ret)
> +                               goto err_event_free;
> +
> +                       cpu =3D riscv_hartid_to_cpuid(preferred_hart);
> +                       sse_global_event_update_cpu(event, cpu);
> +
> +                       ret =3D sse_sbi_register_event(event, event->glob=
al);
> +                       if (ret)
> +                               goto err_event_free;
> +
> +               } else {
> +                       ret =3D sse_on_each_cpu(event, SBI_SSE_EVENT_REGI=
STER,
> +                                             SBI_SSE_EVENT_DISABLE);
> +                       if (ret)
> +                               goto err_event_free;
> +               }
> +       }
> +
> +       scoped_guard(spinlock, &events_list_lock)
> +               list_add(&event->list, &events);
> +
> +       return event;
> +
> +err_event_free:
> +       sse_event_free(event);
> +
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(sse_event_register);
> +
> +static void sse_event_unregister_nolock(struct sse_event *event)
> +{
> +       struct sse_per_cpu_evt cpu_evt;
> +
> +       if (sse_event_is_global(event->evt_id)) {
> +               sse_sbi_unregister_event(event);
> +       } else {
> +               cpu_evt.event =3D event;
> +               cpu_evt.func =3D SBI_SSE_EVENT_UNREGISTER;
> +               on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +       }
> +}
> +
> +void sse_event_unregister(struct sse_event *event)
> +{
> +       scoped_guard(mutex, &sse_mutex) {
> +               scoped_guard(cpus_read_lock)
> +                       sse_event_unregister_nolock(event);
> +
> +               scoped_guard(spinlock, &events_list_lock)
> +                       list_del(&event->list);
> +
> +               sse_event_free(event);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(sse_event_unregister);
> +
> +static int sse_cpu_online(unsigned int cpu)
> +{
> +       struct sse_event *event;
> +
> +       scoped_guard(spinlock, &events_list_lock) {
> +               list_for_each_entry(event, &events, list) {
> +                       if (sse_event_is_global(event->evt_id))
> +                               continue;
> +
> +                       sse_event_register_local(event);
> +                       if (sse_get_reg_evt(event))
> +                               sse_event_enable_local(event);
> +               }
> +       }
> +
> +       /* Ready to handle events. Unmask SSE. */
> +       return sse_events_unmask();
> +}
> +
> +static int sse_cpu_teardown(unsigned int cpu)
> +{
> +       int ret =3D 0;
> +       unsigned int next_cpu;
> +       struct sse_event *event;
> +       struct sse_registered_event *reg_evt;
> +
> +       /* Mask the sse events */
> +       ret =3D sse_events_mask();
> +       if (ret)
> +               return ret;
> +
> +       scoped_guard(spinlock, &events_list_lock) {
> +               list_for_each_entry(event, &events, list) {
> +                       /* Disable local event on current cpu */
> +                       if (!sse_event_is_global(event->evt_id)) {
> +                               reg_evt =3D sse_get_reg_evt(event);
> +                               if (reg_evt->is_enabled)
> +                                       sse_event_disable_local(event);
> +
> +                               sse_sbi_unregister_event(event);
> +                               continue;
> +                       }
> +
> +                       if (event->cpu !=3D smp_processor_id())
> +                               continue;
> +
> +                       /* Update destination hart for global event */
> +                       next_cpu =3D cpumask_any_but(cpu_online_mask, cpu=
);
> +                       ret =3D sse_event_set_target_cpu_nolock(event, ne=
xt_cpu);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int sse_pm_notifier(struct notifier_block *nb, unsigned long acti=
on,
> +                          void *data)
> +{
> +       WARN_ON_ONCE(preemptible());
> +
> +       switch (action) {
> +       case CPU_PM_ENTER:
> +               sse_events_mask();
> +               break;
> +       case CPU_PM_EXIT:
> +       case CPU_PM_ENTER_FAILED:
> +               sse_events_unmask();
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block sse_pm_nb =3D {
> +       .notifier_call =3D sse_pm_notifier,
> +};
> +
> +/*
> + * Mask all CPUs and unregister all events on panic, reboot or kexec.
> + */
> +static int sse_reboot_notifier(struct notifier_block *nb, unsigned long =
action,
> +                              void *data)
> +{
> +       cpuhp_remove_state(sse_hp_state);
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block sse_reboot_nb =3D {
> +       .notifier_call =3D sse_reboot_notifier,
> +};
> +
> +static int __init sse_init(void)
> +{
> +       int ret;
> +
> +       if (sbi_probe_extension(SBI_EXT_SSE) <=3D 0) {
> +               pr_info("Missing SBI SSE extension\n");
> +               return -EOPNOTSUPP;
> +       }
> +       pr_info("SBI SSE extension detected\n");
> +
> +       ret =3D cpu_pm_register_notifier(&sse_pm_nb);
> +       if (ret) {
> +               pr_warn("Failed to register CPU PM notifier...\n");
> +               return ret;
> +       }
> +
> +       ret =3D register_reboot_notifier(&sse_reboot_nb);
> +       if (ret) {
> +               pr_warn("Failed to register reboot notifier...\n");
> +               goto remove_cpupm;
> +       }
> +
> +       ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sse:online"=
,
> +                               sse_cpu_online, sse_cpu_teardown);
> +       if (ret < 0)
> +               goto remove_reboot;
> +
> +       sse_hp_state =3D ret;
> +       sse_available =3D true;
> +
> +       return 0;
> +
> +remove_reboot:
> +       unregister_reboot_notifier(&sse_reboot_nb);
> +
> +remove_cpupm:
> +       cpu_pm_unregister_notifier(&sse_pm_nb);
> +
> +       return ret;
> +}
> +arch_initcall(sse_init);
> diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.=
h
> new file mode 100644
> index 000000000000..84165cb5f2d0
> --- /dev/null
> +++ b/include/linux/riscv_sbi_sse.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025 Rivos Inc.
> + */
> +
> +#ifndef __LINUX_RISCV_SBI_SSE_H
> +#define __LINUX_RISCV_SBI_SSE_H
> +
> +#include <linux/types.h>
> +#include <linux/linkage.h>
> +
> +struct sse_event;
> +struct pt_regs;
> +
> +typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
> +                                  struct pt_regs *regs);
> +
> +#ifdef CONFIG_RISCV_SBI_SSE
> +
> +struct sse_event *sse_event_register(u32 event_num, u32 priority,
> +                                    sse_event_handler_fn *handler, void =
*arg);
> +
> +void sse_event_unregister(struct sse_event *evt);
> +
> +int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu=
);
> +
> +int sse_event_enable(struct sse_event *sse_evt);
> +
> +void sse_event_disable(struct sse_event *sse_evt);
> +
> +int sse_event_enable_local(struct sse_event *sse_evt);
> +int sse_event_disable_local(struct sse_event *sse_evt);
> +
> +#else
> +static inline struct sse_event *sse_event_register(u32 event_num, u32 pr=
iority,
> +                                                  sse_event_handler_fn *=
handler,
> +                                                  void *arg)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void sse_event_unregister(struct sse_event *evt) {}
> +
> +static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
> +                                          unsigned int cpu)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int sse_event_enable(struct sse_event *sse_evt)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void sse_event_disable(struct sse_event *sse_evt) {}
> +#endif
> +#endif /* __LINUX_RISCV_SBI_SSE_H */
> --
> 2.50.1 (Apple Git-155)
>
