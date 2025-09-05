Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CC54654
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Sep 2025 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116674; cv=none; b=njctltnhazIzkoiR9/TpfgulE1XtLJO+SCBcNH6tC7NsN5IfFlfAThHsl9NqIX1vsNT4Kj4pp+SMj7KWpofG993w5RDDq54h0hoE3OIbGMbYnQqCSYeOaV02QalAy3roVLYKPnsXJJ+rByFCms8SLyakePw1H7Zok5faHvlKAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116674; c=relaxed/simple;
	bh=X6FjyOREsMiWyTGUz8ui40PctBG9QEdoLDLoZRzJHIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0/Sp+EYbHquzt7gP6LHBVg/EtF/0OFqS+c2vxV01//au/QEBwnVVH0K9mPJcd97nDs/wFDAsF0yWebvcCbLXV7wiaDld6eU1gz+xasi0csKvyO0A+4FB7F/8Dfli/NCcQxQJoZAZCukKr8eey/hkm8BoEiMqKFD8UdUFFEMXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PvbxhA/U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvbxhA/U"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7725147ec88so1195157b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Sep 2025 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757116671; x=1757721471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pLX9mNLE1Old2BsaUGh3Hjem0q5L//LE3ZX0hufywI=;
        b=PvbxhA/UdV9j8AJ7Lkg9QxwUmHA4ZlqX6fjc1KHsXXrpdBnZtlB2bOGfqPLhs849u+
         lqfI9jCmjT42Teu4jUsdQ0q1CElxp/9R+Ur2u+dCKgRrBY6UOx2ZwkxsT+ShS0VcWQ2K
         P5lu+gHmhSAA6djv1NJfbxXZdSKPufJsZW4XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757116671; x=1757721471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pLX9mNLE1Old2BsaUGh3Hjem0q5L//LE3ZX0hufywI=;
        b=Kfvpovyjs8B12Oi5kh+KXAlE3fnH0AEQ6Sx5ruAHHGlHIPQvgkg6sHUHZUQK0Kk7YF
         e9F+k4XIJQqtl2fAdYuNBYOfKhfoJHrM1NyIrWx0iw+w8vK2R4oUxfMA0LT2SwPVlY4S
         h5HOATv4KYEJFgRAaXFHZCD34dZu1Q37TBNW5Qe3J89AiqEjT/GoCD2GC58oNrweeQQm
         Uf/odSFErMqcrPGGgyjeLVelsc2dw/i2+qHGFVgAjF0ZGXKy9THYldGtgewPk1q8+55I
         KdwrzRvI+4bCD9QHa9ygg7ToD/xBFjEMVORo72Dysb5AMzjzSrVvB+BV+U4C/Ib31Qxk
         fc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwE1ZbrsOFhwSCkfuqTNkpKz0YSJEV1URrRW5uiVJTUJ1FjDSfvM2OkMykt09zNQAx3RWUNbaN0TlXleGrQs6E@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkPK5dy7jPIVkrL2Wnc9Mlbpv1oe7U5aXr+5hNEZWaAPdnjtm
	S6SqbnNuUhO+9uHKrzRzN50ro/X1N6TVQZfCZ2xVTkRVx/b1eDUT0pora25lZFf1rHtKae94nA0
	9PfY=
X-Gm-Gg: ASbGncvsSjxYy7thqqVl3CdXhwlKdq8QG/yYOKGsVWM41YNGE+m5bEBcvUsdEvSsyIB
	qAPgT10S0FTQw6F7o0CnqGB+DhKvlBFPPIxy0FyKGW+VIRR2FiZBBpDzg5anumglIh5GTMXz54B
	EjPRkrYPpJTafnwlkkozMWVsqMkAiF+K8tdBCMnBTHsITxaNTT9qszVuQDn3drnpEUmlErI9kCd
	TAGryPsuEGrExNmgSjucrSR9qLGTHA4FewO4bJZTyGkGAKOmbB1cmccqQ7S9OiCSc/c4V/B5/EH
	LhTIVYvioWfxCuZtpK6neijII1xl6fmZkqMkAQlwjsjCsUwKyjN3BzmvwJA8W+7KdQixU9w6SK2
	/MrcgBj1pGx4xczeuhvhYiHNuLYgEGZjg3jqVLHGZA4BLNErRGiR3+bQ9UI1PNRRkV9doWOFec1
	Y1
X-Google-Smtp-Source: AGHT+IHwUcJA+bnomrUbZUNNMJPKcxbW7tZaNFk4us8fc9n4wSkbFwL98oC6wduCp6fE3KX005st0Q==
X-Received: by 2002:a05:6a20:7f83:b0:243:d3d3:61d4 with SMTP id adf61e73a8af0-2537be02c97mr500519637.16.1757116671317;
        Fri, 05 Sep 2025 16:57:51 -0700 (PDT)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com. [209.85.215.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772447058dbsm19120766b3a.38.2025.09.05.16.57.50
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 16:57:50 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so2673648a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Sep 2025 16:57:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/IlaLEiQs8H76HtfKdkJxeQUfUNIKIb1TUCrQ9PpyeXGVBft5WcT9IoDsCTxPTKyvGSb4WpJdilV42DwnIFd/@vger.kernel.org
X-Received: by 2002:a17:90b:4fd0:b0:325:15bf:4dc2 with SMTP id
 98e67ed59e1d1-32d44f86e71mr623965a91.0.1757116669514; Fri, 05 Sep 2025
 16:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
 <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com> <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
In-Reply-To: <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Sep 2025 16:57:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
X-Gm-Features: Ac12FXzUu2N-pcZbzJSHRvrPWYA7cVEhjyHs0eCe7xSTQbillcbYzLxLmPy77G0
Message-ID: <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 4:56=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Hi Doug=EF=BC=8C
>
> On Wed, Sep 3, 2025 at 1:04=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Sun, Aug 31, 2025 at 10:57=E2=80=AFPM yunhui cui <cuiyunhui@bytedanc=
e.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > > > > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  arch/arm64/kernel/Makefile                   | 1 -
> > > > >  drivers/perf/arm_pmu.c                       | 2 +-
> > > > >  include/linux/nmi.h                          | 1 +
> > > > >  include/linux/perf/arm_pmu.h                 | 2 --
> > > > >  kernel/Makefile                              | 2 +-
> > > > >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> > > > >  6 files changed, 9 insertions(+), 7 deletions(-)
> > > > >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
> > > >
> > > > I'm not a huge fan of the perf hardlockup detector and IMO we shoul=
d
> > > > maybe just delete it. Thus spreading it to support a new architectu=
re
> > > > isn't my favorite thing to do. Can't you use the buddy hardlockup
> > > > detector?
> > >
> > > Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
> > > you explain the specific reasons? Is the community's future plan to
> > > favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?
> >
> > I don't think there are any concrete plans, but there was some discussi=
on here:
> >
> > https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJMoL6XCft=
Eo6W7q6jRCkg@mail.gmail.com/
> >
> > -Doug
> >
>
> I=E2=80=99ve read your linked content, which details the pros and cons of=
 perf
> watchdog and buddy watchdog.
> I think everyone will agree on choosing one as the default.
> It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=80=94=
what=E2=80=99s next
> for these two approaches?

I guess to start, someone (you?) should send some patches to the list.
Maybe one patch to make buddy the default and one to change the
description of the "perf" lockup detector say that its usage is
discouraged, that it might be removed, that people should use the
"buddy" detector instead, and that if there's a reason someone needs
the "perf" detector instead of the buddy one then they should make
some loud noises.

You'd want to CC folks who were involved in recent watchdog changes
and make sure to CC Andrew (akpm). If folks react positive and Andrew
agrees then he'll likely land the the patches and we'll have made
forward progress. :-)

-Doug
