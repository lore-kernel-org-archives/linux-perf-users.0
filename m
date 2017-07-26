From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/40] perf annotate: Process tracing data in pipe mode
Date: Wed, 26 Jul 2017 11:17:16 -0300
Message-ID: <20170726141730.30750-27-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, Kees Kook <keescook@chromium.org>, Paul Turner <pjt@google.com>, Stephane Eranian <eranian@google.com>, Sudeep Holla <sudeep.holla@arm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

'perf annotate' was missing the handler for tracing data records.

Prior to this patch we obtained "unhandled" records when piping trace
events to perf annotate (using -D option to show the dump_printf
messages in process_event_synth_tracing_data_stub):

  $ perf record -o - -e block:bio_free sleep 2 | perf annotate -D --stdio
  ...
  0x78 [0xc]: PERF_RECORD_TRACING_DATA: unhandled!
  ...

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Paul Turner <pjt@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170719011839.99399-4-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7e33278eff67..6db782dfce96 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -396,6 +396,7 @@ int cmd_annotate(int argc, const char **argv)
 			.namespaces = perf_event__process_namespaces,
 			.attr	= perf_event__process_attr,
 			.build_id = perf_event__process_build_id,
+			.tracing_data   = perf_event__process_tracing_data,
 			.feature	= perf_event__process_feature,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
-- 
2.9.4
