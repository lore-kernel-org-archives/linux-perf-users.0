Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F6C7EE29
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbjFGBoh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbjFGBoN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5F19B7
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568bc5db50dso3146847b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102250; x=1688694250;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+NrEcbwPBOpk0EwDAsT956pzayXcPTozL+X916keWM=;
        b=ihZc1GkVfXGtjLpOyBhShfyyoisYkAc9ytIA7e1nXdd+vWRvYBdn9SQ+uQu6ewAOSy
         QXt97SmKFnQ4ud+LZKahKFx8IX9kvnpg13jOMgnvUDkUwZe1657qrDzwasTbzhbJIZtE
         SbHCLBOkE2/TI0G2kjVumTBJzv68I+JbcwuT5QRYEiJq3tgSVEPUiOsOXJUtYGTiTQKX
         ViH7l1v9ywAUDTK/zn/Vdle3j5H2Tsixp0KiHi2QhihB00KZZiD9gaSqXx9Hvq0wOe4Y
         m1Fyd3fqIcJkRrASSmV/hl+qmQqaUzlvglW34RgpI5D3nt1yvdTbsdupKiECHK65kJOo
         J7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102250; x=1688694250;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+NrEcbwPBOpk0EwDAsT956pzayXcPTozL+X916keWM=;
        b=AiN4qUa7gOuLgNtyXVa59W+C8KJ5BaeeO1xE5hYilI7f6TYvkh+ybMgwSoTlRyctvA
         wEPMbs73Dkner0h7wbIP8Vbweb72eYnbx2EDHNtuqTC3pL+EKjsO2LrdpiwsUeZwAFyj
         IxNWsFTPoA5SDtvcghsIMUsv/7iCTjUPG7ZFnDdpG9RgLI++vE071TSFzYEhNp58PB9O
         sYgCmmElCKCYOLWFsiG69Dn26MiBclrLU2fLaZlT26dRZSGIZg3ib1J/1UQE5kB/Z5Lk
         Ws/5E8cy/RXFlYvINW3hrocuP41cqTM7hYj0OxK8hHAp87+ZhdN0xdjdL1bVUNtPlSQU
         uuLg==
X-Gm-Message-State: AC+VfDxHuiywrqqMt+oblFFX6hRAhmeUFTHWTKk257Ly/mmcUqptJJ10
        l4cKOi6LwffQSEfRw7KpdCOrkKZjKb+m
X-Google-Smtp-Source: ACHHUZ4GXlGCu+Zs/Vmx40Fv0PGFszyMqm+XmZo9fovWasK7rSshs945QNld6H5JztDcHFFIrotKEzVZQYuU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c6:b0:ba8:4ff5:3214 with SMTP
 id ck6-20020a05690218c600b00ba84ff53214mr2565675ybb.2.1686102250723; Tue, 06
 Jun 2023 18:44:10 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:33 -0700
Message-Id: <20230607014353.3172466-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 00/20] Reference count checking for thread
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add reference count checking to thread after first refactoring bits of
the code, such as making the thread red-black tree non-invasive (so
the thread it references is easier to reference count, rather than
having 3 potential references). Part of this refactoring also removes
the dead thread list because if we held a reference here the threads
would never die and anything else has questionable
correctness. addr_location is made into its own C/header file to
capture the init, exit and copy code.

Fix additional outstanding memory leak and reference count issues to
the point that "perf test" compiled with address sanitizer but without
libtraceevent passes all but one test - libtraceevent reports leaks
within its own code, most likely as it isn't compiled with
sanitizers. The remaining failing test is "68: Test dwarf unwind" and
that has address sanitizer issues as it uses memcpy to access the
stack within the process - we likely want to skip parts of the test
with sanitizers enabled.

Ian Rogers (20):
  perf thread: Remove notion of dead threads
  perf thread: Make threads rbtree non-invasive
  perf thread: Add accessor functions for thread
  perf maps: Make delete static, always use put
  perf addr_location: Move to its own header
  perf addr_location: Add init/exit/copy functions
  perf thread: Add reference count checking
  perf machine: Make delete_threads part of machine__exit
  perf report: Avoid thread leak
  perf header: Ensure bitmaps are freed
  perf stat: Avoid evlist leak
  perf intel-pt: Fix missed put and leak
  perf evlist: Free stats in all evlist destruction
  perf python: Avoid 2 leak sanitizer issues
  perf jit: Fix two thread leaks
  perf symbol-elf: Correct holding a reference
  perf maps: Fix overlapping memory leak
  perf machine: Fix leak of kernel dso
  perf machine: Don't leak module maps
  perf map/maps/thread: Changes to reference counting

 tools/perf/arch/arm/tests/dwarf-unwind.c      |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c    |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c  |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
 tools/perf/builtin-annotate.c                 |  28 +-
 tools/perf/builtin-c2c.c                      |  18 +-
 tools/perf/builtin-diff.c                     |  16 +-
 tools/perf/builtin-inject.c                   |   4 +-
 tools/perf/builtin-kmem.c                     |  13 +-
 tools/perf/builtin-kwork.c                    |  15 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-report.c                   |  21 +-
 tools/perf/builtin-sched.c                    |  80 +++--
 tools/perf/builtin-script.c                   |  97 +++---
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/builtin-timechart.c                |  11 +-
 tools/perf/builtin-top.c                      |   8 +-
 tools/perf/builtin-trace.c                    |  38 ++-
 .../scripts/python/Perf-Trace-Util/Context.c  |   4 +-
 tools/perf/tests/code-reading.c               |   6 +-
 tools/perf/tests/dwarf-unwind.c               |   1 -
 tools/perf/tests/hists_common.c               |   2 +-
 tools/perf/tests/hists_cumulate.c             |  18 +-
 tools/perf/tests/hists_filter.c               |  11 +-
 tools/perf/tests/hists_link.c                 |  20 +-
 tools/perf/tests/hists_output.c               |  12 +-
 tools/perf/tests/maps.c                       |   2 +-
 tools/perf/tests/mmap-thread-lookup.c         |   5 +-
 tools/perf/tests/perf-targz-src-pkg           |   5 +-
 tools/perf/tests/symbols.c                    |   1 -
 tools/perf/tests/thread-maps-share.c          |  13 +-
 tools/perf/trace/beauty/pid.c                 |   4 +-
 tools/perf/ui/browsers/hists.c                |  19 +-
 tools/perf/ui/hist.c                          |   5 +-
 tools/perf/ui/stdio/hist.c                    |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/addr_location.c               |  44 +++
 tools/perf/util/addr_location.h               |  31 ++
 tools/perf/util/arm-spe.c                     |   4 +-
 tools/perf/util/build-id.c                    |   2 +
 tools/perf/util/callchain.c                   |   7 +-
 tools/perf/util/cs-etm.c                      |  28 +-
 tools/perf/util/data-convert-json.c           |  16 +-
 tools/perf/util/db-export.c                   |  20 +-
 tools/perf/util/dlfilter.c                    |  17 +-
 tools/perf/util/event.c                       |  37 +--
 tools/perf/util/evlist.c                      |   2 +
 tools/perf/util/evsel_fprintf.c               |   8 +-
 tools/perf/util/header.c                      |  12 +-
 tools/perf/util/hist.c                        |  22 +-
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |  88 +++---
 tools/perf/util/jitdump.c                     |  12 +-
 tools/perf/util/machine.c                     | 277 +++++++++---------
 tools/perf/util/map.c                         |   2 +-
 tools/perf/util/maps.c                        |   5 +-
 tools/perf/util/maps.h                        |   9 +-
 tools/perf/util/python.c                      |   4 +
 .../scripting-engines/trace-event-python.c    |  28 +-
 tools/perf/util/session.c                     |   8 +-
 tools/perf/util/sort.c                        |  12 +-
 tools/perf/util/symbol-elf.c                  |   4 +-
 tools/perf/util/symbol.h                      |  17 +-
 tools/perf/util/thread-stack.c                |  25 +-
 tools/perf/util/thread.c                      | 218 +++++++-------
 tools/perf/util/thread.h                      | 210 +++++++++++--
 tools/perf/util/unwind-libdw.c                |  27 +-
 tools/perf/util/unwind-libunwind-local.c      |  19 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |   2 +-
 70 files changed, 1059 insertions(+), 655 deletions(-)
 create mode 100644 tools/perf/util/addr_location.c
 create mode 100644 tools/perf/util/addr_location.h

-- 
2.41.0.rc0.172.g3f132b7071-goog

