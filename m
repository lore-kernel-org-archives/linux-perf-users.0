Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8AC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Dec 2022 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLOU2Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLOU2X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Dec 2022 15:28:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFB389FF
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Dec 2022 12:28:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id co23so515984wrb.4
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Dec 2022 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JjIuJwoR9wTN8Sx8derhfPzv/OsxT3cceK6Z7A/WHoQ=;
        b=LvN5iTT8R/QSYbPz7mXsqOFUavaWBKOlNl+c0TLgqXrga34sn4YnOflaWIiyHAeQdg
         TdXOHPMubGg/lbuqML2D57OUpQJpsE0uN8NItRm8YiGOloSZzPRnsnpSSBVtTgTHkXHI
         HpUQjuFqEaBOoc992ppxtc5VJcXbfMqTz0KI10jvsvqcy40LoPYe1YvN/L2GBYH7d79D
         OzhwjTRxQIdFmeQgonuddoMRznczf4EeKw4iIVAirXULdY4LSvm4RUdtIGOxFKWX+grN
         tqUqV+Wz0rjZqvhSY+O1fQlQTp6/V0b+OJdQFnIKqtt/kSsiy8MBa1V1Co/I709jBUYY
         UaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjIuJwoR9wTN8Sx8derhfPzv/OsxT3cceK6Z7A/WHoQ=;
        b=htK4nXJRtHpc0kIigEBs8L8S70aI9AC8PUKUPICMggyXXqcga9/pP7u8uglD1QINdA
         rBBoaaid0RDlwV3945EQVScTUjMMZUD9XbUgtXLzd89a5HAtFfKb8qZGu1f6mhp3SVxF
         C8AByX1SjA6QnS7rCwRYeJrFY0FYydLf3E5udynhmp9jg1qdd/doAqFMKWCnLPB8zArV
         kz+fz7MhuaF8Fjynu70SOb75u8zortp7fzzWmbEOB6rtC1YdZYVF5h9h8gNLz0qWRQAV
         +69rrZc0kMBBUfmFvrLZATjBGWwt2WHPnS2JXO4y4OsxpVZgFyDh4BpdHznCt8SG9mfX
         Y5Dg==
X-Gm-Message-State: AFqh2kqynLWDXmLhf6jauJkTJYwILPZ521ZEijMPWHRA3D0oDnDniVsp
        WbfxTGElqGojtoSfBNQp+qZClvGTUCR4Q7xCL11RWA==
X-Google-Smtp-Source: AMrXdXtltbnHE8Ch/pai13PGIQZlsdXxg1D6NW6UdZcSoR90uGuhcUSbleVbBscUAshlAZXWy+0t0fqxOzdhtpCm3Ls=
X-Received: by 2002:a05:6000:69b:b0:256:c249:b819 with SMTP id
 bo27-20020a056000069b00b00256c249b819mr182654wrb.654.1671136100534; Thu, 15
 Dec 2022 12:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20221215192817.2734573-1-namhyung@kernel.org>
In-Reply-To: <20221215192817.2734573-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Dec 2022 12:28:08 -0800
Message-ID: <CAP-5=fX8iGMbwHhu7nL0yPbh0xO6n9HCxJoZZddDPRRhxa=oYg@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf report: Improve srcline sort performance (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 15, 2022 at 11:28 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> I noticed a performance problem in the srcline/srcfile processing during
> perf report when it's using an external addr2line process.  I guess it's
> also helpful even if it uses the libbfd to get the srcline info.
>
> Also note that it's mostly from large (static) binaries, but smaller
> binaries should also benefit from the fix if they have a lot of samples.
>
> The first 5 patches are general fixes and updates.  The latter 4 patches
> implemented the actual speed-up.
>
> Let's test it with the perf tools itself.  Build a static binary like below.
>
>   $ cd tools/perf
>   $ make NO_JVMTI=1 LDFLAGS=-static
>
> Then run the perf test workload.
>
>   $ ./perf record -- ./perf test -w noploop
>
> And run the perf report with srcline sort key like this.
>
>   $ ./perf report -n -s srcline --stdio
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   #
>   # Total Lost Samples: 0
>   #
>   # Samples: 4K of event 'cycles:u'
>   # Event count (approx.): 3572938596
>   #
>   # Overhead       Samples  Source:Line
>   # ........  ............  ............
>   #
>       99.94%          4010  noploop.c:26
>        0.03%            14  ??:0
>        0.03%             1  perf.c:330
>        0.00%             1  wcscpy.o:0
>
> The problem is that it runs the addr2line when it processes each sample.
> But as you can see many samples can have same result.  IOW, if the samples
> have same address, we don't need to run the addr2line each time.
>
> So I changed the sort_key->cmp() to compare the addresses only and moved
> the addr2line from sort_key->collapse() so that they can be run after
> merging the samples with the same address.
>
> With the change, I can get a huge speed-up in processing srcline info
> while they generate the same output.
>
> Before:
>
>   $ ./perf stat -- ./perf report -s srcline > /dev/null
>
>    Performance counter stats for './perf report -s srcline':
>
>            15,397.13 msec task-clock:u                     #    0.993 CPUs utilized
>                    0      context-switches:u               #    0.000 /sec
>                    0      cpu-migrations:u                 #    0.000 /sec
>                3,810      page-faults:u                    #  247.449 /sec
>       54,516,351,820      cycles:u                         #    3.541 GHz
>       31,494,118,293      instructions:u                   #    0.58  insn per cycle
>        8,577,271,187      branches:u                       #  557.069 M/sec
>        1,216,165,520      branch-misses:u                  #   14.18% of all branches
>
>         15.505066606 seconds time elapsed
>
>         15.094122000 seconds user
>          0.396962000 seconds sys
>
> After:
>
>   $ ./perf stat -- ./perf report -s srcline > /dev/null
>
>    Performance counter stats for './perf report -s srcline':
>
>               105.66 msec task-clock:u                     #    0.994 CPUs utilized
>                    0      context-switches:u               #    0.000 /sec
>                    0      cpu-migrations:u                 #    0.000 /sec
>                3,275      page-faults:u                    #   30.995 K/sec
>          185,063,407      cycles:u                         #    1.751 GHz
>          142,470,215      instructions:u                   #    0.77  insn per cycle
>           34,584,038      branches:u                       #  327.311 M/sec
>            3,226,005      branch-misses:u                  #    9.33% of all branches
>
>          0.106270464 seconds time elapsed
>
>          0.074254000 seconds user
>          0.032871000 seconds sys
>
> The code is available at 'perf/srcline-v1' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (9):
>   perf srcline: Do not return NULL for srcline
>   perf report: Ignore SIGPIPE for srcline
>   perf symbol: Add filename__has_section()
>   perf srcline: Skip srcline if .debug_line is missing
>   perf srcline: Conditionally suppress addr2line warnings
>   perf hist: Add perf_hpp_fmt->init() callback
>   perf hist: Improve srcline sort key performance
>   perf hist: Improve srcfile sort key performance
>   perf hist: Improve srcline_{from,to} sort key performance

Nice 145x performance win!

Series: Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-report.c      |   1 +
>  tools/perf/util/hist.c           |  10 +--
>  tools/perf/util/hist.h           |   1 +
>  tools/perf/util/sort.c           | 129 ++++++++++++++++++++++++++++---
>  tools/perf/util/sort.h           |   1 +
>  tools/perf/util/srcline.c        |  20 +++--
>  tools/perf/util/symbol-elf.c     |  28 +++++++
>  tools/perf/util/symbol-minimal.c |   5 ++
>  tools/perf/util/symbol.h         |   1 +
>  9 files changed, 176 insertions(+), 20 deletions(-)
>
>
> base-commit: 818448e9cf92e5c6b3c10320372eefcbe4174e4f
> --
> 2.39.0.314.g84b9a713c41-goog
>
