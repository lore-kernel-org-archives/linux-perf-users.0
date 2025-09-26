Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09529DB88
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879478; cv=none; b=gea5ajglpnUlC3fZgHO2iWne8/PURKInM4VOLiUDswAzNs9pw4qSlHtwqnwDFFJPjZr+BqRhAGYgAuayHqBo4efIp8H1Szilo1mVKdeNNBU2uUiz4WHgDLqhi+DS91Nrx1KgpY5nZFKOoUF57o94AYPlGiX0sQ5170FH62E+ERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879478; c=relaxed/simple;
	bh=B/7QQgyqHSm4AZXbTcSg97A8gq1X1CH39AjApJhmXr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcKbvpJkQS+Bf0jixpL00pn49CL3tdJUCwr2sDbOP+Us0Yf4aeXGS7+wKicNZDORsVkQfwce8tKpzn3RnLjIgScTe61Xpp1iV8FYPG8eLUHgcumR4Hz4d17puP4TQpFMtiqUNUPZrycVT7UqkT/pF1V9GkcS/6cezZGwAWYUUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G0n7Nqss; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G0n7Nqss"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74526ca79c2so872483a34.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758879475; x=1759484275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5FmCZ7m0CyShB1Ycdtz4U9JEqoB4MdA/m7HVOlr6mo=;
        b=G0n7NqssAzj0IG6CY+5Qi/lsv6pyp4tX8yLowhiSP4mEo1a5zTTGdKPh+Vcz32SSv7
         VrGACAxwyfhxcCAXEx5Il62yjT9yLvO1IQc1E2hIxPNbI9d09gWxht9RfS+rAy8osM5L
         qsbnHj1eoBUDsSMV8Y4b8weoNajm03mzhYNXqDT4heEzUw+V4JMH1h0d6AnWssO/u+Ow
         g4fwuVCzauhfsyJhp7KH/mGdi46kP0/X0te2b61fmg6V7xfz5qIlvtnCldaqEpvhpVI2
         Bb1sLFRQOUkCIfaSh8B1VRJ2+jHQWHug6VSUqtVoJ1uwEtRTjb9E5nlO8js9t+DFrZgO
         vtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879475; x=1759484275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5FmCZ7m0CyShB1Ycdtz4U9JEqoB4MdA/m7HVOlr6mo=;
        b=p/PUx34Pdm7SQGv5ixZWOIPVgoC5e5SwARKWdW5NdKMlVCxASZZxR54c6DnYaqaKb0
         3GPZWGM1tEHuElE17XpJD8WTcAYGdTnZbNdh+rT3zM9Y9q+7EfVQkT5aXHUCURDe0wMd
         Rka5FDvcnfQKZbFvExJQeVT5jWaUZco80vZTDR6A0ts5ASDvehbxEslfj6g06nsWugRy
         F9eRTwBgGqcTx2UVLA8/qlT7Ti9rWGI3Js+Rf46LLANw9Umra1kHJFO0AUMJTwBazpIP
         aoIuFOHndNf8UOuwvlx2jtZxqewSmfliMvwxqKLaiHcJ2yuMI2iiupGadj0BVXQozlJ7
         0Y7g==
X-Forwarded-Encrypted: i=1; AJvYcCWma8bAhmq6zkhQcHQdGWlOtqp940PnITPMPekDMLZiROzfBtjZEVQiR/sHdo6yDWbPgeEYWywXEciMqv03+uZw@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFqhgHKg/fCxru1j7rLKegBkBFkC0lIJxdVLBN/b4PzQd0dls
	MGTfoIwqnVVXX4/V7cOEoBID2KYDvqi2QV2DfEafaZaTh+ny0mm8vIHEMpTYP+xHEnzLvdddOlz
	CmKogvYRfL7CzBnPXrKv6GEmbIY7n6Swu/zKrWMDv2Q==
X-Gm-Gg: ASbGncuVRZtgO0HM/p5Cc1OiTICYuXUeXtM0SDkt1jIMOeOt5+BLcbe+qWQpeCwrpQJ
	c3wI/e5MsEyD4MP8nvXPkQGDXeolT3/bXMHQRNMmyZn0kOGRxU67dYs06C1UxPFvqXfhWE3ppFE
	OuZUlg5IHewAfqqogB683KW8goeWVM0J1k5q2PRlvN2g/bv/VIrtFsMKzxVn6EnbvNAYrVHCnHn
	RgIgHZ/7qFWFglaYqqXpWz6mXfaMFXCWi3u8g==
X-Google-Smtp-Source: AGHT+IEc3BE14yCdZtCENJr4UXyf6Y8XkhqfpWh+WHahYzWW5GLDg7SSMeNNAS+2Kw/XzX0+d+blEeRda/r+amoNwkc=
X-Received: by 2002:a05:6808:8843:10b0:43f:5218:878a with SMTP id
 5614622812f47-43f52188986mr2126658b6e.22.1758879475127; Fri, 26 Sep 2025
 02:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
In-Reply-To: <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 26 Sep 2025 17:37:44 +0800
X-Gm-Features: AS18NWBUD0z6jg0TusFj1nphukSzt5aTNsZRJ0rH-JxFSgQYIIkepAcYdgJLzRk
Message-ID: <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
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

Hi Doug,

On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > @@ -17,6 +17,7 @@
> >  #include <linux/cpu_pm.h>
> >  #include <linux/export.h>
> >  #include <linux/kernel.h>
> > +#include <linux/nmi.h>
> >  #include <linux/perf/arm_pmu.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched/clock.h>
> > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu=
, int cpu)
> >         return per_cpu(hw_events->irq, cpu);
> >  }
> >
> > -bool arm_pmu_irq_is_nmi(void)
> > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > +bool arch_perf_nmi_is_available(void)
> >  {
> >         return has_nmi;
> >  }
> > +#endif
>
> Should the previous comment move here, AKA:
>
> /*
>  * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns =
off,

Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe()=E2=
=80=9D

>  * however, the pmu interrupts will act like a normal interrupt instead o=
f
>  * NMI and the hardlockup detector would be broken.
> */
>
>
> > +static int __init init_watchdog_freq_notifier(void)
> > +{
> > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > +                                        CPUFREQ_POLICY_NOTIFIER);
>
> I think you need to do something to prevent this from happening on any
> platforms that override hw_nmi_get_sample_period(), right? These
> cpufreq notifiers will be useless in that case...

I understand this is not a problem. watchdog_perf uses
PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
CPU's main frequency. After we make such a change, a larger value may
be used as the period, so the NMI period will become longer, but this
value will not change after the system starts.

>
>
> -Doug
>

Thanks,
Yunhui
