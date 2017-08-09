From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 5/9] perf test 15: disable test-record-group tests on s390x
Date: Wed,  9 Aug 2017 08:40:36 +0200
Message-ID: <20170809064040.50899-5-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752208AbdHIGlC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:41:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796cplZ147213
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:41:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c7rp5wtcc-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:41:01 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:40:59 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x the CPUMF supports sampling of only one hardware
event, namely cycles. There grouping of multiple hardware
events is not supported.
Disable these tests for s390x.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/test-record-group          | 1 +
 tools/perf/tests/attr/test-record-group-sampling | 1 +
 tools/perf/tests/attr/test-record-group1         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
index 6e7961f..aa3885d 100644
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -2,6 +2,7 @@
 command = record
 args    = --group -e cycles,instructions kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index ef59afd..332dc28 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -2,6 +2,7 @@
 command = record
 args    = -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
index 87a222d..1f5359d 100644
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -2,6 +2,7 @@
 command = record
 args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event-1:base-record]
 fd=1
-- 
2.9.3
