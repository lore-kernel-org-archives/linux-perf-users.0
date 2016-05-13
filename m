From: William Cohen <wcohen@redhat.com>
Subject: Lack of aarch64 checks for perf events schedulability
Date: Fri, 13 May 2016 11:33:02 -0400
Message-ID: <5ce079ab-2a31-36f1-713a-8b355888e73d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E92839234C2127822D0D7E80"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54460 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbcEMPdE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 11:33:04 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, PAPI Developers <perfapi-devel@cs.utk.edu>, Michael Petlan <mpetlan@redhat.com>

This is a multi-part message in MIME format.
--------------E92839234C2127822D0D7E80
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

When running the PAPI testsuite on RHEL for aarch64 Michael Petlan
found that the test overflow_allcounters was failing.  I investigated
and it looks like the the RHEL for aarch64 linux kernel perf support
suffers from a problem similar to MIPS kernels where perf_event_open
doesn't properly check that events can be scheduled together; then a
later read of the counters will fail.  This has been observed on the
RHEL for aarch64 4.5.0 based kernel. I have not tried this on the
latest kernel, so I don't know if this is still a problem with newer
kernels.

As a workaround papi's check for MIPS can be expanded for aarch64 as
the attached patch.  However, it would be better if the
perf_event_open schedule checks worked properly for aarch64.

-Will Cohen


--------------E92839234C2127822D0D7E80
Content-Type: text/x-patch;
 name="papi_sched_aarch64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="papi_sched_aarch64.patch"

diff -up papi-5.2.0/src/components/perf_event/perf_event.c.sched_aarch64 papi-5.2.0/src/components/perf_event/perf_event.c
--- papi-5.2.0/src/components/perf_event/perf_event.c.sched_aarch64	2016-05-13 11:07:29.509101953 -0400
+++ papi-5.2.0/src/components/perf_event/perf_event.c	2016-05-13 11:08:16.520550544 -0400
@@ -159,8 +159,8 @@ bug_check_scheduability(void) {
 
 #if defined(__powerpc__)
   /* PowerPC not affected by this bug */
-#elif defined(__mips__)
-  /* MIPS as of kernel 3.1 does not properly detect schedulability */
+#elif defined(__mips__) || defined(__aarch64__)
+  /* MIPS and aarch64 kernels do not properly detect schedulability */
   return 1;
 #else
   if (_papi_os_info.os_version < LINUX_VERSION(2,6,33)) return 1;

--------------E92839234C2127822D0D7E80--
