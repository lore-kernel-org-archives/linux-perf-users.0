Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D3C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiKNST5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiKNSTu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:19:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FECBE03
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:19:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y16so19796864wrt.12
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PESbuKX8wYs7f7ll/+sNjX6qgPThW9GOG5aoQkZl7hU=;
        b=Aprz0G9eHJcUQ1eL/YCsPTh4/3H0Aj0//WSViqcAUZo+QyoJUooJTbsA8JvvXq/dbr
         kb84M3FO6Qp+oCcX68kSI6EfyUzztd3HYQkjbAPIbemqQN+p1EhTg7uB4UveMOnQKj4t
         fJGwT1VwXrGKpMKxxsfaGcjtRxVBXdEqZCRqkHRkzY3o8FQ9vcsAoS69pOXgd+LHu8sr
         pnmFQfKa6jyt1vWPuqEJ/L+p/8drQlJypsB/43Wjq8F97VsOR9o+PbXT6Z5hRoNth5uM
         dvEqrqcJe7EZHay6aOSFK2I9dOCSclCp3yu+6sq9Hqb3nGedRZYwuope8WqUY9e9iNW/
         TLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PESbuKX8wYs7f7ll/+sNjX6qgPThW9GOG5aoQkZl7hU=;
        b=5beDqfwaB4zPFIzD7XoOTHH34V8LXge1x0Plv5b+SxpEtQlEuPKcsWLIOMFkB8UYjE
         15/a3Lap+T247PqBeqkwqDIVQo+Ca/e46cKr0isItDqDjdXijijo1Phttl8Y5n0BDIXa
         l7Ss7BBpvuK8QzRRpgO5HeleAuBxSa9XB6k6yhdMldt/xQ6z8K/r3q9uV60OJa4EWTRZ
         ElMQVbB3VRSK7zyEUCHC8Fx9gGHzwl0dV+2LZY0ptcNATJFdjnIunRZYQJTxYldTRHC2
         cwrqdEAPAG+rXOzuCU7HQvMdK9TDD4bmQ+pN+xsQpM2u7/hut7YW7C/vrEdstnc6m+D+
         V9Qw==
X-Gm-Message-State: ANoB5pmtQtmJSgbccyuRHfsFHhVh6IFE/hN/1Lm//ggFnUDvkeMG4g4a
        gwlfr4ZcBWbNh4TlrfsvHV4bD63HOVmsUpehR7BwHA==
X-Google-Smtp-Source: AA0mqf4L1ubNrUNtpw2RmbsAJYRPEJla/VKvYYa7+enHUdVcW6ZHC3sQN15aliy+vzkaVU7Rx48By/ems4/QUoMjkHk=
X-Received: by 2002:a5d:6e89:0:b0:228:dd1d:8a42 with SMTP id
 k9-20020a5d6e89000000b00228dd1d8a42mr8568799wrz.375.1668449987445; Mon, 14
 Nov 2022 10:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-6-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:19:31 -0800
Message-ID: <CAP-5=fXpKyqYzUxP73V7q6avJ2YRK-CtE5LzYdtDCrZXvrXtaw@mail.gmail.com>
Subject: Re: [PATCH 05/11] perf stat: Clear screen only if output file is a tty
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 11, 2022 at 7:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The --interval-clear option makes perf stat to clear the terminal at
> each interval.  But it doesn't need to clear the screen when it saves
> to a file.  Make it fail when it's enabled with the output options.
>
>   $ perf stat -I 1 --interval-clear -o myfile true
>   --interval-clear does not work with output
>
>    Usage: perf stat [<options>] [<command>]
>
>       -o, --output <file>   output file name
>           --log-fd <n>      log output to fd, instead of stderr
>           --interval-clear  clear screen in between new interval
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d5e1670bca20..1d79801f4e84 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2403,6 +2403,14 @@ int cmd_stat(int argc, const char **argv)
>                 }
>         }
>
> +       if (stat_config.interval_clear && !isatty(fileno(output))) {
> +               fprintf(stderr, "--interval-clear does not work with output\n");
> +               parse_options_usage(stat_usage, stat_options, "o", 1);
> +               parse_options_usage(NULL, stat_options, "log-fd", 0);
> +               parse_options_usage(NULL, stat_options, "interval-clear", 0);
> +               return -1;
> +       }
> +
>         stat_config.output = output;
>
>         /*
> --
> 2.38.1.493.g58b659f92b-goog
>
