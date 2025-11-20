Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E002AE68
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619601; cv=none; b=FKFgREsD/XjTd9MXX0Ryw8Y3jrfUXeR+4FvIg105/IIUm4y52KkOsxBkbQyA/uM/kr88Tq/7frXe40QLM9HnhrScIwKOQNQsfcOfc/e/V6ga5xnR12OB6k14+NZJYNb8rSi1zZctaRYKhuFCXrmX8hUJHQBYgiLGSQnNLz6L8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619601; c=relaxed/simple;
	bh=v4/QNHf5y9qehcrp9ZW1OQ3Qmou9xbBgq+qdM9gXKAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTISjU0SElubIy94SFLZjwEHw7rFXzJFWXUCRDbSEsbuX2+UgtdVfOD9eIEPdNUPmw0nR3PWmj9R8L1fLx6Gnx4qTPgOPVMF3632sZADCAuLgl0qvq+aPwwL5vWLOWqwksF4da22jj9TmJ3LvQq4m1MKppzPqAEoQxt3UzkSRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3pyBtNW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3pyBtNW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980343d9d1so86525ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 22:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763619599; x=1764224399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQbqlneP0k94xfCsp7Dp2s/aFM70DtqH0k+Oufc2748=;
        b=v3pyBtNWWgUAfUWt9ZKpsarvBGtrE5SQH8xDSHYDsmKkyHnUglQQHA/imdekgWup95
         MKxCr8OhtdTZYy+q3gQE8ayg5cdRUrmZ/swW+2DnSSqGfBtGA9RYnop/GtNDNLKsMEhW
         Q0Xv9gmwuTCfzJ2tDdU+TmFQNKDWnZZAp7890+kTJA7D9QWA0KlFc6NWok/QPPPX90mC
         L9p+Bdo5MilY1g5jYQvODGdzk3UPexn1D9pN+D0sc+yeMSQvOOuljvyEIt0qSScj7iaA
         g20cUctyr05XcMn4iaKTb2MVRjKgmLxivWoTAqpPamkCOeSzDlDyAEctg4h51H5nunsi
         lM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763619599; x=1764224399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQbqlneP0k94xfCsp7Dp2s/aFM70DtqH0k+Oufc2748=;
        b=dp5GwDRkLixkLdDeLWiu8hMQDB4DCqcb4iiTzp4hr8CiXbOAUUkex8NrY18+UvuCVp
         yjteyXnqJmXUxFP/xwBE4H/kD5QUK0XxKuedtcEYdD7L8Nl39eebfLa7xFLLtSAnvVNR
         DNDpiSDmYaS7O4TmEc13SmDTT0gOYJ087I8T3piyp9Iarexa0Nwgf+LH19dCXTpr50RL
         9tjTi/vunCqbTHEruQrNAjANG3CLNFnN08qogWJ2oz3uBItrqMfcfRp5Yg0Fi8CZaBWJ
         kSFng3TyULs9G64yQj0V8Ad97LTQO5zxhP15jiVw1ZHHxwJa60Ce2v8Q9k/TyCkIem8J
         81JA==
X-Forwarded-Encrypted: i=1; AJvYcCXPGHZhfa68e2iINUSbZ1sD9O4Ge5KN/7JkvneJPD6Whx9QLDcjcZAC/1mzsoE497bhKVu3KxCOpG+zeVR14lXv@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtP+leTbZHmVBvOonjb6tQ59A9KeCby07923Q01WecMrk8hiA
	qW/xFrIvWsf9vQHjFOEmhvz4fbg9JAFIG8zXHYhv0Ny+Gwgt7wMBNQ8nuJIXeqMeOBDCM6K7S78
	iNiPShF3jtzVWBkBgTRn8vreErLETGgPgKmkwZF6Y
X-Gm-Gg: ASbGncuTvxjWBv00DVtR/pxdJBtJCT3wKM5tBUie06m9S3fn8h821YaV/bj8HdTl157
	Wijt5GBU7CsDBY/+IYwAy/z2x6tgqyS9aTuQZnQbJbe4t6zO8JwNy5INMkFoMhkJQkrlinzRc28
	y4jYWf925CyHp9EHWELZ8AN1/G6SxERUHixR1FSo1YbpUEOJjCO/ShNPzAXLRyOq3764D3Tw0v/
	TOBLLcBzP44uan3mpuzazsO3PNHqUylJeGneeXr0LwLtKEtQEEVbpabxcRZqSmRdtZWNgDM
X-Google-Smtp-Source: AGHT+IEIswPfK3DzmAKM+co/T5twbAI+gC+NxulP6Sj+0yYNqpPtfFvoVIG6/9Gnhh8Uj3uHUwlg6HdLchnuuRvxfWM=
X-Received: by 2002:a17:903:11c7:b0:295:28a4:f0f5 with SMTP id
 d9443c01a7336-29b5dc03c51mr1308115ad.5.1763619598805; Wed, 19 Nov 2025
 22:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com> <20251120053431.491677-7-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251120053431.491677-7-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 22:19:47 -0800
X-Gm-Features: AWmQ_bkI4A3mEQtAkRR1ujkt4bIRsTNW1Nqt--Nm_J9W5uqVMwAGQhGc3rxlao0
Message-ID: <CAP-5=fWOhG8XJwcyT1tYtVhLxp0m2kWG1oSeX6gKOmyJ=kOSpA@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf/x86: Replace magic numbers with macros for attr_rdpmc
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 9:37=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Use macros to replace these attr_rdpmc magic numbers, so users are easy
> to know their meaning.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

I'm reminded that we were having issues with rdpmc on hybrid:
https://lore.kernel.org/lkml/20250614004528.1652860-1-irogers@google.com/
like the enable/disable rdpmc flag being shared across the cpu_core
and cpu_atom PMUs, and needing to force the thread doing the rdpmc to
have affinity matching the CPUs of the PMU it is reading from, as
otherwise things like struct perf_event_mmap_page's index could do
interesting things:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n208
Others required the rdpmc to be in a restartable sequence and Peter
proposed fixing this in the kernel:
https://lore.kernel.org/linux-perf-users/20250618084522.GE1613376@noisy.pro=
gramming.kicks-ass.net/

Also looks like we never merged fixing the documentation:
https://lore.kernel.org/lkml/20220817174909.877139-1-irogers@google.com/

Not specifically a DMR issue but this is reminding me of a bunch of
tech debt - I also wonder if this patch requires the test being
updated.

Thanks,
Ian

> ---
>  arch/x86/events/core.c       | 7 ++++---
>  arch/x86/events/intel/p6.c   | 2 +-
>  arch/x86/events/perf_event.h | 7 +++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5d0d5e466c62..3d9cc1d7fcfa 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2129,7 +2129,8 @@ static int __init init_hw_perf_events(void)
>
>         pr_cont("%s PMU driver.\n", x86_pmu.name);
>
> -       x86_pmu.attr_rdpmc =3D 1; /* enable userspace RDPMC usage by defa=
ult */
> +       /* enable userspace RDPMC usage by default */
> +       x86_pmu.attr_rdpmc =3D X86_USER_RDPMC_CONDITIONAL_ENABLE;
>
>         for (quirk =3D x86_pmu.quirks; quirk; quirk =3D quirk->next)
>                 quirk->func();
> @@ -2609,12 +2610,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev=
,
>                  */
>                 if (val =3D=3D 0)
>                         static_branch_inc(&rdpmc_never_available_key);
> -               else if (x86_pmu.attr_rdpmc =3D=3D 0)
> +               else if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_NEVER_E=
NABLE)
>                         static_branch_dec(&rdpmc_never_available_key);
>
>                 if (val =3D=3D 2)
>                         static_branch_inc(&rdpmc_always_available_key);
> -               else if (x86_pmu.attr_rdpmc =3D=3D 2)
> +               else if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_=
ENABLE)
>                         static_branch_dec(&rdpmc_always_available_key);
>
>                 on_each_cpu(cr4_update_pce, NULL, 1);
> diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
> index 6e41de355bd8..fb991e0ac614 100644
> --- a/arch/x86/events/intel/p6.c
> +++ b/arch/x86/events/intel/p6.c
> @@ -243,7 +243,7 @@ static __init void p6_pmu_rdpmc_quirk(void)
>                  */
>                 pr_warn("Userspace RDPMC support disabled due to a CPU er=
ratum\n");
>                 x86_pmu.attr_rdpmc_broken =3D 1;
> -               x86_pmu.attr_rdpmc =3D 0;
> +               x86_pmu.attr_rdpmc =3D X86_USER_RDPMC_NEVER_ENABLE;
>         }
>  }
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index f7caabc5d487..24a81d2916e9 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -187,6 +187,13 @@ struct amd_nb {
>          (1ULL << PERF_REG_X86_R14)   | \
>          (1ULL << PERF_REG_X86_R15))
>
> +/* user space rdpmc control values */
> +enum {
> +       X86_USER_RDPMC_NEVER_ENABLE             =3D 0,
> +       X86_USER_RDPMC_CONDITIONAL_ENABLE       =3D 1,
> +       X86_USER_RDPMC_ALWAYS_ENABLE            =3D 2,
> +};
> +
>  /*
>   * Per register state.
>   */
> --
> 2.34.1
>
