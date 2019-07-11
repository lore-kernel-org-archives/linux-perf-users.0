From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/3] perf script: Fix --max-blocks man page description
Date: Thu, 11 Jul 2019 11:19:20 -0700
Message-ID: <20190711181922.18765-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The --max-blocks description was using the old name brstackasm.
Use brstackinsn instead.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index d4e2e18a5881..042b9e5dcc32 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -384,7 +384,7 @@ include::itrace.txt[]
 	perf script --time 0%-10%,30%-40%
 
 --max-blocks::
-	Set the maximum number of program blocks to print with brstackasm for
+	Set the maximum number of program blocks to print with brstackinsn for
 	each sample.
 
 --reltime::
-- 
2.20.1
