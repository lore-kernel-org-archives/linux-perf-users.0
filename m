From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 6/9] perf test 15: disable test-record-filter tests on s390x
Date: Wed,  9 Aug 2017 08:40:37 +0200
Message-ID: <20170809064040.50899-6-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57151 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752008AbdHIGlC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:41:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796caRu065050
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:41:01 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c7sxyjgse-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:41:01 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:40:59 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x the CPUMF does not support sampling of branch
events.  Disable these tests for s390x.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/test-record-branch-any             | 1 +
 tools/perf/tests/attr/test-record-branch-filter-any      | 1 +
 tools/perf/tests/attr/test-record-branch-filter-any_call | 1 +
 tools/perf/tests/attr/test-record-branch-filter-any_ret  | 1 +
 tools/perf/tests/attr/test-record-branch-filter-hv       | 1 +
 tools/perf/tests/attr/test-record-branch-filter-ind_call | 1 +
 tools/perf/tests/attr/test-record-branch-filter-k        | 1 +
 tools/perf/tests/attr/test-record-branch-filter-u        | 1 +
 8 files changed, 8 insertions(+)

diff --git a/tools/perf/tests/attr/test-record-branch-any b/tools/perf/tests/attr/test-record-branch-any
index 81f839e..348bd18 100644
--- a/tools/perf/tests/attr/test-record-branch-any
+++ b/tools/perf/tests/attr/test-record-branch-any
@@ -2,6 +2,7 @@
 command = record
 args    = -b kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any b/tools/perf/tests/attr/test-record-branch-filter-any
index 357421f..a99e743 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any
+++ b/tools/perf/tests/attr/test-record-branch-filter-any
@@ -2,6 +2,7 @@
 command = record
 args    = -j any kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_call b/tools/perf/tests/attr/test-record-branch-filter-any_call
index dbc55f2..bb13ebe 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_call
@@ -2,6 +2,7 @@
 command = record
 args    = -j any_call kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_ret b/tools/perf/tests/attr/test-record-branch-filter-any_ret
index a0824ff..9d21181 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_ret
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_ret
@@ -2,6 +2,7 @@
 command = record
 args    = -j any_ret kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-hv b/tools/perf/tests/attr/test-record-branch-filter-hv
index f34d6f1..c1c412d 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-hv
+++ b/tools/perf/tests/attr/test-record-branch-filter-hv
@@ -2,6 +2,7 @@
 command = record
 args    = -j hv kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-ind_call b/tools/perf/tests/attr/test-record-branch-filter-ind_call
index b86a352..187fa31 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-ind_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-ind_call
@@ -2,6 +2,7 @@
 command = record
 args    = -j ind_call kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-k b/tools/perf/tests/attr/test-record-branch-filter-k
index d3fbc5e..236a2b0 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-k
+++ b/tools/perf/tests/attr/test-record-branch-filter-k
@@ -2,6 +2,7 @@
 command = record
 args    = -j k kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
diff --git a/tools/perf/tests/attr/test-record-branch-filter-u b/tools/perf/tests/attr/test-record-branch-filter-u
index a318f0d..518c823 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-u
+++ b/tools/perf/tests/attr/test-record-branch-filter-u
@@ -2,6 +2,7 @@
 command = record
 args    = -j u kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=2311
-- 
2.9.3
