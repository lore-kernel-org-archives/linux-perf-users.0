Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B82E3AE9
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073954; cv=none; b=DfsPj5sXshHMGkvfFwsSqXX6Q6MKa1CV71mr1Wce+3ih1nttt8+BMCbEjL9nWDdyVbmQM+GEzA+p8IGAO8eke/hauS2Hhl9cDQjuMvl1jJ3SkY4UUw4ixWLNKv9JWGwSQqObKip332Ya+xXlC4R0TT5q4m73o9eTnos889vmPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073954; c=relaxed/simple;
	bh=KVxhPOl9A1AJMg0s4eFGGbAqvxrGzpEQIUpU1sh34mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLMp6R2GBqHawDHLG2naiST+r0lRqG1HDUPxZYzvcmXi7ybgWitYkaPVFLnS9ZOiYYSquuP7sfGz3+AoNuqgecAdHUSgxF3L/pBwtF7L33dl3KNv7qf6dfWkffwVSQCYsiaDCP4o/RcXtAntV/tSXHZsvt9E6BVR+tEi23NMfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DMs45vva; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMs45vva"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b710601e659so215051666b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763073950; x=1763678750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UVVQud0Izrm82Y9YsVW4ejkPGLxxg20QvfQU/ToybY=;
        b=DMs45vvaTgJWcJNPUgyCNtrmns49fOjZ436GZK+cm6Fo+ZPrhCvzksKGWvv+qTzVey
         2vTgF6mdKe5ZiHWRjJKgC3vmCQ38jFLHWxQ1ZqL/gzvK4yyQtImP7iU3waRdLAOrY1gj
         tR13Ehs7oYh08bwj6ceDN2JnWS6DYNEcTlUIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763073950; x=1763678750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UVVQud0Izrm82Y9YsVW4ejkPGLxxg20QvfQU/ToybY=;
        b=roCTrytw+jlnOYAEQdQyW1Zit0MtmGiQTh9fO+BZPFEO9IMknEh/SsC4Tt2vNncBjt
         lKnl1kCOZX7jXMAWcHBwX4Nu+0PmpfeS1v5mEwQ8VM19dgx/q1VEith4aZlNoRgBktQz
         MDmSIZYqNba/Pa/OjVK1bjRxh8jfAHC3BRpXddpeNoZQmcixqEouPJbuEO6lo/IMFXcQ
         T5QpTXFhoB7bdlwyaGs0ERqyzX91uG/pGp7/1b/14tx5kefl4xTC9Q1uyQ/Kve3IMQn2
         ihVGrhdVKbl/k4PvPfn6MrFMD27cJFzHXPCor9RvSInLKitiw74E+HHlxal0bnwwh136
         VoCA==
X-Forwarded-Encrypted: i=1; AJvYcCXbB33UxcE8filwrLXGNv8F1B/QCvvPReZERGy4YyIxtohTf2ZL5fmMy2XDEk54aAyNOypvvYUBUZIefBRyKFFQ@vger.kernel.org
X-Gm-Message-State: AOJu0YznBwqzt6vx9WIl8prEzbdbRTPbynhGqLkDe9SbfQtfhRf9PGtO
	/hEmkBtD8+5KQziWUgxqWlSiqyyHEY3yqjxrZbhGWyCQw/V3W7Jcx6MMA4T56Wl7QVJZ96Ew5Q3
	m6OA/7fBc
X-Gm-Gg: ASbGncv92p5T6odQQn9mIvMCUDr2BYScc9s//r0X/qzxBw5x3L4mbKoRiqolJU+QF8m
	Fyj6AVOAExXpD5kIMsp8dKsFAuDg9AY23AKJ6TWEuFV7QDIa4CaY80d6/0C3OIIST/UepTVHhpD
	NJp+Rvf+Sa/Ly6RoP8Z8CFNJnfVu1EX7NV9eqT6vs7gFbvtKALpenwvaVsNiZcx45L+rDDvBWJX
	jB7b83soPBfth0CgCZu2GALkJEUHiXgOg5VP6KZbc7ByVOXiQ+2HwJywDBZlpFfO9YnYWivpaVc
	uIvn+iGCYen1lyxRsE/MeCYSqZ2Mwbkd5w/i0UeRoYngqy2Ldl9REdaCotVkNvbtnYc97P/6kh4
	GY9X4eM7qiSIsKs/QE5Jjpbh5N7KmSS5MWr/V/bkd0tZF3WfVPP3vFMB316K6j0eiEDHh0L4M4x
	VgB7p7aR5+8a1+lAWjHDLfHrc8J/ZyFviTUhHYnKbopb7flRLwvQch9pA+iMtc
X-Google-Smtp-Source: AGHT+IFHXJq863iRNNJkpPy4PLFQnJjjGlPxoYEeQu9NyqePD6IX1EGWYNrubCtG3+270K/YrrDpWA==
X-Received: by 2002:a17:906:d9b:b0:b73:68b3:bd2f with SMTP id a640c23a62f3a-b7368b3c0fdmr49215366b.40.1763073950565;
        Thu, 13 Nov 2025 14:45:50 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734ff36ac6sm252259766b.74.2025.11.13.14.45.49
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 14:45:49 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32900c8bso790376f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 14:45:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT8IkEyo5O2IXD+OsvpyGEcq1yr8lbxC90IZ7D3WBjVvnH8AH8nE+bTMuG0813jLIAneU6cUjZ/fKx53A/KYN/@vger.kernel.org
X-Received: by 2002:a05:6000:2010:b0:42b:3c3e:5d53 with SMTP id
 ffacd0b85a97d-42b5933aff4mr761555f8f.16.1763073948860; Thu, 13 Nov 2025
 14:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111073459.44030-1-cuiyunhui@bytedance.com>
In-Reply-To: <20251111073459.44030-1-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Nov 2025 14:45:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VGvp5XsT9R9-LR-dSbGAZ5YVcm=HxBYibCcSdVnNkyPA@mail.gmail.com>
X-Gm-Features: AWmQ_bkNWl8O-v3oF1GNsRABKkGX6YQ-aUhM_Mt29bXwj4MZQ9qr2FjFv9F9mEw
Message-ID: <CAD=FV=VGvp5XsT9R9-LR-dSbGAZ5YVcm=HxBYibCcSdVnNkyPA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
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

On Mon, Nov 10, 2025 at 11:35=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> After discussion [1],[2], hardlockup_perf cannot be completely replaced b=
y
> the hardlockup_buddy approach, so this patch is still being submitted.
>
> v1->v2:
> The contents of arch/arm64/watchdog_hld.c are directly consolidated into
> kernel/watchdog_perf.c.
>
>
> v2->v3:
> Add CONFIG_WATCHDOG_PERF_ADJUST_PERIOD to enclose the period update logic=
,
> select it by default on arm64 and riscv, without affecting other arches
> like x86 and PPC.
>
> v3->v4:
> Place the line "select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR=
_PERF && CPU_FREQ"
> in the Kconfig files for arm64 and riscv in one line, with no line breaks=
.
>
> v4->v5:
> Remove __weak from hw_nmi_get_sample_period()
>
> Link: https://lore.kernel.org/all/CAD=3DFV=3DUEhVCD6JehQi1wor2sSmtTLDyf=
=3D37xfo-DOTK1=3Du1xzA@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@=
gmail.com/ [2]
>
> Yunhui Cui (2):
>   watchdog: move arm64 watchdog_hld into common code
>   riscv: add HARDLOCKUP_DETECTOR_PERF support
>
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/kernel/Makefile       |  1 -
>  arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
>  arch/riscv/Kconfig               |  3 +
>  drivers/perf/arm_pmu.c           | 10 +++-
>  drivers/perf/riscv_pmu_sbi.c     | 10 ++++
>  include/linux/perf/arm_pmu.h     |  2 -
>  kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
>  lib/Kconfig.debug                |  8 +++
>  9 files changed, 114 insertions(+), 98 deletions(-)
>  delete mode 100644 arch/arm64/kernel/watchdog_hld.c

Perhaps you missed that (I think) Andrew had already dropped your v4
due to the Kernel Test Robot finding a problem. See:

https://lore.kernel.org/r/202510240701.eB6r97V3-lkp@intel.com

I don't think you've fixed these problems in v5, have you? I think you
need a v6 for it? I haven't dug all the way, but I'd suspect the
compile error is if "HARDLOCKUP_DETECTOR_PERF" is defined but not
"CPU_FREQ". Indeed, that matches the config in the report...


-Doug
