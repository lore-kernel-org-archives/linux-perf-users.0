From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH 7/8] tools/perf: Enable Hz/hz prinitg for --metric-only option
Date: Fri, 14 Feb 2020 16:33:34 +0530
Message-ID: <20200214110335.31483-8-kjain@linux.ibm.com>
References: <20200214110335.31483-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214110335.31483-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Commit 54b5091606c18 ("perf stat: Implement --metric-only mode")
added function 'valid_only_metric()' which drops "Hz" or "hz",
if it is part of "ScaleUnit". This patch enable it since hv_24x7
supports couple of frequency events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/util/stat-display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bc31fccc0057..22dcdfbb9e10 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -236,8 +236,6 @@ static bool valid_only_metric(const char *unit)
 	if (!unit)
 		return false;
 	if (strstr(unit, "/sec") ||
-	    strstr(unit, "hz") ||
-	    strstr(unit, "Hz") ||
 	    strstr(unit, "CPUs utilized"))
 		return false;
 	return true;
-- 
2.18.1
