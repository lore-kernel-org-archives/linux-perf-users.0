From: Alan Bartlett <ajb@elrepo.org>
Subject: [PATCH] perf build fix linux-4.4.X branch and RHEL7.4
Date: Sun, 12 Nov 2017 00:11:10 +0000
Message-ID: <5a07919e.z+O+Phd/vA/MPaXS%ajb@elrepo.org>
Reply-To: Alan Bartlett <ajb@elrepo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39471 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbdKLALO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Nov 2017 19:11:14 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: phil@elrepo.org, toracat@elrepo.org, acme@kernel.org, linux-perf-users@vger.kernel.org

[Please Cc me, as I am not subscribed to the list.]

With the update of RHEL7.3 to RHEL7.4 the perf sub-system
of the stable linux-4.4.X branch fails to build.

tools/perf/bench/futex.h:36:10: error: 'SYS_futex' undeclared
tools/perf/tests/mmap-thread-lookup.c:42:20: error: 'SYS_gettid' undeclared

Fix by inserting two conditional hash-defines.

Signed-off-by: Alan Bartlett <ajb@elrepo.org>
Cc: Akemi Yagi <toracat@elrepo.org>
Cc: Philip J Perry <phil@elrepo.org>

diff -Npru a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
--- a/tools/perf/bench/futex.h	2017-11-02 04:40:50.000000000 -0400
+++ b/tools/perf/bench/futex.h	2017-11-05 19:59:35.063971553 -0500
@@ -12,6 +12,10 @@
 #include <sys/types.h>
 #include <linux/futex.h>
 
+#ifndef SYS_futex
+#define SYS_futex __NR_futex
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
diff -Npru a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
--- a/tools/perf/tests/tests.h	2017-11-02 04:40:50.000000000 -0400
+++ b/tools/perf/tests/tests.h	2017-11-05 20:00:59.702007286 -0500
@@ -1,6 +1,10 @@
 #ifndef TESTS_H
 #define TESTS_H
 
+#ifndef SYS_gettid
+#define SYS_gettid __NR_gettid
+#endif
+
 #define TEST_ASSERT_VAL(text, cond)					 \
 do {									 \
 	if (!(cond)) {							 \
