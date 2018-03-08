From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/54] perf build: Force llvm/clang test compile output to .make.output
Date: Thu,  8 Mar 2018 16:50:25 -0300
Message-ID: <20180308195029.14991-51-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So we can see the output of feature compile in following files:

  tools/build/feature/test-llvm.make.output
  tools/build/feature/test-llvm-version.make.output
  tools/build/feature/test-clang.make.output

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f8ad640ffe5d..dac9563b5470 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -260,11 +260,13 @@ $(OUTPUT)test-llvm.bin:
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
-		$(shell $(LLVM_CONFIG) --system-libs)
+		$(shell $(LLVM_CONFIG) --system-libs)		\
+		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-llvm-version.bin:
 	$(BUILDXX) -std=gnu++11 				\
-		-I$(shell $(LLVM_CONFIG) --includedir)
+		-I$(shell $(LLVM_CONFIG) --includedir)		\
+		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
 	$(BUILDXX) -std=gnu++11 				\
@@ -274,7 +276,8 @@ $(OUTPUT)test-clang.bin:
 		  -lclangFrontend -lclangEdit -lclangLex	\
 		  -lclangAST -Wl,--end-group 			\
 		$(shell $(LLVM_CONFIG) --libs Core option)	\
-		$(shell $(LLVM_CONFIG) --system-libs)
+		$(shell $(LLVM_CONFIG) --system-libs)		\
+		> $(@:.bin=.make.output) 2>&1
 
 -include $(OUTPUT)*.d
 
-- 
2.14.3
