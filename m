From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/40] perf jvmti: Fix linker error when libelf config is disabled
Date: Wed, 26 Jul 2017 11:17:17 -0300
Message-ID: <20170726141730.30750-28-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, Kees Kook <keescook@chromium.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sudeep Holla <Sudeep.Holla@arm.com>

When libelf is disabled in the configuration, we get the following
linker error:

  LINK     libperf-jvmti.so
  ld: cannot find -lelf
  Makefile.perf:515: recipe for target 'libperf-jvmti.so' failed

Jiri pointed out that both librt and libelf are not really required. So
this patch fixes the linker error by getting rid of unwanted libraries
in the linker stage.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 209045adc2bb ("perf tools: add JVMTI agent library")
Link: http://lkml.kernel.org/r/20170719011839.99399-5-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 100a6c1670c8..d66f90e6be5c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -518,7 +518,7 @@ $(LIBJVMTI_IN): FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-	$(QUIET_LINK)$(CC) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $< -lelf -lrt
+	$(QUIET_LINK)$(CC) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
 endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
-- 
2.9.4
