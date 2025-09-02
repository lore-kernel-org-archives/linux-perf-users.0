Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077B34167F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Sep 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833030; cv=none; b=MMzdePIENQUyV3oxTT9SrSpPn/QgeX2CmbxCG+kSiUjEhQMHkUM07mgKxvHCXXoIl/bLS/apuJd1aWM5nO1+nmL7dyUFhBag/742fEdUXN5R6xAMbx0YLJNJIO3IrfRVmCCQ3wiwUSDXlY6rSjpXJmrv8C+dKef77L3P8r1obzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833030; c=relaxed/simple;
	bh=oHgHxxly8fLr95F3sY/hL1w7Ojsj5GzmNbdH2vURWZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txXrScDpGvi/2tHc/1uu73wsJRaXMmC/nrj9hCDbBcJhMjzoed21NcTKq2BjbkmLaAVbOjAXj7KXv+3/sWETnCtdp/FmAbnMkc1XfdZHsVbMMS+Q/EUkxOeSwVYd58pC55mSqkGAcg9QylzaTYQUj+v8ViXCgiO69o6PqIv55qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ln3CxNYk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ln3CxNYk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b33032b899so17556011cf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Sep 2025 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756833026; x=1757437826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7Rb+Gc4bzsX0WrGoFt7okZVsdi4ux/eNHzNp2DsalU=;
        b=Ln3CxNYk6JGasQf2T+S+FYJDeWkUIrMbbSxKLUeZ5ZNZBNlPoLN2KBL5bKfUegLMU2
         JUr/tHo3suGOlWVNVU+xe89cjobXM5vJkAoV7bd9Ex5cEu/H4JInVd+ar3tsl/vXpL2A
         Dg5CUb5quDlS8m8tgoIhkrp6AZQFtlHJ92apA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833026; x=1757437826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Rb+Gc4bzsX0WrGoFt7okZVsdi4ux/eNHzNp2DsalU=;
        b=iSiATtpEIaaTu4nVtrbtnbY2gtq0Hqyuf6nWTdOEk50C2NzQID1EozU8Dp3WIF/dI0
         eIeNHPkLYhe/P+5JlsApv9Y8HtLuctP8qoZR3+8DwaV4t+5QI/DGJ2H6EbuO0a+Icphm
         i2fiqE1M3DT42xg8KH1fHeYZCB58dsuiEWNqog3o2pcOoJaTmzIQWM279T2Kv4CDh40V
         Zg1fMTP1uXMP4NKNwhZXsy4kDvhLWVLjnLMq2Z3rVMVdcW4qckS1uL+bmeJibepdMl/a
         MoZaTk6acXfLm7nSCvcF01C/qQIAd2roPwcoENNxRjMNpgAIxACFplGHe4XHs7kdzbJ9
         20GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg8rD0zuzN9r17UjVfBufo7AuXfbmYkti8tb4pUmjMPnqxb5d2HpgfpEcoZSl4x2oERVSnjf5m3kGZBj/O6EsL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FqH3eKAOUXnqJW5FEWBEfVVAq9lVPl+aMjWWtuKrpG5WSqx+
	NA3euisqSL77i3XRcU+XhnzZawndals60QojSvOSyJhC0MTCxZuq5TB1ddydEFjrjnsLG/8wVD8
	rTEc=
X-Gm-Gg: ASbGncsPOfinGp+4gPE9c7yahgClcLLsoORQCqlSrbaS1iay1JyxxDBo+e0JE2O+tdw
	qJj0GjdtN8ymFyTP6xXR5g36j4Mjg41Zi4hygNhscQRhsLgFu2EtA2gkrziS6ZuGPQsjda/Alj/
	9kmkG6eya9rPmsBmCNCSXVDZBu13j6OGZo9EqxdIDdhtH5czX+/ygMBnmUflCJw4bMClCSfZqOO
	hSx0arU8wRhwgb3Sw+rZreVROAWjCxZ7TggaZQYG+coUDIebArVz4W9MKgnQVjW1/7ER4ac0eFz
	3UjFNHLw5pT9+dZVBNXLJ4lMxZwuNFxZ/emovF6SxLieZWfeX1h55xu3lQpovzM7vaQ1VkJSZ3/
	cqQQnHaBg8D33TFQo31f1Iv/iIab3L1V1dstofezabR9SHJUI7muVfWiUtnYzQnYjEQ==
X-Google-Smtp-Source: AGHT+IHcswFc65VoKpVjhGhUo0+TK4oULKD2rIKZI2g5FgShHcb4uYCsn4adHEkjhQImUhB3INwTQA==
X-Received: by 2002:a05:622a:8c9:b0:4b3:10f0:15b8 with SMTP id d75a77b69052e-4b31dcd6634mr157314681cf.77.1756833026440;
        Tue, 02 Sep 2025 10:10:26 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3461c17d4sm15336031cf.15.2025.09.02.10.10.26
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:10:26 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b34066b52eso13451941cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Sep 2025 10:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/2VdbQ0m0hjHlZkJVNg0ED9q4dr72ee0hnNHGCsKU9kGWxIyTpEmZ0/PEB1kF0qwvwb7GBi3JJEMFeayHRHwA@vger.kernel.org
X-Received: by 2002:a17:903:384b:b0:240:84b:a11a with SMTP id
 d9443c01a7336-249448f24abmr161721465ad.17.1756832646700; Tue, 02 Sep 2025
 10:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 2 Sep 2025 10:03:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
X-Gm-Features: Ac12FXykSrYm05H2zP7oRG7JrK-8ugSYBV29nSAU-8Tvd7BMAeSBbf3oz6aTBn8
Message-ID: <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
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

On Sun, Aug 31, 2025 at 10:57=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
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
>
> Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
> you explain the specific reasons? Is the community's future plan to
> favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?

I don't think there are any concrete plans, but there was some discussion h=
ere:

https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W=
7q6jRCkg@mail.gmail.com/

-Doug
