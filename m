From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/75] perf svghelper: Fix unchecked usage of strncpy()
Date: Thu,  6 Dec 2018 18:25:51 -0300
Message-ID: <20181206212602.20474-65-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this specific case this would only happen if fgets() was buggy, as
its man page states that it should read one less byte than the size of
the destination buffer, so that it can put the nul byte at the end of
it, so it would never copy 255 non-nul chars, as fgets reads into the
orig buffer at most 254 non-nul chars and terminates it. But lets just
switch to strlcpy to keep the original intent and silence the gcc 8.2
warning.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  In function 'cpu_model',
      inlined from 'svg_cpu_box' at util/svghelper.c:378:2:
  util/svghelper.c:337:5: error: 'strncpy' output may be truncated copying 255 bytes from a string of length 255 [-Werror=stringop-truncation]
       strncpy(cpu_m, &buf[13], 255);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Fixes: f48d55ce7871 ("perf: Add a SVG helper library file")
Link: https://lkml.kernel.org/n/tip-xzkoo0gyr56gej39ltivuh9g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/svghelper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1cbada2dc6be..f735ee038713 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -334,7 +334,7 @@ static char *cpu_model(void)
 	if (file) {
 		while (fgets(buf, 255, file)) {
 			if (strstr(buf, "model name")) {
-				strncpy(cpu_m, &buf[13], 255);
+				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
 		}
-- 
2.19.2
