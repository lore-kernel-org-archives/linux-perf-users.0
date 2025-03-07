Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B6194C77;
	Fri,  7 Mar 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327972; cv=none; b=lxqmURAUrjayXBP0ShqF/J6t5HhfcHI16xecnsrlWvQM9cEEnMJjgvkUiAanZXjsymrLQbQY6+K5Fe4eeiCwAVJF4vvclBze09fglskzKz6dvk6f9uGehV/cZbni3E8/en7pykALDczLaB0uH5f6WRyBxBDkk2CFSjjiRjb8lcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327972; c=relaxed/simple;
	bh=UAAlQ2J9rJ/vo3jglWH34QsSvJE058rIE/hLwEOpQZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dwvp0gJ3X7fLJfyETUyHDpAOdUB57RRu9ECRXt26ost14mtO5d0o25EKHC1Z+a8Djy5+oZnH3AlPIloAmMQ4MBMPgREyC4f8w/5olbbJw77pLFDm33PO/sUfmcn+Q8UUMeG9EO2fHhoM5Xm3Wvojq/h9FuNTW1iYFXh/5BRiWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM6Vxpo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM6Vxpo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F06C4CED1;
	Fri,  7 Mar 2025 06:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741327971;
	bh=UAAlQ2J9rJ/vo3jglWH34QsSvJE058rIE/hLwEOpQZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=LM6Vxpo6U7JW2ZfubEuxeKdurwV1pClrztLZaOokAHTMyu/qwKQr/oi21OS7OYKyJ
	 KtO3kDWqcfpC9ZMjbXBhtMnWX8QyXtYR2yqHCruOtXN2AJr/Cr5qci+Xd7Y0vKufUU
	 cg2VvUK1J4k7rEyA2qcrzD4Prz+Q5iS5ZH19Pm+AI67B05sKY/kYhE5CCdyvBivg6g
	 Oap7HJEFMaBnbz78Abnru7Y21g5+c6Xa6hhEYzdcMUZXKlNx9AtfGRPJg/YTx0YZ8y
	 ycnSpTWSt0MjdSmFnRL/NuxGeDToqAYzcV6NxirGjgs7VudD8Kb3TNov0HFd98Vsh6
	 KBYmSOnJKn9XA==
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
Subject: [PATCH v2 1/2] perf report: Use map_symbol__copy() when copying callchians
Date: Thu,  6 Mar 2025 22:12:49 -0800
Message-ID: <20250307061250.320849-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
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
 tools/perf/util/callchain.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0c7564747a14e539..d7b7eef740b9d6ed 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -589,9 +589,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 			return -ENOMEM;
 		}
 		call->ip = cursor_node->ip;
-		call->ms = cursor_node->ms;
-		call->ms.map = map__get(call->ms.map);
-		call->ms.maps = maps__get(call->ms.maps);
+		map_symbol__copy(&call->ms, &cursor_node->ms);
 		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
@@ -1094,9 +1092,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 
 	node->ip = ip;
 	map_symbol__exit(&node->ms);
-	node->ms = *ms;
-	node->ms.maps = maps__get(ms->maps);
-	node->ms.map = map__get(ms->map);
+	map_symbol__copy(&node->ms, ms);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->iter_cycles = iter_cycles;
@@ -1564,7 +1560,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 				goto out;
 			*new = *chain;
 			new->has_children = false;
-			new->ms.map = map__get(new->ms.map);
+			map_symbol__copy(&new->ms, &chain->ms);
 			list_add_tail(&new->list, &head);
 		}
 		parent = parent->parent;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

