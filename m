Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9BF9EC;
	Sun,  8 Sep 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827304; cv=none; b=BW2u3QR1LlxhqGMkiU+D7NhGs0tNF69SBf7DZx1S2yk5c1etxrn2vOv3Qb6X9fWa7PwLJXpIavIWCvm/iIKZLzizbPODLyPQFHnhD0DUtaoo2TGY+0fOC1xeJPMKvlONnq9cwd9WbyWE1UGrqtsvEthP39rrkmggmo5gtIlXJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827304; c=relaxed/simple;
	bh=9lJbxYAq0pQArWPt6MRJRLmNOUsJkWmIbCPf3UCfggo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GKVXSxLLVdVpnfs3Grzv26z4xh74Y4KeeOSI9RKZiPNaK17jjdrRxiH4tmKrpF04QzzJN8SJJHYvVR9Mgy9Ictzg2Xh3oU3Ywyxgn/KA5x0VB4lsKg2Y8D/vxMY/15Iw4dCVLgRXqByFWsLbnicGsP84aPkgxBQmj6EWIS3Z0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GswIuH2N; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GswIuH2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725827303; x=1757363303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9lJbxYAq0pQArWPt6MRJRLmNOUsJkWmIbCPf3UCfggo=;
  b=GswIuH2NxfEwTEALmXV5J2PGMZu7hIr1bLng0NQriCVNHroQ5iSsc0eI
   vEC6+jR+aVpkKGfFI5Dj3RdxVpxMsQdbQq1pLK05nEruovF06afhx+clS
   pEMQsaCjVjACVriHL9DB1QSB3OqtlFG5ZDson9zKpGR6fegX0A4uGzRqu
   5eWd0IFIHwQsAQZBuJhNMj+A7IzWC2Vf/jVFC/FP3khXsjrIi/aGKHclN
   fjjYLM65INqBhdGAlXR4Dev9ALym23c6WeU/c+zWo1sS/b2NC/R5ObC9n
   r+LoQP7uqKO+QK7pzrx4OUWo9c84ND2gAhXW7l+HM8EsuBS8ghVsH1/bR
   Q==;
X-CSE-ConnectionGUID: eqXejJaMQHyYaFD4+h08xA==
X-CSE-MsgGUID: ETOgFb7LTZ2H6/vTukEbew==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28392593"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="28392593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 13:28:22 -0700
X-CSE-ConnectionGUID: OQnRXdWmRS+k8z6WOMwfjw==
X-CSE-MsgGUID: K5QnxdVmTj2supDBlDERBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="70583604"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 08 Sep 2024 13:28:21 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf evlist: Print hint for group
Date: Sun,  8 Sep 2024 13:28:47 -0700
Message-Id: <20240908202847.176280-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

An event group is a critical relationship. There is a -g option that can
display the relationship. But it's hard for a user to know when should
this option be applied.

If there is an event group in the perf record, print a hint to suggest
the user apply the -g to display the group information.

With the patch,

 $perf record -e "{cycles,instructions},instructions" sleep 1
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.024 MB perf.data (4 samples) ]

 $perf evlist
 cycles
 instructions
 instructions
 # Tip: use 'perf evlist -g' to show group information

 $perf evlist -g
 {cycles,instructions}
 instructions

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/ZttgvduaKsVn1r4p@x1/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-evlist.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 818ab21c3f73..a9bd7bbef5a9 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -36,7 +36,7 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.force     = details->force,
 	};
 	struct perf_tool tool;
-	bool has_tracepoint = false;
+	bool has_tracepoint = false, has_group = false;
 
 	perf_tool__init(&tool, /*ordered_events=*/false);
 	/* only needed for pipe mode */
@@ -54,11 +54,17 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 
 		if (pos->core.attr.type == PERF_TYPE_TRACEPOINT)
 			has_tracepoint = true;
+
+		if (!evsel__is_group_leader(pos))
+			has_group = true;
 	}
 
 	if (has_tracepoint && !details->trace_fields)
 		printf("# Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events\n");
 
+	if (has_group && !details->event_group)
+		printf("# Tip: use 'perf evlist -g' to show group information\n");
+
 	perf_session__delete(session);
 	return 0;
 }
-- 
2.38.1

