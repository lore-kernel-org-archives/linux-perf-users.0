Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2783C71133
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 04:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjHYELm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 00:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjHYELS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 00:11:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB91FCE
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:11:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40a47e8e38dso97701cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936673; x=1693541473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGQbi4qmX8ZpivuXyzbHSRWTg6lGjiVRdy6WqlGiSaM=;
        b=te32Nw242oXZzi9Ccu/peBttZA8hT6WLXoIWZFXlALjl3f5qw9T/ny+mFeSEPaeTLx
         4pNwkRFHAJqGEOJqcFXSihTMikuEHd/3FTdRKjWNtnP31Gm7Pn5RDuqRfhxZnhdzZY6e
         GBVNY86cjVz/nIMuwyfb9HPclHwIFRf5J1DzTWsl9TtCg5TgsYfNWCla5gm5eVwd4JDM
         IVPNcyQ7iXtq/oqYDrNTZrD4HTS91dY0tuvN/Ibry9M5rf+RqigHHqwjzs2ywGf2X+Fb
         hWDzjTwVbEkc54AXdxBxceWDvEs0AmZw62Nqnbo7EP6kNEOXDSFaLIXRAseTc9b08Xpz
         6gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936673; x=1693541473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGQbi4qmX8ZpivuXyzbHSRWTg6lGjiVRdy6WqlGiSaM=;
        b=cZ49NFmUty991EON7O50PtIUze6O999o+rZFTvqjlfwSKlB2zA+Jq0amiH/jIAQVIt
         5fcRE5pA8KZ1czGfHJuAh4bDFUbsMs4ZAukuLWw6rxQSAKA28yEgA1KKkPyJNNQfAAHt
         FtAcn2Qc0odUQvdqFg4nMoxIwGCbtSwKH7KQtNnPqThqTojU9X/oCAao+12zr5Nkh4DN
         wuQ/YrxelJXkkjdjHEyjuHmO2139CSo9z59zi/S+kN5CwTTl4jLooqIn5xXRTIEyFgvL
         Ak0drwV93PXiyRzOZOxFRfZHRkx4eH8r0SKDnCkSMqzHoL+Zq3E9mjKuTj5fKbF7fPQi
         JYXQ==
X-Gm-Message-State: AOJu0YyKBtRyqJ0UtuHX8G+YHh3qJyMvCEKkUXwePsvJB754bgXHFicl
        LUwaxXJUyQG7ESp61MwYZw8RVkpErWXnHJOtEB4beQ==
X-Google-Smtp-Source: AGHT+IGaLGeIZuaLsveguTS8zXTDSm99bm8F8isv6I53K2aDvLD3+cizMyvuX0kIMcjamLNG9idFBYY9bkeWFnZl4dw=
X-Received: by 2002:ac8:7f96:0:b0:3f8:5b2:aef0 with SMTP id
 z22-20020ac87f96000000b003f805b2aef0mr195327qtj.24.1692936673229; Thu, 24 Aug
 2023 21:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-2-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:11:01 -0700
Message-ID: <CAP-5=fWK=wMuC1e9JE0MW8de4pNKH=48f8ydjCbMLjQ3S4zEjg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] perf pmu: "Compat" supports matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 1:36=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU event.
> Since a Compat value can only match one identifier, when adding the
> same event alias to PMUs with different identifiers, each identifier
> needs to be defined once, which is not streamlined enough.
>
> So let "Compat" supports matching multiple identifiers for uncore PMU
> alias. For example, the Compat value {43401;436*} can match the PMU
> identifier "43401", that is, CMN600_r0p0, and the PMU identifier with
> the prefix "436", that is, all CMN650, where "*" is a wildcard.
> Tokens in Unit field are delimited by ';' with no spaces.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/util/pmu.c | 33 +++++++++++++++++++++++++++++++--
>  tools/perf/util/pmu.h |  1 +
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ad209c8..6402423 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -776,6 +776,35 @@ static bool pmu_uncore_alias_match(const char *pmu_n=
ame, const char *name)
>         return res;
>  }
>
> +bool pmu_uncore_identifier_match(const char *id, const char *compat)

static?

> +{
> +       char *tmp =3D NULL, *tok, *str;
> +       bool res;

Initialize to false to avoid the goto.

> +       int n;

Move into the scope of the for loop, to reduce the scope.

> +
> +       /*
> +        * The strdup() call is necessary here because "compat" is a cons=
t str*
> +        * type and cannot be used as an argument to strtok_r().
> +        */
> +       str =3D strdup(compat);
> +       if (!str)
> +               return false;
> +
> +       tok =3D strtok_r(str, ";", &tmp);
> +       for (; tok; tok =3D strtok_r(NULL, ";", &tmp)) {
> +               n =3D strlen(tok);
> +               if ((tok[n - 1] =3D=3D '*' && !strncmp(id, tok, n - 1)) |=
|
> +                   !strcmp(id, tok)) {

We use fnmatch for a similar check:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1982

> +                       res =3D true;
> +                       goto out;

With "res=3Dfalse;" above this can just be a regular break.

Thanks,
Ian

> +               }
> +       }
> +       res =3D false;
> +out:
> +       free(str);
> +       return res;
> +}
> +
>  struct pmu_add_cpu_aliases_map_data {
>         struct list_head *head;
>         const char *name;
> @@ -847,8 +876,8 @@ static int pmu_add_sys_aliases_iter_fn(const struct p=
mu_event *pe,
>         if (!pe->compat || !pe->pmu)
>                 return 0;
>
> -       if (!strcmp(pmu->id, pe->compat) &&
> -           pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> +       if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> +           pmu_uncore_identifier_match(pmu->id, pe->compat)) {
>                 __perf_pmu__new_alias(idata->head, -1,
>                                       (char *)pe->name,
>                                       (char *)pe->desc,
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b9a02de..9d4385d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -241,6 +241,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head=
, struct perf_pmu *pmu,
>  char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>  const struct pmu_events_table *pmu_events_table__find(void);
>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +bool pmu_uncore_identifier_match(const char *id, const char *compat);
>  void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>
>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval)=
;
> --
> 1.8.3.1
>
