Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB5C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655936139F
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhJDQCf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:02:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236195AbhJDQCe (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Oct 2021 12:02:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6FB6113E;
        Mon,  4 Oct 2021 09:00:44 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 148113F70D;
        Mon,  4 Oct 2021 09:00:42 -0700 (PDT)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] perf vendor events: Add the Neoverse V1 to arm64 mapfile
Date:   Mon,  4 Oct 2021 17:00:07 +0100
Message-Id: <20211004160008.21645-4-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004160008.21645-1-andrew.kilroy@arm.com>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is so that performance counters for the Neoverse V1 appear
categorised upon running 'perf list' on the CPU.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index c43591d831b8..31d8b57ca9bb 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -18,6 +18,7 @@
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
+0x00000000410fd400,v1,arm/neoverse-v1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
-- 
2.17.1

