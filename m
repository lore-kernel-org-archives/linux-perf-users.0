Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8516C849;
	Tue,  7 May 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091204; cv=none; b=X9lldrCbSHcXsybgzwVxKUyKFABF/zu9jP/yCM/xUaMIdbGsFR+ya/I1qK9leckXl1vGFlltO3y70wRMHzEF3DOqrJgVeTVA621zppTFmk0AjAQ+6YPikZ+zmCFO3Gu3a9TpMTZdQSnE/i9sfB3xTn/l6c39yrRIGGxCt5zYDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091204; c=relaxed/simple;
	bh=sE3X07S6/95vfe+bBwB2Qtkb4OMn+hxVPTR3EAq1XMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rF4M9F3yC2QuKs1kXB6DZHFsjUDxYv9b0jrieqi7KgIZMix1Qf/AFcsGhsACNw1M6g2OMWiun20qY6F2P5znXNumHAMmRIuxfClLL0VhwBEm43VbmRhCncfhncPaiFoR2AyA/oO+0vOguEqQxxS0Rd98LZD7ziaT2CFkIqQSLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 595341515;
	Tue,  7 May 2024 07:13:29 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78FCB3F6A8;
	Tue,  7 May 2024 07:13:01 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	atrajeev@linux.vnet.ibm.com,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf maps: Re-use __maps__free_maps_by_name()
Date: Tue,  7 May 2024 15:12:06 +0100
Message-Id: <20240507141210.195939-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507141210.195939-1-james.clark@arm.com>
References: <20240507141210.195939-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maps__merge_in() hard codes the steps to free the maps_by_name list. It
seems to not map__put() each element before freeing, and it sets
maps_by_name_sorted to true after freeing, which may be harmless but
is inconsistent with maps__init() and other functions.

maps__maps_by_name_addr() is also quite hard to read because we already
have maps__maps_by_name() and maps__maps_by_address(), but the function
is only used in that place so delete it.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/maps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 61eb742d91e3..16b39db594f4 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -124,11 +124,6 @@ static void maps__set_maps_by_address(struct maps *maps, struct map **new)
 
 }
 
-static struct map ***maps__maps_by_name_addr(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->maps_by_name;
-}
-
 static void maps__set_nr_maps_allocated(struct maps *maps, unsigned int nr_maps_allocated)
 {
 	RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_maps_allocated;
@@ -284,6 +279,9 @@ void maps__put(struct maps *maps)
 
 static void __maps__free_maps_by_name(struct maps *maps)
 {
+	if (!maps__maps_by_name(maps))
+		return;
+
 	/*
 	 * Free everything to try to do it from the rbtree in the next search
 	 */
@@ -291,6 +289,9 @@ static void __maps__free_maps_by_name(struct maps *maps)
 		map__put(maps__maps_by_name(maps)[i]);
 
 	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
+
+	/* Consistent with maps__init(). When maps_by_name == NULL, maps_by_name_sorted == false */
+	maps__set_maps_by_name_sorted(maps, false);
 }
 
 static int map__start_cmp(const void *a, const void *b)
@@ -1167,8 +1168,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	}
 	maps__set_maps_by_address(kmaps, merged_maps_by_address);
 	maps__set_maps_by_address_sorted(kmaps, true);
-	zfree(maps__maps_by_name_addr(kmaps));
-	maps__set_maps_by_name_sorted(kmaps, true);
+	__maps__free_maps_by_name(kmaps);
 	maps__set_nr_maps_allocated(kmaps, merged_nr_maps_allocated);
 
 	/* Copy entries before the new_map that can't overlap. */
-- 
2.34.1

