From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/44] tools lib traceevent: Add more debugging to see various internal ring buffer entries
Date: Tue,  2 Apr 2019 13:05:19 -0300
Message-ID: <20190402160549.13544-15-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

When trace-cmd report --debug is set, show the internal ring buffer
entries like time-extends and padding. This requires adding new kbuffer
API to retrieve these items.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164343.257591565@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/kbuffer-parse.c | 49 ++++++++++++++++++++++++++++
 tools/lib/traceevent/kbuffer.h       | 13 ++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index af2a1f3b7424..b887e7437d67 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -727,3 +727,52 @@ int kbuffer_start_of_data(struct kbuffer *kbuf)
 {
 	return kbuf->start;
 }
+
+/**
+ * kbuffer_raw_get - get raw buffer info
+ * @kbuf:	The kbuffer
+ * @subbuf:	Start of mapped subbuffer
+ * @info:	Info descriptor to fill in
+ *
+ * For debugging. This can return internals of the ring buffer.
+ * Expects to have info->next set to what it will read.
+ * The type, length and timestamp delta will be filled in, and
+ * @info->next will be updated to the next element.
+ * The @subbuf is used to know if the info is passed the end of
+ * data and NULL will be returned if it is.
+ */
+struct kbuffer_raw_info *
+kbuffer_raw_get(struct kbuffer *kbuf, void *subbuf, struct kbuffer_raw_info *info)
+{
+	unsigned long long flags;
+	unsigned long long delta;
+	unsigned int type_len;
+	unsigned int size;
+	int start;
+	int length;
+	void *ptr = info->next;
+
+	if (!kbuf || !subbuf)
+		return NULL;
+
+	if (kbuf->flags & KBUFFER_FL_LONG_8)
+		start = 16;
+	else
+		start = 12;
+
+	flags = read_long(kbuf, subbuf + 8);
+	size = (unsigned int)flags & COMMIT_MASK;
+
+	if (ptr < subbuf || ptr >= subbuf + start + size)
+		return NULL;
+
+	type_len = translate_data(kbuf, ptr, &ptr, &delta, &length);
+
+	info->next = ptr + length;
+
+	info->type = type_len;
+	info->delta = delta;
+	info->length = length;
+
+	return info;
+}
diff --git a/tools/lib/traceevent/kbuffer.h b/tools/lib/traceevent/kbuffer.h
index 03dce757553f..ed4d697fc137 100644
--- a/tools/lib/traceevent/kbuffer.h
+++ b/tools/lib/traceevent/kbuffer.h
@@ -65,4 +65,17 @@ int kbuffer_subbuffer_size(struct kbuffer *kbuf);
 void kbuffer_set_old_format(struct kbuffer *kbuf);
 int kbuffer_start_of_data(struct kbuffer *kbuf);
 
+/* Debugging */
+
+struct kbuffer_raw_info {
+	int			type;
+	int			length;
+	unsigned long long	delta;
+	void			*next;
+};
+
+/* Read raw data */
+struct kbuffer_raw_info *kbuffer_raw_get(struct kbuffer *kbuf, void *subbuf,
+					 struct kbuffer_raw_info *info);
+
 #endif /* _K_BUFFER_H */
-- 
2.20.1
