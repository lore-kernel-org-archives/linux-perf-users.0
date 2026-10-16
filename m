Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18052AD35
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166492; cv=pass; b=LeTIO8Bg/SaTTe9I3QO/0d197b4I4ZHLDTxIwpYm0Zzflr/TcSe+c+hXmUty207yTu5DM2YxZ9kEVfH/Bxbtf1DjSqSDC7WxpO0sX+MQ21VLTHNxB+uSn9c6PKpJCDWuXyPOd/DSSGI/eqI7AtQ4zV1V21q/cXvfa/kpxTUrVaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166492; c=relaxed/simple;
	bh=su3x38WF9ESfHlQ2lu0nGc+WmoW5v/5KjcpGwujr9M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EplS9g1/Jm/TFI5O3sdZVIUGlOlhVH06+h0wQcBSaNaF20Ng0fO86J8/zyi2HT4qL2y63TC/9lX1H5DPw4jBJRyU5MB5Mqj9Ht9J+BSXjB1RPZlG/Jr309pFPX4mGHvjFTzSBbq3bUaVgOXRbLgFH+MNF+w4m0fMSo/dUvbQnuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyByFIaB; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyByFIaB"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-150ef97e790so9651c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 09:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166490; cv=none;
        d=google.com; s=arc-20260327;
        b=KeCST29krdTAP/XdyDL5p/MHhfpep/mLT+mjo+OQXp0dMTQxYMBjIgPXkIRldJ0kcS
         HHy0UFzVS6N7C59Vc/s1L6lARZTa9v13ppWJ5Fmqkv8w0udeA/TeA8dfQWVps84b5Pf9
         nbPkw4NXgbZcIQ1zDKhGkBoYKfDdyZjDct0zTMcVzL4iXoH6cnXIK0FxuaQnaxoS2uh4
         ZfVhW0ZeN8gX3BxfPaGaMmmAJMsyGRSzoNO21ueHV5blmgNBSltPga8ext6f8yCPJChO
         2QDZYhF7O6LeEoZYe/0f2oWckZrEWYs8GRLiSitx+QCLxW0EVDFWUiAiOMRyjFOoRi2Z
         3b8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=omjJiHG4DMcEiTl3Shd+1lm1YosdvYSAbHcTPN1mW38=;
        fh=pyPYFGJxcs2lPEft2crAlKyS0GzhJbh7tsMM79i10UY=;
        b=ahwhFw+i9I0BY5yGS2wGVAsynIJxAQCpavsa3LkzDTHQYENWV0IuFgQXG7EGCJ460V
         QsNfDE6E5kib3MSHyy4SUF6rmGUPn9uXNPkaQaPe2LnMo5cuIQaR1UbeYcbEw9L0IzMl
         aBZhaU7l0IkIxhcs8tauvXR7ft18yUm9TS/bJtBJQdWiK2joWZDABnLKw6HJB40Dkvtw
         +ebJi4zjj70+Nmh+57i0Z+oQdBrJoFMEYRSmQUvxQLCz8T67PGEvTzNM3CArwDXJJrv3
         hMDt9mOjqPSadd4YVAufW72xsI1cd+k4HzQKwZISj+8mp1Y5EJScP9NEC1L1oTjcotTA
         +hpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792166490; x=1792771290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=omjJiHG4DMcEiTl3Shd+1lm1YosdvYSAbHcTPN1mW38=;
        b=pyByFIaBQ6qPfYn3hZHGxHO2ZapglbtXmAAbUnXs7hJAIutkJfSsUxDMNysldk2jiu
         wGbeeWNpCl677LqT305HpDWDkfZmAzpa0H2JE40jPee6h68SNEh5XMTyYkToJPkEb0uq
         qSfYueQV+pid8ELWXnOGrQMzlh8nFZTSfQF69H7G5iOsl3NdKGUL6HWzO0PIxf8Fcgtx
         LrO330dFnSbQcD+q8Zl1t32bM1fbW97Pxm5P7HzHolryAeQ3qDxJ6YFJ1mRD8eNwrumC
         bhxvkKkRE8cgNrzAMcDa6pSrqx11cmaH2mqUdqce1DVCyATVMQsUEWGbv0bxai2y1O7R
         KaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166490; x=1792771290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=omjJiHG4DMcEiTl3Shd+1lm1YosdvYSAbHcTPN1mW38=;
        b=LOMwHOvgGC5skYA31xpUnY4YioUXjBN1Czp8n69Rsj4tZrqaCyaxnWgmlnZJ7sC65E
         xjxA16g6zox3j2+vzQmtH7yP0TKgzV/oOdCGsbKDTY/Urimqq/9lq/8YrVStptYUHEQk
         A7vOSK+yAbz8SNMXN4ATsvVjoJCPQQtBzkRIZBgYm9VzPPC++xBB7TNHi2eMxQJWHgHw
         0cwwQXkJOzxrAk4KUZOtC08zFieeFhhZIciOaC0ZDj9F/uxWp+nn9jhJsBk36cCu2rlZ
         a+ES5p8iysncmOih4wO/QyK9IckfnOZkbYV2KTu/K3kAYY0AssQPxUqmSVYsenhS8r/q
         6nPw==
X-Forwarded-Encrypted: i=1; AKwUvBxMQ3bajBiqYSFPeV1nacICQeXy31c8eVPn/PZ1yM4rG9mVmLTb13036xfdDW0zbT7DlExxi3p/zmdfjIY+m46V@vger.kernel.org
X-Gm-Message-State: AFq9FYI5HLFeUxMBrK3esqES7ELWyOzy3yyWI4/lpvHrDn4HAWl3emNt
	a7TxxqzlG1MjXbOQGUGgOKX+GeW/T0fHbpaPcH3vt2BJZUCKCTjp0GaKYaL69DuyDI61w/g5Sc0
	CxCbhXYRlyKSn3IuHUDPzf1kAsYVwPc5t8bI5cXDn
X-Gm-Gg: AYBFou1GAhcxbN2lyrsiFLJR4hEYym+UPQF+Y6g271jz2g1iuRW7DhicGVD4Mx3lYUg
	8nfTOgKkBTxd20LJ8tcqJ/G71HbgXvFJ3x3WP9ayRtc3p8C/35ws4STEJGT8zWqvvZlmqqSSbYI
	3RpL7FcLDyA+nb+z7mcrG0rOj6SuZLog5TfiXyooHAnb5ohVeTgt0/yt3YLcnisU2m/pF/2Rnl5
	gbEmKJHfpvEyNA/OcLaMPVcNriD/A5sfNm5n7mP/Bhj3o4ctDzmqzAI9ugwpoK+q+flfIQWgHOO
	dBnSwbn96Ddbxywtq99GOJbwIveIHdFA001wfzxWtHjRgLnj7xGM9WRaS4lHWZMvieSyxyShPm4
	nrm7j/QJnhg==
X-Received: by 2002:a05:7022:ea8c:b0:16d:a8b9:140f with SMTP id
 a92af1059eb24-182b0ca6175mr427365c88.0.1792166483960; Fri, 16 Oct 2026
 09:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015233237.542258-1-namhyung@kernel.org> <atIImjxxXKUO2os8@shell.ilvokhin.com>
In-Reply-To: <atIImjxxXKUO2os8@shell.ilvokhin.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Oct 2026 09:01:12 -0700
X-Gm-Features: AclHuK-C91GMbaVoBKGkfP2nvN8OyYYYhAjdJeyYsefwsHeseQJAtyhWdsx84Jk
Message-ID: <CAP-5=fWCwLuFah70DQCbmmDvjQYJ5DiozBj=YawZK6eVFGNnDw@mail.gmail.com>
Subject: Re: [PATCH v2] perf c2c: Fix memory leaks on output fields
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:21=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> wr=
ote:
>
> On Thu, Oct 15, 2026 at 04:32:37PM -0700, Namhyung Kim wrote:
> > The perf_hpp_list was not freed after use.  Let's add it for the main
> > c2c hists list in perf c2c report and a local list in print_pareto().
> >
> > Previously it was detected by ASAN like below.
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   =3D=3D42183=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> >   Indirect leak of 1064 byte(s) in 7 object(s) allocated from:
> >       #0 0x7f17334ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildI=
d: 61e8165ca90f7a4f06b73f064a938c76deaae079)
> >       #1 0x0000005fa099 in zalloc  ../../lib/zalloc.c:8
> >       #2 0x0000004faf6d in get_format  tools/perf/builtin-c2c.c:1978
> >       #3 0x0000004fb45e in c2c_hists__init_output  tools/perf/builtin-c=
2c.c:2004
> >       #4 0x0000004fb7de in __hpp_list__parse  tools/perf/builtin-c2c.c:=
2047
> >       #5 0x0000004fbae9 in hpp_list__parse  tools/perf/builtin-c2c.c:20=
85
> >       #6 0x0000004fee13 in print_pareto  tools/perf/builtin-c2c.c:2563
> >       #7 0x0000004ffcd7 in perf_c2c__hists_fprintf  tools/perf/builtin-=
c2c.c:2708
> >       #8 0x000000500ab5 in perf_c2c_display  tools/perf/builtin-c2c.c:2=
949
> >       #9 0x0000005045c3 in perf_c2c__report  tools/perf/builtin-c2c.c:3=
522
> >       #10 0x000000505caa in cmd_c2c  tools/perf/builtin-c2c.c:3676
> >       #11 0x0000005df50e in run_builtin  tools/perf/perf.c:383
> >       #12 0x0000005df9b1 in handle_internal_command  tools/perf/perf.c:=
436
> >       #13 0x0000005dfd7f in run_argv  tools/perf/perf.c:480
> >       #14 0x0000005e02d6 in main  tools/perf/perf.c:581
> >       #15 0x7f1729450680 in __libc_start_call_main (/lib64/libc.so.6+0x=
3680) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
> >       #16 0x7f1729450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.=
so.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
> >       #17 0x000000409c34 in _start (tools/perf/perf+0x409c34) (BuildId:=
 36a64600776d92e4ab7dfd5ca20c92280d72a645)
> >
> >   SUMMARY: AddressSanitizer: 1064 byte(s) leaked in 7 allocation(s).
> >
> > Fixes: c75540e3160f ("perf c2c report: Add dimension support")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
