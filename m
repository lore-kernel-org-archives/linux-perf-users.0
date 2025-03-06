Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF41E7C20;
	Thu,  6 Mar 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247509; cv=none; b=eO+N1CbE1WrtZng3/yP0iVFLM0qZLoY7D/psIx2+/1odB+JWJ+oOFUirRJT5K6IxOXnjsyysBMkX5zrn3AMJhAoRSFssih0+PYI32EL3hh8VfSlWRqNce398yOrpvzv29KWOnNtiO5zWLDXOMlXcIsksKPlLFA6WuLa/NTtt8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247509; c=relaxed/simple;
	bh=o7rw6NP46HIH4ntSfSRtnBPyLGmycBEJ6xC1MY+6+80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDamIeWl8JbKqp4GvJ2vhuDqgG+cxdWfkxmVpIR1MS5HNyaxknKQ7WYR3kiAHIJqfY5B1jUmtWnqkDg4RGtpcftYiH7NlPHxzhkQfUe+RQOcxECJapaVv5ge33KQjQVypuHdFg+wleZe6eu/ulv8Bq912nU2KHM1JlvrYCNpQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9bFIrWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9bFIrWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124B3C4CEE9;
	Thu,  6 Mar 2025 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741247508;
	bh=o7rw6NP46HIH4ntSfSRtnBPyLGmycBEJ6xC1MY+6+80=;
	h=From:To:Cc:Subject:Date:From;
	b=b9bFIrWHvWZtZRt5+zDUxU3nrGCJ8Gdop5H0dfkblY1EHMTjZ7XxXBdAHda1rz3Qg
	 PO+jIpNGWqtD0KSIRwXPVI3MacZSXNW0kC5d5GTnxJyArHXzmeQqoEz4WrpZQaOWSv
	 gYuXFVroe0watB7HzL7dlvlBoTh2VGo4M25k0OiIsjUqMHx7GxYlq1um4JIm2T16jL
	 dwZG1JEBLv3f2f/DPXEw2tbKvnC84DggWYNeQ7sAmna/tawI9aECsPf+yALnyBn38D
	 1AAEjaBADNT7DK/cPcZdlVFR98YUcH3lguJJ1fzrswHD6EuQNwzYHOje4ORdctq5J1
	 CPynTvo6yhC0A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf report: Use map_symbol__copy() when copying callchians
Date: Wed,  5 Mar 2025 23:51:46 -0800
Message-ID: <20250306075147.195435-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems there are places to miss updating refcount of maps.
Let's use map_symbol__copy() helper to properly copy them with
refcounts updated.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/callchain.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0c7564747a14e539..4fe7a10de33b6de8 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -590,8 +590,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		}
 		call->ip = cursor_node->ip;
 		call->ms = cursor_node->ms;
-		call->ms.map = map__get(call->ms.map);
-		call->ms.maps = maps__get(call->ms.maps);
+		map_symbol__copy(&call->ms, &cursor_node->ms);
 		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
@@ -1094,9 +1093,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 
 	node->ip = ip;
 	map_symbol__exit(&node->ms);
-	node->ms = *ms;
-	node->ms.maps = maps__get(ms->maps);
-	node->ms.map = map__get(ms->map);
+	map_symbol__copy(&node->ms, ms);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->iter_cycles = iter_cycles;
@@ -1564,7 +1561,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 				goto out;
 			*new = *chain;
 			new->has_children = false;
-			new->ms.map = map__get(new->ms.map);
+			map_symbol__copy(&new->ms, &chain->ms);
 			list_add_tail(&new->list, &head);
 		}
 		parent = parent->parent;
-- 
2.48.1.711.g2feabab25a-goog

