Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA84207A
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503627; cv=none; b=eA97U3NfgVFcFYc1wp6CBvp5Jx4T04n5KTYzuWmQ9R4lwRtQhUW8OgbcY5f8ljJ7hVgaPbHE8DBfxu4hBOBiZtUw7kZKSzTqH7tclRbb/o2i4L2iPJEqeuPmaQVIaq3NOiWWzY2w3HEd4NfUbZ7pIisdHjfft+us7RpClrX74Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503627; c=relaxed/simple;
	bh=von6eHvl6KgBL/4WwjFrHfO6TT4yQpG/ETSfXa6LoEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8cSVZ3GlGhcWAuHJOxY2lo4Dga4HAqgi1DZ7s3cNC5DnNWj03V83Anvb8MJdtQA7hunaCfeqLpJUebkoyhwc780R1W5kiRonDqlHAdaCc2RAMvyAwCeKYire9LjfFnKQrzqnKnNPT3mWfjOLMhzlxFWKJV1GHev/0xRmQ2kteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fwjDwVNs; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwjDwVNs"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70def63ec87so18843436d6.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756503624; x=1757108424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dis7nbiiCt2fP4GWwjgCXhTEHKxInIHXXX1XONaAGoM=;
        b=fwjDwVNsAM8VL5PI+FWWUZdIDJKczQp0SLCKnunMqaHoIkXJR+SoS+cv5KcZBrEGf9
         W4z7Cz90H+GO70rv6WXrFfuURRSQ2YInzF/zfcksdzmkDT/mlIdRKXd7BPE4pgNrotqj
         8xHIaZrj4b7ImNO3SbM3hINIpvZpepGBgLBcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756503624; x=1757108424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dis7nbiiCt2fP4GWwjgCXhTEHKxInIHXXX1XONaAGoM=;
        b=GiIphfb+RLNJQm5Lekgt5If2AYZtzDE9FIaFtE0d6mOF6RbIo2ZcU5MYkoSx7M09MT
         WcQ4bCaJ+4K7yn1nJqhquoBiNq/ORKKSqADWQ1flpGDoP8xBTMXPN7kPJ+YvFzKP1DRG
         lBaQkIGi+bvyUrxQ4fAGCpACNdMrANwYciDL0M1AIhtHAgIZMWLMNwpgtHiIpD2M3hGY
         MDB460yrwpYusrVXb7jL9+MkLTjHZpJgmHE+l+Iw8CuRlJl89VVLLLNyjAcXJi5Zx+e1
         RHtORRbRIvbRgeQCpjqdTAfLBKuUguPtYdrrQLxwElTAIxDeIEdsoYC55SPgt96mSsm4
         zbYg==
X-Forwarded-Encrypted: i=1; AJvYcCVDCD7B2amArb/AXaHiqO9Z0ekhhrm09FxJIochlAQHAVf4YE7N6/Ww6qH29pohzZaLjcF2lSxcofpDu4Qs3KEQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2F32EbuCoFZnwTn/GDPl7kj6f90gwuGKMdiHlJlAirlDkt4+
	sWAOlR0CP3DXN5p6r3bwxa7rlOyXVqfhmwl8xsSgVjVlY8QyPuzuVwsuOVxo6Awo3abutT6SXxv
	DaAk=
X-Gm-Gg: ASbGnculrppYLAP0Xu5Ss6IH0U+XUQDxq5+BqraSck5fYGtwiF/t6fznctu4oVpsbp6
	Pb3J8NWYL0ZaCzAdH3zYhLuPfxoOEfyRqWeBIWJLnek3wuPjYxUuU8Uq7vD+UnK6VxoYyUhQRWf
	SiQWy/cWi/CZUqkZFurf2UFzDz6thOxvRS8owAdUBb2egnf3QgiqWgqI9GCYsSTCjn0/+em/XuN
	ZNq91T9XrltZbXdb3yf98f45+jldFBVV4KPmOt5B4PHVqnWYGjA1RkopN66vRIBXM+BR+KxTmqj
	Meg0unx9t79Zlvxif3veMmUc/9+Yh5pbgNq6NItGw2Yk9zLsexJvHTZgAIOJW0zRqpgaAN/0lMO
	go5iLW4wsPzd6l/g6X1tnuN51kdvYBRWnQsMtJuGZOkrTThxzlFGCo3+FAtDDBCOWlHzx8Otztw
	oB
X-Google-Smtp-Source: AGHT+IEZeC1PptIPoCqZOCCdN7KcI8xc5S3Es+DFfi+L8mcukcrmf/8OsHDVrnc4JLU4s9Q2thySeg==
X-Received: by 2002:a05:6214:1d2e:b0:70d:6de2:50ce with SMTP id 6a1803df08f44-70fac946ecfmr950806d6.59.1756503624436;
        Fri, 29 Aug 2025 14:40:24 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6251d0f4sm23123846d6.51.2025.08.29.14.40.24
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 14:40:24 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f6f367a248so231352985a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 14:40:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKFW6MofMJLkd/HUWXqXU0wO7k1hLpYqRcd45zEuqwLkmeDjyJ4dr0xTGqOKmEhtaBx+WkHYon/uf+cqchfkB/@vger.kernel.org
X-Received: by 2002:a17:903:1a2b:b0:245:f7a8:bc68 with SMTP id
 d9443c01a7336-24944b1f682mr902835ad.57.1756503250127; Fri, 29 Aug 2025
 14:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com> <20250827100959.83023-2-cuiyunhui@bytedance.com>
In-Reply-To: <20250827100959.83023-2-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 29 Aug 2025 14:33:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
X-Gm-Features: Ac12FXwa45bnt2Fo7fophuQQG1oKhw1sdW41Dqgu52LADz5-5chJEPC22bATC7M
Message-ID: <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Yunhui Cui <cuiyunhui@bytedance.com>
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

On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> to arch_pmu_irq_is_nmi() for cross-arch reusability.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/kernel/Makefile                   | 1 -
>  drivers/perf/arm_pmu.c                       | 2 +-
>  include/linux/nmi.h                          | 1 +
>  include/linux/perf/arm_pmu.h                 | 2 --
>  kernel/Makefile                              | 2 +-
>  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
>  6 files changed, 9 insertions(+), 7 deletions(-)
>  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)

I'm not a huge fan of the perf hardlockup detector and IMO we should
maybe just delete it. Thus spreading it to support a new architecture
isn't my favorite thing to do. Can't you use the buddy hardlockup
detector?

That being said, I did a quick look at your patch. I'm pretty sure you
can't just move the arm64 "watchdog_hld.c" to be generic. Won't
hw_nmi_get_sample_period() conflict with everyone else's (x86 and
powerpc)?

-Doug
