Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE096FBF6
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197212; cv=none; b=EmDz9WGPGJgKhpkVMB9nzkE1BJqrYXz/+kPkJGQI6Qvyk2BK9GSXb05QT0UrZtyFPEo8csRe3Rd5vtCwcXLLQF/EFlsdFRJ3ReSq7HtLd8Ax5Zkb0yiqhIPQwqkdnflGtj9GcQn20TUUPoVXaw16LixvTGBZifuJsRkoBmKp2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197212; c=relaxed/simple;
	bh=KHeRZdF9f1/WYrUGtC1t0PzuWIeBDY2y/0U9s6lUey4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtQlJ42FA2gWlUPPrPJA1LlmpCsZwlIta+FDuJwdc47nfYJgekdh5pUul6GExl4pmDJdQUlRvfxiVS7hhDGiDQuJIDZM2qGunBz84BYy5QhWcTPf5+g8RqnxDWSb3OpCQvHAnoPuQslUNFJP7KFtFVsCmGdZ8XQLPNKmlyVlelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MTvDTONY; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MTvDTONY"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-646f75551e7so587515eaf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759197210; x=1759802010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHamc5L5wTvTPFxS1t1gdHiPJZFL4Y2ngP4edhfwGzA=;
        b=MTvDTONYjWn+PfwuhV2mzazO1mMwmSGdGsVqHCH6p9CdZvf5k3W+KSiIVPAIH0R/5t
         lBQMuhDlQwJWQ6ekDCQYcQa9r+rRH4sqoI0K1pK1D5n4b/AT4rLI+5qfu+9FxhWWcwRO
         kQEA+hEGTgLdNWgtHeYy+n7MA9AMzV7Us2hSnO/P7bU/1wPyFk8JAJ7bQLUywH1KDd0U
         OBxVYR1HllUa7YyGzdP592a9ExBR2DC51MbMTGnq1k5vpuuX/+gXFmpCkZqcsIuRNxIE
         eIHKszcUZfs3+a9LQ7b3SpAy6DMwFZs9RqFkikNyTRxvjaZncluhwXyOOF+36F0BpWZj
         T+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759197210; x=1759802010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHamc5L5wTvTPFxS1t1gdHiPJZFL4Y2ngP4edhfwGzA=;
        b=CfSe9bp/2uA9pJ4o3PgGchV1BeXON2+Nibv/G7RdX/2Qsai8BnsrsP2yc6IFSI16pA
         PuyZTWYF7GjaZrYrHFgUDreQgBWwEKrr4DKhDvsdvVoXilcCsrfkaw1T4ycpExfTpZUw
         0TU/VVuewBDih7CZTnYH0N8M3Ix9TLP5ZpP2NVvtGTAtey3Ms9bbabkQedlL6Mt0XAvu
         Ja9kvkP3eyHR7xj1zWfp7x8CBjvjNcvMa+ZaPxHvXkholQrdDMS5NVfcLhg/ZJyio7Xd
         hAuhgKp3BUpFkcnc8aW/YVHNeYsYqzah9yFHuIcfHARUy3b7YnRgM7pEZ3fNLqlW/QfW
         8v+A==
X-Forwarded-Encrypted: i=1; AJvYcCVZMcVqptIWGIUiIzRkWbHL+c+o+vLxKhYIA0anp6RWcUA5QVPw3pBCudpDQ6+IXanMXPkTIT8o2WhlyB5PkAum@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xPlGb5VosfBnnbNkr1O7i7BBBrV3u+gPGv2Dtk6D9qP8PqAC
	MBqa3qO6xaoJUi2h1501X+8bLqzoghJ9Zm7nu5kLjgVjDSGfD2CtgwoM+oUOV6eHVxVVt8QSPp/
	bDQTXkXZoJpO/z7LIOa55vTnHd1Wxnbg2Lx34/E7G+A==
X-Gm-Gg: ASbGncvmL56NWcyvMz3pvkCKEeHNXXCQFHgDHkLvpqiRFtY/Qmj2UTMfxALvKUKG1J6
	DiCVfkqGxEdkO4gZma3aPVmI6bBGSkENTt4Ywm3uP11QdD/OsXH8/aocwa+bCsAuZwEmphHNl5i
	aYi5H3s5KRtBaB7I+MlWJX8tAV3egFeK97rKDEAVqcsHQGWOmU9z15GVnHoxVdvCxdJClxyMAqS
	4hp86DoI1Yx1rqcHQTmrZSFDueUIZm452BuBLPP8pVjhfw2eg/6jUc=
X-Google-Smtp-Source: AGHT+IFF+H5NN0a3VCV7KK9x7DfqmNVVmY1tvARIlVfpRzzuFTMLMMebmMXrJVNqsu5Vtt1RgIzJyqFijRAfWLNMznY=
X-Received: by 2002:a05:6820:5204:b0:644:953b:fc04 with SMTP id
 006d021491bc7-644953c01ddmr3120884eaf.1.1759197209849; Mon, 29 Sep 2025
 18:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
 <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
 <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com> <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
In-Reply-To: <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Sep 2025 09:53:19 +0800
X-Gm-Features: AS18NWAw7c1iZ6ACt20cNcuqSJALqhbqwUHFleou105FkMTBcbtF3qtTJwuUi-4
Message-ID: <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Doug Anderson <dianders@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	ziqianlu@bytedance.com, akpm@linux-foundation.org, alex@ghiti.fr, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	catalin.marinas@arm.com, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Tue, Sep 30, 2025 at 6:56=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Sat, Sep 27, 2025 at 7:38=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Doug,
> >
> > On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Hi Doug,
> > > >
> > > > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chr=
omium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@byt=
edance.com> wrote:
> > > > > >
> > > > > > @@ -17,6 +17,7 @@
> > > > > >  #include <linux/cpu_pm.h>
> > > > > >  #include <linux/export.h>
> > > > > >  #include <linux/kernel.h>
> > > > > > +#include <linux/nmi.h>
> > > > > >  #include <linux/perf/arm_pmu.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/sched/clock.h>
> > > > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_=
pmu *pmu, int cpu)
> > > > > >         return per_cpu(hw_events->irq, cpu);
> > > > > >  }
> > > > > >
> > > > > > -bool arm_pmu_irq_is_nmi(void)
> > > > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > > > +bool arch_perf_nmi_is_available(void)
> > > > > >  {
> > > > > >         return has_nmi;
> > > > > >  }
> > > > > > +#endif
> > > > >
> > > > > Should the previous comment move here, AKA:
> > > > >
> > > > > /*
> > > > >  * hardlockup_detector_perf_init() will success even if Pseudo-NM=
I turns off,
> > > >
> > > > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_pro=
be()=E2=80=9D
> > > >
> > > > >  * however, the pmu interrupts will act like a normal interrupt i=
nstead of
> > > > >  * NMI and the hardlockup detector would be broken.
> > > > > */
> > > > >
> > > > >
> > > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > > +{
> > > > > > +       return cpufreq_register_notifier(&watchdog_freq_notifie=
r,
> > > > > > +                                        CPUFREQ_POLICY_NOTIFIE=
R);
> > > > >
> > > > > I think you need to do something to prevent this from happening o=
n any
> > > > > platforms that override hw_nmi_get_sample_period(), right? These
> > > > > cpufreq notifiers will be useless in that case...
> > > >
> > > > I understand this is not a problem. watchdog_perf uses
> > > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by t=
he
> > > > CPU's main frequency. After we make such a change, a larger value m=
ay
> > > > be used as the period, so the NMI period will become longer, but th=
is
> > > > value will not change after the system starts.
> > >
> > > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> > >
> > > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > {
> > >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > > }
> >
> > I have added the maintainers for arch/x86.
> >
> > 1. cpu_khz can be understood as returning the base operating frequency
> > of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> > downclock to 800MHz under low load and overclock to 4.4GHz under high
> > load.
> >
> > 2. Because the event provided to the PMU has the
> > PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
> > on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
> > fixed; it varies with the CPU's core frequency. When the CPU runs at a
> > frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
> > it will lengthen.
> >
> > 3. After our modification, if the architecture is not integrated with
> > cpufreq, it returns 0 and will not update the cycle. If integrated
> > with cpufreq, it returns the maximum frequency supported by the CPU,
> > so the NMI cycle is only slightly lengthened, with no impact on the
> > actual hardlockup detection function.
> >
> > 4. I have also conducted tests:
> > stress-ng --cpu 1 --taskset 1 --cpu-load 80
> > echo 800000 > scaling_max_freq
> > turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectively.
> > And the NMI cycle became approximately 30 seconds:
> > [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =3D=
 1
> > [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =3D=
 1
>
> Whether or not having x86 and powerpc start looking at cpufreq is an
> improvement, certainly it is a change in behavior, right? If we're
> really changing the behavior here then the commit subject and commit
> message need to mention this. Right now this is billed as a simple
> rename...
>
> I don't personally have lots of experience with x86 cpufreq but I do
> know it doesn't work quite the same as how it does on arm. It would
> definitely be good to get someone on x86 / powerpc to make sure that
> they are happy with this. ...or you just keep making it work the way
> it did before and then you don't have to worry about getting any
> buy-in from x86 / powerpc folks. Up to you, I guess.

Well, I fully agree with your suggestion. What I can think of for now
is wrapping the newly added content with #if defined(CONFIG_ARM64) ||
defined(CONFIG_RISCV). Do you have a more elegant approach to
recommend?

>
> Note that folks on x86 have definitely had to deal with turbo mode
> before.  See commit 7edaeb6841df ("kernel/watchdog: Prevent false
> positives with turbo modes").
>
> -Doug
>

Thanks,
Yunhui
