Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F0281531
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836896; cv=none; b=s0nPCesJG8wp8eRuszu3oyBz0wTsMbofk/xIis9OSgs0IwARl260N3mjOpri0AI29ZBjN9uAvYjeuaeoDWJ/Drl7heHeXjbYFG5aw8wUvSfSkgFIpkoUOAJpN3lLRpMAZFQchDEbJuaGpgu9wdivq2cgJ5feayzp6x54A0wLE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836896; c=relaxed/simple;
	bh=w09wSAyKXW3qBD6pcz9lGlMTHirxjNuyqDGC+xjvZWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9fE5udHLbbHMTBrxNqC5D3uWpse/LjnqoPkfLET94yUB1AF4nlNwR9hgdxT1vXGbFYs0WKQK8xHviwvsWbYvAi861o0jUZWCs4EL3kr1yzkhu+J+sYlGJPFOMnN7wWG5khQfdu6SV8v2HqAPVNoJr0J3M6J+6RxV5yIKMPP1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRKZQ3uk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRKZQ3uk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so196185ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761836894; x=1762441694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtgDL4CNzIRWFeWdzUwa9l0ZhfF8MlQxcBiXG+FT3wM=;
        b=KRKZQ3uk9burkfqxgBqW5bGLF9KBYd1hgljl4LFOykYrhfmyyDVOWHdH7xsJ6bFwY1
         /GuER+YBOfQKWAfOYiwrP3OkRze5Jtnc64fWiV5MOx5vgAqGvbPIMpvLFh7aNMRjGMNH
         TU8XBvrXSMXrxAnF6TBqoP1hy/IU26mY7DqmfEM5+wAAagafwsdyYLtc8V4xOvPSMqpn
         mcmnb6puRMT87Bt7eLcC9jx29HFoQkcN2gB0JBiK9D8zF3slEXumxUTEOANqKHrFckbh
         zQO/e+zPQ2/VSN1l4tlDitf2zU13+GgCP5cpC0l/cC0d2lAGEQuBE2uRblddc71nf70j
         ObEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836894; x=1762441694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtgDL4CNzIRWFeWdzUwa9l0ZhfF8MlQxcBiXG+FT3wM=;
        b=P7ymz8eR+5NSkypVGDjihabLQ53yFlrcApSUMNQwvrxip0qe05GBFgTbmftmT59qtZ
         2nr/meUQgz3XT72Juz6HnXjop+fSBuUiljurkK2xRu5vJczPCHR7HqWxgFB2ehWCPfWh
         G5eifYto/EvhoBj1gs3KyQyjFc83NbiVu/KQa+MZhh8jUTakBJMY7eYiSo1Fhu9z3oX0
         YumMWF4hVu59LP/aTpSA7jntUBZKCJ08SFLg+qCPjwZmj8TAXkbziKYwkfdc6EMD5zfO
         2S1IM571AGIipeoCsrQG4WswjgXqzlyaj4iSXMqn/XEW8aVQPLJODcVa1rHmXpX9ajD9
         Do9w==
X-Forwarded-Encrypted: i=1; AJvYcCXgSxNnIiR+Dp4jxhkoxgeD09h53jekRM+gZ2BgQm5sUvEaDSjutXrx6ANiOOnsEbtk7uUxYsjpKUMP6J7DpSDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+zh64SY5RBb1mImO99odgewvuuc/lb639eG0+pPiIo8/oyYN
	MG0XctjTZoR1pa9L42va6dRFqShMdV3FgV7khHVlsXHLnyBhUX5Xc9XftNfXCgwN6yp4cDSV0cp
	vkTgyBgMyd+NLrtZhL7jV/gqDU31zPGp5aZYmRv7G
X-Gm-Gg: ASbGnctkdBLdNApGbyHqRRjYFRlIom7+wTWq/nkaxB7jyQYdShQ4grCL7uSSGpPt4F0
	YeYrP98iKJ80k6yZzFCa6TdAO+SFZZtcbxl8zOBEfwe1fGrKPNNwsE6upKbFDhC4DNZEbsDJ6k6
	ciBRYsKPyROewogxWFnj8FkOGTnsmxcE+UhjzfMW0CcFtDEdCi2LOiJYkfNkIlOyj2ReDQODt2G
	/YQQns5n9H9t/n2GVREc4cGklyQ/99yWKnsVlqgyLwbzCV5bKHgWqq867vBNfaoenGIwYxoAbDA
	OqOtfLnqg+Ouykk=
X-Google-Smtp-Source: AGHT+IFigT5X65ypvqb7uJDHxLvHz+Pz9Zc6xIoSJ0A8R/77e4JiyI3k+FWsZr+FCoJ0cb8ItFvdlcAVhU60h7DWiDs=
X-Received: by 2002:a17:903:189:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-294ee38bca0mr5466275ad.6.1761836893656; Thu, 30 Oct 2025
 08:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029222638.816100-1-irogers@google.com> <aQL70qlYohRT7cT8@google.com>
In-Reply-To: <aQL70qlYohRT7cT8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 08:08:02 -0700
X-Gm-Features: AWmQ_bkg9LolVxgNEq3vV2njLdXKB6-BbL1B0cR15fquDCMb7mdBNgL9i5BdA20
Message-ID: <CAP-5=fU1pJ_7ewrxwCLUu_OkjZ2Z_bSzkaZxREG8uKnwop6JYw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf pmu: Make pmu_alias_terms weak again
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Oct 29, 2025 at 03:26:37PM -0700, Ian Rogers wrote:
> > The terms for a json event should be weak so they don't override
> > command line options.
>
> Can you please give an example command line and the error?

Sure, it is also covered in the test.

Before:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   200003
 { sample_period, sample_freq }   2000003
 { sample_period, sample_freq }   1000
```

After:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
```

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index d597263fab4f..f14f2a12d061 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu =
*pmu, int sysfs_fd)
> >  static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_h=
ead *terms)
> >  {
> >       struct parse_events_terms alias_terms;
> > +     struct parse_events_term *term;
> >       int ret;
> >
> >       parse_events_terms__init(&alias_terms);
> > @@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *=
alias, struct list_head *terms
> >               parse_events_terms__exit(&alias_terms);
> >               return ret;
> >       }
> > +     list_for_each_entry(term, &alias_terms.terms, list) {
> > +             /*
> > +              * Weak terms don't override command line options,
> > +              * which we don't want for implicit terms in aliases.
> > +              */
> > +             term->weak =3D true;
> > +     }
> >       list_splice_init(&alias_terms.terms, terms);
> >       parse_events_terms__exit(&alias_terms);
> >       return 0;
> > --
> > 2.51.1.851.g4ebd6896fd-goog
> >
