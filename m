Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB6192B94;
	Mon, 12 Aug 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491889; cv=none; b=Ku41FGlZYafXhieS2q9JbknU4BemvhzfjG+Fdl78+3ocCcwZlurVH+Cl80X0+QAvpXBedWO+Tnu2K0QYxalJdo3jsqRCCKAbaQ17+P89RA4abisnM8r202xnVN1BTzqWSclLDCypAk5KUQfiYHeeGljde+gU0Q3IzG4XYi2rk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491889; c=relaxed/simple;
	bh=xmrmBEbnMGh2CK5MqpiPZ5Obe+6ba9uMuv9hj+CH/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYMv+YZtBglNsP1ecJ+Y1TdFEj4J3rJIpbYBFdAIab2CHEi1yh6C6SBkO8l3chMMlQZ+0+X3K19zng3340GtnMwUFxP7eKBJph5ylNXoqmLBG7ThfIA0WENW2k+ldkvCSXKNZ8GySfpIFuPXsA33Xbrr+yhErkyng4AB5UDAJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRZHNV46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRZHNV46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D742C4AF0D;
	Mon, 12 Aug 2024 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723491889;
	bh=xmrmBEbnMGh2CK5MqpiPZ5Obe+6ba9uMuv9hj+CH/+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRZHNV46z4zVR1GFmyL2QtxVOlu0p14cy/11aTBYy1g85bu9nmfeY6hJwv2Avt1Dp
	 Cv3n3Bw/PTvTkLVWe+Ep4wKcv31fQXv4bqgFmwXd5gZcX+2qvf3EExkEEZHqOCwtnW
	 cZYNNjr0CEYxgRq7uEpDyE7H5ErtETJayplZO9zQFQejHnAqF5VCHwLnLETtFqJvLk
	 6GAND14uDpAA2RXZ8tGN4pnc8DUFlEZs4wK+jJzCvaS/jRVhVKNIaj69tpY2anrzIO
	 rc0YXbXE0U6I+2Lo1KiKGdv4aNmo/ZZ83hiPcLQjDiVnI7Jrn/NcWnNBEAbMXIRyHU
	 as+aAjSFqJ7vA==
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
Subject: [PATCH 1/3] perf annotate-data: Support folding in TUI browser
Date: Mon, 12 Aug 2024 12:44:45 -0700
Message-ID: <20240812194447.2049187-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240812194447.2049187-1-namhyung@kernel.org>
References: <20240812194447.2049187-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like in the hists browser, it should support folding current entry so
that it can hide unwanted details in some data structures.  The folded
entries will be displayed with '+' sign, while unfolded entries will
have '-' sign.  Entries have no children will not show any signs.

  Annotate type: 'struct socket' (1 samples)
        Percent     Offset       Size  Field
  -      100.00          0        128  struct socket {                                  ◆
           0.00          0          4      socket_state   state;                        ▒
           0.00          4          2      short int      type;                         ▒
           0.00          8          8      long unsigned int      flags;                ▒
           0.00         16          8      struct file*   file;                         ▒
         100.00         24          8      struct sock*   sk;                           ▒
           0.00         32          8      struct proto_ops*      ops;                  ▒
  -        0.00         64         64      struct socket_wq       wq {                  ▒
  -        0.00         64         24          wait_queue_head_t  wait {                ▒
  +        0.00         64          4              spinlock_t     lock;                 ▒
  -        0.00         72         16              struct list_head       head {        ▒
           0.00         72          8                  struct list_head*  next;         ▒
           0.00         80          8                  struct list_head*  prev;         ▒
                                                   };                                   ▒
                                               };                                       ▒
           0.00         88          8          struct fasync_struct*      fasync_list;  ▒
           0.00         96          8          long unsigned int  flags;                ▒
  +        0.00        104         16          struct callback_head       rcu;          ▒
                                           };                                           ▒
                                       };                                               ▒

This just adds the display logic for folding, actually folding action
will be implemented in the next patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 235 ++++++++++++++++++++++---
 1 file changed, 212 insertions(+), 23 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index a937b55da736..04c73b67cd6c 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -14,6 +14,10 @@
 #include "util/evlist.h"
 #include "util/sort.h"
 
+#define FOLDED_SIGN  '+'
+#define UNFOLD_SIGN  '-'
+#define NOCHLD_SIGN  ' '
+
 struct annotated_data_browser {
 	struct ui_browser b;
 	struct list_head entries;
@@ -24,7 +28,11 @@ struct browser_entry {
 	struct list_head node;
 	struct annotated_member *data;
 	struct type_hist_entry *hists;
-	int indent;
+	struct browser_entry *parent;
+	struct list_head children;
+	int indent;  /*indentation level, starts from 0 */
+	int nr_entries; /* # of visible entries: self + descendents */
+	bool folded;  /* only can be false when it has children */
 };
 
 static struct annotated_data_browser *get_browser(struct ui_browser *uib)
@@ -65,13 +73,14 @@ static int get_member_overhead(struct annotated_data_type *adt,
 }
 
 static int add_child_entries(struct annotated_data_browser *browser,
+			     struct browser_entry *parent,
 			     struct annotated_data_type *adt,
 			     struct annotated_member *member,
 			     struct evsel *evsel, int indent)
 {
 	struct annotated_member *pos;
 	struct browser_entry *entry;
-	int nr_entries = 0;
+	struct list_head *parent_list;
 
 	entry = zalloc(sizeof(*entry));
 	if (entry == NULL)
@@ -84,36 +93,60 @@ static int add_child_entries(struct annotated_data_browser *browser,
 	}
 
 	entry->data = member;
+	entry->parent = parent;
 	entry->indent = indent;
 	if (get_member_overhead(adt, entry, evsel) < 0) {
 		free(entry);
 		return -1;
 	}
 
-	list_add_tail(&entry->node, &browser->entries);
-	nr_entries++;
+	INIT_LIST_HEAD(&entry->children);
+	if (parent)
+		parent_list = &parent->children;
+	else
+		parent_list = &browser->entries;
 
-	list_for_each_entry(pos, &member->children, node) {
-		int nr = add_child_entries(browser, adt, pos, evsel, indent + 1);
+	list_add_tail(&entry->node, parent_list);
 
+	list_for_each_entry(pos, &member->children, node) {
+		int nr = add_child_entries(browser, entry, adt, pos, evsel,
+					   indent + 1);
 		if (nr < 0)
 			return nr;
-
-		nr_entries += nr;
 	}
 
 	/* add an entry for the closing bracket ("}") */
 	if (!list_empty(&member->children)) {
-		entry = zalloc(sizeof(*entry));
-		if (entry == NULL)
+		struct browser_entry *bracket;
+
+		bracket = zalloc(sizeof(*bracket));
+		if (bracket == NULL)
 			return -1;
 
-		entry->indent = indent;
-		list_add_tail(&entry->node, &browser->entries);
-		nr_entries++;
+		bracket->indent = indent;
+		bracket->parent = entry;
+		bracket->folded = true;
+		bracket->nr_entries = 1;
+
+		INIT_LIST_HEAD(&bracket->children);
+		list_add_tail(&bracket->node, &entry->children);
 	}
 
-	return nr_entries;
+	/* fold child entries by default */
+	entry->folded = true;
+	entry->nr_entries = 1;
+	return 0;
+}
+
+static u32 count_visible_entries(struct annotated_data_browser *browser)
+{
+	int nr = 0;
+	struct browser_entry *entry;
+
+	list_for_each_entry(entry, &browser->entries, node)
+		nr += entry->nr_entries;
+
+	return nr;
 }
 
 static int annotated_data_browser__collect_entries(struct annotated_data_browser *browser)
@@ -123,9 +156,12 @@ static int annotated_data_browser__collect_entries(struct annotated_data_browser
 	struct evsel *evsel = hists_to_evsel(he->hists);
 
 	INIT_LIST_HEAD(&browser->entries);
+
+	add_child_entries(browser, /*parent=*/NULL, adt, &adt->self, evsel,
+			  /*indent=*/0);
+
 	browser->b.entries = &browser->entries;
-	browser->b.nr_entries = add_child_entries(browser, adt, &adt->self,
-						  evsel, /*indent=*/0);
+	browser->b.nr_entries = count_visible_entries(browser);
 	return 0;
 }
 
@@ -140,9 +176,155 @@ static void annotated_data_browser__delete_entries(struct annotated_data_browser
 	}
 }
 
+static struct browser_entry *get_first_child(struct browser_entry *entry)
+{
+	if (list_empty(&entry->children))
+		return NULL;
+
+	return list_first_entry(&entry->children, struct browser_entry, node);
+}
+
+static struct browser_entry *get_last_child(struct browser_entry *entry)
+{
+	if (list_empty(&entry->children))
+		return NULL;
+
+	return list_last_entry(&entry->children, struct browser_entry, node);
+}
+
+static bool is_first_child(struct browser_entry *entry)
+{
+	/* This will be checked in a different way */
+	if (entry->parent == NULL)
+		return false;
+
+	return get_first_child(entry->parent) == entry;
+}
+
+static bool is_last_child(struct browser_entry *entry)
+{
+	/* This will be checked in a different way */
+	if (entry->parent == NULL)
+		return false;
+
+	return get_last_child(entry->parent) == entry;
+}
+
+static struct browser_entry *browser__prev_entry(struct ui_browser *uib,
+						 struct browser_entry *entry)
+{
+	struct annotated_data_browser *browser = get_browser(uib);
+	struct browser_entry *first;
+
+	first = list_first_entry(&browser->entries, struct browser_entry, node);
+
+	while (entry != first) {
+		if (is_first_child(entry))
+			entry = entry->parent;
+		else {
+			entry = list_prev_entry(entry, node);
+			while (!entry->folded)
+				entry = get_last_child(entry);
+		}
+
+		if (!uib->filter || !uib->filter(uib, &entry->node))
+			return entry;
+	}
+	return first;
+}
+
+static struct browser_entry *browser__next_entry(struct ui_browser *uib,
+						 struct browser_entry *entry)
+{
+	struct annotated_data_browser *browser = get_browser(uib);
+	struct browser_entry *last;
+
+	last = list_last_entry(&browser->entries, struct browser_entry, node);
+	while (!last->folded)
+		last = get_last_child(last);
+
+	while (entry != last) {
+		if (!entry->folded)
+			entry = get_first_child(entry);
+		else {
+			while (is_last_child(entry))
+				entry = entry->parent;
+
+			entry = list_next_entry(entry, node);
+		}
+
+		if (!uib->filter || !uib->filter(uib, &entry->node))
+			return entry;
+	}
+	return last;
+}
+
+static void browser__seek(struct ui_browser *uib, off_t offset, int whence)
+{
+	struct annotated_data_browser *browser = get_browser(uib);
+	struct browser_entry *entry;
+
+	if (uib->nr_entries == 0)
+		return;
+
+	switch (whence) {
+	case SEEK_SET:
+		entry = list_first_entry(&browser->entries, typeof(*entry), node);
+		if (uib->filter && uib->filter(uib, &entry->node))
+			entry = browser__next_entry(uib, entry);
+		break;
+	case SEEK_CUR:
+		entry = list_entry(uib->top, typeof(*entry), node);
+		break;
+	case SEEK_END:
+		entry = list_last_entry(&browser->entries, typeof(*entry), node);
+		while (!entry->folded)
+			entry = get_last_child(entry);
+		if (uib->filter && uib->filter(uib, &entry->node))
+			entry = browser__prev_entry(uib, entry);
+		break;
+	default:
+		return;
+	}
+
+	assert(entry != NULL);
+
+	if (offset > 0) {
+		while (offset-- != 0)
+			entry = browser__next_entry(uib, entry);
+	} else {
+		while (offset++ != 0)
+			entry = browser__prev_entry(uib, entry);
+	}
+
+	uib->top = &entry->node;
+}
+
 static unsigned int browser__refresh(struct ui_browser *uib)
 {
-	return ui_browser__list_head_refresh(uib);
+	struct browser_entry *entry, *next;
+	int row = 0;
+
+	if (uib->top == NULL || uib->top == uib->entries)
+		browser__seek(uib, SEEK_SET, 0);
+
+	entry = list_entry(uib->top, typeof(*entry), node);
+
+	while (true) {
+		if (!uib->filter || !uib->filter(uib, &entry->node)) {
+			ui_browser__gotorc(uib, row, 0);
+			uib->write(uib, entry, row);
+			if (++row == uib->rows)
+				break;
+		}
+		next = browser__next_entry(uib, entry);
+		if (next == entry)
+			break;
+
+		entry = next;
+	}
+
+	return row;
 }
 
 static int browser__show(struct ui_browser *uib)
@@ -171,7 +353,7 @@ static int browser__show(struct ui_browser *uib)
 		strcpy(title, "Percent");
 
 	ui_browser__printf(uib, "%*s %10s %10s %10s  %s",
-			   11 * (browser->nr_events - 1), "",
+			   2 + 11 * (browser->nr_events - 1), "",
 			   title, "Offset", "Size", "Field");
 	ui_browser__write_nstring(uib, "", uib->width);
 	return 0;
@@ -208,12 +390,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 	struct evsel *leader = hists_to_evsel(he->hists);
 	struct evsel *evsel;
 	int idx = 0;
+	bool current = ui_browser__is_current_entry(uib, row);
 
 	if (member == NULL) {
-		bool current = ui_browser__is_current_entry(uib, row);
-
 		/* print the closing bracket */
 		ui_browser__set_percent_color(uib, 0, current);
+		ui_browser__printf(uib, "%c ", NOCHLD_SIGN);
 		ui_browser__write_nstring(uib, "", 11 * browser->nr_events);
 		ui_browser__printf(uib, " %10s %10s  %*s};",
 				   "", "", be->indent * 4, "");
@@ -221,6 +403,13 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 		return;
 	}
 
+	ui_browser__set_percent_color(uib, 0, current);
+
+	if (!list_empty(&be->children))
+		ui_browser__printf(uib, "%c ", be->folded ? FOLDED_SIGN : UNFOLD_SIGN);
+	else
+		ui_browser__printf(uib, "%c ", NOCHLD_SIGN);
+
 	/* print the number */
 	for_each_group_evsel(evsel, leader) {
 		struct type_hist *h = adt->histograms[evsel->core.idx];
@@ -237,13 +426,13 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 		ui_browser__printf(uib, " %10d %10d  %s%s",
 				   member->offset, member->size,
 				   member->type_name,
-				   list_empty(&member->children) ? ";" : " {");
+				   list_empty(&member->children) || be->folded? ";" : " {");
 	} else {
 		ui_browser__printf(uib, " %10d %10d  %*s%s\t%s%s",
 				   member->offset, member->size,
 				   be->indent * 4, "", member->type_name,
 				   member->var_name ?: "",
-				   list_empty(&member->children) ? ";" : " {");
+				   list_empty(&member->children) || be->folded ? ";" : " {");
 	}
 	/* fill the rest */
 	ui_browser__write_nstring(uib, "", uib->width);
@@ -297,7 +486,7 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
 	struct annotated_data_browser browser = {
 		.b = {
 			.refresh = browser__refresh,
-			.seek	 = ui_browser__list_head_seek,
+			.seek	 = browser__seek,
 			.write	 = browser__write,
 			.priv	 = he,
 			.extra_title_lines = 1,
-- 
2.46.0.76.ge559c4bf1a-goog

