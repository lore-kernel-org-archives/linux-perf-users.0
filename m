From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] perf, tools, report: Fix description for --mem-mode
Date: Fri,  9 Feb 2018 08:39:09 -0800
Message-ID: <20180209163909.9240-1-andi@firstfloor.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:4171 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbeBIQj2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Feb 2018 11:39:28 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

From: Andi Kleen <ak@linux.intel.com>

The mem-loads event only works when PEBS is enabled, so add
/p to the examples.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 907e505b6309..2884a9e2d27c 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -367,7 +367,7 @@ OPTIONS
 	Use the data addresses of samples in addition to instruction addresses
 	to build the histograms.  To generate meaningful output, the perf.data
 	file must have been obtained using perf record -d -W and using a
-	special event -e cpu/mem-loads/ or -e cpu/mem-stores/. See
+	special event -e cpu/mem-loads/p or -e cpu/mem-stores/p. See
 	'perf mem' for simpler access.
 
 --percent-limit::
-- 
2.14.3
