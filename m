Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88842C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5005F617E4
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhKHSxE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhKHSxC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:53:02 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0AEC061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:50:17 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 14so1927941ioe.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20zpAUVVGi50MQj4q3R9J0UASAgkwC4OA34FpEJjmzo=;
        b=Uf5+m3X3P9O7FsaFVN6yoClpidKl9zTItyk7wuELng2ceJKormy8uadOXT3C219hXw
         rv4j/o48NXIa/q4npgaf+8DoKzf7D3Yg55+xTmY8GVARtY/zhn8ZslVCmrzJ2gJCYZxT
         mIw7PmqZBOGPT9Cy87gKLkzzH2TOV7C4be4AjbElLsG3N5vXtFYwjr7K2rmNz3uizeic
         PQSnmAKE3mcnUR1lKTg6MxXejiNy7F/EQlE/SlHBkNT2IkdVJ11zaP+6YZHXhu//LlSN
         tZg+hqlJvk9IS2TFxoCWIyriaw+OFyTi5h8p1Qqv1uwffCkNUIa9HJwjS5LDsxfJX185
         7C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20zpAUVVGi50MQj4q3R9J0UASAgkwC4OA34FpEJjmzo=;
        b=HHLb5ecLxIFt76sQT5VOv2Y2mxI4pJF+Q3sWulEoBcHy8CkVBIO97p/MAHecuhNKNZ
         ZPV170fnFlooAh8AIMQs9UgQy/HKajeNw9Lgrb0jsC06FOOAfewSXjGe6X8bjzh+Wswp
         OFhfDMgAcy7IhaZFXhhvccuY+w3TfE32CW/9aohgazL/jxSLgPplzFlawgv4hcDS9/1A
         i7v1AJto6AQi1KAAdm4eoHCNvIajuNhCLxNbJYsC5FkT13tLcl4tKKDSsg//yhcxB3Aw
         JjzwkSvYjNAHcpGwZ4C4Q7WFzZrHGwYMfmMfznjc7Wxgp6+kuy917jGnFgn1YnNx5k9s
         bAzQ==
X-Gm-Message-State: AOAM533DnJEEAq9db1ExBxFHmJnTAiQ1VfPznkP+uhJ50beYvOL9jyGC
        Jxkury4jigUXAx2KeuEnusB1rEKQpJ34oU6O4wjTTg==
X-Google-Smtp-Source: ABdhPJw0wPpwp5evlQChYrLlmbinLBdtSbwCGVYUfBUVd89R5o/4fqU/QLkOCwPXA6PBM2VGapG9/97od/QLk4ieYxI=
X-Received: by 2002:a02:950e:: with SMTP id y14mr1008260jah.88.1636397416577;
 Mon, 08 Nov 2021 10:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:50:01 -0800
Message-ID: <CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com>
Subject: Re: [RFC 00/59] libperf: Move in event parse code
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:37 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> this *RFC* patchset moves event parser code to libperf.
>
> It keeps the current perf functionality intact (hopefully)
> and adds new libperf_parse_events API to libperf that
> provides events parsing.
>
> At the moment libperf_parse_events function supports only
> breakpoint events, so it can be used to do things like:
> (see the new libperf test)
>
>   evlist = perf_evlist__new();
>   err = libperf_parse_events(evlist, "mem:0:rw");
>
>
> The other pmus parsing code directly depends on parsing
> code, so now when the parser is in the libperf, it will
> be easier to add the rest of pmus support.
>
> I'm curious on any early feedback because it's big change.
> My primary target is using this interface for bpftool prog
> profile to allow using all the perf events there.
>
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   libperf/parse
>
>
> I'm Cc-ing most of the folks just on the cover email,
> because it's a lot of changes and most people won't be
> interested ;-)
>
> Please check the linux-perf-users mailing list or the git
> branch above for all the changes.
>
> thanks,
> jirka

It is a big change but I'm positive about it. Perhaps bpftool can use
libpfm4 in the short-term ;-) There are lots of small cleanups and
documentation improvements that can be done. Getting the main move
done quickly will help avoid the merge conflicts. I foresee conflicts
with my un-merged changes (reviews welcome :-) ):

new literals in metrics and a source_count function:
https://lore.kernel.org/lkml/20211105170943.3479315-1-irogers@google.com/

kunit style cleanup:
https://lore.kernel.org/lkml/20211104064208.3156807-1-irogers@google.com/

I would like to see pmu-events cleaned up. Some ideas here are:

1) moving jevents to a python program to simplify its maintenance -
100s of lines of json parsing code would turn into a single import and
we'd cease having an out dated for of jsmn

2) the pmu_events_map holds both events and metrics. Moving pmu-events
into libperf probably means something for the metrics code, should it
move to libperf too?

3) an issue with the existing pmu_events_map is that it is a struct
with lots of pointers. Most of the pointers are to .rodata strings.
With PIE the strings can end up anywhere in memory and so relocations
are needed for what is about 1.5MB worth of data. It'd be nice if perf
wasn't relocating all of that every time it starts. A solution would
be to turn all the events into a giant string (with deduplication,
etc.) and then to do something like leb128 encode offsets into the
string (many offsets are 0 and leb128 would encode that as a single
byte). As the string offsets, or leb128 encoded offsets, are constant
then they can go in .rodata and don't require relocating. We should be
able to shave something like 1MB off the binary size while improving
startup performance. Adding the logic to jevents.c would be more yucky
than in python imo.

Thanks,
Ian

> Cc: John Garry <john.garry@huawei.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Stephane Eranian <eranian@google.com>
> ---
> Jiri Olsa (59):
>       libperf: Move pmu-events.h file to libperf
>       libperf: Move pmu-events framework to libperf
>       libperf: Move pmu-events build to libperf
>       libperf: Move perf_pmu__format_parse to libperf
>       tools api fs: Move in the fncache from perf
>       libperf: Move in the pmu hybrid support
>       libperf: Move name to perf_evsel
>       libperf: Move auto_merge_stats to perf_evsel
>       libperf: Move config_terms to perf_evsel
>       libperf: Move metric_id to perf_evsel
>       libperf: Move tool_event to perf_evsel
>       libperf: Move unit to perf_evsel
>       libperf: Move exclude_GH to perf_evsel
>       libperf: Move sample_read to perf_evsel
>       libperf: Move precise_max to perf_evsel
>       libperf: Move weak_group to perf_evsel
>       libperf: Move bpf_counter to perf_evsel
>       libperf: Move group_name to perf_evsel
>       perf tools: Fix parse_events_term__num call
>       perf tools: Pass parse_state all the way down to __add_event
>       perf tools: Pass parse_state all the way down to add_tracepoint
>       perf tools: Add evsel__new callback to parse_state_ops
>       perf tools: Add evsel__new_tp callback to parse_state_ops
>       perf tools: Add loc_term and loc_val helpers to parse_events_term__str
>       perf tools: Add loc_term and loc_val helpers to parse_events_term__num
>       libperf: Move in the event_symbols_hw/event_symbols_sw
>       libperf: Move in struct parse_events_term code
>       perf tools: Add perf_evsel__add_event function
>       perf tools: Change struct parse_events_state::evlist to perf_evlist
>       libperf: Move in struct parse_events_state
>       perf tools: Move event_attr_init in evsel__new_idx function
>       libperf: Move in perf_pmu__warn_invalid_config function
>       libperf: Move in perf_evsel__add_event function
>       perf tools: Move parse_events_update_lists to parser unit
>       libperf: Add perf_evsel__is_group_leader function
>       perf tools: Make parse_events__modifier_event work over perf_evsel
>       perf tool: Pass perf_guest in struct parse_events_state
>       libperf: Move in parse_events__modifier_group/event functions
>       libperf: Move in parse_events__handle_error function
>       libperf: Move in parse_events_evlist_error function
>       perf tools: Add perf_evsel__delete callback to struct parse_events_ops
>       libperf: Move in parse_events_name function
>       perf tools: Move out parse_events_add_pmu fallback from parser code
>       perf tools: Add add_pmu callback to struct parse_events_ops
>       perf tools: Add add_pmu_multi callback to struct parse_events_ops
>       perf tools: Add add_numeric callback to struct parse_events_ops
>       perf tools: Add add_cache callback to struct parse_events_ops
>       perf tools: Add add_breakpoint callback to struct parse_events_ops
>       perf tools: Add add_tracepoint callback to struct parse_events_ops
>       perf tools: Add add_bpf callback to struct parse_events_ops
>       perf tools: Add add_tool callback to struct parse_events_ops
>       perf tools: Add set_leader callback to struct parse_events_ops
>       perf tools: Add parse_check callback to struct parse_events_ops
>       perf tools: Move PE_* enums in parse_events__scanner
>       libperf: Move in parse-events flex/bison parser
>       libperf: Move in parse_events_add_breakpoint function
>       libperf: Move in some lib objects from perf
>       libperf: Add libperf_parse_events function
>       libperf: Add parse-events test
>
>  tools/lib/api/fs/Build                             |   1 +
>  tools/{perf/util => lib/api/fs}/fncache.c          |   4 +-
>  tools/lib/api/fs/fs.h                              |   2 +
>  tools/lib/perf/Build                               |  79 ++
>  tools/lib/perf/Makefile                            |  40 +-
>  tools/lib/perf/include/internal/evsel.h            |  30 +
>  tools/lib/perf/include/internal/parse-events.h     | 203 +++++
>  .../perf/include/internal}/pmu-hybrid.h            |   2 +-
>  tools/lib/perf/include/internal/pmu.h              |  59 ++
>  tools/lib/perf/include/perf/evlist.h               |   2 +
>  .../perf/include/perf}/pmu-events.h                |   0
>  tools/lib/perf/libperf.map                         |   1 +
>  tools/lib/perf/parse-events.c                      | 875 +++++++++++++++++++
>  tools/{perf/util => lib/perf}/parse-events.l       |  16 +-
>  tools/{perf/util => lib/perf}/parse-events.y       | 197 +++--
>  tools/{ => lib}/perf/pmu-events/Build              |   2 +-
>  tools/{ => lib}/perf/pmu-events/README             |   0
>  .../pmu-events/arch/arm64/ampere/emag/branch.json  |   0
>  .../pmu-events/arch/arm64/ampere/emag/bus.json     |   0
>  .../pmu-events/arch/arm64/ampere/emag/cache.json   |   0
>  .../pmu-events/arch/arm64/ampere/emag/clock.json   |   0
>  .../arch/arm64/ampere/emag/exception.json          |   0
>  .../arch/arm64/ampere/emag/instruction.json        |   0
>  .../arch/arm64/ampere/emag/intrinsic.json          |   0
>  .../pmu-events/arch/arm64/ampere/emag/memory.json  |   0
>  .../arch/arm64/ampere/emag/pipeline.json           |   0
>  .../arch/arm64/arm/cortex-a53/branch.json          |   0
>  .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  |   0
>  .../arch/arm64/arm/cortex-a53/cache.json           |   0
>  .../arch/arm64/arm/cortex-a53/memory.json          |   0
>  .../arch/arm64/arm/cortex-a53/other.json           |   0
>  .../arch/arm64/arm/cortex-a53/pipeline.json        |   0
>  .../arm64/arm/cortex-a57-a72/core-imp-def.json     |   0
>  .../arch/arm64/arm/cortex-a76-n1/branch.json       |   0
>  .../arch/arm64/arm/cortex-a76-n1/bus.json          |   0
>  .../arch/arm64/arm/cortex-a76-n1/cache.json        |   0
>  .../arch/arm64/arm/cortex-a76-n1/exception.json    |   0
>  .../arch/arm64/arm/cortex-a76-n1/instruction.json  |   0
>  .../arch/arm64/arm/cortex-a76-n1/memory.json       |   0
>  .../arch/arm64/arm/cortex-a76-n1/other.json        |   0
>  .../arch/arm64/arm/cortex-a76-n1/pipeline.json     |   0
>  .../arch/arm64/arm/neoverse-v1/branch.json         |   0
>  .../pmu-events/arch/arm64/arm/neoverse-v1/bus.json |   0
>  .../arch/arm64/arm/neoverse-v1/cache.json          |   0
>  .../arch/arm64/arm/neoverse-v1/exception.json      |   0
>  .../arch/arm64/arm/neoverse-v1/instruction.json    |   0
>  .../arch/arm64/arm/neoverse-v1/memory.json         |   0
>  .../arch/arm64/arm/neoverse-v1/other.json          |   0
>  .../arch/arm64/arm/neoverse-v1/pipeline.json       |   0
>  .../arch/arm64/armv8-common-and-microarch.json     |   0
>  .../pmu-events/arch/arm64/armv8-recommended.json   |   0
>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  |   0
>  .../arch/arm64/freescale/imx8mm/sys/ddrc.json      |   0
>  .../arch/arm64/freescale/imx8mm/sys/metrics.json   |   0
>  .../arch/arm64/freescale/imx8mn/sys/ddrc.json      |   0
>  .../arch/arm64/freescale/imx8mn/sys/metrics.json   |   0
>  .../arch/arm64/freescale/imx8mp/sys/ddrc.json      |   0
>  .../arch/arm64/freescale/imx8mp/sys/metrics.json   |   0
>  .../arch/arm64/freescale/imx8mq/sys/ddrc.json      |   0
>  .../arch/arm64/freescale/imx8mq/sys/metrics.json   |   0
>  .../arch/arm64/fujitsu/a64fx/branch.json           |   0
>  .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |   0
>  .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json |   0
>  .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   0
>  .../arch/arm64/fujitsu/a64fx/exception.json        |   0
>  .../arch/arm64/fujitsu/a64fx/instruction.json      |   0
>  .../arch/arm64/fujitsu/a64fx/memory.json           |   0
>  .../pmu-events/arch/arm64/fujitsu/a64fx/other.json |   0
>  .../arch/arm64/fujitsu/a64fx/pipeline.json         |   0
>  .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   |   0
>  .../arch/arm64/hisilicon/hip08/core-imp-def.json   |   0
>  .../arch/arm64/hisilicon/hip08/metrics.json        |   0
>  .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |   0
>  .../arch/arm64/hisilicon/hip08/uncore-hha.json     |   0
>  .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |   0
>  .../perf/pmu-events/arch/arm64/mapfile.csv         |   0
>  .../perf/pmu-events/arch/nds32/mapfile.csv         |   0
>  .../perf/pmu-events/arch/nds32/n13/atcpmu.json     |   0
>  .../perf/pmu-events/arch/powerpc/mapfile.csv       |   0
>  .../pmu-events/arch/powerpc/power10/cache.json     |   0
>  .../arch/powerpc/power10/floating_point.json       |   0
>  .../pmu-events/arch/powerpc/power10/frontend.json  |   0
>  .../pmu-events/arch/powerpc/power10/locks.json     |   0
>  .../pmu-events/arch/powerpc/power10/marked.json    |   0
>  .../pmu-events/arch/powerpc/power10/memory.json    |   0
>  .../arch/powerpc/power10/nest_metrics.json         |   0
>  .../pmu-events/arch/powerpc/power10/others.json    |   0
>  .../pmu-events/arch/powerpc/power10/pipeline.json  |   0
>  .../perf/pmu-events/arch/powerpc/power10/pmc.json  |   0
>  .../arch/powerpc/power10/translation.json          |   0
>  .../perf/pmu-events/arch/powerpc/power8/cache.json |   0
>  .../arch/powerpc/power8/floating-point.json        |   0
>  .../pmu-events/arch/powerpc/power8/frontend.json   |   0
>  .../pmu-events/arch/powerpc/power8/marked.json     |   0
>  .../pmu-events/arch/powerpc/power8/memory.json     |   0
>  .../pmu-events/arch/powerpc/power8/metrics.json    |   0
>  .../perf/pmu-events/arch/powerpc/power8/other.json |   0
>  .../pmu-events/arch/powerpc/power8/pipeline.json   |   0
>  .../perf/pmu-events/arch/powerpc/power8/pmc.json   |   0
>  .../arch/powerpc/power8/translation.json           |   0
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |   0
>  .../arch/powerpc/power9/floating-point.json        |   0
>  .../pmu-events/arch/powerpc/power9/frontend.json   |   0
>  .../pmu-events/arch/powerpc/power9/marked.json     |   0
>  .../pmu-events/arch/powerpc/power9/memory.json     |   0
>  .../pmu-events/arch/powerpc/power9/metrics.json    |   0
>  .../arch/powerpc/power9/nest_metrics.json          |   0
>  .../perf/pmu-events/arch/powerpc/power9/other.json |   0
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |   0
>  .../perf/pmu-events/arch/powerpc/power9/pmc.json   |   0
>  .../arch/powerpc/power9/translation.json           |   0
>  .../perf/pmu-events/arch/s390/cf_z10/basic.json    |   0
>  .../perf/pmu-events/arch/s390/cf_z10/crypto.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z10/extended.json |   0
>  .../perf/pmu-events/arch/s390/cf_z13/basic.json    |   0
>  .../perf/pmu-events/arch/s390/cf_z13/crypto.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z13/extended.json |   0
>  .../pmu-events/arch/s390/cf_z13/transaction.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z14/basic.json    |   0
>  .../perf/pmu-events/arch/s390/cf_z14/crypto.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z14/extended.json |   0
>  .../pmu-events/arch/s390/cf_z14/transaction.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z15/basic.json    |   0
>  .../perf/pmu-events/arch/s390/cf_z15/crypto.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  |   0
>  .../perf/pmu-events/arch/s390/cf_z15/extended.json |   0
>  .../pmu-events/arch/s390/cf_z15/transaction.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z196/basic.json   |   0
>  .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |   0
>  .../pmu-events/arch/s390/cf_z196/extended.json     |   0
>  .../perf/pmu-events/arch/s390/cf_zec12/basic.json  |   0
>  .../perf/pmu-events/arch/s390/cf_zec12/crypto.json |   0
>  .../pmu-events/arch/s390/cf_zec12/extended.json    |   0
>  .../pmu-events/arch/s390/cf_zec12/transaction.json |   0
>  .../perf/pmu-events/arch/s390/mapfile.csv          |   0
>  .../perf/pmu-events/arch/test/arch-std-events.json |   0
>  .../pmu-events/arch/test/test_soc/cpu/branch.json  |   0
>  .../pmu-events/arch/test/test_soc/cpu/cache.json   |   0
>  .../pmu-events/arch/test/test_soc/cpu/other.json   |   0
>  .../pmu-events/arch/test/test_soc/cpu/uncore.json  |   0
>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |   0
>  .../perf/pmu-events/arch/x86/amdzen1/branch.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen1/cache.json    |   0
>  .../perf/pmu-events/arch/x86/amdzen1/core.json     |   0
>  .../pmu-events/arch/x86/amdzen1/data-fabric.json   |   0
>  .../arch/x86/amdzen1/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/amdzen1/memory.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen1/other.json    |   0
>  .../pmu-events/arch/x86/amdzen1/recommended.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen2/branch.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen2/cache.json    |   0
>  .../perf/pmu-events/arch/x86/amdzen2/core.json     |   0
>  .../pmu-events/arch/x86/amdzen2/data-fabric.json   |   0
>  .../arch/x86/amdzen2/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/amdzen2/memory.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen2/other.json    |   0
>  .../pmu-events/arch/x86/amdzen2/recommended.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen3/branch.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen3/cache.json    |   0
>  .../perf/pmu-events/arch/x86/amdzen3/core.json     |   0
>  .../pmu-events/arch/x86/amdzen3/data-fabric.json   |   0
>  .../arch/x86/amdzen3/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/amdzen3/memory.json   |   0
>  .../perf/pmu-events/arch/x86/amdzen3/other.json    |   0
>  .../pmu-events/arch/x86/amdzen3/recommended.json   |   0
>  .../perf/pmu-events/arch/x86/bonnell/cache.json    |   0
>  .../arch/x86/bonnell/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/bonnell/frontend.json |   0
>  .../perf/pmu-events/arch/x86/bonnell/memory.json   |   0
>  .../perf/pmu-events/arch/x86/bonnell/other.json    |   0
>  .../perf/pmu-events/arch/x86/bonnell/pipeline.json |   0
>  .../arch/x86/bonnell/virtual-memory.json           |   0
>  .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   0
>  .../perf/pmu-events/arch/x86/broadwell/cache.json  |   0
>  .../arch/x86/broadwell/floating-point.json         |   0
>  .../pmu-events/arch/x86/broadwell/frontend.json    |   0
>  .../perf/pmu-events/arch/x86/broadwell/memory.json |   0
>  .../perf/pmu-events/arch/x86/broadwell/other.json  |   0
>  .../pmu-events/arch/x86/broadwell/pipeline.json    |   0
>  .../perf/pmu-events/arch/x86/broadwell/uncore.json |   0
>  .../arch/x86/broadwell/virtual-memory.json         |   0
>  .../arch/x86/broadwellde/bdwde-metrics.json        |   0
>  .../pmu-events/arch/x86/broadwellde/cache.json     |   0
>  .../arch/x86/broadwellde/floating-point.json       |   0
>  .../pmu-events/arch/x86/broadwellde/frontend.json  |   0
>  .../pmu-events/arch/x86/broadwellde/memory.json    |   0
>  .../pmu-events/arch/x86/broadwellde/other.json     |   0
>  .../pmu-events/arch/x86/broadwellde/pipeline.json  |   0
>  .../arch/x86/broadwellde/uncore-cache.json         |   0
>  .../arch/x86/broadwellde/uncore-memory.json        |   0
>  .../arch/x86/broadwellde/uncore-power.json         |   0
>  .../arch/x86/broadwellde/virtual-memory.json       |   0
>  .../arch/x86/broadwellx/bdx-metrics.json           |   0
>  .../perf/pmu-events/arch/x86/broadwellx/cache.json |   0
>  .../arch/x86/broadwellx/floating-point.json        |   0
>  .../pmu-events/arch/x86/broadwellx/frontend.json   |   0
>  .../pmu-events/arch/x86/broadwellx/memory.json     |   0
>  .../perf/pmu-events/arch/x86/broadwellx/other.json |   0
>  .../pmu-events/arch/x86/broadwellx/pipeline.json   |   0
>  .../arch/x86/broadwellx/uncore-cache.json          |   0
>  .../arch/x86/broadwellx/uncore-interconnect.json   |   0
>  .../arch/x86/broadwellx/uncore-memory.json         |   0
>  .../arch/x86/broadwellx/uncore-power.json          |   0
>  .../arch/x86/broadwellx/virtual-memory.json        |   0
>  .../pmu-events/arch/x86/cascadelakex/cache.json    |   0
>  .../arch/x86/cascadelakex/clx-metrics.json         |   0
>  .../arch/x86/cascadelakex/floating-point.json      |   0
>  .../pmu-events/arch/x86/cascadelakex/frontend.json |   0
>  .../pmu-events/arch/x86/cascadelakex/memory.json   |   0
>  .../pmu-events/arch/x86/cascadelakex/other.json    |   0
>  .../pmu-events/arch/x86/cascadelakex/pipeline.json |   0
>  .../arch/x86/cascadelakex/uncore-memory.json       |   0
>  .../arch/x86/cascadelakex/uncore-other.json        |   0
>  .../arch/x86/cascadelakex/virtual-memory.json      |   0
>  .../pmu-events/arch/x86/elkhartlake/cache.json     |   0
>  .../arch/x86/elkhartlake/ehl-metrics.json          |   0
>  .../arch/x86/elkhartlake/floating-point.json       |   0
>  .../pmu-events/arch/x86/elkhartlake/frontend.json  |   0
>  .../pmu-events/arch/x86/elkhartlake/memory.json    |   0
>  .../pmu-events/arch/x86/elkhartlake/other.json     |   0
>  .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   0
>  .../arch/x86/elkhartlake/virtual-memory.json       |   0
>  .../perf/pmu-events/arch/x86/goldmont/cache.json   |   0
>  .../pmu-events/arch/x86/goldmont/frontend.json     |   0
>  .../perf/pmu-events/arch/x86/goldmont/memory.json  |   0
>  .../perf/pmu-events/arch/x86/goldmont/other.json   |   0
>  .../pmu-events/arch/x86/goldmont/pipeline.json     |   0
>  .../arch/x86/goldmont/virtual-memory.json          |   0
>  .../pmu-events/arch/x86/goldmontplus/cache.json    |   0
>  .../pmu-events/arch/x86/goldmontplus/frontend.json |   0
>  .../pmu-events/arch/x86/goldmontplus/memory.json   |   0
>  .../pmu-events/arch/x86/goldmontplus/other.json    |   0
>  .../pmu-events/arch/x86/goldmontplus/pipeline.json |   0
>  .../arch/x86/goldmontplus/virtual-memory.json      |   0
>  .../perf/pmu-events/arch/x86/haswell/cache.json    |   0
>  .../arch/x86/haswell/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/haswell/frontend.json |   0
>  .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   0
>  .../perf/pmu-events/arch/x86/haswell/memory.json   |   0
>  .../perf/pmu-events/arch/x86/haswell/other.json    |   0
>  .../perf/pmu-events/arch/x86/haswell/pipeline.json |   0
>  .../perf/pmu-events/arch/x86/haswell/uncore.json   |   0
>  .../arch/x86/haswell/virtual-memory.json           |   0
>  .../perf/pmu-events/arch/x86/haswellx/cache.json   |   0
>  .../arch/x86/haswellx/floating-point.json          |   0
>  .../pmu-events/arch/x86/haswellx/frontend.json     |   0
>  .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   0
>  .../perf/pmu-events/arch/x86/haswellx/memory.json  |   0
>  .../perf/pmu-events/arch/x86/haswellx/other.json   |   0
>  .../pmu-events/arch/x86/haswellx/pipeline.json     |   0
>  .../pmu-events/arch/x86/haswellx/uncore-cache.json |   0
>  .../arch/x86/haswellx/uncore-interconnect.json     |   0
>  .../arch/x86/haswellx/uncore-memory.json           |   0
>  .../pmu-events/arch/x86/haswellx/uncore-power.json |   0
>  .../arch/x86/haswellx/virtual-memory.json          |   0
>  .../perf/pmu-events/arch/x86/icelake/cache.json    |   0
>  .../arch/x86/icelake/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/icelake/frontend.json |   0
>  .../pmu-events/arch/x86/icelake/icl-metrics.json   |   0
>  .../perf/pmu-events/arch/x86/icelake/memory.json   |   0
>  .../perf/pmu-events/arch/x86/icelake/other.json    |   0
>  .../perf/pmu-events/arch/x86/icelake/pipeline.json |   0
>  .../arch/x86/icelake/virtual-memory.json           |   0
>  .../perf/pmu-events/arch/x86/icelakex/cache.json   |   0
>  .../arch/x86/icelakex/floating-point.json          |   0
>  .../pmu-events/arch/x86/icelakex/frontend.json     |   0
>  .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   0
>  .../perf/pmu-events/arch/x86/icelakex/memory.json  |   0
>  .../perf/pmu-events/arch/x86/icelakex/other.json   |   0
>  .../pmu-events/arch/x86/icelakex/pipeline.json     |   0
>  .../arch/x86/icelakex/uncore-memory.json           |   0
>  .../pmu-events/arch/x86/icelakex/uncore-other.json |   0
>  .../pmu-events/arch/x86/icelakex/uncore-power.json |   0
>  .../arch/x86/icelakex/virtual-memory.json          |   0
>  .../perf/pmu-events/arch/x86/ivybridge/cache.json  |   0
>  .../arch/x86/ivybridge/floating-point.json         |   0
>  .../pmu-events/arch/x86/ivybridge/frontend.json    |   0
>  .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   0
>  .../perf/pmu-events/arch/x86/ivybridge/memory.json |   0
>  .../perf/pmu-events/arch/x86/ivybridge/other.json  |   0
>  .../pmu-events/arch/x86/ivybridge/pipeline.json    |   0
>  .../perf/pmu-events/arch/x86/ivybridge/uncore.json |   0
>  .../arch/x86/ivybridge/virtual-memory.json         |   0
>  .../perf/pmu-events/arch/x86/ivytown/cache.json    |   0
>  .../arch/x86/ivytown/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/ivytown/frontend.json |   0
>  .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   0
>  .../perf/pmu-events/arch/x86/ivytown/memory.json   |   0
>  .../perf/pmu-events/arch/x86/ivytown/other.json    |   0
>  .../perf/pmu-events/arch/x86/ivytown/pipeline.json |   0
>  .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   0
>  .../arch/x86/ivytown/uncore-interconnect.json      |   0
>  .../pmu-events/arch/x86/ivytown/uncore-memory.json |   0
>  .../pmu-events/arch/x86/ivytown/uncore-power.json  |   0
>  .../arch/x86/ivytown/virtual-memory.json           |   0
>  .../perf/pmu-events/arch/x86/jaketown/cache.json   |   0
>  .../arch/x86/jaketown/floating-point.json          |   0
>  .../pmu-events/arch/x86/jaketown/frontend.json     |   0
>  .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   0
>  .../perf/pmu-events/arch/x86/jaketown/memory.json  |   0
>  .../perf/pmu-events/arch/x86/jaketown/other.json   |   0
>  .../pmu-events/arch/x86/jaketown/pipeline.json     |   0
>  .../pmu-events/arch/x86/jaketown/uncore-cache.json |   0
>  .../arch/x86/jaketown/uncore-interconnect.json     |   0
>  .../arch/x86/jaketown/uncore-memory.json           |   0
>  .../pmu-events/arch/x86/jaketown/uncore-power.json |   0
>  .../arch/x86/jaketown/virtual-memory.json          |   0
>  .../pmu-events/arch/x86/knightslanding/cache.json  |   0
>  .../arch/x86/knightslanding/frontend.json          |   0
>  .../pmu-events/arch/x86/knightslanding/memory.json |   0
>  .../arch/x86/knightslanding/pipeline.json          |   0
>  .../arch/x86/knightslanding/uncore-memory.json     |   0
>  .../arch/x86/knightslanding/virtual-memory.json    |   0
>  .../{ => lib}/perf/pmu-events/arch/x86/mapfile.csv |   0
>  .../perf/pmu-events/arch/x86/nehalemep/cache.json  |   0
>  .../arch/x86/nehalemep/floating-point.json         |   0
>  .../pmu-events/arch/x86/nehalemep/frontend.json    |   0
>  .../perf/pmu-events/arch/x86/nehalemep/memory.json |   0
>  .../perf/pmu-events/arch/x86/nehalemep/other.json  |   0
>  .../pmu-events/arch/x86/nehalemep/pipeline.json    |   0
>  .../arch/x86/nehalemep/virtual-memory.json         |   0
>  .../perf/pmu-events/arch/x86/nehalemex/cache.json  |   0
>  .../arch/x86/nehalemex/floating-point.json         |   0
>  .../pmu-events/arch/x86/nehalemex/frontend.json    |   0
>  .../perf/pmu-events/arch/x86/nehalemex/memory.json |   0
>  .../perf/pmu-events/arch/x86/nehalemex/other.json  |   0
>  .../pmu-events/arch/x86/nehalemex/pipeline.json    |   0
>  .../arch/x86/nehalemex/virtual-memory.json         |   0
>  .../pmu-events/arch/x86/sandybridge/cache.json     |   0
>  .../arch/x86/sandybridge/floating-point.json       |   0
>  .../pmu-events/arch/x86/sandybridge/frontend.json  |   0
>  .../pmu-events/arch/x86/sandybridge/memory.json    |   0
>  .../pmu-events/arch/x86/sandybridge/other.json     |   0
>  .../pmu-events/arch/x86/sandybridge/pipeline.json  |   0
>  .../arch/x86/sandybridge/snb-metrics.json          |   0
>  .../pmu-events/arch/x86/sandybridge/uncore.json    |   0
>  .../arch/x86/sandybridge/virtual-memory.json       |   0
>  .../perf/pmu-events/arch/x86/silvermont/cache.json |   0
>  .../pmu-events/arch/x86/silvermont/frontend.json   |   0
>  .../pmu-events/arch/x86/silvermont/memory.json     |   0
>  .../perf/pmu-events/arch/x86/silvermont/other.json |   0
>  .../pmu-events/arch/x86/silvermont/pipeline.json   |   0
>  .../arch/x86/silvermont/virtual-memory.json        |   0
>  .../perf/pmu-events/arch/x86/skylake/cache.json    |   0
>  .../arch/x86/skylake/floating-point.json           |   0
>  .../perf/pmu-events/arch/x86/skylake/frontend.json |   0
>  .../perf/pmu-events/arch/x86/skylake/memory.json   |   0
>  .../perf/pmu-events/arch/x86/skylake/other.json    |   0
>  .../perf/pmu-events/arch/x86/skylake/pipeline.json |   0
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |   0
>  .../perf/pmu-events/arch/x86/skylake/uncore.json   |   0
>  .../arch/x86/skylake/virtual-memory.json           |   0
>  .../perf/pmu-events/arch/x86/skylakex/cache.json   |   0
>  .../arch/x86/skylakex/floating-point.json          |   0
>  .../pmu-events/arch/x86/skylakex/frontend.json     |   0
>  .../perf/pmu-events/arch/x86/skylakex/memory.json  |   0
>  .../perf/pmu-events/arch/x86/skylakex/other.json   |   0
>  .../pmu-events/arch/x86/skylakex/pipeline.json     |   0
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   0
>  .../arch/x86/skylakex/uncore-memory.json           |   0
>  .../pmu-events/arch/x86/skylakex/uncore-other.json |   0
>  .../arch/x86/skylakex/virtual-memory.json          |   0
>  .../perf/pmu-events/arch/x86/tigerlake/cache.json  |   0
>  .../arch/x86/tigerlake/floating-point.json         |   0
>  .../pmu-events/arch/x86/tigerlake/frontend.json    |   0
>  .../perf/pmu-events/arch/x86/tigerlake/memory.json |   0
>  .../perf/pmu-events/arch/x86/tigerlake/other.json  |   0
>  .../pmu-events/arch/x86/tigerlake/pipeline.json    |   0
>  .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   0
>  .../arch/x86/tigerlake/virtual-memory.json         |   0
>  .../perf/pmu-events/arch/x86/tremontx/cache.json   |   0
>  .../pmu-events/arch/x86/tremontx/frontend.json     |   0
>  .../perf/pmu-events/arch/x86/tremontx/memory.json  |   0
>  .../perf/pmu-events/arch/x86/tremontx/other.json   |   0
>  .../pmu-events/arch/x86/tremontx/pipeline.json     |   0
>  .../arch/x86/tremontx/uncore-memory.json           |   0
>  .../pmu-events/arch/x86/tremontx/uncore-other.json |   0
>  .../pmu-events/arch/x86/tremontx/uncore-power.json |   0
>  .../arch/x86/tremontx/virtual-memory.json          |   0
>  .../pmu-events/arch/x86/westmereep-dp/cache.json   |   0
>  .../arch/x86/westmereep-dp/floating-point.json     |   0
>  .../arch/x86/westmereep-dp/frontend.json           |   0
>  .../pmu-events/arch/x86/westmereep-dp/memory.json  |   0
>  .../pmu-events/arch/x86/westmereep-dp/other.json   |   0
>  .../arch/x86/westmereep-dp/pipeline.json           |   0
>  .../arch/x86/westmereep-dp/virtual-memory.json     |   0
>  .../pmu-events/arch/x86/westmereep-sp/cache.json   |   0
>  .../arch/x86/westmereep-sp/floating-point.json     |   0
>  .../arch/x86/westmereep-sp/frontend.json           |   0
>  .../pmu-events/arch/x86/westmereep-sp/memory.json  |   0
>  .../pmu-events/arch/x86/westmereep-sp/other.json   |   0
>  .../arch/x86/westmereep-sp/pipeline.json           |   0
>  .../arch/x86/westmereep-sp/virtual-memory.json     |   0
>  .../perf/pmu-events/arch/x86/westmereex/cache.json |   0
>  .../arch/x86/westmereex/floating-point.json        |   0
>  .../pmu-events/arch/x86/westmereex/frontend.json   |   0
>  .../pmu-events/arch/x86/westmereex/memory.json     |   0
>  .../perf/pmu-events/arch/x86/westmereex/other.json |   0
>  .../pmu-events/arch/x86/westmereex/pipeline.json   |   0
>  .../arch/x86/westmereex/virtual-memory.json        |   0
>  tools/{ => lib}/perf/pmu-events/jevents.c          |   6 +-
>  tools/{ => lib}/perf/pmu-events/jsmn.c             |   0
>  tools/{ => lib}/perf/pmu-events/jsmn.h             |   0
>  tools/{ => lib}/perf/pmu-events/json.c             |   0
>  tools/{ => lib}/perf/pmu-events/json.h             |   0
>  tools/{perf/util => lib/perf}/pmu-hybrid.c         |   3 +-
>  tools/lib/perf/pmu.c                               | 117 +++
>  tools/{perf/util => lib/perf}/pmu.l                |   3 +-
>  tools/{perf/util => lib/perf}/pmu.y                |   2 +-
>  tools/lib/perf/tests/Build                         |   1 +
>  tools/lib/perf/tests/main.c                        |   1 +
>  tools/lib/perf/tests/test-evlist.c                 |   2 +
>  tools/lib/perf/tests/test-parse-events.c           |  43 +
>  tools/lib/perf/tests/tests.h                       |   1 +
>  tools/perf/Makefile.perf                           |  22 +-
>  tools/perf/arch/x86/util/kvm-stat.c                |   8 +-
>  tools/perf/arch/x86/util/pmu.c                     |   1 -
>  tools/perf/builtin-c2c.c                           |   2 +-
>  tools/perf/builtin-kvm.c                           |   6 +-
>  tools/perf/builtin-list.c                          |   2 +-
>  tools/perf/builtin-mem.c                           |   2 +-
>  tools/perf/builtin-record.c                        |  12 +-
>  tools/perf/builtin-stat.c                          |  18 +-
>  tools/perf/builtin-top.c                           |   2 +-
>  tools/perf/builtin-trace.c                         |  12 +-
>  tools/perf/tests/event_update.c                    |   2 +-
>  tools/perf/tests/evsel-roundtrip-name.c            |   2 +-
>  tools/perf/tests/evsel-tp-sched.c                  |   6 +-
>  tools/perf/tests/expand-cgroup.c                   |   8 +-
>  tools/perf/tests/parse-events.c                    |  87 +-
>  tools/perf/tests/parse-metric.c                    |   6 +-
>  tools/perf/tests/perf-time-to-tsc.c                |   2 +-
>  tools/perf/tests/pmu-events.c                      |   2 +-
>  tools/perf/util/Build                              |  55 --
>  tools/perf/util/amd-sample-raw.c                   |   2 +-
>  tools/perf/util/arm-spe.c                          |   6 +-
>  tools/perf/util/auxtrace.c                         |   6 +-
>  tools/perf/util/bpf_counter.c                      |   2 +-
>  tools/perf/util/cputopo.c                          |   2 +-
>  tools/perf/util/evlist-hybrid.c                    |   5 +-
>  tools/perf/util/evlist.c                           |  18 +-
>  tools/perf/util/evsel.c                            | 109 +--
>  tools/perf/util/evsel.h                            |  23 +-
>  tools/perf/util/evsel_fprintf.c                    |   2 +-
>  tools/perf/util/fncache.h                          |   7 -
>  tools/perf/util/header.c                           |  32 +-
>  tools/perf/util/intel-pt.c                         |   6 +-
>  tools/perf/util/mem-events.c                       |   2 +-
>  tools/perf/util/metricgroup.c                      |  22 +-
>  tools/perf/util/metricgroup.h                      |   2 +-
>  tools/perf/util/parse-events-hybrid.c              |  26 +-
>  tools/perf/util/parse-events-hybrid.h              |   6 +-
>  tools/perf/util/parse-events.c                     | 971 +++++----------------
>  tools/perf/util/parse-events.h                     | 167 +---
>  tools/perf/util/pmu.c                              | 113 +--
>  tools/perf/util/pmu.h                              |  44 +-
>  tools/perf/util/python-ext-sources                 |   2 -
>  tools/perf/util/record.c                           |   4 +-
>  tools/perf/util/s390-sample-raw.c                  |   2 +-
>  tools/perf/util/sideband_evlist.c                  |   2 +-
>  tools/perf/util/sort.c                             |   6 +-
>  tools/perf/util/srccode.c                          |  10 +-
>  tools/perf/util/stat-display.c                     |  29 +-
>  tools/perf/util/stat-shadow.c                      |  14 +-
>  tools/perf/util/synthetic-events.c                 |  10 +-
>  tools/perf/util/trace-event-info.c                 |   6 +-
>  466 files changed, 2051 insertions(+), 1556 deletions(-)
>  rename tools/{perf/util => lib/api/fs}/fncache.c (95%)
>  create mode 100644 tools/lib/perf/include/internal/parse-events.h
>  rename tools/{perf/util => lib/perf/include/internal}/pmu-hybrid.h (96%)
>  create mode 100644 tools/lib/perf/include/internal/pmu.h
>  rename tools/{perf/pmu-events => lib/perf/include/perf}/pmu-events.h (100%)
>  create mode 100644 tools/lib/perf/parse-events.c
>  rename tools/{perf/util => lib/perf}/parse-events.l (96%)
>  rename tools/{perf/util => lib/perf}/parse-events.y (76%)
>  rename tools/{ => lib}/perf/pmu-events/Build (87%)
>  rename tools/{ => lib}/perf/pmu-events/README (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/bus.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/clock.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/exception.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/instruction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/bus.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/exception.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/armv8-recommended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/arm64/mapfile.csv (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/nds32/mapfile.csv (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/nds32/n13/atcpmu.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/mapfile.csv (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/floating_point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/locks.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/marked.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/nest_metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/others.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/pmc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power10/translation.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/marked.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/pmc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power8/translation.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/marked.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/nest_metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/pmc.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/powerpc/power9/translation.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z10/basic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z10/crypto.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z10/extended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z13/basic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z13/crypto.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z13/extended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z13/transaction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z14/basic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z14/crypto.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z14/extended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z14/transaction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z15/basic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z15/crypto.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z15/crypto6.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z15/extended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z15/transaction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z196/basic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z196/crypto.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_z196/extended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_zec12/basic.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_zec12/crypto.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_zec12/extended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/cf_zec12/transaction.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/s390/mapfile.csv (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/test/arch-std-events.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/test/test_soc/cpu/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/test/test_soc/cpu/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/test/test_soc/cpu/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/test/test_soc/cpu/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/test/test_soc/sys/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/core.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/data-fabric.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen1/recommended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/core.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/data-fabric.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen2/recommended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/branch.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/core.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/data-fabric.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/amdzen3/recommended.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/bonnell/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwell/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmont/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmont/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmont/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmont/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmont/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmont/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmontplus/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmontplus/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmontplus/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmontplus/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmontplus/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/hsw-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswell/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/uncore-cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/haswellx/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/icl-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelake/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/icx-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/uncore-other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/icelakex/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/uncore-cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/ivytown/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/uncore-cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/jaketown/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/knightslanding/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/knightslanding/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/knightslanding/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/knightslanding/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/mapfile.csv (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/silvermont/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/silvermont/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/silvermont/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/silvermont/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/silvermont/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/silvermont/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/skl-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/uncore.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylake/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/skx-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/uncore-other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/skylakex/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/uncore-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/uncore-other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/uncore-power.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/tremontx/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/cache.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/floating-point.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/frontend.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/other.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/pipeline.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/arch/x86/westmereex/virtual-memory.json (100%)
>  rename tools/{ => lib}/perf/pmu-events/jevents.c (99%)
>  rename tools/{ => lib}/perf/pmu-events/jsmn.c (100%)
>  rename tools/{ => lib}/perf/pmu-events/jsmn.h (100%)
>  rename tools/{ => lib}/perf/pmu-events/json.c (100%)
>  rename tools/{ => lib}/perf/pmu-events/json.h (100%)
>  rename tools/{perf/util => lib/perf}/pmu-hybrid.c (97%)
>  create mode 100644 tools/lib/perf/pmu.c
>  rename tools/{perf/util => lib/perf}/pmu.l (91%)
>  rename tools/{perf/util => lib/perf}/pmu.y (98%)
>  create mode 100644 tools/lib/perf/tests/test-parse-events.c
>  delete mode 100644 tools/perf/util/fncache.h
>
