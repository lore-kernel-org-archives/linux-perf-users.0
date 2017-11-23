From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: disable test cases 19 and 20 on s390x
Date: Thu, 23 Nov 2017 08:46:23 +0100
Message-ID: <20171123074623.20817-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750880AbdKWHqg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 02:46:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAN7iDB7013861
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2017 02:46:36 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eds3gkeb9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2017 02:46:35 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 23 Nov 2017 07:46:34 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, =schwidefsky@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

The s390x CPU sampling and measurement facilities do not
support perf events of type PERF_TYPE_BREAKPOINT. The
test cases are executed and fail with -ENOENT due to
missing hardware support.

Disable the execution of both test cases based on a
platform check. This is the same approach as done for
PowerPC.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 335b695f4970..a467615c5a0e 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -296,7 +296,7 @@ bool test__bp_signal_is_supported(void)
  * instruction breakpoint using the perf event interface.
  * Once it's there we can release this.
  */
-#ifdef __powerpc__
+#if defined(__powerpc__) || defined(__s390x__)
 	return false;
 #else
 	return true;
-- 
2.13.4
