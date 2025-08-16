Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60B1E0DE3;
	Sat, 16 Aug 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314209; cv=none; b=eLO/uISipnqXvjPHfieS4yyBCyzOu7ZtG+rZBC04c+/uJvQpchgUXsAlu2CyG5S88aKnBLcPPYZiVdiT4DiglEpoQ0HR687xGlLKyEHAZ1TtWRm0fNz1anQuc3PSc5DAzCCHCbcpUO7hxmOKAj/qYqDL2NrCwtn6KOsfDVc3RIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314209; c=relaxed/simple;
	bh=/q5ZMgNzBTPuHcNQWblbJy/veaZuKraOJBpsFCRXNSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQbTCmmSr4qrQ3F6tIGRq0Gb+hGl9zX3k8dCGItuWFMQdn8iEaQBuLr05aFDdI948WseI13hdbBg98csM+I1gAnJjNTVAWfs53+1Y924+uh88kb+XoKSqwXDXA6tGl9dlcgx/j3MCr54EE6MyXYDOHvS8NXK+RaU7wlVFqQ/Auo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c536WIue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c536WIue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3B9C4CEF4;
	Sat, 16 Aug 2025 03:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314209;
	bh=/q5ZMgNzBTPuHcNQWblbJy/veaZuKraOJBpsFCRXNSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c536WIueefK10+Vy+Y8heltG3GMiV5GDcvvQBrwmvfiuqVFWF9LPcqPtGhFo7p+uW
	 EM7Ykj95cZXDulKOI/Gp9kYWJfjP/S3ddqoJ2a1KRwlZncmjZKtDJNotfjksvOw3XN
	 i7gKQJdjlB7lET+qqi9bCgoxoUqXFF3BWBmTsa0rDF+w77bYHJKD+rE8NT/sF9RmwT
	 j8aQIYnuIOZ3Xgo3Go4i3z8cunz+yCdqAiPCeFT9dFFl85oieauA5YKqWVW4BYOntX
	 m7KjM41HqtIHQMhoERJ4T430bnEDrWGqLPq5rj2gbczMC3zjEg4uPzubL2aCNjZJzJ
	 YVcBx3GHOck7A==
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
Subject: [PATCH v5 08/12] perf annotate: Add 'T' hot key to toggle data type display
Date: Fri, 15 Aug 2025 20:16:31 -0700
Message-ID: <20250816031635.25318-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>
References: <20250816031635.25318-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support data type display with a key press so that users can toggle the
output dynamically on TUI.  Also display "[Type]" in the title line if
it's enabled.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e5b35336f0d33d7e..dfe869c20e35da77 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -533,9 +533,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 static int sym_title(struct symbol *sym, struct map *map, char *title,
 		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
+	return snprintf(title, sz, "%s  %s [Percent: %s] %s", sym->name,
 			dso__long_name(map__dso(map)),
-			percent_type_str(percent_type));
+			percent_type_str(percent_type),
+			annotate_opts.code_with_type ? "[Type]" : "");
 }
 
 /*
@@ -909,7 +910,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"b             Toggle percent base [period/hits]\n"
 		"B             Branch counter abbr list (Optional)\n"
 		"?             Search string backwards\n"
-		"f             Toggle showing offsets to full address\n");
+		"f             Toggle showing offsets to full address\n"
+		"T             Toggle data type display\n");
 			continue;
 		case 'r':
 			script_browse(NULL, NULL);
@@ -1029,6 +1031,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 'f':
 			annotation__toggle_full_addr(notes, ms);
 			continue;
+		case 'T':
+			annotate_opts.code_with_type ^= 1;
+			if (browser->dbg == NULL)
+				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
+			annotate_browser__show(&browser->b, title, help);
+			continue;
 		case K_LEFT:
 		case '<':
 		case '>':
@@ -1133,8 +1141,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
-	if (annotate_opts.code_with_type)
-		debuginfo__delete(browser.dbg);
+	debuginfo__delete(browser.dbg);
 	if (not_annotated && !notes->src->tried_source)
 		annotated_source__purge(notes->src);
 
-- 
2.50.1

