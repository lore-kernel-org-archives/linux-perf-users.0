Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204F5EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 14:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGJOTf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjGJOTc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 10:19:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C820E3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 07:19:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 233B4D75;
        Mon, 10 Jul 2023 07:20:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDB963F67D;
        Mon, 10 Jul 2023 07:19:29 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, john.g.garry@oracle.com
Cc:     namhyung@kernel.org, acme@kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH v2 1/5] perf: cs-etm: Don't duplicate FIELD_GET()
Date:   Mon, 10 Jul 2023 15:18:59 +0100
Message-Id: <20230710141903.1595312-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710141903.1595312-1-james.clark@arm.com>
References: <20230710141903.1595312-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

linux/bitfield.h can be included as long as linux/kernel.h is included
first, so change the order of the includes and drop the duplicate macro.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1419b40dfbe8..9729d006550d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -6,10 +6,11 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/coresight-pmu.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
@@ -281,17 +282,6 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 	return 0;
 }
 
-/*
- * FIELD_GET (linux/bitfield.h) not available outside kernel code,
- * and the header contains too many dependencies to just copy over,
- * so roll our own based on the original
- */
-#define __bf_shf(x) (__builtin_ffsll(x) - 1)
-#define FIELD_GET(_mask, _reg)						\
-	({								\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
-	})
-
 /*
  * Get a metadata for a specific cpu from an array.
  *
-- 
2.34.1

