From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/3] perf, tools, report: Handle samples without time
Date: Mon, 11 Mar 2019 20:52:22 -0700
Message-ID: <20190312035224.30350-2-andi@firstfloor.org>
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

When a sample doesn't have a time stamp (e.g. from --no-time),
show the beginning of the trace for res samples instead of generating
an impossible time range that errors out.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/ui/browsers/res_sample.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index c0dd73176d42..c450a3536f10 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -60,7 +60,9 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		return -1;
 	r = &res_samples[choice];
 
-	n = timestamp__scnprintf_nsec(r->time - context_len, trange, sizeof trange);
+	n = timestamp__scnprintf_nsec(r->time > context_len ?
+				      r->time - context_len : r->time,
+				      trange, sizeof trange);
 	trange[n++] = ',';
 	timestamp__scnprintf_nsec(r->time + context_len, trange + n, sizeof trange - n);
 
-- 
2.20.1
