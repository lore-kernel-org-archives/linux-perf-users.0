From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [Patchv2 0/3] perf report: Display CPU Measurement facility counter sets
Date: Thu, 17 Jan 2019 10:30:00 +0100
Message-ID: <20190117093003.96287-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

The CPU Measurement facility for counters supports the extraction
of complete counter sets via hardware instruction STCCTM (if
available).

This patch set displays the counter sets in the perf report tool.

V1 --> V2
1. Repackage event decoding and create an s390 specific file
   util/s390-sample-raw.c. It decodes the counter sets and is located
   in the common tree to enable decoding on other platforms (x86) as
   well.
2. Patch 3 unchanged

Thomas Richter (3):
  perf report: Display s390 diagnostic counter sets
  perf report: Display names in s390 diagnostic counter sets
  perf/report: s390 dump counter set data to file.

-- 
2.14.3
