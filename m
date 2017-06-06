From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf: fix exit code check in test case execution
Date: Tue,  6 Jun 2017 16:31:55 +0200
Message-ID: <20170606143156.10471-3-tmricht@linux.vnet.ibm.com>
References: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751624AbdFFOcU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2017 10:32:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v56ETWt1045219
        for <linux-perf-users@vger.kernel.org>; Tue, 6 Jun 2017 10:32:14 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2awm23ej5j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2017 10:32:14 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 6 Jun 2017 15:32:12 +0100
In-Reply-To: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>

Jiri Olsa's
Commit c9666c26ead0 ("perf tests attr: Make compare_data global")
introduced a wrong check on the command's return code exit status test:

  -        if ret != int(self.ret):
  +        if compare_data(str(ret), str(self.ret)):
             raise Unsup(self)

This check succeeds when the expected return code matches
the actual return code and raises the Unsup exceptions.
This is not correct.

Revert to the orignal check to raise the exception on
mismatch.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 5787879..d0242d8 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -174,7 +174,7 @@ class Test(object):
 
         log.info("  '%s' ret %d, expected %s" % (cmd, ret, str(self.ret)))
 
-        if compare_data(str(ret), str(self.ret)):
+        if ret != int(self.ret):
             raise Unsup(self)
 
     def compare(self, expect, result):
-- 
2.9.3
