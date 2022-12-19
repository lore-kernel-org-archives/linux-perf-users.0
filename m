Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD40EC10F1B
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 16:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiLSQN4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSQNz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 11:13:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37A22DEA1;
        Mon, 19 Dec 2022 08:13:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFCFBFEC;
        Mon, 19 Dec 2022 08:14:34 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D78E3F703;
        Mon, 19 Dec 2022 08:13:51 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     robh@kernel.org, German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] perf event: Add simd_flags field to perf_sample
Date:   Mon, 19 Dec 2022 16:12:55 +0000
Message-Id: <20221219161259.3097213-2-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219161259.3097213-1-james.clark@arm.com>
References: <20221219161259.3097213-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: German Gomez <german.gomez@arm.com>

Add new field to the struct perf_sample to store flags related to SIMD
ops.

It will be used to store SIMD information from SVE and NEON when
profiling using ARM SPE.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/sample.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 60ec79d4eea4..bdf52faf165f 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -66,6 +66,18 @@ struct aux_sample {
 	void *data;
 };
 
+struct simd_flags {
+	u64	arch:1,	/* architecture (isa) */
+		pred:2;	/* predication */
+};
+
+/* simd architecture flags */
+#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* ARM SVE */
+
+/* simd predicate flags */
+#define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
+#define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
+
 struct perf_sample {
 	u64 ip;
 	u32 pid, tid;
@@ -103,6 +115,7 @@ struct perf_sample {
 	struct stack_dump user_stack;
 	struct sample_read read;
 	struct aux_sample aux_sample;
+	struct simd_flags simd_flags;
 };
 
 /*
-- 
2.25.1

