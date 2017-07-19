From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/86] perf vendor events: Add POWER9 PVRs to mapfile
Date: Wed, 19 Jul 2017 11:28:54 -0300
Message-ID: <20170719142950.3747-31-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shriya <shriyak@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Add currently supported POWER9 PVRs to the mapfile

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shriya <shriyak@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/n/tip-k1pe02sn5gh6nrzp8ditye94@git.kernel.org
[ Fix conflict with a87006fd5629 ("perf pmu-events: Support additional POWER8+ PVR in mapfile") ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index f03aec70dfc9..14318ef215f8 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -20,3 +20,6 @@
 004d0100,1,power8.json,core
 004d0200,1,power8.json,core
 004c0100,1,power8.json,core
+004e0100,1,power9.json,core
+004e0200,1,power9.json,core
+004e1200,1,power9.json,core
-- 
2.9.4
