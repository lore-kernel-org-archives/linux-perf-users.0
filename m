From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 9/9] perf: test 15 fix expected task value.
Date: Wed,  9 Aug 2017 08:40:40 +0200
Message-ID: <20170809064040.50899-9-tmricht@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752137AbdHIGlK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 02:41:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v796cwkL070752
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 02:41:10 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c7tj19xnr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 02:41:09 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 07:41:07 +0100
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Running perf test 15 (event attr test) the expected value
for task is 1. This can be seen with:

[root@oc2666213455 ~]# perf record -vv -b -- sleep 1
------------------------------------------------------------
perf_event_attr:
  size                             104
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|PERIOD|BRANCH_STACK
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
[...]

Change the expected task value from 0 to 1 in the base-record
file to match the correct results and report success for the
test-record-* test cases.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/base-record | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 31e0b1d..3794066 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -23,7 +23,7 @@ comm=1
 freq=1
 inherit_stat=0
 enable_on_exec=1
-task=0
+task=1
 watermark=0
 precise_ip=0|1|2|3
 mmap_data=0
-- 
2.9.3
