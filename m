Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9330AABE
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727356; cv=none; b=WUvw+zPWGwmQEr06iJBiUCoePrkmaw9LWCXDjtmhg+j4HiToCjCz6REbDuYxw8vyocJMmdXXcnSVEktI2xCwqxEvPf4dbXTwFjRx/YgylgRvT6ZDxPK/bjC2P/ua7w9BTp1Ir5jAWUs6u8+S22M3f5Jix1/XUWQfBJqnTrUHPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727356; c=relaxed/simple;
	bh=JsPnfKtr3MiLoJ8hsPpReBdY4CePyEpwU2RLe/kafMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhUj2dte10LRmUKzd6wls4UmnOsjtt6WbkvYdCAdldtGt3z5p3fZFTvMTmWGAMQ3dfn9uErKRhu7dgcaPy/WLRbazNhLDD6Hu6+zaduXgG30wVeGt6kiipWHcjKdVaUMwnznkzKp4ugcdJkuaZxgeQhLlfxQn4BFGX584cIR17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PUFNavYn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PUFNavYn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so7100947b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758727355; x=1759332155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGkkH3On4e9g/uKbOlSYkJKHveGl2HpttCc7mFGVIhA=;
        b=PUFNavYnN8MQnTSb1pmGvwUR2NDqHh+nIF/Pt6Ql+75GzYq8iT4hs5YWnxuaDQjJQb
         BM+Y6BwRnnQGZIrvEHJoQt2qJ55tThqLHPjp6+6Pyzjep4bg1t8senLZwRU9jgl3idCs
         U8m7LuEkascIY7yHgtJbpOO1UW4HVSqugByGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727355; x=1759332155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGkkH3On4e9g/uKbOlSYkJKHveGl2HpttCc7mFGVIhA=;
        b=ttXuCrN04YI01uvcEjlAqNkzFTXypaK/Ht6IFz35BEm/c4+69ObsqHcH63FLvuaIQw
         pmglzjNxQoyqyy4w3NPFLO1ot56cxu1z+65B1eiOjiWlUoJqq69nPnojIg2oqtQKAgDN
         Bu0itVQ33UuO7z1UsqEC57qveuhcciCplaw64seE7p9mdiTq5sCslGtELDPmA4thY8Pc
         BIWhoG6MALmFyQ8R5VX5tiuePd/3DcFfRijch2XMvURN09e8LIwK8uUlEe5/RyOPj0O2
         1eWorgDHw7a9Jg/37gNFrd48tx8wG47hSu78iMEAUFt/JnbOnBFHfLdXAo1702qkjFyB
         +qqA==
X-Forwarded-Encrypted: i=1; AJvYcCXbJ5NJ/aa1Th8jxEcWCoQvB9g3v7OlyjMwz8WJ26NNnF1ux5yHGvFVjAkFJwU5zYxIR1r02rhbx9gm+Dbv+Frp@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvJ1q2kyGiQhV6SKM0oq1yVB8bnQZD0FfhzikrJDmw3fo0it1
	496q31n2g9rtwzzTZaAV8bpqZzOsZEWESd9Cz3gQKTcmDgUYTRyQPn+wj0dI5pWPEDOwefbTUJt
	6cs4=
X-Gm-Gg: ASbGnctpVozTC6emaiBy3wD8e9QZ6qxkAmsuC8ilDuBHXmVYVrVx4Q3AcnA5e6ZZC7p
	RiuotcLPnXuZK/zzSRuhVRI6c4DRkprqEfN1FSwWseJs4WWNQja3SXSwCo4SUqHF9TCvb4FHwCI
	0C78iYIf3wtZMh61IzIkCj4ydK3zLXl4MzBKE2VYep0xbnE/gCO0kcqW7fbb/ZfHlBwOiikpSdF
	8mlYpEIEq9ERirxk/a4qjlQIbCUXVhsvKHvWcm6r3dT6uHTQ6eDWViC9SqAUwsJ1lxvzhTx1rAD
	UY5BBeO0rTc8t844RG/H8tx3z0FeTvRFM8Hox1GUZrVy9C24vI2FG0n+Xwa3b310NlA5vUSH3+S
	1hxKs/b3MTXlcmlGuQyPaBnwvO2ZJT87ysKV9UHdfTXrQEr2cr7n4JFwpJArlcoWARA==
X-Google-Smtp-Source: AGHT+IHBztUVsdKIZG7ZZAIph7myIMoCIceVljn3Wsve7lbeBMRitq9MVjqcXPVIrd9FOpVxZ3VRQg==
X-Received: by 2002:a05:6a00:124e:b0:77f:14f5:7483 with SMTP id d2e1a72fcca58-780fced6c5cmr402486b3a.25.1758727354699;
        Wed, 24 Sep 2025 08:22:34 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-780fd8e95f9sm101221b3a.34.2025.09.24.08.22.34
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:22:34 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-279e2554b6fso28288335ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 08:22:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnk+QE7XXrg2TQCJmpIjL2Zf50SCufiF064kA92Kq41wg2FXyjOG9dU+AWPrFjLm6A80Gf70ytPsPFeuZyt6xg@vger.kernel.org
X-Received: by 2002:a17:902:c94d:b0:278:daab:7940 with SMTP id
 d9443c01a7336-27ed4a3dfa8mr1337745ad.17.1758727353184; Wed, 24 Sep 2025
 08:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wnHzL6KVaW=RAkoMNSoM+HW11n=5miFwkw7=LQw+375Gw@mail.gmail.com>
In-Reply-To: <CAEEQ3wnHzL6KVaW=RAkoMNSoM+HW11n=5miFwkw7=LQw+375Gw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Sep 2025 08:22:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYGmayve1ujv9oqRrJaq-D6g7pRygvQf31WfEMsT3g8Q@mail.gmail.com>
X-Gm-Features: AS18NWDf2q3VkrTezxWiqMq5MaW03lcJwh8tH3BwlSFCZCG9Jd79C5JfcXHF2sY
Message-ID: <CAD=FV=XYGmayve1ujv9oqRrJaq-D6g7pRygvQf31WfEMsT3g8Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, 
	mark.rutland@arm.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com, 
	masahiroy@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, mingo@kernel.org, 
	lihuafei1@huawei.com, akpm@linux-foundation.org, jpoimboe@kernel.org, 
	rppt@kernel.org, kees@kernel.org, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 23, 2025 at 7:41=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/arm64/kernel/Makefile                   | 1 -
> > >  drivers/perf/arm_pmu.c                       | 2 +-
> > >  include/linux/nmi.h                          | 1 +
> > >  include/linux/perf/arm_pmu.h                 | 2 --
> > >  kernel/Makefile                              | 2 +-
> > >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> > >  6 files changed, 9 insertions(+), 7 deletions(-)
> > >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
> >
> > I'm not a huge fan of the perf hardlockup detector and IMO we should
> > maybe just delete it. Thus spreading it to support a new architecture
> > isn't my favorite thing to do. Can't you use the buddy hardlockup
> > detector?
> >
> > That being said, I did a quick look at your patch. I'm pretty sure you
> > can't just move the arm64 "watchdog_hld.c" to be generic. Won't
> > hw_nmi_get_sample_period() conflict with everyone else's (x86 and
> > powerpc)?
>
> After discussing whether to remove watchdog perf, it still seems
> necessary to keep advancing with it. For the code, we just need to
> decorate hw_nmi_get_sample_period() with __weak, right?

That would probably work, but IMO you should make sure you can figure
out how to at least compile the x86/powerpc kernels to confirm.

-Doug
