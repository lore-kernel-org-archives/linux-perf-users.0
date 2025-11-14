Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838526F2AD
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086376; cv=none; b=CNxi2ueDVnInoYb3kh5ri8+k519YTQ5Sim3uahMjgZI98LmnPcukHepRjK+hjtWUkOrIkAnuyub16XIECF1HnLxdrR1GpFZwgiuTguqFwuv7142qeWsOIgMxYxRpOJ4B1M+QWyFOsdBdyIVHlVjoLsSO9ygs5YvlrDRXiUwgUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086376; c=relaxed/simple;
	bh=Ah/xJ0bYqUpIFbLqeA3hC94ZlIfAy5PPkysDbnucDRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkYyGE6aerB6LE1SG5Qpnuu8CfAjTrR+Vo+qA6OiPfXeZ3mllDNhZiTo+YqK1Lb5p/+/ii+WorMakbTHz/0LtZrC6OwuWbJ/LMtIMd529f+pzTDme8fThnCBAoC3inOmK+yYe/VFExRYfFOTZu/B/LBDM1vCToGMpryz7kzW6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nr+oKZ2L; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nr+oKZ2L"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4503ee5c160so693064b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763086374; x=1763691174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBM3vq37SG4A6w1IUkBk6VD1Hqp+KmIvSGnOQB9SSPA=;
        b=Nr+oKZ2LHd6dr6Offcl7ttJFtzIxM/xHj81QObPzAkvoZ9Sby5jdqkX0A7CcOV4jLf
         BZpD5CDIb5KbHuNEbTXL6Mbb97/YpDRTs4hbaK+sFjr7je/46GrRTLN0D61Rvow6v+Pc
         t0RpeYnR2qhZTbuNRIa/PJmt9qz2wF3gdcAlrpI+vBFVLMUCsTWBosCxSoILd1xHNbTO
         D+LVBCAYzt2g9T3PlAitNAH+UHjaKVur59rxHHLK3PXY4UElxXdpKAg2gKbNASS7TJUz
         VanZgie5XnFefvh4b7OqWvny3Su3IAV2XhVBq/UuBYzkg+4p9Py6ZdMiWNgryMh6sz0B
         BVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763086374; x=1763691174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBM3vq37SG4A6w1IUkBk6VD1Hqp+KmIvSGnOQB9SSPA=;
        b=CMReOFtmDvqVTjZcwABaZPY4xI+/56Gr/AVQSBQqZfByRKeJY8jU4TDu8ysiZj6yXL
         2BD1LRGTZ1BI5ArEAlO9GbN+3yFa9hjVcYnfUwNZNx2TOB6mPu1/yzFFGhWbAX48RCUl
         /OHRPusNtUvyKoMuZMA9ywFfSl2W2GBfNy1a0XVKmQcLMQdLzdwUfRtckcYLKBRITvFl
         pfIBSWH8kONRfRpJA5Sl4/FuwI1v4zO/voDCJiwdwNvAQVacTqq9Rzr2QklbaAdUWmQH
         WC7r38Jpp6KTcK+F1JmFk/ZYdkaQqwOAO/AcLA8yqCvstNnBneCXr3I+gUV1egdp7JgG
         ew4w==
X-Forwarded-Encrypted: i=1; AJvYcCWBE6Wz/WpweW7I/vdijfFwimaWp3F5fZJv9WBoVW3CkC0+SILgJIudGUSxpzAFBFK1ZpuFMr4knPrlogi6XJBq@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjQ/qJr8xishE6jCQYHJlXNRdiJy/Z/LkPLPJh7Et8NUTQbgZ
	JPVCc8sWTStyuc3ixzuFnydrHd17/K7eVrAg9WaSQd8M+mlgDEoRLxd/LAK23BRjA6apQlsMxQV
	AZg5uEohKugGi5mHASjXnIoQehZc+z+WFwzGotlfKXg==
X-Gm-Gg: ASbGncsJQm83HNi4PhiO8aiGN5S6MQiSL+UWZQuPIe/04tYyFdrIT8tBrBlYG4sFDP0
	Y8/Vt5v+2O6rBl0zPuuCNTP3NGh9GCAB4YsZ7Q6/k0/nxFK7Ikjk9qn3uOKEGaqDITcdy7l0asU
	WGfyhPH6bHqCH8s1vR3PdmtCKXBbHGlX2WFq8dK0gv/3FoMwGe6QFfZk4yXzewxXo5Z7gPMVS5W
	E0sLNor8hVtoaJI/nOpcu1EopPR8hWk+JXe8+r1n4/xs2AmXJyAmGfF6azCbtBbXPPXOVk5yRRA
	KeohArW1
X-Google-Smtp-Source: AGHT+IHy0n4gQ/6J6Qsut3+AMNzWOn2pYSEr7TLktEg1mu/utZ4gYoyrlrE9G2GmaDzmMmkxvEL9sFE1ukImX70O6Wg=
X-Received: by 2002:a05:6808:221f:b0:450:76f:b1a8 with SMTP id
 5614622812f47-450973ba31emr745094b6e.30.1763086373692; Thu, 13 Nov 2025
 18:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111073459.44030-1-cuiyunhui@bytedance.com> <CAD=FV=VGvp5XsT9R9-LR-dSbGAZ5YVcm=HxBYibCcSdVnNkyPA@mail.gmail.com>
In-Reply-To: <CAD=FV=VGvp5XsT9R9-LR-dSbGAZ5YVcm=HxBYibCcSdVnNkyPA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 14 Nov 2025 10:12:41 +0800
X-Gm-Features: AWmQ_bkAOsbu28DhTbtm-Wf7KobQu9Ki7D8PlLDLwgn0w5kVCtpXXRPq6fTQ_oc
Message-ID: <CAEEQ3wnGUDW_dqbbhM8nLeDH0kL=s89=8x2ESYs=Nm6AMzkV4A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/2] Add HARDLOCKUP_DETECTOR_PERF
 support for RISC-V
To: Doug Anderson <dianders@chromium.org>
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

Hi Doug,

On Fri, Nov 14, 2025 at 6:51=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Nov 10, 2025 at 11:35=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.=
com> wrote:
> >
> > After discussion [1],[2], hardlockup_perf cannot be completely replaced=
 by
> > the hardlockup_buddy approach, so this patch is still being submitted.
> >
> > v1->v2:
> > The contents of arch/arm64/watchdog_hld.c are directly consolidated int=
o
> > kernel/watchdog_perf.c.
> >
> >
> > v2->v3:
> > Add CONFIG_WATCHDOG_PERF_ADJUST_PERIOD to enclose the period update log=
ic,
> > select it by default on arm64 and riscv, without affecting other arches
> > like x86 and PPC.
> >
> > v3->v4:
> > Place the line "select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECT=
OR_PERF && CPU_FREQ"
> > in the Kconfig files for arm64 and riscv in one line, with no line brea=
ks.
> >
> > v4->v5:
> > Remove __weak from hw_nmi_get_sample_period()
> >
> > Link: https://lore.kernel.org/all/CAD=3DFV=3DUEhVCD6JehQi1wor2sSmtTLDyf=
=3D37xfo-DOTK1=3Du1xzA@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao60=
0@gmail.com/ [2]
> >
> > Yunhui Cui (2):
> >   watchdog: move arm64 watchdog_hld into common code
> >   riscv: add HARDLOCKUP_DETECTOR_PERF support
> >
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/kernel/Makefile       |  1 -
> >  arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
> >  arch/riscv/Kconfig               |  3 +
> >  drivers/perf/arm_pmu.c           | 10 +++-
> >  drivers/perf/riscv_pmu_sbi.c     | 10 ++++
> >  include/linux/perf/arm_pmu.h     |  2 -
> >  kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
> >  lib/Kconfig.debug                |  8 +++
> >  9 files changed, 114 insertions(+), 98 deletions(-)
> >  delete mode 100644 arch/arm64/kernel/watchdog_hld.c
>
> Perhaps you missed that (I think) Andrew had already dropped your v4
> due to the Kernel Test Robot finding a problem. See:
>
> https://lore.kernel.org/r/202510240701.eB6r97V3-lkp@intel.com
>
> I don't think you've fixed these problems in v5, have you? I think you
> need a v6 for it? I haven't dug all the way, but I'd suspect the
> compile error is if "HARDLOCKUP_DETECTOR_PERF" is defined but not
> "CPU_FREQ". Indeed, that matches the config in the report...
>

Thanks for the reminder. I indeed missed replying to the email dated
October 26th regarding the error "ld.lld: error: undefined symbol:
hw_nmi_get_sample_period".
We can fix it directly as follows:
-       select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF
&& CPU_FREQ
+       select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF
Because when CPU_FREQ is not defined, there is a stub function, and
the corresponding max_cpu_freq will be set to SAFE_MAX_CPU_FREQ.

>
> -Doug

Thanks,
Yunhui
