Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB927CB04;
	Wed, 16 Jul 2025 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642063; cv=none; b=ccpgNmUUuhSJVujAvcQNJggiQ/sDw4pyjmchIq0zR4va9YEFM4O9GqQd2u6buHZ+Lc0Ajtqma5xCVWnTa2MJRb0PqenywigmZWE/s1rDnHSZ/LDPbfEAXCJ+ODqwiuARakKSMdBSEM350YeXnAN2C8Y4LXW0tmliWz80KMS9pAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642063; c=relaxed/simple;
	bh=ER0kGduABeTw/jyrOz3QLI6pC2W3uT/J4XKTt/gNfuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2RTUQUt05BC7uueyRFzN5YaBED6B+ltYqEpGwiLDFYmIkDvsKqccAHlgqFcMnUGGblrhs9BDJjkNdm561lpGEv1AtwZbEBr4c5af72WPHjHBf2Qa5vJ5albOObTw6xf+uhnfL+9ZEcuVol/2JtfUhE5uusCwZPYLSbgRy66vzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf4ZsOzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf4ZsOzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36040C4CEF7;
	Wed, 16 Jul 2025 05:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752642063;
	bh=ER0kGduABeTw/jyrOz3QLI6pC2W3uT/J4XKTt/gNfuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wf4ZsOzG4gKUJcKuPgDs/kcgowYj1fNbM7t4/FHaAIyGtp+dz4EXdzEB9A7OxoH/j
	 ZMf8kQ/qz7meT5J9hrzTe/oFI2xfDP2uNIWlHTqvQu8HF7T6QiF/gX56zORSqPQIKa
	 AFX/BL2ELwPGBJpkWxLlF4k7naQ65Ml+49WSjyBS9N5z01w23FFbBZuGuhr49Vxz0E
	 b8dHcZK+ARi1l9bNX9Qdk1WZoeiHOcezUTOaSo04nNscEfhlTtWLIj0YQM9cm3fjnm
	 tn0SHuo4GYAHezd8trZUPvnD4Gln9zTnwRsYu1MQjoOQ+4UHX490iZohN+dQ93FaKt
	 IhjDyMolmDMxg==
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
Subject: [PATCH v3 6/8] perf annotate: Add 'T' hot key to toggle data type display
Date: Tue, 15 Jul 2025 22:00:52 -0700
Message-ID: <20250716050054.14130-7-namhyung@kernel.org>
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
2.50.0

