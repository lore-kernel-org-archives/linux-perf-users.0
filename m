From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH 0/2] perf: Fix POWER9 cpi_breakdown metricgroup
Date: Thu,  7 May 2020 11:28:56 -0500
Message-ID: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au, irogers@google.com
List-Id: linux-perf-users.vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

The recent patches posted by Ian Rogers motivated a deeper dive into
the POWER9 perf metrics, which uncovered some additional issues:

- 'lsu_other_stall_cpi' doesn't work at all
- All of the "ICT" metrics are missing from the metricgroup

Paul A. Clarke (2):
  perf: Fix POWER9 metric 'lsu_other_stall_cpi'
  perf: Add missing metrics to POWER9 'cpi_breakdown'

 .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
 tools/perf/util/expr.h                        |   2 +-
 2 files changed, 79 insertions(+), 66 deletions(-)

-- 
2.18.2
