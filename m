From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/36] perf test: Disable test cases 19 and 20 on s390x
Date: Wed,  6 Dec 2017 11:40:41 -0300
Message-ID: <20171206144115.15097-3-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

The s390x CPU sampling and measurement facilities do not support perf
events of type PERF_TYPE_BREAKPOINT. The test cases are executed and
fail with -ENOENT due to missing hardware support.

Disable the execution of both test cases based on a
platform check. This is the same approach as done for
PowerPC.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
LPU-Reference: 20171123074623.20817-1-tmricht@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-uqvoy6a1tsu8jddo5jjg4h85@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 335b695f4970..a467615c5a0e 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -296,7 +296,7 @@ bool test__bp_signal_is_supported(void)
  * instruction breakpoint using the perf event interface.
  * Once it's there we can release this.
  */
-#ifdef __powerpc__
+#if defined(__powerpc__) || defined(__s390x__)
 	return false;
 #else
 	return true;
-- 
2.13.6
