Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A8C77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjEYHMN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbjEYHMD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D721BF
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:11:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso4277047b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998719; x=1687590719;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t01BI3QFegtwIlfIReuEV6hoCGeSyvhEbxHTS2cMx+k=;
        b=TspvUXxxtsRBD9zskVbOGYoGHkofUr/N/jcR9anGyJxjboN8MeeX1Hn1VoAIYiC91g
         GOX7zo2mQ4pzAwwPCY6QJimkH56RmrFdx7fW85nvJPPgZlqcrk0e3tavEcf1iq1vRoij
         hbQEp7VaotScKUHASUVV56SOKsnpQa9qvUzeJA43Rghfu3Jvju8W2QkoveOfn+AfKx9h
         d+wC9jWVJcC9bgovuT4f2gkwWnbyvbaCaqkV0cQ5fogCwTMRSMK8/NSyBraSdByq0ume
         fQUphtzJLUjvbfjm1UCrFyZrUSwzjU/YFYD+sZrw6bi2GkDWDRWBYYwThKl9c69xN5XT
         6Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998719; x=1687590719;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t01BI3QFegtwIlfIReuEV6hoCGeSyvhEbxHTS2cMx+k=;
        b=LXObxryKZaCpiq62dQvwOVNZxuFWU9ooIoCbQcjuCjETOLvbRDFHFZEcwSZlf3bl9C
         zTls2Ni/0D7I4ZHAz1UEApeqqRmVZ1GgXf1G//V95YxcSDmy/KTBIHufgeK6bSVSaza4
         PxSW5qG6UuJZQ8YrzNaYhvCawCi61+O65MuyYCJGvaUvGdXc3y6XRzNTQcOWml8qwiUQ
         MOhPzccMZuIg0QSd/H7XQiBF2N/Uc/3Jfc1MefyH83HJxk/LtKCHXaqOsUw/QznxSxX9
         fCruCEs4TIQ6kFj9laYJ/7xJz23ES1tdlNNMJzOQg+hvjQxN0sl8/ApXGmRvS1r4A3mX
         c9yQ==
X-Gm-Message-State: AC+VfDwbn3H2g+O7R7VJaUFnbVEDDVuX5XzfvU0NbokkQI7sOBp5EVdH
        6Upc18FgbBvgUA3bg60IFUJwiG8sby02
X-Google-Smtp-Source: ACHHUZ7k4CcS4afmm6W2+oCXTMPZQc2W1UETBWL6jFCAGbcTJ/766Ax+V3ebreUZ6SjhoIvB/uVG7XI/9DrJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:b619:0:b0:561:356b:e445 with SMTP id
 u25-20020a81b619000000b00561356be445mr13117914ywh.9.1684998718820; Thu, 25
 May 2023 00:11:58 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:17 -0700
Message-Id: <20230525071133.2066610-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 00/16] Address some perf memory/data size issues
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Try to reduce the data size of the perf command. Before these patches
a stripped non-debug binary was:

$ size -A perf
perf  :
section                  size       addr
.interp                    28        848
.note.gnu.property         32        880
.note.gnu.build-id         36        912
.note.ABI-tag              32        948
.gnu.hash               24628        984
.dynsym                 88920      25616
.dynstr                 70193     114536
.gnu.version             7410     184730
.gnu.version_r            800     192144
.rela.dyn              460824     192944
.rela.plt               14784     653768
.init                      23     671744
.plt                     9872     671776
.plt.got                   24     681648
.text                 2279182     681680
.noinstr.text             476    2960864
.fini                       9    2961340
.rodata               7042922    2961408
.eh_frame_hdr           42844   10004332
.eh_frame              226496   10047176
.tbss                      48   10279720
.init_array                16   10279720
.fini_array                 8   10279736
.data.rel.ro            53376   10279744
.dynamic                  736   10333120
.got                      328   10333856
.got.plt                 4952   10334184
.data                  391088   10339136
.bss                   285776   10730240
.comment                   31          0
Total                11005894

And after:
perf  :
section                  size       addr
.interp                    28        848
.note.gnu.property         32        880
.note.gnu.build-id         36        912
.note.ABI-tag              32        948
.gnu.hash               24628        984
.dynsym                 88944      25616
.dynstr                 70217     114560
.gnu.version             7412     184778
.gnu.version_r            816     192192
.rela.dyn              460824     193008
.rela.plt               14808     653832
.init                      23     671744
.plt                     9888     671776
.plt.got                   24     681664
.text                 2280446     681696
.noinstr.text             476    2962144
.fini                       9    2962620
.rodata               7048746    2965504
.eh_frame_hdr           42852   10014252
.eh_frame              226568   10057104
.tbss                      48   10285640
.init_array                16   10285640
.fini_array                 8   10285656
.data.rel.ro           301408   10285664
.dynamic                  736   10587072
.got                      328   10587808
.got.plt                 4960   10588136
.data                  100464   10593152
.bss                    22512   10693632
.comment                   31          0
Total                10707320

The binary has reduced in size by 298,574 bytes. The .bss, that
doesn't count toward file size, is reduced by 263,254 bytes. At
runtime this could reduce the footprint up to 561,828 bytes. This is
still just a fraction of the .rodata section's size of 7,048,746
bytes, that mainly contains the converted json events. The .rodata
section needn't all be mapped at the same time.

The changes are largely removing static variables and replacing them
with local or dynamically allocated memory. A common issue was having
paths in statics for the sake of returning a non-stack pointer to a
buffer, so the APIs were changed to pass buffers in.

Ian Rogers (16):
  perf header: Make nodes dynamic in write_mem_topology
  perf test x86: insn-x86 test data is immutable so mark it const
  perf test x86: intel-pt-test data is immutable so mark it const
  perf trace: Make some large static arrays const
  perf trace beauty: Make MSR arrays const
  tools api fs: Avoid large static PATH_MAX arrays
  tools lib api fs tracing_path: Remove two unused MAX_PATH paths
  perf daemon: Dynamically allocate path to perf
  perf lock: Dynamically allocate lockhash_table
  perf timechart: Make large arrays dynamic
  perf probe: Dynamically allocate params memory
  perf path: Make mkpath thread safe
  perf scripting-engines: Move static to local variable
  tools api fs: Dynamically allocate cgroupfs mount point cache
  perf test pmu: Avoid 2 static path arrays
  libsubcmd: Avoid two path statics

 tools/lib/api/fs/cgroup.c                     |  17 ++-
 tools/lib/api/fs/fs.c                         |  25 +++-
 tools/lib/api/fs/tracing_path.c               |  17 +--
 tools/lib/subcmd/exec-cmd.c                   |  35 +++--
 tools/perf/arch/x86/tests/insn-x86.c          |  10 +-
 tools/perf/arch/x86/tests/intel-pt-test.c     |  14 +-
 tools/perf/builtin-config.c                   |   4 +-
 tools/perf/builtin-daemon.c                   |  15 +-
 tools/perf/builtin-help.c                     |   4 +-
 tools/perf/builtin-lock.c                     |  20 ++-
 tools/perf/builtin-probe.c                    | 133 ++++++++++--------
 tools/perf/builtin-timechart.c                |  48 +++++--
 tools/perf/builtin-trace.c                    |  33 +++--
 tools/perf/tests/pmu.c                        |  17 +--
 tools/perf/trace/beauty/beauty.h              |   2 +-
 .../perf/trace/beauty/tracepoints/x86_msr.sh  |   6 +-
 tools/perf/util/cache.h                       |   2 +-
 tools/perf/util/config.c                      |   3 +-
 tools/perf/util/header.c                      |  33 +++--
 tools/perf/util/path.c                        |  35 +----
 .../util/scripting-engines/trace-event-perl.c |   4 +-
 .../scripting-engines/trace-event-python.c    |   5 +-
 22 files changed, 278 insertions(+), 204 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

