From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 4/9] perf: test 15 add s390x support for stat test cases
Date: Wed,  9 Aug 2017 08:40:35 +0200
Message-ID: <20170809064040.50899-4-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752008AbdHIGlA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:41:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796cvuU070666
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:41:00 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c7tj19xcw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:40:59 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:40:56 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

The perf test 15 test cases test-stat-detailed[123]
and test-stat-default fail for s390x.
The reason is missing support of the CPUMF facility
for some of the test.

The tests are now marked optional. On s390x some of the
individual tests still fail, but when marked as optional,
do not cause the complete test to fail.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/test-stat-default    |  4 ++++
 tools/perf/tests/attr/test-stat-detailed-1 | 12 ++++++++++++
 tools/perf/tests/attr/test-stat-detailed-2 | 22 ++++++++++++++++++++++
 tools/perf/tests/attr/test-stat-detailed-3 | 22 ++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
index e911dbd..0dc3ef0 100644
--- a/tools/perf/tests/attr/test-stat-default
+++ b/tools/perf/tests/attr/test-stat-default
@@ -54,13 +54,17 @@ type=0
 config=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
+# Optional on s390x
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
+# Optional on s390x
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
index b39270a..14ec910 100644
--- a/tools/perf/tests/attr/test-stat-detailed-1
+++ b/tools/perf/tests/attr/test-stat-detailed-1
@@ -55,49 +55,61 @@ type=0
 config=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
+# Optional on s390x
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
+# Optional on s390x
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event11:base-stat]
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event12:base-stat]
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event13:base-stat]
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event14:base-stat]
 fd=14
 type=3
 config=65538
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
index 45f8e6e..763e2f0 100644
--- a/tools/perf/tests/attr/test-stat-detailed-2
+++ b/tools/perf/tests/attr/test-stat-detailed-2
@@ -55,52 +55,64 @@ type=0
 config=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
+# Optional on s390x
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
+# Optional on s390x
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event11:base-stat]
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event12:base-stat]
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event13:base-stat]
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event14:base-stat]
 fd=14
 type=3
 config=65538
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -116,43 +128,53 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event16:base-stat]
 fd=16
 type=3
 config=65537
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event17:base-stat]
 fd=17
 type=3
 config=3
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event18:base-stat]
 fd=18
 type=3
 config=65539
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event19:base-stat]
 fd=19
 type=3
 config=4
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event20:base-stat]
 fd=20
 type=3
 config=65540
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
index 30ae0fb..5ed7ce6 100644
--- a/tools/perf/tests/attr/test-stat-detailed-3
+++ b/tools/perf/tests/attr/test-stat-detailed-3
@@ -55,52 +55,64 @@ type=0
 config=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
+# Optional on s390x
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
+# Optional on s390x
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event11:base-stat]
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event12:base-stat]
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event13:base-stat]
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event14:base-stat]
 fd=14
 type=3
 config=65538
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -116,46 +128,56 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event16:base-stat]
 fd=16
 type=3
 config=65537
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event17:base-stat]
 fd=17
 type=3
 config=3
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event18:base-stat]
 fd=18
 type=3
 config=65539
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
+# Optional on s390x
 [event19:base-stat]
 fd=19
 type=3
 config=4
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
+# Optional on s390x
 [event20:base-stat]
 fd=20
 type=3
 config=65540
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
-- 
2.9.3
