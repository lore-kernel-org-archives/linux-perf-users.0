Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C5C00140
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 12:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiHLMR2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiHLMRN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 08:17:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D22B08A3;
        Fri, 12 Aug 2022 05:17:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F53D16F2;
        Fri, 12 Aug 2022 05:17:11 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB6E3F70D;
        Fri, 12 Aug 2022 05:17:09 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v7 12/14] perf test: Add unroll thread test shell script
Date:   Fri, 12 Aug 2022 13:16:39 +0100
Message-Id: <20220812121641.336465-13-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This adds scripts to drive the unroll thread tests to compare perf
output against a minimum bar of content/quality.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../shell/coresight/unroll_loop_thread_10.sh   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh

diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
new file mode 100755
index 000000000000..f48c85230b15
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# CoreSight / Unroll Loop Thread 10
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/../lib/coresight.sh
+ARGS="10"
+DATV="10"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 10 10 10
+
+err=$?
+exit $err
-- 
2.32.0

