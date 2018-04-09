From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/13] perf tools: Fix perf builds with clang support
Date: Mon,  9 Apr 2018 16:34:35 -0300
Message-ID: <20180409193437.14199-12-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

For libclang, some distro packages provide static libraries (.a) while
some provide shared libraries (.so). Currently, perf code can only be
linked with static libraries. This makes perf build possible for both
cases.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: d58ac0bf8d1e ("perf build: Add clang and llvm compile and linking support")
Link: http://lkml.kernel.org/r/20180404180419.19056-1-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f7517e1b73f8..83e453de36f8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -364,7 +364,8 @@ LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive
 
 ifeq ($(USE_CLANG), 1)
   CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-  LIBCLANG = $(foreach l,$(CLANGLIBS_LIST),$(wildcard $(shell $(LLVM_CONFIG) --libdir)/libclang$(l).a))
+  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
+  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
   LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
 endif
 
-- 
2.14.3
