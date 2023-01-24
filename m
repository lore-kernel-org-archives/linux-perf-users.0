Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764DDC25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 15:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjAXPAI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjAXPAE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 10:00:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94CB6AD0C;
        Tue, 24 Jan 2023 06:59:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 212254B3;
        Tue, 24 Jan 2023 07:00:41 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CA603F5A1;
        Tue, 24 Jan 2023 06:59:57 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.or
Cc:     linux-kernel@vger.kernel.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf mem/c2c: Document that SPE is used for mem and c2c on Arm
Date:   Tue, 24 Jan 2023 14:59:29 +0000
Message-Id: <20230124145929.557891-1-james.clark@arm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Setup is non-trivial so also link to the full SPE docs.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-c2c.txt | 8 ++++++--
 tools/perf/Documentation/perf-mem.txt | 7 ++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index af5c3106f468..4e8c263e1721 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -22,7 +22,11 @@ you to track down the cacheline contentions.
 On Intel, the tool is based on load latency and precise store facility events
 provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
 with thresholding feature. On AMD, the tool uses IBS op pmu (due to hardware
-limitations, perf c2c is not supported on Zen3 cpus).
+limitations, perf c2c is not supported on Zen3 cpus). On Arm64 it uses SPE to
+sample load and store operations, therefore hardware and kernel support is
+required. See linkperf:perf-arm-spe[1] for a setup guide. Due to the
+statistical nature of Arm SPE sampling, not every memory operation will be
+sampled.
 
 These events provide:
   - memory address of the access
@@ -333,4 +337,4 @@ Check Joe's blog on c2c tool for detailed use case explanation:
 
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-mem[1]
+linkperf:perf-record[1], linkperf:perf-mem[1], linkperf:perf-arm-spe[1]
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 005c95580b1e..19862572e3f2 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -23,6 +23,11 @@ Note that on Intel systems the memory latency reported is the use-latency,
 not the pure load (or store latency). Use latency includes any pipeline
 queueing delays in addition to the memory subsystem latency.
 
+On Arm64 this uses SPE to sample load and store operations, therefore hardware
+and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
+Due to the statistical nature of SPE sampling, not every memory operation will
+be sampled.
+
 OPTIONS
 -------
 <command>...::
@@ -93,4 +98,4 @@ all perf record options.
 
 SEE ALSO
 --------
-linkperf:perf-record[1], linkperf:perf-report[1]
+linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-arm-spe[1]

base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
-- 
2.39.1

