Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E4EB64DA
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 14:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjGJOTe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjGJOTb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 10:19:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3CAC90
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 07:19:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78E42B;
        Mon, 10 Jul 2023 07:20:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B0A23F67D;
        Mon, 10 Jul 2023 07:19:28 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, john.g.garry@oracle.com
Cc:     namhyung@kernel.org, acme@kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH v2 0/5] perf vendor events arm64: Update N2 and V2 metrics and events using Arm telemetry repo
Date:   Mon, 10 Jul 2023 15:18:58 +0100
Message-Id: <20230710141903.1595312-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v1:
  * Split last change into two so it doesn't hit the mailing list size
    limit

James Clark (5):
  perf: cs-etm: Don't duplicate FIELD_GET()
  perf jevents: Match on highest version of Arm json file available
  perf vendor events arm64: Update scale units and descriptions of
    common topdown metrics
  perf vendor events arm64: Update N2-r0p3 and V2 metrics and events
    using Arm telemetry repo
  perf vendor events arm64: Update N2-r0p0 metrics and events using Arm
    telemetry repo

 tools/perf/arch/arm64/util/header.c           |  61 +++-
 .../arch/arm64/arm/neoverse-n2-v2/branch.json |   8 -
 .../arch/arm64/arm/neoverse-n2-v2/bus.json    |  20 --
 .../arch/arm64/arm/neoverse-n2-v2/cache.json  | 155 --------
 .../arm64/arm/neoverse-n2-v2/exception.json   |  47 ---
 .../arm64/arm/neoverse-n2-v2/instruction.json | 143 --------
 .../arch/arm64/arm/neoverse-n2-v2/memory.json |  41 ---
 .../arm64/arm/neoverse-n2-v2/metrics.json     | 273 --------------
 .../arm64/arm/neoverse-n2-v2/pipeline.json    |  23 --
 .../arch/arm64/arm/neoverse-n2-v2/spe.json    |  14 -
 .../arch/arm64/arm/neoverse-n2-v2/trace.json  |  29 --
 .../arch/arm64/arm/neoverse-n2r0p0/bus.json   |  18 +
 .../arm64/arm/neoverse-n2r0p0/exception.json  |  62 ++++
 .../arm/neoverse-n2r0p0/fp_operation.json     |  22 ++
 .../arm64/arm/neoverse-n2r0p0/general.json    |  10 +
 .../arm64/arm/neoverse-n2r0p0/l1d_cache.json  |  54 +++
 .../arm64/arm/neoverse-n2r0p0/l1i_cache.json  |  14 +
 .../arm64/arm/neoverse-n2r0p0/l2_cache.json   |  50 +++
 .../arm64/arm/neoverse-n2r0p0/l3_cache.json   |  22 ++
 .../arm64/arm/neoverse-n2r0p0/ll_cache.json   |  10 +
 .../arm64/arm/neoverse-n2r0p0/memory.json     |  46 +++
 .../arm64/arm/neoverse-n2r0p0/metrics.json    | 332 ++++++++++++++++++
 .../arm64/arm/neoverse-n2r0p0/retired.json    |  30 ++
 .../arch/arm64/arm/neoverse-n2r0p0/spe.json   |  18 +
 .../arm/neoverse-n2r0p0/spec_operation.json   | 110 ++++++
 .../arch/arm64/arm/neoverse-n2r0p0/stall.json |  30 ++
 .../arch/arm64/arm/neoverse-n2r0p0/sve.json   |  50 +++
 .../arch/arm64/arm/neoverse-n2r0p0/tlb.json   |  66 ++++
 .../arch/arm64/arm/neoverse-n2r0p0/trace.json |  38 ++
 .../arm64/arm/neoverse-n2r0p3-v2/bus.json     |  18 +
 .../arm/neoverse-n2r0p3-v2/exception.json     |  62 ++++
 .../arm/neoverse-n2r0p3-v2/fp_operation.json  |  22 ++
 .../arm64/arm/neoverse-n2r0p3-v2/general.json |  10 +
 .../arm/neoverse-n2r0p3-v2/l1d_cache.json     |  54 +++
 .../arm/neoverse-n2r0p3-v2/l1i_cache.json     |  14 +
 .../arm/neoverse-n2r0p3-v2/l2_cache.json      |  50 +++
 .../arm/neoverse-n2r0p3-v2/l3_cache.json      |  22 ++
 .../arm/neoverse-n2r0p3-v2/ll_cache.json      |  10 +
 .../arm64/arm/neoverse-n2r0p3-v2/memory.json  |  46 +++
 .../arm64/arm/neoverse-n2r0p3-v2/metrics.json | 331 +++++++++++++++++
 .../arm64/arm/neoverse-n2r0p3-v2/retired.json |  30 ++
 .../arm64/arm/neoverse-n2r0p3-v2/spe.json     |  18 +
 .../neoverse-n2r0p3-v2/spec_operation.json    | 110 ++++++
 .../arm64/arm/neoverse-n2r0p3-v2/stall.json   |  30 ++
 .../arm64/arm/neoverse-n2r0p3-v2/sve.json     |  50 +++
 .../arm64/arm/neoverse-n2r0p3-v2/tlb.json     |  66 ++++
 .../arm64/arm/neoverse-n2r0p3-v2/trace.json   |  38 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   5 +-
 tools/perf/pmu-events/arch/arm64/sbsa.json    |  24 +-
 tools/perf/pmu-events/jevents.py              |  49 +--
 tools/perf/tests/pmu-events.c                 |  34 ++
 tools/perf/util/cs-etm.c                      |  14 +-
 52 files changed, 2088 insertions(+), 815 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/instruction.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/pipeline.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p0/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json

-- 
2.34.1

