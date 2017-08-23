From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/15] perf tools: Fix static linking with libunwind
Date: Wed, 23 Aug 2017 16:36:14 -0300
Message-ID: <20170823193614.20394-16-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932898AbdHWThH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2017 15:37:07 -0400
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

* libunwind-x86_64 must be linked before libunwind
* libunwind requires liblzma
* static libunwind conflicts with static libgcc_eh

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/150322917247.129799.14247751517961953155.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bb4735b92ada..6a64c6bbd9a5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -35,7 +35,7 @@ ifeq ($(SRCARCH),x86)
   ifeq (${IS_64_BIT}, 1)
     CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT -DHAVE_SYSCALL_TABLE -I$(OUTPUT)arch/x86/include/generated
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
-    LIBUNWIND_LIBS = -lunwind -lunwind-x86_64
+    LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
     $(call detected,CONFIG_X86_64)
   else
     LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
@@ -505,6 +505,10 @@ ifndef NO_LOCAL_LIBUNWIND
   EXTLIBS += $(LIBUNWIND_LIBS)
   LDFLAGS += $(LIBUNWIND_LIBS)
 endif
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  # gcc -static links libgcc_eh which contans piece of libunwind
+  LIBUNWIND_LDFLAGS += -Wl,--allow-multiple-definition
+endif
 
 ifndef NO_LIBUNWIND
   CFLAGS  += -DHAVE_LIBUNWIND_SUPPORT
-- 
2.13.5
