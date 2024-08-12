Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B019307D;
	Mon, 12 Aug 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491889; cv=none; b=jlFEWEkf5YQOZS4mDngsD65FCyMtSOPYX9wyUCC24a1ngTFcvewM3AmKyTwpXWTPl7oWt0NhJfvElNvq8efmQ3Axpc8MNZCFK4jVde+VYXTVwfygndwW722dMetWtDJsa5vbGQI3SM9AMfE7zEJwsSL4yIxfz/3wbbNjhFBUmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491889; c=relaxed/simple;
	bh=3WU1qCwUzfXdnhH/+P803xMWStHIejlFVKP55ZuK+/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT7/5ETIDOvMWr+wRm6VIyZudCyI8ucryb6cH1S3gAOMbh1lfS36dkitJcyHS2fQ7J0VO2xkDPW0iJ96ybu3glF+o6D5VY3/L0ozPJ1vEcXdWSHgSJ9q85lF5jZaAk87Fycj53SLw4qAIeJEEMlMeduaQMULNjkUU1Ud16ufXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K25wMMzR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K25wMMzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3F9C4AF0E;
	Mon, 12 Aug 2024 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723491889;
	bh=3WU1qCwUzfXdnhH/+P803xMWStHIejlFVKP55ZuK+/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K25wMMzRXOpv/VjOkm3HZH14fZrB+VcZPLtRNwfdjQ1S/4TfCVlzaU5ZdMP6VrCi9
	 Jj2cUF6aCZ0O6DmFsZoNY1h6PX8lX2QmJWo1eklWvNQPKx85gUdcaNbFErEt+9HEDc
	 nlFDBUflkf1fJegKf5y02YEW/Guhim+KHz05OXKrrB8fsCNvNsLK5C6VjdvJRIBRAN
	 67Q8maQa2UuVC3YGczAdv5mpLOLIGvlSKlyQ7KtDt7+ZjR3zNCJuxEFxBRNGOFeP1K
	 84bR4re07K6TatDsFY/2YiYdE4ZzV9qboNJI/RSjcigR+rhMouLXKKlAAYtolXloBc
	 OpBf8/medvr6g==
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
Subject: [PATCH 2/3] perf annotate-data: Implement folding in TUI browser
Date: Mon, 12 Aug 2024 12:44:46 -0700
Message-ID: <20240812194447.2049187-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240812194447.2049187-1-namhyung@kernel.org>
References: <20240812194447.2049187-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like perf report, use 'e' or 'E' key to toggle folding the current entry
so that it can control displaying child entries.

Note I didn't add the 'c' and 'C' key to collapse the entry because it's
also handled with the 'e'/'E' since it toggles the state.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 98 ++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index 04c73b67cd6c..a5c5ad63425e 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -18,12 +18,6 @@
 #define UNFOLD_SIGN  '-'
 #define NOCHLD_SIGN  ' '
 
-struct annotated_data_browser {
-	struct ui_browser b;
-	struct list_head entries;
-	int nr_events;
-};
-
 struct browser_entry {
 	struct list_head node;
 	struct annotated_member *data;
@@ -35,6 +29,13 @@ struct browser_entry {
 	bool folded;  /* only can be false when it has children */
 };
 
+struct annotated_data_browser {
+	struct ui_browser b;
+	struct list_head entries;
+	struct browser_entry *curr;
+	int nr_events;
+};
+
 static struct annotated_data_browser *get_browser(struct ui_browser *uib)
 {
 	return container_of(uib, struct annotated_data_browser, b);
@@ -302,6 +303,7 @@ static void browser__seek(struct ui_browser *uib, off_t offset, int whence)
 
 static unsigned int browser__refresh(struct ui_browser *uib)
 {
+	struct annotated_data_browser *browser = get_browser(uib);
 	struct browser_entry *entry, *next;
 	int row = 0;
 
@@ -314,6 +316,8 @@ static unsigned int browser__refresh(struct ui_browser *uib)
 		if (!uib->filter || !uib->filter(uib, &entry->node)) {
 			ui_browser__gotorc(uib, row, 0);
 			uib->write(uib, entry, row);
+			if (uib->top_idx + row == uib->index)
+				browser->curr = entry;
 			if (++row == uib->rows)
 				break;
 		}
@@ -438,6 +442,78 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 	ui_browser__write_nstring(uib, "", uib->width);
 }
 
+static void annotated_data_browser__fold(struct annotated_data_browser *browser,
+					 struct browser_entry *entry,
+					 bool recursive)
+{
+	struct browser_entry *child;
+
+	if (list_empty(&entry->children))
+		return;
+	if (entry->folded && !recursive)
+		return;
+
+	if (recursive) {
+		list_for_each_entry(child, &entry->children, node)
+			annotated_data_browser__fold(browser, child, true);
+	}
+
+	entry->nr_entries = 1;
+	entry->folded = true;
+}
+
+static void annotated_data_browser__unfold(struct annotated_data_browser *browser,
+					   struct browser_entry *entry,
+					   bool recursive)
+{
+	struct browser_entry *child;
+	int nr_entries;
+
+	if (list_empty(&entry->children))
+		return;
+	if (!entry->folded && !recursive)
+		return;
+
+	nr_entries = 1; /* for self */
+	list_for_each_entry(child, &entry->children, node) {
+		if (recursive)
+			annotated_data_browser__unfold(browser, child, true);
+
+		nr_entries += child->nr_entries;
+	}
+
+	entry->nr_entries = nr_entries;
+	entry->folded = false;
+}
+
+static void annotated_data_browser__toggle_fold(struct annotated_data_browser *browser,
+						bool recursive)
+{
+	struct browser_entry *curr = browser->curr;
+	struct browser_entry *parent;
+
+	parent = curr->parent;
+	while (parent) {
+		parent->nr_entries -= curr->nr_entries;
+		parent = parent->parent;
+	}
+	browser->b.nr_entries -= curr->nr_entries;
+
+	if (curr->folded)
+		annotated_data_browser__unfold(browser, curr, recursive);
+	else
+		annotated_data_browser__fold(browser, curr, recursive);
+
+	parent = curr->parent;
+	while (parent) {
+		parent->nr_entries += curr->nr_entries;
+		parent = parent->parent;
+	}
+	browser->b.nr_entries += curr->nr_entries;
+
+	assert(browser->b.nr_entries == count_visible_entries(browser));
+}
+
 static int annotated_data_browser__run(struct annotated_data_browser *browser,
 				       struct evsel *evsel __maybe_unused,
 				       struct hist_browser_timer *hbt)
@@ -462,8 +538,18 @@ static int annotated_data_browser__run(struct annotated_data_browser *browser,
 		"UP/DOWN/PGUP\n"
 		"PGDN/SPACE    Navigate\n"
 		"</>           Move to prev/next symbol\n"
+		"e             Expand/Collapse current entry\n"
+		"E             Expand/Collapse all children of the current\n"
 		"q/ESC/CTRL+C  Exit\n\n");
 			continue;
+		case 'e':
+			annotated_data_browser__toggle_fold(browser,
+							    /*recursive=*/false);
+			break;
+		case 'E':
+			annotated_data_browser__toggle_fold(browser,
+							    /*recursive=*/true);
+			break;
 		case K_LEFT:
 		case '<':
 		case '>':
-- 
2.46.0.76.ge559c4bf1a-goog

