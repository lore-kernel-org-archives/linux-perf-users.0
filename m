From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/35] perf arm spe: Fix uninitialized record error variable
Date: Wed, 15 Aug 2018 12:06:06 -0300
Message-ID: <20180815150611.32080-31-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

The auxtrace init variable 'err' was not being initialized, leading perf
to abort early in an SPE record command when there was no explicit
error, rather only based whatever memory contents were on the stack.
Initialize it explicitly on getting an SPE successfully, the same way
cs-etm does.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: ffd3d18c20b8 ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
Link: http://lkml.kernel.org/r/20180810174512.52900813e57cbccf18ce99a2@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1120e39c1b00..5ccfce87e693 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -194,6 +194,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->itr.read_finish = arm_spe_read_finish;
 	sper->itr.alignment = 0;
 
+	*err = 0;
 	return &sper->itr;
 }
 
-- 
2.14.4
