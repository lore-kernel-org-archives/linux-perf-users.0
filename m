Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B9C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5529F611F0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbhKILxU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:53:20 -0500
Received: from foss.arm.com ([217.140.110.172]:60784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343587AbhKILxT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 06:53:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8E1ED1;
        Tue,  9 Nov 2021 03:50:33 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 846F63F7F5;
        Tue,  9 Nov 2021 03:50:31 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] perf arm-spe: Track pid/tid for Arm SPE samples
Date:   Tue,  9 Nov 2021 11:50:16 +0000
Message-Id: <20211109115020.31623-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The following patchset is an iteration on RFC [1] where pid/tid info is
assigned to the Arm SPE synthesized samples. Two methods of tracking
pids are considered: hardware-based (using Arm SPE CONTEXT packets), and
context-switch events (from perf) as fallback.

  - Patch #1 enables pid tracking using RECORD_SWITCH* events from perf.
  - Patch #2 updates perf-record documentation and arm-spe recording so
    that they are consistent.
  - Patch #3 saves the value of SPE CONTEXT packet to the arm_spe_record
    struct.
  - Patch #4 enables hardware-based pid tracking using SPE CONTEXT
    packets.

Changes since v1:

  - [PATCH 1/4] Fix authorship of commit.
  - [PATCH 2/4] (New patch) Updated perf-record docs to reflect the
    behavior of Arm SPE introduced by the previous patch.
  - [PATCH 3/4] update initialization of context_id field to (u64)-1.
  - [PATCH 4/4] Update handling of pid/tid tracking fallback following
    Leo Yan's suggestion. Don't consider per-thread mode on this patch.

German Gomez (3):
  perf arm-spe: Update --switch-events docs in perf-record
  perf arm-spe: Save context ID in record
  perf arm-spe: Support hardware-based PID tracing

Namhyung Kim (1):
  perf arm-spe: Track task context switch for cpu-mode events

 tools/perf/Documentation/perf-record.txt      |   2 +-
 tools/perf/arch/arm64/util/arm-spe.c          |   8 +-
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   2 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |   1 +
 tools/perf/util/arm-spe.c                     | 120 ++++++++++++++----
 5 files changed, 104 insertions(+), 29 deletions(-)

-- 
2.25.1

