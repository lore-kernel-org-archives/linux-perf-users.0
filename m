From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/3] perf: fix incorrect sample_type value for perf stat tests
Date: Tue,  6 Jun 2017 16:31:54 +0200
Message-ID: <20170606143156.10471-2-tmricht@linux.vnet.ibm.com>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52041 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751435AbdFFOc0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2017 10:32:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v56ETS5H102051
        for <linux-perf-users@vger.kernel.org>; Tue, 6 Jun 2017 10:32:12 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2awq378b2s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2017 10:32:11 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 6 Jun 2017 15:32:09 +0100
In-Reply-To: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>

Test case 14 runs 'perf stat' command to execute all
tests/attr/test-stat* test cases. They all fail with
a mismatch in sample_type attribute, for example:

running './tests/attr//test-stat-basic'
...
compare
  matchng [event:base-stat]
      to [event-0-0-4]
      ...
      [sample_type] 0 65536
  ->FAIL

The reason for the failure is in create_perf_stat_counter()
in file builtin-stat.c. When command 'perf stat record -o -'
is used the value of perf_event_stat.sample_type is not changed.
All other invocations of 'perf stat' change this
member to PERF_SAMPLE_IDENTIFIER (2^16).

None of the test-stat-* tests are invoked with
'perf stat record -o -' and the sample_type comparion fails.

Fix this by changing the expected value for attribute sample_type
in the base_stat file.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr/base-stat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index f4cf148..4a48d16 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -8,7 +8,7 @@ type=0
 size=112
 config=0
 sample_period=0
-sample_type=0
+sample_type=65536
 read_format=3
 disabled=1
 inherit=1
-- 
2.9.3
