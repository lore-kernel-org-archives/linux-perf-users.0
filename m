Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773D257AF0;
	Fri, 25 Jul 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472284; cv=none; b=A9j6LuRILj7l6nRqAmgON3Xpiy5j7Vq3ru4KG3CdIIT0PbViwNLQUcjIogOSULIdUEhbcX/41QgLSVtwztcKCiyZ3V8pAk8O55LSME60W5sPuoO/4eztiG3Hml8xH/UvJA0Y1q3+QCu/JvY2VEIm8n9Czp64qmdHa9SxuDDHcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472284; c=relaxed/simple;
	bh=RZwoNefxnoF2jKQS/nrvWEJRyA20FSBuyZwRH1BtM18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9TpTK9qi032xevWWsrlwaLerGsm8QnXPq/BlFbyykZdo2+UXXEP6H7cmCiS05eiCpBb9UCLOo7b5JgvA/XzE/+0bXd/zMVrM8IgoiHVil2x9U6C0x7uVB68pOc/dfgwOyiOiVTHxx2rNdqMNi+dOB/rayUIc52aBwNq5jcX2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnGFBffG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnGFBffG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A699C4CEF7;
	Fri, 25 Jul 2025 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472284;
	bh=RZwoNefxnoF2jKQS/nrvWEJRyA20FSBuyZwRH1BtM18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnGFBffGD7znfhMFp1VvnEi6OIWmwxvcjvq9DwIjAyxnRomYcbwroX33vmPMz1Vk4
	 krpkn6dOwoVG5TILlbo86fwxIZQiGEMYTUpaI1QmozEoxb4k6gvIGD+UdOZz8eRIQP
	 hYiJsqxa8USY3UwXi2JScnJQgbtIdw5gnmencj/Ase6cWAsVAJsMVLRGebAWOk9g70
	 dbVMXeBmOowCBi8/mqErriUBDodR5y6oPofxAtAZI7beEH1+6tS+nTsQD16p2jxw8X
	 b+d/jQ+oNQPHag0xQ9vc15iZ07TSdlQfdi2QLXUyRScnpTXjL5ynfwAEcR/BapUw+/
	 cvNwXalVxHd1g==
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
Subject: [PATCH v4 6/9] perf annotate: Add 'T' hot key to toggle data type display
Date: Fri, 25 Jul 2025 12:37:52 -0700
Message-ID: <20250725193755.12276-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725193755.12276-1-namhyung@kernel.org>
References: <20250725193755.12276-1-namhyung@kernel.org>
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
index cdee1969f3131a7c..4b059e0bafd33fcf 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -525,9 +525,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
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
@@ -901,7 +902,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"b             Toggle percent base [period/hits]\n"
 		"B             Branch counter abbr list (Optional)\n"
 		"?             Search string backwards\n"
-		"f             Toggle showing offsets to full address\n");
+		"f             Toggle showing offsets to full address\n"
+		"T             Toggle data type display\n");
 			continue;
 		case 'r':
 			script_browse(NULL, NULL);
@@ -1021,6 +1023,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
@@ -1115,8 +1123,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
-	if (annotate_opts.code_with_type)
-		debuginfo__delete(browser.dbg);
+	debuginfo__delete(browser.dbg);
 	if (not_annotated && !notes->src->tried_source)
 		annotated_source__purge(notes->src);
 
-- 
2.50.1

