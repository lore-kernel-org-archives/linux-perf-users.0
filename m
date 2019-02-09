From: Paul Clarke <pc@us.ibm.com>
Subject: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics for POWER9
Date: Sat,  9 Feb 2019 13:14:25 -0500
Message-ID: <20190209181429.23950-1-pc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com
List-Id: linux-perf-users.vger.kernel.org

[Note this is for POWER*9* and is different content than a
previous patchset for POWER*8*.]

The patches define metrics and metric groups for computation by "perf"
for POWER9 processors.

Paul Clarke (4):
  [powerpc] perf vendor events: Add JSON metrics for POWER9
  [powerpc] perf vendor events: Add JSON metrics for POWER9
  [powerpc] perf vendor events: Add JSON metrics for POWER9
  [powerpc] perf vendor events: Add JSON metrics for POWER9

v2:
The content of these patches was sent previously, to LKML and
linux-perf-users, but never showed up at linux-perf-users, so
I split it into smaller patches and am resending.

 .../arch/powerpc/power9/metrics.json          | 1982 +++++++++++++++++
 1 file changed, 1982 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json

-- 
2.17.1
