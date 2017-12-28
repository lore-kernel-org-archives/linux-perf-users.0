From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/35] Revert "perf s390: Always build with -fPIC"
Date: Thu, 28 Dec 2017 11:30:21 -0300
Message-ID: <20171228143027.30547-30-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This one made x86 always build with -fPIC, when the intention was for
s390 to be built that way, due to a rebase mistake.

Reported-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
This reverts commit 1dc4ddf112a408e607a073d951b962b6c6e2bd6c.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6f73c2316740..eb6bd99be0bd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -43,7 +43,6 @@ ifeq ($(SRCARCH),x86)
     LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
   endif
   NO_PERF_REGS := 0
-  CFLAGS += -fPIC
 endif
 
 ifeq ($(SRCARCH),arm)
-- 
2.13.6
