Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B261A9B39;
	Sun,  1 Jun 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748760786; cv=none; b=MhegZqd83Waz5euuhVx02ft3sOFTY+eVV1aghQQoquiJe+zbvDlrBlnKlIH+2ObBD3xKyHWw04a0N7DyOo/m3x+j0v8cXXUGHNtvfzSvTcG/DpAhjDkgPR/NwWm7+KkWfxVGmdQGKy4/JmOBnd7L67cGsQjFhLlnYOjvZfPKg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748760786; c=relaxed/simple;
	bh=w8+QfNx+uCIISmTP+rtDGxlrj31TjIv8kOjYOA/n79A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQp0LRq4b4IJXVfVf0d47Uv9HVZZgRXWRQ7fXl6Qt5xaI98A1Mrz+MR9ccRVsuPJHXvEm/hpjqlI/ndIuZ9p5tRAEcksBZ/Y4OYbZbij0tVPQj3gJm6+5d33YJWcUIkfQXIvpzmn01UA+XiZbsHTSbTHWGL6iw2qgvPNeXOOeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmE4GxBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmE4GxBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA35C4CEFA;
	Sun,  1 Jun 2025 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748760786;
	bh=w8+QfNx+uCIISmTP+rtDGxlrj31TjIv8kOjYOA/n79A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmE4GxBCIffR64tod0PgumkxK1z3gc+5FWXaPhpx5lDBPh8y6ovzltIhz+0LB3bkz
	 tVn4A/P6uO2Y6fH04Lm+K+MgjK9B82rZshP6NKbZpsr0WqEy3HS2DDnZFZwAk7T3ib
	 5xSXPLAl90XpVpeQ81GhLm39cz3f50yg58rlQDTrJxYbu7ecK7c0y6lakCKA7CLw0A
	 lnBY+Qxxw+h3u9p7NiJyQ4pVoueZm67rrdlf/QJwU0GuC9b3yU0nhXhKhqdfYM89Xz
	 zE54Vgsh+sd88HnszXVWOMZl5HFBR5O7R+5+ouSZVxNUOYcQqBX61hOTJSUfwYiBra
	 0nZqqCBJBoLgg==
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
Subject: [PATCH 6/6] perf annotate: Add 'y' hot key to toggle data type display
Date: Sat, 31 May 2025 23:53:02 -0700
Message-ID: <20250601065302.12531-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601065302.12531-1-namhyung@kernel.org>
References: <20250601065302.12531-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support data type display with a key press so that users can toggle the
output dynamically on TUI.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 686fa54e545e275c..cd1d452035a265d3 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -827,7 +827,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"b             Toggle percent base [period/hits]\n"
 		"B             Branch counter abbr list (Optional)\n"
 		"?             Search string backwards\n"
-		"f             Toggle showing offsets to full address\n");
+		"f             Toggle showing offsets to full address\n"
+		"y             Toggle data type display\n");
 			continue;
 		case 'r':
 			script_browse(NULL, NULL);
@@ -947,6 +948,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 'f':
 			annotation__toggle_full_addr(notes, ms);
 			continue;
+		case 'y':
+			annotate_opts.code_with_type ^= 1;
+			if (browser->dbg == NULL)
+				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
+			continue;
 		case K_LEFT:
 		case '<':
 		case '>':
@@ -1035,8 +1041,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
-	if (annotate_opts.code_with_type)
-		debuginfo__delete(browser.dbg);
+	debuginfo__delete(browser.dbg);
 	if(not_annotated)
 		annotated_source__purge(notes->src);
 
-- 
2.49.0

