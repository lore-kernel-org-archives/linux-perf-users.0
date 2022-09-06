Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8308EECAAD5
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 10:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiIFKqL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbiIFKpt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 06:45:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6B591EC5E;
        Tue,  6 Sep 2022 03:44:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 712C21A00;
        Tue,  6 Sep 2022 03:44:01 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.15.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16B83F534;
        Tue,  6 Sep 2022 03:43:53 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v8 04/13] perf test: Add asm pureloop test shell script
Date:   Tue,  6 Sep 2022 11:30:35 +0100
Message-Id: <20220906103044.761250-5-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906103044.761250-1-carsten.haitzler@foss.arm.com>
References: <20220906103044.761250-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

Add a script to drive the asm pureloop test for arm64/CoreSight that
gathers data so it passes a minimum bar for amount and quality of
content that we extract from the kernel's perf support.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../tests/shell/coresight/asm_pure_loop.sh     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/asm_pure_loop.sh

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop.sh b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
new file mode 100755
index 000000000000..569e9d46162b
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# CoreSight / ASM Pure Loop
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="asm_pure_loop"
+. $(dirname $0)/../lib/coresight.sh
+ARGS=""
+DATV="out"
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

