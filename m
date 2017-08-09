From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 7/9] perf test 15: disable test-record-graph-dwarf test on s390x
Date: Wed,  9 Aug 2017 08:40:38 +0200
Message-ID: <20170809064040.50899-7-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57569 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752208AbdHIGlE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:41:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796cc1D144628
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:41:04 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c7qvcr51t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:41:04 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:41:02 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

There is currently no stack unwinding support for dwarf
in the perf s390x architecture dependend code.
Disable this test for s390x.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/test-record-graph-dwarf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/attr/test-record-graph-dwarf b/tools/perf/tests/attr/test-record-graph-dwarf
index da2fa73..c7a22d8 100644
--- a/tools/perf/tests/attr/test-record-graph-dwarf
+++ b/tools/perf/tests/attr/test-record-graph-dwarf
@@ -2,6 +2,7 @@
 command = record
 args    = --call-graph dwarf -- kill >/dev/null 2>&1
 ret     = 1
+arch	= !s390x
 
 [event:base-record]
 sample_type=45359
@@ -10,3 +11,4 @@ sample_stack_user=8192
 # TODO different for each arch, no support for that now
 sample_regs_user=*
 mmap_data=1
+task=1
-- 
2.9.3
