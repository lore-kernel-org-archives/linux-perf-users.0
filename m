Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC112E5D
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046173; cv=none; b=PyoCV7oA/Zc6kZKmJgnUW3vxhfhwo4fELpvdOvGuJKvrl//pKn+ajoJyqVLdjoUti3HubZ0ovirs/KxbJoFJ92Z4QblQz5ZGY97Z8eO/fzpWCbHRW/piMG02/XDDeqdltz5gNXf/EhlmgB26ozaabSv5ZMuy4Riubo/Fg2qe8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046173; c=relaxed/simple;
	bh=FXObw9eEckg2sOaajMqgfkaBO4sWvzOqvz8uVr5uM2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BI91t29vPsJzrLTAzMY1QXBHMIMxGdJrSRo79yHYGwOC8AJ2huTjp2fPMdR015lkz171dW3h4YhVVVI4JEfWsm04WKA+b8D+kFd4F0iump0fSoB9C3iTyzLmXU899u60/uXOH3lfjtSVFBIntyF+jJQmy+Le5ft0/zJ8A3JXsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333351655;
	Fri, 27 Jun 2025 10:42:34 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 369433F66E;
	Fri, 27 Jun 2025 10:42:50 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] perf/arm-cmn: Reduce stack usage during discovery
Date: Fri, 27 Jun 2025 18:42:39 +0100
Message-Id: <e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arnd reports that Clang's aggressive inlining of arm_cmn_discover() can
lead to stack frame size warnings, and while we could simply prevent
such inlining to hide the issue, it seems more productive to actually
heed the warning and do something about the overall stack footprint.
The xp_region array is already rather large, and CMN_MAX_XPS might only
grow larger in future, however it only serves as a convenience to save
repeating the first level's worth of register reads in the second pass
of discovery. There's no performance concern here, and it only takes a
small tweak to the flow to re-extract the offsets instead of stashing
them, so let's just do that and save several hundred bytes of stack.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 031d45d0fe3d..02ffc8d09328 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2245,12 +2245,11 @@ static enum cmn_node_type arm_cmn_subtype(enum cmn_node_type type)
 
 static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 {
-	void __iomem *cfg_region;
+	void __iomem *cfg_region, __iomem *xp_region;
 	struct arm_cmn_node cfg, *dn;
 	struct arm_cmn_dtm *dtm;
 	enum cmn_part part;
 	u16 child_count, child_poff;
-	u32 xp_offset[CMN_MAX_XPS];
 	u64 reg;
 	int i, j;
 	size_t sz;
@@ -2302,11 +2301,12 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	cmn->num_dns = cmn->num_xps;
 
 	/* Pass 1: visit the XPs, enumerate their children */
+	cfg_region += child_poff;
 	for (i = 0; i < cmn->num_xps; i++) {
-		reg = readq_relaxed(cfg_region + child_poff + i * 8);
-		xp_offset[i] = reg & CMN_CHILD_NODE_ADDR;
+		reg = readq_relaxed(cfg_region + i * 8);
+		xp_region = cmn->base + (reg & CMN_CHILD_NODE_ADDR);
 
-		reg = readq_relaxed(cmn->base + xp_offset[i] + CMN_CHILD_INFO);
+		reg = readq_relaxed(xp_region + CMN_CHILD_INFO);
 		cmn->num_dns += FIELD_GET(CMN_CI_CHILD_COUNT, reg);
 	}
 
@@ -2332,11 +2332,12 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	cmn->dns = dn;
 	cmn->dtms = dtm;
 	for (i = 0; i < cmn->num_xps; i++) {
-		void __iomem *xp_region = cmn->base + xp_offset[i];
 		struct arm_cmn_node *xp = dn++;
 		unsigned int xp_ports = 0;
 
-		arm_cmn_init_node_info(cmn, xp_offset[i], xp);
+		reg = readq_relaxed(cfg_region + i * 8);
+		xp_region = cmn->base + (reg & CMN_CHILD_NODE_ADDR);
+		arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, xp);
 		/*
 		 * Thanks to the order in which XP logical IDs seem to be
 		 * assigned, we can handily infer the mesh X dimension by
-- 
2.39.2.101.g768bb238c484.dirty

