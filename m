From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/35] perf clang: Remove needless extra semicolon
Date: Thu,  7 Mar 2019 14:44:16 -0300
Message-ID: <20190307174433.28819-19-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yang Wei <yang.wei9@zte.com.cn>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Yang Wei <albin_yang@163.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Yang Wei <yang.wei9@zte.com.cn>

Delete a superfluous semicolon in getBPFObjectFromModule().

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Wei <albin_yang@163.com>
Link: http://lkml.kernel.org/r/1551710174-3349-1-git-send-email-albin_yang@163.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 39c0004f2886..fc361c3f8570 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -156,7 +156,7 @@ getBPFObjectFromModule(llvm::Module *Module)
 #endif
 	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
-		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
+		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
 	}
 	PM.run(*Module);
 
-- 
2.20.1
