Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B149C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 May 2022 17:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386489AbiEBRIm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 May 2022 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiEBRIl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 May 2022 13:08:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390027B
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 10:05:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so10503358wrn.8
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILRP524+2fdLDTShu4hSsO+6dehNvYTua716YzeA9Fg=;
        b=YDWfLX1xSIUwsEMnssgIoCHQO8OLl2q81ADfKyheoORpJWFFKfJBcZNs8cOj83RvXy
         31erF0OeLY0X5e2EhHdMzi09UQNQgxuAiAaP1aKGjsflBTGPEjKXLnNcdjdpQ328cwxd
         i+6YiDC7OMst6lOmjI8msSGBFxio8+XY4fEu8oHviRF9yG3QufHYzpoMtYWWUt6ieB4m
         KodYbVNfW83VJ00k/LeDcrDRb+kuEDRXc/+3am4mBrBGa1uZwbG8e5/gWuytzgFgeyYR
         y8JFiIwQe5GmA8Q7np9BTS9tZiTlgFfEBA3BYB4W+tcqvvfd84jUfhGepDb3Cz6DItSA
         z4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILRP524+2fdLDTShu4hSsO+6dehNvYTua716YzeA9Fg=;
        b=InjwgcQCvAfShr0ZOTj9/ZZsw8GHbEA3ZHtadBEQddfoj6uyBWHBi2/iFLNJl+OPGn
         8sGSwYR1RQ2eBKYKELJyBt/ewys6YSjIN4IMHny+iFyrZPwacAGBVpRa9TB0m5uiKJBU
         hfhJgocBnZMSL0oUOgg/6RtXKrtlKWxrYGPWHC4x5A3QfhYoRFyJh8AOSt+wNmHVE+DT
         D3jVJr7/rZhWinx26Q4+BilVzOJjNlyFDyZ+ZO4kP4ojI0ikQu9jXIZKD7UE738cA02q
         pRnHEaOBmTKFUjwcPBYJp5mZZ9XIXkcYZmHIZL7/jm30dFoIEUXFIOTveE4rwxdzia8E
         mfXg==
X-Gm-Message-State: AOAM533Z4aVd8dtYLh5WJ5Zx7e/LLfdj/dHLWOe1g3STz+FSta9EJRmw
        f5GBXjUk/2WIoerwvuYTsy9f3I2dl+fYVLnLO33kXQ==
X-Google-Smtp-Source: ABdhPJwapNE9nWFgzhKYpaQKNHhqIs/ouKZtT/FIYeoMKh13aLfp0xSWPQA3PWYkrL+UK68ul/j7zF71aSSPTfuVTlY=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr10089318wro.654.1651511109668; Mon, 02
 May 2022 10:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com> <20220430062324.1565215-5-irogers@google.com>
 <b0551170-f559-4801-1cb4-3653b9685474@intel.com>
In-Reply-To: <b0551170-f559-4801-1cb4-3653b9685474@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 2 May 2022 10:04:57 -0700
Message-ID: <CAP-5=fWwDEW=Vhw1B9i3JN9wr1FJ_+dfaWXjJ7vXeKWfZNaz0g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] perf cpumap: Handle dummy maps as empty in subset
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 2, 2022 at 9:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 30/04/22 09:23, Ian Rogers wrote:
> > perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
> > respect that.
>
> I think this might be the opposite of what I am trying to do, which is
> enable all_cpus to represent all the "cpu" values (3rd parameter of
> perf_event_open()) to iterate over including -1 so that per-thread and
> per-cpu events can be mixed.

Wouldn't you iterate over the cpus of the evsel? I'm not sure using
all_cpus in that way makes sense, it also violates the definition of
empty.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c   |  4 ++--
> >  tools/perf/tests/cpumap.c | 10 +++++++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 384d5e076ee4..9c83675788c2 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
> >  /** Is 'b' a subset of 'a'. */
> >  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
> >  {
> > -     if (a == b || !b)
> > +     if (a == b || perf_cpu_map__empty(b))
> >               return true;
> > -     if (!a || b->nr > a->nr)
> > +     if (perf_cpu_map__empty(a) || b->nr > a->nr)
> >               return false;
> >
> >       for (int i = 0, j = 0; i < a->nr; i++) {
> > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > index f94929ebb54b..d52b58395385 100644
> > --- a/tools/perf/tests/cpumap.c
> > +++ b/tools/perf/tests/cpumap.c
> > @@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
> >       struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
> >       struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
> >       struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
> > +     struct perf_cpu_map *d = perf_cpu_map__dummy_new();
> > +     struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
> >       char buf[100];
> >
> >       TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
> >       cpu_map__snprint(c, buf, sizeof(buf));
> >       TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
> > -     perf_cpu_map__put(b);
> > +
> > +     TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
> > +     cpu_map__snprint(e, buf, sizeof(buf));
> > +     TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
> > +
> >       perf_cpu_map__put(c);
> > +     perf_cpu_map__put(d);
> > +     perf_cpu_map__put(e);
> >       return 0;
> >  }
> >
>
