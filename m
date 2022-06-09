Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFEACCA47B
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiFIM2l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiFIM2Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 08:28:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9B13F90
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 05:28:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q1so25971218ljb.5
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZkVNogiVa8TD8+T4Yv+cG2dpFAwHLFgC+ukHCJDT4I=;
        b=IMiMlQXzfUPcw+2OYtInMvM+UurNQEg1HuNbNUI2Yie5fl0zYgUctTMI2LTZZ5nwhk
         t6BUf/I4RveOFGJzjVDTAzjnilpq8YetOifH/y9O7DI+Dv4YQ4NNZkazU2SH5pvQ3MCI
         ULJxqXOjPmG4zkE+aZi6kSC6A3zT+/+paWGtk/ZXl2FO2Bj1b+3AO3yh1YKpv1RS663q
         /KplhvEht9zrJvEUQpt852lRcfB3Vx8ZzK19+5vwth+eiKWRIewLT97C1US/SvpNFtC4
         rZ2j9hkJNRqPUQ+Yeqzhbg4PwVlciNIhCFWrc3lG7mn8BkYG2E9Aevo2ESPNcmcWKc1E
         LHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZkVNogiVa8TD8+T4Yv+cG2dpFAwHLFgC+ukHCJDT4I=;
        b=Jn6pJK7AtnLdRwlON8C8dhvD9QrJKA9oQ7qBWBlS3c2/TaYq1flJVITPL8lQ4hEQ2U
         atqs821JC2PmKjQBtKxGjbeTXyyt4ToSmpLRGWeZlxdIANNaDdQF6ceawSJoZsYn3Q/3
         w3jB5BdvucSCrJqgy4i66gKrSZ3idoJwLOD+0F+U8uYtgK7OmpdZFwwA9xEDIONSExaf
         I8cIdIdHDl1+5EzYwD/4EEKS06M/o7o8YyXgBFlrvGI9FUo0bKKkmuDz8T9jna6biQNS
         dMvz1/1NdQnfPhK8XMAOpM61saf+IOXyAKb4/IVTemWp9w4DbHjFP0lAVHxbnmaUMm8e
         XZbQ==
X-Gm-Message-State: AOAM532ygXXFtYOUMbe+Rpo8UaPSERj9sMedkBu/X4xXLHQaXucyvCWp
        rJbBkXBss8nOfGH2SoexTd2h7ojnndEOYyiwyZan6A==
X-Google-Smtp-Source: ABdhPJxpbYQfKdgekEkNg9JFGcwYFChokxhgQwQATVrBYFZVLYc2xioTL1GBM4ncwJzPdWOXTxbGWM2QIuW5mBKcDb0=
X-Received: by 2002:a2e:8882:0:b0:255:6858:d4c0 with SMTP id
 k2-20020a2e8882000000b002556858d4c0mr24538236lji.268.1654777699961; Thu, 09
 Jun 2022 05:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com>
In-Reply-To: <20220609113046.780504-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:28:08 +0200
Message-ID: <CACT4Y+bA44uBgOZ7Hn74zrnX+agqGQWbkq=bzOX+A726nB2M7Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] perf/hw_breakpoint: Optimize for thousands of tasks
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 9 Jun 2022 at 13:30, Marco Elver <elver@google.com> wrote:
>
> The hw_breakpoint subsystem's code has seen little change in over 10
> years. In that time, systems with >100s of CPUs have become common,
> along with improvements to the perf subsystem: using breakpoints on
> thousands of concurrent tasks should be a supported usecase.
>
> The breakpoint constraints accounting algorithm is the major bottleneck
> in doing so:
>
>   1. task_bp_pinned() has been O(#tasks), and called twice for each CPU.
>
>   2. Everything is serialized on a global mutex, 'nr_bp_mutex'.
>
> This series first optimizes task_bp_pinned() to only take O(1) on
> average, and then reworks synchronization to allow concurrency when
> checking and updating breakpoint constraints for tasks. Along the way,
> smaller micro-optimizations and cleanups are done as they seemed obvious
> when staring at the code (but likely insignificant).
>
> The result is (on a system with 256 CPUs) that we go from:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>                 [ ^ more aggressive benchmark parameters took too long ]
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 236.418 [sec]
>  |
>  |   123134.794271 usecs/op
>  |  7880626.833333 usecs/op/cpu
>
> ... to -- with all optimizations:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 0.071 [sec]
>  |
>  |       37.134896 usecs/op
>  |     2376.633333 usecs/op/cpu
>
> On the used test system, that's an effective speedup of ~3315x per op.

Awesome!

> Which is close to the theoretical ideal performance through
> optimizations in hw_breakpoint.c -- for reference, constraints
> accounting disabled:
>
>  | perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 0.067 [sec]
>  |
>  |       35.286458 usecs/op
>  |     2258.333333 usecs/op/cpu
>
> At this point, the current implementation is only ~5% slower than the
> theoretical ideal. However, given constraints accounting cannot
> realistically be disabled, this is likely as far as we can push it.
>
> Marco Elver (8):
>   perf/hw_breakpoint: Optimize list of per-task breakpoints
>   perf/hw_breakpoint: Mark data __ro_after_init
>   perf/hw_breakpoint: Optimize constant number of breakpoint slots
>   perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
>   perf/hw_breakpoint: Remove useless code related to flexible
>     breakpoints
>   perf/hw_breakpoint: Reduce contention with large number of tasks
>   perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent
>   perf/hw_breakpoint: Clean up headers
>
>  arch/sh/include/asm/hw_breakpoint.h  |   5 +-
>  arch/x86/include/asm/hw_breakpoint.h |   5 +-
>  include/linux/hw_breakpoint.h        |   1 -
>  include/linux/perf_event.h           |   3 +-
>  kernel/events/hw_breakpoint.c        | 374 +++++++++++++++++++--------
>  5 files changed, 276 insertions(+), 112 deletions(-)
>
> --
> 2.36.1.255.ge46751e96f-goog
