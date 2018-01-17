From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/32] tools lib traceevent: Add UL suffix to MISSING_EVENTS
Date: Wed, 17 Jan 2018 13:12:05 -0300
Message-ID: <20180117161222.15611-16-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Sartain <mikesart@fastmail.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Michael Sartain <mikesart@fastmail.com>

Add UL suffix to MISSING_EVENTS since ints shouldn't be left shifted by 31.

Signed-off-by: Michael Sartain <mikesart@fastmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20171016165542.13038-4-mikesart@fastmail.com
Link: http://lkml.kernel.org/r/20180112004822.829533885@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/kbuffer-parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index c94e3641b046..ca424b157e46 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -24,8 +24,8 @@
 
 #include "kbuffer.h"
 
-#define MISSING_EVENTS (1 << 31)
-#define MISSING_STORED (1 << 30)
+#define MISSING_EVENTS (1UL << 31)
+#define MISSING_STORED (1UL << 30)
 
 #define COMMIT_MASK ((1 << 27) - 1)
 
-- 
2.14.3
