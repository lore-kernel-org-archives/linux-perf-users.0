Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC145C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851E4611EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhHUJU1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhHUJU1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6813C061575;
        Sat, 21 Aug 2021 02:19:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z20so25180779ejf.5;
        Sat, 21 Aug 2021 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNhwlYCFxIsxfxHGWTfCyvwhYhQYYLG4sGsEIO4+KlA=;
        b=RFeY+DOrcj8Ia/6gfRHvGUE0vHQdbmAxU1Upyc3xFBBrJdm/c+tNgC85qHVc22AMbA
         koS+zqBeSaYszwkuj4Ai5LYSlPNy7KqMNog2WKOd+zdnPsh4q3jsnzaYYi3aigGZC/MD
         3Y5wEVG/Om/9FUlWAVF+lb5n66YBOrJWUSWwr1jkVrIcDz4y5NbXmTQKYFE+NlCj/fp6
         AliTa8HvhGLBu1Sr9eFXdooEMDpvi9qJe3YjY0+mLUhF7HjLMZvbQV0wfFGBdb2VZzBz
         XtrmNEr3SYpoZI2d35y0iJGBuAJdQw6sWVRY32jgTy+hnLPIWPwdD7qGy1Fu8mK+Apqo
         2a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNhwlYCFxIsxfxHGWTfCyvwhYhQYYLG4sGsEIO4+KlA=;
        b=j6Qjt5bydGjsijA6Brb5Tkqze0Y5eFMVeke8TLNrvkY+Yj1IYk6WFRZYyu96Ict9ad
         B4oaD9XyvHnTVnv5S9AsE352EoPGevvxPyBhrtOCL/HtBdvsEp+c69TjcEFvb4tQiMCA
         7t2ucMLZO5fPPKMDen0HtDFUyyqYDIXOUKGWGFRVe96aEV5ps4kT3qkErRn6Kpg7ZsPX
         7Ieg4AGOFkIMHbORsAgM2QXcteQJPnF4fsWf7lq90tRnugCuMs0TXUbjvEzEbQ4T1nYw
         qGVNHYzrALhgcaQaMOtjOf1+970VebeP49FqMnk2fhrjNVtAJxNFyDJBhgpzrrdkKIjC
         rC/w==
X-Gm-Message-State: AOAM532Qvui3jEDEMwxyq/UiSjdN3nqzU48FpBRcw5HlEVxd90uyZrZR
        8dqViaMa8Yzvs6s8qRXH5GQ=
X-Google-Smtp-Source: ABdhPJzebR0NMfXrkQQS/6YrsPl3gnHV9MyEoPbavjZHhosYvUzvfySz2bwpyWQJjjoC61nQ8U9sxg==
X-Received: by 2002:a17:906:cd10:: with SMTP id oz16mr25148015ejb.428.1629537586318;
        Sat, 21 Aug 2021 02:19:46 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:45 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 00/37] perf: use workqueue for evlist operations
Date:   Sat, 21 Aug 2021 11:19:06 +0200
Message-Id: <cover.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

this patchset adds multithreading through the workqueue to the most
important evlist operations: enable, disable, close, and open.
Their multithreaded implementation is then used in perf-record through
a new option '--threads'.
It is dependent on the workqueue patchset (v3):
https://lore.kernel.org/lkml/cover.1629454773.git.rickyman7@gmail.com/

In each operation, each worker is assigned a cpu and pins itself to that
cpu to perform the operation on all evsels. In case enough threads are
provided, the underlying threads are pinned to the cpus, otherwise, they
just change their affinity temporarily.

Parallelization of enable, disable, and close is pretty straightforward,
while open requires more work to separate the actual open from all 
fallback mechanisms.
In the multithreaded implementation of open, each thread will run until it
finishes or gets an error. When all threads finish, the main process
checks for errors. If it finds one, it applies a fallback and resumes the
open on all cpus from where they encountered the error.

I have tested the main fallback mechanisms (precise_ip, ignore missing
thread,fd limit increase), but not all of the missing feature ones.
I also ran perf test, with no errors. Below you can find the skipped 
tests (I ommitted successfull results for brevity):
$ sudo ./perf test
23: Watchpoint                                                      :
23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
58: builtin clang support                                           : Skip (not compiled in)
63: Test libpfm4 support                                            : Skip (not compiled in)
89: perf stat --bpf-counters test                                   : Skip
90: Check Arm CoreSight trace data recording and synthesized samples: Skip

I know the patchset is huge, but I didn't have time to split it (and 
my time is running out). In any case, I tried to keep related patches
close together. It is organized as follows:
 -  1 -  3: remove the cpu iterator inside evsel to simplify
            parallelization. In the doing, cpumap idx and max methods are
            improved based on the assumption that the cpumap is ordered.
 -  4 -  5: preparation patches for adding affinities to threadpool.
 -  6 -  8: add affinity support to threadpool and workqueue (preparation
            for adding workqueue to evsel).
 -       9: preparation for adding workqueue to evsel.
 - 10 - 13: add multithreading to evlist enable, disable, and close.
 - 14 - 27: preparation for adding multithreading to evlist__open.
 -      28: add multithreading to evlist__open.
 - 29 - 34: use multithreaded evlist operations in perf-record.
 - 35 - 38: improve evlist-open-close benchmark, adding multithreading
            and detailed output.

I'll be happy to split it if necessary in the future, with the goal of
merging my GSoC work, but, for now, I need to send it as is to include it
in my final report.

Below are some experimental results of evlist-open-close benchmark run on:
 - laptop (2 cores + hyperthreading)
 - vm (16 vCPUs)

The command line was:
$ ./perf bench internals evlist-open-close [-j] <options>

where [-j] was included only in the specified rows and <options> refers
to the column label:
 - "" (dummy): open one dummy event on all cpus.
 - "-n 100": open 100 dummy events on all cpus.
 - "-e '{cs,cycles}'": open the "{cs,cycles}" group on all cpus.
 - "-u 0": open one dummy event on all cpus for all processes of root user
           (~300 on my laptop; ~360 on my VM).

Results:
machine   configuration   (dummy)       -n 100     -e '{cs,cycles}'      -u 0
laptop    perf/core     980 +- 130   10514 +- 313   31950 +- 526    14529 +- 241
laptop    this w/o -j   698 +- 102   11302 +- 283   31807 +- 448    13885 +- 143
laptop    this w/ -j   2233 +- 261    5434 +- 386   13586 +- 443     9465 +- 568
vm        perf/core    9818 +-  94   89993 +- 941        N/A       266414 +-1431
vm        this w/o -j  5245 +-  88   82806 +- 922        N/A       260416 +-1563
vm        this w -j   37787 +- 748   54844 +-1089        N/A       101088 +-1900

Comments:
 - opening one dummy event in single threaded mode is faster than 
   perf/core, probably due to the changes in how evsel cpus are iterated.
 - opening one event in multithreaded mode is not worth it.
 - in all other cases, multithreaded mode is between 1.5x and 2.5x faster.

Time breakdown on my laptop:
One dummy event per cpu:
$  ./perf bench internals evlist-open-close -d
# Running 'internals/evlist-open-close' benchmark:
  Number of workers:    1
  Number of cpus:       4
  Number of threads:    1
  Number of events:     1 (4 fds)
  Number of iterations: 100
  Average open-close took:      879.250 usec (+-      103.238 usec)
                init took:        0.040 usec (+-        0.020 usec)
                open took:       28.900 usec (+-        6.675 usec)
                mmap took:      415.870 usec (+-       17.391 usec)
              enable took:      240.950 usec (+-       92.641 usec)
             disable took:       64.670 usec (+-        9.722 usec)
              munmap took:       16.450 usec (+-        3.571 usec)
               close took:      112.100 usec (+-       25.465 usec)
                fini took:        0.220 usec (+-        0.042 usec)
$ ./perf bench internals evlist-open-close -j -d
# Running 'internals/evlist-open-close' benchmark:
  Number of workers:    4
  Number of cpus:       4
  Number of threads:    1
  Number of events:     1 (4 fds)
  Number of iterations: 100
  Average open-close took:     1979.670 usec (+-      271.772 usec)
                init took:       30.860 usec (+-        1.190 usec)
                open took:      552.040 usec (+-       96.166 usec)
                mmap took:      428.970 usec (+-        9.492 usec)
              enable took:      222.740 usec (+-       56.112 usec)
             disable took:      191.990 usec (+-       55.029 usec)
              munmap took:       13.670 usec (+-        0.754 usec)
               close took:      155.660 usec (+-       44.079 usec)
                fini took:      383.520 usec (+-       87.476 usec)

Comments: 
 - the overhead comes from open (spinnig up threads) and fini 
   (terminating threads). There could be some improvements there (e.g.
   not waiting for the thread to spawn).
 - enable, disable, and close also take longer due to the overhead of
   assigning the tasks to the workers.

One dummy event per process per cpu:
$ ./perf bench internals evlist-open-close -d -u0
# Running 'internals/evlist-open-close' benchmark:
  Number of workers:    1
  Number of cpus:       4
  Number of threads:    295
  Number of events:     1 (1180 fds)
  Number of iterations: 100
  Average open-close took:    15101.380 usec (+-      247.959 usec)
                init took:        0.010 usec (+-        0.010 usec)
                open took:     4224.460 usec (+-      119.028 usec)
                mmap took:     3235.210 usec (+-       55.867 usec)
              enable took:     2359.570 usec (+-       44.923 usec)
             disable took:     2321.100 usec (+-       80.779 usec)
              munmap took:      304.440 usec (+-       11.558 usec)
               close took:     2655.920 usec (+-       59.089 usec)
                fini took:        0.380 usec (+-        0.051 usec)
$ ./perf bench internals evlist-open-close -j -d -u0
# Running 'internals/evlist-open-close' benchmark:
  Number of workers:    4
  Number of cpus:       4
  Number of threads:    298
  Number of events:     1 (1192 fds)
  Number of iterations: 100
  Average open-close took:    10321.060 usec (+-      771.875 usec)
                init took:       31.530 usec (+-        0.721 usec)
                open took:     2849.870 usec (+-      533.019 usec)
                mmap took:     3267.810 usec (+-       87.465 usec)
              enable took:     1041.160 usec (+-       66.324 usec)
             disable took:     1176.970 usec (+-      134.291 usec)
              munmap took:      253.680 usec (+-        4.525 usec)
               close took:     1204.550 usec (+-      101.284 usec)
                fini took:      495.260 usec (+-      136.661 usec)
Comments:
 - mmap/munmap are not parallelized and account for 20% of the time.
 - open time is reduced by 33% (due to overhead of spinning up threads,
   which is around half ms).
 - enable, disable, and close times are halved.

It is not always worth using multithreading in evlist operations, but
in the good cases the improvements can be significant.
For this reason, we could include an heuristic to decide whether to
use it or not (e.g. use it only if there are less than X event fds to open).

It'd be great to see more experiments like these on a bigger machine, and
on a more realistic scenario (instead of dummy events).

Thanks,
Riccardo

Riccardo Mancini (37):
  libperf cpumap: improve idx function
  libperf cpumap: improve max function
  perf evlist: replace evsel__cpu_iter* functions with evsel__find_cpu
  perf util: add mmap_cpu_mask__duplicate function
  perf util/mmap: add missing bitops.h header
  perf workqueue: add affinities to threadpool
  perf workqueue: add support for setting affinities to workers
  perf workqueue: add method to execute work on specific CPU
  perf python: add workqueue dependency
  perf evlist: add multithreading helper
  perf evlist: add multithreading to evlist__disable
  perf evlist: add multithreading to evlist__enable
  perf evlist: add multithreading to evlist__close
  perf evsel: remove retry_sample_id goto label
  perf evsel: separate open preparation from open itself
  perf evsel: save open flags in evsel
  perf evsel: separate missing feature disabling from evsel__open_cpu
  perf evsel: add evsel__prepare_open function
  perf evsel: separate missing feature detection from evsel__open_cpu
  perf evsel: separate rlimit increase from evsel__open_cpu
  perf evsel: move ignore_missing_thread to fallback code
  perf evsel: move test_attr__open to success path in evsel__open_cpu
  perf evsel: move bpf_counter__install_pe to success path in
    evsel__open_cpu
  perf evsel: handle precise_ip fallback in evsel__open_cpu
  perf evsel: move event open in evsel__open_cpu to separate function
  perf evsel: add evsel__open_per_cpu_no_fallback function
  perf evlist: add evlist__for_each_entry_from macro
  perf evlist: add multithreading to evlist__open
  perf evlist: add custom fallback to evlist__open
  perf record: use evlist__open_custom
  tools lib/subcmd: add OPT_UINTEGER_OPTARG option type
  perf record: add --threads option
  perf record: pin threads to monitored cpus if enough threads available
  perf record: apply multithreading in init and fini phases
  perf test/evlist-open-close: add multithreading
  perf test/evlist-open-close: use inline func to convert timeval to
    usec
  perf test/evlist-open-close: add detailed output mode

 tools/lib/perf/cpumap.c                  |  27 +-
 tools/lib/subcmd/parse-options.h         |   1 +
 tools/perf/Documentation/perf-record.txt |   9 +
 tools/perf/bench/evlist-open-close.c     | 116 +++++-
 tools/perf/builtin-record.c              | 128 ++++--
 tools/perf/builtin-stat.c                |  24 +-
 tools/perf/tests/workqueue.c             |  87 ++++-
 tools/perf/util/evlist.c                 | 464 +++++++++++++++++-----
 tools/perf/util/evlist.h                 |  44 ++-
 tools/perf/util/evsel.c                  | 473 ++++++++++++++---------
 tools/perf/util/evsel.h                  |  36 +-
 tools/perf/util/mmap.c                   |  12 +
 tools/perf/util/mmap.h                   |   4 +
 tools/perf/util/python-ext-sources       |   2 +
 tools/perf/util/record.h                 |   3 +
 tools/perf/util/workqueue/threadpool.c   |  70 ++++
 tools/perf/util/workqueue/threadpool.h   |   7 +
 tools/perf/util/workqueue/workqueue.c    | 154 +++++++-
 tools/perf/util/workqueue/workqueue.h    |  18 +
 19 files changed, 1334 insertions(+), 345 deletions(-)

-- 
2.31.1

