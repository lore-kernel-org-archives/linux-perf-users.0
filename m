From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/54] perf intel-pt: Adjust overlap-checking to support sampling mode
Date: Thu,  8 Mar 2018 16:50:13 -0300
Message-ID: <20180308195029.14991-39-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Adjust overlap-checking to support sampling mode.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-10-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 5c5c155fba78..0effaff57020 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -230,6 +230,7 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	struct auxtrace_buffer *buffer = ptq->buffer;
 	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
 	struct auxtrace_queue *queue;
+	bool might_overlap;
 
 	if (ptq->stop) {
 		b->len = 0;
@@ -256,7 +257,8 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 			return -ENOMEM;
 	}
 
-	if (ptq->pt->snapshot_mode && !buffer->consecutive && old_buffer &&
+	might_overlap = ptq->pt->snapshot_mode || ptq->pt->sampling_mode;
+	if (might_overlap && !buffer->consecutive && old_buffer &&
 	    intel_pt_do_fix_overlap(ptq->pt, old_buffer, buffer))
 		return -ENOMEM;
 
@@ -269,8 +271,7 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	}
 	b->ref_timestamp = buffer->reference;
 
-	if (!old_buffer || ptq->pt->sampling_mode || (ptq->pt->snapshot_mode &&
-						      !buffer->consecutive)) {
+	if (!old_buffer || (might_overlap && !buffer->consecutive)) {
 		b->consecutive = false;
 		b->trace_nr = buffer->buffer_nr + 1;
 	} else {
-- 
2.14.3
