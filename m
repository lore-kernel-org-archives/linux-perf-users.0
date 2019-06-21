From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/25] tools build feature tests: Add missing SPDX headers
Date: Fri, 21 Jun 2019 14:38:23 -0300
Message-ID: <20190621173831.13780-18-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3h6fa866w6ao0wsbyqz9nrm8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-fortify-source.c | 1 +
 tools/build/feature/test-hello.c          | 1 +
 tools/build/feature/test-setns.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-fortify-source.c b/tools/build/feature/test-fortify-source.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-fortify-source.c
+++ b/tools/build/feature/test-fortify-source.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-hello.c b/tools/build/feature/test-hello.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-hello.c
+++ b/tools/build/feature/test-hello.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 4a1581ae7a55..2757c201ed50 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 #include <sched.h>
 
-- 
2.20.1
