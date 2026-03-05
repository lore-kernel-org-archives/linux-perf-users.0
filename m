Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51226738C
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682727; cv=pass; b=o3iz138Z1LE4u5OqRCFD81kjm/tYZMRVlZ1hcd+FsrGJP20AvEDjBw2inG+SaCWFgss6eh5ARpBTJgpAWZoAJpDywsmda0rCqGvd/qdtc/urdN7PTyKXpCNmLXuldo8O93ps+1xlpgS+u2X2nlKz1o1QOMgYJoWSDWFkp45rf/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682727; c=relaxed/simple;
	bh=fSMFzKlToje7AHTglujYAfbTU1CEsdNdxVdtm5c4IB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qyQRKqCwC0RysJ+CI8Q1lqOlsb0vKjQhmgR0tg4T6A5VQxayt6dbH5WPKtYA6aE/F0aGox+GYonW6sithF4evOVHV3keBdD7dNjpNNuQHcjjlVB15YpOxB+vqLY4aWjKGuLlwyDeDD0WylKLSHCYUO9oGdtI4T0cfgHyNfhCtKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=a6mHKIDj; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a6mHKIDj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b939cfc1e83so600528366b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 19:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682723; cv=none;
        d=google.com; s=arc-20240605;
        b=eG0XXEgCnMY3+bpF5IhxCj19GOdUtmQWWXSurAmVR7yyoE5h4245NsP3UNs+LWpMvh
         FcBKDjiZ8ijtgRGbkPPpq0yWr9JCkg2m8roia/ShU42TfKZAka4vrPKhdkwHgqH9wTVz
         ofVMIHY/sEw16qlFL5JGTDudLMUbFOZGAaJNRHwrMWkYMD4sm4S0SfoOuAOAh3VLrhFO
         0/pgiBh1NmAwYoLfUCrtRcsr84NLOCeHh824y9QeCPQL4Aj9tmjiUms1gs/qsC2DdEUf
         eERo/w44ocXmlKwyz0A+HyJzE0IuxqHFExJOJHLgA56aXllhuFFzSrME+xrF3DT2/DSe
         Ed5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laQ2AvpCgXuC+R6d2u3IgOfzliLlwjhc9p/ySjCR+uo=;
        fh=1y0IovvazOyYTT2jpK+9zR64Q1tKbKtlS/Si7OGUeRs=;
        b=AZDiLrDD4sbVBiXXDtCAjmKpkDOvae6p5rK13bQu9JM9HBgPTlvbHF5FeLmtuS8pBA
         lP1bj5xxiE835j1it7+NnivRfnYSAcTWUjSCR9OExaPnAYRAQP1Q1LZ0FYUmu6ibhiSR
         hbRYoEgVmQPeXXOxX05i++WsQpa99yyi4qHGOU9js+7gJNtib+3dVCuVa98H2WwIDUMs
         wHlqJCy92sxv47iJVVLhMPyeNKpMWRagppVqDe+O3ZYrNu8rl6tD21ZQ+P9wYHhKzXpv
         +9PpnNHs/0utT2vLGiLowU+eAkM7XO959L0McMgggUfQ0C6tEBDqrQfgSOoLY9Df33h2
         orAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1772682723; x=1773287523; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laQ2AvpCgXuC+R6d2u3IgOfzliLlwjhc9p/ySjCR+uo=;
        b=a6mHKIDju5hd8NdJ5bt3L6JNOvIuv3L/B+G9Zb4QywXTM9YT8m+YwWUj9tNFHni7Rb
         N1NiYJ37Mu+ddv3XHhWALnjnWRb4a1XZRpZ0AAv6bWs2zQgwYtke8WxB/pHCvGqzmMmM
         jHSihOQMTkSrC2U2z75ab2HWyAQ4QeBUznrJECCok3+rS4DDsxq+d9zkvwyOA/a4u9YK
         ORgLxzuSPnvvjoaTZxXUABMdxnxlQCmcdeQCWpppKmGi4WwIun/7C/60Ix9kzkM4CHBW
         InWz+hNJSW77YnYNH3SaFF1zZ3sEOo4SP9ubq+WrPaGWZgXBaKFOOrO5sp4PcMazBAL4
         K2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682723; x=1773287523;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laQ2AvpCgXuC+R6d2u3IgOfzliLlwjhc9p/ySjCR+uo=;
        b=P140+te5pvR+klwYhLTLXfxGDWQFD0KGCa5tqXMzpjp7cpP7Qox5nWEnz2pN3fDPfO
         sPOdU2AbH3Xk+pRqbJGpXy1/3rCv5MAk9p+UEIsuXPhCtvIKGqzHVvpEKZFb5wGTbZkD
         c2BrvygGJQx6xPRO9VwBlKcUUdkzOtVDOKXc9mJznXryuPqH54jGGJZ6jiYPY37PDKYD
         1AAI7QjFT3NVq5yiTO3vBi3efu9olOKx0alAmfjLZPG3IYa+6Dln537JKtod2d4WyHfh
         bri44XH79eKY8rsgAKOaqneOVN/HRkDa9ode+jBWU19E2mE/M/pfFZy3DO5JYoOcNMlc
         u5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWFzcTBbv6zv9LkAZzlCTTmHR3/9Fipn8Otu2a4WXcYuMbPqL75M8ddNw0sZyPH4zUBjdjSA+Ie4ikYdLUrtYD+@vger.kernel.org
X-Gm-Message-State: AOJu0YwcL/gm4X2dTIEioNQNJuUD9pdKrhCFjH//G1/x1vsJo8OdnMAQ
	6EWGwI/mP7xThB/VRnjeqAL73Q0Z1tnxUoXOwNwl/IuqLaikRyHFd/2v4V/sTM0AW0PjHlE8v8X
	TQ5K2oFORV1Q/YMP58FOID8ywtx4IEoyi8DeVplAOHA==
X-Gm-Gg: ATEYQzzfo/cw8b6hYJC+wSvgDs4tykdmcA3hzT1zDlyJsAd6JChPa6CrzRaYnj9rhX3
	BfciacizK5QP295ns/Xd3AwSY4MtuMWKdRfPF/BI3m10edOHURXgrzmwmyn1M9dGN1KuuncCNRF
	6b1RXMSMjac1gUHvbJE11JAmpuUu4t6vHBGLAlZ04h6xIpXHQngn3Fj3bDlHyrTxwgx4BztZ1T0
	fvrd8Pp6NLmvY3QnBNbE+8uVwRD1RjKvfT4zWB1BOUE+ASUx5bhwiM9uRa4hm9+TZOu0oqNEVtL
	nCo1TCvmmw==
X-Received: by 2002:a17:906:f59f:b0:b93:c5a9:a5f4 with SMTP id
 a640c23a62f3a-b93f1171a50mr230933866b.9.1772682723178; Wed, 04 Mar 2026
 19:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208063848.3547817-1-zong.li@sifive.com>
In-Reply-To: <20260208063848.3547817-1-zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 5 Mar 2026 11:51:54 +0800
X-Gm-Features: AaiRm52-PEQgHfjyPwhUeK2thl3vuXWbRxSFi-k5ctXKrtEiXxfPbnakyP7RYIc
Message-ID: <CANXhq0rLQYL3hVhirV09nQKjnFy2wR+TFr5E=_YMQJPYU25QkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	conor+dt@kernel.org, guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com, 
	lv.zheng@linux.spacemit.com, andrew.jones@oss.qualcomm.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Jingyu Li <joey.li@spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 2:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> This series implements support for the RISC-V IOMMU hardware performance
> monitor.
>
> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
> created by the parent RISC-V IOMMU driver. The child driver can obtain
> resources and information from the parent device, such as the MMIO base
> address and IRQ number.
>
> Custom event support is not included in this series and will be submitted
> as a separate series. The idea is that custom events will be defined
> through the driver data of the auxiliary driver. When the parent IOMMU
> driver creates the auxiliary device, it should pass a vendor-specific
> name as the device name in order to match the corresponding auxiliary
> device ID.
>
> After my initial RFC and the v1 patch series were posted, similar patch
> series also appeared on the mailing list.
>
> One was from Yaxing Guo:
> https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
>
> and another from Lv Zheng:
> https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac1c=
352a469f@linux.spacemit.com/
>
> Yaxing has agreed to pause his series, as discussed here:
> https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@=
bosc.ac.cn/
>
> The motivation for sending this v2 version is not only to address the
> feedback and suggestions from the previous round, but also to introduce
> a major structural change: the PMU driver has been moved under
> drivers/perf/, which has been mentioned repeatedly by several people.
> This results in a different driver structure compared to my earlier
> version and the other two series, and I'd like to gather feedback and
> suggestions from the community on this approach. If the community would
> prefer to go with Lv Zheng=E2=80=99s version instead, I am perfectly fine=
 with
> that as well.
>
> Since I did not follow up closely on the patches from Lv Zheng, Jingyu
> Li, or Yaxing, it is possible that this v2 series may miss some important
> features or fixes from their work. Therefore, I would really appreciate
> it if everyone could help review this v2 series and point out any
> additional fixes or feature support that I may have missed.
>

Hi Robin,

This is the next version of the previous series. It seems to me that
this v2 version addresses all the suggestions you mentioned in the
previous series.
https://lore.kernel.org/lkml/20250115030306.29735-1-zong.li@sifive.com/

I talked with Lv Zheng, we'd like to know if this version looks good
to you, or if there is anything else that could be improved?

Thanks.

> Changed in v1:
> - Rebased onto v6.19-rc8
> - Pick all suggestions and feedbacks from v1 series
> - Add cpu hotplug implementation to avoid race enablement
> - Move PMU-related definition from header to c file
> - Change PMU driver to auxiliary device driver
>
> Changed in RFC:
> - Rebase onto v6.13-rc7
> - Clear interrupt pending before handling interrupt
> - Fix the counter value issue caused by OF bit in the cycle counter.
> - Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
>   in riscv_iommu_remove()
>
> Zong Li (2):
>   drivers/perf: riscv-iommu: add risc-v iommu pmu driver
>   iommu/riscv: create a auxiliary device for HPM
>
>  drivers/iommu/riscv/iommu-bits.h |  61 ---
>  drivers/iommu/riscv/iommu.c      |  20 +
>  drivers/perf/Kconfig             |  12 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/riscv_iommu_pmu.c   | 661 +++++++++++++++++++++++++++++++
>  5 files changed, 694 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
>
> --
> 2.43.7
>
