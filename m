Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED52EF654
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Nov 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483360; cv=none; b=dMEN/vJb6RLcAcVNDQnPO7b7lZyjw9eRJa5rw57sVxyWQDhxBAOt7Z+FvbEa6i7FKkSN/KpI3Yxw1d2XWTtHzm9XEkhij7Q3BI8bvr9TliwMUE9/Hjv4MFx3wGNxpebBFTgc76C7eq8C7Bc9I5uQDfcEL5rzwL1zjO+xhxvqVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483360; c=relaxed/simple;
	bh=uYfqsgI+4yKP34dOe9Nf3RalYvhP+CX4KYMz72LP0Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufwdT0Z5HcifLKo4rFCb7srIvezitPQLRzozO9uy4NEf8yfESMiiyHU3MJNAFiDyrelxdPp2WO/oTMMZPha6ZbED8CloIeZ9++l1GA5/TYkdQMEtN8vR+UBxX+6qAHGvCYvVcP5G2eUIIebUyrbf5/i5rSicvCc/93q3qUX5qvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LSQktzlJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LSQktzlJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4491510f005so76081b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762483357; x=1763088157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta4pHybjsRd5oAb5H49GhrRgg2InYaGc8HOWjDuWw8Q=;
        b=LSQktzlJNDOWNxrCj20o34ZHK0ILbhIKUhX1ve58RrWkfT1iCPIP1yBhfvpqOclJRL
         /t8Sf4ZOVzCi4n93EKb2y1H27UKAjXWBt7jrPB1RLGy/Tji2iduu/HCOSMC546s12onR
         paFkysj4nMTJWo3W9bQgnd+bq8w9jnUaFTc9P1PDZaKlvr9+qKsWKGiGXbL4/fzlx+ql
         SG/Ku2QVjnQK2BxWzk+Oeh5n8pIQ/D73vUrZ8LXX5+ucm+nInikhsWTHlLXmWO+bbHW+
         LNj6KssNQV1oFqgeDAqkP3CWx3XYWaEPTN0IKrwr01b1rf+Gx/nyI63KDxpoCECXf6oK
         oUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762483357; x=1763088157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ta4pHybjsRd5oAb5H49GhrRgg2InYaGc8HOWjDuWw8Q=;
        b=Dh/txHnN71NFjmCxoDvrInpoZDZV6nSrmnxq6f0pKMuJltJxt1lRlbe9MLXYA1968U
         U+Z1IVQXuA1KBCV7zcfCcdv6bJl7A1jYyYrgOf22UwrGejOVNRfPgQ0pzhDnPiwkO/zT
         JQG/jBZx3F9oWy2uqpWW601MSlDJ0HQtMgf09jnl+UrF4ZFiH2BG2Nx3krCj4Nwb6Rav
         4or5YlBcAgJH0WUgUyKcYYhJWYLVyiG1/TMz4qL/iY4qtOepqPNgNo02sZSngM1OGV6P
         gmu/+XLylF/wgVGXkUX3Xw/I0kQI+2SHDALxPkrQUod1vqkwSAmWtIlX9yP3BWTQydeF
         NEKw==
X-Forwarded-Encrypted: i=1; AJvYcCXvDD31zPTB/bEIf/NeU7vlTuFiTJFuHc0WoJz1S9nMy6Y4MU13ojbzqFfti9THMDhggXapByWY+Ue5D+I7Bv2b@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnH+meykYhHaS7OXZ2uqMmEEVOuM5b+ja/GFvXXzdasMLH5Uk
	jqU4XdEHzcP+Iwbix6vhcj+/YJsaBtEyHFC3iqoVeBXEWeOwGZY2cbpAgVJrAq/wQGcMY1tmajF
	uGLHX4sblhKJGE+9Uj/B6rvettJGC+C6Nsap6kRuNrhIgAYdomRDAMgFhJg==
X-Gm-Gg: ASbGncu550SqFR0mJzvssGmx5mnHngrfucsQIil6UnY5VUDEunvuLncRnoGS2M4u+4d
	uIgb/MFK78QSu4edoyySCcRDZlLmtYGykTm1uEban7S3Tv8YrFweN7EAyxmockGK6mupXJ5au8E
	3CwQyitzohIWSuS7vxhA5XHyYlNgXUMip2O0AjpwV+t9lfR/RaDwXAlW/VnuDVstRXoluwBplZv
	3WS8N/DlJxZYR6QLNOIl//SIWlbxhNJsAeY6xSg936AJX7arODTdA4Y4sL7kKjTzZp23IzUfL9f
	bAYrP10y
X-Google-Smtp-Source: AGHT+IGb0n2soPVhA9HW3Yi/ug81lmtTpcvsCQ9ShMeI3zEImc6F3+dHOysOTdbZsRZbSPkSfqhccOrjI+KKkLT4UmA=
X-Received: by 2002:a05:6808:f8d:b0:44f:e3d2:59db with SMTP id
 5614622812f47-45015d583cemr1045696b6e.16.1762483357292; Thu, 06 Nov 2025
 18:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
 <20251014031425.93284-2-cuiyunhui@bytedance.com> <aQixsIQXTjYyhRVj@willie-the-truck>
In-Reply-To: <aQixsIQXTjYyhRVj@willie-the-truck>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 7 Nov 2025 10:42:25 +0800
X-Gm-Features: AWmQ_bkNdWjndV3isxnVf7u1V6RwPPlMP2i7v5fPfn_48ruw1DHahvSQ2HKDsok
Message-ID: <CAEEQ3wk5Ru4-=4Ecnc6kQAAbR57806xxYTz0o1z4KfgZE6Cg6w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	dianders@chromium.org, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Mon, Nov 3, 2025 at 9:44=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Oct 14, 2025 at 11:14:24AM +0800, Yunhui Cui wrote:
> > @@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const cha=
r *str)
> >       wd_hw_attr.type =3D PERF_TYPE_RAW;
> >       wd_hw_attr.config =3D config;
> >  }
> > +
> > +#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
> > +/*
> > + * Safe maximum CPU frequency in case a particular platform doesn't im=
plement
> > + * cpufreq driver. Although, architecture doesn't put any restrictions=
 on
> > + * maximum frequency but 5 GHz seems to be safe maximum given the avai=
lable
> > + * CPUs in the market which are clocked much less than 5 GHz. On the o=
ther
> > + * hand, we can't make it much higher as it would lead to a large hard=
-lockup
> > + * detection timeout on parts which are running slower (eg. 1GHz on
> > + * Developerbox) and doesn't possess a cpufreq driver.
> > + */
> > +#define SAFE_MAX_CPU_FREQ    5000000000UL // 5 GHz
> > +__weak u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > +{
> > +     unsigned int cpu =3D smp_processor_id();
> > +     unsigned long max_cpu_freq;
> > +
> > +     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > +     if (!max_cpu_freq)
> > +             max_cpu_freq =3D SAFE_MAX_CPU_FREQ;
> > +
> > +     return (u64)max_cpu_freq * watchdog_thresh;
> > +}
>
> Why does this function become __weak? Neither arm64 nor riscv override
> it afaict.

Would you say there=E2=80=99s any particular issue here? If some architectu=
res
might need to override the hw_nmi_get_sample_period() function later
on, wouldn=E2=80=99t __weak be a more reasonable choice?

>
> Will

Thanks,
Yunhui
