Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502E14ABE;
	Fri, 29 May 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065238; cv=none; b=tXu1VE4lsin6SMqZF9OO/5Bsf//4ojVOGD/HlLbdsUa8nNtQiycUA/By8BHhUo3WGwCTjccn07B14JZp3KHrb/ZHRtEdFwImyE+Pap9qbGue/d3Wl9FPMR5S8hfP99ufl/ImLCQRy8+8RAJ8VOAU0bIyWSL3OXAq5qWIO+Ew8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065238; c=relaxed/simple;
	bh=DxQIY9aVNXnbe+nacPZDzEqdF/6n6FZ2z0Z159xjSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P65Z42UXS4iJANJAuuTmBjW/o84sVXBBEA1UmPbvEUFmI4bop3mHkplTkdLS1wbLGFFqdjlLCo2G8VmnEupdCdPy2NAwR/csunkRrxZy8tHB5xUZcsNWIYsIRK70gcTVImVACEDJH5HDp7LqdLMpTHGR/eShP7Z5D7qTo73p3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=frmzm4Bw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="frmzm4Bw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4BF1FC7;
	Fri, 29 May 2026 07:33:50 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF6B03F905;
	Fri, 29 May 2026 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780065235; bh=DxQIY9aVNXnbe+nacPZDzEqdF/6n6FZ2z0Z159xjSJk=;
	h=From:To:Cc:Subject:Date:From;
	b=frmzm4Bw0NKUCKg7cScfgm4wYmILy10DV6QqLlMXsaJp5zwedFU4kHAze4ZyreWSn
	 7qevaKhEkRLfLeEvA/Pu5o224lb3z/IdD12EyF9fX8reA+k+NVfOoML+tzwW645ugf
	 Kr+A0g++p6Yy/rHfK1clZfFRGv67X8sEJWu2VDjc=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Fix DVM node events
Date: Fri, 29 May 2026 15:33:45 +0100
Message-ID: <1af20ba3fb35cc507e0d74408675b50340feca39.1780065225.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new DVM node events added in CMN-700 also apply to CMN S3; fix
the model encoding so that we can expose the aliases and handle
occupancy filtering on newer CMNs too.

Cc: <stable@vger.kernel.org>
Fixes: 0dc2f4963f7e ("perf/arm-cmn: Support CMN S3")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f5305c8fdca4..6e5cc4086a9e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -197,13 +197,14 @@
 enum cmn_model {
 	CMN600 = 1,
 	CMN650 = 2,
-	CMN700 = 4,
-	CI700 = 8,
+	CI700 = 4,
+	CMN700 = 8,
 	CMNS3 = 16,
 	/* ...and then we can use bitmap tricks for commonality */
 	CMN_ANY = -1,
 	NOT_CMN600 = -2,
-	CMN_650ON = CMN650 | CMN700 | CMNS3,
+	CMN_700ON = ~(CMN700 - 1),
+	CMN_650ON = CMN_700ON | CMN650,
 };
 
 /* Actual part numbers and revision IDs defined by the hardware */
@@ -919,14 +920,14 @@ static struct attribute *arm_cmn_event_attrs[] = {
 	CMN_EVENT_DVM(NOT_CMN600, txsnp_stall,		0x0a),
 	CMN_EVENT_DVM(NOT_CMN600, trkfull,		0x0b),
 	CMN_EVENT_DVM_OCC(NOT_CMN600, trk_occupancy,	0x0c),
-	CMN_EVENT_DVM_OCC(CMN700, trk_occupancy_cxha,	0x0d),
-	CMN_EVENT_DVM_OCC(CMN700, trk_occupancy_pdn,	0x0e),
-	CMN_EVENT_DVM(CMN700, trk_alloc,		0x0f),
-	CMN_EVENT_DVM(CMN700, trk_cxha_alloc,		0x10),
-	CMN_EVENT_DVM(CMN700, trk_pdn_alloc,		0x11),
-	CMN_EVENT_DVM(CMN700, txsnp_stall_limit,	0x12),
-	CMN_EVENT_DVM(CMN700, rxsnp_stall_starv,	0x13),
-	CMN_EVENT_DVM(CMN700, txsnp_sync_stall_op,	0x14),
+	CMN_EVENT_DVM_OCC(CMN_700ON, trk_occupancy_cxha, 0x0d),
+	CMN_EVENT_DVM_OCC(CMN_700ON, trk_occupancy_pdn,	0x0e),
+	CMN_EVENT_DVM(CMN_700ON, trk_alloc,		0x0f),
+	CMN_EVENT_DVM(CMN_700ON, trk_cxha_alloc,	0x10),
+	CMN_EVENT_DVM(CMN_700ON, trk_pdn_alloc,		0x11),
+	CMN_EVENT_DVM(CMN_700ON, txsnp_stall_limit,	0x12),
+	CMN_EVENT_DVM(CMN_700ON, rxsnp_stall_starv,	0x13),
+	CMN_EVENT_DVM(CMN_700ON, txsnp_sync_stall_op,	0x14),
 
 	CMN_EVENT_HNF(CMN_ANY, cache_miss,		0x01),
 	CMN_EVENT_HNF(CMN_ANY, slc_sf_cache_access,	0x02),
-- 
2.54.0.dirty

