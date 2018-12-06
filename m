From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/75] perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul
Date: Thu,  6 Dec 2018 18:25:52 -0300
Message-ID: <20181206212602.20474-66-acme@kernel.org>
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

In this case we are actually setting the null byte at the right place,
but since we pass the buffer size as the limit to strncpy() and not
it minus one, gcc ends up warning us about that, see below. So, lets
just switch to the shorter form provided by strlcpy().

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  ui/tui/helpline.c: In function 'tui_helpline__push':
  ui/tui/helpline.c:27:2: error: 'strncpy' specified bound 512 equals destination size [-Werror=stringop-truncation]
    strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: e6e904687949 ("perf ui: Introduce struct ui_helpline")
Link: https://lkml.kernel.org/n/tip-d1wz0hjjsh19xbalw69qpytj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/helpline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 4ca799aadb4e..93d6b7240285 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -24,7 +24,7 @@ static void tui_helpline__push(const char *msg)
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
-	strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
+	strlcpy(ui_helpline__current, msg, sz);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)
-- 
2.19.2
