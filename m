Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D427144B;
	Wed, 16 Jul 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642062; cv=none; b=f8eO07FttiyQqgdSGvrt6JSNTI6DXq4yjHsS4OlsjIj8rNUBGoSet78TPuj8Fszp5Oy9OFteWxMjOuhAlzYs4jaVmENBtbcETZ+WeScurBmgzsNMy///jiP62QLreyMoPS10UXTLFSElgdq3fBBcerPe5UdGcZU4AVjuM+M0uTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642062; c=relaxed/simple;
	bh=ZR4FlTTBffrOf8yc2kOBjPOIFcxPv32gKjOEK9beR0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMBjWFJHAGfxyIYNDhyijyQwcj88YJYjYErAl5QE6pExLHQsdpU56MJW2XVjBBsfC4JSK/C75PB8mrjixh83xS5JsJgHgoHvM3CxaaODwUwBxHHtaB8ZU2J7wjvXZhUW69tX2MEuieUYDPZlCGZSHcBmi2dhEckcZKO8LJcTdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJyuw8/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJyuw8/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDEDC4CEF6;
	Wed, 16 Jul 2025 05:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752642061;
	bh=ZR4FlTTBffrOf8yc2kOBjPOIFcxPv32gKjOEK9beR0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJyuw8/PQQXfN9K4UAZ4I5H3HFre3mW78m8mHsl30bXVIOdxlEPWG4T6PLQulBVZX
	 GrvUf28ucLiJzwrZsQyetKUFOseC3qIqIsFNJ7Lh3Q1fRXFASetFzVxibp/QblFfut
	 so5M7temQVTjCbJvvbjDNOMKJ0+Gfsr6zz5Ci2HFHo9ej7nkzuXOsQaFFa52WSkJEP
	 NmsT5+CsrlxZJbW7lKZqW/66mcT5EuFiLOMlaT6UQajUBxvptQ8GwwvD48oLHTqzpx
	 X4b7td0rbX5iVNuVNbcsYVetoyxVnqVCZaipMpxdzwnE1Qg1C0S+nkdaUA8VQDJhD5
	 jf+zUM7HnxJdA==
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
Subject: [PATCH v3 2/8] perf annotate: Remove __annotation_line__write()
Date: Tue, 15 Jul 2025 22:00:48 -0700
Message-ID: <20250716050054.14130-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716050054.14130-1-namhyung@kernel.org>
References: <20250716050054.14130-1-namhyung@kernel.org>
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
index 0dd475a744b6dfac..69ee83052396b15e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1935,24 +1935,26 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
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
@@ -1966,7 +1968,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
 
-			percent = annotation_data__percent(&al->data[i], percent_type);
+			percent = annotation_data__percent(&al->data[i],
+							   annotate_opts.percent_type);
 
 			obj__set_percent_color(obj, percent, current_entry);
 			if (symbol_conf.show_total_period) {
@@ -2115,17 +2118,6 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 
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
2.50.0

