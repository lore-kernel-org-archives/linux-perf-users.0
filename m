From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 3/9] perf: test 15 fix test-stat-group tests
Date: Wed,  9 Aug 2017 08:40:34 +0200
Message-ID: <20170809064040.50899-3-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56873 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751974AbdHIGk4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:40:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796cZW0065022
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:40:56 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c7sxyjgmu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:40:55 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:40:54 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Both test-stat-group and test-stat-group1 fail.
The reason is an invalid check for the read_format
return code.  The submitted value is 15 and this
value should be returned by the perf_event_open() call
(which it is).
The comparison however is done against an invalid
value of 3.
Fix this by setting the expected read_format value.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/test-stat-group  | 2 ++
 tools/perf/tests/attr/test-stat-group1 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
index fdc1596..8fb3a50 100644
--- a/tools/perf/tests/attr/test-stat-group
+++ b/tools/perf/tests/attr/test-stat-group
@@ -6,10 +6,12 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=15
 
 [event-2:base-stat]
 fd=2
 group_fd=1
 config=1
 disabled=0
+read_format=15
 enable_on_exec=0
diff --git a/tools/perf/tests/attr/test-stat-group1 b/tools/perf/tests/attr/test-stat-group1
index 2a1f86e..086aa2f 100644
--- a/tools/perf/tests/attr/test-stat-group1
+++ b/tools/perf/tests/attr/test-stat-group1
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=15
-- 
2.9.3
