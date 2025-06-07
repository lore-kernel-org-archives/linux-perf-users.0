Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435F21ABDC;
	Sat,  7 Jun 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338742; cv=none; b=oiGVs7q2qBiAlPZljMMXAiQq0N6fqxk3Ga5hdRi6HomWn2/xoVRgU2EST1/CxqG1TofkTPNPNwWMIwQEFYpK+aCt8hO9h/obpyg/n1v0i0WoXw7x8LDzCtkBqnMfkUFTs9dFvv87Dd7CyjvjMuOQSV0VyhWTFXMDmdMF12aIQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338742; c=relaxed/simple;
	bh=J1xmgKQrWkaZr76FYlzVzbOsf5JCdhN8E+pTBL7Wub4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOPEvwEMWiQwisE1B0j1mXxGjGy857E2pjX0Nzv3t8arcN59oGtltAJDMaVJs6M7/saP9Iok4L/qBch78P89XB5wn9OBUMzbrQWRb2YyNKHgdHaQzJNT33jy1OA4WF45tVwmt3VvSB+w8gT6kwmzF0mpds6+ZdVM1eZjEMBs6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhDb+UFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhDb+UFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B5C4CEF1;
	Sat,  7 Jun 2025 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338742;
	bh=J1xmgKQrWkaZr76FYlzVzbOsf5JCdhN8E+pTBL7Wub4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhDb+UFRN/VsBimrQX8vCzgqtCrWEpZHgK2FZfEa2xcuNSx6EdHX89LD7N6Ab3Q9f
	 0Usd8UpdRYNJsHVmwkV6CD6bIczm9Oy4u5neNF5PgjhWEMJVLDHikWsMyHGLeGTOyZ
	 NpIHZRwyVlBaXmVa7nasmcLBcDSD6XHdWZ1O9MLMCxgEYtnc1Zd9j3Duwu8nWRZHzS
	 hIwlT8mpj4dPxUp3osHZv2GFwbiUVHkwyMkaNOhtDOK2utH85XvcAnTo3KbUB6MAe9
	 RA9fzOXOepctKyt8UQpBTB2R2Z/echTPKgomPGi0b1PaK0JPgVVoyavRll6JPbVBdj
	 9IGSC4Ziql2Pw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v2 2/7] perf annotate: Remove __annotation_line__write()
Date: Sat,  7 Jun 2025 16:25:35 -0700
Message-ID: <20250607232540.89488-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607232540.89488-1-namhyung@kernel.org>
References: <20250607232540.89488-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of the internal function and convert function arguments into
local variables if they are used more than once.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 46 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 264a212b47df850c..58c33c9a58765b95 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1934,24 +1934,26 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 	return -ENOMEM;
 }
 
-static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
-				     bool first_line, bool current_entry, bool change_color, int width,
-				     void *obj, unsigned int percent_type,
-				     int  (*obj__set_color)(void *obj, int color),
-				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
-				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
-				     void (*obj__printf)(void *obj, const char *fmt, ...),
-				     void (*obj__write_graph)(void *obj, int graph))
-
-{
-	double percent_max = annotation_line__max_percent(al, percent_type);
-	int pcnt_width = annotation__pcnt_width(notes),
-	    cycles_width = annotation__cycles_width(notes);
+void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+			    struct annotation_write_ops *wops)
+{
+	bool current_entry = wops->current_entry;
+	bool change_color = wops->change_color;
+	double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
+	int width = wops->width;
+	int pcnt_width = annotation__pcnt_width(notes);
+	int cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
 	char bf[256];
 	int printed;
-
-	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
+	void *obj = wops->obj;
+	int  (*obj__set_color)(void *obj, int color) = wops->set_color;
+	void (*obj__set_percent_color)(void *obj, double percent, bool current) = wops->set_percent_color;
+	int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current) = wops->set_jumps_percent_color;
+	void (*obj__printf)(void *obj, const char *fmt, ...) = wops->printf;
+	void (*obj__write_graph)(void *obj, int graph) = wops->write_graph;
+
+	if (wops->first_line && (al->offset == -1 || percent_max == 0.0)) {
 		if (notes->branch && al->cycles) {
 			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
 				show_title = true;
@@ -1965,7 +1967,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
 
-			percent = annotation_data__percent(&al->data[i], percent_type);
+			percent = annotation_data__percent(&al->data[i],
+							   annotate_opts.percent_type);
 
 			obj__set_percent_color(obj, percent, current_entry);
 			if (symbol_conf.show_total_period) {
@@ -2114,17 +2117,6 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 
 }
 
-void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *wops)
-{
-	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
-				 wops->change_color, wops->width, wops->obj,
-				 annotate_opts.percent_type,
-				 wops->set_color, wops->set_percent_color,
-				 wops->set_jumps_percent_color, wops->printf,
-				 wops->write_graph);
-}
-
 int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 		      struct arch **parch)
 {
-- 
2.49.0

