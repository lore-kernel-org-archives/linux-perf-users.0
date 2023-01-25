Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA72DC54EAA
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Jan 2023 17:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjAYRdx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 12:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjAYRdw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 12:33:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897256ED0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 09:33:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q10so869851wrm.4
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E9WsIQf1aXjxCs4eUvqFirEjjXHFzQ9khpR/1HSfB70=;
        b=ETQHs4jU18yIVJ4F4tuaBFLL6V5NeLUyFtfscN9ndORs88SqWZktM9Ydx4rY9dN+Zj
         /TcAscMKxxYrZYq7dLR7gfnq7VA3Tn5TnAXlDd/jq6Bjfop0/VqoSUw8eH7KK3NZLCN9
         u+TOOSvmL0m9LjiW8DnZcF6q1DzXffh/iSlYaxbJTJePlyDqvWAogroOrGaTXuNZDlcC
         fOYazIbRdtC0PtILz/V6OG+GLGR4BfPue81u0P0zIugx7DHfLFTpGRHQlHx0jXzM33/q
         B+5p8JKOpfOoWFcNNRgODRe8GhKiqtg8vPyiE2/NXZGsj02Metu7YAlDLtosn1Z1jRyG
         8/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9WsIQf1aXjxCs4eUvqFirEjjXHFzQ9khpR/1HSfB70=;
        b=g2GlrJAprrADPVN9x4qsf2oNSpEl19N1SnSVUOXGKN/6IH8OXutHVBt4dHFgCIX69b
         e9KQh/1Fzoi2V9ArJuyFlk+K2nzdRWTcNyER5hYY5K985KvyLb6MrnlILghpDhcAz/DT
         M8cTamtbh7Ar1DMEzzdc+H5UtG8h47TI53/5b/9l+gCm4RjtmiBJaXkkSCsQke5OKhvw
         qfprXMHTcu2PPMT8anagLOhQ2h2krdW77gMRzO7b6h7hiQB6JXPNyakhekCO6QMMK07Z
         uOEUghdDPsCt2GUCjsupqBCLAfPX5+Zt3bkvW9E03nTCioGlvIYmdov/HqVAF9KoM4P2
         UpBA==
X-Gm-Message-State: AO0yUKXPy6zTy97IgkemFEfSsBH36zblotljvFkpIt4tUAHzikpVh8pF
        yoK0ro2aSgoXxeDuZXl0BFj4FMVhdY1sVgG2lKvlpQ==
X-Google-Smtp-Source: AK7set9JFZ02MPAZHbnYX+wME9RaY1KCQgjYY6ggVnZ3gELwHGyA1dCRplWL/caRmaj+qG8GgKi6Jmquj/o4AC4zDH8=
X-Received: by 2002:a5d:5341:0:b0:2bf:b79f:73f0 with SMTP id
 t1-20020a5d5341000000b002bfb79f73f0mr156579wrv.654.1674668021544; Wed, 25 Jan
 2023 09:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20230125081251.1244997-1-namhyung@kernel.org>
In-Reply-To: <20230125081251.1244997-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Jan 2023 09:33:29 -0800
Message-ID: <CAP-5=fVS8EGLk1mgo2fqg4pLn2MOSELJBQ9jfyaiS7bKq-D57w@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Hide invalid uncore event output for aggr mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jan 25, 2023 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The current display code for perf stat iterates given cpus and build the
> aggr map to collect the event data for the aggregation mode.
>
> But uncore events have their own cpu maps and it won't guarantee that
> it'd match to the aggr map.  For example, per-package uncore events
> would generate a single value for each socket.  When user asks per-core
> aggregation mode, the output would contain 0 values for other cores.
>
> Thus it needs to check the uncore PMU's cpumask and if it matches to the
> current aggregation id.
>
> Before:
>   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0-D0-C0              1               3.73 Joules power/energy-pkg/
>   S0-D0-C1              0      <not counted> Joules power/energy-pkg/
>   S0-D0-C2              0      <not counted> Joules power/energy-pkg/
>   S0-D0-C3              0      <not counted> Joules power/energy-pkg/
>
>          1.001404046 seconds time elapsed
>
>   Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>
> The core 1, 2 and 3 should not be printed because the event is handled
> in a cpu in the core 0 only.  With this change, the output becomes like
> below.
>
> After:
>   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0-D0-C0              1               2.09 Joules power/energy-pkg/
>
> Fixes: b89761351089 ("perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events")

Thanks! Tested further with mixed core and uncore events like:
$ perf stat -A -a -e power/energy-pkg/,cycles sleep 1
and the "<not counted>" are now nicely gone.

> Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 8bd8b0142630..b9dcb13650d0 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -787,6 +787,22 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
>                 uniquify_event_name(counter);
>  }
>
> +static bool check_uncore_event_aggr(struct perf_stat_config *config,
> +                                   struct evsel *counter,
> +                                   struct aggr_cpu_id *id)

nit: const *s
nit: check_uncore_event_aggr isn't particularly intention revealing,
perhaps something more like should_print_counter. Perhaps some
kernel-doc like:
/**
 * should_print_counter() - Based on id, should the current counter's
value be printed.
 * @config: The perf stat configuration with knowledge of the aggregation mode.
 * @counter: The counter with its associated cpumap.
 * @id: The aggregation type that is being queried for printing.
 *
 * An evlist can have evsels with different cpumaps, for example, by
mixing core and uncore events.
 * When displaying one counter the other counter shouldn't be printed.
Check the counter's cpumap
 * to see whether for any CPU it is associated with the counter should
be printed.
 *
 * Return: true for counters that should be printed.
 */

> +{
> +       struct perf_cpu cpu;
> +       int idx;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, counter->core.own_cpus) {

I know this is pre-existing, sorry to whine. I think we need to
document cpus vs own_cpus in the perf_evsel. Normally own_cpus ==
cpus, but in a case like this the difference matters and I have a hard
time understanding what "own" is supposed to be conveying, and why
here we don't use cpus. I also lose what the connection is with
perf_evlist all_cpus, does that union own_cpus or cpus? At least there
is a comment there :-D Honestly, why do we need to even have 2 cpu
maps in an evsel?

> +               struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
> +
> +               if (aggr_cpu_id__equal(id, &own_id))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
>                                    struct outstate *os)
> @@ -814,12 +830,21 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         ena = aggr->counts.ena;
>         run = aggr->counts.run;
>
> -       /*
> -        * Skip value 0 when enabling --per-thread globally, otherwise it will
> -        * have too many 0 output.
> -        */
> -       if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> -               return;
> +       if (val == 0) {
> +               /*
> +                * Skip value 0 when enabling --per-thread globally,
> +                * otherwise it will have too many 0 output.
> +                */
> +               if (config->aggr_mode == AGGR_THREAD && config->system_wide)
> +                       return;
> +               /*
> +                * Skip value 0 when it's an uncore event and the given aggr id
> +                * does not belong to the PMU cpumask.
> +                */
> +               if (counter->core.requires_cpu &&
> +                   !check_uncore_event_aggr(config, counter, &id))
> +                       return;
> +       }
>
>         if (!metric_only) {
>                 if (config->json_output)
> --
> 2.39.1.405.gd4c25cc71f-goog
>
