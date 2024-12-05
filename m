Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B70391
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380444; cv=none; b=s5qlJb64YF4OSs18jBIKqdd23/OnYR1X460SU87eCSf40xIKkqeysmh/ZqZcbTkPf0UH0NbojjHX/l3jGReiM2lEAQq0QOoNa4liOKq1rZYtHNVE9jRwJpS/CRFLtR01rlMAF7vH8jv4BNwf9wHIG5/0Dcgh7xkl4oIBHTXu4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380444; c=relaxed/simple;
	bh=VYQxyC/l3SIBJTvrSVqsCeLz+pAkgBcm1YklVVmfRMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6sozkNZ9tNP2ExY3D0cEmKc1xs0pn9LLEDNZcLr8DIDdY2n5Mr/JqqkmvmL+Q6mfh3fKfeDZHLaB4jsvOuBEIaxtS9JPH4dJaPE3tJheon/zzXBLyY7SEqsGHbjf35fGkY/IezGIMK12nyTbhyPFygJgkWR91zxEVTQmQoyBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwi5qAgY; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwi5qAgY"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a77ab3ebfaso81985ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733380441; x=1733985241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ+PTS/O30h8AWJWzVBtOJLnncwS4BzOGPDsCRKaXKE=;
        b=Qwi5qAgYbCKV2k94FgZA32azw+Ej7LqLhXCuCltEE9l0YTNtedEWJ22Wn0vWffSZZK
         b7DqJg69VjT0r7sWS3wpDb5ZFyRe20TQGZh+LazyCEjh+xAA3/XfKtx44bLM5qRbNSvT
         nmB/K5+a++W+ziSzLEMwEI/W5jyVY3XO+3gNgf9plLGfDfnHoiPvLbataMI6JnPKnms/
         0TUkDPuWGfOiI4PoX2arpBz7ZkemPsP0qAIEuVhl2Jgmpg+z8Zp1EyGI4BI5X1DidzUK
         4SiZFVbuuWB+/GHOqc6fUhw3YZKC7frvqIki49XQVU29Azjs/4TPrIZlKUhW/HGgm1IJ
         9s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733380441; x=1733985241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ+PTS/O30h8AWJWzVBtOJLnncwS4BzOGPDsCRKaXKE=;
        b=uVx151vya3eIEOIimlQX97lLhl4ARhEiD8NTTVQFyPqaaqyTeBAkFB7j1boDa1/tzG
         9Vz1hQ8x21EGW48pvVovRYJ8GuWqvV/2k5vpGoBwiyIy/S4adwYyEbNunhxLSMlL/MXi
         I+YOSwathPt4Pkc2VJWB3Fih/Xukzfz9c/RZIJhlc0PVqi1zN3jsq0slvXdOPxu8A6iG
         7ycs7lO5Sk6Xn/7DVsHaas+LpPW+WrtEM8oDX0/D9OWsHRvXwP4ymy964NyPK+smenu5
         fK9cSRmnbZ+y8b2J1BVCSdBrrrx4/B8Qxtx4AmCyXiDqmd5EY/PCZhGTa40PVqjUORlj
         Q8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV/VVLBeDFDG+Cj8W8XsX46kcW7qAwzQcdBfTgsmQhR2QefdqGk0E/9j8tIL5RFO+3lQc0GcnXcTodh/jBZXNw3@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVBI7u7shxoADRsZQkM4s2auJ/kPS3rqLAvJRGYrLZ90Y93fQ
	9n7ny2shBtUhai7dbu76liu/b2Ukmyc6nv9CYPnIBAwlAI04ROxfKyCnaWuSPIyHOU/Zc1oRhw4
	/T0hd6Cbdu+YhDK//6zVf3Ekd1Fj3lh1O0txY
X-Gm-Gg: ASbGncvwt9WEbPv23jIMj2hG60ErU8o3nz9bsA0ETsar8lgXN1XA/1R63BR4rppMhIy
	yFNgBFG8w+cuNQ8ypqnesun8CTYfNCeKb
X-Google-Smtp-Source: AGHT+IEgHHfxuE1aJp6TLehuMD4UwVg+/zaAmQLSfttijsmXQLGtoBotHEy8B0DJzdNyFucHeZ8dje/BN3+W1K5iZGg=
X-Received: by 2002:a05:6e02:3486:b0:3a0:a459:8eca with SMTP id
 e9e14a558f8ab-3a8083bfa97mr2293065ab.10.1733380440495; Wed, 04 Dec 2024
 22:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205022305.158202-1-irogers@google.com> <Z1E-WHWSPAezVF4f@google.com>
In-Reply-To: <Z1E-WHWSPAezVF4f@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Dec 2024 22:33:49 -0800
Message-ID: <CAP-5=fVPw5wJtVR0fxU-7drXg34vNrBsEzurfcLLvC+wFPMAAg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, 
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> > The refactoring of tool PMU events to have a PMU then adding the expr
> > literals to the tool PMU made it so that the literal system_tsc_freq
> > was only supported on x86. Update the test expectations to match -
> > namely the parsing is x86 specific and only yields a non-zero value on
> > Intel.
> >
> > Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions a=
nd json descriptions")
> > Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854-1=
-atrajeev@linux.vnet.ibm.com/
> > Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> It failed on my VM.
>
>   root@arm64-vm:~/build# ./perf test -v 7
>   --- start ---
>   test child forked, pid 2096
>   Using CPUID 0x00000000000f0510
>   division by zero
>   syntax error
>   Unrecognized literal '#system_tsc_freq'FAILED tests/expr.c:253 #system_=
tsc_freq =3D=3D 0
>   ---- end(-1) ----
>     7: Simple expression parser                                        : =
FAILED!

I'll need to check this. The test is looking for parsing failures, so
it's confusing to me expr__parse is returning 0. I was testing on x86
but disabling the literal in the tool PMU.

> > ---
> >  tools/perf/tests/expr.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index 41ff1affdfcd..726cf8d4da28 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -75,14 +75,12 @@ static int test__expr(struct test_suite *t __maybe_=
unused, int subtest __maybe_u
> >       double val, num_cpus_online, num_cpus, num_cores, num_dies, num_p=
ackages;
> >       int ret;
> >       struct expr_parse_ctx *ctx;
> > -     bool is_intel =3D false;
> >       char strcmp_cpuid_buf[256];
> >       struct perf_cpu cpu =3D {-1};
> >       char *cpuid =3D get_cpuid_allow_env_override(cpu);
> >       char *escaped_cpuid1, *escaped_cpuid2;
> >
> >       TEST_ASSERT_VAL("get_cpuid", cpuid);
> > -     is_intel =3D strstr(cpuid, "Intel") !=3D NULL;
> >
> >       TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
> >
> > @@ -245,12 +243,19 @@ static int test__expr(struct test_suite *t __mayb=
e_unused, int subtest __maybe_u
> >       if (num_dies) // Some platforms do not have CPU die support, for =
example s390
> >               TEST_ASSERT_VAL("#num_dies >=3D #num_packages", num_dies =
>=3D num_packages);
> >
> > -     TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#syst=
em_tsc_freq") =3D=3D 0);
> > -     if (is_intel)
> > -             TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> > -     else
> > -             TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpclassify(v=
al) =3D=3D FP_ZERO);
> >
> > +     if (expr__parse(&val, ctx, "#system_tsc_freq") =3D=3D 0) {
> > +             bool is_intel =3D strstr(cpuid, "Intel") !=3D NULL;
> > +
> > +             if (is_intel)
> > +                     TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>
> Also Sasha reported that some (Intel?) guest machine doesn't have TSC
> frequency.

I think, unfortunately, this is working as intended. Intel metrics use
#system_tsc_freq in metrics for most models:
```
$ grep -ril system_tsc_freq tools/perf/pmu-events/arch/x86/
tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
```
The code to generate the TSC frequency uses the CPUID leaf
information, but this can be disabled by the host operating system for
guest operating systems. The fallback logic using `/proc/cpuinfo` is
intended for older models and it appears the more recent formatting
won't be parse-able by perf. The host has also likely disabled the
information if the CPUID leaf is hidden. So the test is correctly
failing because metrics using #system_tsc_freq would be broken inside
the guest OS. Kan was involved in the conversation when the literal
was added and this was the best we could do.

Thanks,
Ian

> > +             else
> > +                     TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpcl=
assify(val) =3D=3D FP_ZERO);
> > +     } else {
> > +#if defined(__i386__) || defined(__x86_64__)
> > +             TEST_ASSERT_VAL("#system_tsc_freq unsupported", 0);
> > +#endif
> > +     }
> >       /*
> >        * Source count returns the number of events aggregating in a lea=
der
> >        * event including the leader. Check parsing yields an id.
> > --
> > 2.47.0.338.g60cca15819-goog
> >
