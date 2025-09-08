Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDF224247;
	Mon,  8 Sep 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311857; cv=none; b=GXzJxbOMqhVjEj/grWVCvpHgM2UOkIhOSQ72H4F7UvpFSyR8EKyFALg9aASJ5LWGrvz0WntQyQH0WHqz3+sKNJc/DY9H9I7tKHAWA7sbs7OBTmwD+WnlxzP6qC6Z5dNgOZeXg4MdFhvLr/FG+UC0vJlQ2MK7Rw21qJNk22gUwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311857; c=relaxed/simple;
	bh=42RbIOux0GF5O6/ekdvZTRMvb6cp3vVJBIeVsGzbb0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+tixp8sYn6Sx5EX7tWzRdIbOtfCqBs9TOXi7sd8an2+P5leL6gXo7uAcqfAXQF0Eu12U3sAeCJmCxDqgqa9eZ/a7TA3dh3pVa4cKXUbIdTp9z/6KDT4E9Q1i/XvB9q0dWidproj14RXrJR6CLvn0mYYXISiGem5bQ15XWvhTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hluh7r1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hluh7r1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996A6C4CEFB;
	Mon,  8 Sep 2025 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757311856;
	bh=42RbIOux0GF5O6/ekdvZTRMvb6cp3vVJBIeVsGzbb0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hluh7r1ZSub5RVhUIcgZlu7AZu9YhML603q4p1xCJKx7klyms9SA6FX+SHyL5pdgD
	 +3IgPUFuljyXxN185aT8jlgXfRiES+FKpVpzSr/pd9YmQ1MeyT2WU53O2WfB+thkUb
	 c0/TkBVhxJozTjKlsiKx6sOuXhyx3e+LILV2GqZtclj/Iks0Jr58oZnmZPPUBMNP2d
	 8XssGoyYBb5ZJv4SESsFpi8PMjsT9IdnFd5CpD6i9Fm14AZqgUkg1yAQX9Yn0Pmof7
	 Bknv0N/oZ3ZS3zOGkRuPs6kBY4ylF442S6x/LMle+keYvGDXIB5JYkLdvJyS3QLFJt
	 RcUEVOvsYnH6g==
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
Subject: [PATCH 2/3] perf annotate: Factor out annotate_browser__show_function_title()
Date: Sun,  7 Sep 2025 23:10:49 -0700
Message-ID: <20250908061050.27517-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908061050.27517-1-namhyung@kernel.org>
References: <20250908061050.27517-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It'll be used in other places.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 6fd4c3483c5068ae..39f042837d438559 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -555,6 +555,20 @@ static int sym_title(struct symbol *sym, struct map *map, char *title,
 			annotate_opts.code_with_type ? "[Type]" : "");
 }
 
+static void annotate_browser__show_function_title(struct annotate_browser *browser)
+{
+	struct ui_browser *b = &browser->b;
+	struct map_symbol *ms = b->priv;
+	struct symbol *sym = ms->sym;
+	char title[SYM_TITLE_MAX_SIZE];
+
+	sym_title(sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
+
+	ui_browser__gotorc_title(b, 0, 0);
+	ui_browser__set_color(b, HE_COLORSET_ROOT);
+	ui_browser__write_nstring(b, title, b->width + 1);
+}
+
 /*
  * This can be called from external jumps, i.e. jumps from one function
  * to another, like from the kernel's entry_SYSCALL_64 function to the
@@ -768,19 +782,10 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static int annotate_browser__show(struct annotate_browser *browser, char *title, const char *help)
 {
-	struct ui_browser *b = &browser->b;
-	struct map_symbol *ms = b->priv;
-	struct symbol *sym = ms->sym;
-	char symbol_dso[SYM_TITLE_MAX_SIZE];
-
-	if (ui_browser__show(b, title, help) < 0)
+	if (ui_browser__show(&browser->b, title, help) < 0)
 		return -1;
 
-	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso), annotate_opts.percent_type);
-
-	ui_browser__gotorc_title(b, 0, 0);
-	ui_browser__set_color(b, HE_COLORSET_ROOT);
-	ui_browser__write_nstring(b, symbol_dso, b->width + 1);
+	annotate_browser__show_function_title(browser);
 	return 0;
 }
 
-- 
2.51.0

