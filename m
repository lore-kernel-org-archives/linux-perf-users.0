Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634609;
	b=nFz9TWZF0UxA5xJ7b2TIMHOxT617pdwo4N116pw9LmO8A8YVL7eizApylKw78rn0TGU9
	 H8azAuJZuLPzaMA+bJGUPslumR06D75nKQu9WgwpvfymXsgXTZPYWLYlDExQZidLRoCGs
	 X69SyOirspRRdig8fDGY1meeE2VPYwFJUpqSztF+sAgttP2cEIyTX9npr/RBGW1ReeNNx
	 9e66AWRiZkzWb5gZurSAMQoZkh5B+MogwLB665NzxLycY5+Ivwfstqgjg8L7IKlsz4H+j
	 d8+Z0REKojlrDC/C31iDxlsk9WQJQVDLRS4pjARYZjwPKJUT6GY6DJYHbawvVnQcmqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pfp8gaPqhsaUgu3J0t38d2U4yc4dPtHGtqJbx2EZfik=;
	b=VqezdpVd/p9013JHcEcrt7FrKPONTmufCQgQajGApPJxSpq32HpbeWYoK6bbUSCLJU/q
	 cXiPMWGHbDmXmLL8xwdvFowDfGdtH8AP34oGPmAIF8PowraF/lFK/+QuDJ0Y3cLcGJGOh
	 FR7zC0MSEqHNEqVMFquVDSwkQlPDo18iYhIJjjPa8REFrbzCJeDbyzVTzT+UT0zLo1p27
	 EWOjpGyuMNXu/uuFdBVDUrp+qQPq0KmM5lW/WeqKD+riwtbUy5fQOnN5mfZB4DZggCpaF
	 j4pLMPouf6tTdzmj4n13gLZg2lq3m3EJRBY/gihUGAI9RSl0Ne+BjyqwcEzWzMIsbWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5RvDYmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBAE606A32C;
	Wed, 25 Nov 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5RvDYmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635261F000C4;
	Wed, 25 Nov 2026 19:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634609;
	bh=pfp8gaPqhsaUgu3J0t38d2U4yc4dPtHGtqJbx2EZfik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M5RvDYmdEjyCO99VTvPZ6+1WL04goWldChZ04855/UbH8y1e0zo2SurRS48ji2lYv
	 jeBxsxr5t5Jr5Y+3oIGC7wblZdFLRGm134mdcP6cabF1Z3Ut4oRXxknHlgRrB4QSzm
	 i8+HVcGEqZMW0XMi0A1ijjjBNupgN9xTz1UjGAWtYL+EyMuu7S6N/qU3lZEqgiLu4+
	 pSc6dM3CYcAGdT28ndKZ3FDsTYfD0aqX0bJf9ab1bY8wS6jf0nl1e0gvlQkyz2Jt9n
	 WZLQ447zsmAa+3BceUBeliugMEaZqLgnlQrgJvNIh5+fArtNo7BkgoahoS5NuZrn9z
	 2CjSjnkMN2kuw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v13 03/19] perf annotate: Print the stats where the counters are final
Date: Wed, 25 Nov 2026 16:22:56 -0300
Message-ID: <20261125192312.34134-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The stats are printed from hists__find_annotations(), before that event
is annotated: with --code-with-type the first event reports zeros,
because those types are resolved while printing, and a later event can
report a total that is not its own.  The data type total is only
counted in --data-type mode, so --type-stat without it is incomplete
too.

The data type pass resolves the samples while the histograms are being
resorted, so in stdio without --code-with-type the counters are final
before any annotation is printed.  Print the stats once there, before
the annotations, so that the quality can be checked without scrolling,
and once after them when --code-with-type or a browser is used, where
the counters only reach their final values during the output.  Leave
the TUI's alternate screen before printing, so the stats remain on the
terminal.  Warn if --type-stat is used without --data-type.

Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debugging")
Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debugging")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  2 +-
 tools/perf/builtin-annotate.c              | 68 +++++++++++++++++-----
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 1a90b09a12d5abb1..d27eff28ba4f6af0 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -169,7 +169,7 @@ include::itrace.txt[]
 	all data types it finds.
 
 --type-stat::
-	Show stats for the data type annotation.
+	Show stats for the data type annotation (with --data-type).
 
 --skip-empty::
 	Do not display empty (or dummy) events.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7cb7e03d9a21d81b..52fbb88a6b63bd83 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -414,11 +414,6 @@ static void hists__find_annotations(struct hists *hists,
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
 	int key = K_RIGHT;
 
-	if (ann->type_stat)
-		print_annotate_data_stat(&ann_data_stat);
-	if (ann->insn_stat)
-		print_annotate_item_stat(&ann_insn_stat, "Instruction");
-
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
@@ -552,12 +547,25 @@ static void hists__find_annotations(struct hists *hists,
 	}
 }
 
+static void print_annotation_stats(struct perf_annotate *ann)
+{
+	/* pr_warning reaches the terminal: the browser mode has exited. */
+	if (ann->type_stat && !ann->data_type)
+		pr_warning("Warning: --type-stat needs --data-type\n");
+
+	if (ann->data_type && ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
+}
+
 static int __cmd_annotate(struct perf_annotate *ann)
 {
 	int ret;
 	struct perf_session *session = ann->session;
 	struct evsel *pos;
 	u64 total_nr_samples;
+	bool stats_first;
 
 	if (ann->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, ann->cpu_list,
@@ -619,18 +627,14 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			 * An event group needs to display other events too.
 			 * Let's delay printing until other events are processed.
 			 */
-			if (symbol_conf.event_group) {
-				if (!evsel__is_group_leader(pos)) {
-					struct hists *leader_hists;
-
-					leader_hists = evsel__hists(evsel__leader(pos));
-					hists__match(leader_hists, hists);
-					hists__link(leader_hists, hists);
-				}
-				continue;
-			}
+			if (symbol_conf.event_group &&
+			    !evsel__is_group_leader(pos)) {
+				struct hists *leader_hists;
 
-			hists__find_annotations(hists, pos, ann);
+				leader_hists = evsel__hists(evsel__leader(pos));
+				hists__match(leader_hists, hists);
+				hists__link(leader_hists, hists);
+			}
 		}
 	}
 
@@ -639,6 +643,29 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		goto out;
 	}
 
+	/*
+	 * The data type pass resolves the samples while the histograms are
+	 * being resorted, so with nothing left to resolve during the
+	 * annotation print the stats are complete here: show them before
+	 * the annotations, where judging quality needs no scrolling.  With
+	 * --code-with-type and in a browser the types are resolved while
+	 * printing, there the stats go after the annotations, once the
+	 * totals are final.
+	 */
+	stats_first = use_browser == 0 && !annotate_opts.code_with_type;
+	if (stats_first)
+		print_annotation_stats(ann);
+
+	/* Standalone events, group leaders are printed together below */
+	evlist__for_each_entry(session->evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		if (symbol_conf.event_group || hists->stats.nr_samples == 0)
+			continue;
+
+		hists__find_annotations(hists, pos, ann);
+	}
+
 	/* Display group events together */
 	evlist__for_each_entry(session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
@@ -663,6 +690,15 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		hists__find_annotations(hists, pos, ann);
 	}
 
+	if (!stats_first && (ann->insn_stat || ann->type_stat)) {
+		if (use_browser == 1) {
+			/* Leave the alternate screen before printing to the terminal. */
+			ui__exit(false);
+			use_browser = 0;
+		}
+		print_annotation_stats(ann);
+	}
+
 	if (use_browser == 2) {
 		void (*show_annotations)(void);
 
-- 
2.56.0

