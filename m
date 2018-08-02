From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3] perf report: Add s390 auxiliary trace support
Date: Thu,  2 Aug 2018 09:46:19 +0200
Message-ID: <20180802074622.13641-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Add support for S390 CPU-Measurement Sampling Facility auxiliary 
trace data buffers.

Patch 1: Handle perf PERF_RECORD_AUXTRACE_INFO record for s390.
	Perf report on s390 does not terminate with an error
	message.
Patch 2: Display auxiliary trace data in raw (hex) format when
	perf report interprets the perf.data input file with
	option -D.
Patch 3: Display auxiliary trace in UI. Resolve addresses to
	symbols and file names.

Thomas Richter (4):
  perf auxtrace: Support for perf report -D for s390
  perf report: Add raw report support for s390 auxiliary trace
  perf report: Add GUI report support for s390 auxiliary trace

 tools/perf/arch/s390/util/auxtrace.c |   1 +
 tools/perf/util/Build                |   1 +
 tools/perf/util/auxtrace.c           |   3 +
 tools/perf/util/auxtrace.h           |   1 +
 tools/perf/util/s390-cpumsf-kernel.h |  71 ++
 tools/perf/util/s390-cpumsf.c        | 987 +++++++++++++++++++++++++++
 tools/perf/util/s390-cpumsf.h        |  21 +
 7 files changed, 1085 insertions(+)
 create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
 create mode 100644 tools/perf/util/s390-cpumsf.c
 create mode 100644 tools/perf/util/s390-cpumsf.h

-- 
2.17.0
