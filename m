From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/18] tools build tests: Don't hardcode gcc name
Date: Tue, 29 Aug 2017 16:42:46 -0300
Message-ID: <20170829194254.1338-11-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Use $(CC) instead of harcoded gcc binary name.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170827075442.108534-2-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/tests/ex/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/tests/ex/Makefile b/tools/build/tests/ex/Makefile
index c50d5782ad5a..027d6c8a58a7 100644
--- a/tools/build/tests/ex/Makefile
+++ b/tools/build/tests/ex/Makefile
@@ -8,7 +8,7 @@ ex:
 include $(srctree)/tools/build/Makefile.include
 
 ex: ex-in.o libex-in.o
-	gcc -o $@ $^
+	$(CC) -o $@ $^
 
 ex.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=. $@
-- 
2.13.5
