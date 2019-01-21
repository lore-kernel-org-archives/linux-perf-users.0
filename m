From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/7] perf ordered_events: Fix crash in ordered_events__free
Date: Mon, 21 Jan 2019 15:35:01 -0300
Message-ID: <20190121183507.23490-2-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Song Liu <liu.song.a23@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Song Liu reported crash in 'perf record':

  > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
  > #1  0x0000000000500196 in ordered_events.reinit ()
  > #2  0x00000000004fe413 in perf_session.process_events ()
  > #3  0x0000000000440431 in cmd_record ()
  > #4  0x00000000004a439f in run_builtin ()
  > #5  0x000000000042b3e5 in main ()"

This can happen when we get out of buffers during event processing.

The subsequent ordered_events__free() call assumes oe->buffer != NULL
and crashes. Add a check to prevent that.

Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Song Liu <liu.song.a23@gmail.com>
Tested-by: Song Liu <liu.song.a23@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190117113017.12977-1-jolsa@kernel.org
Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 897589507d97..ea523d3b248f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
-- 
2.20.1
