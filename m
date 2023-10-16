Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A16FCE
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98447DC;
	Sun, 15 Oct 2023 22:24:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5A21FB;
	Sun, 15 Oct 2023 22:25:21 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B18383F762;
	Sun, 15 Oct 2023 22:24:38 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'
Date: Mon, 16 Oct 2023 10:54:29 +0530
Message-Id: <20231016052431.1390269-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series drops 'pmu_lock' usage from all arm platforms which had already
been dropped from arm64 platforms earlier via the following commit.

commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking"). 

Afterwards, drop unused 'pmu_lock' element from 'struct pmu_hw_events'. The
series applies on 6.6-rc6 and has been tested on arm64. Although just build
tested for arm platform.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Anshuman Khandual (2):
  arm: perf: Remove PMU locking
  drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'

 arch/arm/kernel/perf_event_v6.c     | 20 ++++---------
 arch/arm/kernel/perf_event_v7.c     | 44 -----------------------------
 arch/arm/kernel/perf_event_xscale.c | 30 +++++---------------
 drivers/perf/arm_pmu.c              |  1 -
 include/linux/perf/arm_pmu.h        |  6 ----
 5 files changed, 12 insertions(+), 89 deletions(-)

-- 
2.25.1

