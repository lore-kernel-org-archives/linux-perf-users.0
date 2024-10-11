Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2C1CDA31;
	Fri, 11 Oct 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633897; cv=none; b=OX/3X8u29WdR/TmzP8Cgoxp4i0kKimpVh/50Cmn6r5Xa5W4SZ6YHb2X+xgAMNtJtCtgObwpRYn8wh2sjA2rRJJxIL+V9MPxEa22zw4ZSC0X9GOT3uQVepCf/hbfQAKDYFum8BTyfvIHsVPixFjdbjqt2swHzZ5qTdul4kggyc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633897; c=relaxed/simple;
	bh=dTN8hMoDEwuDuC6o7FbLye3wkfriMZqTE3K8Yy5nY6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EzkOKK5UnPuHSHKKyWsXju23XR9oVkfk5cvBP4k8/eaoJ6u8lhO3tWWgdcVpG7K20bIfMsqf2em493PbFU0RukAi4hmSknGZVHJ0ejJ2I8d4CFl1PiISS0UQFnQaNLMLDgkjVa5G1MECIH7JEn6aXKmQ2HbmUl+SvnP5LGUuLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a45nVHVe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a45nVHVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728633896; x=1760169896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dTN8hMoDEwuDuC6o7FbLye3wkfriMZqTE3K8Yy5nY6U=;
  b=a45nVHVeNVYXzcgOwpA03VCm4nylr7jKNArd5ufgBSk5y7N4kyUt3d6F
   pl90bI3K53dNX8AcBwM4GPw1b9VJ3UYWI4IYWYYF2Ei9/o+IRq/2tTQ/E
   pcqeqcjbAsLAVlTdWH/sEY2ejIhwRDJXCYVg5MACRxMYE1XpTnHWb2q0g
   Ej7QKkLKsMCTzbmvNV2cLIZBpyIOEEF6cFYnFp2A84mSI5ZqmMxKXi+fh
   oUQpu/eUjnew0twwgRbq9Al3jlXmJeXjW9a2eOB+jPBZ38Yiy+jeH+7rD
   327agTbDPe0My005oNtBV1GXZU8/hGAPhXiECGJuTL+2A3HQmBNfMgzY/
   w==;
X-CSE-ConnectionGUID: s68H6w5tSziYxZd9BI5EkA==
X-CSE-MsgGUID: F2dATKwXQBGb0iSHfT2Mhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="30899097"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="30899097"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:04:55 -0700
X-CSE-ConnectionGUID: WPZuiKPMRu6TbsWHpLbiyw==
X-CSE-MsgGUID: R6qhWOiEQnagD03ySdJmYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81829177"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2024 01:04:52 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2] perf x86/topdown: Make topdown metrics comparators be symmetric
Date: Fri, 11 Oct 2024 11:02:06 +0000
Message-Id: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit "3b5edc0421e2 (perf x86/topdown: Don't move topdown metric
 events in group)" modifies topdown metrics comparator to move topdown
metrics events which are not in same group with previous event. But it
just modifies the 2nd comparator and causes the comparators become
asymmetric.

Thus modify the 1st topdown metrics comparator and make the two
comparators be symmetric, and refine the comments as well.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 438e4639fa89..447a734e591c 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -52,7 +52,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	 *          3,015,058      cycles
 	 *    <not supported>      topdown-retiring
 	 *
-	 * if slots event and topdown metrics events are in two groups, the group which
+	 * If slots event and topdown metrics events are in two groups, the group which
 	 * has topdown metrics events must contain only the topdown metrics event,
 	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
 	 *
@@ -69,13 +69,16 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 			return -1;
 		if (arch_is_topdown_slots(rhs))
 			return 1;
-		/* Followed by topdown events. */
-		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
-			return -1;
+
 		/*
-		 * Move topdown events forward only when topdown events
-		 * are not in same group with previous event.
+		 * Move topdown metrics events forward only when topdown metrics
+		 * events are not in same group with previous slots event. If
+		 * topdown metrics events are already in same group with slots
+		 * event, do nothing.
 		 */
+		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
+		    lhs->core.leader != rhs->core.leader)
+			return -1;
 		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
 		    lhs->core.leader != rhs->core.leader)
 			return 1;

base-commit: 57fb40d40f9543213ffadb04d07cfb2ba46edc26
-- 
2.40.1

