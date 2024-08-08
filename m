Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473C147C86;
	Thu,  8 Aug 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145576; cv=none; b=tWN4tv9nfon6uuxhbBE38yaM/sAzqDHTmOho13LezXTFywhCgRx9W3Rc8x41jt8pIwbvwGdIcgs9MmsLuY1OQ0WcCkGznHSPu2wVsLptdeRUClhwEklbL+JenmFp14JjXa+xA3xWumhtPhEfLPVeBKxfeLabLZ4NHVcTBeiR3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145576; c=relaxed/simple;
	bh=PUCAnV1am/H9H6knp3RxChEqhaqrs51NcPpmZipRtQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/dZx1hMkMt93CPG7D3oA+6P6Y4YX9fcwJZtc3nuSRGwUdiC20I+4t2yJhKrZzAo7Xs0vewtL/bbWrtVqTS9XyHeylyRIc7ZUVNETwsZATZlYIQcvHKtv9xAY0LGg3Sr+SM/ZFPoJJNG4Q9El6cRlyxiGkt8ToAlPyLHJ9KbQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QznDpzHL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QznDpzHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723145574; x=1754681574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUCAnV1am/H9H6knp3RxChEqhaqrs51NcPpmZipRtQM=;
  b=QznDpzHLOLNwKaNPZjtI9ZncwBs46JnRDRG68bu7W6xlin2QktPa6dRe
   q4yoFF7rGKKxJ1BZYdmUJTy+oJZsMlcxYLlAavoMt66U9uFpVZE/JCgAa
   7903/m/49FcBpGbONF++I5fE6NJO6KdHy1b7fYd+PILUPvQxH4xzdyZhc
   H82s/wQKMPQyco5X8yhG2V4i0kwYCwRGVp5R5Vg1L0XkRi8vf2swdz4H3
   M/aOgqM3fHg25d2nMCzh1IrBkhnGDX1uWOBeTdxy7gRFaJjRM705u1geY
   /QMUS8qR6gE1MfBhCwD3cV6bLxxpkvksVjEdeXmFlAFfp96HUEQo66B3C
   w==;
X-CSE-ConnectionGUID: hi8+2ghcRw6PiSAfYNvclA==
X-CSE-MsgGUID: Lbg83UGnRdmrMNBMaikVGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25091700"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25091700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:32:51 -0700
X-CSE-ConnectionGUID: UH/jKZwRT0CMbNcDrV2whg==
X-CSE-MsgGUID: bkGNTlvTQwi3PBcgvBpJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57402584"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 12:32:51 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/9] perf evlist: Save branch counters information
Date: Thu,  8 Aug 2024 12:33:18 -0700
Message-Id: <20240808193324.2027665-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The branch counters logging (A.K.A LBR event logging) introduces a
per-counter indication of precise event occurrences in LBRs. The kernel
only dumps the number of occurrences into a record. The perf tool has
to map the number to the corresponding event.

Add evlist__update_br_cntr() to go through the evlist to pick the
events that are configured to be logged. Assign a logical idx to track
them, and add the total number of the events in the leader event.
The total number will be used to allocate the space to save the branch
counters for a block. The logical idx will be used to locate the
corresponding event quickly in the following patches.

It only needs to iterate the evlist once. The
evsel__has_branch_counters() is also optimized.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++++
 tools/perf/util/evlist.h |  2 ++
 tools/perf/util/evsel.c  | 13 +++++++------
 tools/perf/util/evsel.h  |  8 ++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4b2538e4f679..68bbd3ea771b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -79,6 +79,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->ctl_fd.fd = -1;
 	evlist->ctl_fd.ack = -1;
 	evlist->ctl_fd.pos = -1;
+	evlist->nr_br_cntr = -1;
 }
 
 struct evlist *evlist__new(void)
@@ -1264,6 +1265,20 @@ u64 evlist__combined_branch_type(struct evlist *evlist)
 	return branch_type;
 }
 
+void evlist__update_br_cntr(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int i = 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
+			evsel->br_cntr_idx = i++;
+			evsel__leader(evsel)->br_cntr_nr++;
+		}
+	}
+	evlist->nr_br_cntr = i;
+}
+
 bool evlist__valid_read_format(struct evlist *evlist)
 {
 	struct evsel *first = evlist__first(evlist), *pos = first;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cccc34da5a02..b46f1a320783 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -57,6 +57,7 @@ struct evlist {
 	bool		 enabled;
 	int		 id_pos;
 	int		 is_pos;
+	int		 nr_br_cntr;
 	u64		 combined_sample_type;
 	enum bkw_mmap_state bkw_mmap_state;
 	struct {
@@ -219,6 +220,7 @@ int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel,
 u64 __evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_branch_type(struct evlist *evlist);
+void evlist__update_br_cntr(struct evlist *evlist);
 bool evlist__sample_id_all(struct evlist *evlist);
 u16 evlist__id_hdr_size(struct evlist *evlist);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f22f402d54cc..38a74d6dde49 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2636,17 +2636,18 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 
 static inline bool evsel__has_branch_counters(const struct evsel *evsel)
 {
-	struct evsel *cur, *leader = evsel__leader(evsel);
+	struct evsel *leader = evsel__leader(evsel);
 
 	/* The branch counters feature only supports group */
 	if (!leader || !evsel->evlist)
 		return false;
 
-	evlist__for_each_entry(evsel->evlist, cur) {
-		if ((leader == evsel__leader(cur)) &&
-		    (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
-			return true;
-	}
+	if (evsel->evlist->nr_br_cntr < 0)
+		evlist__update_br_cntr(evsel->evlist);
+
+	if (leader->br_cntr_nr > 0)
+		return true;
+
 	return false;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a5da4b03bb1c..a393dae1dc96 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -148,6 +148,14 @@ struct evsel {
 	 */
 	__u64			synth_sample_type;
 
+	/*
+	 * Store the branch counter related information.
+	 * br_cntr_idx: The idx of the branch counter event in the evlist
+	 * br_cntr_nr:  The number of the branch counter event in the group
+	 *	        (Only available for the leader event)
+	 */
+	int			br_cntr_idx;
+	int			br_cntr_nr;
 	/*
 	 * bpf_counter_ops serves two use cases:
 	 *   1. perf-stat -b          counting events used byBPF programs
-- 
2.38.1

