Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0723957D
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212843; cv=none; b=SBeK/zEqij20t/0vvNlXu9i6k4V4O1cygIIL8MEDnRzzhbdMwhy2lAt6QVcr1YTjTfrcuhBA927IsCtuX9rE/XAmFzokbJXz0wOGM27Y1xNJ6QC5+1xMNgmpyqO6/Dos+3aFbTppeRj9ZdLAI/rzldBhQODIDm947264IX5cKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212843; c=relaxed/simple;
	bh=IwCnZGALhOPk/F+1dqCbwAPb1i30sraV2IqW5w1Dd4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mulRAOpRMVBu2amRQgwh/1QBFPzyFPIZX5jaQxM6hJFvWwWwQkwRCa5oZNR/OaGA7UMYeShY8CUEb9Db1RrUVNKnAAIpg9uL2+FH9Wn64L0O1ZZXREdZHyWv5dRim2JwLqzBT0wiafI5YIKDzA6RdTqUfoVkas/KO1uQoZCOhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30D5113D5;
	Mon, 17 Mar 2025 05:00:50 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DA013F63F;
	Mon, 17 Mar 2025 05:00:40 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] perf/arm_cspmu: Fix missing io.h include
Date: Mon, 17 Mar 2025 12:00:33 +0000
Message-Id: <657935ca177024ad08d5ec6f85e8faf75f82cf65.1742212833.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the writel() calls needs io.h, which apparently gets
transiently included somewhere on arm64, but not elsewhere.

Fixes: 6de0298a3925 ("perf/arm_cspmu: Generalise event filtering")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503150649.Dol8RBSh-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503152245.cAG4FMfi-lkp@intel.com/
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/nvidia_cspmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 4d5c4912c68f..0a7e316fb999 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -6,6 +6,7 @@
 
 /* Support for NVIDIA specific attributes. */
 
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/topology.h>
 
-- 
2.39.2.101.g768bb238c484.dirty

