From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3] Fix OOM in perf report on s390
Date: Wed, 22 May 2019 16:45:58 +0200
Message-ID: <20190522144601.50763-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

This patch set fixes OOM scenarios on s390 when commands
perf top or perf report are executed. This often happens
when debuginfo packages are not installed. Root users
and non-root users are both affected.

Patch 1: Do not allocate memory for histograms when
         the symbol is not of type function.
Patch 2: Reduce the gap between kernel end and and first
         module start address on perf record.
Patch 3: Create module maps for non-root user during
         perf record on s390.

Thomas Richter (3):
  perf report: Fix OOM error in TUI mode on s390
  perf record: Fix kallsym map size for s390
  perf record: Fix s390 missing module symbol and warning for non-root
    users

 tools/perf/arch/s390/util/machine.c |  9 ++++++---
 tools/perf/util/annotate.c          |  2 +-
 tools/perf/util/event.c             |  4 ++--
 tools/perf/util/machine.c           | 29 +++++++++++++++++++++++------
 4 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.19.1
