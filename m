From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/85] perf intel-pt: Document IPC usage
Date: Tue, 11 Jun 2019 15:58:01 -0300
Message-ID: <20190611185911.11645-16-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add brief documentation about instructions-per-cycle (IPC) information
derived from Intel PT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 60d99e5e7921..50c5b60101bd 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -103,6 +103,36 @@ The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
 in transaction, respectively.
 
+Another interesting field that is not printed by default is 'ipc' which can be
+displayed as follows:
+
+	perf script --itrace=be -F+ipc
+
+There are two ways that instructions-per-cycle (IPC) can be calculated depending
+on the recording.
+
+If the 'cyc' config term (see config terms section below) was used, then IPC is
+calculated using the cycle count from CYC packets, otherwise MTC packets are
+used - refer to the 'mtc' config term.  When MTC is used, however, the values
+are less accurate because the timing is less accurate.
+
+Because Intel PT does not update the cycle count on every branch or instruction,
+the values will often be zero.  When there are values, they will be the number
+of instructions and number of cycles since the last update, and thus represent
+the average IPC since the last IPC for that event type.  Note IPC for "branches"
+events is calculated separately from IPC for "instructions" events.
+
+Also note that the IPC instruction count may or may not include the current
+instruction.  If the cycle count is associated with an asynchronous branch
+(e.g. page fault or interrupt), then the instruction count does not include the
+current instruction, otherwise it does.  That is consistent with whether or not
+that instruction has retired when the cycle count is updated.
+
+Another note, in the case of "branches" events, non-taken branches are not
+presently sampled, so IPC values for them do not appear e.g. a CYC packet with a
+TNT packet that starts with a non-taken branch.  To see every possible IPC
+value, "instructions" events can be used e.g. --itrace=i0ns
+
 While it is possible to create scripts to analyze the data, an alternative
 approach is available to export the data to a sqlite or postgresql database.
 Refer to script export-to-sqlite.py or export-to-postgresql.py for more details,
-- 
2.20.1
