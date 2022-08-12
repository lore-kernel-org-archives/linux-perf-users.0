Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E50C25B0E
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 11:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiHLLm4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 07:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiHLLmu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 07:42:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE8B1AF0C9;
        Fri, 12 Aug 2022 04:42:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67BDB106F;
        Fri, 12 Aug 2022 04:42:47 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BFD83F70D;
        Fri, 12 Aug 2022 04:42:45 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v6 08/14] perf test: Add memcpy thread test shell script
Date:   Fri, 12 Aug 2022 12:42:12 +0100
Message-Id: <20220812114218.323052-9-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812114218.323052-1-carsten.haitzler@foss.arm.com>
References: <20220812114218.323052-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>

Add a script to drive the threaded memcpy test that gathers data so
it passes a minimum bar for amount and quality of content that we
extract from the kernel's perf support.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../shell/coresight/memcpy_thread_16k_10.sh    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh

diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
new file mode 100755
index 000000000000..d21ba8545938
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# CoreSight / Memcpy 16k 10 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/../lib/coresight.sh
+ARGS="16 10 1"
+DATV="16k_10"
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

