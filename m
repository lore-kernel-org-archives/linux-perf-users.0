Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E9C43217
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKHXYV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKHXXw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65CE1D
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 15:23:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g12so23256262wrs.10
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYY27CHCBp8aK7/t2oC4sqeVRM8MWfwLNJDQiNepGd0=;
        b=FlSm+XMleqvvRQunx5UXOGP84aWOdZ8IuY3HzZdNr6efOzgmUuAgM1W6gl42lDTL/t
         1UYRuXiqhGR7UW+LKv8B1xRlUXO68/l9zwooMrXPris7Q+9RQMN5//EDchFpH2Ojwest
         aOXgK0wSVaZY1bk+zNfKfJRiv05ujyzyWSHBhvES14fDrn1EXexkkgtl4KuX0OMQh8bd
         Ffvqf3CDH3R+/HK4O45wRlBVoU0L7ui26iTv5a0NTzEVYgBLdHsym41NE0CNAe2qM6BA
         vZ+G4s1H423nZoMjTDk23RKrWfdaxTeCx2MLWAdElZ4xzOYBVoZPwOkC+S9Xh0ov6LcC
         DNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYY27CHCBp8aK7/t2oC4sqeVRM8MWfwLNJDQiNepGd0=;
        b=qdhGNaBIH+6UjRl6BczM5BM/5seCs7V9psLf2lKdgLEpti1xmaOg6n0ZPeolixqWvL
         6dbPxgXLevo4OzmguW9I4Mn3tiwrzE3jdCpK+ZUDh8Axrt1InxenMVEreDmL+aZ+DDuA
         uZ+pFxpvjQkYsjTIgJf53KsPHfPxg+XVArMftpm4A7DakGlOF7Onu8X0Yz3m20EXsxkr
         ltzO/vKjgu+1oowWs5Pl1rdRF2MLqS1LaeSW2pDV36cUZm2KatF3Bn0VkGTixUsEaDBs
         OpKYtDscZB0uUQ1NGpJAAooPlmrsNAMMzTLQU6VEMIBAOoxfPac9eyLSdi+5eooXUXL+
         9Q9g==
X-Gm-Message-State: ACrzQf0SokjPWhVSRTe8M/MIRJJVloAjsd/pgFBkzpf1eFJ+TB9JmsSn
        oAdEYiTtlgk7RMLzEfuaIcxlaH/o79kaawKzduJrekvUmbir8A==
X-Google-Smtp-Source: AMsMyM5h7J0P/PUzGAOqi3WOJZ+P94yBxjYzQo/QJvzJmKG8jVSwbooLinTm0fu+SLtBUtINwBjEYvG/E2GKMz6iBOg=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr36330718wrb.300.1667949799496; Tue, 08
 Nov 2022 15:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-9-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-9-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:23:07 -0800
Message-ID: <CAP-5=fXWdaGr3cNsUMWqrb_be38z01Eq5UhyPU6eUSLJNQHyQg@mail.gmail.com>
Subject: Re: [PATCH 8/9] perf stat: Fix condition in print_interval()
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

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The num_print_interval and config->interval_clear should be checked
> together like other places like later in the function.  Otherwise,
> the --interval-clear option could print the headers for the CSV or
> JSON output unnecessarily.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index aab2576bd40f..a10af26c26ab 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -902,8 +902,8 @@ static void print_interval(struct perf_stat_config *config,
>                 sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
>                                  ts->tv_sec, ts->tv_nsec);
>
> -       if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
> -                        || config->interval_clear) {
> +       if ((num_print_interval == 0 || config->interval_clear) &&
> +                       !config->csv_output && !config->json_output) {
>                 switch (config->aggr_mode) {
>                 case AGGR_NODE:
>                         fprintf(output, "#           time node   cpus");
> --
> 2.38.1.431.g37b22c650d-goog
>
