Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63122DA1A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539524; cv=none; b=KuZrc1nIv0+mhYDPfwBcdgQasM11fTUErqTkMTvEX525zP3+6IQYVV9emhX1IuDY4KW+tmhTIEmr+aJnFb6Qr0s9F19oMa81vsef5p7FHnZw62gLa1p+cemAel56lcUbEK+k0XkhJT0qR0NWDvp29YdALH/0F2zTdp1CyO/FECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539524; c=relaxed/simple;
	bh=R7W36fC9mqA2YImazGJzMilva/IX/vW7Fpjaef9QXRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQXiUibANl05KU8ZAyHmRfjGy4NH4cZBiCPX+bIwK8xdv+O9toliNds3q96v0jk2hLSQWi93xQMMC0Y0Sr+sjIMR+bL3z/hyuTKuu4M9gbQ/Ck7k0N6EORXvF6zozTvr20cVMQll0YRyoOHo9eeqV8RWmlFIRZXT2swofoy50Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJAn4UXm; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJAn4UXm"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so6425ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748539522; x=1749144322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq5UWqCDWZg2jUBruTrKCignhLetlhTEoSWLRFlBvKY=;
        b=FJAn4UXmJ5F2YEZhhj6T/KCixe1TGMF1njpw7gZuPOMxpCb0jGfNY9QBXF3m1qLc8F
         QJLrDBYCch1Dbt3FuTopTR8HB/uJwmotD0Rq3QT1o2hdY/2xsyDieb1Nzrm5tofwbtQm
         CLqd4DDmVTRrxqJuAQVaAVTIftTidT6eTcil/VSeFhU5IFIFcq3eCJ92wsJfUpw/Py1Q
         7/fEFV3BPOExF6etTJ3O2K2Cm/0Zz6DA1PEqGNF0nPXiZ1A3Ry65zQgDSj/UbluErU4N
         kBvrAdeFNNTToXdBExMVUR+XSG4xMv09Dzrkifr8dLoicPXIDc9JKCzVVg5GrxO/iPT8
         vd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539522; x=1749144322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq5UWqCDWZg2jUBruTrKCignhLetlhTEoSWLRFlBvKY=;
        b=ofG1VrlTsUI8D1NeN4xn56at8lqOkCY1ONvHbLyGaTiWKZyaQ1b44+HBBdcHm2Lmih
         HW3dTDT+oKNff60byZohlaeB0OSV/4/6fkOhh1rhTiHJN/mH6xlGLOpuxq+6UzvXPMjk
         hlp+rATPZwTWpVCbNbNMLFf+O/V2IZ0MEueV4XhXfguZ4ODJDsgeH1ewNz0t9tsmFtJ+
         Q48ZPrK5qmBGRvConSIRWXqsTwZqTdORucmrdyyJ8RZpYIzUmZS5SwTvRjzAPzuxUEty
         SYpo+EUu1ZIkqmRg5pLbN+JRzxtMP5oiHiKwH6O1wCBrX7ZNgepttG/+BnU84JEFAu+M
         ponQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmr1MjlALZhdJayNnEnNPnNL9KvF9Q9HSNo5tZPjiH9I0gbHh3VvsOW5I8mvBjJPG9q3UbXkH5BENp+24B9eDG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Sy1a8rvQ1UFdHzpUtGxFECPd66Y5lG8DvbSeNWgFkV+89rfR
	8IdH3rLeSdEOJSMmSsdUhTbUiLRBDGEzuDH/FsF5AdOqhdHHIS2fZ/GmONj0T0hxEQQj8QO+5K8
	/w8zb/znoBseSOh5F2mALgT7Da6w1YkSgOtHGPNA0
X-Gm-Gg: ASbGncv7Idpviq8tF84RChRRAs9tWz5EjAfk8jd1c7uPp8wRVZWQkN1fGIi2VZ7Cx/A
	8JOeV66EnY5/fEXRLn2ZmFJc5Y5nf936+wtC9IGc5I3uytPMymbuD4sKMWI22XsPefIZIkzDc3v
	00n3JSannxTjVAZmH7ebza+7KTYiHRKReFZ7vM9EyjpDFVNjYt0c/OHHa4z6rTp2gEUsu3ygHi7
	RjoEWAzx7k=
X-Google-Smtp-Source: AGHT+IEieB0z/jaUQ85p0bxGKF/BsfxceTJbHzW2dlAAgUo/3U0hH7+izTddIgjUp6yv6WeWDg6P6NOKrSVA54Daxp0=
X-Received: by 2002:a05:6e02:b4e:b0:3dc:8041:235b with SMTP id
 e9e14a558f8ab-3dd93102438mr3785775ab.5.1748539521790; Thu, 29 May 2025
 10:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org> <20250529-james-perf-feat_spe_eft-v2-10-a01a9baad06a@linaro.org>
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-10-a01a9baad06a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 May 2025 10:25:09 -0700
X-Gm-Features: AX0GCFsMi0PuJSkUZIq3glS5t7yiPh54_nxoMbLwC4oi0UtVw-ij7ss9J0KioO4
Message-ID: <CAP-5=fUOfEskPp_5myy167bpZ47NjavWU_8vAMpPo4TSWJRs-w@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] perf tools: Add support for perf_event_attr::config4
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 4:33=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> perf_event_attr has gained a new field, config4, so add support for it
> extending the existing configN support.
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 14 +++++++++++++-
>  tools/perf/util/parse-events.c  | 11 +++++++++++
>  tools/perf/util/parse-events.h  |  1 +
>  tools/perf/util/parse-events.l  |  1 +
>  tools/perf/util/pmu.c           |  8 ++++++++
>  tools/perf/util/pmu.h           |  1 +
>  6 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 5ec2e5607987..5f624a63d550 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -615,6 +615,8 @@ static int test__checkevent_pmu(struct evlist *evlist=
)
>         TEST_ASSERT_VAL("wrong config1",    1 =3D=3D evsel->core.attr.con=
fig1);
>         TEST_ASSERT_VAL("wrong config2",    3 =3D=3D evsel->core.attr.con=
fig2);
>         TEST_ASSERT_VAL("wrong config3",    0 =3D=3D evsel->core.attr.con=
fig3);
> +       TEST_ASSERT_VAL("wrong config4",    0 =3D=3D evsel->core.attr.con=
fig4);
> +
>         /*
>          * The period value gets configured within evlist__config,
>          * while this test executes only parse events method.
> @@ -637,6 +639,7 @@ static int test__checkevent_list(struct evlist *evlis=
t)
>                 TEST_ASSERT_VAL("wrong config1", 0 =3D=3D evsel->core.att=
r.config1);
>                 TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->core.att=
r.config2);
>                 TEST_ASSERT_VAL("wrong config3", 0 =3D=3D evsel->core.att=
r.config3);
> +               TEST_ASSERT_VAL("wrong config4", 0 =3D=3D evsel->core.att=
r.config4);
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> @@ -813,6 +816,15 @@ static int test__checkterms_simple(struct parse_even=
ts_terms *terms)
>         TEST_ASSERT_VAL("wrong val", term->val.num =3D=3D 4);
>         TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config3"))=
;
>
> +       /* config4=3D5 */
> +       term =3D list_entry(term->list.next, struct parse_events_term, li=
st);
> +       TEST_ASSERT_VAL("wrong type term",
> +                       term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_CO=
NFIG4);
> +       TEST_ASSERT_VAL("wrong type val",
> +                       term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM=
);
> +       TEST_ASSERT_VAL("wrong val", term->val.num =3D=3D 5);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config4"))=
;
> +
>         /* umask=3D1*/
>         term =3D list_entry(term->list.next, struct parse_events_term, li=
st);
>         TEST_ASSERT_VAL("wrong type term",
> @@ -2451,7 +2463,7 @@ struct terms_test {
>
>  static const struct terms_test test__terms[] =3D {
>         [0] =3D {
> -               .str   =3D "config=3D10,config1,config2=3D3,config3=3D4,u=
mask=3D1,read,r0xead",
> +               .str   =3D "config=3D10,config1,config2=3D3,config3=3D4,c=
onfig4=3D5,umask=3D1,read,r0xead",
>                 .check =3D test__checkterms_simple,
>         },
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 5152fd5a6ead..7e37f91e7b49 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -247,6 +247,8 @@ __add_event(struct list_head *list, int *idx,
>                                               PERF_PMU_FORMAT_VALUE_CONFI=
G2, "config2");
>                 perf_pmu__warn_invalid_config(pmu, attr->config3, name,
>                                               PERF_PMU_FORMAT_VALUE_CONFI=
G3, "config3");
> +               perf_pmu__warn_invalid_config(pmu, attr->config4, name,
> +                                             PERF_PMU_FORMAT_VALUE_CONFI=
G4, "config4");
>         }
>         if (init_attr)
>                 event_attr_init(attr);
> @@ -783,6 +785,7 @@ const char *parse_events__term_type_str(enum parse_ev=
ents__term_type term_type)
>                 [PARSE_EVENTS__TERM_TYPE_CONFIG1]               =3D "conf=
ig1",
>                 [PARSE_EVENTS__TERM_TYPE_CONFIG2]               =3D "conf=
ig2",
>                 [PARSE_EVENTS__TERM_TYPE_CONFIG3]               =3D "conf=
ig3",
> +               [PARSE_EVENTS__TERM_TYPE_CONFIG4]               =3D "conf=
ig4",
>                 [PARSE_EVENTS__TERM_TYPE_NAME]                  =3D "name=
",
>                 [PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]         =3D "peri=
od",
>                 [PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]           =3D "freq=
",
> @@ -830,6 +833,7 @@ config_term_avail(enum parse_events__term_type term_t=
ype, struct parse_events_er
>         case PARSE_EVENTS__TERM_TYPE_CONFIG1:
>         case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>         case PARSE_EVENTS__TERM_TYPE_CONFIG3:
> +       case PARSE_EVENTS__TERM_TYPE_CONFIG4:
>         case PARSE_EVENTS__TERM_TYPE_NAME:
>         case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
>         case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> @@ -898,6 +902,10 @@ do {                                                =
                          \
>                 CHECK_TYPE_VAL(NUM);
>                 attr->config3 =3D term->val.num;
>                 break;
> +       case PARSE_EVENTS__TERM_TYPE_CONFIG4:
> +               CHECK_TYPE_VAL(NUM);
> +               attr->config4 =3D term->val.num;
> +               break;
>         case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>                 CHECK_TYPE_VAL(NUM);
>                 break;
> @@ -1097,6 +1105,7 @@ static int config_term_tracepoint(struct perf_event=
_attr *attr,
>         case PARSE_EVENTS__TERM_TYPE_CONFIG1:
>         case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>         case PARSE_EVENTS__TERM_TYPE_CONFIG3:
> +       case PARSE_EVENTS__TERM_TYPE_CONFIG4:
>         case PARSE_EVENTS__TERM_TYPE_NAME:
>         case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>         case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> @@ -1237,6 +1246,7 @@ do {                                               =
               \
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG1:
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG3:
> +               case PARSE_EVENTS__TERM_TYPE_CONFIG4:
>                 case PARSE_EVENTS__TERM_TYPE_NAME:
>                 case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
>                 case PARSE_EVENTS__TERM_TYPE_RAW:
> @@ -1274,6 +1284,7 @@ static int get_config_chgs(struct perf_pmu *pmu, st=
ruct parse_events_terms *head
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG1:
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG3:
> +               case PARSE_EVENTS__TERM_TYPE_CONFIG4:
>                 case PARSE_EVENTS__TERM_TYPE_NAME:
>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index e176a34ab088..6e90c26066d4 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -58,6 +58,7 @@ enum parse_events__term_type {
>         PARSE_EVENTS__TERM_TYPE_CONFIG1,
>         PARSE_EVENTS__TERM_TYPE_CONFIG2,
>         PARSE_EVENTS__TERM_TYPE_CONFIG3,
> +       PARSE_EVENTS__TERM_TYPE_CONFIG4,
>         PARSE_EVENTS__TERM_TYPE_NAME,
>         PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD,
>         PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ,
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 7ed86e3e34e3..8e2986d55bc4 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -317,6 +317,7 @@ config                      { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_CONFIG); }
>  config1                        { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_CONFIG1); }
>  config2                        { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_CONFIG2); }
>  config3                        { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_CONFIG3); }
> +config4                        { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_CONFIG4); }
>  name                   { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
NAME); }
>  period                 { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
SAMPLE_PERIOD); }
>  freq                   { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
SAMPLE_FREQ); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b7ebac5ab1d1..fc50df65d540 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1427,6 +1427,10 @@ static int pmu_config_term(const struct perf_pmu *=
pmu,
>                         assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
>                         pmu_format_value(bits, term->val.num, &attr->conf=
ig3, zero);
>                         break;
> +               case PARSE_EVENTS__TERM_TYPE_CONFIG4:
> +                       assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_NUM);
> +                       pmu_format_value(bits, term->val.num, &attr->conf=
ig4, zero);
> +                       break;
>                 case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
>                         return -EINVAL;
>                 case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_HARDWARE:
> @@ -1474,6 +1478,9 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>         case PERF_PMU_FORMAT_VALUE_CONFIG3:
>                 vp =3D &attr->config3;
>                 break;
> +       case PERF_PMU_FORMAT_VALUE_CONFIG4:
> +               vp =3D &attr->config4;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -1787,6 +1794,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu,=
 void *state, pmu_format_call
>                 "config1=3D0..0xffffffffffffffff",
>                 "config2=3D0..0xffffffffffffffff",
>                 "config3=3D0..0xffffffffffffffff",
> +               "config4=3D0..0xffffffffffffffff",
>                 "name=3Dstring",
>                 "period=3Dnumber",
>                 "freq=3Dnumber",
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b93014cc3670..1ce5377935db 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -22,6 +22,7 @@ enum {
>         PERF_PMU_FORMAT_VALUE_CONFIG1,
>         PERF_PMU_FORMAT_VALUE_CONFIG2,
>         PERF_PMU_FORMAT_VALUE_CONFIG3,
> +       PERF_PMU_FORMAT_VALUE_CONFIG4,
>         PERF_PMU_FORMAT_VALUE_CONFIG_END,
>  };
>
>
> --
> 2.34.1
>
