Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB29C04A95
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 23:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWXWf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 19:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiIWXWe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 19:22:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61074128882
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 16:22:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bq9so2124934wrb.4
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Xy+pG0DBIu4N9rh+jQUXmy6fJfOf66S6GPpFpSf0HrU=;
        b=nEYA9/ic3LBZF/uHYRvlHZDD9zRVRKVqSdZzXZx3uMbwUK7XGcETK6ImTYKtLfsIbJ
         IuaNGF44tt42RFA2YkJErU6QGOgLvA8LqBKTZnVMfSAIom+w7+3bTot4NBeo5ZmtGBCL
         KKk3mOdmty/fIJKDyAKsL1dyXviLOIhV6yArj2S2DhqYi0q2xdOwfaGTcKwUkm/QdD3c
         4g4HQjDfpO44AFF2+pulW2WUaPJOWF8wtqc4tsCo9Wu2KIucn14Qmuvx3ZGWR2vSsy+Z
         ZCwEFoh9jOtca8sIvFevXogLSCki4xNka954E+awIhMVAy9Ix8W3tcgtNcTUzX5i9BV+
         jvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Xy+pG0DBIu4N9rh+jQUXmy6fJfOf66S6GPpFpSf0HrU=;
        b=YUQmfh1gE32A1HMYdBEdDxGRp0Zmg1TVmCQ8aSiEaZEbwvzBH00dosQKftxfpBaz9U
         xmovlKfkkVTn6LMmJRNcUEYaOxh7kEYVEtpdGQ9gmzyyiZCXjN7uEnayYOHKqgCxVjAO
         C77RCPhzxYL/8dcy7ZIq4O/6UsFSRi+zugPFLA/CnL38rgwi2ZmDOQEpnZQUuvwZy0nR
         1a/6JP/uHsSyZt8qbWknW24AICWWglinaRCKsiQA7rz1fqNowaVkUdk6f3lBIh7ADJZB
         kinX8uD5u6LDZJKFaP17R+FHA3J9CKuFGDjvS1q4N2jwj+sqIfbETU3dz5SkShEJceaE
         aVnA==
X-Gm-Message-State: ACrzQf3v+wHEayNVhR232miBfPd8UmM7064Us6uLOb+ys9IonK75a9pC
        0XtjmwW4Y9G6mHCeaUgdzlqS4B4NH+XBaa5vOTKp8Q==
X-Google-Smtp-Source: AMsMyM67AX9+s2AxYpdGDAQJg1+hPLMwpAOkGC3yJN2f51MbbDBte/ud8GV+Kejxow2eC9YkzM+vl97HGFSt8+Miy08=
X-Received: by 2002:a05:6000:150:b0:22a:55bf:80e9 with SMTP id
 r16-20020a056000015000b0022a55bf80e9mr6767939wrx.654.1663975351759; Fri, 23
 Sep 2022 16:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220923173142.805896-1-namhyung@kernel.org> <20220923173142.805896-5-namhyung@kernel.org>
In-Reply-To: <20220923173142.805896-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 16:22:19 -0700
Message-ID: <CAP-5=fV9COiwEQCYMEHYRHVqKt9=mq25hwq5-8JHYu50obxiHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf annotate: Toggle full address <-> offset display
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 23, 2022 at 10:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Handle 'f' key to toggle the display offset and full address.  Obviously
> it only works when users set to see disassembler output ('o' key).  It'd
> be useful when users want to see the full virtual address in the TUI
> annotate browser.
>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c |  6 +++++-
>  tools/perf/util/annotate.c        | 19 ++++++++++++++++++-
>  tools/perf/util/annotate.h        |  4 +++-
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 9bc1076374ff..725662e21b23 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -805,7 +805,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
>                 "r             Run available scripts\n"
>                 "p             Toggle percent type [local/global]\n"
>                 "b             Toggle percent base [period/hits]\n"
> -               "?             Search string backwards\n");
> +               "?             Search string backwards\n"
> +               "f             Toggle showing offsets to full address\n");
>                         continue;
>                 case 'r':
>                         script_browse(NULL, NULL);
> @@ -912,6 +913,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
>                         hists__scnprintf_title(hists, title, sizeof(title));
>                         annotate_browser__show(&browser->b, title, help);
>                         continue;
> +               case 'f':
> +                       annotation__toggle_full_addr(notes, ms);
> +                       continue;
>                 case K_LEFT:
>                 case K_ESC:
>                 case 'q':
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5bc63c9e0324..db475e44f42f 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2239,7 +2239,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>         }
>
>         args.ms = *ms;
> -       notes->start = map__rip_2objdump(ms->map, sym->start);
> +       if (notes->options && notes->options->full_addr)
> +               notes->start = map__objdump_2mem(ms->map, ms->sym->start);
> +       else
> +               notes->start = map__rip_2objdump(ms->map, ms->sym->start);
>
>         return symbol__disassemble(sym, &args);
>  }
> @@ -2762,6 +2765,8 @@ void annotation__update_column_widths(struct annotation *notes)
>  {
>         if (notes->options->use_offset)
>                 notes->widths.target = notes->widths.min_addr;
> +       else if (notes->options->full_addr)
> +               notes->widths.target = BITS_PER_LONG / 4;
>         else
>                 notes->widths.target = notes->widths.max_addr;
>
> @@ -2771,6 +2776,18 @@ void annotation__update_column_widths(struct annotation *notes)
>                 notes->widths.addr += notes->widths.jumps + 1;
>  }
>
> +void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms)
> +{
> +       notes->options->full_addr = !notes->options->full_addr;
> +
> +       if (notes->options->full_addr)
> +               notes->start = map__objdump_2mem(ms->map, ms->sym->start);
> +       else
> +               notes->start = map__rip_2objdump(ms->map, ms->sym->start);
> +
> +       annotation__update_column_widths(notes);
> +}
> +
>  static void annotation__calc_lines(struct annotation *notes, struct map *map,
>                                    struct rb_root *root,
>                                    struct annotation_options *opts)
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 3cbd883e4d7a..8934072c39e6 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -88,7 +88,8 @@ struct annotation_options {
>              show_nr_jumps,
>              show_minmax_cycle,
>              show_asm_raw,
> -            annotate_src;
> +            annotate_src,
> +            full_addr;
>         u8   offset_level;
>         int  min_pcnt;
>         int  max_lines;
> @@ -325,6 +326,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size);
>  void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
>  void annotation__update_column_widths(struct annotation *notes);
>  void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
> +void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms);
>
>  static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
>  {
> --
> 2.37.3.998.g577e59143f-goog
>
