Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C2824A3
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851868; cv=none; b=VeRKDKZm3b/jRaK7aDFVNqivCVcvBaD0/884gYwEBUn3MuNMBUu8IP4GyeFSduh2t7Jgc95V+N2X56MR3GgLRDd5yEvxQk1xqW092cLRu+n+GEQ9VS+5/5P/6TmhxQHdqYkeOUdxXDRig2Q8ZDX/MGq7OrDdwPnM2HOiQ8LGXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851868; c=relaxed/simple;
	bh=5uV3pFDaW2HQK+caAyfzLg5OCLt3WtV+WxLBqOw9wrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q32UM+KfFG6WVqAk+/XULh/lzV95Z9Jcro4KYud9KoNZ3dm1FYQbm+5zTQYkSlyMpPTTAOQX4LhtlIYotUFXmhqzglyvsoZErAatZg6AQ5PU1jH+JD1yHuj+nxgRU140ABJ+xERxI3HFb3aisTmsxOZeh2fKyh9ruhB3ZNY3O1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C0E1063;
	Thu,  6 Feb 2025 06:24:49 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B28253F63F;
	Thu,  6 Feb 2025 06:24:25 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH] perf/arm-cmn: Minor event type housekeeping
Date: Thu,  6 Feb 2025 14:24:04 +0000
Message-Id: <ef46a47fc4ab909093f14b2b4289a4835836ab6c.1738851844.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While handling RN-D nodes under the functionally-identical RN-I type
works fine for perf tool users using the "rnid_" event aliases, and that
is the documented and expected ABI, there's little reason not to be
permissive and accept the actual RN-D type as an additional encoding for
the same events as well. This may be convenient for other tooling
generating event configs directly from its own topology data.

In the RN-I event mood, it also seems as good a time as any to clean up
a forgotten macro for CCLA_RNI events which ended up being unnecessary.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index ef959e66db7c..d4fe30ff225b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -802,8 +802,6 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	CMN_EVENT_ATTR(_model, ccha_##_name, CMN_TYPE_CCHA, _event)
 #define CMN_EVENT_CCLA(_name, _event)				\
 	CMN_EVENT_ATTR(CMN_ANY, ccla_##_name, CMN_TYPE_CCLA, _event)
-#define CMN_EVENT_CCLA_RNI(_name, _event)				\
-	CMN_EVENT_ATTR(CMN_ANY, ccla_rni_##_name, CMN_TYPE_CCLA_RNI, _event)
 #define CMN_EVENT_HNS(_name, _event)				\
 	CMN_EVENT_ATTR(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
 
@@ -1798,6 +1796,9 @@ static int arm_cmn_event_init(struct perf_event *event)
 	} else if (type == CMN_TYPE_XP &&
 		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
 		hw->wide_sel = true;
+	} else if (type == CMN_TYPE_RND) {
+		/* Secretly permit this as an alias for "rnid" events */
+		type = CMN_TYPE_RNI;
 	}
 
 	/* This is sufficiently annoying to recalculate, so cache it */
-- 
2.39.2.101.g768bb238c484.dirty

