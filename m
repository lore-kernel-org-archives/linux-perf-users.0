Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE161A932;
	Sun,  6 Oct 2024 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728177744; cv=none; b=ISlkmNX0BryRu0u3ahRqNzZw0oYSxgDkuIi2Rz2LpIkrYX6PyVILpGYXAlq7MwSOP7GZDw5YOLqPm67IYMkekHGHNJygSuWE9k+cq07Nu26eYA55GxpXl/gz4re6q0Z41GAZp+J8evXyPpVXLndDn0RQjIFoP2o/xI9szG4+fm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728177744; c=relaxed/simple;
	bh=gQMm9AkLwf2L6HRLj1OwQP+An2MMteBTn0/2c25qQLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/FJ+G4eWvpkJOpDbei0eHk9oJJxDtTLSJyTDxz2gnfK/IhNwH8UK19it6bV47KZ9+onxrUrGPLTlV1UiNhazuocIGTs2c0Nc/JRMbO+ENjuQ3JvJ/tVzFxgl665koSrHDsR+lrbviRTj1qwvmStqudU0RLNLCDpGVEYi2CtDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CsWIlDQq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CsWIlDQq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Pqh8codxrX22SToFGaI1BL/8kRezKW4jx+SJzOiKeVw=; b=CsWIlDQqKcpXAGHS
	9Ph4jTyh0b281KXLZ0AQ/5Zec2s3kGWFYw4XUce1EyJm0U68V6UeLOcwpPNYOi9TzQ2KwEscXvsT5
	VklS37S8D9OIUOdrS1nHiL/Ew64lk7gZFs5gezIMOXj0geAlcGEqpyx9MvzV0cJRnkb2bjMJDzB0K
	HgZZb0WSLQrUz8rVfKB1mUfx8cj4yT4AiG54yTEnJ1HvkRridJh1qT7j9GG4y7oXmMn3heEfFZSPZ
	oMi9DRNUdXLaeXWytJpSGnVgKotIu449ev8TRbUg4YBDiXbYadvqgSEaPtGV7y/j/2EBGR1lPMkw3
	VFEQPvv8QoVSmwNHdw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxFyH-009Dy6-1P;
	Sun, 06 Oct 2024 01:22:05 +0000
From: linux@treblig.org
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf callchain: Remove unused callchain_branch_counts
Date: Sun,  6 Oct 2024 02:22:04 +0100
Message-ID: <20241006012204.373803-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

callchain_branch_counts() was added in 2016 by commit
3dd029ef9401 ("perf report: Calculate and return the branch flag counting")
but unused.

Remove it and it's helpers.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/callchain.c | 71 -------------------------------------
 tools/perf/util/callchain.h |  4 ---
 2 files changed, 75 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0c7564747a14..11435b72afbe 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1266,77 +1266,6 @@ int callchain_node__fprintf_value(struct callchain_node *node,
 	return 0;
 }
 
-static void callchain_counts_value(struct callchain_node *node,
-				   u64 *branch_count, u64 *predicted_count,
-				   u64 *abort_count, u64 *cycles_count)
-{
-	struct callchain_list *clist;
-
-	list_for_each_entry(clist, &node->val, list) {
-		if (branch_count)
-			*branch_count += clist->branch_count;
-
-		if (predicted_count)
-			*predicted_count += clist->predicted_count;
-
-		if (abort_count)
-			*abort_count += clist->abort_count;
-
-		if (cycles_count)
-			*cycles_count += clist->cycles_count;
-	}
-}
-
-static int callchain_node_branch_counts_cumul(struct callchain_node *node,
-					      u64 *branch_count,
-					      u64 *predicted_count,
-					      u64 *abort_count,
-					      u64 *cycles_count)
-{
-	struct callchain_node *child;
-	struct rb_node *n;
-
-	n = rb_first(&node->rb_root_in);
-	while (n) {
-		child = rb_entry(n, struct callchain_node, rb_node_in);
-		n = rb_next(n);
-
-		callchain_node_branch_counts_cumul(child, branch_count,
-						   predicted_count,
-						   abort_count,
-						   cycles_count);
-
-		callchain_counts_value(child, branch_count,
-				       predicted_count, abort_count,
-				       cycles_count);
-	}
-
-	return 0;
-}
-
-int callchain_branch_counts(struct callchain_root *root,
-			    u64 *branch_count, u64 *predicted_count,
-			    u64 *abort_count, u64 *cycles_count)
-{
-	if (branch_count)
-		*branch_count = 0;
-
-	if (predicted_count)
-		*predicted_count = 0;
-
-	if (abort_count)
-		*abort_count = 0;
-
-	if (cycles_count)
-		*cycles_count = 0;
-
-	return callchain_node_branch_counts_cumul(&root->node,
-						  branch_count,
-						  predicted_count,
-						  abort_count,
-						  cycles_count);
-}
-
 static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
 {
 	return scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86ed9e4d04f9..d7741fa9e9de 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -298,10 +298,6 @@ void free_callchain(struct callchain_root *root);
 void decay_callchain(struct callchain_root *root);
 int callchain_node__make_parent_list(struct callchain_node *node);
 
-int callchain_branch_counts(struct callchain_root *root,
-			    u64 *branch_count, u64 *predicted_count,
-			    u64 *abort_count, u64 *cycles_count);
-
 void callchain_param_setup(u64 sample_type, const char *arch);
 
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
-- 
2.46.2

