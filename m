Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7621E097
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681686; cv=none; b=osEcw7QZhbcqIiHbVYtUzQZxxTrrUmRwDyBxep0Jr6FbUb2ZpUUzD0gK7YeLrk4nLhyDOqkuLY2S7bwH94FFdW2smh7aWZUsl1SZwZS+VsEggNHDYU1PGlGUWywKhdGcve2cWu9pa/Els+rCw28IlVRYb4vVmNIyH5u+bJGFXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681686; c=relaxed/simple;
	bh=33wXjsIvKpnr07ANf4dsbUFwqzQfE0tjd9GeFkQo5dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsKNmIQ3vRCHLMDfDSeCN8umsqHzKacJPFryljO23w50Td8rU/shqjXb63prGWadsuHB6g1hxs4jBV29z5OtEF368yVrEytHaCRZCS0FbV/h6bb2qyhQMIshDqzN8Q6qEGvkfd4A2pRuNENFkwP4pA9otgMNU2xiQzl5fcLxhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j2V5aZ8y; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j2V5aZ8y"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-62190d14a96so2417821eaf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758681683; x=1759286483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ7ZD4HOO6vcvN2jhvcYNuUy+e/nu1npqP5xs4E4kvw=;
        b=j2V5aZ8yMBhCfMo5ISfykD7gGN6yx8WMCaSuYJPBFLEWlio1CTj58WGzq9sAUph3QI
         D3FTsfvMz9XkJcAEeS4z6zesVq2Bkc1BFvYB8sLR0qqNvq9E/qyeazaQ5dvKgWsS5gM4
         9ARqO/5X4AdegKsHVjv9f7UlrLKGn4HtQFr30usWaJP8u0dXvZQMnOjXHb2+/opaOpKR
         HNYTNw9TYEOJl5KA0zxJjj1IFxb8vubrKWRvZ0DKKWONX/34NY2kYXmSnORFsOwuVdAN
         Z8a9MPvpNqKo9qxMHblozps2mjWViFcCbda5AqQaJp4hSFWwH/6pXGyg2CUlPArl/g/8
         /SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758681683; x=1759286483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ7ZD4HOO6vcvN2jhvcYNuUy+e/nu1npqP5xs4E4kvw=;
        b=KHCjW0Z7BaLAVaJPj0iy2duIUriarCFs3KhBeMhCyB5/KIbE4e+eCiJw8Q/HoEwBMX
         xcxhf5/EiJXVyJ+R48SgLaiR2MhkfT/5a2n9cGWkAWJTcnldn5f2iqfafyN12Ct36ZDE
         FLCI45tOWfRXzqK3rDRQ44lTnHIIQyOzPHClwGBa9cuXZbTSX8rCFwDYHbJGewFSYqy7
         KtZbh0vDwDBvXQwHsd4ATpZdxhoGtvVZXLzSNizqy9wCmXSIkO5OpEr68ZMlexPuWECz
         lLdC2oqQBNWwfY6MdoZbmlj1alHanOvxApHLc0mo/xXP+R1dUTum9gEZKpMvAuLK6g/s
         PEXA==
X-Forwarded-Encrypted: i=1; AJvYcCWdIClgapKi4ROSlZWvR3AEzprTP8svHYLPYUooFSZvELVBYzVnGWeSU6FT1MQqhgDH6zpQPx2X/SJIijtvZqUU@vger.kernel.org
X-Gm-Message-State: AOJu0YwTU7GK2/qlVyP3gF7ztFwiGiThU12qSUYX6UUdfff4Pkh0oEU6
	qzMVx0V4t3xTtZg2FEgnEHZQ+Jd6Sxr1sOJKrKRRSQNhQRNXmSq9pU9mT3EOcvE8aX3WJaabYX0
	Vcz7W9AisflZjp7QsPRw/xGIT8cm5FRdggS3bL5SRuw==
X-Gm-Gg: ASbGncttV+GHrhp4a2HJreku6Xws1ZbPJ1KK99lBE+czNG89MlBYNvGD/Y+UEHsYPc/
	n3Q3QEJVv7UmNT0dUWRVqHs3oHx794btha6KZcsdOZVquS5SrerBmw2lLDwVvgccYUm4dJajHDY
	K6W/KZMazaxr6qqMOfvt4iplvA9D1/7eA/Wt68KKmIvrhtaldSVcPZ/Ag8Dpp9MVPj2fvhYFxAS
	Vt7Na5NJR3slG8anloA7a2TRx7Ed6c=
X-Google-Smtp-Source: AGHT+IGEpNk9DDtckp5YNfBhGfRHVJ45anN0NmcR9uT9RDyjMg5L8WQA0A/0mav6VX8Fgt6VaztuETs4XxHkt904xHk=
X-Received: by 2002:a05:6808:4fcf:b0:439:b9b3:af48 with SMTP id
 5614622812f47-43f2d4fa2f9mr2800409b6e.51.1758681683348; Tue, 23 Sep 2025
 19:41:23 -0700 (PDT)
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
Date: Wed, 24 Sep 2025 10:41:12 +0800
X-Gm-Features: AS18NWB66CdU_tLMngkAZDvsu7vdd4uKDW0eFr5qi5AGo0Yw70dG5SNPb2ixTPc
Message-ID: <CAEEQ3wnHzL6KVaW=RAkoMNSoM+HW11n=5miFwkw7=LQw+375Gw@mail.gmail.com>
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
>
> That being said, I did a quick look at your patch. I'm pretty sure you
> can't just move the arm64 "watchdog_hld.c" to be generic. Won't
> hw_nmi_get_sample_period() conflict with everyone else's (x86 and
> powerpc)?

After discussing whether to remove watchdog perf, it still seems
necessary to keep advancing with it. For the code, we just need to
decorate hw_nmi_get_sample_period() with __weak, right?


>
> -Doug
>

Thanks,
Yunhui
