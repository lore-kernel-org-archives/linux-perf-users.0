From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCHv2 2/9] perf test: perf test case 15 result ignored
Date: Wed,  9 Aug 2017 14:13:45 +0200
Message-ID: <20170809121345.76966-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55057 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752546AbdHIMOV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 08:14:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v79CEG9Q095186
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 08:14:20 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c815nutbu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 08:14:19 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 13:13:52 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@redhat.com, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

I have rebased this patch on todays perf/core branch from acme
and it applies cleanly now. All the other patches applied cleanly
without any changes. Hope this helps.

Command perf test -v 15 (Setup struct perf_event_attr test)
always reports success even if the test case fails.
It works correctly if you also specify -F (for don't fork).

   root@s35lp76 perf]# ./perf test -v 15
   15: Setup struct perf_event_attr               :
   --- start ---
   running './tests/attr/test-record-no-delay'
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.002 MB /tmp/tmp4E1h7R/perf.data
     (1 samples) ]
   expected task=0, got 1
   expected precise_ip=0, got 3
   expected wakeup_events=1, got 0
   FAILED './tests/attr/test-record-no-delay' - match failure
   test child finished with 0
   ---- end ----
   Setup struct perf_event_attr: Ok

The reason for the wrong error reporting is the return value of the
system() library call. It is called in run_dir() file tests/attr.c
and returns the exit status, in above case 0xff00.
This value is given as parameter to the exit() function which
can only handle values 0-0xff.
The child process terminates with exit value of 0 and the parent
does not detect any error.

This patch corrects the error reporting and prints the
correct test result.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index c9aafed..25ede44 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -166,7 +166,7 @@ static int run_dir(const char *d, const char *perf)
 	snprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
 		 d, d, perf, vcnt, v);
 
-	return system(cmd);
+	return system(cmd) ? TEST_FAIL : TEST_OK;
 }
 
 int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.9.4
