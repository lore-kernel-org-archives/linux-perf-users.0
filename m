Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67021CA13;
	Sat,  7 Jun 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338744; cv=none; b=ZSFG2//hsjmQTch1tuTCYGlL1g5HHE49YHdT4fV1hA0n/4eqKpw/li5RVKr2AOd+luggvmGkbIegAAB00zXAiMcBWtJFY3TPXCabxn620tZ/ugsT5eR2aeiyReciye1dOj9naJnJI52XdvNdmyteWLlB1QkawL3jM6j/ac0n/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338744; c=relaxed/simple;
	bh=MNnJC1Iw8l3zhx++zNwnC5pdp8BO0/MPYBFQNUUoGCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIp2ehEug1bXa+9AExZEL+4Ib0QBF/QerKqIqRnQsUE4Fg9R7tiwv1Pfce14pUcyX9ayS+v5lL8+QaW2ToCryR8Wsu6MN9w8jsGEhDznD0139cOhf+Mar37O74JBt1KNSMD+VBBLtfBspXOlGRKpHlkIjUjBpYmuMBfIKofHYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUES6ppX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUES6ppX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B0C4CEFE;
	Sat,  7 Jun 2025 23:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338744;
	bh=MNnJC1Iw8l3zhx++zNwnC5pdp8BO0/MPYBFQNUUoGCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUES6ppXWirkoWBer/iBiEeHinoYZAcb+8d50KFBeWUD4QsQQHkefry3MrgwahsIr
	 ep8mzLx40d1Xzas8gqHLnkrBBpIpOR2CWRy/3oS5/slEJo/rYGrsqvfiXNe8gJYFvC
	 YXUrI5BSaIBneVr11A+j1Qv7BM72XGidanCS439/pUo5XiEGzjKNoQgIKNv2S8G2QN
	 1YHDlwdRQnlXPuSFx928Mm8tBxS6MzVQCkKmk5+jnd7o2dUvBHNHQC1aUqQsOLaEsm
	 v9KrzoGRKkLel/R3vghSBaoPJ7C1zmvV7bRRsEOGFquTyjMNlUlbp6biHAgs/Di5DI
	 q58/Fkjhknwjw==
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
Subject: [PATCH v2 6/7] perf annotate: Add 'T' hot key to toggle data type display
Date: Sat,  7 Jun 2025 16:25:39 -0700
Message-ID: <20250607232540.89488-7-namhyung@kernel.org>
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

Support data type display with a key press so that users can toggle the
output dynamically on TUI.  Also display "[Type]" in the title line if
it's enabled.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 686fa54e545e275c..b0b31a121941daec 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -451,9 +451,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
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
@@ -827,7 +828,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"b             Toggle percent base [period/hits]\n"
 		"B             Branch counter abbr list (Optional)\n"
 		"?             Search string backwards\n"
-		"f             Toggle showing offsets to full address\n");
+		"f             Toggle showing offsets to full address\n"
+		"T             Toggle data type display\n");
 			continue;
 		case 'r':
 			script_browse(NULL, NULL);
@@ -947,6 +949,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
@@ -1035,8 +1043,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
-	if (annotate_opts.code_with_type)
-		debuginfo__delete(browser.dbg);
+	debuginfo__delete(browser.dbg);
 	if(not_annotated)
 		annotated_source__purge(notes->src);
 
-- 
2.49.0

