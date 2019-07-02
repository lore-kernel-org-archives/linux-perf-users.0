From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/43] perf tools: Fix cache.h include directive
Date: Mon,  1 Jul 2019 23:25:34 -0300
Message-ID: <20190702022616.1259-2-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Numfor Mbiziwo-Tiapo <nums@google.com>, Jiri Olsa <jolsa@redhat.com>, Luke Mujica <lukemujica@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Numfor Mbiziwo-Tiapo <nums@google.com>

Change the include path so that progress.c can find cache.h since it was
previously searching in the wrong directory.

Committer notes:

  $ ls -la tools/perf/ui/../cache.h
  ls: cannot access 'tools/perf/ui/../cache.h': No such file or directory

So it really should include ../../util/cache.h, or plain cache.h, since
we have -Iutil in INC_FLAGS in tools/perf/Makefile.config

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>,
Cc: Luke Mujica <lukemujica@google.com>,
Cc: Stephane Eranian <eranian@google.com>
To: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/n/tip-pud8usyutvd2npg2vpsygncz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index bbfbc91a0fa4..8cd3b64c6893 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../cache.h"
+#include "../util/cache.h"
 #include "progress.h"
 
 static void null_progress__update(struct ui_progress *p __maybe_unused)
-- 
2.20.1
