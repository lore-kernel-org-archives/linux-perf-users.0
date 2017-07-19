From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/86] perf pmu-events: Support additional POWER8+ PVR in mapfile
Date: Wed, 19 Jul 2017 11:28:52 -0300
Message-ID: <20170719142950.3747-29-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Shriya <shriyak@linux.vnet.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Shriya <shriyak@linux.vnet.ibm.com>

Add support for POWER8+ PVR 004c0100 for Garrison

Signed-off-by: Shriya <shriyak@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1497853842-11023-1-git-send-email-shriyak@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index e925baa0c30b..f03aec70dfc9 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -19,3 +19,4 @@
 004d0000,1,power8.json,core
 004d0100,1,power8.json,core
 004d0200,1,power8.json,core
+004c0100,1,power8.json,core
-- 
2.9.4
