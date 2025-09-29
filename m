Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C046BF
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759186549; cv=none; b=qLP8rlBS3sIAnVYuhs/hdyTLP3hJPXa/B7kgMDT1WcE0KiwOUQX5ic5xyvWUL4pqkMHtObN1SuskwcZcFEPyo+1Z0UQkLy0pKnyJuy1MqnbBoHOENhDgTW7CwT2+jRUjUqvZMfpS35ESdTc1Ds67ug8r1OdvVp3QJpqcXFSJ3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759186549; c=relaxed/simple;
	bh=yWltR5UMzQ7WPVaW6BAgCDmNnZZsCVW/Imk+hdrGYds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meROsnp4z0udlFn9GieoeXwyTECfv6UgqfZT3rQW1XgLtBdWxcoyBH1EAlgS8BBAz68GBVEL8ykQ6/Bn+cft9TLYSJ8Dh85HjLNXg+qauc3bF79uDWG5NgPNyqybSBIg14IS4TOoLbl5hz6nZ053ixzpoLE+6ShT6OK0u7j0N44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=blm/TWE4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="blm/TWE4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267f0fe72a1so40979495ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759186547; x=1759791347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWwi2YKfcBmpXzN2h2HKSfYkQo0+gXnuV1TKOkK9JPg=;
        b=blm/TWE4F9Oirn2qLsmmuxCns8S1JAOZHFkub2KrhpTIfat6bD8yMre+zbYODU4hJl
         Y8qS6lcwlYhsZmOyy8G5COxZgLHpaP5O+9WSMTUxPRUDwTWw0AF42Om/ItgPIEiAkMhs
         zZ75tTXkxF/8r9gkbfGuAadj5xsgLGUokYEDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759186547; x=1759791347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWwi2YKfcBmpXzN2h2HKSfYkQo0+gXnuV1TKOkK9JPg=;
        b=P/y0mMJUE9SpFZMCqx4v6xwlefCsr0+UAGrZV3ZfZd2xf3Heo78rrf2rGWEoCat1oP
         F8w4XliLjQwuZt48UkwtQqojaMMnDAAZWLF5vlim5hx3aIA5bCnMVP5NfYvznLzmhF8d
         UWZ3lxdrS5wkuGGSjO/FidT/wvF+zeLuatpfJSsbuMIxiWf5B/c0MNCjSuOsBXBwZPoj
         FPT8xlhccRcqWTC435OmOM+2nSan2eNFtY+PQ3LcQkoE8UvO8YZJgbv9S2PYroNmwdo2
         Ty13//5yxEbA+Ju/6up0QAP2D5ZPM/IT+xbOLfIwBiqtZAk6fzvs5Z1EWyK2vLZI+Mbq
         AleQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMkZgppmBRl8jfFXiEJlDktSncJSiU8+3TuoY+jPhkwmtwhnHjWsT6vl5Q86nm9G8aPQw31ljI8NbQHdBoQbzZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzhyy5zTQHpsw/FsEYrkQgZVBwbuknMtidKWi2cxxP7ZeakyNQ
	0uX2kRicIjxfbuN88RaNGWt11fKxkOonpqB3ytZVb0tjNMaTW5NmR7K4zksmXL2pvBVULDkLs9k
	FU1w=
X-Gm-Gg: ASbGnctqly/gWoXOwSFle0qiD4mNeoAXU5P5SmWkxT1hHsrLzmr58ep5Qtep0IDviLa
	W8954rKz2WQmVs8VdgLyUYa7vBKSjx40dPJ7SCbIoIwsSRJ9p/ZNAKRLPsOQZeRQvS+LJlnmk1G
	pt29Nkc8fb9aXZy3qLJmXJUdSY5Bp+4ICIHpUejUdZYeNA+X//hUxnCPwEzr9zgci0mJg6Xi09K
	hSjoOdvEGR8O+Hq6gB1AxiESzHQntQfax/gYyZEEd6KdQ5dQEhGzDAe96fXlusmuB1PfzQ6sQaK
	vRMwnHcvyrBI4sq1mgO1aQ0xrxs8wOzV6YOmswQq23g9SjrLephLUrBRaENwcYwSzLD3ryf8HgW
	TtxAsPIp50q9k0Uhzmeniqa+AhDGkjmQEDuHWwSqD5nxXA+wGwJeAV4rA9ovrGdBw3g==
X-Google-Smtp-Source: AGHT+IGeQ0sYeoGyM7LpFkq/TFU2U+mgarTUc+40E4E8k4VwA85HOxvhmwQflZTiPuBHiBcBQ0jtrA==
X-Received: by 2002:a17:902:f688:b0:269:9adf:839 with SMTP id d9443c01a7336-27ed49d0be2mr208365285ad.19.1759186546745;
        Mon, 29 Sep 2025 15:55:46 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d6523sm141806495ad.11.2025.09.29.15.55.46
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 15:55:46 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698d47e776so45701525ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 15:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8Qki47U6Kj9Z1ODRm5m6ADOLrutQtWla794TINMLwABt2ds4cRduLpfHVP1mRLgRBBc5GssRIft6BrGBL7jc0@vger.kernel.org
X-Received: by 2002:a17:903:2291:b0:27e:dc53:d222 with SMTP id
 d9443c01a7336-27edc53d5ddmr177688785ad.44.1759186545584; Mon, 29 Sep 2025
 15:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
 <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com> <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
In-Reply-To: <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Sep 2025 15:55:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
X-Gm-Features: AS18NWAnKZZMEtwxIM0YbV4Mazpr4rnQGlLmvr3-cqjcbEOsSH_1wE2lEHBVzYs
Message-ID: <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: yunhui cui <cuiyunhui@bytedance.com>
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

Hi,

On Sat, Sep 27, 2025 at 7:38=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include <linux/cpu_pm.h>
> > > > >  #include <linux/export.h>
> > > > >  #include <linux/kernel.h>
> > > > > +#include <linux/nmi.h>
> > > > >  #include <linux/perf/arm_pmu.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/sched/clock.h>
> > > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pm=
u *pmu, int cpu)
> > > > >         return per_cpu(hw_events->irq, cpu);
> > > > >  }
> > > > >
> > > > > -bool arm_pmu_irq_is_nmi(void)
> > > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > > +bool arch_perf_nmi_is_available(void)
> > > > >  {
> > > > >         return has_nmi;
> > > > >  }
> > > > > +#endif
> > > >
> > > > Should the previous comment move here, AKA:
> > > >
> > > > /*
> > > >  * hardlockup_detector_perf_init() will success even if Pseudo-NMI =
turns off,
> > >
> > > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe=
()=E2=80=9D
> > >
> > > >  * however, the pmu interrupts will act like a normal interrupt ins=
tead of
> > > >  * NMI and the hardlockup detector would be broken.
> > > > */
> > > >
> > > >
> > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > +{
> > > > > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > > > > +                                        CPUFREQ_POLICY_NOTIFIER)=
;
> > > >
> > > > I think you need to do something to prevent this from happening on =
any
> > > > platforms that override hw_nmi_get_sample_period(), right? These
> > > > cpufreq notifiers will be useless in that case...
> > >
> > > I understand this is not a problem. watchdog_perf uses
> > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
> > > CPU's main frequency. After we make such a change, a larger value may
> > > be used as the period, so the NMI period will become longer, but this
> > > value will not change after the system starts.
> >
> > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> >
> > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > {
> >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > }
>
> I have added the maintainers for arch/x86.
>
> 1. cpu_khz can be understood as returning the base operating frequency
> of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> downclock to 800MHz under low load and overclock to 4.4GHz under high
> load.
>
> 2. Because the event provided to the PMU has the
> PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
> on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
> fixed; it varies with the CPU's core frequency. When the CPU runs at a
> frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
> it will lengthen.
>
> 3. After our modification, if the architecture is not integrated with
> cpufreq, it returns 0 and will not update the cycle. If integrated
> with cpufreq, it returns the maximum frequency supported by the CPU,
> so the NMI cycle is only slightly lengthened, with no impact on the
> actual hardlockup detection function.
>
> 4. I have also conducted tests:
> stress-ng --cpu 1 --taskset 1 --cpu-load 80
> echo 800000 > scaling_max_freq
> turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectively.
> And the NMI cycle became approximately 30 seconds:
> [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1
> [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1

Whether or not having x86 and powerpc start looking at cpufreq is an
improvement, certainly it is a change in behavior, right? If we're
really changing the behavior here then the commit subject and commit
message need to mention this. Right now this is billed as a simple
rename...

I don't personally have lots of experience with x86 cpufreq but I do
know it doesn't work quite the same as how it does on arm. It would
definitely be good to get someone on x86 / powerpc to make sure that
they are happy with this. ...or you just keep making it work the way
it did before and then you don't have to worry about getting any
buy-in from x86 / powerpc folks. Up to you, I guess.

Note that folks on x86 have definitely had to deal with turbo mode
before.  See commit 7edaeb6841df ("kernel/watchdog: Prevent false
positives with turbo modes").

-Doug
