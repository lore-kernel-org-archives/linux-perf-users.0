Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AD2BE024
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216295; cv=none; b=fnjH7ZEAIpqlV3q8wuAcCrvtdtbanz0HDhEkTtu1/Qp660s+0zTT5LLjcqrxj5BgXE82p4x/TsI/jsvF8Df0hys06BHn1bLJD8+zNLvVsQ/QHN1aNVqqC8W+UNA5jN4geb4Ffr63MUGM8ZeXprCko/KF9Q5XO62me6tmVYuqviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216295; c=relaxed/simple;
	bh=wU7LKPEWgp8v64IOBUq45JwQFdXugbm6cOiATPmV9CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lplN/9pB9NCd8r51ynBSWbjHzHEwgOc00E5pQ+/UUHRD8c0oIqQMdOto31U4ok3m3DAICK+8uTIzbtIWBlEQBEf8e9uJy/fhjvxppl4qx7w02oIGt4T4E8yEgDrHFUH4qzgJGzkuK5jhcERs/VYEKZxzuThNEV0npjDP9xI9wow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BDMZTUH9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BDMZTUH9"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7a32c0163bfso3322744a34.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759216293; x=1759821093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR+v3DYyPIQfSuBgQSD/F1YEBoxZbmD+6/3elV5THH0=;
        b=BDMZTUH9pvj1q3ZmJ7w+1z1WJ7tdEfOzM154R+mlWma6AWkQNy2o2uVZUZHgdamTCH
         LLnMNYfZUw+ZUkscYF8SHyXu1SUqRXFDoQgS/Gn2GsZhC+j0GpkcRN1XkEDXvkolecZj
         fHE+wMc3TKMkqj9tIjbw444Lna3I2nIJIAujHGAtDsZXhlozxAp4AVqpFOf2arHPnZfh
         OtIHSdjLyMpX16DZU1xcjoRfxLMCIiVJtbMhmM94bLd6xyWRE+vls9sr6au3ml1+Lm6r
         ZcZwP90A5dQg4nz2eWpwDHcM0ZyrQJY4ECblU+EKzNqyy6pLivZJvUIWt++aZOluuJ4a
         Qp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216293; x=1759821093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR+v3DYyPIQfSuBgQSD/F1YEBoxZbmD+6/3elV5THH0=;
        b=V5GUEE6URmbBX11gfY/i1EqTCzA5s8/T+nXhlEHNs6fYsATk7Lq2JIdIUEPSKxH3hm
         fTTXz3MEmUOWTl99XHvyTG25HyONKeOGky4unlQwe9L8IoanJCEZf9ijDd1xmbc9oD7V
         IFpygZwgcL8p47FQjQlWJ+AImsbWizXO6+YVPHxuNikZtJpZ+NbVxFTIzdlLWz82rKul
         FhzLYaDrDqq+8F/yuUeueXhJIldlrg0HFhKaRTZfoT1jH07SzGGzGVkSSJaJsZ5RM66X
         lJRPxV9WApsnKGa8rueKUD+B9t+sCjzuOHGOM+DXkoytXK7/uVSd7oWvKULX1J+7snmY
         yrRA==
X-Forwarded-Encrypted: i=1; AJvYcCUVIpYIlYK020nrp9aJXiuNmQs9hmvBUMh02lQjNs/+cluoe7ZDXIXpEGxymNhEmgphdjRMH8FDyk+gX7KopRKP@vger.kernel.org
X-Gm-Message-State: AOJu0YzIm+VXb2YRVunWAKUD3/C1F2j4BulCjkybRKpOPGWcR1ITwroP
	Mjzx5yai3keKXsolpQACma8vzr/Re4RTSIfh7mUMOE/sFC57QYhuKh1K7QMqKkqk2rexpI56W85
	sgv3DRZOqpzc3oHWSNLoKLEfjGil89XaJQEMuMJX7CQ==
X-Gm-Gg: ASbGnctHaijeyWZxF0OPnPCDugKn16AWGEuPtAai89ukdd2ZZHoeM6Mcd5Xn2zgUs2u
	zLjLlhGbcDaQbcKTz9FU7oLgIdT1Wv7rDKCL1+mijfz6sRk3QQkHrqeI6DMnfs7byiKqzyzqEFi
	obmPykZ8qDbbXXtvmG1xu9uoCx84gy03xPvbSpICa3xPCYL/i5MVR9rd74bTBIRoWzBGckIvLDh
	gVIo/MKfU8HOB4czGaCLHGaEitV6H7KJB90BRS0w4hZ9jSkGgg=
X-Google-Smtp-Source: AGHT+IG13enBpViuqbJkl3egtFONm0MWRV/sewI1GNsujGwdIAgHii202fyE/GTui5/tKuBeRANEDhPr69i6SXBk7hQ=
X-Received: by 2002:a05:6808:158d:b0:437:d0a7:e7aa with SMTP id
 5614622812f47-43f9401fe52mr1763089b6e.19.1759216292941; Tue, 30 Sep 2025
 00:11:32 -0700 (PDT)
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
 <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
 <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com> <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com>
In-Reply-To: <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Sep 2025 15:11:21 +0800
X-Gm-Features: AS18NWBdZh_HxwD18sk9IRGlss7IupBdkXT8d-g2velRw5frfqvDCFq41tp_kn0
Message-ID: <CAEEQ3wkUai4-noA6CQDsOs=Hn3bSB5cdV9tZJZR8_g+o9e-Mpg@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 9:53=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Tue, Sep 30, 2025 at 6:56=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Sat, Sep 27, 2025 at 7:38=E2=80=AFPM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > Hi Doug,
> > > > >
> > > > > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@c=
hromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@b=
ytedance.com> wrote:
> > > > > > >
> > > > > > > @@ -17,6 +17,7 @@
> > > > > > >  #include <linux/cpu_pm.h>
> > > > > > >  #include <linux/export.h>
> > > > > > >  #include <linux/kernel.h>
> > > > > > > +#include <linux/nmi.h>
> > > > > > >  #include <linux/perf/arm_pmu.h>
> > > > > > >  #include <linux/slab.h>
> > > > > > >  #include <linux/sched/clock.h>
> > > > > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct ar=
m_pmu *pmu, int cpu)
> > > > > > >         return per_cpu(hw_events->irq, cpu);
> > > > > > >  }
> > > > > > >
> > > > > > > -bool arm_pmu_irq_is_nmi(void)
> > > > > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > > > > +bool arch_perf_nmi_is_available(void)
> > > > > > >  {
> > > > > > >         return has_nmi;
> > > > > > >  }
> > > > > > > +#endif
> > > > > >
> > > > > > Should the previous comment move here, AKA:
> > > > > >
> > > > > > /*
> > > > > >  * hardlockup_detector_perf_init() will success even if Pseudo-=
NMI turns off,
> > > > >
> > > > > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_p=
robe()=E2=80=9D
> > > > >
> > > > > >  * however, the pmu interrupts will act like a normal interrupt=
 instead of
> > > > > >  * NMI and the hardlockup detector would be broken.
> > > > > > */
> > > > > >
> > > > > >
> > > > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > > > +{
> > > > > > > +       return cpufreq_register_notifier(&watchdog_freq_notif=
ier,
> > > > > > > +                                        CPUFREQ_POLICY_NOTIF=
IER);
> > > > > >
> > > > > > I think you need to do something to prevent this from happening=
 on any
> > > > > > platforms that override hw_nmi_get_sample_period(), right? Thes=
e
> > > > > > cpufreq notifiers will be useless in that case...
> > > > >
> > > > > I understand this is not a problem. watchdog_perf uses
> > > > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by=
 the
> > > > > CPU's main frequency. After we make such a change, a larger value=
 may
> > > > > be used as the period, so the NMI period will become longer, but =
this
> > > > > value will not change after the system starts.
> > > >
> > > > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> > > >
> > > > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > > {
> > > >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > > > }
> > >
> > > I have added the maintainers for arch/x86.
> > >
> > > 1. cpu_khz can be understood as returning the base operating frequenc=
y
> > > of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> > > downclock to 800MHz under low load and overclock to 4.4GHz under high
> > > load.
> > >
> > > 2. Because the event provided to the PMU has the
> > > PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
> > > on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
> > > fixed; it varies with the CPU's core frequency. When the CPU runs at =
a
> > > frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
> > > it will lengthen.
> > >
> > > 3. After our modification, if the architecture is not integrated with
> > > cpufreq, it returns 0 and will not update the cycle. If integrated
> > > with cpufreq, it returns the maximum frequency supported by the CPU,
> > > so the NMI cycle is only slightly lengthened, with no impact on the
> > > actual hardlockup detection function.
> > >
> > > 4. I have also conducted tests:
> > > stress-ng --cpu 1 --taskset 1 --cpu-load 80
> > > echo 800000 > scaling_max_freq
> > > turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectivel=
y.
> > > And the NMI cycle became approximately 30 seconds:
> > > [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =
=3D 1
> > > [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =
=3D 1
> >
> > Whether or not having x86 and powerpc start looking at cpufreq is an
> > improvement, certainly it is a change in behavior, right? If we're
> > really changing the behavior here then the commit subject and commit
> > message need to mention this. Right now this is billed as a simple
> > rename...
> >
> > I don't personally have lots of experience with x86 cpufreq but I do
> > know it doesn't work quite the same as how it does on arm. It would
> > definitely be good to get someone on x86 / powerpc to make sure that
> > they are happy with this. ...or you just keep making it work the way
> > it did before and then you don't have to worry about getting any
> > buy-in from x86 / powerpc folks. Up to you, I guess.
>
> Well, I fully agree with your suggestion. What I can think of for now
> is wrapping the newly added content with #if defined(CONFIG_ARM64) ||
> defined(CONFIG_RISCV).

I=E2=80=99ve also thought of an alternative approach: add a generic
WATCHDOG_PERF_ADJUST_PERIOD to /lib/Kconfig.debug, then have the
Kconfig files for arch/arm64 and riscv select
WATCHDOG_PERF_ADJUST_PERIOD. What=E2=80=99s your take on this?

Do you have a more elegant approach to
> recommend?
>
> >
> > Note that folks on x86 have definitely had to deal with turbo mode
> > before.  See commit 7edaeb6841df ("kernel/watchdog: Prevent false
> > positives with turbo modes").
> >
> > -Doug
> >
>
> Thanks,
> Yunhui

Thanks,
Yunhui
