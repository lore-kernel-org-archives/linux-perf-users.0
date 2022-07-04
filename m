Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C52FC43334
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 15:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGDPGA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiGDPF7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 11:05:59 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF7FD0E
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 08:05:57 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id kv9-20020a17090778c900b007262b461ecdso2090540ejc.6
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vCw+qYcLfEryg0NCqZvoZGaEOfEUqqIfSJ3H2Y/La+U=;
        b=HFp/v8d2JOu2HioOUO0UTDm9Zyhs+v2Kftdg2XX6m5HUrg5WguofD2OUwXCJFmS2t5
         MzJ+MRI0ygIfoJcIf/tMFNJNZbGyjzyrLWGWivMyMHmp8eVi4nsp7ExUK3gmGVz/wyw0
         7U6+cUacp1FI8hB1JqPYKjF6K/yUIZFAuD4PFsJqvZ864ha8FmfiajnGNjREe9ugM/7A
         2bwVpugmtHL2oGjoONBY82pn1ytKFJaNZ1V8XrMgfIf418nJTEtcHiaSuoetYrZep8i9
         0Co/EUanDPBpyvGSg4MjLbGcZRFp1iZpG2VX08sIwcAZPlkaF3A6n4gwMxMPGNYD6Br1
         yaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vCw+qYcLfEryg0NCqZvoZGaEOfEUqqIfSJ3H2Y/La+U=;
        b=ji0OVGceVlXVYNq14rNEvsWCNFX2f95F6pWJ/hMFe6lhhu5oz8eX1nKhi07BpsBTwm
         D/nhvpX9SsKGA0emmLvAuEonPKCvSr2kMW/ndUK05lQybTJPiJinBEcpz2ft8l0nz7H3
         l9qNx/t2WIdECD9xYQA49K0kaqJAODMiCcdoX0NWbf5tsgZ2szhhdtTlACRP6/SCcvRD
         O/bC5cOZ4pwboML0BnN1ycpCDSyuAu+C48lonFOijFoqE4LqmCCRH7XvC9/hGvdi1k78
         OOV7Cm1zb5/cA0RaURxBP0YLWRXhdR7PianzRpym2bUktaVaRzOgnabHsQ3h0K7iGyLk
         rdkA==
X-Gm-Message-State: AJIora8K/3C5c+CohPAuCZSADGSP6qyALg3J+VQRJPbo0Gahih60XTUQ
        U07ZD9aLSZx4DVbLd9xQaavKRBZ/QQ==
X-Google-Smtp-Source: AGRyM1vcv+ey9wUHmm7mpO7HIaPskiyQmKiaXY4E4O4MknYpkUaDhKf/gg5exg6tZAXZRBybUUWCEVO2Hg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id
 dd6-20020a1709069b8600b006f824e7af7dmr29696674ejc.295.1656947155542; Mon, 04
 Jul 2022 08:05:55 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:00 +0200
Message-Id: <20220704150514.48816-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 00/14] perf/hw_breakpoint: Optimize for thousands of tasks
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The hw_breakpoint subsystem's code has seen little change in over 10
years. In that time, systems with >100s of CPUs have become common,
along with improvements to the perf subsystem: using breakpoints on
thousands of concurrent tasks should be a supported usecase.

The breakpoint constraints accounting algorithm is the major bottleneck
in doing so:

  1. toggle_bp_slot() and fetch_bp_busy_slots() are O(#cpus * #tasks):
     Both iterate through all CPUs and call task_bp_pinned(), which is
     O(#tasks).

  2. Everything is serialized on a global mutex, 'nr_bp_mutex'.

The series progresses with the simpler optimizations and finishes with
the more complex optimizations:

 1. We first optimize task_bp_pinned() to only take O(1) on average.

 2. Rework synchronization to allow concurrency when checking and
    updating breakpoint constraints for tasks.

 3. Eliminate the O(#cpus) loops in the CPU-independent case.

Along the way, smaller micro-optimizations and cleanups are done as they
seemed obvious when staring at the code (but likely insignificant).

The result is (on a system with 256 CPUs) that we go from:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
	 	[ ^ more aggressive benchmark parameters took too long ]
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 236.418 [sec]
 |
 |   123134.794271 usecs/op
 |  7880626.833333 usecs/op/cpu

... to the following with all optimizations:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 0.067 [sec]
 |
 |       35.292187 usecs/op
 |     2258.700000 usecs/op/cpu

On the used test system, that's an effective speedup of ~3490x per op.

Which is on par with the theoretical ideal performance through
optimizations in hw_breakpoint.c (constraints accounting disabled), and
only 12% slower than no breakpoints at all.

Changelog
---------

v3:
* Fix typos.
* Introduce hw_breakpoint_is_used() for the test.
* Add WARN_ON in bp_blots_histogram_add().
* Don't use raw_smp_processor_id() in test.
* Apply Acked-by/Reviewed-by given in v2 for mostly unchanged patches.

v2: https://lkml.kernel.org/r/20220628095833.2579903-1-elver@google.com
 * Add KUnit test suite.
 * Remove struct bp_busy_slots and simplify functions.
 * Add "powerpc/hw_breakpoint: Avoid relying on caller synchronization".
 * Add "locking/percpu-rwsem: Add percpu_is_write_locked() and percpu_is_read_locked()".
 * Use percpu-rwsem instead of rwlock.
 * Use task_struct::perf_event_mutex instead of sharded mutex.
 * Drop v1 "perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent".
 * Add "perf/hw_breakpoint: Introduce bp_slots_histogram".
 * Add "perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent task targets".
 * Add "perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task targets".
 * Apply Acked-by/Reviewed-by given in v1 for unchanged patches.
==> Speedup of ~3490x (vs. ~3315x in v1).

v1: https://lore.kernel.org/all/20220609113046.780504-1-elver@google.com/

Marco Elver (14):
  perf/hw_breakpoint: Add KUnit test for constraints accounting
  perf/hw_breakpoint: Provide hw_breakpoint_is_used() and use in test
  perf/hw_breakpoint: Clean up headers
  perf/hw_breakpoint: Optimize list of per-task breakpoints
  perf/hw_breakpoint: Mark data __ro_after_init
  perf/hw_breakpoint: Optimize constant number of breakpoint slots
  perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
  perf/hw_breakpoint: Remove useless code related to flexible
    breakpoints
  powerpc/hw_breakpoint: Avoid relying on caller synchronization
  locking/percpu-rwsem: Add percpu_is_write_locked() and
    percpu_is_read_locked()
  perf/hw_breakpoint: Reduce contention with large number of tasks
  perf/hw_breakpoint: Introduce bp_slots_histogram
  perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent
    task targets
  perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task
    targets

 arch/powerpc/kernel/hw_breakpoint.c  |  53 ++-
 arch/sh/include/asm/hw_breakpoint.h  |   5 +-
 arch/x86/include/asm/hw_breakpoint.h |   5 +-
 include/linux/hw_breakpoint.h        |   4 +-
 include/linux/percpu-rwsem.h         |   6 +
 include/linux/perf_event.h           |   3 +-
 kernel/events/Makefile               |   1 +
 kernel/events/hw_breakpoint.c        | 638 ++++++++++++++++++++-------
 kernel/events/hw_breakpoint_test.c   | 333 ++++++++++++++
 kernel/locking/percpu-rwsem.c        |   6 +
 lib/Kconfig.debug                    |  10 +
 11 files changed, 885 insertions(+), 179 deletions(-)
 create mode 100644 kernel/events/hw_breakpoint_test.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

