From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/13] perf jevents: Support FCMask and PortMask
Date: Mon, 21 Aug 2017 16:25:38 -0300
Message-ID: <20170821192549.17251-3-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Skylake server uncore IIO events need new FCMask/PortMask fields. Support
those in the json parser and pass it through as a filter.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170816220201.19182-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 2350f6099a46..d51dc9ca8861 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -137,6 +137,8 @@ static struct field {
 	{ "AnyThread",	"any=" },
 	{ "EdgeDetect",	"edge=" },
 	{ "SampleAfterValue", "period=" },
+	{ "FCMask",	"fc_mask=" },
+	{ "PortMask",	"ch_mask=" },
 	{ NULL, NULL }
 };
 
-- 
2.13.5
