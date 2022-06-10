Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D6C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Jun 2022 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiFJRqD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350182AbiFJRqC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Jun 2022 13:46:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94C84562E2;
        Fri, 10 Jun 2022 10:46:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6626113E;
        Fri, 10 Jun 2022 10:46:00 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8428B3F766;
        Fri, 10 Jun 2022 10:45:58 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf vendor events arm64: Arm Cortex-A78C and X1C
Date:   Fri, 10 Jun 2022 18:44:59 +0100
Message-Id: <20220610174459.615995-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add PMU events for the Arm Cortex-A78C and Arm Cortex-X1C CPUs.

Events for Arm Cortex-A78C match those for Arm Cortex-A78.
Events for Arm Cortex-X1C match those for Arm Cortex- X1.

As such, this is just a mapfile change.

Main ID Register (MIDR) and event data is sourced from the corresponding
Arm Technical Reference Manuals:

Arm Cortex-A78C
https://developer.arm.com/documentation/102226/

Arm Cortex-X1C
https://developer.arm.com/documentation/101968/

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index ed29e4433c67..406f6edd4e12 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -27,7 +27,9 @@
 0x00000000410fd0d0,v1,arm/cortex-a77,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
 0x00000000410fd410,v1,arm/cortex-a78,core
+0x00000000410fd4b0,v1,arm/cortex-a78,core
 0x00000000410fd440,v1,arm/cortex-x1,core
+0x00000000410fd4c0,v1,arm/cortex-x1,core
 0x00000000410fd460,v1,arm/cortex-a510,core
 0x00000000410fd470,v1,arm/cortex-a710,core
 0x00000000410fd480,v1,arm/cortex-x2,core
-- 
2.25.1

