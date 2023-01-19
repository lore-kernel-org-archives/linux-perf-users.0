Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2460C00A5A
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjASPp5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 10:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjASPpz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 10:45:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1688386B;
        Thu, 19 Jan 2023 07:45:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72CE1FB;
        Thu, 19 Jan 2023 07:46:31 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 340B93F445;
        Thu, 19 Jan 2023 07:45:47 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] perf cs_etm: Basic support for virtual/kernel timestamps
Date:   Thu, 19 Jan 2023 15:42:59 +0000
Message-Id: <20230119154308.3815108-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes since v3:

  * Scale time estimates by INSTR_PER_NS, rather than assuming 1
    instruction = 1ns
  * Add a new commit that fixes some issues around timestamps going
    backwards
  * Use nanoseconds inside cs-etm-decoder.c, rather than storing the
    raw time values and converting when a sample is synthesized. This
    simplifies some of the code like estimating the first timestamp.
  
===========================
Changes since v2:

  * Remove const to non-const change and copy strings where needed
    instead.
  * Use sizeof() instead of PATH_MAX
  * Append "will not be set accurately." to new error message
  * Remove unneeded stat() call
  * Rebase on perf/core
  
==========================

Changes since v1:

  * Add 3 refactor commits for sysfs reading around pmu.c as suggested
    by Arnaldo here [1]
  * The dependency on [2] has now reached mainline so is no longer
    blocking
  * Rebase on perf/core
  
[1]: https://lore.kernel.org/all/YnqVqq5QW%2Fb14oPZ@kernel.org/
[2]: https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/

German Gomez (4):
  perf pmu: Add function to check if a pmu file exists
  perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
  perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
  perf cs_etm: Set the time field in the synthetic samples

James Clark (4):
  perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
  perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
  perf: Remove remaining duplication of bus/event_source/devices/...
  perf: cs-etm: Ensure that Coresight timestamps don't go backwards

 tools/perf/arch/arm/util/auxtrace.c           |   5 +-
 tools/perf/arch/arm/util/cs-etm.c             |  91 ++++++++-
 tools/perf/arch/x86/util/pmu.c                |  12 +-
 tools/perf/util/cputopo.c                     |   9 +-
 tools/perf/util/cs-etm-base.c                 |  34 +++-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  68 +++++--
 tools/perf/util/cs-etm.c                      |  95 +++++++++-
 tools/perf/util/cs-etm.h                      |  16 +-
 tools/perf/util/pmu-hybrid.c                  |  27 +--
 tools/perf/util/pmu.c                         | 177 +++++++-----------
 tools/perf/util/pmu.h                         |  10 +-
 11 files changed, 349 insertions(+), 195 deletions(-)


base-commit: 69b41ac87e4a664de78a395ff97166f0b2943210
prerequisite-patch-id: 9722bf86e3e6d16d177ff9a1411992a795a7dcbd
prerequisite-patch-id: b05dbef439c2ea8465f3321532257b0ca29f21f9
prerequisite-patch-id: 92680a4781cbcf010fcb007e6ea030f59e9eaefc
prerequisite-patch-id: 8e3a73a04e4b89b503377b5fac1d89d551159393
prerequisite-patch-id: 09980d8fedcdaa70b220a7802428109f48448a58
prerequisite-patch-id: 711843c93d5d6bdf4d73e024949950f4e4de9e1a
-- 
2.25.1

