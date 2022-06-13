Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E200C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Jun 2022 21:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350021AbiFMVkh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348863AbiFMVke (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Jun 2022 17:40:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FA2605
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 14:40:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x17so8692089wrg.6
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jun 2022 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rf94aztMu8q6rJgTVG04OMc6+8p9+/WQev0gF3cZvlM=;
        b=Pl0LzCNNO1w/frcAU/VtV4pRni7lpWufyksBYg0ZjtOrKos8OdbiT+BoNYZhqWB6vb
         DqwWQvTKHu6DZxoUX/MgPfuu/UcM1oInkCc+GJkXtYbQEHZPQB31n+lkNgWYZlY0V7Xm
         6YTPGTM14U3I+EPmnPxEdEfs/HYpaWNRnT7DLvQwj/GwZCx4o9QpkDebYbKzz93BBi6F
         zNJT2tIXpjY2ANM2FYpdibtmasHlDk7qyrTK3LCud9iClK4ulKXDwRaXO7WBUumzg5r+
         8kM/NHKyFFypCRWcrJgOG8xcJdrJ0hg8hk3wg31N+WhEL57L6LodHQjNV1rDXdiNAUtQ
         BVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rf94aztMu8q6rJgTVG04OMc6+8p9+/WQev0gF3cZvlM=;
        b=jbs+6Zc9i2x5SquB436ryc+PjEAKs3tRTxT42zVs+iJd/OYhFmNqQxsjMtCzlQiffY
         afl1n58m/Pz6TY3BlHneFFuupz6rD5zooS1xRi4ZCGRqrwadH5DK469vKB3BYuHTRYNa
         YecxcmZDOwl7zxGtdaPLAeVhdtaWqHLHU7jGAo4/+hRSKEnB+CrpCF+OjZ8dKiCT2Rw6
         FdlQ5AuZZBow0QiAguBlvk5A+GhZtFZ+9FQuCDR7Xcy62Ear6Cu6lJny8IIQuI8VoS5Y
         z4z2xKF0k9MEc8L4kyV6dI+jj2POfaWYlTzSQwZKzycvmWcy4zfjCWWjCJxoXWA/X0Pn
         5aww==
X-Gm-Message-State: AJIora9UD2KHCkmq88JqfcLK8Rc3EooYvSKtjX9Uliy7Mh88D27LEpOp
        Bh3PwRbB46nxWtW9VV17pGvaZAQChwW6QH5PJl/pqg==
X-Google-Smtp-Source: AGRyM1v2CFKS3VbNIYRjIRPm7XoBld31D8Xpf3SH96B8OY0SShLb01jlm5GHh/K4lKLv/PUop92YuIMJdNNl1gEXkdo=
X-Received: by 2002:a05:6000:1a8d:b0:219:e3f2:c092 with SMTP id
 f13-20020a0560001a8d00b00219e3f2c092mr1696458wry.375.1655156431586; Mon, 13
 Jun 2022 14:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220526224515.4088240-1-irogers@google.com>
In-Reply-To: <20220526224515.4088240-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Jun 2022 14:40:19 -0700
Message-ID: <CAP-5=fUQZgA_aaiv2t2Y8DMfU90LvgSrKpc3wn9EQW0m-2N=ww@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] JSON output for perf stat
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 26, 2022 at 3:45 PM Ian Rogers <irogers@google.com> wrote:
>
> Parsing the CSV or text output of perf stat can be problematic when
> new output is added (columns in CSV format). JSON names values and
> simplifies the job of parsing. Add a JSON output option to perf-stat
> then add unit test that parses and validates the output.
>
> This is a resend of two v2 patches:
> https://lore.kernel.org/lkml/20210813220754.2104922-1-cjense@google.com/
> https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
> with a few formatting changes and improvements to the linter.

Still looking for reviews for these 2 changes. Thanks!
Ian

> v5. Drops the merged CSV check, fixes a json test issue found by
>     Arnaldo and a typo.
>
> v4. Does some minor fixes to the json linter.
>
> v3. There is some tidy up of CSV code including a potential memory
>     over run in the os.nfields set up caught by sanitizers. To
>     facilitate this an AGGR_MAX value is added. v3 also adds the CSV
>     testing.
>
> v2. Fixes the system wide no aggregation test to not run if the
>     paranoia is wrong. It also makes the counter-value check handle
>     the "<not counted>" and "<not supported>" cases.
>
> Claire Jensen (2):
>   perf stat: Add JSON output option
>   perf test: Json format checking
>
>  tools/perf/Documentation/perf-stat.txt        |  21 +
>  tools/perf/builtin-stat.c                     |   6 +
>  .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++
>  tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
>  tools/perf/util/stat-display.c                | 384 +++++++++++++-----
>  tools/perf/util/stat.c                        |   1 +
>  tools/perf/util/stat.h                        |   2 +
>  7 files changed, 550 insertions(+), 106 deletions(-)
>  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
>  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
>
> --
> 2.36.1.124.g0e6072fb45-goog
>
