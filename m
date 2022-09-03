Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D786ECAAD4
	for <linux-perf-users@archiver.kernel.org>; Sat,  3 Sep 2022 06:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiICGwk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 3 Sep 2022 02:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiICGwj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 3 Sep 2022 02:52:39 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE2BCC2D
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Sep 2022 23:52:38 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3376851fe13so33386627b3.6
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Sep 2022 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ReE86CAuXFmaMHJ7YOUAJHviWpFsT5ozIc0Vr/5is54=;
        b=eFWMH5qnQtV84oUmcsyzFEuWFg1a1ann3d3GfyO1fKAPei7VpCFvt3PEKfE/LWBD2/
         Pj0IwkfG+2UrAk+Zq2lM3COEfUfFcFCL7RYZ8nVuQQVQR9g4fxfif/tAASgmZvNSwy5z
         Y5sDf66a6OFuM+7OPgHzMT8Vh6WqMdzYtjmRyUVf5YOYizLf6W8vQPfS7XALBBy/W9su
         Z79aaLmYlUpfGtB+Cy1bI/PK7gDqEsmkPIwZLw3aKLtCIw/0Q98W6ps9rMgv8UCULCYK
         HJ//3s87yITwqRnqEvMGVO5eUlnL9CUtmH25yMPL+B7zcobtXx6W/ibisQxa5Qiip/0D
         5Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ReE86CAuXFmaMHJ7YOUAJHviWpFsT5ozIc0Vr/5is54=;
        b=jrWzy0EQe+9M0LD3wAcEGsO6Kn5zqIKnr0itvtBNzQ1APhlpBOB/TiXqTTGDZnhQlm
         0nLE9zOk7dM9UTthIEVN4BHuLPJScp8RVZasiMb/3TV35DECF9SzHuM80KcZESFvJN7J
         Nmq44Pshqm9z9pv5WrB7T7Jr5wAX2i4gNshhDhKJDL+bhtSEA6mXnqVVaniwAu+TLA3T
         nu5zbSXehxpzqigwshC/E3Kdy25lbqlcmqWNc6XMgDZjgv3z2VRgI/gYpLkC4aIxml9l
         3FFAW2RlYqieqVFqa3O1hY+3jbRiZn7fVo+pRBQfw+jQYL5lrld2u51/vTfdeVaOZZ4D
         aEjQ==
X-Gm-Message-State: ACgBeo3EfMGVfq1PvIcHLhC1KUwwUZA04ib3FDgEzHpq7NHzhlFvLVZV
        s7mRAwPlobay6tw4DwsHYePbKyYMhBz0rM2yPArNtVdF934=
X-Google-Smtp-Source: AA6agR5NLwbY37rIKDr5iizkgRfVc6QFlkp9VsnBMmmRAefLTFJUEUrxxvWaur/K+fvnqZ3yhMeQo3IQUNJX6X0GBnI=
X-Received: by 2002:a81:6808:0:b0:345:be:890a with SMTP id d8-20020a816808000000b0034500be890amr3134610ywc.267.1662187957704;
 Fri, 02 Sep 2022 23:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org>
In-Reply-To: <20220903000210.1112014-1-namhyung@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 3 Sep 2022 08:52:01 +0200
Message-ID: <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
>
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skip the test if it failed.
>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/sigtrap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..7057566e6ae4 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>         if (fd < 0) {
>                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +               ret = TEST_SKIP;

Wouldn't we be interested if perf_event_open() fails because it could
actually be a bug? By skipping we'll be more likely to miss the fact
there's a real problem.

That's my naive thinking at least - what do other perf tests usually
do in this case?

Thanks,
-- Marco
