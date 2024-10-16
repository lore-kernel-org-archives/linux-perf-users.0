Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF621E3BA
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054095; cv=none; b=Pon0x7iIcdHvN71o+fHLsrHPSvgHDr6s9cIOwSE9yly/szx/xQbkIunB7eIfot7eLz57uAUAT6rfbTH+nuG2yintWaX64AbyWqJAd/jgbDVv0GxS2qGqFxdvMvSiV+654OOwTKDko66r64OwfBqrXE33Y0Hy4I0tKvRJ8c9Dw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054095; c=relaxed/simple;
	bh=LgvQ+ExvLCEmGIz7x4GNwy6YjG+peJDwsn05tUBgJ/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8v2WWbB1cYbRuIhPSsXDbHtlTxpOqV3YTv31EnVhhf5zCoWtdhwXgQT+/i03mEB9w0E2kO5Ak1viIK9RFUfEd2XDEsfqVRy/FKPeYagXyD8HgVrWUAsl5hSEmAm2hGHF6ntFwhobH37bBTMQ9BnY3Sc8+By0j2vZ1NsZHR/bdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hJiX6Hp; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hJiX6Hp"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso94995ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729054093; x=1729658893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx8GkNgend+QdUDnatzxx5RDCynf3CQQIso1XU0+dk0=;
        b=3hJiX6HpKfFxHxHuiVWKl0NrBE1d7mGbPpKKjz7btQGw+AIH4ZmSzQLiTixxws1m3d
         ooUPSPfA/91eFP0V8KkeJJ+et+g/CjnNmnkP+Q4KhTIsfS0jawRAwaxRVhUGjVq0hdX9
         WaE1lZcb7VjjpQzgeWfBQ8bKwrhTL2fjosJSRTwO15t80039giq++G/RIS6LoMa9rRmp
         yQirq11wi2qBC/WP1fbIvi2f/Y1q1+ekrrp+eUZca2Uh2z5vIvwIFJd1AtF9MAszdxjK
         EW7dXQtPENrwnbq4ckO4sdEeX0QiLyuANcHmqYibkG1jwxP4oS6aJbhjTcngCAydqgx5
         yZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729054093; x=1729658893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx8GkNgend+QdUDnatzxx5RDCynf3CQQIso1XU0+dk0=;
        b=FouGlbNqMg0pJzHk12lM7utkZsUyl6zs+P/3EQ8GXRXolWZZnWlZt0O7gRqbS/2q4u
         fCSqyP+VzjdicZxOntNLuZF+2ffCqORV6g4jT/BSBzk5cTMc+iz4/78cIgOQ3cm+4MBP
         2J/clCxQ/75v7KfV1dh/+6jQTLKaK+CD5x31ACQFDQU35OAyD9FJnXRhRKPeBzOT1/NG
         Ebbe/CTa069oFcESDXf92jqXCUxYeoRNvH1SOF5uWeLUD2Nd5qar5UwfYLsbhZfqkCUu
         zXEDX4FyXeKxAfygspQb7upORc4fshK2Japg5V1wTOxEwmxbkMBwHzZL/hhE/e/cT6Dw
         pG9g==
X-Forwarded-Encrypted: i=1; AJvYcCXpw57w87gzyAMrkRWE86p7LCdEnM7XNjln2TlzgwmYEdhvgNlvnj1Ve5HbdAr1bs7OcufiPDfpwRwB4aARDP8S@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+bGj/9hmD0WC4QMqxkLqloHt93iAHz0Ar6mJ6av2o0x+2Mm2
	yrwqA64mNNOcFYkRS65Ki2I25Kb+Lt7scIgtme5knKQ1Ff9aWV+q6YkRPygzuArMeMUMSs+izEM
	p+xkjDRFdIFaT4vpC3+ENr2IVtu8dJwTXJAk0
X-Google-Smtp-Source: AGHT+IFGq9cDLuk2K6rzTc5+nkLft8e5kyKFW3QJ1RajyCmMHKTaR8s1wa0XBOXMlPIWQv+ZFl9QvPVNq/RkJC1MYeI=
X-Received: by 2002:a05:6e02:1528:b0:3a3:b07b:6d3 with SMTP id
 e9e14a558f8ab-3a3de7bc485mr1525755ab.9.1729054092764; Tue, 15 Oct 2024
 21:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com> <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
 <Zv7O_XJZcSIS9I_i@google.com> <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>
 <Zv8cyZN1p7EI08XA@google.com> <Zw1vcnX-HdnmJMU1@google.com>
In-Reply-To: <Zw1vcnX-HdnmJMU1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Oct 2024 21:47:59 -0700
Message-ID: <CAP-5=fVFNRxrO_MXEA=UV5jLuBHsK6M3W_cWrBgAbqQPQwuErA@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Thu, Oct 03, 2024 at 03:38:01PM -0700, Namhyung Kim wrote:
> > On Thu, Oct 03, 2024 at 10:32:47AM -0700, Ian Rogers wrote:
> > > On Thu, Oct 3, 2024 at 10:06=E2=80=AFAM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > On Tue, Oct 01, 2024 at 03:21:50PM -0700, Ian Rogers wrote:
> > > > > On Tue, Oct 1, 2024 at 2:36=E2=80=AFPM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > > >
> > > > > > On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> > > > > > > On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyun=
g@kernel.org> wrote:
> > > > > > > >
> > > > > > > > The perf_event_open might fail due to various reasons, so b=
lindly
> > > > > > > > reducing precise_ip level might not be the best way to deal=
 with it.
> > > > > > > >
> > > > > > > > It seems the kernel return -EOPNOTSUPP when PMU doesn't sup=
port the
> > > > > > > > given precise level.  Let's try again with the correct erro=
r code.
> > > > > > > >
> > > > > > > > This caused a problem on AMD, as it stops on precise_ip of =
2 for IBS but
> > > > > > > > user events with exclude_kernel=3D1 cannot make progress.  =
Let's add the
> > > > > > > > evsel__handle_error_quirks() to this case specially.  I pla=
n to work on
> > > > > > > > the kernel side to improve this situation but it'd still ne=
ed some
> > > > > > > > special handling for IBS.
> > > > > > > >
> > > > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > > > ---
> > > > > > > >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> > > > > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evse=
l.c
> > > > > > > > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > > > > > > > --- a/tools/perf/util/evsel.c
> > > > > > > > +++ b/tools/perf/util/evsel.c
> > > > > > > > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_fe=
atures(struct evsel *evsel)
> > > > > > > >         return false;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static bool evsel__handle_error_quirks(struct evsel *evsel=
, int error)
> > > > > > > > +{
> > > > > > > > +       /* AMD IBS doesn't support exclude_kernel, forward =
it to core PMU */
> > > > > > >
> > > > > > > Should the quirk handling be specific to evsels with the IBS =
PMU given
> > > > > > > the comment above? ie this is a PMU specific workaround rathe=
r than an
> > > > > > > AMD specific workaround, however, the PMU only exists on AMD =
:-)
> > > > > > >
> > > > > > > > +       if (error =3D=3D -EINVAL && evsel->precise_max && e=
vsel->core.attr.precise_ip &&
> > > > > > > > +           evsel->core.attr.exclude_kernel && x86__is_amd_=
cpu()) {
> > > > > > >
> > > > > > > So here rather than x86__is_amd_cpu it would be
> > > > > > > !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner =
to move
> > > > > > > the logic into pmu.c.
> > > > > >
> > > > > > I guess the problem is that AMD driver does implicit forwarding=
 to IBS
> > > > > > if the legacy hardware events have precise_ip.  So it might hav=
e just
> > > > > > core pmu (or no pmu) in the evsel.
> > > > >
> > > > > I think the no PMU case should probably have a PMU possibly simil=
ar to
> > > > > the tool PMU in:
> > > > > https://lore.kernel.org/all/20240912190341.919229-1-irogers@googl=
e.com/
> > > > > But that's not in place yet. You can always use
> > > > > perf_pmus__scan_core(NULL) or
> > > > > perf_pmus__find_by_type(evsel->core.attr.type or PERF_TYPE_RAW).
> > > > > evsel->pmu->is_core && x86__is_amd_cpu() would identify an AMD co=
re
> > > > > PMU whereas the code above could fire for IBS or other PMUs.
> > > >
> > > > But IBS is the only PMU on AMD that provides precise_ip IIRC.  So I
> > > > don't think other events would have it nor have any effect on chang=
ing
> > > > the value.  So maybe we can skip the PMU scanning and just drop to =
0?
> > >
> > > cpu supports precise_ip as it forwards it to IBS, IBS is an ambiguous
> > > term as there are ibs_op and ibs_fetch PMUs. The code is using values
> > > in the attribute to infer the PMU that is being used, it feels it
> > > would be more intention revealing to do things like:
> > > ```
> > > if (error =3D=3D ... && perf_pmu__is_ibs_op_or_fetch(evsel->pmu)) ..
> > > ```
> >
> > I guess it'd get a core PMU for the default cycles event.  I think the
> > intention is already confusing with the implicit forwarding.
>
> What about this?
>
> ---8<---
>
> From 70d39fb5c2956ba264a292f112f7fd7272dc91be Mon Sep 17 00:00:00 2001
> From: Namhyung Kim <namhyung@kernel.org>
> Date: Tue, 3 Sep 2024 22:50:09 -0700
> Subject: [PATCH] perf tools: Check fallback error and order
>
> The perf_event_open might fail due to various reasons, so blindly
> reducing precise_ip level might not be the best way to deal with it.
>
> It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> given precise level.  Let's try again with the correct error code.
>
> This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
> user events with exclude_kernel=3D1 cannot make progress.  Let's add the
> evsel__handle_error_quirks() to this case specially.  I plan to work on
> the kernel side to improve this situation but it'd still need some
> special handling for IBS.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 50 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 476658143822c346..2c45c55222c43dd4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2246,6 +2246,43 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel)
>         return false;
>  }
>
> +/*
> + * AMD core PMU forwards some events with precise_ip to IBS implicitly.
> + * This logic matches to the kernel function (core_pmu_ibs_config).
> + */
> +static bool evsel__is_implicit_ibs_event(struct evsel *evsel)
> +{
> +       if (evsel->core.attr.precise_ip =3D=3D 0 || !x86__is_amd_cpu())
> +               return false;
> +
> +       if (evsel->core.attr.type =3D=3D PERF_TYPE_HARDWARE &&
> +           evsel->core.attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES)
> +               return true;

Lgtm, still seems strange we're not asserting something like
evsel->is_pmu_core. There's some clean up of that in (unmerged):
https://lore.kernel.org/lkml/20240918220133.102964-3-irogers@google.com/#t

Thanks,
Ian

> +
> +       if (evsel->core.attr.type =3D=3D PERF_TYPE_RAW &&
> +           (evsel->core.attr.config =3D=3D 0x76 || evsel->core.attr.conf=
ig =3D=3D 0xc1))
> +               return true;
> +
> +       return false;
> +}
> +
> +static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> +{
> +       /*
> +        * AMD IBS doesn't support exclude_kernel, forward it back to the=
 core
> +        * PMU by clearing precise_ip only if it's from precise_max (:P).
> +        */
> +       if (error =3D=3D -EINVAL && evsel__is_implicit_ibs_event(evsel) &=
&
> +           evsel->core.attr.exclude_kernel && evsel->precise_max) {
> +               evsel->core.attr.precise_ip =3D 0;
> +               pr_debug2_peo("removing precise_ip on AMD\n");
> +               display_attr(&evsel->core.attr);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpu=
s,
>                 struct perf_thread_map *threads,
>                 int start_cpu_map_idx, int end_cpu_map_idx)
> @@ -2366,9 +2403,6 @@ static int evsel__open_cpu(struct evsel *evsel, str=
uct perf_cpu_map *cpus,
>         return 0;
>
>  try_fallback:
> -       if (evsel__precise_ip_fallback(evsel))
> -               goto retry_open;
> -
>         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
>                                          idx, threads, thread, err)) {
>                 /* We just removed 1 thread, so lower the upper nthreads =
limit. */
> @@ -2385,11 +2419,15 @@ static int evsel__open_cpu(struct evsel *evsel, s=
truct perf_cpu_map *cpus,
>         if (err =3D=3D -EMFILE && rlimit__increase_nofile(&set_rlimit))
>                 goto retry_open;
>
> -       if (err !=3D -EINVAL || idx > 0 || thread > 0)
> -               goto out_close;
> +       if (err =3D=3D -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> +               goto retry_open;
>
> -       if (evsel__detect_missing_features(evsel))
> +       if (err =3D=3D -EINVAL && evsel__detect_missing_features(evsel))
>                 goto fallback_missing_features;
> +
> +       if (evsel__handle_error_quirks(evsel, err))
> +               goto retry_open;
> +
>  out_close:
>         if (err)
>                 threads->err_thread =3D thread;
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
