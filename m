From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/54] perf intel-pt: Remove a check for sampling mode
Date: Thu,  8 Mar 2018 16:50:12 -0300
Message-ID: <20180308195029.14991-38-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Intel PT code already has some preparation for AUX area sampling mode.

However the implementation has changed from the first proposal and one
of the side-effects is that it will not be impossible to support snapshot
mode and sampling mode at the same time.

Although there are no plans to support it, let validation (not yet
implemented) control whether it is allowed rather than low-level
functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-9-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9a4f9cdb752f..5c5c155fba78 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2061,9 +2061,6 @@ static int intel_pt_process_auxtrace_event(struct perf_session *session,
 	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
 					   auxtrace);
 
-	if (pt->sampling_mode)
-		return 0;
-
 	if (!pt->data_queued) {
 		struct auxtrace_buffer *buffer;
 		off_t data_offset;
-- 
2.14.3
