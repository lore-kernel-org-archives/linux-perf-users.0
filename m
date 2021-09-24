Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2692C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1699610CF
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 08:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbhIXIVc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbhIXIV0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 04:21:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAFC061757;
        Fri, 24 Sep 2021 01:19:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso7049510pjb.0;
        Fri, 24 Sep 2021 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=en0BNZepb388y42VwZK97cG6vwTM2RLIEDJf2i2NL/E=;
        b=ji/y2Fb+TtBS47HMED9yR5byTMhTtdwRGpjAyipNAqBeIZm7SVF2WfeHQQC1DmXC05
         P81bEEtxFIA2zOY8bv7jU2IYccV3s1AIu9Vi2cOHsLbrRM6SXOni8j5OiqFBwsegSF/W
         3iAGvD0GAcDlq6UJEeFMZlavqibym96llwmc4i1l8wAkvEGYav48815+mA8LESygPyni
         tJbPqJXWjPJyi68dgfoRabRM6x/66B4h6fc3Hk79iNoCO9uZdyTgZBBauZ6czCWA8NPA
         yT8yFbNQZU+z3MvyjPsgLjD8eYSUr46/OjDNX6/tDa9QM7geHvRqD4K1D4XrvTUebVZN
         LyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=en0BNZepb388y42VwZK97cG6vwTM2RLIEDJf2i2NL/E=;
        b=a8+qvCJF5o/J9SWD34B1qs+5mwK3hHLBYHPDGnap0XirFwj8AJ5qY22Vyjw97x69Lm
         LipEubPWqKv8DIyYBrMFA462B3xlMYqak+N5H4RNvDVtISfhv0rtlrqJuuR8nFXD0AY8
         wq+/ubVl6S/2+ng1kFwm83Nk+1RWA8YZyQiUWEpTUzydkcwzUPQLlT/D84lUtsMfzYY/
         oOZ10AyIOO9s/gQgJNlhagEy3R8MpUkH7GbYAqizTy6DJeIpHRHipiJY7NPLUCWuJiT1
         TmR1BtbSCuzn+cLLIDstpJz4+7A7s9ik0/3wdH+2oR+5jdw1WHV07F8nkQdNSJTTzTBD
         1WMA==
X-Gm-Message-State: AOAM532Ul1eV5VjQdDCEzLoHM4NqO56eP1uqWpwo+SvufSGtfMpstp0f
        g0q1EUrTmIgRSaWb/k8oanQ=
X-Google-Smtp-Source: ABdhPJyV+7uiPqiOPRmmxl9oaQZ5fYkO7cqh1WaIOm/f/TDRyI4Jy/6UjjuBVBnpkcqm5WoO4xLq2w==
X-Received: by 2002:a17:903:230b:b0:13b:a0ec:1136 with SMTP id d11-20020a170903230b00b0013ba0ec1136mr7902396plh.63.1632471592893;
        Fri, 24 Sep 2021 01:19:52 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id n19sm8083216pfa.60.2021.09.24.01.19.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:19:52 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf doc: Fix typos all over the place
Date:   Fri, 24 Sep 2021 16:19:42 +0800
Message-Id: <20210924081942.38368-1-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

Considering that perf and its subcommands have so many parameters,
the documentation is always the first stop for perf beginners. Fixing
some spelling errors will relax the eyes of some readers a little bit.

 s/specicfication/specification/
 s/caheline/cacheline/
 s/tranasaction/transaction/
 s/complan/complain/
 s/sched_wakep/sched_wakeup/
 s/possble/possible/
 s/methology/methodology/

Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/Documentation/jitdump-specification.txt | 2 +-
 tools/perf/Documentation/perf-c2c.txt              | 2 +-
 tools/perf/Documentation/perf-intel-pt.txt         | 2 +-
 tools/perf/Documentation/perf-lock.txt             | 2 +-
 tools/perf/Documentation/perf-script-perl.txt      | 2 +-
 tools/perf/Documentation/perf-script-python.txt    | 2 +-
 tools/perf/Documentation/perf-stat.txt             | 2 +-
 tools/perf/Documentation/topdown.txt               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 52152d156ad9..79936355d819 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -164,7 +164,7 @@ const char unwinding_data[n]: an array of unwinding data, consisting of the EH F
 The EH Frame header follows the Linux Standard Base (LSB) specification as described in the document at https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html
 
 
-The EH Frame follows the LSB specicfication as described in the document at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
+The EH Frame follows the LSB specification as described in the document at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
 
 
 NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, then only the EH Frame Header will be read, which can be used to specify FP based unwinding for a function which does not have unwinding information.
diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index de6beedb7283..3b6a2c84ea02 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -261,7 +261,7 @@ COALESCE
 User can specify how to sort offsets for cacheline.
 
 Following fields are available and governs the final
-output fields set for caheline offsets output:
+output fields set for cacheline offsets output:
 
   tid   - coalesced by process TIDs
   pid   - coalesced by process PIDs
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 184ba62420f0..db465fa7ee91 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -883,7 +883,7 @@ and "r" can be combined to get calls and returns.
 
 "Transactions" events correspond to the start or end of transactions. The
 'flags' field can be used in perf script to determine whether the event is a
-tranasaction start, commit or abort.
+transaction start, commit or abort.
 
 Note that "instructions", "branches" and "transactions" events depend on code
 flow packets which can be disabled by using the config term "branch=0".  Refer
diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 74d774592196..1b4d452923d7 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -44,7 +44,7 @@ COMMON OPTIONS
 
 -f::
 --force::
-	Don't complan, do it.
+	Don't complain, do it.
 
 REPORT OPTIONS
 --------------
diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Documentation/perf-script-perl.txt
index 5a1f68122f50..fa4f39d305a7 100644
--- a/tools/perf/Documentation/perf-script-perl.txt
+++ b/tools/perf/Documentation/perf-script-perl.txt
@@ -54,7 +54,7 @@ all sched_wakeup events in the system:
 Traces meant to be processed using a script should be recorded with
 the above option: -a to enable system-wide collection.
 
-The format file for the sched_wakep event defines the following fields
+The format file for the sched_wakeup event defines the following fields
 (see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
 
 ----
diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 0250dc61cf98..cf4b7f4b625a 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -448,7 +448,7 @@ all sched_wakeup events in the system:
 Traces meant to be processed using a script should be recorded with
 the above option: -a to enable system-wide collection.
 
-The format file for the sched_wakep event defines the following fields
+The format file for the sched_wakeup event defines the following fields
 (see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
 
 ----
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4c9310be6acc..7e6fb7cbc0f4 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -385,7 +385,7 @@ Aggregate counts per physical processor for system-wide mode measurements.
 Print metrics or metricgroups specified in a comma separated list.
 For a group all metrics from the group are added.
 The events from the metrics are automatically measured.
-See perf list output for the possble metrics and metricgroups.
+See perf list output for the possible metrics and metricgroups.
 
 -A::
 --no-aggr::
diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index c6302df4cf29..a15b93fdcf50 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -2,7 +2,7 @@ Using TopDown metrics in user space
 -----------------------------------
 
 Intel CPUs (since Sandy Bridge and Silvermont) support a TopDown
-methology to break down CPU pipeline execution into 4 bottlenecks:
+methodology to break down CPU pipeline execution into 4 bottlenecks:
 frontend bound, backend bound, bad speculation, retiring.
 
 For more details on Topdown see [1][5]
-- 
2.32.0

