From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/19] perf vendor events powerpc: remove suffix in mapfile
Date: Mon, 14 Aug 2017 13:27:24 -0300
Message-ID: <20170814162741.6101-3-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Drop the .json suffix for events directory in the mapfile.csv.

Now that we have separate JSON files for each topic in a CPU (eg: see
tools/perf/pmu-events/arch/powerpc/power8/*.json) the .json suffix in
the mapfile is misleading and redundant.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20170802174617.GA32545@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index 14318ef215f8..a0f3a11ca19f 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -13,13 +13,13 @@
 #
 
 # Power8 entries
-004b0000,1,power8.json,core
-004b0201,1,power8.json,core
-004c0000,1,power8.json,core
-004d0000,1,power8.json,core
-004d0100,1,power8.json,core
-004d0200,1,power8.json,core
-004c0100,1,power8.json,core
-004e0100,1,power9.json,core
-004e0200,1,power9.json,core
-004e1200,1,power9.json,core
+004b0000,1,power8,core
+004b0201,1,power8,core
+004c0000,1,power8,core
+004d0000,1,power8,core
+004d0100,1,power8,core
+004d0200,1,power8,core
+004c0100,1,power8,core
+004e0100,1,power9,core
+004e0200,1,power9,core
+004e1200,1,power9,core
-- 
2.13.4
