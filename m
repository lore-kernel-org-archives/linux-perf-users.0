Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AF3AA507;
	Sat,  6 Jun 2026 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776406; cv=none; b=bLs2XOUp+Fvy8y3ZS7Mm9n8E05BBRbPE8Z8EYzA88UzG+y4F9utkfBEonhByg9WMM5EkQysKUByPIgC2a9Pv2F8jPFCzWcb/3O6JGSyrZ9AqCEI3YYKE4G84P8vw2m97azPjTOstVaDNwRJpt8tgzKUowfVT2u70ft0UVokvgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776406; c=relaxed/simple;
	bh=tpRn58mPXbibn/1mD53zsa5k6gm4YmIkOr3rpaeI80s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2U1NYUhD0Rctxdubww+kSi4/ak9jfgi53tnMHLwmKM0y80B+/XHsaAc9ADH70KG/XH3tx76k7IqinYHn24B1wk/QmCAVs4pT1VZrNe6JK/3wJ6f8m2JAMu1Td0HINM03M/xh2xA1oDOtoRTho92SBr4Wznwy0swhPhirY7vc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWjNa9yW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWjNa9yW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770BB1F00893;
	Sat,  6 Jun 2026 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776405;
	bh=1tjL0WkxtgQSVt50jRLm7IWs5CaKopZAj1RIXm99+yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWjNa9yWYpkKJgT5e3ENYpNpeOTHQBZ1KVAhT9hXoi32K6s2BF2AuaBxHw/UKclmP
	 ZerGxcxk/6MNjmDSCD845bkPRIQFScBD6LRNExJJQhkx3tLAipd5zEMeLf4J6vQzqU
	 vZ5Ym8KfYU9ZA7hBJpL2WOHS3iTSTGK8fdHkQmlVmGL+w2hA/Q12u6LXsHgYRd503f
	 zatHo65AAe4/D/dF5/l+IaffiZYxo8yKiosRF68oQbR7yVer7PsyQlIwjP10jDamnR
	 YaUO87agaWCJ7KqSvMiQLuGP5Vx5NFRphB/AgFGIee3FazF7bPWkTz11RNE4Z/pJlQ
	 fD4n7R7zAw7zw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 6/7] perf sched: Free callchain nodes in idle thread cleanup
Date: Sat,  6 Jun 2026 17:05:58 -0300
Message-ID: <20260606200601.1861227-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

free_idle_threads() relies on the thread priv destructor (free()) to
clean up idle_thread_runtime structs.  But free() doesn't walk the
callchain_cursor linked list or the callchain_root tree allocated
by callchain_cursor__copy() and callchain_append() during --idle-hist
processing.  Every idle thread with callchain data leaks these nodes.

Introduce callchain_cursor_cleanup() to free the cursor's linked list
of callchain_cursor_node entries, and call it together with
free_callchain() in free_idle_threads() before thread__put().

Fixes: 225b24f569980ac9 ("perf sched timehist: Save callchain when entering idle")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c  |  5 ++++-
 tools/perf/util/callchain.c | 15 +++++++++++++++
 tools/perf/util/callchain.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b7ccdc6a985d1c7b..1ff01f03d2ad1ad3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2500,8 +2500,11 @@ static void free_idle_threads(void)
 			struct idle_thread_runtime *itr;
 
 			itr = thread__priv(idle);
-			if (itr)
+			if (itr) {
 				thread__put(itr->last_thread);
+				free_callchain(&itr->callchain);
+				callchain_cursor_cleanup(&itr->cursor);
+			}
 
 			thread__put(idle);
 		}
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8981ae879ebb887c..31c675cbab63187b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1578,6 +1578,21 @@ void free_callchain(struct callchain_root *root)
 	free_callchain_node(&root->node);
 }
 
+void callchain_cursor_cleanup(struct callchain_cursor *cursor)
+{
+	struct callchain_cursor_node *node, *next;
+
+	callchain_cursor_reset(cursor);
+
+	for (node = cursor->first; node; node = next) {
+		next = node->next;
+		free(node);
+	}
+	cursor->first = NULL;
+	cursor->last = &cursor->first;
+	cursor->curr = NULL;
+}
+
 static u64 decay_callchain_node(struct callchain_node *node)
 {
 	struct callchain_node *child;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 0eb5d7a1a41d81e1..8b1e405d1cdf4660 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -286,6 +286,7 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 					FILE *fp, char *bf, int bfsize);
 
 void free_callchain(struct callchain_root *root);
+void callchain_cursor_cleanup(struct callchain_cursor *cursor);
 void decay_callchain(struct callchain_root *root);
 int callchain_node__make_parent_list(struct callchain_node *node);
 
-- 
2.54.0

