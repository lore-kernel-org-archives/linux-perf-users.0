Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A64288510
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920271; cv=none; b=p25fGv/mvavvZYUvDq4cFVJ9AxXmP0FoRd3WrRND55nGmY4dHSd+++MWlS5G1kNkP6LUp9nwWeB9DIPZCzLzrQWlDhJJ912T3Ox+2eR1Bn1KBOzKEBMX9dEWE+iz4H6h5CXu7bzhbqz+9UioO0kwVToPJ/LGrt06cI+KpSN1eDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920271; c=relaxed/simple;
	bh=CE1reL0wncd9PierxwrDmW4jfOrkqzteseelrqjomUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBkfmjHY2sRhy2M7LL+yUFRvHsIedyHQFKJLj39u7GGHPWujBrSmMraLLK10d+zuutbqzdF6jZ9HRfrVapAcDKPbR8fbz0mNaCldJ0qUtDqJvB7WvLOz4g3CrWyZPRe+hsSVhiWBmVNaBYpXSonza7lcskC5pj/TjM/FNsx1ZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LnFvvg12; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LnFvvg12"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so3042315a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758920266; x=1759525066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH2Sfk58/GaFMno98E5ZZZ0Jezt1oWfRMccsDmLi3+U=;
        b=LnFvvg1251fT84Uc8EvVtzSfwMHLGfZG01EU733AX0T7JbM3bf9WO+AlcCM8uwIuQi
         NFLA2Ky9BXuNNtxTMaLusiOxRjGQKjQAkkW8U0KqPtGSTg40Bo/UtDEA49TBa7QAvW/e
         rdHNtfb2ubWfk/7STYKrdNd1LlTJkOLjhEy/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758920266; x=1759525066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH2Sfk58/GaFMno98E5ZZZ0Jezt1oWfRMccsDmLi3+U=;
        b=KJAoZw08KvrJEURmUVR07QGlCxr38URFiSzTsk22lK50tL8kMl0Z/dLqe8donQC1QS
         B1LmTm3/2Ep6s93fxmi05iDnMefj3NWeenE+48n+ksbRTgownGtOTIbGqaLkOCy7fWBI
         Jg8inB9YtJbB/Zs60nS7MQejsOPp2CjIa59S3eHfcIbulhjDLBNBlsmr/7Rx/bGil8Hr
         AKQ0baQAbwJLQucbSEL1h0QPgOrOx1GpDRV7T6/Vq8mq5gqKic1sL30kwDUr9oAK18Br
         8hcPYxjSaZ3lB681xXRaja46S1mjh8hFOPALHy2CfqT6O2GnurpXqSvh965vj0UHae9v
         UqOw==
X-Forwarded-Encrypted: i=1; AJvYcCV2q73DJNw/3X3s7E/gjYUdUqDxqtJaRpR+gy73Xpp/R8rmsW/livpFztDhS8DyHjnNaZy2iurvBBQ0RA9ZKPaB@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAH4LEIXsWBenO+LLiqm/apkMXsN1By52z4fKBJguP2j2KuAy
	/yQkXk/NSPk3an82dNYeCH7YfbgDh1Sg4piLu6cyxNnnL2MKxn1B22+L8fxP6Xlc2dGNITP/arM
	SrBc=
X-Gm-Gg: ASbGncvp/D5+KTgVhOPgJQoiOiEKkH3Jq37Cro7rSagiDhixUhirlUrsLKN07moRkLK
	8ptmHTnLJT4JDWWXu0gCH27Bjyud+oyOvkZnBkvGZj7A0IYRRgTWf/D0lGV2MC4euK9eUUhbkcS
	mQWK5+nGl0TKy+ELS3efTNDfiLOpz3rrvUOcFrrsi3dSSZWGXAV5ANSNDY+gYaoqZfz0TeqOl9N
	+C/mgE5+YoyaXXhFfJSFe+SITNySFSD3vH48i3/jbEpoG1hekRwMkFhGqjnr6bOUT9GEQZEb8N5
	/IgY2Gr/3pmPzBDP3XipHldt8DAUwb5B2xBuFCeQKcSiwaCpeid5KAZFHsdeyaVLh+qmVxgiO3d
	VIz6x4W6hYuuHq6IW9rfj+KS8Pjt/jpX0dmx0lziKyNUYp5IwZ2Emm4lJhqMCg9ldWcV57SaHtX
	oE
X-Google-Smtp-Source: AGHT+IGUn9RQHUA+UsWh/l47ULycJOukQrvT/u9NAGySWClknwUmotwz2vC3mogtk+AB7Ib6MAruTw==
X-Received: by 2002:a17:90b:3a8b:b0:330:4604:3ab6 with SMTP id 98e67ed59e1d1-3342a2b119emr9410998a91.18.1758920265986;
        Fri, 26 Sep 2025 13:57:45 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3352c6e11d8sm3111990a91.17.2025.09.26.13.57.44
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:57:44 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-269639879c3so25339595ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 13:57:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1mN1Ms9XSU8HGKh5O900cDdjhs1EPu2Mh89CkZ9qatGwlrk+7R+CY/e/o0bEgMfFgBT4R3kY4c/GRpNzTSMrz@vger.kernel.org
X-Received: by 2002:a17:902:c402:b0:25c:d4b6:f119 with SMTP id
 d9443c01a7336-27ed49df307mr105837165ad.12.1758920263386; Fri, 26 Sep 2025
 13:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
In-Reply-To: <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Sep 2025 13:57:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
X-Gm-Features: AS18NWDVMqIM3NdX-t4tF69rrS3UxfWVNc7ZvIbAVZlF3PJHNdBYWzKZ9mUJzVc
Message-ID: <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: yunhui cui <cuiyunhui@bytedance.com>
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

Hi,

On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/cpu_pm.h>
> > >  #include <linux/export.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/nmi.h>
> > >  #include <linux/perf/arm_pmu.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/sched/clock.h>
> > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu *p=
mu, int cpu)
> > >         return per_cpu(hw_events->irq, cpu);
> > >  }
> > >
> > > -bool arm_pmu_irq_is_nmi(void)
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > +bool arch_perf_nmi_is_available(void)
> > >  {
> > >         return has_nmi;
> > >  }
> > > +#endif
> >
> > Should the previous comment move here, AKA:
> >
> > /*
> >  * hardlockup_detector_perf_init() will success even if Pseudo-NMI turn=
s off,
>
> Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe()=
=E2=80=9D
>
> >  * however, the pmu interrupts will act like a normal interrupt instead=
 of
> >  * NMI and the hardlockup detector would be broken.
> > */
> >
> >
> > > +static int __init init_watchdog_freq_notifier(void)
> > > +{
> > > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > > +                                        CPUFREQ_POLICY_NOTIFIER);
> >
> > I think you need to do something to prevent this from happening on any
> > platforms that override hw_nmi_get_sample_period(), right? These
> > cpufreq notifiers will be useless in that case...
>
> I understand this is not a problem. watchdog_perf uses
> PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
> CPU's main frequency. After we make such a change, a larger value may
> be used as the period, so the NMI period will become longer, but this
> value will not change after the system starts.

I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:

u64 hw_nmi_get_sample_period(int watchdog_thresh)
{
  return (u64)(cpu_khz) * 1000 * watchdog_thresh;
}

On PowerPC it's:

u64 hw_nmi_get_sample_period(int watchdog_thresh)
{
  return ppc_proc_freq * watchdog_thresh;
}

Neither of those are necessarily based on the results the cpufreq
reports. ...so therefore I don't think you should be taking the
cpufreq reported numbers and assuming they're OK on x86 and powerpc.

-Doug
