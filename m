Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D166119
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FFE89B;
	Wed, 15 Nov 2023 01:28:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB29DA7;
	Wed, 15 Nov 2023 01:29:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.37.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3DB63F7B4;
	Wed, 15 Nov 2023 01:28:13 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'
Date: Wed, 15 Nov 2023 14:58:03 +0530
Message-Id: <20231115092805.737822-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series drops 'pmu_lock' usage from all arm platforms which had already
been dropped from arm64 platforms earlier via the following commit.

commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking"). 

Afterwards, drop unused 'pmu_lock' element from 'struct pmu_hw_events'. The
series applies on 6.7-rc1 and has been tested on arm64. Although just build
tested for arm platform.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Changes in V1:

- Added some build warning fixes

RFC V1:

https://lore.kernel.org/all/20231016052431.1390269-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  arm: perf: Remove PMU locking
  drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'

 arch/arm/kernel/perf_event_v6.c     | 28 ++++--------------
 arch/arm/kernel/perf_event_v7.c     | 44 -----------------------------
 arch/arm/kernel/perf_event_xscale.c | 44 ++++++-----------------------
 drivers/perf/arm_pmu.c              |  1 -
 include/linux/perf/arm_pmu.h        |  6 ----
 5 files changed, 13 insertions(+), 110 deletions(-)

-- 
2.25.1

