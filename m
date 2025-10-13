Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45530F54C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394864; cv=none; b=lEpYwqPRI+Bgc1+F0kiak4KIn9s63nhQRWn0soCibduHlSOy8rNg8hKI4BDTeKkW8ZcxblGGtmjarZ7oMmXMuT6lZsHCusFQ3Od30rcNFPmeYwK5IUegtm8QvO3+y6nBxvTKFLMCk30eeXU2Ef842AEBYN+zQCUj3bndow0uv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394864; c=relaxed/simple;
	bh=UpuAxADbv7GA++YfwZct97abHEvsfJGjTfg+N9P5LSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeNTglUJA6PbpoIvGQ/mG6ZFlFl8cGb2zMbpW+GZUNCWHRhjWI1Be3XkCCkdCiOwwAg/5rySJx5LgH+IjFBknBG+ZxSVWNrl+SqQrzvUwnZGfQnl/LRko/p8TsbecUpJbpls7hfmKbbPYvUT/HCuCODfxSBNkw01qvDGQp1G7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xsu2N3bR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xsu2N3bR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3352018e051so5434936a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760394859; x=1760999659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwbGv4J28a1dG4lLmSXG6e+W+t/2iTnwMsiuMvjryc0=;
        b=Xsu2N3bRzic08PArIaedhsGebbkn7SG8s3Ei7IebWaugI4rbtFa2om0zHvmgH1m6LR
         ATCR6mWdfzPYCTzaprdpPFgOWOmBs6c9AHPKNPQl0sMwvOZpf3SIVgRrLTd8meGrkUMi
         44hfReYwVJ8qFwIpllysMq7uAxTXj2DGzw1lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394859; x=1760999659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwbGv4J28a1dG4lLmSXG6e+W+t/2iTnwMsiuMvjryc0=;
        b=laotLhFzwWhfOseZXJalqqtxzqrq5jX65ncNEtauEHGlI6eadfa2E6LsTxB97/aTJT
         E3zD+9hhC1SdQqUIBBEQgc/ZJ2LfmvA/OGrRtNCNn3JpnUOgRG80IfrjcxX8QvuuzNpY
         uiP8x54xv9lxghOBcinyGFMLSLcR+NG5krwTDnfj+H++XiaFPAeWJR2RS4g+HNhwsI2x
         mlHm87iV1WU6UAnjF9UuAKphPXThETOc8m5eI93eLRpRpKzt/baOuCaryaedXAjJLJFx
         e771S/zWYuGiX6dmMPlH+BmUWx9GXe1/l6T0v6wlM2ixBd+dvc/GOieYRCUxNEoSDbQv
         RXvg==
X-Forwarded-Encrypted: i=1; AJvYcCXCzz8bjVRuGZIFHNtvdgVVjhjVaWqCJ65xmASL2FdNvH+UDjPN0OhGtblYpE08cF1IOpPnU0eZQea/TNyMZoBq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oq+h1fiFzpaDuBThewAjVFFdGy64MJeN+RHF9fbwCKq4lFy/
	/UumN3gVo7kPqgjggvud2Fo85Q2kOWO8PGRUUMyxMGgUzLgjdQifCokrRKgvIn1KfUYl8nGDz0l
	NkJk=
X-Gm-Gg: ASbGncvMj+RpWg5EkTMngBtZg4hu7gjBm5Vd0l81/6ZL9DVNfiSW8gtkyuKWVfqdzuo
	oLg3Nws5b6PqwLE22zDEXUOHUTuOJUjo8LC+cD9SGmrEtihEChUSzSitoqGJedhAW8cdjqMlkU2
	xyVkpiSDmAZgv6J5tN0rZJFjDBIRC2IBPoUCBRznjY002iMiQ/MsGBEqPtoucw+3geTEOtBPg/Z
	3MZ+J2E/ozMHa9zWY7jgYIlc9uWq+ag3faY/zEHoPlety48sLM3jpUB3nhMmXOswY9EocufZHUr
	zvd0zhPPNQvPbWD/dkD6PTGjBNL00P1+XNabKqAzwCaB/MTpI+udn16g5WCXbyw9CyBnf+0ihDK
	uPbM3LIP7iX4AaFquoOC9ikyNwkaeTyEIpoQ/7flGiDwztk60NpK6KraSlbZM4QInBJ+OgJzGZR
	f8N1wp
X-Google-Smtp-Source: AGHT+IHfpgw+9B6qsQd+FgLCghFRt2ncOCJAYfs0OErwzXkYiRm8Ds3AgQ7L3Zd/oH0xIbZSOdGIpA==
X-Received: by 2002:a17:90b:3148:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-33b5137587amr33577925a91.24.1760394858797;
        Mon, 13 Oct 2025 15:34:18 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6264734csm13349046a91.10.2025.10.13.15.34.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:34:16 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so5924321a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 15:34:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdwexMFQoRi9JCz+HG8gAV4Z0fdeqRchgADPtPcFPbB1ht5EJ5kjK3cRds9B5Xo1HWzhFe5MnY7n3/nCWkVzRZ@vger.kernel.org
X-Received: by 2002:a17:903:11cf:b0:269:63ea:6d4e with SMTP id
 d9443c01a7336-290272c1aa5mr269142435ad.37.1760394855700; Mon, 13 Oct 2025
 15:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009032838.63060-1-cuiyunhui@bytedance.com> <20251009032838.63060-2-cuiyunhui@bytedance.com>
In-Reply-To: <20251009032838.63060-2-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Oct 2025 15:34:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcgDFk-Ad8nhOYK8Ay_8==3JRxaZ=8j3SHCa2rTKJCTA@mail.gmail.com>
X-Gm-Features: AS18NWDRlpKOc8vUNSnX7EzUSo2l7O6rFyMCga60WeZRtc9k0KplotG4eFs760Y
Message-ID: <CAD=FV=VcgDFk-Ad8nhOYK8Ay_8==3JRxaZ=8j3SHCa2rTKJCTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] watchdog: move arm64 watchdog_hld into common code
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 8, 2025 at 8:29=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Move the contents of arch/arm64/watchdog_hld.c to kernel/watchdog_perf.c
> to create a generic implementation that can be reused by other arch,
> such as RISC-V.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/Kconfig               |  2 +
>  arch/arm64/kernel/Makefile       |  1 -
>  arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
>  drivers/perf/arm_pmu.c           | 10 +++-
>  include/linux/perf/arm_pmu.h     |  2 -
>  kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
>  lib/Kconfig.debug                |  8 +++
>  7 files changed, 102 insertions(+), 98 deletions(-)
>  delete mode 100644 arch/arm64/kernel/watchdog_hld.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5438ff4772ce..4759e4969c4a6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -231,6 +231,8 @@ config ARM64
>         select HAVE_GCC_PLUGINS
>         select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
>                 HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +       select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF &&=
 \
> +       CPU_FREQ

nit: the line limit is generally accepted to be ~100 characters now.
It would be nice not to wrap. If you really need to wrap, indent like
the wrapping above.

In any case, this seems like a reasonable thing to do to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
