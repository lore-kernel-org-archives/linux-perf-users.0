From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/54] perf auxtrace: Add missing parameters from kernel-doc comments
Date: Thu,  8 Mar 2018 16:49:50 -0300
Message-ID: <20180308195029.14991-16-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add missing parameters from kernel-doc comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 453c148d2158..e731f55da072 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -130,6 +130,7 @@ struct auxtrace_index {
 /**
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
+ * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
@@ -301,6 +302,7 @@ struct auxtrace_mmap_params {
  * @parse_snapshot_options: parse snapshot options
  * @reference: provide a 64-bit reference number for auxtrace_event
  * @read_finish: called after reading from an auxtrace mmap
+ * @alignment: alignment (if any) for AUX area data
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
-- 
2.14.3
