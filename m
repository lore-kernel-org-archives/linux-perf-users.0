From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 3/3] perf, tools, report: Set up samples correctly in hierarchy mode
Date: Mon, 11 Mar 2019 20:52:24 -0700
Message-ID: <20190312035224.30350-4-andi@firstfloor.org>
References: <20190312035224.30350-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312035224.30350-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In hierarchy mode the res samples need to be cloned from the parent
entry. Copy them in this case. This fixes res sample browsing
with --hierarchy.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/hist.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1f230285d78a..dcf24581dfbd 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -437,8 +437,15 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	if (symbol_conf.res_sample) {
-		he->res_samples = calloc(sizeof(struct res_sample),
-					symbol_conf.res_sample);
+		if (he->res_samples) {
+			he->res_samples = memdup(he->res_samples,
+						sizeof(struct res_sample) *
+						symbol_conf.res_sample);
+		} else {
+			he->res_samples = calloc(sizeof(struct res_sample),
+						 symbol_conf.res_sample);
+			he->num_res = 0;
+		}
 		if (!he->res_samples)
 			goto err_srcline;
 	}
-- 
2.20.1
