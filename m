Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59820C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABDB613F0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhGOQKW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGOQKW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EE4C06175F;
        Thu, 15 Jul 2021 09:07:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so8462587wro.9;
        Thu, 15 Jul 2021 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGn8v0AZsNXonIn+TnzTtj2wqzovhDsmhmy5/5DhM/8=;
        b=OeZpCvisTOhnd71MPRLK0V7gZDYoqiNFQurDLT8k2K34SOombDHvrPaaSAxloaJ16l
         DiNzKrzpVsMJHFnvRSBuyggyHXZw9VR+0U1BeBgMkb/om92Hogu1wc4v6LK2EJd83MQ6
         2zYsD3DmOsa3H7TbyUijriLOoLX42T4nWubRT+V5qS7bueHf0xIQd31P/UmP1g7Xhtgi
         1JrAuVtd0m5VUo1KS8OQI5Jp2Xfge9wpJQp9VrVbkX05cwg3LxykW61gZptDdicGnc9Q
         Mcm6G+1XH0+amZx+JIEfReNVgqYnwJvl5A5fFhX/gSitDhALVXiwvHrRqvk74uWKaoTh
         R/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGn8v0AZsNXonIn+TnzTtj2wqzovhDsmhmy5/5DhM/8=;
        b=syTZWs1xXxnJ/Zr3G4N47PnL4ymAotvtGnArsZu2XrOrNNsZS33n8waElgXBLmycwQ
         yVNU/3Atv+6kM7kFHF+/+ezEoABGXnsZs2LRBYAEhPbwOg/OlgciP1Z8yB5LbsUBmwOu
         h65ZzMsDbBhirNkxrNxskxHA8iGZXUztWM7DBDLk7h806IJj+VK+msgxqRYt15d1zGv+
         jOWbXp6+nE8voY1I6GArF9/CGU6HJvw0VG4gewwiM/ErSHtodA0qlsE8GJKCQmORZfPX
         8Bk4+hyLtMTVk2ucUOTVwNaqTjqQ/VwOgbbnp0SXntIlIQINrjv44lAFAynxf0pvxgDe
         Xr+Q==
X-Gm-Message-State: AOAM532cJmjll2dFngqgiTd0l/2h6pPB9/SodwfwBq3vkHRBWTqwGre/
        rJbAgX0xpT+aM/A5Ky0Z19U=
X-Google-Smtp-Source: ABdhPJxTj1D41QBi/p1RwtiTSgNLMLFe6p6fjynoeXOLn3tdUNo79i+Dkqvho+0vEUC5oEBKUshyIg==
X-Received: by 2002:adf:f149:: with SMTP id y9mr6402880wro.85.1626365247085;
        Thu, 15 Jul 2021 09:07:27 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:26 -0700 (PDT)
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
Subject: [PATCH 00/20] perf: fix several memory leaks reported by ASan on perf-test
Date:   Thu, 15 Jul 2021 18:07:05 +0200
Message-Id: <cover.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patchset fixes several memory leaks found using ASan on perf-test. 
After this patch, all memory leaks in perf-test that were found on my machine 
are fixed.
This does not mean that there are no longer memory leaks in perf (just running
perf report or perf top raises a few), but that now it is possible to run the 
perf tests with ASan to catch future memory errors.

While many of these leaks have little to no effect on the daily use of perf 
(some were inside the test itself, other were just a missing cleanup on exit), 
other were (slightly) more serious, namely:
 - nsinfo refcounting was broken since it was not decreased when a reference was
   replaced, causing many nsinfos to never being deallocated.
 - dso__new_map refcounting was wrong, missing a __put
 - lzma stream was never closed

Below are the results of perf-test before and after this patchset. Only failed
and skipped tests are reported for brevity.

The perf binary has been compiled using
make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
compilation using clang shows same results.

Tests are run on my laptop: 
Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz (2 cores + hyperthreading)
Fedora 34 w/ kernel 5.12.14-300.fc34.x86_64

Before this patchset:
 1: vmlinux symtab matches kallsyms                                 : FAILED!
19: 'import perf' in python                                         : FAILED!
23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
31: Lookup mmap thread                                              : FAILED!
41: Session topology                                                : FAILED!
42.1: Basic BPF filtering                                           : FAILED!
42.2: BPF pinning                                                   : Skip
42.3: BPF prologue generation                                       : Skip
49: Synthesize attr update                                          : FAILED!
58: builtin clang support                                           : Skip (not compiled in)
63: Test libpfm4 support                                            : Skip (not compiled in)
65: maps__merge_in                                                  : FAILED!
73: DWARF unwind                                                    : FAILED!
78: build id cache operations                                       : FAILED!
82: Use vfs_getname probe to get syscall args filenames             : FAILED!
83: Zstd perf.data compression/decompression                        : FAILED!
86: perf stat --bpf-counters test                                   : Skip
87: Check Arm CoreSight trace data recording and synthesized samples: Skip
88: Check open filename arg using perf trace + vfs_getname          : FAILED!

After this patchset:
19: 'import perf' in python                                         : FAILED!
23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
58: builtin clang support                                           : Skip (not compiled in)
63: Test libpfm4 support                                            : Skip (not compiled in)
73: DWARF unwind                                                    : FAILED!
86: perf stat --bpf-counters test                                   : Skip
87: Check Arm CoreSight trace data recording and synthesized samples: Skip

After this patchset, without ASan:
23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
58: builtin clang support                                           : Skip (not compiled in)
63: Test libpfm4 support                                            : Skip (not compiled in)
86: perf stat --bpf-counters test                                   : Skip
87: Check Arm CoreSight trace data recording and synthesized samples: Skip

The two failing tests are false positives and can be skipped:
 - "19: 'import perf' in python" fails since there are memory leaks inside the 
   python library.
 - "73: DWARF unwind" fails due to stack buffer underflow, since it's unwinding
   the stack.

Riccardo

Riccardo Mancini (20):
  perf nsinfo: fix refcounting
  perf env: fix sibling_dies memory leak
  perf test: session_topology: delete session->evlist
  perf test: event_update: fix memory leak of evlist
  perf test: event_update: fix memory leak of unit
  perf dso: fix memory leak in dso__new_map
  perf test: maps__merge_in: fix memory leak of maps
  perf env: fix memory leak of cpu_pmu_caps
  perf report: free generated help strings for sort option
  perf inject: close inject.output
  perf session: cleanup trace_event
  perf script: release zstd data
  perf script: fix memory leaks in perf_script
  perf util/lzma: close lzma stream
  perf trace: free malloc'd trace fields on exit
  perf trace: free syscall->arg_fmt
  perf trace: free syscall tp fields in evsel->priv
  perf trace: free strings in trace__parse_events_option
  perf test: bpf: free obj_buf
  perf util/probe-file: delete namelist on error in del_events

 tools/perf/builtin-inject.c     | 13 ++++++---
 tools/perf/builtin-report.c     | 33 ++++++++++++++-------
 tools/perf/builtin-script.c     |  8 ++++++
 tools/perf/builtin-trace.c      | 51 +++++++++++++++++++++++++++++++--
 tools/perf/tests/bpf.c          |  1 +
 tools/perf/tests/event_update.c |  6 ++--
 tools/perf/tests/maps.c         |  2 ++
 tools/perf/tests/topology.c     |  1 +
 tools/perf/util/dso.c           |  4 ++-
 tools/perf/util/env.c           |  2 ++
 tools/perf/util/lzma.c          |  8 ++++--
 tools/perf/util/map.c           |  2 ++
 tools/perf/util/probe-event.c   |  4 ++-
 tools/perf/util/probe-file.c    |  4 +--
 tools/perf/util/session.c       |  1 +
 tools/perf/util/sort.c          |  2 +-
 tools/perf/util/sort.h          |  2 +-
 17 files changed, 116 insertions(+), 28 deletions(-)

-- 
2.31.1

