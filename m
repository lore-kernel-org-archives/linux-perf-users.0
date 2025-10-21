Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5961A3166;
	Tue, 21 Oct 2025 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016075; cv=none; b=mSoBOFFhNqkS3xl2A9+oZU9e6oJ4qG38WZEciGQunDstXbW0+oH7E60T2uPm5CfE0HwE2pDxz9INHX57kEqW4lsY5+bI0PiFQr9P7HTpDh36oAiWX7XK0JShUSM6MyPJw+pHs0zF579k2KUsVyB22JqOKsrxAXD72iNi6eERTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016075; c=relaxed/simple;
	bh=sCq2PWQBi6avOIyc/gQ5GDOwRQDRQWYucGOCptWi6Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkoQ8mWyUl0QzlsBjr+ece0xqyyIzjD46G4HjpBUpovu19WnP0pmsFzlF0rvZlqjrAjkslsMkwWKLHN582a+36TAFIF0XC/93rAH6siDUhV55uPkxFMmegMX6Wlh3Q3l+nSAjZpTQ5uQM4Kz35kGMWvTeRR3/sRawBwCefwsAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGY3EYC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGY3EYC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FBC4CEFB;
	Tue, 21 Oct 2025 03:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761016074;
	bh=sCq2PWQBi6avOIyc/gQ5GDOwRQDRQWYucGOCptWi6Hk=;
	h=From:To:Cc:Subject:Date:From;
	b=dGY3EYC3EIuYaSW2tPpNpkkselhAV+5am7P6vsyFEnLTyvcVn5h3iqUY+MrozPNZe
	 i5/HsWseN7zJWlaEeBrAQYka5D426CbwIFOtGo23SFyYka5jX+4XdezelPaRS1c3nZ
	 YGlW6iiDlARHmAU8o1kXOQg9Hpf7EspZRaLWLyAYYnRe0TkJ9ikoKk1DBZwUseUQYg
	 b3zTa6f5nHwm0UzoKjn3WWQdvAnUUSC8FcUoHFtXTHgOXBZRPKmnt1T15ibDnMSVE1
	 Auq6TqiTXnDBNIYlkzAHd0ukqt1yjrltVqaNhFDWHauhFb46I7kd8hprt2W/p+2k/5
	 g1VN5JlkthdRQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Tianyou Li <tianyou.li@intel.com>
Subject: [PATCH] perf annotate: Fix build with NO_SLANG=1
Date: Tue, 21 Oct 2025 12:07:50 +0900
Message-ID: <20251021030750.254186-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent change for perf c2c annotate broke build without slang
support like below.

  builtin-annotate.c: In function 'hists__find_annotations':
  builtin-annotate.c:522:73: error: 'NO_ADDR' undeclared (first use in this function); did you mean 'NR_ADDR'?
    522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
        |                                                                         ^~~~~~~
        |                                                                         NR_ADDR
  builtin-annotate.c:522:73: note: each undeclared identifier is reported only once for each function it appears in

  builtin-annotate.c:522:31: error: too many arguments to function 'hist_entry__tui_annotate'
    522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
        |                               ^~~~~~~~~~~~~~~~~~~~~~~~
  In file included from util/sort.h:6,
                   from builtin-annotate.c:28:
  util/hist.h:756:19: note: declared here
    756 | static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
        |                   ^~~~~~~~~~~~~~~~~~~~~~~~

And I noticed that it missed to update the other side of #ifdef
HAVE_SLANG_SUPPORT.  Let's fix it.

Fixes: cd3466cd2639783d ("perf c2c: Add annotation support to perf c2c report")
Cc: Tianyou Li <tianyou.li@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6795816eee856e8f..1d5ea632ca4e1b0b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -709,12 +709,12 @@ struct block_hist {
 	struct hist_entry	he;
 };
 
+#define NO_ADDR 0
+
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
-#define NO_ADDR 0
-
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
 			       struct hist_browser_timer *hbt, u64 al_addr);
@@ -748,14 +748,16 @@ int evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
 static inline int __hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 					     struct map_symbol *ms __maybe_unused,
 					     struct evsel *evsel __maybe_unused,
-					     struct hist_browser_timer *hbt __maybe_unused)
+					     struct hist_browser_timer *hbt __maybe_unused,
+					     u64 al_addr __maybe_unused)
 {
 	return 0;
 }
 
 static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 					   struct evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   u64 al_addr __maybe_unused)
 {
 	return 0;
 }
-- 
2.51.0.869.ge66316f041-goog

