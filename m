Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095E4C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26E360F24
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 Nov 2021 18:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhKBSKe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:10:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230392AbhKBSKd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Nov 2021 14:10:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6689611B3;
        Tue,  2 Nov 2021 11:07:58 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85A7E3F7B4;
        Tue,  2 Nov 2021 11:07:56 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] perf arm-spe: Track pid/tid for Arm SPE samples
Date:   Tue,  2 Nov 2021 18:07:36 +0000
Message-Id: <20211102180739.18049-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The following patchset is an iteration on RFC [1] where pid/tid info is
assigned to the Arm SPE synthesized samples. Two methods of tracking
pids are considered: hardware-based (using Arm SPE CONTEXT packets), and
context-switch events (from perf) as fallback.

- Patch #1 enables pid tracking using RECORD_SWITCH* events from perf.
- Patch #2 saves the value of SPE CONTEXT packet to the arm_spe_record
  struct (patch from [2]).
- Patch #3 enables hardware-based pid tracking using SPE CONTEXT packets.

[1] https://lore.kernel.org/lkml/20210916001748.1525291-1-namhyung@kernel.org/
[2] https://www.spinics.net/lists/linux-perf-users/msg12543.html

German Gomez (3):
  perf arm-spe: Track task context switch for cpu-mode events
  perf arm-spe: Save context ID in record
  perf arm-spe: Support hardware-based PID tracing

 tools/perf/arch/arm64/util/arm-spe.c          |   6 +-
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   2 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |   1 +
 tools/perf/util/arm-spe.c                     | 144 ++++++++++++++----
 4 files changed, 123 insertions(+), 30 deletions(-)

-- 
2.25.1

