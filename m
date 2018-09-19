From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/13] perf: Suppress AUX/OVERWRITE records
Date: Wed, 19 Sep 2018 11:25:25 -0300
Message-ID: <20180919142537.29985-2-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Markus T Metzger <markus.t.metzger@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

It has been pointed out to me many times that it is useful to be able to
switch off AUX records to save the bandwidth for records that actually
matter, for example, in AUX overwrite mode.

The usefulness of PERF_RECORD_AUX is in some of its flags, like the
TRUNCATED flag that tells the decoder where exactly gaps in the trace
are.  The OVERWRITE flag, on the other hand will be set on every single
record in overwrite mode. However, a PERF_RECORD_AUX[flags=OVERWRITE] is
generated on every target task's sched_out, which over time adds up to a
lot of useless information.

If any folks out there have userspace that depends on a constant stream
of OVERWRITE records for a good reason, they'll have to let us know.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Link: http://lkml.kernel.org/r/20180404145323.28651-1-alexander.shishkin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/ring_buffer.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5d3cf407e374..4a9937076331 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -459,10 +459,20 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	if (size || handle->aux_flags) {
 		/*
 		 * Only send RECORD_AUX if we have something useful to communicate
+		 *
+		 * Note: the OVERWRITE records by themselves are not considered
+		 * useful, as they don't communicate any *new* information,
+		 * aside from the short-lived offset, that becomes history at
+		 * the next event sched-in and therefore isn't useful.
+		 * The userspace that needs to copy out AUX data in overwrite
+		 * mode should know to use user_page::aux_head for the actual
+		 * offset. So, from now on we don't output AUX records that
+		 * have *only* OVERWRITE flag set.
 		 */
 
-		perf_event_aux_event(handle->event, aux_head, size,
-		                     handle->aux_flags);
+		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
+			perf_event_aux_event(handle->event, aux_head, size,
+			                     handle->aux_flags);
 	}
 
 	rb->user_page->aux_head = rb->aux_head;
-- 
2.14.4
