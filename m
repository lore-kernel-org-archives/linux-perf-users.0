Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD730101F
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824455; cv=none; b=uYc/znBoiWbcDvXETVfoyEvjOkgKNYcoB0rqANeccmNbnen+S3WwZMXWE4KiGy5KhYWvKQEEHq/5iPjCJl0q02Ts0yy9+XpCjMoj40ct7mZ9Q3Fzc7T8OwlFUzm5hz7IQM4FJRKSOkwrRf8cK6cGiuXMe0D7Lqo1aEZYPmX4IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824455; c=relaxed/simple;
	bh=ynb1Pz7S4Rh+mM2HiZZ5on0pKnh8R/gdfodATPNKL0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCHPEPdK6O81otghRIJRH2VzYjfP62yYZreIjXL4z/yc/xDUl860otPOqi5ycbXBGvOsWNWZpw1uWdDPgJ/M0871Oajrs7j53pRDuwhoZyE1lDtC9IVEkKisZjigg3EaTV4hnJ2CpTHO4H1GsecdAdVVLYq82wRUcZbVhiSPU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fv/1VNR0; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fv/1VNR0"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ec314aaae5so422667fac.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 21:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1764824452; x=1765429252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynb1Pz7S4Rh+mM2HiZZ5on0pKnh8R/gdfodATPNKL0A=;
        b=fv/1VNR00ss2Kib/lXrHs/ZOrpt5WZ/jVJu8W+KKoH2jkO1zWEgF6TWGHQ37DxsU1u
         roZEqgwWvm2njQeoSCeYVJALWO8bFJzBP+rPadAgL9Lw/2KSDOyVGlFy5pYqJPHqoUfB
         1qpYvtN2lqEJgsFiJeyJGFiK6if4ENm02vxIjYXS/EuhJzrReamsghI7sDNbpHi2Fs9z
         teaVDGno8QKtjSSuzOlPkCFRMkFElC5y+WMrAnB5KMQuo5MaqvLOCSKZggKIQKpbpylw
         QebC8MP0Q9kp6eY00G5x32YaSG9TyqUGSwj+drokZhAxvep23tqK5taA/f3apvDfuaKa
         F7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764824452; x=1765429252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynb1Pz7S4Rh+mM2HiZZ5on0pKnh8R/gdfodATPNKL0A=;
        b=E7dm+/5jByHHKfx2CSrWZEOPBUYmSHIg7mQ9SLxcWgHi7FRJiO1ls7oPFKITUFYj3t
         BOLsPNBthiLJnI4vAvsW1hV1KzeonspS8lvUqmqVaKp9E9+4oiW3uA1wUa08t9Cl1xel
         DnkdbrP9KYXvBaBVNvO1Pg/dhqY1cjl65xVN0N9g1Oq0str2zrR1jZTS9GZhWh4/q6B6
         itvlO30zPOB/qo44JhqwRSR8HhEUXJ+2zOQHswbvBet3lhhLwXXmUu/wWjzgBOQD7Z3+
         ZPl2wlfH8WGNEkGtqUXHTNJOaB03plwgYaxGlMvG7u1IDzXajlyF4kb1NJYY6MOdQoLv
         KYlA==
X-Forwarded-Encrypted: i=1; AJvYcCVl2SDlZ8t/x5tmVBKCaJrcZupreCtbwigedUF1QEsc2dbXL773GiAkI9qZ8poZiKshw8xf6jp38nnStpyPPW0f@vger.kernel.org
X-Gm-Message-State: AOJu0YxRvWGAfN4x8/sboT8w5GxmtjbMCn8M40orNk26AJETEaZrUBZ7
	XOaOv8HxxyY1xA5AdesTo3028XBligp7XRpaFgeMQCaQnDrcTXUoNUFEAYd2FVAVWlcIj0D2qa1
	SEB1EmHICbpdU7O14x6JUJMXjcfk14erZDaYfNTDT8Q==
X-Gm-Gg: ASbGnctQS8xpOIPgijuF6gqvhMFfu65zvABHqJHkD64mphTHa+Gz/Q5wpOthzBUQSpX
	uTQ7RfKL08jyyLe2o1XkQIQ0tNzAaRsoTUHifcwlvK4B6CqJPc47R7Z+3RdyuHYvv3LmiN0b5HH
	Xxx0ZB9Yq14nB3qLC0T0EAE2k53ZfUygaeRdw036PpfgPmDW4iqvCerHnH4pwg02og0tTkzBpWK
	6yrZg1ggnrQlO6CN6SCY95E3qvBCoyHzC4eRWSsLbCg/cKR+omsuv/cQkIhAJKM2+VGJwztk7Uy
	zg==
X-Google-Smtp-Source: AGHT+IGs1i5jYMwbaLlrfd7bj2pB6zXQmPz0bH8HdsC7EIxuIEFzisuXnQAnT8qR0b61+0KWK9jUwDlnypRtY3EbS0o=
X-Received: by 2002:a05:6871:7426:b0:3d2:e13c:5ea7 with SMTP id
 586e51a60fabf-3f1693a56e9mr2970174fac.39.1764824452474; Wed, 03 Dec 2025
 21:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114033243.76509-1-cuiyunhui@bytedance.com> <CAD=FV=Vh-guJS+5BAqhao9aECtkRFgoqEjpzhuDYEsRVqtVA6w@mail.gmail.com>
In-Reply-To: <CAD=FV=Vh-guJS+5BAqhao9aECtkRFgoqEjpzhuDYEsRVqtVA6w@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 4 Dec 2025 13:00:40 +0800
X-Gm-Features: AWmQ_bm8VR4mmm7gM0qxlsCJG381p5n9-XFc6fATbqwFqWlsUG-TXpi8vcKmNZI
Message-ID: <CAEEQ3wmz=CHkbxZwyMHGTSeXj0OFjBskgzyEKeZHk9rNOWge+w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 0/2] Add HARDLOCKUP_DETECTOR_PERF
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

Hi Andrew,

On Sat, Nov 15, 2025 at 3:21=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Nov 13, 2025 at 7:33=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
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
> > v5->v6:
> > Removed the dependency on CPU_FREQ for WATCHDOG_PERF_ADJUST_PERIOD in K=
config, which fixes the
> > issue reported at: https://lore.kernel.org/oe-kbuild-all/202510240701.e=
B6r97V3-lkp@intel.com/
>
> I haven't tried compiling this myself, but it seems like an OK
> solution for the compile-time error to me.
>
> -Doug

Could you please help review and merge this again? Thank you!

>

Thanks,
Yunhui
