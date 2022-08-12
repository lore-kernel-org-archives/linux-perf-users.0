Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F82C00140
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 11:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiHLLnA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 07:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbiHLLm4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 07:42:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 171C6AF0CE;
        Fri, 12 Aug 2022 04:42:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98607113E;
        Fri, 12 Aug 2022 04:42:54 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D1183F70D;
        Fri, 12 Aug 2022 04:42:52 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v6 13/14] perf test: Add git ignore for tmp and output files of CoreSight tests
Date:   Fri, 12 Aug 2022 12:42:17 +0100
Message-Id: <20220812114218.323052-14-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812114218.323052-1-carsten.haitzler@foss.arm.com>
References: <20220812114218.323052-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>

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

