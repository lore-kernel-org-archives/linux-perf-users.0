From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 61/75] perf header: Fix unchecked usage of strncpy()
Date: Thu,  6 Dec 2018 18:25:48 -0300
Message-ID: <20181206212602.20474-62-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/header.c: In function 'perf_event__synthesize_event_update_unit':
  util/header.c:3586:2: error: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
    strncpy(ev->data, evsel->unit, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/header.c:3579:16: note: length computed here
    size_t size = strlen(evsel->unit);
                  ^~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: a6e5281780d1 ("perf tools: Add event_update event unit type")
Link: https://lkml.kernel.org/n/tip-fiikh5nay70bv4zskw2aa858@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4a64739c67e7..c87cfe6b7c96 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3583,7 +3583,7 @@ perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strncpy(ev->data, evsel->unit, size);
+	strlcpy(ev->data, evsel->unit, size + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
-- 
2.19.2
