Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81028189902
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308342; cv=none; b=skm9GwXUsr0hj/lUGA5C6LqEmrE91rOUsF8cHMckBnDMgdohH4A8UqP00SyT5g7ScJSCz+zegKgq7XyL77Zz3I/Cy7G9S/iWOCG2N1/2fr1FltFyU7RBRkASbMpvgQ0wjOYMgLaHrMCJL6ZZxcmvLfhiJwuQzagR81dGGHEHaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308342; c=relaxed/simple;
	bh=ZxU9+VqjJRGENIQ07ahp8xXkjFU7fLknJOtMNk2m+pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/qJ+GU3R8Clj2VUCNaP2G9vBYIaB6lnHKIly7y02m6uuwKAIkwRyiw/ZMUlPTf6mvu38wiqGrKDUsdpZRmiHPDPaSpdq8dYyhhw2TWyU/ynm2ksNvohIGTsWpbQzYZdYJlYJVFxnnvyyk0EcG3D8ucTTF/TutTN9bzzmuiCdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02E4313D5;
	Tue, 18 Mar 2025 07:32:28 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B08503F694;
	Tue, 18 Mar 2025 07:32:18 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH Resend] perf/arm-cmn: Remove CMN-600 DTC domain special case
Date: Tue, 18 Mar 2025 14:32:10 +0000
Message-Id: <67985e39f53b56385d79a4f1264cf7f9cacedb58.1742308248.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The special case for trying to infer the DTC domain for DTC-adjacent
nodes on CMN-600 is fragile and buggy - currently resulting in subtly
messed up DTC counter allocation - and the theoretical benefit it
offers to a tiny minority of use-cases arguably doesn't outweigh the
inconsistency it offers to others anyway. Just get rid of it.

Fixes: ab33c66fd8f1 ("perf/arm-cmn: Enable per-DTC counter allocation")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index ef959e66db7c..582f0c0e1783 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2166,13 +2166,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 
 	cmn->xps = arm_cmn_node(cmn, CMN_TYPE_XP);
 
-	if (cmn->part == PART_CMN600 && cmn->num_dtcs > 1) {
-		/* We do at least know that a DTC's XP must be in that DTC's domain */
-		dn = arm_cmn_node(cmn, CMN_TYPE_DTC);
-		for (int i = 0; i < cmn->num_dtcs; i++)
-			arm_cmn_node_to_xp(cmn, dn + i)->dtc = i;
-	}
-
 	for (dn = cmn->dns; dn->type; dn++) {
 		if (dn->type == CMN_TYPE_XP)
 			continue;
-- 
2.39.2.101.g768bb238c484.dirty

