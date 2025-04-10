Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489728CF5D
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310344; cv=none; b=jYIvhr1Oe9iC5JH7lNhhx5ygMD7gtkV4YSg54VPZD/xzK42IsV6pyTMfuDPSHjHRMenQk+46gj4fjLTCTogkz5+2ECH+zNEtzmHSYDVseONjUTReWher1UMexjaVrtBdJzgdF69G2njtsrrdxC0jb/JjNFbNBp5LRatIhuBr8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310344; c=relaxed/simple;
	bh=WXrV8ZOqkERjJyEmucIIf5r2rsjMNHHboYxRESQP1HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX3Y2ELmz0qZBBvlcT7YgI97EDLzE8HrzsdRwvz0c600yNC25adevQpFDEV7tpO2patHr1Ru1tRi/Pznika5uC3LbpwGlYj56lmplSXmjUVvcuppAHpXTqeHqy3kJ5q0xvFJ6QbleaBHf3IqRLXMBI4s3JfvbqfZ0OAwH93h5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtGO0joQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtGO0joQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744310343; x=1775846343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WXrV8ZOqkERjJyEmucIIf5r2rsjMNHHboYxRESQP1HU=;
  b=dtGO0joQrgEtt3I5nCB1aqTN4b30FeCRwoxGx95JaHF16tsSDMiNc26c
   FWUJz6PtfMEOw2KU7cb/lb8t+Uno0ud/OEPo5vaXegNj2Z9mXdSdY+VRG
   T7M7jz1l/nScWpPhOKOt/qQNrm3vBrlcn9w3P3vOPIRzXTTXJ3a7q93DZ
   ka8do2zGGdk18dGb5ss6Dos8EoxKX/DBy6un5jUp9NAoG25stwEaKFUdz
   bbhLhi/CooFEyx/rZ97yYB8Gg6WSwjSSCXyF9D+SSsQJxTRRVP0G2EB/R
   2Llb5RF2gvQoltGl14Z/jQgwygFN+LWul4M/gjqc2bENR8vqblefZEKwe
   w==;
X-CSE-ConnectionGUID: jsEUN70XREGspw+cBBioqA==
X-CSE-MsgGUID: EELkD8//QsiCoMVsuP5GgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45978601"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45978601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:39:02 -0700
X-CSE-ConnectionGUID: 5njm8PvqRuGu4NHb1ssIZQ==
X-CSE-MsgGUID: M0R26jCVTQWWPPEtuoWJ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133091570"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:39:02 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf annotate: Fix BUG_ON in basic block processing
Date: Thu, 10 Apr 2025 11:38:52 -0700
Message-ID: <20250410183852.872311-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hit with perf annotate --code-with-type --stdio

perf: util/annotate-data.c:1299: find_data_type_insn: Assertion
`!(bb->begin->al.offset == -1 || bb->end->al.offset == -1)' failed.

This makes sure to skip non instruction disasm lines in all cases that
add basic blocks. Also added some extra BUG_ONs for this case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/annotate-data.c | 10 +++++++++-
 tools/perf/util/annotate.c      |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c3ffb8cad4fc..51ca86ef2677 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -986,7 +986,15 @@ static void prepend_basic_blocks(struct list_head *this_blocks,
 	}
 
 	/* Point to the insn before the last when adding this block to full_blocks */
-	last_bb->end = list_prev_entry(last_bb->end, al.node);
+	do {
+		/* Nothing useful found */
+		if (last_bb->end == last_bb->begin) {
+			list_del(&last_bb->list);
+			free(last_bb);
+			goto out;
+		}
+		last_bb->end = list_prev_entry(last_bb->end, al.node);
+	} while (last_bb->end->al.offset == -1);
 
 out:
 	list_splice(this_blocks, full_blocks);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 18ce9f37053e..1c226f257245 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2966,6 +2966,7 @@ static int add_basic_block(struct basic_block_data *bb_data,
 
 	if (dl == NULL)
 		return -1;
+	BUG_ON(dl->al.offset == -1);
 
 	if (!is_new_basic_block(bb_data, dl))
 		return 0;
@@ -3006,7 +3007,7 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 
 	last_dl = list_last_entry(&notes->src->source,
 				  struct disasm_line, al.node);
-	if (last_dl->al.offset == -1)
+	while (last_dl && last_dl->al.offset == -1)
 		last_dl = annotation__prev_asm_line(notes, last_dl);
 
 	if (last_dl == NULL)
@@ -3052,6 +3053,7 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 		break;
 
 	}
+	BUG_ON(dl->al.offset == -1);
 	link->bb->end = dl;
 	return found;
 }
-- 
2.49.0

