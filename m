Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D97C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiDLMgF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348114AbiDLMft (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 08:35:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 363E513FB4;
        Tue, 12 Apr 2022 04:54:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3641A1424;
        Tue, 12 Apr 2022 04:54:39 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E47C63F70D;
        Tue, 12 Apr 2022 04:54:32 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [RFC V2 0/8] arm64/perf: Enable branch stack sampling
Date:   Tue, 12 Apr 2022 17:24:47 +0530
Message-Id: <20220412115455.293119-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series enables perf branch stack sampling support on arm64 platform
via a new arch feature called Branch Record Buffer Extension (BRBE). All
relevant register definitions could be accessed here.

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers

This series applies on v5.18-rc1 after the BRBE related perf ABI changes series
(V5) that was posted earlier.

https://lore.kernel.org/all/20220404045046.634522-2-anshuman.khandual@arm.com/

Following issues remain inconclusive

- Jame's concerns regarding permission inadequacy related to perfmon_capable()
- Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()
- Rob's concerns regarding the series structure, arm_pmu callbacks based framework

Changes in RFC V2:

- Added branch_sample_priv() while consolidating other branch sample filter helpers
- Changed all SYS_BRBXXXN_EL1 register definition encodings per Marc
- Changed the BRBE driver as per proposed BRBE related perf ABI changes (V5)
- Added documentation for struct arm_pmu changes, updated commit message
- Updated commit message for BRBE detection infrastructure patch
- PERF_SAMPLE_BRANCH_KERNEL gets checked during arm event init (outside the driver)
- Branch privilege state capture mechanism has now moved inside the driver

Changes in RFC V1:

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (8):
  perf: Consolidate branch sample filter helpers
  arm64/perf: Add register definitions for BRBE
  arm64/perf: Update struct arm_pmu for BRBE
  arm64/perf: Update struct pmu_hw_events for BRBE
  driver/perf/arm_pmu_platform: Add support for BRBE attributes detection
  arm64/perf: Drive BRBE from perf event states
  arm64/perf: Add BRBE driver
  arm64/perf: Enable branch stack sampling

 arch/arm64/include/asm/sysreg.h | 222 +++++++++++++++++
 arch/arm64/kernel/perf_event.c  |  48 ++++
 drivers/perf/Kconfig            |  11 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/arm_pmu.c          |  72 +++++-
 drivers/perf/arm_pmu_brbe.c     | 425 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu_brbe.h     | 259 +++++++++++++++++++
 drivers/perf/arm_pmu_platform.c |  34 +++
 include/linux/perf/arm_pmu.h    |  63 +++++
 include/linux/perf_event.h      |  24 ++
 kernel/events/core.c            |   9 +-
 11 files changed, 1158 insertions(+), 10 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_brbe.c
 create mode 100644 drivers/perf/arm_pmu_brbe.h

-- 
2.25.1

