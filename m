Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA6060F51
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 15:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhIPPsX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:48:23 -0400
Received: from foss.arm.com ([217.140.110.172]:39354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhIPPsX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 11:48:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B10C1063;
        Thu, 16 Sep 2021 08:47:02 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 351EB3F5A1;
        Thu, 16 Sep 2021 08:47:00 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH 2/5] perf arm-spe: Print size using consistent format
Date:   Thu, 16 Sep 2021 16:46:32 +0100
Message-Id: <20210916154635.1525-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210916154635.1525-1-german.gomez@arm.com>
References: <20210916154635.1525-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Andrew Kilroy <andrew.kilroy@arm.com>

Since the size is already printed earlier in hex, print the same data
using the same format, in hex.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58b7069c5a5f..2196291976d9 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -100,7 +100,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 	const char *color = PERF_COLOR_BLUE;
 
 	color_fprintf(stdout, color,
-		      ". ... ARM SPE data: size %zu bytes\n",
+		      ". ... ARM SPE data: size %#zx bytes\n",
 		      len);
 
 	while (len) {
-- 
2.17.1

