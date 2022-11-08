Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A7C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 23:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKHXT5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiKHXT4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 18:19:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63C220E7
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 15:19:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so23247641wrs.10
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDhQEj+n/k7sCVnltIPFzGHQqu943Q7XYa2MfmyF2u8=;
        b=kGXxQwNbfl1D+8Wi7UWRUABEV2zPFiq7wtEfY1eg03A9cUYy5hKEVsO6ZJxgt45iCb
         jdAc2dJyKMwAjiYcbdT87S3f4ic4GABVAVJn7LHCRstxTaDxvoNSWffLaD9pakmG4ZD6
         vKN0pkVPszs/FPSwb60RVRfFjTCe2erW6xu7G7Xg5ZdM8Dav65X8h9f2zE/27z0eLBAL
         zv/VGUbPpXk/qGxu8Ba8+ruQtYMkNCPQLy0LWZekw8tTSdLVEpHbnpEE6nlHBCxDog4y
         C6/LRIbnwMJ6EYHFBEuBCIGcU5GoQ9kLHe6A06o8wINHeJqZ7SYn4XsHEXdh9H4+sj75
         4zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDhQEj+n/k7sCVnltIPFzGHQqu943Q7XYa2MfmyF2u8=;
        b=3qS3tzx6wGAof/SgqrjKtsdMpYR935n21eOP64sJvfw98KgWbsyWjuxldSFKTo3E18
         AsfHgg8bv1xnoy4IwkLeVISEljFJIxWnjcMe/M2ETfk4IR7By9b4OMxa74am3K8jUTdt
         Jc7kgFK3WOhU8953+Zuig3WrhxCfwXK6iAWtpa1x/cppBHUprQ2Dy8QoP073WRIoiQQh
         Igpk0hicYhHFmuCFB05ucT1oVEA9dlR39wCcNUAF3MLAtQ+fupZj1qUl9QW4SFSloRCO
         PYj+cJelMOH7T3x2IO43PReH02nHMJF0SSXwJz9uOLHs2FVLVJ9Ej9SThavgf3qjM/w+
         e/gw==
X-Gm-Message-State: ACrzQf12q6ObVH92Qp0rfvLNSGNODRbAvqQYOEELJdt1z7EgT1xakI5k
        /vIhEvPw+agiF6dV0Vah+pt7OmtpJnnvFb8iuH5bcw==
X-Google-Smtp-Source: AMsMyM5wkzuscVmHcUx13Q7g6jemNmuUOg0Tv3mglMhFx3aziOco44W5VUzUOestHzPtjZ2MAktDWpmK7jBPjS2dZY0=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr36325650wrb.300.1667949594214; Tue, 08
 Nov 2022 15:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-5-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:19:42 -0800
Message-ID: <CAP-5=fXOsQFGo90mg8yRvgMF3k4-s51-HC-n0+1hnE=4VR-rew@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf stat: Move common code in print_metric_headers()
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
> The struct perf_stat_output_ctx is set in a loop with the same values.
> Move the code out of the loop and keep the loop minimal.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>
Could also potentially make it const, but functions it is passed to
would also need changing.

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index d4936a502560..115477461224 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -837,11 +837,16 @@ static void print_metric_headers(struct perf_stat_config *config,
>                                  struct evlist *evlist,
>                                  const char *prefix, bool no_indent)
>  {
> -       struct perf_stat_output_ctx out;
>         struct evsel *counter;
>         struct outstate os = {
>                 .fh = config->output
>         };
> +       struct perf_stat_output_ctx out = {
> +               .ctx = &os,
> +               .print_metric = print_metric_header,
> +               .new_line = new_line_metric,
> +               .force_header = true,
> +       };
>         bool first = true;
>
>         if (config->json_output && !config->interval)
> @@ -865,13 +870,11 @@ static void print_metric_headers(struct perf_stat_config *config,
>         /* Print metrics headers only */
>         evlist__for_each_entry(evlist, counter) {
>                 os.evsel = counter;
> -               out.ctx = &os;
> -               out.print_metric = print_metric_header;
> +
>                 if (!first && config->json_output)
>                         fprintf(config->output, ", ");
>                 first = false;
> -               out.new_line = new_line_metric;
> -               out.force_header = true;
> +
>                 perf_stat__print_shadow_stats(config, counter, 0,
>                                               0,
>                                               &out,
> --
> 2.38.1.431.g37b22c650d-goog
>
