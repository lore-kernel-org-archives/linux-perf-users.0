Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C46AC6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Apr 2023 15:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjDRPzW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjDRPzV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Apr 2023 11:55:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1283D6E9D
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 08:55:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso57225e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681833318; x=1684425318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY9pHq2dLU+St3NtjkMXoaWK13Cg/WiXep4UpYBIrPw=;
        b=mm8wh/FA5a4YQFZ/iAjX7fNpwhPH2eRnAfJLRjxFmcE1yFZ9rVIyc4VoANT2TORCvd
         piR+Xj7jxuJz9T2yG/+bgMA74j11th+pwpc/X7Biiduw+HK9hqZsYAVrMfQl6xzh1xkv
         kfeUehN6KNSTG/ef8Ia+GQzfZ47axFK1Alfbb+IvzHlikbVujTOFWMVYnrDgzMnfO47k
         17VauL27vMldDTQk9YUFIGkbwpeEvKByF9wXiXm4FkpX6BMTbVBoyzuONCnlGlBHLXIE
         0vf1hJPt5d/HUlcnI7H2SKTQY8PZjlVtbOyPlrGiC+YhWKg6P9JUc2KdoPoGnrrlkuNZ
         ntLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833318; x=1684425318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pY9pHq2dLU+St3NtjkMXoaWK13Cg/WiXep4UpYBIrPw=;
        b=DKgmoo+ztr0CbyKdSQ4RtEg8qzfVgsPP2DWjTKsvxNZw2owAuyKgzGYd60ieH5uiNK
         lmvTc+7ZYLPHcTyr6dlzptddlaA7GnrcWiu3H6T8nfi00q5O3zayVJP2p+KeZOmJWqVu
         D0oHmWcwxJ9YTVqwvkWYWsEmUtmmoHkWuYt8otmvCUNuSr8bORNpI3yFLWwAGYiyKs6l
         fuajJaG9gDZmPtYtBEgFE5gTseqk04Tr5oYe9MJ7crfAMZUH4Fbfw5knsRLZkCMBGP27
         4DXWafqrfCu9JsSKcZj/aN7H9NuOmrQmLO5vOrHKEMzXv73QnDhbZHtT6WBn5Y8R5KxI
         FGkA==
X-Gm-Message-State: AAQBX9eddLRolHmpELTwTuGC3Ep2Xk8E2HAQOfj0WFSuDAOSQi7N6IX6
        IW1Ve0+g3rcyEtkJh4Uedwz+cMK99ygD45dMB/+Eqw==
X-Google-Smtp-Source: AKy350bJQ5DYzvXJKpTEBvO2yIbqvTi0KxkrimYpzhxKffSt3yNKaKZCVEYlf4iOu3eMnvQ1FTZRWAuTH58moz688qI=
X-Received: by 2002:a05:600c:470b:b0:3f0:aeef:e2da with SMTP id
 v11-20020a05600c470b00b003f0aeefe2damr174184wmo.3.1681833318274; Tue, 18 Apr
 2023 08:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <ZD68RYCVT8hqPuxr@kernel.org>
In-Reply-To: <ZD68RYCVT8hqPuxr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 08:55:04 -0700
Message-ID: <CAP-5=fXr6Nc9qkaN+yHJRDNsg6nMxJiV9p7o9OR5cByeey-w0w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix use before NULL check introduced by
 map__dso() introduction
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 18, 2023 at 8:50=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> James Clark noticed that the recent 63df0e4bc368adbd ("perf map: Add
> accessor for dso") patch accessed map->dso before the 'map' variable was
> NULL checked, which is a change in logic that leads to segmentation
> faults, so comb thru that patch to fix similar cases.
>
> Fixes: 63df0e4bc368adbd ("perf map: Add accessor for dso")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will@kernel.org>
> To: James Clark <james.clark@arm.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sorry for the breakage!
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c    | 7 +++----
>  tools/perf/ui/browsers/hists.c | 4 ++--
>  tools/perf/util/sort.c         | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 8fba247b798ca307..006f522d0e7f6a18 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1075,8 +1075,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
>                 return 0;
>         }
>
> -       dso =3D map__dso(al.map);
> -       if (!thread__find_map(thread, *cpumode, start, &al) || !dso) {
> +       if (!thread__find_map(thread, *cpumode, start, &al) || (dso =3D m=
ap__dso(al.map)) =3D=3D NULL) {
>                 pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", st=
art, end);
>                 return 0;
>         }
> @@ -1106,9 +1105,9 @@ static int map__fprintf_srccode(struct map *map, u6=
4 addr, FILE *fp, struct srcc
>         unsigned line;
>         int len;
>         char *srccode;
> -       struct dso *dso =3D map__dso(map);
> +       struct dso *dso;
>
> -       if (!map || !dso)
> +       if (!map || (dso =3D map__dso(map)) =3D=3D NULL)
>                 return 0;
>         srcfile =3D get_srcline_split(dso,
>                                     map__rip_2objdump(map, addr),
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index ab70e5f5fad236e5..69c81759a64f938f 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2499,9 +2499,9 @@ add_annotate_opt(struct hist_browser *browser __may=
be_unused,
>                  struct map_symbol *ms,
>                  u64 addr)
>  {
> -       struct dso *dso =3D map__dso(ms->map);
> +       struct dso *dso;
>
> -       if (!ms->map || !dso || dso->annotate_warned)
> +       if (!ms->map || (dso =3D map__dso(ms->map)) =3D=3D NULL || dso->a=
nnotate_warned)
>                 return 0;
>
>         if (!ms->sym)
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f2ffaf90648e469e..31b1cd0935e277ba 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1568,7 +1568,7 @@ static int hist_entry__dcacheline_snprintf(struct h=
ist_entry *he, char *bf,
>
>         if (he->mem_info) {
>                 struct map *map =3D he->mem_info->daddr.ms.map;
> -               struct dso *dso =3D map__dso(map);
> +               struct dso *dso =3D map ? map__dso(map) : NULL;
>
>                 addr =3D cl_address(he->mem_info->daddr.al_addr, chk_doub=
le_cl);
>                 ms =3D &he->mem_info->daddr.ms;
> --
> 2.39.2
>
