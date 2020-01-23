From: James Clark <james.clark@arm.com>
Subject: [PATCH v2 7/7] perf tools: Unset precise_ip when using SPE
Date: Thu, 23 Jan 2020 16:07:34 +0000
Message-ID: <20200123160734.3775-8-james.clark@arm.com>
References: <20200123160734.3775-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123160734.3775-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com, gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com, linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Tan Xiaojun <tanxiaojun@huawei.com>, Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

precise_ip is not supported on Arm and the kernel may be
updated to reflect this. So unset it when we know we can use
SPE to get precise data instead.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 0fcaefd386a6..0ed2a68db0b3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -937,6 +937,7 @@ void arm_spe_precise_ip_support(struct evlist *evlist, struct evsel *evsel)
 			evsel->core.attr.config = SPE_ATTR_TS_ENABLE
 						| SPE_ATTR_BRANCH_FILTER;
 			evsel->core.attr.config1 = SPE_ATTR_EV_BRANCH;
+			evsel->core.attr.precise_ip = 0;
 		}
 	}
 }
-- 
2.25.0
