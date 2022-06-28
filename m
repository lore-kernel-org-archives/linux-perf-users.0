Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995BCC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 09:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiF1J7G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245008AbiF1J7B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:01 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC42E9C2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:59:00 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w8-20020a056402268800b004379267f163so4239124edd.20
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MrF5aaShEN6B7UjaZWC1TSqA3Z20kM5d1l/pRL2xCe0=;
        b=kpac3JTWggRdiHBa1fh59jMkbCSb9OblwJN+RfZ/fjE4TPO76j/gmwnSWiMqirO/RA
         MtTi0fzXw/WvbDygEa8XmyBZWWv2LuPU5ilmvRbvg+qDo7rJ6DcpD45MbwShAf9gYcT4
         58D0kDspgGu8+ctdqSssbUA7tsc65VeY5aG4g876MM2ToFCKqdihwENvPWn0UTUi6yl4
         lzT6hrrYw9uwZNPpHny3QZvwu6p21XsvqJUitxVvhT50c15CL3uUPY2xFITl5liDkI7H
         p1WOWea+7N0BdGIRUCqRUJNLZg9qyiTWACWLDmZ4AN7CghQcExbp5T5IhlOXd+FnUH9J
         UWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MrF5aaShEN6B7UjaZWC1TSqA3Z20kM5d1l/pRL2xCe0=;
        b=8JXxO91lxgSlGLEYP5vIcsEbQpP0ipfPeWf/1KZ9BuKmqWUnln60Ow+H7E4OIVvWkq
         sXH/qoZm5vfM7b9BZ80TkUJuqsNBVQ0LUzQdGkQIYW4KTcDuP4IxCQjqqjcOSqeH/Xz7
         4PeC1d/yVdu3aNHF9BLpa8QHQxq4TgBHoL9QSfb1vjQ9ML4YiAMw6zJ7T1s+twHEbccD
         EgkyySvtmGgAqBAsuePuXaI1mm3I22/6NAn/KotsoxhHRIZs/yhvgIqNXy1PbpxaRH0o
         cY/D00Qn4fkfAyLDOHtEusrwcJONC1ahBFLPGXfl51/qDL+cjGRcRnrN4IT/i6Slr+I1
         NK7Q==
X-Gm-Message-State: AJIora+rBQd1XPV36K2S4Br0Wp/hYyduCXsaqs4WD7usfm+eY4MBVopZ
        4RhvSCyxlh/eN/sGUFQJouXj1nrZGg==
X-Google-Smtp-Source: AGRyM1u3/0hvVVmDLacPPBFeWP8vaAFalfonAP5U/UldSOaNizgt1tCkuWBKHhsyPyl7bj7GKBvrytijQg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a05:6402:1c09:b0:435:6562:e70d with SMTP id
 ck9-20020a0564021c0900b004356562e70dmr21782463edb.203.1656410338427; Tue, 28
 Jun 2022 02:58:58 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:20 +0200
Message-Id: <20220628095833.2579903-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 00/13] perf/hw_breakpoint: Optimize for thousands of tasks
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

v2:
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

Marco Elver (13):
  perf/hw_breakpoint: Add KUnit test for constraints accounting
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
 include/linux/hw_breakpoint.h        |   1 -
 include/linux/percpu-rwsem.h         |   6 +
 include/linux/perf_event.h           |   3 +-
 kernel/events/Makefile               |   1 +
 kernel/events/hw_breakpoint.c        | 594 ++++++++++++++++++++-------
 kernel/events/hw_breakpoint_test.c   | 321 +++++++++++++++
 kernel/locking/percpu-rwsem.c        |   6 +
 lib/Kconfig.debug                    |  10 +
 11 files changed, 826 insertions(+), 179 deletions(-)
 create mode 100644 kernel/events/hw_breakpoint_test.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

