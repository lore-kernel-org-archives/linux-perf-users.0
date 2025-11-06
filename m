Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D22D8764
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454617; cv=none; b=cmA4o2l1rV2hKa4x+rjCgCGL9aXNiBH5BamcyYE9fy2tjh1c1aMi9xJRuv/Z98OjX5ylqot4WoIcySIVJxQ+JT9gdm/Htkwi8IpUK8k41icPKBk9JY1Os/m/2fSPBksStriwVz/DwUtixw26S8aC/40jc9DwpiS7fL3gQmUlrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454617; c=relaxed/simple;
	bh=Xgezs5FSuKUDxWZkIg/JG0XAvfAssZlpTqZgQYOOjtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp2xCG8TFllf8KQR8BLDDzC/7FkDgT21zVsi3EAUJabZbD4slC3pZ97qpkrmqSE+ua+fFm+jmbtSDrOBi2ADnezQ/jgZTOh/MxGx+BqxfTcaUheEpiyhCK+K7C5ox4oIuMjTtKvV4MoTWSRyVuD2IPM7Y/lMQbqfGJ9MMuXz6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i35KC73V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i35KC73V"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294f3105435so13685ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 10:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762454615; x=1763059415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx3k3kEep1Osi8t9YC8biS3Xn+GMlwzxfXdy+eSJ/tw=;
        b=i35KC73VPrU1iUCJP2VhlkFnSui4Qny00LhJCO5H6jzbxw+PaBbt/QF1Ig1+aKwmdi
         P6mpRtrDpHKks0+qCDc2xm9zQiwLS8V6uS6ncT1AH6TUpPBHrnaW4LiBy5ruhtrDzJHj
         QFzSO4LtjVeQYYSHjzHr4EpXQDOEdMvp/n9HOUMdD2if0WIJCh21sIDssBrcX7tloeas
         4POU5gERedBmZS1YkVaCnfk3ee4TwoO3xLBRwI5rtJptNtnF4j/kH+EjEEzu+NsUrmvN
         DV0vt+cBorylm7jkYePor4IC4D+hfg+Ee0kWDyB/OxFcJr8l2N/R7YnF8CG93/sUtzrQ
         hSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454615; x=1763059415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kx3k3kEep1Osi8t9YC8biS3Xn+GMlwzxfXdy+eSJ/tw=;
        b=npKrKvYM78HLk6gpLkO9nBL1cgxvB+guTdj099yHAIXrCi1EpBjwKbuIT+neX9pmPh
         7n3Ya8DD90ye0d2/mkV9a0B12G9wjAIpasMcByPiBrwIvjlLTWgVdHCt9JThS/5OrK7F
         QNN/UXMh0rdNKebDX3hxHwPAR78dzfX/qFhnQc2LLAUNVGY4IfEtGvJRhCFEQuVwqgDj
         c9uefVaGX6D1QMgk0j2qe+RqKkDpye7/151nHLfyyrdT6BolfTPar3mMagyyem/jRX0X
         bzQlhn+vsefJBBSvI2YslcUszr1uX7pQhfvvSUtJCxlO6W84b//ZuL2PB6G9OjofhJDh
         g1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH0UwyZfNd2Qpx++DmUwP5wTF137Pr4x3FyRAE2NVpJFQuIWdOR/GWbAXf/GJQ0619N5i8w6FQ/QGDCuD1kSqc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3zeaaOCrr20i/1aZHyx/wQVUy8woflw6ClmmAKnPJGSf5L8v
	rj4O6GCmnun3IcxXHhZitIUs0Q35X/VreIrtwt+KbJ/8Er7AiiMZ5dw87n1jwoYY7l5t0d44eE/
	9xhAE8vJqram7dxQda/eAJ/Hq3KRbtEvos69p/37q
X-Gm-Gg: ASbGnctfDqZ0Hbhlb1WMmm0YCubDCFp0gpknq80x9ip0eWgS0H23RXom1fmGvfAaPEi
	rfBerb6+4Ro0rEN32Fg2sngphPzoYbt3XyR1MIFxmXgEW5hluGy6HwoI7C23sCmBxFHHpwa2Nzq
	IQ3WYjDVyQ0bbK2d1mJeXVRHxTNJsjNygjwu4+HpppZClAjV3U41BSkUSgSP7Vw8rKB+zA5KHjD
	uDVh+hEbaL4FxDtHfP+hSIHFMNe/pyoVzT+YypQkN5Zc/WOXkuITo+CfnmDauslctwOx6F6Wz+5
	A2IH/hwxj+bLXYwJX2/FRqQepg==
X-Google-Smtp-Source: AGHT+IF595yXHj1R0vJCF+feMalPWNtb+trAUjO98C5efGBIfaeJjOXXPVeNB7Rs+09OqW76Or/uYcg+9ZG9bBRA+RU=
X-Received: by 2002:a17:902:db07:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-297c23c3639mr176895ad.6.1762454615057; Thu, 06 Nov 2025
 10:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <20251024175857.808401-8-irogers@google.com>
 <aQmHfya8SYIcVGcg@google.com>
In-Reply-To: <aQmHfya8SYIcVGcg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Nov 2025 10:43:24 -0800
X-Gm-Features: AWmQ_blYBvvVj5PROyLrN85lROrsLampVhlxTAN2qAyCgPP2Nlsws--HlUu63tU
Message-ID: <CAP-5=fUcCjDpu3=FNkiayZG7gpTzo9VLnEO-YM_b=GPwdDeLbw@mail.gmail.com>
Subject: Re: [PATCH v1 07/22] perf expr: Add #target_cpu literal
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Oct 24, 2025 at 10:58:42AM -0700, Ian Rogers wrote:
> > For CPU nanoseconds a lot of the stat-shadow metrics use either
> > task-clock or cpu-clock, the latter being used when
> > target__has_cpu. Add a #target_cpu literal so that json metrics can
> > perform the same test.
>
> Do we have documentation for the literals and metric expressions in
> general?  I think it's getting complex and we should provide one.

So in general all these are documented in the tools events in `perf list`:
```
$ perf list
...
tool:
  duration_time
       [Wall clock interval time in nanoseconds. Unit: tool]
  has_pmem
       [1 if persistent memory installed otherwise 0. Unit: tool]
  num_cores
       [Number of cores. A core consists of 1 or more thread,with each
thread being associated
        with a logical Linux CPU. Unit: tool]
  num_cpus
       [Number of logical Linux CPUs. There may be multiple such CPUs
on a core. Unit: tool]
  num_cpus_online
       [Number of online logical Linux CPUs. There may be multiple
such CPUs on a core. Unit: tool]
  num_dies
       [Number of dies. Each die has 1 or more cores. Unit: tool]
  num_packages
       [Number of packages. Each package has 1 or more die. Unit: tool]
  smt_on
       [1 if simultaneous multithreading (aka hyperthreading) is
enable otherwise 0. Unit: tool]
  system_time
       [System/kernel time in nanoseconds. Unit: tool]
  system_tsc_freq
       [The amount a Time Stamp Counter (TSC) increases per second. Unit: t=
ool]
  user_time
       [User (non-kernel) time in nanoseconds. Unit: tool]
```

We haven't done that with #core_wide and I followed that pattern for
#target_cpu as they do similar things. The issue with these two
"literals", why they are hard to be tool events, is that they depend
on command line options that may be processed after the processing of
the metrics. We could make tool versions with some plumbing. I'll look
to add that.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 7fda0ff89c16..4df56f2b283d 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const=
 struct expr_scanner_ctx *ctx
> >       } else if (!strcmp("#core_wide", literal)) {
> >               result =3D core_wide(ctx->system_wide, ctx->user_requeste=
d_cpu_list)
> >                       ? 1.0 : 0.0;
> > +     } else if (!strcmp("#target_cpu", literal)) {
> > +             result =3D (ctx->system_wide || ctx->user_requested_cpu_l=
ist)
> > +                     ? 1.0 : 0.0;
> >       } else {
> >               pr_err("Unrecognized literal '%s'", literal);
> >       }
> > --
> > 2.51.1.821.gb6fe4d2222-goog
> >
