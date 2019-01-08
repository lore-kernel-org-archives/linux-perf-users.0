From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/16] tools lib traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()
Date: Tue,  8 Jan 2019 16:59:04 -0300
Message-ID: <20190108195910.17726-11-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API
should be straightforward.

After a discussion with Steven Rostedt, we decided to rename a few APIs,
to have more intuitive names.

This patch renames tep_is_file_bigendian() to tep_file_bigendian().

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.767549746@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 4 ++--
 tools/lib/traceevent/event-parse.h     | 2 +-
 tools/lib/traceevent/plugin_kvm.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 8b31c0e00ba3..d463761a58f4 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -194,13 +194,13 @@ void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 }
 
 /**
- * tep_is_file_bigendian - get if the file is in big endian order
+ * tep_file_bigendian - get if the file is in big endian order
  * @pevent: a handle to the tep_handle
  *
  * This returns if the file is in big endian order
  * If @pevent is NULL, 0 is returned.
  */
-int tep_is_file_bigendian(struct tep_handle *pevent)
+int tep_file_bigendian(struct tep_handle *pevent)
 {
 	if(pevent)
 		return pevent->file_bigendian;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index ac377ae99008..bd1bd9a27839 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -559,7 +559,7 @@ int tep_get_long_size(struct tep_handle *pevent);
 void tep_set_long_size(struct tep_handle *pevent, int long_size);
 int tep_get_page_size(struct tep_handle *pevent);
 void tep_set_page_size(struct tep_handle *pevent, int _page_size);
-int tep_is_file_bigendian(struct tep_handle *pevent);
+int tep_file_bigendian(struct tep_handle *pevent);
 void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian);
 int tep_is_host_bigendian(struct tep_handle *pevent);
 void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian);
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 754050eea467..64b9c25a1fd3 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -389,7 +389,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	 * We can only use the structure if file is of the same
 	 * endianness.
 	 */
-	if (tep_is_file_bigendian(event->pevent) ==
+	if (tep_file_bigendian(event->pevent) ==
 	    tep_is_host_bigendian(event->pevent)) {
 
 		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
-- 
2.20.1
