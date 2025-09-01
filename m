Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F3239E63
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706254; cv=none; b=TVZC5/wyLIIGKxD3x+REBu8mMSnrvRV2OMyXMsUpztBLWoIYYwN3j7RggWDM+ZT7JEHeGE/PaCGDUTJIS9+DKwTsC1xAvgrf+wr++i7kWSJWzZU1LioGjdNMt80KS/Zt5+mvEr9HZgehQ93LhrmIOMUuyYzSz1VaHYiI5QXrHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706254; c=relaxed/simple;
	bh=FyAsHeoe/zeL0dZKiAKYHqGwqBTz8WBo6jni7UhNvo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4z22OFW1EQGdAfpBfXn0+S0H9IoQxo8LGrZEtT6FVv9UHp1gM0SO0fXkgZBJ3lIL2tagUgf4/e7lq/xzSaiIvJ3rH8JwafCn0wXhQo9TPGKnp9ZTwrFZi6lvVVe2GOhqLg8D5Cda+hWeUkKqND//sjqu1BBW9xv8clW3uGLeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YyYfO+UE; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YyYfO+UE"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61e27fee909so780321eaf.3
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Aug 2025 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756706251; x=1757311051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeQYWbY1S4fZ+YczB8KbzZBm49i+mRKtPu5B3WoNWrY=;
        b=YyYfO+UELD5VAVOmS2U2dcNZPe/V8rFIdi7bo0gMa6NhRJTi9LqzlnVVkvJpX/lHIv
         Bk3kyz44pkHSvnB1N48TpgAmcM9MnxclEN0kpzuyznV2SfI6xSlA6bU2gOEk+c1xL1+9
         W36uHBTYhkZr/C+tHigzXbiOB/AQPk7phZDRbw9a3Z5fQUar/8yGWfyhkfc1Hcei3nuH
         Ll81OUN7TgFtHPY9qhbbKUAFO5h0Wl5vFM/FQY7i0rmlWD325yuE4zjNuGKjfeCBQRT0
         TIPV/jNDSVjN3bpY92nEDhStDDkrw6QS9Jx3il4VEB4cUvqn7qLgd9YiI6KaTTtZRUSW
         Mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706251; x=1757311051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeQYWbY1S4fZ+YczB8KbzZBm49i+mRKtPu5B3WoNWrY=;
        b=DHtqOynw0T0493iA9yyrpW7Fbep0Antspi0Z71OT8rU7wGcRUR4up655kIsaQdYn6e
         SSDoZ3kvCq4+FmSpd5zlVMl+bGyp1YWJTfcjBX6JwKJeSn4TNyrU9IZwGu6yMGUhocp6
         e/uaVpoAsBjsYyEwSQ2JRsm7AcUT8O9eaiJ1qO+zalkwa0cvTOiCyGaUolWJqX0Ts5Se
         yrKN1AEpV+IxdH1KWgnhj6eTdxhGDG0OpQowokXM347R85+hyNNwgtokBNFTTubh6FFA
         TZv9B+E+vQaQyP/QrshT7N2JxQBgAnOf1kw8Q2aWaj+GLVe3wA/CI8wzTFG7TulNoj88
         2qJg==
X-Forwarded-Encrypted: i=1; AJvYcCVIHFUy1TgZS9YmNe+cAXP0SKtMAnaJuG7MlnvQfZT99pHX6Jfg4nySwsx292mL/+qHLEMr2b0/kUH0SPRKahzD@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxnLfys+N41isKwEKvkT+tfVL5X0VmeV/G4BBxvYVQYmI+t8P
	ExgktDZkmM+622SHef3PqqT32fkAThvhqqU3W9rit3qlXspWgeX5BBbXlMFKM4ww/OE+IyaxSF0
	KeS/bPZVg/zP8Ua9M/Xox+02xF4Fch99N/dOZ7g6yFA==
X-Gm-Gg: ASbGncs0tyeynn+tpCGeM0xYU1w4iWCDmYAh77xrAVXhJK6K5/RAfE3yjqyLwz/Gk93
	HhPQ+znnQpxjQ7KONIccakpFTPqQhT2PcjkqbLmVXhTwMCllw++mkO3oznPWiCaBWg+TvxKmrkO
	jU1RMs7x1q7zyJyiGGc2pQ7A1tIwbj0Aws9uaOF47utxuA968iNRcCSrxuXix3Fxps4XtC6lnFM
	JP8A+XTB7RzKOwJ2Udfb2HFX1Nc/A==
X-Google-Smtp-Source: AGHT+IEtvyL0v+dIqPd4cVuA9FY2MWzZGsXTxWqPBDg5RCf2ntrVdCNu37vpIo27yokw6idnCUTUmPkUJc2WW9ZSX9I=
X-Received: by 2002:a05:6808:14c2:b0:437:75a1:34ff with SMTP id
 5614622812f47-437f7dc9eadmr3255975b6e.43.1756706251452; Sun, 31 Aug 2025
 22:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
In-Reply-To: <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 1 Sep 2025 13:57:20 +0800
X-Gm-Features: Ac12FXztNIRPMxCTXiinwhNyATXzi2utzF9owhxKyx-0keFQXx7jGWYBvVSkODg
Message-ID: <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Doug Anderson <dianders@chromium.org>
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

Hi Doug,

On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/arm64/kernel/Makefile                   | 1 -
> >  drivers/perf/arm_pmu.c                       | 2 +-
> >  include/linux/nmi.h                          | 1 +
> >  include/linux/perf/arm_pmu.h                 | 2 --
> >  kernel/Makefile                              | 2 +-
> >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> >  6 files changed, 9 insertions(+), 7 deletions(-)
> >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
>
> I'm not a huge fan of the perf hardlockup detector and IMO we should
> maybe just delete it. Thus spreading it to support a new architecture
> isn't my favorite thing to do. Can't you use the buddy hardlockup
> detector?

Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
you explain the specific reasons? Is the community's future plan to
favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?

>
> That being said, I did a quick look at your patch. I'm pretty sure you
> can't just move the arm64 "watchdog_hld.c" to be generic. Won't
> hw_nmi_get_sample_period() conflict with everyone else's (x86 and
> powerpc)?
>
> -Doug
>

Thanks,
Yunhui
