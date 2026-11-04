Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809233;
	b=XzUwceEERIqk6OntzKQqAUaMv3381/vxBefEDOKeCdOVB/vTvsg17T4ryUoC1vnJfSRQ
	 A4OueB5KSnlE1xL0YEIfTqZRSQ51ueoV3fPT2zu1ZIO8Xg6KL4+6f8ln4xpFTfFn01OF8
	 pDnLB3QtY4z1FHzldQT71rRDKsBPuraMOGd9is5Q+Xxiy5dkQzUGdDpBi0ObOaz9KpUkp
	 FB901fd9uRgGdG1QSMq4aTt4Qh2PjrfgQDqcmc2aUmEiRUd2NUuReoyyRrkB2ePXDvm2B
	 Qr1Knz/SzhiWKpv0gtKhuiTXYa/s1eu8PUqQmaTwc0q+9PiLgXf3WbTSwkbh4OhSf6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7WX/ZTMITs0q76Ht6EmOOVK989Ar1uU+fZznXiAFQ00=;
	b=zfI/l5E41LnWcrIpU2uap/sNQNOOMJazz5mDS76OxAdPEJHas5kJhjWyLy5lLWliq0vi
	 0b8QSSeoziMcZTb6fD9t6YdaJhizudhIt+YeJpRJA6KDRsjLiod/kgJGbMMiwEc3CuPMd
	 vAtHpH3TgIAN0cP6QXMP6Mu5dnQk+845yJI4XfSTgtyoujicVySLQ5Ho2PjK7HwT7g+Xu
	 wn3Tsi50TqujQpKCMb9Xex0LYnNOVnchRU5gdMqvMgzU//XST0oGjPehKncN6ZQMnEPRR
	 E0RG2POzctlW/bfujwzR78SrXwwfnpu4xqp8eb03lhtS0YEzwVT9peG479Vc+dX/m0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="e7CwDu/v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E116606A329
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E116606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7CwDu/v
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533202fe429so338731cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 08:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793809232; cv=none;
        d=google.com; s=arc-20260327;
        b=EezCL52vvP9XSexTmsJh0D17qBBrDNkp0X2BL5KZjtvY56/WwJEu2QET51YiZ/rMyj
         idOABfWO51Pp7LPn60PKN+zhoiA+if8B2nL7KomeAzNHkAvYgeFq/GdltJrh8haVvwqM
         noauOKl+JtOo88hdC2A2WAfdlJS3ZuT9RTXT4+tZ/Ej2j5ajM5oOxNUswANepAzCM6kA
         o/cMTw6wOBaeJv4hEp1RmFKAOIOkNTO/VSny5dSHHV8MfdrOABUYdVtuq12faPNI+cOy
         MHqIkfDd8dI8YK8Y935QjYp1R6EGTO6OsfkNfD/M2cky8f+Hn2CkUqyt/Rzk9d7YwqMs
         Uyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7WX/ZTMITs0q76Ht6EmOOVK989Ar1uU+fZznXiAFQ00=;
        fh=s0iWiBwDEAk8ATk9kcxiughvR5ShQdMxCudCWTAvYVQ=;
        b=hI68J/kQfiWBGEzCdrvmGa/IO3VU32NMYh3ompoaAMJ5VysycnkSI+6jlWImB41gFq
         ZbLPOZQHQ5rpDkFd/rtEFqTuGORApyEGCnIDybsJ8zMe6okPaNig1b9DVS1nDJbhOu61
         tGT2vnhhcswG1kGLEmaOZ8WZ/UNuXQkBLboQLrgtEx3wt8BS9DVxIGMJ2zr1jNxBYJJB
         aCQClR3t0ybIhvCkwadS9feKZmZ0m3TEWGIPXjZ5poqdbq+t4wqfFvGFyFrT4E7eDmFK
         KzCEZ1b+T9cwOJ42Mlq8uOEvFq0rRgWc7vbWl25ns38pgoG4CyFfFz3IvDgLij9YySeM
         hCIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793809232; x=1794414032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7WX/ZTMITs0q76Ht6EmOOVK989Ar1uU+fZznXiAFQ00=;
        b=e7CwDu/vxnexZuo4KfJhPCtRyWpfG4HA0qSLqj+dx6M9IOdxQTm/gBei/ZyfXmq/tY
         P3MSh9PYrzkGTLNUGfeAhvMJ48cwsMtPhpMNJbHeeVj1mW9CQXZ5nMm75rYZGkOVbG3k
         rFNTr2VlmNYDn/QUmG26sYZcxpZv36ky85ZtR1vsgYmamTbuT99dkuYTfms7KontHtol
         tezQM6c6DOiouuc7Ebec+4sCb42oFqyMr5n5XDWfnRzA8OB+lUGytMxXw1jIxctA7xux
         OKtvTcZV765Kwpj2pfdySCuyVlXj0n9CPKwUySlhGEsxzWP2LfN4uZcLgzZ/XyNTaa/H
         wgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809232; x=1794414032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7WX/ZTMITs0q76Ht6EmOOVK989Ar1uU+fZznXiAFQ00=;
        b=UQCbyfLqSw+JM1f4yqb7BwSMB1tzL2/OH3pccVGEs+G5AtUeu5NyJ7JMF0y4TY6c8u
         LlkO0mxCdWmOA2Rs87EOurJ+P/MAcQu9Md5BBaTiL7XsM71XeNC30SoNQApc6gXdEz1o
         J2fjntbeD0hC2Z2xR8l4OdKBjsnjap+BNqF95blmCvYLh8CeDZKfbhZkh1awNDdVQjz0
         sqwaIG7ANi4nD4EZL1wtpDisp63Y+csxuFd3Felwg2L4AUxZtQb8Gp/kPRYT6hXAk1SU
         J9JwyIHX7+2XCj5ejeKwdyaY/Q1TQuvncxkWzyXJVNk56SFXYfjVftgn80ItwFnmtzWN
         5Okw==
X-Forwarded-Encrypted: i=1; AKwUvBxlDNxQu13H7/uov9enyxmHZEIaXGx4RrSgn5aioY3mHyrpKS7SMn1IC+ukiWVxKaGlE0p5A5jOrBXcz+bE+b+L@vger.kernel.org
X-Gm-Message-State: APuU4Z/LojbBheaNhXYpSlUGNfF6lrxnspsTNz55Htf0dNhlfwvPZRgb
	RZh2nKwH91P8fbE/1u2i/pKpZi2CX9LF0xRFscSKJQR1OLvrWxiUeDZGABBWkYvIkChh4wsMPrp
	4+C+gjVrlbWfazbFwOGooH1OPDl3wX5L03wewqvBy
X-Gm-Gg: AYBFou3+03y/LQqiR/+Fy187wPrcOs7J02ORbD4NJSNWZZlFsZ3VnMOBpKp1e0tQTDC
	co1633CuRCVbtChB6NP+TfC1OP1ErJQLqMv5cDdQOGGw/ANi0f+ooajXI8u1Y7fKO821NZJDxdm
	aDJYrMRYoJmhOwz91TJlofUZeBYBn9tNo7IgFJk10vRxAoFXdw7uuvOgGgUuRY7hfuhohoxQ/Np
	+ELEvu2zCcASITvx2RUPp09gNx7Dn7RswG6dAgFXhLMj7OinheRIL3GtBYjZ6XPL8n76tDyR/HZ
	Oq3+K5RiPknU0xmdza6/LHOo7ei3XVbTi1GWaGZg5+/CRQuF0qM613Qf0hrm6riEgOd6YiW9JiR
	y0tVgtzMJRNeOGBMx3kMmM6fGrApaNfNbbbSnT/bY0TdeUitpa6TBn6XRHvWFXIB34aAviD4ibS
	Pe4AHISkDZoiE=
X-Received: by 2002:a05:622a:5a17:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-54b828def6bmr16257461cf.10.1793809230476; Wed, 04 Nov 2026
 08:20:30 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104160716.2910873-1-bwicaksono@nvidia.com> <20261104160716.2910873-6-bwicaksono@nvidia.com>
In-Reply-To: <20261104160716.2910873-6-bwicaksono@nvidia.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Nov 2026 08:20:17 -0800
X-Gm-Features: AclHuK8kmY9Y5i9GpPnoLDbH8n_OPilb4d8Fhx3j9bcjOJ8O94IiJtK0q4nuoTg
Message-ID: <CAP-5=fUP4ivJpDySjk5Np5VM=Q3xaSL4ONkZZLumQn=OH_hucA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] perf jevents: Add support for NVIDIA Tegra410 C2C
 PMU aliasing
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@kernel.org, namhyung@kernel.org, ctshao@google.com, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, mochs@nvidia.com, 
	rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
	john.garry@linux.dev, will@kernel.org, james.clark@linaro.org, 
	mike.leach@arm.com, leo.yan@linux.dev, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:08=E2=80=AFAM Besar Wicaksono <bwicaksono@nvidia.c=
om> wrote:
>
> Add alias support for NVIDIA Tegra410 C2C PMU events.

What does alias mean in this case? That there are json and sysfs
events? I don't see support being added, only additional events.

Thanks,
Ian

> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++++++++++
>  .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +++++++
>  .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 ++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-n=
vclink.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-n=
vdlink.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-n=
vlink_c2c.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.=
json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
> new file mode 100644
> index 000000000000..1e7f8115ff9c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvclink.json
> @@ -0,0 +1,67 @@
> +[
> +    {
> +        "EventCode": "0x0",
> +        "EventName": "NVCLINK_CYCLES",
> +        "BriefDescription": "Counts NV-CLink interface clock cycles.",
> +        "PublicDescription": "Counts NV-CLink interface clock cycles. Al=
l NV-CLink instances share this clock, so the count is read from the first =
instance.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "EventCode": "0x1",
> +        "EventName": "NVCLINK_IN_RD_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding incoming read r=
equests counted by NVCLINK_IN_RD_REQ each NV-CLink interface cycle.",
> +        "PublicDescription": "Accumulates the outstanding incoming read =
requests counted by NVCLINK_IN_RD_REQ each NV-CLink interface cycle. Pair t=
he two for the average read latency.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "EventCode": "0x2",
> +        "EventName": "NVCLINK_IN_RD_REQ",
> +        "BriefDescription": "Counts incoming read requests from the remo=
te Tegra SoC at the NV-CLink interface.",
> +        "PublicDescription": "Counts incoming read requests from the rem=
ote Tegra SoC at the NV-CLink interface, where local memory or a local devi=
ce responds with data. Request size can be from 1 to 256 bytes. The count i=
s summed over all NV-CLink instances.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "EventCode": "0x5",
> +        "EventName": "NVCLINK_OUT_RD_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding outgoing read r=
equests counted by NVCLINK_OUT_RD_REQ each NV-CLink interface cycle.",
> +        "PublicDescription": "Accumulates the outstanding outgoing read =
requests counted by NVCLINK_OUT_RD_REQ each NV-CLink interface cycle. Pair =
the two for the average read latency.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "EventCode": "0x6",
> +        "EventName": "NVCLINK_OUT_RD_REQ",
> +        "BriefDescription": "Counts outgoing read requests from the loca=
l Tegra SoC to the remote Tegra SoC at the NV-CLink interface.",
> +        "PublicDescription": "Counts outgoing read requests from the loc=
al Tegra SoC to the remote Tegra SoC at the NV-CLink interface, where memor=
y on the remote Tegra SoC responds with data. Request size can be from 1 to=
 256 bytes. The count is summed over all NV-CLink instances.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "MetricName": "nvclink_freq",
> +        "MetricGroup": "NVCLINK_Frequency;NVCLINK_Latency;NVCLINK_Read_L=
atency",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVCLINK_CYCLES / aggr_nr(NVCLINK_CYCLES)) / 1e9 =
/ duration_time",
> +        "ScaleUnit": "1GHz",
> +        "BriefDescription": "NV-CLink interface clock frequency.",
> +        "PublicDescription": "Average NV-CLink interface clock frequency=
 over the measurement interval.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "MetricName": "nvclink_in_avg_rd_latency",
> +        "MetricGroup": "NVCLINK_Latency;NVCLINK_Read_Latency;NVCLINK_Inc=
oming",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVCLINK_IN_RD_CUM_OUTS / NVCLINK_IN_RD_REQ) / nv=
clink_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of incoming read requests f=
rom the remote Tegra SoC at the NV-CLink interface.",
> +        "PublicDescription": "Average latency of the incoming read reque=
sts counted by NVCLINK_IN_RD_REQ, measured at the NV-CLink interface.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    },
> +    {
> +        "MetricName": "nvclink_out_avg_rd_latency",
> +        "MetricGroup": "NVCLINK_Latency;NVCLINK_Read_Latency;NVCLINK_Out=
going",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVCLINK_OUT_RD_CUM_OUTS / NVCLINK_OUT_RD_REQ) / =
nvclink_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of outgoing read requests s=
ent by the local Tegra SoC to the remote Tegra SoC at the NV-CLink interfac=
e.",
> +        "PublicDescription": "Average latency of the outgoing read reque=
sts counted by NVCLINK_OUT_RD_REQ, measured at the NV-CLink interface.",
> +        "Unit": "nvidia_nvclink_pmu_"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.=
json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
> new file mode 100644
> index 000000000000..7777add3741d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvdlink.json
> @@ -0,0 +1,43 @@
> +[
> +    {
> +        "EventCode": "0x0",
> +        "EventName": "NVDLINK_CYCLES",
> +        "BriefDescription": "Counts NV-DLink interface clock cycles.",
> +        "PublicDescription": "Counts NV-DLink interface clock cycles. Al=
l NV-DLink instances share this clock, so the count is read from the first =
instance.",
> +        "Unit": "nvidia_nvdlink_pmu_"
> +    },
> +    {
> +        "EventCode": "0x1",
> +        "EventName": "NVDLINK_IN_RD_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding read requests c=
ounted by NVDLINK_IN_RD_REQ each NV-DLink interface cycle.",
> +        "PublicDescription": "Accumulates the outstanding read requests =
counted by NVDLINK_IN_RD_REQ each NV-DLink interface cycle. Pair the two fo=
r the average read latency.",
> +        "Unit": "nvidia_nvdlink_pmu_"
> +    },
> +    {
> +        "EventCode": "0x2",
> +        "EventName": "NVDLINK_IN_RD_REQ",
> +        "BriefDescription": "Counts read requests to local CXL memory at=
 the NV-DLink interface.",
> +        "PublicDescription": "Counts read requests to local CXL memory a=
t the NV-DLink interface, from all requesters, local and remote. Request si=
ze can be from 1 to 256 bytes. The count is summed over all NV-DLink instan=
ces.",
> +        "Unit": "nvidia_nvdlink_pmu_"
> +    },
> +    {
> +        "MetricName": "nvdlink_freq",
> +        "MetricGroup": "NVDLINK_Frequency;NVDLINK_Latency;NVDLINK_Read_L=
atency",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVDLINK_CYCLES / aggr_nr(NVDLINK_CYCLES)) / 1e9 =
/ duration_time",
> +        "ScaleUnit": "1GHz",
> +        "BriefDescription": "NV-DLink interface clock frequency.",
> +        "PublicDescription": "Average NV-DLink interface clock frequency=
 over the measurement interval.",
> +        "Unit": "nvidia_nvdlink_pmu_"
> +    },
> +    {
> +        "MetricName": "nvdlink_in_avg_rd_latency",
> +        "MetricGroup": "NVDLINK_Latency;NVDLINK_Read_Latency",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVDLINK_IN_RD_CUM_OUTS / NVDLINK_IN_RD_REQ) / nv=
dlink_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of read requests to local C=
XL memory at the NV-DLink interface.",
> +        "PublicDescription": "Average latency of the read requests count=
ed by NVDLINK_IN_RD_REQ, measured at the NV-DLink interface.",
> +        "Unit": "nvidia_nvdlink_pmu_"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c=
2c.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.js=
on
> new file mode 100644
> index 000000000000..48a64caaba61
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json
> @@ -0,0 +1,115 @@
> +[
> +    {
> +        "EventCode": "0x0",
> +        "EventName": "NVLINK_C2C_CYCLES",
> +        "BriefDescription": "Counts NVLink-C2C interface clock cycles.",
> +        "PublicDescription": "Counts NVLink-C2C interface clock cycles. =
All NVLink-C2C instances share this clock, so the count is read from the fi=
rst instance.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x1",
> +        "EventName": "NVLINK_C2C_IN_RD_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding incoming read r=
equests counted by NVLINK_C2C_IN_RD_REQ each NVLink-C2C interface cycle.",
> +        "PublicDescription": "Accumulates the outstanding incoming read =
requests counted by NVLINK_C2C_IN_RD_REQ each NVLink-C2C interface cycle. P=
air the two for the average read latency. The gpu_mask filter works as desc=
ribed for NVLINK_C2C_IN_RD_REQ.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x2",
> +        "EventName": "NVLINK_C2C_IN_RD_REQ",
> +        "BriefDescription": "Counts incoming read requests from connecte=
d GPUs or a remote Tegra SoC at the NVLink-C2C interface.",
> +        "PublicDescription": "Counts incoming read requests sent by conn=
ected GPUs or a remote Tegra SoC to the local Tegra SoC at the NVLink-C2C i=
nterface, where the local Tegra SoC responds with data. Request size can be=
 from 1 to 256 bytes. The count is summed over all NVLink-C2C instances. Fi=
lters: the gpu_mask filter selects GPUs by index, one bit per GPU. This fil=
ter is available only when GPUs are connected. An unset gpu_mask counts all=
 GPUs.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x3",
> +        "EventName": "NVLINK_C2C_IN_WR_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding incoming write =
requests counted by NVLINK_C2C_IN_WR_REQ each NVLink-C2C interface cycle.",
> +        "PublicDescription": "Accumulates the outstanding incoming write=
 requests counted by NVLINK_C2C_IN_WR_REQ each NVLink-C2C interface cycle. =
Available only when GPUs are connected. Pair the two for the average write =
latency. The gpu_mask filter works as described for NVLINK_C2C_IN_WR_REQ.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x4",
> +        "EventName": "NVLINK_C2C_IN_WR_REQ",
> +        "BriefDescription": "Counts incoming write requests from connect=
ed GPUs to the local Tegra SoC at the NVLink-C2C interface.",
> +        "PublicDescription": "Counts incoming write requests sent by con=
nected GPUs to the local Tegra SoC at the NVLink-C2C interface, where the G=
PU sends the data. Request size can be from 1 to 256 bytes. Available only =
when GPUs are connected. The count is summed over all NVLink-C2C instances.=
 Filters: the gpu_mask filter selects GPUs by index, one bit per GPU. An un=
set gpu_mask counts all GPUs.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x5",
> +        "EventName": "NVLINK_C2C_OUT_RD_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding outgoing read r=
equests counted by NVLINK_C2C_OUT_RD_REQ each NVLink-C2C interface cycle.",
> +        "PublicDescription": "Accumulates the outstanding outgoing read =
requests counted by NVLINK_C2C_OUT_RD_REQ each NVLink-C2C interface cycle. =
Pair the two for the average read latency. The gpu_mask filter works as des=
cribed for NVLINK_C2C_OUT_RD_REQ.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x6",
> +        "EventName": "NVLINK_C2C_OUT_RD_REQ",
> +        "BriefDescription": "Counts outgoing read requests to connected =
GPUs or a remote Tegra SoC at the NVLink-C2C interface.",
> +        "PublicDescription": "Counts outgoing read requests from all req=
uesters to connected GPUs or a remote Tegra SoC at the NVLink-C2C interface=
, where the GPU or remote Tegra SoC responds with data. Request size can be=
 from 1 to 256 bytes. The count is summed over all NVLink-C2C instances. Fi=
lters: the gpu_mask filter selects GPUs by index, one bit per GPU. This fil=
ter is available only when GPUs are connected. An unset gpu_mask counts all=
 GPUs.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x7",
> +        "EventName": "NVLINK_C2C_OUT_WR_CUM_OUTS",
> +        "BriefDescription": "Accumulates the outstanding outgoing write =
requests counted by NVLINK_C2C_OUT_WR_REQ each NVLink-C2C interface cycle."=
,
> +        "PublicDescription": "Accumulates the outstanding outgoing write=
 requests counted by NVLINK_C2C_OUT_WR_REQ each NVLink-C2C interface cycle.=
 Available only when GPUs are connected. Pair the two for the average write=
 latency. The gpu_mask filter works as described for NVLINK_C2C_OUT_WR_REQ.=
",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "EventCode": "0x8",
> +        "EventName": "NVLINK_C2C_OUT_WR_REQ",
> +        "BriefDescription": "Counts outgoing write requests to connected=
 GPUs at the NVLink-C2C interface.",
> +        "PublicDescription": "Counts outgoing write requests from all re=
questers to connected GPUs at the NVLink-C2C interface, where the requester=
 sends the data. Request size can be from 1 to 256 bytes. Available only wh=
en GPUs are connected. The count is summed over all NVLink-C2C instances. F=
ilters: the gpu_mask filter selects GPUs by index, one bit per GPU. An unse=
t gpu_mask counts all GPUs.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "MetricName": "nvlink_c2c_freq",
> +        "MetricGroup": "NVLINK_C2C_Frequency;NVLINK_C2C_Latency;NVLINK_C=
2C_Read_Latency;NVLINK_C2C_Write_Latency",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVLINK_C2C_CYCLES / aggr_nr(NVLINK_C2C_CYCLES)) =
/ 1e9 / duration_time",
> +        "ScaleUnit": "1GHz",
> +        "BriefDescription": "NVLink-C2C interface clock frequency.",
> +        "PublicDescription": "Average NVLink-C2C interface clock frequen=
cy over the measurement interval.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "MetricName": "nvlink_c2c_in_avg_rd_latency",
> +        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Read_Latency;NVLIN=
K_C2C_Incoming",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVLINK_C2C_IN_RD_CUM_OUTS / NVLINK_C2C_IN_RD_REQ=
) / nvlink_c2c_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of incoming read requests a=
t the NVLink-C2C interface.",
> +        "PublicDescription": "Average latency of the incoming read reque=
sts counted by NVLINK_C2C_IN_RD_REQ, measured at the NVLink-C2C interface."=
,
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "MetricName": "nvlink_c2c_in_avg_wr_latency",
> +        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Write_Latency;NVLI=
NK_C2C_Incoming",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVLINK_C2C_IN_WR_CUM_OUTS / NVLINK_C2C_IN_WR_REQ=
) / nvlink_c2c_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of incoming write requests =
from connected GPUs at the NVLink-C2C interface.",
> +        "PublicDescription": "Average latency of the incoming write requ=
ests counted by NVLINK_C2C_IN_WR_REQ, measured at the NVLink-C2C interface.=
 Available only when GPUs are connected.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "MetricName": "nvlink_c2c_out_avg_rd_latency",
> +        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Read_Latency;NVLIN=
K_C2C_Outgoing",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVLINK_C2C_OUT_RD_CUM_OUTS / NVLINK_C2C_OUT_RD_R=
EQ) / nvlink_c2c_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of outgoing read requests a=
t the NVLink-C2C interface.",
> +        "PublicDescription": "Average latency of the outgoing read reque=
sts counted by NVLINK_C2C_OUT_RD_REQ, measured at the NVLink-C2C interface.=
",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    },
> +    {
> +        "MetricName": "nvlink_c2c_out_avg_wr_latency",
> +        "MetricGroup": "NVLINK_C2C_Latency;NVLINK_C2C_Write_Latency;NVLI=
NK_C2C_Outgoing",
> +        "MetricConstraint": "NO_GROUP_EVENTS",
> +        "MetricExpr": "(NVLINK_C2C_OUT_WR_CUM_OUTS / NVLINK_C2C_OUT_WR_R=
EQ) / nvlink_c2c_freq",
> +        "ScaleUnit": "1ns/request",
> +        "BriefDescription": "Average latency of outgoing write requests =
to connected GPUs at the NVLink-C2C interface.",
> +        "PublicDescription": "Average latency of the outgoing write requ=
ests counted by NVLINK_C2C_OUT_WR_REQ, measured at the NVLink-C2C interface=
. Available only when GPUs are connected.",
> +        "Unit": "nvidia_nvlink_c2c_pmu_"
> +    }
> +]
> --
> 2.43.0
>
