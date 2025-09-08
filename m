Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1922A4F8;
	Mon,  8 Sep 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311857; cv=none; b=fhEl6/K1PCcnLKCiO9rv3LytHQ9EGMl4ElB4E7shllFHC9o8Gmi4qBxgkI78rF9YiSuJqQI+rI9Jw7BOnr9M43S3EfT3vYJJe6BVF19xzkti1AMOzQEGDrJ59CQwVq+3vH/Uy0qUqoGVFH9Z+lxlbi/psZel4vq6zElyigoxER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311857; c=relaxed/simple;
	bh=F5BzcfILpCLjaUcP/GHe2YvfI6hKbplkLQwl/8liWbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLtL/jIrIyyUXz/rqKYa1lXzg3c44HN67WqOauYpKKQJ3ygWZkzQ+80Bv4RTnawY/6xK2QKJ6WVq73n44XxkC3NkultgCPVXhqhFLJTyw3jo+ThXpm3PHF8ElCOEl4KRy88jjEisqR+/3EOWD0MzBr106ZS6/bsGwKWieMNagTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDTzse7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDTzse7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CB1C4CEF7;
	Mon,  8 Sep 2025 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757311857;
	bh=F5BzcfILpCLjaUcP/GHe2YvfI6hKbplkLQwl/8liWbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDTzse7k5/Ko4OZYG44/ueoyByMVvCHvSD8+RIZIR+LBTC15q3wg//v8KTWHKkYMP
	 PZlrW3J/VBWxx7wZeV6GYP5MLm7vjIuTvjGBiNC7bf4PZtJ6HXG+SNH/lu6X+Ce5mz
	 PNsk6jGYg1b71/7RPIUDSAIkB03brjZUnAoPBcHf4QwBuLJ0LdnAW0VVagRa3+G+hO
	 abMfHBesEOUYSAf9iIHsrouExiEU5ODOjCxzLnzBGfKhRdGKDbqMAnHw4igFeF/Tbi
	 hpPfGbkQYlzgVeb+/rhyeVZQzSMXXffL5IkBJTdqyu4aaYIRqBHeUPhtgxpPfPV2Az
	 4rRp0iNzkmUlQ==
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
Subject: [PATCH 3/3] perf annotate: Fix title line after return from call
Date: Sun,  7 Sep 2025 23:10:50 -0700
Message-ID: <20250908061050.27517-3-namhyung@kernel.org>
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

The second title line which shows symbol and DSO name is broken after
moving to another function at 'callq' instruction.

The ui_browser__show_title() is used for the first line which shows
global sample count and event name so it doesn't change across the
functions.

What it needs after processing 'call' instruction is to update the
second line onlly.  Add a comment and call appropriate function.

You can verify the change by pressing ENTER on a 'call' instruction and
then ESC.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 39f042837d438559..8fe699f985423eab 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -585,7 +585,6 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	struct map_symbol *ms = browser->b.priv, target_ms;
 	struct disasm_line *dl = disasm_line(browser->selection);
 	struct annotation *notes;
-	char title[SYM_TITLE_MAX_SIZE];
 
 	if (!dl->ops.target.sym) {
 		ui_helpline__puts("The called function was not found.");
@@ -607,8 +606,13 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
 	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
-	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
-	ui_browser__show_title(&browser->b, title);
+
+	/*
+	 * The annotate_browser above changed the title with the target function
+	 * and now it's back to the original function.  Refresh the header line
+	 * for the original function again.
+	 */
+	annotate_browser__show_function_title(browser);
 	return true;
 }
 
-- 
2.51.0

