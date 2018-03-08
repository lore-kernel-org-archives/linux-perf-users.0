From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/54] perf build: Add llvm/clang make targets to FILES
Date: Thu,  8 Mar 2018 16:50:24 -0300
Message-ID: <20180308195029.14991-50-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So they can follow the OUTPUT variable setup as the rest of the
features.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0a490cb15149..f8ad640ffe5d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -54,7 +54,10 @@ FILES=                                          \
          test-jvmti.bin				\
          test-sched_getcpu.bin			\
          test-setns.bin				\
-         test-libopencsd.bin
+         test-libopencsd.bin			\
+         test-clang.bin				\
+         test-llvm.bin				\
+         test-llvm-version.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
-- 
2.14.3
