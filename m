From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/7] x86/perf/amd: Fix build failure when CONFIG_HAVE_NMI_WATCHDOG is not set
Date: Fri, 12 Apr 2019 11:22:45 -0300
Message-ID: <20190412142250.20595-3-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>, Jiri Olsa <jolsa@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

When CONFIG_HAVE_NMI_WATCHDOG is not set, the asm/nmi.h file is not
included. The asm/nmi.h file contains the definitions for NMI_HANDLED
and NMI_DONE which are used in arch/x86/events/amd/core.c. This causes
the build the fail.

Fix the issue by changing the include in arch/x86/events/amd/core.c from
linux/nmi.h to asm/nmi.h.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 5d423653f744..0ecfac84ba91 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -4,8 +4,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/nmi.h>
 #include <asm/apicdef.h>
+#include <asm/nmi.h>
 
 #include "../perf_event.h"
 
-- 
2.20.1
