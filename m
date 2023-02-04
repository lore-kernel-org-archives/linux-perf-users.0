Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8AC61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Feb 2023 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjBDVZs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Feb 2023 16:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjBDVZr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Feb 2023 16:25:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7FE234F4
        for <linux-perf-users@vger.kernel.org>; Sat,  4 Feb 2023 13:25:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j25so3848669wrc.4
        for <linux-perf-users@vger.kernel.org>; Sat, 04 Feb 2023 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QucXsCUGkAYvMM/m5+lQnUtugoTYxql3JyDPSNTCSc=;
        b=gMgnnl4uis9wwGEAHmp91wWTN6meZgAsGLuzViwo3jWh+ke27ZTYyh0hM2AFm3dmsl
         fpU/2t2R9T0+r+de/yRta7sMJaNAA+z/JUNyJp/3VGmj5nHedUDLMncJKnP7q/xSg7D3
         GmiVdUZ+I1Li+cl2Ky6bItiKKioQ6Zi9bu/ULaVFhvBTTZOdD5LmKGQ+OQ+Goec93wIG
         5npijm0lwYSo+Tf4foSxd4Y1YFt24OnkmqMk8pelStoDWhCh6h1kUecYwA1ZMPGcFm1S
         Bb6hdQcRQhh0pG2mNwUP4CFgsl8BDCnMNBuDJsTRBZHVVZZ1y5WnUqs8OyK7p0jyU4Fz
         8CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QucXsCUGkAYvMM/m5+lQnUtugoTYxql3JyDPSNTCSc=;
        b=NLT35bRgMyJGoydcesNFxjr68SW0ojR5Xmx5K1zshZS2QiAUuYd2T+NDDfJpcOewx7
         KMsJrzfyYfQ+/q1eSSNcwQC9y8xJR+BMbZvjxnDJ/SIit3bADMA80MEWMIyh9ltg20fM
         9f4BwkncE+4kIq2Mn68PIK00qEOg5wuP05ap5KBlCZY22mKYg3EomIvmBfAAs0+PYZDM
         7JpMst8z3uk1llL3h7JO7EZMbdAD6U9cTodthqAqUC7C7HB9DnmCWGuynmHuRoOeJH93
         vLqzgjuhOuRqLAV6dG4gSxVgX4yDc3ZfHi5xeFUiARv08TWizQzD3g3cr4ZdBoJm1Xde
         6PoA==
X-Gm-Message-State: AO0yUKWS5EhRMS3qwF3eUvGXGsTqJRepj7GP6zgZzb6nUv6qyq7O0Zs6
        7IkotbWvSHdqJAW1TBTgeRF8s2y9lzXjIJRfD/IJsg==
X-Google-Smtp-Source: AK7set9CbvgLfEJ2jn5/zRiDcIDRmDUMIjRHSnXWFoR7u6wNniF5tZuwENqZy7NCTcl7ArQhLKCbViMrWUHcVJ3zCEg=
X-Received: by 2002:a05:6000:16c4:b0:2c3:7ee6:e3ad with SMTP id
 h4-20020a05600016c400b002c37ee6e3admr632269wrf.289.1675545944934; Sat, 04 Feb
 2023 13:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com> <20230126233645.200509-16-irogers@google.com>
 <Y91rYT5eBOFUHsJK@kernel.org>
In-Reply-To: <Y91rYT5eBOFUHsJK@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 4 Feb 2023 13:25:31 -0800
Message-ID: <CAP-5=fVSVURfMiDQYL8LSnhGEQ4VSA4EcMvmW6pdfLEtJa7ZNw@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] perf jevents: Run metric_test.py at compile-time
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Feb 3, 2023 at 12:15 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 26, 2023 at 03:36:45PM -0800, Ian Rogers escreveu:
> > Add a target that generates a log file for running metric_test.py and
> > make this a dependency on generating pmu-events.c. The log output is
> > displayed if the test fails like (the test was modified to make it
> > fail):
> >
> > ```
> >   TEST    /tmp/perf/pmu-events/metric_test.log
> > F......
> > ======================================================================
> > FAIL: test_Brackets (__main__.TestMetricExpressions)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "tools/perf/pmu-events/metric_test.py", line 33, in test_Brackets
> >     self.assertEqual((a * b + c).ToPerfJson(), 'a * b + d')
> > AssertionError: 'a * b + c' != 'a * b + d'
> > - a * b + c
> > ?         ^
> > + a * b + d
>
> Added this:
>
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index 05806ecfc33c12a1..f533e76fb48002b7 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -38,6 +38,7 @@ arch/*/include/generated/
>  trace/beauty/generated/
>  pmu-events/pmu-events.c
>  pmu-events/jevents
> +pmu-events/metric_test.log
>  feature/
>  libapi/
>  libbpf/
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b7d9c42062300d04..bac9272682b759e9 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1103,6 +1103,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
>                 $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>                 $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
>                 $(OUTPUT)pmu-events/pmu-events.c \
> +               $(OUTPUT)pmu-events/metric_test.log \
>                 $(OUTPUT)$(fadvise_advice_array) \
>                 $(OUTPUT)$(fsconfig_arrays) \
>                 $(OUTPUT)$(fsmount_arrays) \

Acked, thanks!

Ian
