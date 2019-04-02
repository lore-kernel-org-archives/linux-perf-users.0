From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/44] perf trace beauty renameat: No need to include linux/fs.h
Date: Tue,  2 Apr 2019 13:05:09 -0300
Message-ID: <20190402160549.13544-5-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There is no use for what is in that file, as everything is
built by the tools/perf/trace/beauty/rename_flags.sh script from
the copied kernel headers, the end result being:

  $ cat /tmp/build/perf/trace/beauty/generated/rename_flags_array.c
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

I.e. no use of any defines from uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lgugmfa8z4bpw5zsbuoitllb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/renameat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/trace/beauty/renameat.c b/tools/perf/trace/beauty/renameat.c
index 6dab340cc506..852d2e271833 100644
--- a/tools/perf/trace/beauty/renameat.c
+++ b/tools/perf/trace/beauty/renameat.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 #include "trace/beauty/beauty.h"
-#include <uapi/linux/fs.h>
 
 static size_t renameat2__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
-- 
2.20.1
