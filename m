Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E38C6FA94
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbiIFKrX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiIFKqi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 06:46:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FA4377EB3;
        Tue,  6 Sep 2022 03:45:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 101261BB0;
        Tue,  6 Sep 2022 03:44:13 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.15.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90BA33F534;
        Tue,  6 Sep 2022 03:44:05 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v8 12/13] perf test: Add git ignore for tmp and output files of CoreSight tests
Date:   Tue,  6 Sep 2022 11:30:43 +0100
Message-Id: <20220906103044.761250-13-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906103044.761250-1-carsten.haitzler@foss.arm.com>
References: <20220906103044.761250-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

Ignore other output files of the new CoreSight tests so they don't
fill git status with noise we don't need or want.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index faa23b5d32f5..a653311d9693 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -22,6 +22,7 @@ perf-archive
 perf-iostat
 tags
 TAGS
+stats-*.csv
 cscope*
 config.mak
 config.mak.autogen
@@ -29,6 +30,7 @@ config.mak.autogen
 *-flex.*
 *.pyc
 *.pyo
+*.stdout
 .config-detected
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
-- 
2.32.0

