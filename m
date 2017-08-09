From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 8/9] perf: test 15 change period and frequency for s390x
Date: Wed,  9 Aug 2017 08:40:39 +0200
Message-ID: <20170809064040.50899-8-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57659 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752322AbdHIGlG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:41:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796cbAB144583
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:41:06 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c7qvcr53q-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:41:05 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:41:04 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

The perf record command can specify sampling period and frequency.
For s390x both values are too slow and needs to be increased.
On s390x there is a minimum value and when the specified
command line value is too low, the perf_event_system call
fails.
I have successfully tested these new values on Intel.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/test-record-count  | 4 ++--
 tools/perf/tests/attr/test-record-period | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/attr/test-record-count b/tools/perf/tests/attr/test-record-count
index 34f6cc5..34788fe 100644
--- a/tools/perf/tests/attr/test-record-count
+++ b/tools/perf/tests/attr/test-record-count
@@ -1,9 +1,9 @@
 [config]
 command = record
-args    = -c 123 kill >/dev/null 2>&1
+args    = -c 100000 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=123
+sample_period=100000
 sample_type=7
 freq=0
diff --git a/tools/perf/tests/attr/test-record-period b/tools/perf/tests/attr/test-record-period
index 69bc748..6b53250 100644
--- a/tools/perf/tests/attr/test-record-period
+++ b/tools/perf/tests/attr/test-record-period
@@ -1,8 +1,8 @@
 [config]
 command = record
-args    = -c 100 -P kill >/dev/null 2>&1
+args    = -c 100000 -P kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=100
+sample_period=100000
 freq=0
-- 
2.9.3
