Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9B2EAE3
	for <linux-perf-users@vger.kernel.org>; Sun, 28 Sep 2025 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027104; cv=none; b=TUbiMn65belQ8w9atCnBqDIYkQKfb/6Ozsw3S9mUSUDQxFBHWz7d2AjbeMnTGX2L3mLbbN0tyqxysrQ7aQcRuPzppOX1ohkZf1wEPGNN6yuKZgtXYMxSCC9QCAhjYoJHdhhtutc/ZgqlBqX7bj69qTztcnMLdZHgK3MZupxHbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027104; c=relaxed/simple;
	bh=y1o0NktTiBEjBpOsSj/+9mjkA32Qt5ndvIyNBx4gntc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo68rR6G35DT4Yqm0K7KC6wEcbprtzJAVQvEPq2/ADFOr6RlXtP27oBOcc+KRawzKnX8DFJ/2ytfGtnbF0gWItwKZCbYaxKGl4J5n7fnEoEIGs4TVIb3STB2hveTn2PaHBVRBQfTxSqA8BB0zjjEZ7x5kLHK9anamMB5288hvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=asix7SXw; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="asix7SXw"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6401f1733d7so1257662eaf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 27 Sep 2025 19:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759027102; x=1759631902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDDVDZIdgHY10IxWeSmThIWnM3Kfl8SB2Uc8qwV0eGM=;
        b=asix7SXwsSIdHyHeR0zGuCLJBz+BNzd6M+VkUCC/c5AjPAWzRHxWmvFWChtHPKlPwc
         4yb0Fy6t9jxb5ndZ/56x64mTcWlos83ImV4zoEnf983IG4D7RuN/0R8OQMu7Ztg5s12Z
         s39O8eqf4//VNdp0Jjhv3jhv7LSMMNfm7NZ3T+VdR69d6TMqRbmUfZDzDXXKJ9qG8Nj3
         AF+uEGegnQF9mi3gkXIB0wjr/VIz3QtAA+xQUVInv5kbcku+o6G/aaDHOCwxKZ7M6AWg
         4TqQjMPW9JPPnW/sj9MJ1WxyziLy+mxJHOfQkNVu9Vd5glLyaZMmtevrIvjMZ+J/SGJu
         ZEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759027102; x=1759631902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDDVDZIdgHY10IxWeSmThIWnM3Kfl8SB2Uc8qwV0eGM=;
        b=VAStwzNt5hvZqrflWz6VFyuWc0Sjq6pLQpCYIMdM6bmZ6Ak+5tglJ7bX4oeIdGmSR3
         csExyUlsm4fEvEZlE0IM8JjCWJHw89teY0IbgkyRrVVTcEJtsWZSLanfYmkN8ImKt/PK
         /5QKBDG2HnDyTsJVZkJJBHKxGNxpXvSxi1QwVwUm0XqZL8vkvB9oNAigH0sLsWldo4KX
         iJgljLpKk0b0NZpQCY4l/557eKTa3+M7JLHT8iHcvG3OiBSD1+wDcDij6bhyCW/WOajq
         UY8BGygWENRyuuEG+GzrV/s6cM5nHzNxPyyUwHlknSyr/eD12vAXzNdeFrFzDMM5Sn/x
         8sTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/aKtwO4S/5rP+V+Dq1dM4x9LnFd9aBozo/9vmlZ4bFtuq7kdYkiw15JiZ16BD4Lqhmv2PbnXT1MfVTPYc5xy9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nvOc1W74VEO5edz9VI+gdjXiFZ2O1eAGc6OO+RGL6fIJe8i4
	h0LKKKPYrqorantAU+UevyxOuS/idCSXghO+0ytzONPwEVqSFvueZLztzZjjaGhwYlNL4vQLf0C
	2h2toD2JwPEC58Fc+FcN8XuTzg9vaq6GBHy7fKy3mXg==
X-Gm-Gg: ASbGncvFYygOHQj8mW3mhV6ne4rB+SE/Iy8BfqV4vR57js9Xb7PogKR2LhBfnUu0C2N
	lNzkUxmkRutQJj0kC0iY5RQUY+fC2VV92Sihe4uyzLtXCoEJX5kEbHVPcicL5uONaJaZ5vcrJN1
	/bBGhVDln3bDtyORHHvx/Rmh0o81Ydp7TUkqValhU3Mkf0BdIHjPeRH64YHnMwB4Lsl9CvKTRk+
	1AjGX6TUQy6E9Os3flxaElNES60RwA=
X-Google-Smtp-Source: AGHT+IHN9SZKPMfskn9LtN56hlvjdE/PVxPJY1sD2/2M2FEMKbIx55CZ1Hog94gS2psvQYARXktJ5bJrXOdSq0er7i4=
X-Received: by 2002:a05:6808:3022:b0:43f:7287:a5d0 with SMTP id
 5614622812f47-43f7287b062mr1202461b6e.34.1759027101799; Sat, 27 Sep 2025
 19:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com> <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
In-Reply-To: <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 28 Sep 2025 10:38:10 +0800
X-Gm-Features: AS18NWAN-ZpVjYdN0iAwRHsiQoYm1lDRDU85PF8Qq2B5t-2l3rsp0TxumU2MhVA
Message-ID: <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Doug Anderson <dianders@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, ziqianlu@bytedance.com
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

Hi Doug,

On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Doug,
> >
> > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/cpu_pm.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/nmi.h>
> > > >  #include <linux/perf/arm_pmu.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/sched/clock.h>
> > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu =
*pmu, int cpu)
> > > >         return per_cpu(hw_events->irq, cpu);
> > > >  }
> > > >
> > > > -bool arm_pmu_irq_is_nmi(void)
> > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > +bool arch_perf_nmi_is_available(void)
> > > >  {
> > > >         return has_nmi;
> > > >  }
> > > > +#endif
> > >
> > > Should the previous comment move here, AKA:
> > >
> > > /*
> > >  * hardlockup_detector_perf_init() will success even if Pseudo-NMI tu=
rns off,
> >
> > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe()=
=E2=80=9D
> >
> > >  * however, the pmu interrupts will act like a normal interrupt inste=
ad of
> > >  * NMI and the hardlockup detector would be broken.
> > > */
> > >
> > >
> > > > +static int __init init_watchdog_freq_notifier(void)
> > > > +{
> > > > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > > > +                                        CPUFREQ_POLICY_NOTIFIER);
> > >
> > > I think you need to do something to prevent this from happening on an=
y
> > > platforms that override hw_nmi_get_sample_period(), right? These
> > > cpufreq notifiers will be useless in that case...
> >
> > I understand this is not a problem. watchdog_perf uses
> > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
> > CPU's main frequency. After we make such a change, a larger value may
> > be used as the period, so the NMI period will become longer, but this
> > value will not change after the system starts.
>
> I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
>
> u64 hw_nmi_get_sample_period(int watchdog_thresh)
> {
>   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> }

I have added the maintainers for arch/x86.

1. cpu_khz can be understood as returning the base operating frequency
of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
downclock to 800MHz under low load and overclock to 4.4GHz under high
load.

2. Because the event provided to the PMU has the
PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
fixed; it varies with the CPU's core frequency. When the CPU runs at a
frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
it will lengthen.

3. After our modification, if the architecture is not integrated with
cpufreq, it returns 0 and will not update the cycle. If integrated
with cpufreq, it returns the maximum frequency supported by the CPU,
so the NMI cycle is only slightly lengthened, with no impact on the
actual hardlockup detection function.

4. I have also conducted tests:
stress-ng --cpu 1 --taskset 1 --cpu-load 80
echo 800000 > scaling_max_freq
turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectively.
And the NMI cycle became approximately 30 seconds:
[ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1
[ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1



>
> On PowerPC it's:
>
> u64 hw_nmi_get_sample_period(int watchdog_thresh)
> {
>   return ppc_proc_freq * watchdog_thresh;
> }
>
> Neither of those are necessarily based on the results the cpufreq
> reports. ...so therefore I don't think you should be taking the
> cpufreq reported numbers and assuming they're OK on x86 and powerpc.
>
> -Doug
>

Thanks,
Yunhui
