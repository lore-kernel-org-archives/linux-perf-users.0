Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5991A4E77
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346000; cv=none; b=fdILTS3j/Fh2SwB4IQRs0XSd0WwL+wRMGQx7WHkvhAXPWJMRpK5Lq5ZqULJR+nZWyP2byiE1RtIP1RVHndO2M/NvfSjmKtZuiCSmuNwYAlMYpIC+dfcKP9Xh58xkSDKFy1B/OISb0fzynk0R/ORt+kVcI1E4dWKuy3C7HnBGrEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346000; c=relaxed/simple;
	bh=5qMqmgSZz1CgtaYeiDnJYb17IEvFM3Wt3+ze2QJ7Csc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF3py27pPhXmioBPx69vPu8fGMA9/E4+p9DYSTdkJ8iTEUahmqqF4C61D3TtY2iOiqK3rNsaoAXlNWp1oqrahFhvFzqXsSZYt4FLBVSeqKo/V4Gdoyw0HX2b/Ne5it8BbWx4IH9GUI+BIMZ1LPs+DyHX5lCWTdSLECT4T4qSvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOHbkUY0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOHbkUY0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8ac50b79so299875ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731345998; x=1731950798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtHqIQ077NK/Kpw1yOeqFT7YzM6NTkAZYzpUap4JxFE=;
        b=yOHbkUY0Ye2Hu7YH0XZFbDy5UrcVv/JXfW1rspInYnwbd6o7v0woWsBGKfVgO6aEi+
         9OnSP1r7zZR69yrtiGP9G2QhyPqE9PI6C9upl2xp3btGkd5wkHwcPFxg9a65Won0xZad
         IN0Y9aJQAbJAlLLDwYiDPsuNkNQN6N+8wkQlWfU86TCP4thC2bnpKLcz6wIDiI1VHkNV
         TwLRprwgikEyi3ccYFrh+IQSBJdeg1yyGcy1CUcWUSUmeTi1Hh++rluADVUhaENDvJqA
         Tic8CltuXR4qr43ANpJ1lx/4Pr2RDZYErwOu3ot3bnERbbOen+XYbgp1mGN8hQS5oQTW
         9Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345998; x=1731950798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtHqIQ077NK/Kpw1yOeqFT7YzM6NTkAZYzpUap4JxFE=;
        b=iM7jVKmpGf0jEfC5+2O3xkc/maAz6yF4qFgifpCVJvZq8jep2Ydzy/pjUnmKZG0O1V
         eCQY5rsySQ/Pl69PIPg6JTqqhzpETXtwajBnStTJlScQynF3G3/Nsu2xIRTGH2a5UAeg
         TbaPwQgwd7ohMkgrCD0x1GYfJ1KIE1Ib+Dy0XACoX5fY3QA1QZpoY2H2fg/rxrcG0uhk
         7yojUVGpGMrYCh++yCugBUBJ1jUSO5o5wIqk3fY2+ibGbcuQWpXoXVuXyCx2ZHsZoIGq
         moxgoA0DgEHJRbumSu2Yl128W+H7gWyaJZeOMlsdxzJAm8PrRqydeycLYX5O5qvSutzW
         jhlw==
X-Forwarded-Encrypted: i=1; AJvYcCVOExNDALp1KOr7zppaKPs9XbXm8CcOwJshiKToZ9die94+mVGNuvsDXWQKsNk6hQizTzCeMqs1fAy7geUzJtVe@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkyNMank8smkYcBVW1ZuJxZMON8/lFmVKdNVjWMOaoaPL82FT
	caiY0iTc5wf3UVQy+sGWnBgqHE7rO9MlPRvQuWrsCB97p44FBG+86bsQht+XFLZ/YBZiJ9J+FoM
	pIGZidhtl4qAwC7fqrYAj6QhXXoTOAhrGHzkv
X-Gm-Gg: ASbGncsfs63in8dEUwPLnDUtM2XX6zxWm2z4lupWY3If+qLGnJ1ET5pbC/xcfQ+PUDO
	ncYZlSwUbXg9CuPin9BTy0ZEel8hAmL9Rw8JTJ4cjsLEQ14DHhUAGmwuIsdz9fLI=
X-Google-Smtp-Source: AGHT+IHgErp88bOMfE1J3Q01M453IP2j5pUxjRlUV6LMT18h2fTc3RLfhl4aFLhattLgSrBW2Nw7RxJj79FiohU74yA=
X-Received: by 2002:a17:902:ecd1:b0:20b:6c3c:d495 with SMTP id
 d9443c01a7336-2118f1d2446mr3763045ad.25.1731345997997; Mon, 11 Nov 2024
 09:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109160219.49976-1-irogers@google.com> <bfba7266-1903-41ca-9961-aa449f982912@linux.intel.com>
 <CAP-5=fWxMzCDQ7v1W_gMN-Yaz4yiam=5vOc8+bter0vF4cbV+Q@mail.gmail.com> <4d5d2514-8378-4b0f-b58f-45dcd239ea51@linux.intel.com>
In-Reply-To: <4d5d2514-8378-4b0f-b58f-45dcd239ea51@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:26:26 -0800
Message-ID: <CAP-5=fWsmZPxTqCK7w=9+WqeP_VQy0kE5Pi3P34Tn3EDo+Aa2Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Add a runs-per-test flag
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:14=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-11-11 11:10 a.m., Ian Rogers wrote:
> > On Mon, Nov 11, 2024 at 7:52=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-11-09 11:02 a.m., Ian Rogers wrote:
> >>> To detect flakes it is useful to run tests more than once. Add a
> >>> runs-per-test flag that will run each test multiple times.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++++-----------=
--
> >>>  1 file changed, 23 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/built=
in-test.c
> >>> index d2cabaa8ad92..574fbd5caff0 100644
> >>> --- a/tools/perf/tests/builtin-test.c
> >>> +++ b/tools/perf/tests/builtin-test.c
> >>> @@ -42,6 +42,8 @@
> >>>  static bool dont_fork;
> >>>  /* Fork the tests in parallel and wait for their completion. */
> >>>  static bool sequential;
> >>> +/* Numer of times each test is run. */
> >>> +static unsigned int runs_per_test =3D 1;
> >>>  const char *dso_to_test;
> >>>  const char *test_objdump_path =3D "objdump";
> >>>
> >>> @@ -490,10 +492,10 @@ static int __cmd_test(struct test_suite **suite=
s, int argc, const char *argv[],
> >>>                               len =3D strlen(test_description(*t, sub=
i));
> >>>                               if (width < len)
> >>>                                       width =3D len;
> >>> -                             num_tests++;
> >>> +                             num_tests +=3D runs_per_test;
> >>>                       }
> >>>               } else {
> >>> -                     num_tests++;
> >>> +                     num_tests +=3D runs_per_test;
> >>>               }
> >>>       }
> >>
> >> Seems we just need to calculate the num_tests once at the end for each
> >> loop. Something as below may works. (not tested)
> >>
> >> @@ -482,20 +490,19 @@ static int __cmd_test(struct test_suite **suites=
,
> >> int argc, const char *argv[],
> >>
> >>         for (struct test_suite **t =3D suites; *t; t++) {
> >>                 int len =3D strlen(test_description(*t, -1));
> >> +               int subi =3D 0, subn =3D 1;
> >>
> >>                 if (width < len)
> >>                         width =3D len;
> >>
> >>                 if (has_subtests(*t)) {
> >> -                       for (int subi =3D 0, subn =3D num_subtests(*t)=
; subi
> >> < subn; subi++) {
> >> +                       for (subn =3D num_subtests(*t); subi < subn; s=
ubi++) {
> >>                                 len =3D strlen(test_description(*t, su=
bi));
> >>                                 if (width < len)
> >>                                         width =3D len;
> >> -                               num_tests++;
> >>                         }
> >> -               } else {
> >> -                       num_tests++;
> >>                 }
> >> +               num_tests +=3D subn * runs_per_test;
> >>         }
> >>         child_tests =3D calloc(num_tests, sizeof(*child_tests));
> >>         if (!child_tests)
> >
> > It's basically the same thing, instead of doing increments and then
> > multiplying by runs_per_test you just add on runs_per_test and avoid
> > the multiply.
>
> The "else" should be unnecessary either. But the above is just a nit.
>
> >
> >>>       child_tests =3D calloc(num_tests, sizeof(*child_tests));
> >>> @@ -556,21 +558,25 @@ static int __cmd_test(struct test_suite **suite=
s, int argc, const char *argv[],
> >>>                       }
> >>>
> >>>                       if (!has_subtests(*t)) {
> >>> -                             err =3D start_test(*t, curr, -1, &child=
_tests[child_test_num++],
> >>> -                                              width, pass);
> >>> -                             if (err)
> >>> -                                     goto err_out;
> >>> +                             for (unsigned int run =3D 0; run < runs=
_per_test; run++) {
> >>> +                                     err =3D start_test(*t, curr, -1=
, &child_tests[child_test_num++],
> >>> +                                                     width, pass);
> >>> +                                     if (err)
> >>> +                                             goto err_out;
> >>> +                             }
> >>>                               continue;
> >>>                       }
> >>> -                     for (int subi =3D 0, subn =3D num_subtests(*t);=
 subi < subn; subi++) {
> >>> -                             if (!perf_test__matches(test_descriptio=
n(*t, subi),
> >>> -                                                     curr, argc, arg=
v))
> >>> -                                     continue;
> >>> -
> >>> -                             err =3D start_test(*t, curr, subi, &chi=
ld_tests[child_test_num++],
> >>> -                                              width, pass);
> >>> -                             if (err)
> >>> -                                     goto err_out;
> >>> +                     for (unsigned int run =3D 0; run < runs_per_tes=
t; run++) {
> >>> +                             for (int subi =3D 0, subn =3D num_subte=
sts(*t); subi < subn; subi++) {
> >>> +                                     if (!perf_test__matches(test_de=
scription(*t, subi),
> >>> +                                                                    =
 curr, argc, argv))
> >>> +                                             continue;
> >>> +
> >>> +                                     err =3D start_test(*t, curr, su=
bi, &child_tests[child_test_num++],
> >>> +                                                     width, pass);
> >>> +                                     if (err)
> >>> +                                             goto err_out;
> >>> +                             }
> >>
> >> Can we add a wrapper for the start_test()? Something similar to below?
> >> It avoids adding the loop for every places using the start_test.
> >>
> >> +static int start_test(struct test_suite *test, int i, int subi, struc=
t
> >> child_test **child,
> >> +               int width, int pass)
> >> +{
> >> +       for (unsigned int run =3D 0; run < runs_per_test; run++) {
> >> +               __start_test();
> >> +       }
> >> +}
> >
> > I think the issue is the code has become overly indented.
>
> And duplication.

Agreed. Do we want the runs-per-test feature without me overhauling
all of this? I'm not going to have time any time soon.

> > Having a
> > start_test function that starts some number of tests feels less than
> > intention revealing. Perhaps (in the future I'd like to tackle other
> > things for now, such as new TMAs :-) ) we can create all the child
> > tests in one pass, then just have start_test and finish_test work with
> > the child tests.
>
> It may be easier to understand if we have both start_mul/all_tests() and
> start_single_test().
>
> > (Off topic) Something else I'd like is to move the
> > slower running tests to the end of the list of tests so you can see
> > the earlier results while waiting.
>
> I'm not sure how useful it is. But for me, I always wait for all the
> tests complete, no matter how fast the results of the first several
> cases shows.

Agreed. The issue for me is I tend to run with `perf test -v`, the
single verbose means report the error from failing tests only. Some
tests, like testing all metrics, generate 100s of lines of output and
you may lose test output if you don't have enough shell history. It's
nice to see in cases like that, that the regular tests passed. Perhaps
we should also capture test output to a file. That reminds me that I
wish `perf test list` wrote to stdout rather than stderr, but no doubt
"fixing" that would lead to complaints about breaking compatibility
:-/

Thanks,
Ian
