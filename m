From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/13] perf tests clang: Fix function name for clang IR test
Date: Mon,  9 Apr 2018 16:34:37 -0300
Message-ID: <20180409193437.14199-14-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

As stated in tests/llvm-src-base.c, the name of the bpf function should
be "bpf_func__SyS_epoll_pwait" but this clang test fails as it tries to
lookup "bpf_func__SyS_epoll_wait".

Before applying patch:

55: builtin clang support                                 :
55.1: builtin clang compile C source to IR                : FAILED!
55.2: builtin clang compile C source to ELF object        : Skip

After applying patch:

55: builtin clang support                                 :
55.1: builtin clang compile C source to IR                : Ok
55.2: builtin clang compile C source to ELF object        : Ok

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: e67d52d411c3 ("perf clang: Update test case to use real BPF script")
Link: http://lkml.kernel.org/r/20180404180419.19056-3-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang-test.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index a4014d786676..7b042a5ebc68 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -41,7 +41,7 @@ int test__clang_to_IR(void)
 	if (!M)
 		return -1;
 	for (llvm::Function& F : *M)
-		if (F.getName() == "bpf_func__SyS_epoll_wait")
+		if (F.getName() == "bpf_func__SyS_epoll_pwait")
 			return 0;
 	return -1;
 }
-- 
2.14.3
