From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 2/3] tools/perf/testsuite: Adding a skeleton for future
 testcases
Date: Thu, 22 Oct 2015 01:08:57 +0200
Message-ID: <1445468937.12960.119.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756534AbbJUXI6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Oct 2015 19:08:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id D7F618E221
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 23:08:58 +0000 (UTC)
Received: from [10.34.1.123] (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9LN8v0w008052
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 19:08:58 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


The skeleton should be a specimen for future testcases.
---
 tools/perf/testsuite/base_skeleton/cleanup.sh  | 16 +++++++++++
 tools/perf/testsuite/base_skeleton/settings.sh | 10 +++++++
 tools/perf/testsuite/base_skeleton/setup.sh    | 16 +++++++++++
 tools/perf/testsuite/base_skeleton/test_01.sh  | 40 ++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)
 create mode 100755 tools/perf/testsuite/base_skeleton/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_skeleton/settings.sh
 create mode 100755 tools/perf/testsuite/base_skeleton/setup.sh
 create mode 100755 tools/perf/testsuite/base_skeleton/test_01.sh

diff --git a/tools/perf/testsuite/base_skeleton/cleanup.sh b/tools/perf/testsuite/base_skeleton/cleanup.sh
new file mode 100755
index 0000000..21ca683
--- /dev/null
+++ b/tools/perf/testsuite/base_skeleton/cleanup.sh
@@ -0,0 +1,16 @@
+#
+#	cleanup.sh of SKELETON test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+print_overall_results 0
+exit 0
diff --git a/tools/perf/testsuite/base_skeleton/settings.sh b/tools/perf/testsuite/base_skeleton/settings.sh
new file mode 100644
index 0000000..6bbffc0
--- /dev/null
+++ b/tools/perf/testsuite/base_skeleton/settings.sh
@@ -0,0 +1,10 @@
+#
+#	settings.sh of SKELETON test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="SKELETON"
diff --git a/tools/perf/testsuite/base_skeleton/setup.sh b/tools/perf/testsuite/base_skeleton/setup.sh
new file mode 100755
index 0000000..41fbbf5
--- /dev/null
+++ b/tools/perf/testsuite/base_skeleton/setup.sh
@@ -0,0 +1,16 @@
+#
+#	setup.sh of SKELETON test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+print_overall_results 0
+exit 0
diff --git a/tools/perf/testsuite/base_skeleton/test_01.sh b/tools/perf/testsuite/base_skeleton/test_01.sh
new file mode 100755
index 0000000..34aa973
--- /dev/null
+++ b/tools/perf/testsuite/base_skeleton/test_01.sh
@@ -0,0 +1,40 @@
+#
+#	test_01 of SKELETON test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0`
+TEST_RESULT=0
+
+
+# testcases
+
+# format:
+# print_results $PERF_COMMAND_EXIT_CODE $REGEXP_PARSER_EXIT_CODE "comment (subtest name, etc...)"
+
+print_results 0 0 "some	 passing test 01"
+(( TEST_RESULT += $? ))
+
+print_results 0 0 "some passing test 02"
+(( TEST_RESULT += $? ))
+
+print_results 1 0 "some test failing on perf command"
+(( TEST_RESULT += $? ))
+
+print_results 0 1 "some test failing on parsing output"
+(( TEST_RESULT += $? ))
+
+print_results 1 1 "some completely failing test"
+(( TEST_RESULT += $? ))
+
+# print results
+print_overall_results 3
-- 
1.8.3.1
