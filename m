From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/31] perf vendor events arm64: Relocate ThunderX2 JSON to
 cavium subdirectory
Date: Tue, 13 Mar 2018 09:04:52 -0300
Message-ID: <20180313120508.29327-16-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.garry@huawei.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>, William Cohen <wcohen@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Since jevents now supports vendor subdirectory, relocate
the ThunderX2 JSON to Cavium subdirectory.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-6-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../cavium/{thunderx2-imp-def.json => thunderx2/core-imp-def.json}      | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/cavium/{thunderx2-imp-def.json => thunderx2/core-imp-def.json} (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
rename to tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index e61c9ca6cf9e..952a05cbf675 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,5 +12,5 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000420f5160,v1,cavium,core
+0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
2.14.3
