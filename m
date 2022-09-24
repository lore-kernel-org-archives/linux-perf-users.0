Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F87C04A95
	for <linux-perf-users@archiver.kernel.org>; Sat, 24 Sep 2022 02:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiIXCtf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 22:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIXCte (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 22:49:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F578205
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 19:49:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so1774611wml.5
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Sep 2022 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=44PHLAFFr/xjmdOFKAz7bT66nwC87SvDUnUenHVK6zs=;
        b=b3l1JF04D5cK9FCSUV5yWpe4jXQiO38hhNC3eUjZlPtHMRXMMWyrh0z3ni5wqx6fH6
         jN7ITFhgb2CBFxFmv5ihybT0ZJT83vXIdn7g4V0AY1K67jqon0uIR3pJBhCKpLMFB8ln
         OIIcWg4OowwRGBMAVua8wBEX1bwMKgOhvyI8KA+Dyyzn7UnL8JiewJ8FFN6WhdjHQhU/
         npspuKctZsjZs2EynN2+8cUTJkLu42Wlq5zEoiCewf5bZEJPUoQSHMOMz/rjs79UjU+2
         noyVgLcfRVmPOojS83iKKW6rG8x8PiwzhaXRcIOzKlstWUJeDFXBIojAJrl1boqhJpKe
         qaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=44PHLAFFr/xjmdOFKAz7bT66nwC87SvDUnUenHVK6zs=;
        b=t6l1tKpvxlE2ZczXs0rOt3qkbAwtT43xQrgx31F9q+E0p73xdai7TBerjX11MRSlta
         tPcYi+6s6aSSrOivH3Dlu2qp00Qc8hpGybH4zDTw7KhDbJJ3vRXuBYj82Rm/JYWYSLNu
         0CBXvpbVIzo3bbKSe9aabQ5z3s0lLU2/CR8xnf5Lz+a+hhCw7qCTLPnK6HfvbsQ58LaP
         JBD6ebGV//NcaUIrdV4Te9NJlmQvws5p9GquO60XUuZQaLZdKZng7hbF4a61S17PqN4h
         Fxd84HaMOCeBk6H3JhqBnGSCluOSURlQSvlO4bhIgJkJ0/2UYoM5bBVP/ZEmMpHxvkzO
         7iAA==
X-Gm-Message-State: ACrzQf1VGvezgB140kYE//AI0NqRNLZzmJNHElMSaNG1eIkWyBNZjzeE
        zOsLK1eg+TbFdy64LEHEqj6iuwnKfHHvo3BkqtiAnQ==
X-Google-Smtp-Source: AMsMyM4C+4WatuahEwxP306EwjKhsVg7m9cZ3qPR2p8oC8RBnzW5zW9Cr+BjevJj2xWJdNkOURUNKoyiOSeQU6QMT8k=
X-Received: by 2002:a7b:ca54:0:b0:3b4:fb06:9b1 with SMTP id
 m20-20020a7bca54000000b003b4fb0609b1mr7642630wml.67.1663987767740; Fri, 23
 Sep 2022 19:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220924004221.841024-1-namhyung@kernel.org>
In-Reply-To: <20220924004221.841024-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 19:49:14 -0700
Message-ID: <CAP-5=fUb9muc-5ncaOvWjciXydOhiS7S+5y_L8QR=A-PDU2jCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf lock: Add -E/--entries option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 23, 2022 at 5:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Like perf top, the -E option can limit number of entries to print.
> It can be useful when users want to see top N contended locks only.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-lock.txt | 10 ++++++++++
>  tools/perf/builtin-lock.c              | 20 +++++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 5f2dc634258e..b23e76200ac2 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -94,6 +94,11 @@ REPORT OPTIONS
>           EventManager_De       1845          1             636
>           futex-default-S       1609          0               0
>
> +-E::
> +--entries=<value>::
> +       Display this many entries.
> +
> +
>  INFO OPTIONS
>  ------------
>
> @@ -105,6 +110,7 @@ INFO OPTIONS
>  --map::
>         dump map of lock instances (address:name table)
>
> +
>  CONTENTION OPTIONS
>  --------------
>
> @@ -154,6 +160,10 @@ CONTENTION OPTIONS
>  --stack-skip
>         Number of stack depth to skip when finding a lock caller (default: 3).
>
> +-E::
> +--entries=<value>::
> +       Display this many entries.
> +
>
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 25d75fa09b90..1c0d52384d9e 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -58,6 +58,7 @@ static bool use_bpf;
>  static unsigned long bpf_map_entries = 10240;
>  static int max_stack_depth = CONTENTION_STACK_DEPTH;
>  static int stack_skip = CONTENTION_STACK_SKIP;
> +static int print_nr_entries = INT_MAX / 2;
>
>  static enum {
>         LOCK_AGGR_ADDR,
> @@ -1266,14 +1267,14 @@ static void print_result(void)
>         struct lock_stat *st;
>         struct lock_key *key;
>         char cut_name[20];
> -       int bad, total;
> +       int bad, total, printed;
>
>         pr_info("%20s ", "Name");
>         list_for_each_entry(key, &lock_keys, list)
>                 pr_info("%*s ", key->len, key->header);
>         pr_info("\n\n");
>
> -       bad = total = 0;
> +       bad = total = printed = 0;
>         while ((st = pop_from_result())) {
>                 total++;
>                 if (st->broken)
> @@ -1311,6 +1312,9 @@ static void print_result(void)
>                         pr_info(" ");
>                 }
>                 pr_info("\n");
> +
> +               if (++printed >= print_nr_entries)
> +                       break;
>         }
>
>         print_bad_events(bad, total);
> @@ -1476,7 +1480,7 @@ static void print_contention_result(struct lock_contention *con)
>  {
>         struct lock_stat *st;
>         struct lock_key *key;
> -       int bad, total;
> +       int bad, total, printed;
>
>         list_for_each_entry(key, &lock_keys, list)
>                 pr_info("%*s ", key->len, key->header);
> @@ -1486,7 +1490,7 @@ static void print_contention_result(struct lock_contention *con)
>         else
>                 pr_info("  %10s   %s\n\n", "type", "caller");
>
> -       bad = total = 0;
> +       bad = total = printed = 0;
>         if (use_bpf)
>                 bad = bad_hist[BROKEN_CONTENDED];
>
> @@ -1507,7 +1511,7 @@ static void print_contention_result(struct lock_contention *con)
>                         /* st->addr contains tid of thread */
>                         t = perf_session__findnew(session, pid);
>                         pr_info("  %10d   %s\n", pid, thread__comm_str(t));
> -                       continue;
> +                       goto next;
>                 }
>
>                 pr_info("  %10s   %s\n", get_type_str(st), st->name);
> @@ -1527,6 +1531,10 @@ static void print_contention_result(struct lock_contention *con)
>                                 pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
>                         }
>                 }
> +
> +next:
> +               if (++printed >= print_nr_entries)
> +                       break;
>         }
>
>         print_bad_events(bad, total);
> @@ -1878,6 +1886,7 @@ int cmd_lock(int argc, const char **argv)
>                     "combine locks in the same class"),
>         OPT_BOOLEAN('t', "threads", &show_thread_stats,
>                     "show per-thread lock stats"),
> +       OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>         OPT_PARENT(lock_options)
>         };
>
> @@ -1905,6 +1914,7 @@ int cmd_lock(int argc, const char **argv)
>         OPT_INTEGER(0, "stack-skip", &stack_skip,
>                     "Set the number of stack depth to skip when finding a lock caller, "
>                     "Default: " __stringify(CONTENTION_STACK_SKIP)),
> +       OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>         OPT_PARENT(lock_options)
>         };
>
> --
> 2.37.3.998.g577e59143f-goog
>
