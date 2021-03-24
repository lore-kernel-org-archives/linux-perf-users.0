Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CFC433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314C161A1D
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 23:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhCXXR6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbhCXXRd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Mar 2021 19:17:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CFC06174A;
        Wed, 24 Mar 2021 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=B9IH6Bm0/kSsdrM6qZIGkSgskCeTe3eOs2ebC18G4xk=; b=I9pvyFT7SGaMOckWRDIUkuRQ6h
        zc9X56fajLFpQqlSCiB3ZkBNvDVyaeR08XJg97C/thMELzmLH/afH/EN+2hpwWOWvhJxH5WiPVsjr
        xd+2GezB6NY1Rj60GB2vCqorV5iLk4iovY2DBYaLHvAM7f3w6rCUQQsbaED2vKmgo3VMDTBHtIu1V
        d5qq7tIbqGDkN1VugJczq49BKfYcS+VvK0RRiVr0B45mo1GJC2zWbrTLhlXMAD+IuQ9IzxLnCW+X8
        YxEdf2hqRijO2qfKUF3YpJlWYTGl7I22v7PNDzn7+wRSBb3uUFzLOpYn+HX867WFmtVvq7A2a6Fcp
        fakzrhmg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPCkj-000LE1-DV; Wed, 24 Mar 2021 23:17:29 +0000
Subject: Re: [PATCH, -v2] perf tools: Fix various typos in comments
To:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <20210321113734.GA248990@gmail.com>
 <20210323160915.GA61903@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <543bd87e-5059-002b-4cc4-a262fe5eb1ff@infradead.org>
Date:   Wed, 24 Mar 2021 16:17:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323160915.GA61903@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/23/21 9:09 AM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>> Fix ~81 single-word typos in the perf tooling code - accumulated over the years.
> 
> Found a few more:
> 
> =============>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Sun, 21 Mar 2021 12:37:34 +0100
> Subject: [PATCH] perf tools: Fix various typos in comments
> 
> Fix ~124 single-word typos and a few spelling errors in the perf tooling code,
> accumulated over the years.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20210321113734.GA248990@gmail.com
> ---
>  tools/perf/Documentation/perf-buildid-cache.txt        |  2 +-
>  tools/perf/Documentation/perf-report.txt               |  2 +-
>  tools/perf/Documentation/perf-top.txt                  |  2 +-
>  tools/perf/arch/arm/util/cs-etm.c                      |  2 +-
>  tools/perf/arch/arm64/util/machine.c                   |  8 ++++----
>  tools/perf/arch/arm64/util/perf_regs.c                 |  2 +-
>  tools/perf/arch/powerpc/util/kvm-stat.c                |  2 +-
>  tools/perf/arch/powerpc/util/utils_header.h            |  2 +-
>  tools/perf/arch/x86/tests/bp-modify.c                  |  2 +-
>  tools/perf/arch/x86/util/perf_regs.c                   |  4 ++--
>  tools/perf/bench/epoll-wait.c                          |  4 ++--
>  tools/perf/bench/numa.c                                |  2 +-
>  tools/perf/builtin-annotate.c                          |  2 +-
>  tools/perf/builtin-diff.c                              |  2 +-
>  tools/perf/builtin-lock.c                              |  2 +-
>  tools/perf/builtin-sched.c                             |  2 +-
>  tools/perf/builtin-script.c                            |  4 ++--
>  tools/perf/builtin-stat.c                              |  4 ++--
>  tools/perf/builtin-top.c                               |  2 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c       |  4 ++--
>  tools/perf/jvmti/jvmti_agent.c                         |  4 ++--
>  tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 12 ++++++------
>  tools/perf/pmu-events/arch/powerpc/power9/metrics.json |  2 +-
>  tools/perf/pmu-events/jevents.c                        |  2 +-
>  tools/perf/scripts/python/netdev-times.py              |  2 +-
>  tools/perf/tests/bp_signal.c                           |  6 +++---
>  tools/perf/tests/code-reading.c                        |  2 +-
>  tools/perf/tests/hists_cumulate.c                      |  4 ++--
>  tools/perf/tests/parse-events.c                        |  2 +-
>  tools/perf/tests/parse-metric.c                        |  2 +-
>  tools/perf/tests/topology.c                            |  2 +-
>  tools/perf/trace/beauty/include/linux/socket.h         |  2 +-
>  tools/perf/ui/browsers/annotate.c                      |  2 +-
>  tools/perf/ui/browsers/hists.c                         |  2 +-
>  tools/perf/util/bpf-loader.c                           |  2 +-
>  tools/perf/util/call-path.h                            |  2 +-
>  tools/perf/util/callchain.c                            |  2 +-
>  tools/perf/util/config.c                               |  2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c        |  2 +-
>  tools/perf/util/cs-etm.c                               |  8 ++++----
>  tools/perf/util/cs-etm.h                               |  5 +++--
>  tools/perf/util/data-convert-bt.c                      |  2 +-
>  tools/perf/util/demangle-java.c                        |  4 ++--
>  tools/perf/util/dso.h                                  |  2 +-
>  tools/perf/util/dwarf-aux.c                            |  6 +++---
>  tools/perf/util/dwarf-aux.h                            |  2 +-
>  tools/perf/util/events_stats.h                         |  2 +-
>  tools/perf/util/evlist.c                               |  2 +-
>  tools/perf/util/evsel.c                                |  4 ++--
>  tools/perf/util/expr.h                                 |  2 +-
>  tools/perf/util/header.c                               | 18 +++++++++---------
>  tools/perf/util/intel-pt.c                             |  2 +-
>  tools/perf/util/levenshtein.c                          |  2 +-
>  tools/perf/util/libunwind/arm64.c                      |  2 +-
>  tools/perf/util/libunwind/x86_32.c                     |  2 +-
>  tools/perf/util/llvm-utils.c                           |  2 +-
>  tools/perf/util/machine.c                              |  8 ++++----
>  tools/perf/util/map.h                                  |  4 ++--
>  tools/perf/util/mem-events.h                           |  2 +-
>  tools/perf/util/metricgroup.c                          |  2 +-
>  tools/perf/util/parse-events.c                         | 10 +++++-----
>  tools/perf/util/pmu.c                                  |  4 ++--
>  tools/perf/util/probe-event.c                          |  4 ++--
>  tools/perf/util/probe-finder.c                         |  6 +++---
>  tools/perf/util/s390-cpumsf.c                          | 10 +++++-----
>  tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
>  tools/perf/util/session.c                              |  4 ++--
>  tools/perf/util/strbuf.h                               |  2 +-
>  tools/perf/util/strfilter.h                            |  4 ++--
>  tools/perf/util/symbol-elf.c                           |  2 +-
>  tools/perf/util/synthetic-events.c                     |  4 ++--
>  tools/perf/util/unwind-libunwind-local.c               |  2 +-
>  72 files changed, 125 insertions(+), 124 deletions(-)
> 

> diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
> index 40c5e0b5bda8..acdf8dc1189b 100644
> --- a/tools/perf/arch/arm64/util/machine.c
> +++ b/tools/perf/arch/arm64/util/machine.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/ SPDX-License-Identifier: GPL-2.0

That is the only problem that I found, and I see that found
that one.

>  #include <inttypes.h>
>  #include <stdio.h>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

(yeah, I'm late)

-- 
~Randy

