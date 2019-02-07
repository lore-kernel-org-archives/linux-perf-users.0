From: Paul Clarke <pc@us.ibm.com>
Subject: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics for POWER8
Date: Thu,  7 Feb 2019 12:53:10 -0500
Message-ID: <20190207175314.31813-1-pc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
List-Id: linux-perf-users.vger.kernel.org

The patches define metrics and metric groups for computation by "perf" for
POWER8 processors.

Paul Clarke (4):
  [powerpc] perf vendor events: Add JSON metrics for POWER8 1/4
  [powerpc] perf vendor events: Add JSON metrics for POWER8 2/4
  [powerpc] perf vendor events: Add JSON metrics for POWER8 3/4
  [powerpc] perf vendor events: Add JSON metrics for POWER8 4/4

v2:
The content of these patches was sent previously, to LKML and linux-perf-users,
but never showed up at linux-perf-users, so I split it into smaller patches
and am resending.

 .../arch/powerpc/power8/metrics.json          | 2245 +++++++++++++++++
 1 file changed, 2245 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json

-- 
2.17.1
