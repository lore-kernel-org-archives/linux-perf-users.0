From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf trace: Warn about --call-graph dwarf invalid parameters
Date: Thu, 11 Jan 2018 15:16:57 +0100
Message-ID: <20180111141657.14000-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932314AbeAKORO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Jan 2018 09:17:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0BEFoWl085247
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jan 2018 09:17:14 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fe7rxdbhj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jan 2018 09:17:13 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 11 Jan 2018 14:17:11 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

When invoking ./perf trace --call-graph fp|lbr with
additional parameters a warning is printed that these
additional comma separated parameters are silently ignored.

[root@f27 perf]# ./perf trace -vv --no-syscalls --call-graph lbr,1024
callchain: No more arguments needed for --call-graph lbr
[root@f27 perf]#

This does not happen for --call-graph dwarf,4096,4. The additional
parameter 4 is silently ignored and no warning printed.

Before:
[root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf,4096,4
Please specify something to trace.
[root@f27 perf]#

After:
[root@s35lp76 perf]# ./perf trace --no-syscalls --call-graph dwarf,4096,4
callchain: No more arguments needed for --call-graph dwarf[,xxx]
Please specify something to trace.
[root@s35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/util/callchain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 082505d08d72..59292d582894 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -272,6 +272,10 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 
 				ret = get_stack_size(tok, &size);
 				param->dump_size = size;
+				if (strtok_r(NULL, ",", &saveptr)) {
+					pr_err("callchain: No more arguments "
+					       "needed for --call-graph dwarf[,xxx]\n");
+				}
 			}
 		} else if (!strncmp(name, "lbr", sizeof("lbr"))) {
 			if (!strtok_r(NULL, ",", &saveptr)) {
-- 
2.13.4
