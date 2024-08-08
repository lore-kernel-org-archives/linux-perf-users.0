Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74E156863;
	Thu,  8 Aug 2024 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145576; cv=none; b=BLcZbnA3/bM0NF9Nksb1WKqF6rE9cvm2lSS/dGGcu3aTmvnKCgx7q1c8GjQV2vyCdR7F1UxGJJJ8srStDd+zbsEsD9aWBnn8MInVSfBrkHVIy6ce16XU/VOBtbiYsDVmJakYfYUyYjkkpoJAdtbqedGsg1HwMZt+x8g7DOXixw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145576; c=relaxed/simple;
	bh=INmGvse47m1TyhqqOxl4EU0UajeILdDJuF9VfmuIi70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+H9q3maTOWTTMr68n89k0aF11uIfFwyREF4jIQY8JhQko2vSCHzepY6OHKMvLkBWza0nDvsMZpNYu1qiNc33Hi9dtrMARJb5LPfCZaD7Fx5VvZOkp/w18KybqS1C4a3xEY19Oks+6AtDOLyy3tk7uIITC8YgiswiSM8xeJh4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFFM0TiN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFFM0TiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723145575; x=1754681575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INmGvse47m1TyhqqOxl4EU0UajeILdDJuF9VfmuIi70=;
  b=kFFM0TiN/Mc5/RGzqAOf8zFU2pbgKh3TLKQ62m78WGDS0ebfpv2MBuOD
   +6JwkM+6AFikRGJctseq1HYoPzIwlyCRZQOyb8q7Z+u+pYdHdPufggiXR
   Nd9yyfr6/OLDpq/7nTUO/hI5Gs8utjSY5GhQwq3y8Pv4fU+YtAGiW4QE+
   NKQGV8iP5u3Fdd36T76MKD4WzITtIbGpii3wR7+NTytAZHK5xWrycePjn
   j+MNk8aYPMRgAXWWHZQmhQ+7Ilcs1qrGaxap7SlCGBcuFp8mO97HRq8G6
   p8GmsbBKQTwTgcqtkVzYpNYvf3uXom0qbeYSx14pPELVBYuzsp4WPXBnr
   g==;
X-CSE-ConnectionGUID: dxKGErKQTfyjyfdno1EXyA==
X-CSE-MsgGUID: VlIntO9lS8qon9T2+fEVFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25091711"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25091711"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:32:52 -0700
X-CSE-ConnectionGUID: dfRly6t1RZieXLB738TbLg==
X-CSE-MsgGUID: 24ONvpEbSi+IoyvkbY2cjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57402593"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 12:32:52 -0700
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
Subject: [PATCH V2 5/9] perf evsel: Assign abbr name for the branch counter events
Date: Thu,  8 Aug 2024 12:33:20 -0700
Message-Id: <20240808193324.2027665-6-kan.liang@linux.intel.com>
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

There could be several branch counter events. If perf tool output the
result via the format "event name + a number", the line could be very
long and hard to read.

An abbreviation is introduced to replace the full event name in the
display. The abbreviation starts from 'A' to 'Z9', which can support
up to 286 events. The same abbreviation will be assigned if the same
events are found in the evlist. The next patch will utilize the
abbreviation name to show the branch counter events in the output.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 55 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h  |  6 +++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 68bbd3ea771b..c0379fa1ccfe 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -33,6 +33,7 @@
 #include "util/bpf-filter.h"
 #include "util/stat.h"
 #include "util/util.h"
+#include "util/env.h"
 #include "util/intel-tpebs.h"
 #include <signal.h>
 #include <unistd.h>
@@ -1265,15 +1266,67 @@ u64 evlist__combined_branch_type(struct evlist *evlist)
 	return branch_type;
 }
 
+static struct evsel *
+evlist__find_dup_event_from_prev(struct evlist *evlist, struct evsel *event)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (event == pos)
+			break;
+		if ((pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) &&
+		    !strcmp(pos->name, event->name))
+			return pos;
+	}
+	return NULL;
+}
+
+#define MAX_NR_ABBR_NAME	(26 * 11)
+
+/*
+ * The abbr name is from A to Z9. If the number of event
+ * which requires the branch counter > MAX_NR_ABBR_NAME,
+ * return NA.
+ */
+static void evlist__new_abbr_name(char *name)
+{
+	static int idx;
+	int i = idx / 26;
+
+	if (idx >= MAX_NR_ABBR_NAME) {
+		name[0] = 'N';
+		name[1] = 'A';
+		name[2] = '\0';
+		return;
+	}
+
+	name[0] = 'A' + (idx % 26);
+
+	if (!i)
+		name[1] = '\0';
+	else {
+		name[1] = '0' + i - 1;
+		name[2] = '\0';
+	}
+
+	idx++;
+}
+
 void evlist__update_br_cntr(struct evlist *evlist)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *dup;
 	int i = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
 			evsel->br_cntr_idx = i++;
 			evsel__leader(evsel)->br_cntr_nr++;
+
+			dup = evlist__find_dup_event_from_prev(evlist, evsel);
+			if (dup)
+				memcpy(evsel->abbr_name, dup->abbr_name, 3 * sizeof(char));
+			else
+				evlist__new_abbr_name(evsel->abbr_name);
 		}
 	}
 	evlist->nr_br_cntr = i;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a393dae1dc96..4316992f6a69 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -153,9 +153,15 @@ struct evsel {
 	 * br_cntr_idx: The idx of the branch counter event in the evlist
 	 * br_cntr_nr:  The number of the branch counter event in the group
 	 *	        (Only available for the leader event)
+	 * abbr_name:   The abbreviation name assigned to an event which is
+	 *		logged by the branch counter.
+	 *		The abbr name is from A to Z9. NA is applied if out
+	 *		of the range.
 	 */
 	int			br_cntr_idx;
 	int			br_cntr_nr;
+	char			abbr_name[3];
+
 	/*
 	 * bpf_counter_ops serves two use cases:
 	 *   1. perf-stat -b          counting events used byBPF programs
-- 
2.38.1

