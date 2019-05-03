From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/11] perf tools: Remove needless asm/unistd.h include fixing build in some places
Date: Thu,  2 May 2019 20:25:33 -0400
Message-ID: <20190503002533.29359-12-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were including sys/syscall.h and asm/unistd.h, since sys/syscall.h
includes asm/unistd.h, sometimes this leads to the redefinition of
defines, breaking the build.

Noticed on ARC with uCLibc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Link: https://lkml.kernel.org/n/tip-xjpf80o64i2ko74aj2jih0qg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cloexec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index ca0fff6272be..06f48312c5ed 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,7 +7,6 @@
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
-#include <asm/unistd.h>
 #include <sys/syscall.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
-- 
2.20.1
