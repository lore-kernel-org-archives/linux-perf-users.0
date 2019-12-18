From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [PATCH 6/6] perf tools: arm-spe: fix record hang after being terminated
Date: Wed, 18 Dec 2019 15:54:55 +0800
Message-ID: <20191218075455.5106-7-tanxiaojun@huawei.com>
References: <20191218075455.5106-1-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191218075455.5106-1-tanxiaojun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com, James.Clark@arm.com, jeremy.linton@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, tanxiaojun@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Wei Li <liwei391@huawei.com>

If the spe event is terminated, we don't enable it again here.

Signed-off-by: Wei Li <liwei391@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..629badda724d 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -165,9 +165,13 @@ static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type)
-			return perf_evlist__enable_event_idx(sper->evlist,
-							     evsel, idx);
+		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
+			if (evsel->terminated)
+				return 0;
+			else
+				return perf_evlist__enable_event_idx(
+						sper->evlist, evsel, idx);
+		}
 	}
 	return -EINVAL;
 }
-- 
2.17.1
