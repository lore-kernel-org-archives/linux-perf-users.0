Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612621147F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624220; cv=none; b=ZuH6uBRlm3gHBMf4N9QI4680PaZpDlA7auLEIgxQV/3kziH5MAmHnn7tcjwxchFMCAHLSfCbSSHRe1SAv2kBP2Uhvswt2PUG6QUZTQFP737Lk3yqz5Qr/rKZTO9LC0O9cki60BipKBxBgt8VhbP90Bj6TxX4e+4f1Qk+cS6Vpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624220; c=relaxed/simple;
	bh=sP9Amf4PHF1B8sHyha2yW7J5FVMz9cnWHGRJRJRWjrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnOGbHV+4JnTBhVdhSkrgWwFgYeN/dFZQ+wx/fDptCDbHAmeZOi323TFj8zb3X0mFHNDwCe8guJ6UTaAroprxbT3LMmqHKeYhs1eC1EHXuiW/uSgl9IQwXgCSKT+7WxTwsuz9Ch9BnvND1SMbxxHjTJVLFgR1QaGbyPzof3hGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAaDR013; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAaDR013"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so52185ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738624216; x=1739229016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKQWS+XIncPJWANBz14WihnvnGg66/dc6f2Ww2mNP9Y=;
        b=oAaDR013ifAQ+WaZ4ZatotlmDHyQveCI7EGFbK18NXWCd2wWFPKuEP0/vrW088KPXr
         v9jT5SR8twryb1lwnHYOTRVGEiLy5C6G5z89ODeKMiI8q6v4KC4x/YaqfYntv8budyyI
         x6ib/D3SVJ4n2rAD1wE7wIcRpCXcYTDZ6YTpt2D/6psQPmcilQsG/TdthJqQkgw7hQbg
         Bukqiq39gIOUgkCm2wvTB0EaHJK3ReachGTVcd5PZr9bY+Q7Hde187ooQlDwxUd4Fn7D
         ixNSYSnDv43Pt+AXX9Daazh8igazts6mCVpkL1ruq5sJIQZw4fiDOThEPajBfjMce+nH
         3AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738624216; x=1739229016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKQWS+XIncPJWANBz14WihnvnGg66/dc6f2Ww2mNP9Y=;
        b=pycCo3WJMtUumEvZWMJwzraufKNst6FxejljJcl1LqwmbmlrR2oE2S8gZMT3pibPhe
         5Ql3sI7+nz5A41qHmXOwZXh5x3wgodleZ2LuXmMP9IdaOIZOJ63qJ3X5gJ6xDmUDPdYz
         Wp1GthMcOk/qnJ7sg3pNt9DJMt94jX+XLVUdCch3LZXqsuj2XGJz8unToaVIfC6rshUN
         gqeSKCdLFW2rJyqM5MeniSdJvK0Tazfdikeo0e/tJ1FrDSFa12OaUestWwNxOUwzfjQR
         FM0a2FmRgBVRj7kxX/GCW5rCkqHuJrPf2SkzowjJJ79kIzrgXgf7KieDILxvNoLJL2JK
         MuqA==
X-Forwarded-Encrypted: i=1; AJvYcCXtukh5S7bc/Mn65+6gMe4HhuHCx66LPfJoJxpZ05UT8cwsKRZTfkSnLBqE88puDVCZgsmfoMCcuXcC/BAJgLsg@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdFSfFzHcYU9THzJNAHWotTbENuSg8S4J96pSBMEQ8siQTm7X
	aSBwElfZToO9d4bRGj0yJ2wSHbPBIEaZskoXQGU/7m1RNYlpgC9KCedI1/BqI/TipUewwPpg033
	XT1E5SYqgUsNGoYtx4eVx9nhSjIhcPBkQ+zrh
X-Gm-Gg: ASbGncummusWxmePuPobywB62U2bmH1fbs0RruA1fiDFhGVrag59cWO21+b1NjsDzx4
	PDFVLqjW7J8u3QhWt43O72sQ2PtuIomc/EtMG3bSGkw8CpLrJjajo1m5bmB+KITjQXmNnsSVc9Y
	8JiLoo8A2SiW5+Sb9iD8Nw9/hp
X-Google-Smtp-Source: AGHT+IFcSnWilNw5ho+oedGZlEfLlELW+if+e699skdPlGhyJrWDDQtoGO0MtYkFj9MXCkNqTTRjBKzDAhGgYqWidzk=
X-Received: by 2002:a05:6e02:1348:b0:3d0:bd4:e46e with SMTP id
 e9e14a558f8ab-3d03fc63026mr1106615ab.22.1738624215458; Mon, 03 Feb 2025
 15:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201074320.746259-1-irogers@google.com> <20250201074320.746259-4-irogers@google.com>
 <Z6FKoQfY2zBNzIZV@google.com>
In-Reply-To: <Z6FKoQfY2zBNzIZV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 15:10:04 -0800
X-Gm-Features: AWEUYZmQBRqUML1Nj_f-qAM6euGxWwp5uB6XLRGS0leyde6I3v9ofY7HqaTiv0E
Message-ID: <CAP-5=fXuH=5Tq0gpVn7tAQX3cSLd=vjXZ6vp7Szde6i_RQNq+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf pmu: Rename name matching for no suffix or
 wildcard variants
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 3:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Fri, Jan 31, 2025 at 11:43:18PM -0800, Ian Rogers wrote:
> > Wildcard PMU naming will match a name like pmu_1 to a PMU name like
> > pmu_10 but not to a PMU name like pmu_2 as the suffix forms part of
> > the match. No suffix matching will match pmu_10 to either pmu_1 or
> > pmu_2. Add or rename matching functions on PMU to make it clearer what
> > kind of matching is being performed.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/empty-pmu-events.c |   8 +-
> >  tools/perf/pmu-events/jevents.py         |   8 +-
> >  tools/perf/tests/pmu.c                   |  85 ++++----
> >  tools/perf/util/parse-events.c           |   2 +-
> >  tools/perf/util/pmu.c                    | 256 ++++++++++++++++-------
> >  tools/perf/util/pmu.h                    |   5 +-
> >  6 files changed, 235 insertions(+), 129 deletions(-)
> >
> [...]
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 6206c8fe2bf9..c2a15b0259cf 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -847,21 +847,23 @@ static size_t pmu_deduped_name_len(const struct p=
erf_pmu *pmu, const char *name,
> >  }
> >
> >  /**
> > - * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignor=
ing any
> > - *                                   trailing suffix? The Suffix must =
be in form
> > - *                                   tok_{digits}, or tok{digits}.
> > + * perf_pmu__match_wildcard - Does the pmu_name start with tok and is =
then only
> > + *                            followed by nothing or a suffix? tok may=
 contain
> > + *                            part of a suffix.
> >   * @pmu_name: The pmu_name with possible suffix.
> > - * @tok: The possible match to pmu_name without suffix.
> > + * @tok: The wildcard argument to match.
> >   */
> > -static bool perf_pmu__match_ignoring_suffix(const char *pmu_name, cons=
t char *tok)
> > +static bool perf_pmu__match_wildcard(const char *pmu_name, const char =
*tok)
>
> It'd be nice if we use a function prefix with "__" only if the first
> argument is the corresponding type.  How about renaming it to
> pmu_name_match_wildcard() and others?
>
> Otherwise, looks good to me.

I think the intent is to make them look like (in the C++ sense) static
member functions. I was following the existing convention as with
perf_pmu__event_source_devices_scnprintf,
perf_pmu__pathname_scnprintf, perf_pmu__convert_scale,
perf_pmu__event_source_devices_fd,  perf_pmu__pathname_fd, all the
perf_pmus functions, etc.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  {
> >       const char *p, *suffix;
> >       bool has_hex =3D false;
> > +     size_t tok_len =3D strlen(tok);
> >
> > -     if (strncmp(pmu_name, tok, strlen(tok)))
> > +     /* Check start of pmu_name for equality. */
> > +     if (strncmp(pmu_name, tok, tok_len))
> >               return false;
> >
> > -     suffix =3D p =3D pmu_name + strlen(tok);
> > +     suffix =3D p =3D pmu_name + tok_len;
> >       if (*p =3D=3D 0)
> >               return true;
> >
> > @@ -887,60 +889,84 @@ static bool perf_pmu__match_ignoring_suffix(const=
 char *pmu_name, const char *to
> >  }
> >
> >  /**
> > - * pmu_uncore_alias_match - does name match the PMU name?
> > - * @pmu_name: the json struct pmu_event name. This may lack a suffix (=
which
> > + * perf_pmu__match_ignoring_suffix_uncore - Does the pmu_name match to=
k ignoring
> > + *                                          any trailing suffix on pmu=
_name and
> > + *                                          tok?  The Suffix must be i=
n form
> > + *                                          tok_{digits}, or tok{digit=
s}.
> > + * @pmu_name: The pmu_name with possible suffix.
> > + * @tok: The possible match to pmu_name.
> > + */
> > +static bool perf_pmu__match_ignoring_suffix_uncore(const char *pmu_nam=
e, const char *tok)
> > +{
> > +     size_t pmu_name_len, tok_len;
> > +
> > +     /* For robustness, check for NULL. */
> > +     if (pmu_name =3D=3D NULL)
> > +             return tok =3D=3D NULL;
> > +
> > +     /* uncore_ prefixes are ignored. */
> > +     if (!strncmp(pmu_name, "uncore_", 7))
> > +             pmu_name +=3D 7;
> > +     if (!strncmp(tok, "uncore_", 7))
> > +             tok +=3D 7;
> > +
> > +     pmu_name_len =3D pmu_name_len_no_suffix(pmu_name);
> > +     tok_len =3D pmu_name_len_no_suffix(tok);
> > +     if (pmu_name_len !=3D tok_len)
> > +             return false;
> > +
> > +     return strncmp(pmu_name, tok, pmu_name_len) =3D=3D 0;
> > +}
> > +
> > +
> > +/**
> > + * perf_pmu__match_wildcard_uncore - does to_match match the PMU's nam=
e?
> > + * @pmu_name: The pmu->name or pmu->alias to match against.
> > + * @to_match: the json struct pmu_event name. This may lack a suffix (=
which
> >   *            matches) or be of the form "socket,pmuname" which will m=
atch
> >   *            "socketX_pmunameY".
> > - * @name: a real full PMU name as from sysfs.
> >   */
> > -static bool pmu_uncore_alias_match(const char *pmu_name, const char *n=
ame)
> > +static bool perf_pmu__match_wildcard_uncore(const char *pmu_name, cons=
t char *to_match)
> >  {
> > -     char *tmp =3D NULL, *tok, *str;
> > -     bool res;
> > -
> > -     if (strchr(pmu_name, ',') =3D=3D NULL)
> > -             return perf_pmu__match_ignoring_suffix(name, pmu_name);
> > +     char *mutable_to_match, *tok, *tmp;
> >
> > -     str =3D strdup(pmu_name);
> > -     if (!str)
> > +     if (!pmu_name)
> >               return false;
> >
> > -     /*
> > -      * uncore alias may be from different PMU with common prefix
> > -      */
> > -     tok =3D strtok_r(str, ",", &tmp);
> > -     if (strncmp(pmu_name, tok, strlen(tok))) {
> > -             res =3D false;
> > -             goto out;
> > -     }
> > +     /* uncore_ prefixes are ignored. */
> > +     if (!strncmp(pmu_name, "uncore_", 7))
> > +             pmu_name +=3D 7;
> > +     if (!strncmp(to_match, "uncore_", 7))
> > +             to_match +=3D 7;
> >
> > -     /*
> > -      * Match more complex aliases where the alias name is a comma-del=
imited
> > -      * list of tokens, orderly contained in the matching PMU name.
> > -      *
> > -      * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY"=
, we
> > -      *          match "socket" in "socketX_pmunameY" and then "pmunam=
e" in
> > -      *          "pmunameY".
> > -      */
> > -     while (1) {
> > -             char *next_tok =3D strtok_r(NULL, ",", &tmp);
> > +     if (strchr(to_match, ',') =3D=3D NULL)
> > +             return perf_pmu__match_wildcard(pmu_name, to_match);
> >
> > -             name =3D strstr(name, tok);
> > -             if (!name ||
> > -                 (!next_tok && !perf_pmu__match_ignoring_suffix(name, =
tok))) {
> > -                     res =3D false;
> > -                     goto out;
> > +     /* Process comma separated list of PMU name components. */
> > +     mutable_to_match =3D strdup(to_match);
> > +     if (!mutable_to_match)
> > +             return false;
> > +
> > +     tok =3D strtok_r(mutable_to_match, ",", &tmp);
> > +     while (tok) {
> > +             size_t tok_len =3D strlen(tok);
> > +
> > +             if (strncmp(pmu_name, tok, tok_len)) {
> > +                     /* Mismatch between part of pmu_name and tok. */
> > +                     free(mutable_to_match);
> > +                     return false;
> >               }
> > -             if (!next_tok)
> > -                     break;
> > -             tok =3D next_tok;
> > -             name +=3D strlen(tok);
> > +             /* Move pmu_name forward over tok and suffix. */
> > +             pmu_name +=3D tok_len;
> > +             while (*pmu_name !=3D '\0' && isdigit(*pmu_name))
> > +                     pmu_name++;
> > +             if (*pmu_name =3D=3D '_')
> > +                     pmu_name++;
> > +
> > +             tok =3D strtok_r(NULL, ",", &tmp);
> >       }
> > -
> > -     res =3D true;
> > -out:
> > -     free(str);
> > -     return res;
> > +     free(mutable_to_match);
> > +     return *pmu_name =3D=3D '\0';
> >  }
> >
> >  bool pmu_uncore_identifier_match(const char *compat, const char *id)
> > @@ -1003,11 +1029,19 @@ static int pmu_add_sys_aliases_iter_fn(const st=
ruct pmu_event *pe,
> >  {
> >       struct perf_pmu *pmu =3D vdata;
> >
> > -     if (!pe->compat || !pe->pmu)
> > +     if (!pe->compat || !pe->pmu) {
> > +             /* No data to match. */
> >               return 0;
> > +     }
> > +
> > +     if (!perf_pmu__match_wildcard_uncore(pmu->name, pe->pmu) &&
> > +         !perf_pmu__match_wildcard_uncore(pmu->alias_name, pe->pmu)) {
> > +             /* PMU name/alias_name don't match. */
> > +             return 0;
> > +     }
> >
> > -     if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> > -         pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> > +     if (pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> > +             /* Id matched. */
> >               perf_pmu__new_alias(pmu,
> >                               pe->name,
> >                               pe->desc,
> > @@ -1016,7 +1050,6 @@ static int pmu_add_sys_aliases_iter_fn(const stru=
ct pmu_event *pe,
> >                               pe,
> >                               EVENT_SRC_SYS_JSON);
> >       }
> > -
> >       return 0;
> >  }
> >
> > @@ -1974,15 +2007,82 @@ int perf_pmu__for_each_event(struct perf_pmu *p=
mu, bool skip_duplicate_pmus,
> >       return ret;
> >  }
> >
> > -bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
> > +static bool perf_pmu___name_match(const struct perf_pmu *pmu, const ch=
ar *to_match, bool wildcard)
> >  {
> > -     return !strcmp(pmu->name, pmu_name) ||
> > -             (pmu->is_uncore && pmu_uncore_alias_match(pmu_name, pmu->=
name)) ||
> > +     const char *names[2] =3D {
> > +             pmu->name,
> > +             pmu->alias_name,
> > +     };
> > +     if (pmu->is_core) {
> > +             for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
> > +                     const char *name =3D names[i];
> > +
> > +                     if (!name)
> > +                             continue;
> > +
> > +                     if (!strcmp(name, to_match)) {
> > +                             /* Exact name match. */
> > +                             return true;
> > +                     }
> > +             }
> > +             if (!strcmp(to_match, "default_core")) {
> > +                     /*
> > +                      * jevents and tests use default_core as a marker=
 for any core
> > +                      * PMU as the PMU name varies across architecture=
s.
> > +                      */
> > +                     return true;
> > +             }
> > +             return false;
> > +     }
> > +     if (!pmu->is_uncore) {
> >               /*
> > -              * jevents and tests use default_core as a marker for any=
 core
> > -              * PMU as the PMU name varies across architectures.
> > +              * PMU isn't core or uncore, some kind of broken CPU mask
> > +              * situation. Only match exact name.
> >                */
> > -             (pmu->is_core && !strcmp(pmu_name, "default_core"));
> > +             for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
> > +                     const char *name =3D names[i];
> > +
> > +                     if (!name)
> > +                             continue;
> > +
> > +                     if (!strcmp(name, to_match)) {
> > +                             /* Exact name match. */
> > +                             return true;
> > +                     }
> > +             }
> > +             return false;
> > +     }
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
> > +             const char *name =3D names[i];
> > +
> > +             if (wildcard && perf_pmu__match_wildcard_uncore(name, to_=
match))
> > +                     return true;
> > +             if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(n=
ame, to_match))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +/**
> > + * perf_pmu__name_wildcard_match - Called by the jevents generated cod=
e to see
> > + *                                 if pmu matches the json to_match st=
ring.
> > + * @pmu: The pmu whose name/alias to match.
> > + * @to_match: The possible match to pmu_name.
> > + */
> > +bool perf_pmu__name_wildcard_match(const struct perf_pmu *pmu, const c=
har *to_match)
> > +{
> > +     return perf_pmu___name_match(pmu, to_match, /*wildcard=3D*/true);
> > +}
> > +
> > +/**
> > + * perf_pmu__name_no_suffix_match - Does pmu's name match to_match ign=
oring any
> > + *                                  trailing suffix on the pmu_name an=
d/or tok?
> > + * @pmu: The pmu whose name/alias to match.
> > + * @to_match: The possible match to pmu_name.
> > + */
> > +bool perf_pmu__name_no_suffix_match(const struct perf_pmu *pmu, const =
char *to_match)
> > +{
> > +     return perf_pmu___name_match(pmu, to_match, /*wildcard=3D*/false)=
;
> >  }
> >
> >  bool perf_pmu__is_software(const struct perf_pmu *pmu)
> > @@ -2229,29 +2329,31 @@ void perf_pmu__warn_invalid_config(struct perf_=
pmu *pmu, __u64 config,
> >                  name ?: "N/A", buf, config_name, config);
> >  }
> >
> > -bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
> > +bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *=
wildcard_to_match)
> >  {
> > -     const char *name =3D pmu->name;
> > -     bool need_fnmatch =3D strisglob(tok);
> > +     const char *names[2] =3D {
> > +             pmu->name,
> > +             pmu->alias_name,
> > +     };
> > +     bool need_fnmatch =3D strisglob(wildcard_to_match);
> >
> > -     if (!strncmp(tok, "uncore_", 7))
> > -             tok +=3D 7;
> > -     if (!strncmp(name, "uncore_", 7))
> > -             name +=3D 7;
> > +     if (!strncmp(wildcard_to_match, "uncore_", 7))
> > +             wildcard_to_match +=3D 7;
> >
> > -     if (perf_pmu__match_ignoring_suffix(name, tok) ||
> > -         (need_fnmatch && !fnmatch(tok, name, 0)))
> > -             return true;
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
> > +             const char *pmu_name =3D names[i];
> >
> > -     name =3D pmu->alias_name;
> > -     if (!name)
> > -             return false;
> > +             if (!pmu_name)
> > +                     continue;
> >
> > -     if (!strncmp(name, "uncore_", 7))
> > -             name +=3D 7;
> > +             if (!strncmp(pmu_name, "uncore_", 7))
> > +                     pmu_name +=3D 7;
> >
> > -     return perf_pmu__match_ignoring_suffix(name, tok) ||
> > -             (need_fnmatch && !fnmatch(tok, name, 0));
> > +             if (perf_pmu__match_wildcard(pmu_name, wildcard_to_match)=
 ||
> > +                 (need_fnmatch && !fnmatch(wildcard_to_match, pmu_name=
, 0)))
> > +                     return true;
> > +     }
> > +     return false;
> >  }
> >
> >  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t si=
ze)
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index edd36c20aedc..f5306428c03f 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -240,7 +240,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, con=
st char *name);
> >  size_t perf_pmu__num_events(struct perf_pmu *pmu);
> >  int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate=
_pmus,
> >                            void *state, pmu_event_callback cb);
> > -bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)=
;
> > +bool perf_pmu__name_wildcard_match(const struct perf_pmu *pmu, const c=
har *to_match);
> > +bool perf_pmu__name_no_suffix_match(const struct perf_pmu *pmu, const =
char *to_match);
> >
> >  /**
> >   * perf_pmu_is_software - is the PMU a software PMU as in it uses the
> > @@ -275,7 +276,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu =
*pmu, __u64 config,
> >                                  const char *config_name);
> >  void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
> >
> > -bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok);
> > +bool perf_pmu__wildcard_match(const struct perf_pmu *pmu, const char *=
wildcard_to_match);
> >
> >  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t si=
ze);
> >  int perf_pmu__pathname_scnprintf(char *buf, size_t size,
> > --
> > 2.48.1.362.g079036d154-goog
> >
