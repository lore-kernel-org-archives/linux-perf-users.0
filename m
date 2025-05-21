Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E35280311
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855207; cv=none; b=QyEGOYSN76agBkF3AInWdC8goVJMfcIOUb4sxZEqU2YJjjWOafc1yOPhm7leBFk1G7RVXyM9R59Djdx6vxRkBNPVN83a1kg0efYpWoaPkTgiU9z3iMEsfRgsWb2l17wdd3NMpfDJAayc7bHCcOOV5VfYK4DndbwMQDPk90SYXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855207; c=relaxed/simple;
	bh=GnB/O/EVmri7y38J/jByIJMb+SeoeRsKY/K6vIHsCKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2s2zaFl/jKXYNmzi/5e2xymXF8pH4AIKh+kXGyzs26IaPhOxgO32D6hc2czwkXkTZoStzSMWwiscy4xsb5XGRDrNnrCkQIwdfT2HJM5ILhdrrzoWVOwxJ+GvBw3iU5/0FIrHEmEUWoRWllNqK/7HZKj8btQVpWYBkhWRbPZ0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+9Yx/HK; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+9Yx/HK"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso145675ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747855205; x=1748460005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH9ep65+iIljq49GwNY241t6DbkwIT/99iko/YlYgi4=;
        b=B+9Yx/HKUh89ktiaXr2A9kMuU9Be+GxdSDzGNhi9EoFPJApW2dbxYfmGSxOfr1Ud1E
         ZVhQ+Zjt/5slJ3859Q02l7OaVY9NMMTmnZtPJostrw8I4vGolNqGRGaRsfUZC0cWmE8o
         nLT6u6rhy8I/E/AdKU7YP4lL6bjd90Jfi5exybqtorRPcpIUX1YisgRU3la8kniM6Lq5
         5wS+ZXVyveNxkKz8w+H/W2P1OHkV5o9PhbOc3eQEmKlc3rG1bM8WU/qrDJdOf1BEqdii
         DvIthJJpLexNKXOmzFNeXbxjunITOy0dHdI3kIn4CBfl6q4kOJErJYNxpmk7DA0a7cQR
         7b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747855205; x=1748460005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RH9ep65+iIljq49GwNY241t6DbkwIT/99iko/YlYgi4=;
        b=Rn4MaUvi2F1IR91LTdbiJyQqhf4iqU9IniBsYv8JU3rKvlBI77yL1ziSFgN1eQ0GTu
         6TFxkmGUvlKHwoYYhf/7/2GH1OPPyBpf06+HUqIdwWxepGSS+micKmH9aDWGrg9HEBdd
         gwpdotiA7jImmCyPDpdtSxWC05647Q2x2XQXcokssc9dlzDDa9SYNnp+Jzf3oJpFiG2Z
         F4y0P0Uw6s4vNVDnhzZmpyyPurLHIKC16usgpFDgXud8cKBMGQkVwn0SJl/fM5q2vgsE
         nKw68h1jgqxXvbK5/mh5IqLMyUU7dy4bIB/Qx0JS18KNno8uyg3GalmS+1F0Ojz7ZFDC
         wDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpWqLYUpKe2E8xnUTuqxYftzU4tRp4zV7Cba51AqVHiGJblLUC0xjfCYl19UTosejLD6Kl7mNvAEuOMLMwJbxE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Xc8dW26S5ZOV65bBvvOAzFWnrSjyTVD/Rlrs4AVCrJ8oe/HD
	SSCi4WbNzwwZWgBG4tG2Zw5IbQdG2jCBSKjtNZVrGhB25OUisERHh5aaLnkXovsQTsElr/ZdT77
	gpi+glpAdoLdmkCyNQH9T0FAHJw2yR+V+c46sKf6n
X-Gm-Gg: ASbGncvNHl3i0RDkE5yyIR6R7SLBA9f6M8w831UaM0ARYT71PO65gq4izBwxcJgeEvF
	+x3/X43s5h4PU/rUnv3P4e9Y4McKEtftvTyxetjqjZpsjA9rz2EOTW5zIfki9nhQlLuht0MPmAJ
	yoh3GGgUGZuYy2ySu+z+KbLTcbbW0/S3N7jqyHc4ZeRiHzAbCI3CnWJICUfdGc5vq32FX8Sk8=
X-Google-Smtp-Source: AGHT+IEdThBAtZZFOyQI8ndZvd6+jvPSbtIqyrmJS1pfB4JA/e7fLaaSpaoPZZQa+W07/lnsfHpHN7t7x36UfN9ThKE=
X-Received: by 2002:a92:c052:0:b0:3dc:8895:4260 with SMTP id
 e9e14a558f8ab-3dc8895434bmr2451035ab.19.1747855204420; Wed, 21 May 2025
 12:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521135500.677508-1-irogers@google.com> <20250521135500.677508-4-irogers@google.com>
 <3e8b674e-38f7-4212-923d-f53626de69f2@linux.intel.com> <CAP-5=fX5q7rDgBdB+cMH6fTyHBBPyiac7tuv9WJOMcg9OFdq5g@mail.gmail.com>
 <9aa2c899-80e0-4626-acb7-5331fbf46a0d@linux.intel.com>
In-Reply-To: <9aa2c899-80e0-4626-acb7-5331fbf46a0d@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 May 2025 12:19:52 -0700
X-Gm-Features: AX0GCFu4PPYG7j8QdsCgxl3Fa-IYTZcsame8vgyYD43SyJeG4LuLy-sh2dDPJAA
Message-ID: <CAP-5=fW4brQZQ-tMDj+N9MnddRVZidi4L5uSw1mvv_9OD_vOSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf sort: Use perf_env to set arch sort keys and header
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 11:14=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2025-05-21 12:16 p.m., Ian Rogers wrote:
> >>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> >>> index 7b6cde87d2af..13ef0d188a96 100644
> >>> --- a/tools/perf/builtin-top.c
> >>> +++ b/tools/perf/builtin-top.c
> >>> @@ -1747,7 +1747,14 @@ int cmd_top(int argc, const char **argv)
> >>>
> >>>       setup_browser(false);
> >>>
> >>> -     if (setup_sorting(top.evlist) < 0) {
> >>> +     top.session =3D perf_session__new(/*data=3D*/NULL, /*tool=3D*/N=
ULL);
> >>> +     if (IS_ERR(top.session)) {
> >>> +             status =3D PTR_ERR(top.session);
> >>> +             top.session =3D NULL;
> >>> +             goto out_delete_evlist;
> >>> +     }
> >>> +
> >>> +     if (setup_sorting(top.evlist, &top.session->header.env) < 0) {
> >> I doubt a valide env can be got in perf_session__new(), since there is
> >> no perf.data in perf top.
> >> Maybe just need to invoke the perf_env__raw_arch() instead to fill the
> >> env->arch.
> > I think the current code is making things harder than it should be, we
> > should work away from perf_env__arch and strings, instead using EM_
> > values which we can default to EM_HOST avoiding any runtime costs.
> > Looking at perf_env__arch:
> > ```
> > const char *perf_env__arch(struct perf_env *env)
> > {
> >         char *arch_name;
> >
> >         if (!env || !env->arch) { /* Assume local operation */
> >                 static struct utsname uts =3D { .machine[0] =3D '\0', }=
;
> >                 if (uts.machine[0] =3D=3D '\0' && uname(&uts) < 0)
> >                         return NULL;
> >                 arch_name =3D uts.machine;
> >         } else
> >                 arch_name =3D env->arch;
> >
> >         return normalize_arch(arch_name);
> > }
> > ```
> > in this case env->arch =3D=3D NULL and so the uname machine will be use=
d.
> > For perf_env__raw_arch the behavior is similar but it populates the
> > env:
> > ```
> > static int perf_env__read_arch(struct perf_env *env)
> > {
> >         struct utsname uts;
> >
> >         if (env->arch)
> >                 return 0;
> >
> >         if (!uname(&uts))
> >                 env->arch =3D strdup(uts.machine);
> >
> >         return env->arch ? 0 : -ENOMEM;
> > }
> >
> > const char *perf_env__raw_arch(struct perf_env *env)
> > {
> >         return env && !perf_env__read_arch(env) ? env->arch : "unknown"=
;
> > }
> > ```
> > Aside from caching the arch, the main difference is that
> > normalize_arch isn't called. Not having normalize_arch means the code
> > in arch_support_sort_key and arch_perf_header_entry would need to
> > handle strings "ppc" as well as "powerpc", "i386" as well as "x86",
> > etc. As I'd prefer not handle all those cases I think the way the code
> > is is best given how the env code is currently structured.
>
> Right. The perf_env__raw_arch() doesn't improve anything.
> But I still don't like &top.session->header.env.
> Because I don't think you can get any useful information from
> top.session->header.env. It just brings confusions. (It seems an env is
> retrieved, but it is actually not.)

Well there's a certain consistency in using the session env to set up
the sorting, etc. This pre-exists this change with nearly every
builtin-* file doing `symbol__init(&session->header.env);`. perf top
does `symbol__init(NULL);`:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-top.c?h=3Dperf-tools-next#n1811
but the code now has lazy initialization patterns and handling NULL as
a special case of meaning host machine:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/symbol.c?h=3Dperf-tools-next#n2350

> In the perf top, &perf_env is used for the existing cases. If any env
> fields are not available, perf_env__read_XXX() is invoked to get the
> information.
> I think we may follow the existing usage, e.g.,
> setup_sorting(top.evlist, &perf_env).

So using the global perf_env rather than NULL feels preferable but I
think the global perf_env should be deleted. Whenever I see the global
perf_env in use I think the code has a bug as the perf_env should be
coming from the session or the machine. The global perf_env can have
no meaning for cases like `perf diff` where more than one
file/header/env is open at a time. The global perf_env variable's
existence encourages bad or broken code, so deleting it should avoid
errors in code. Another place these issues can occur is with TPEBS
where we're maintaining multiple sessions for sampling alongside
counting.

> Alternatively, it looks like the perf top doesn't support --weight. The
> env->arch should never be used. If so, a NULL can be used as well, E.g.,
> setup_sorting(top.evlist, NULL).

So I don't like NULL because then we have lazy initialization of host
data and NULL meaning use host. I don't like the global perf_env
variable as it has a code smell about it. I think moving the session
initialization earlier in perf top so its env, although unpopulated,
can be used is consistent with `perf report` - this is consistent with
`perf top` being `perf record` glued together with `perf report`. So I
think the change here is the smallest and most sensible.

Longer term let's delete the global perf_env variable,  perf_env__arch
should be switched to a perf_env__e_machine as then we can avoid uname
calls just to determine the machine architecture, etc.

Thanks,
Ian

> Thanks,
> Kan
>
