From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/24] perf, bpf: Introduce PERF_RECORD_KSYMBOL
Date: Mon, 21 Jan 2019 20:56:56 -0300
Message-ID: <20190121235706.20005-15-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, netdev@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

For better performance analysis of dynamically JITed and loaded kernel
functions, such as BPF programs, this patch introduces
PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
register/unregister information to user space.

The following data structure is used for PERF_RECORD_KSYMBOL.

    /*
     * struct {
     *      struct perf_event_header        header;
     *      u64                             addr;
     *      u32                             len;
     *      u16                             ksym_type;
     *      u16                             flags;
     *      char                            name[];
     *      struct sample_id                sample_id;
     * };
     */

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h      |  8 +++
 include/uapi/linux/perf_event.h | 26 ++++++++-
 kernel/events/core.c            | 98 ++++++++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4eb88065a9b5..136fe0495374 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1122,6 +1122,10 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+
+extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
+			       bool unregister, const char *sym);
+
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1342,6 +1346,10 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+
+typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
+static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
+				      bool unregister, const char *sym)	{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ea19b5d491bf..1dee5c8f166b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				ksymbol        :  1, /* include ksymbol events */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -963,9 +964,32 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record ksymbol register/unregister events:
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u32				len;
+	 *	u16				ksym_type;
+	 *	u16				flags;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_KSYMBOL			= 17,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
+enum perf_record_ksymbol_type {
+	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
+	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
+};
+
+#define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
+
 #define PERF_MAX_STACK_DEPTH		127
 #define PERF_MAX_CONTEXTS_PER_STACK	  8
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bc525cd1615c..e04ab5f325cf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -385,6 +385,7 @@ static atomic_t nr_namespaces_events __read_mostly;
 static atomic_t nr_task_events __read_mostly;
 static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
+static atomic_t nr_ksymbol_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4235,7 +4236,7 @@ static bool is_sb_event(struct perf_event *event)
 
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
-	    attr->task ||
+	    attr->task || attr->ksymbol ||
 	    attr->context_switch)
 		return true;
 	return false;
@@ -4305,6 +4306,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (has_branch_stack(event))
 		dec = true;
+	if (event->attr.ksymbol)
+		atomic_dec(&nr_ksymbol_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7653,6 +7656,97 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 	perf_output_end(&handle);
 }
 
+/*
+ * ksymbol register/unregister tracking
+ */
+
+struct perf_ksymbol_event {
+	const char	*name;
+	int		name_len;
+	struct {
+		struct perf_event_header        header;
+		u64				addr;
+		u32				len;
+		u16				ksym_type;
+		u16				flags;
+	} event_id;
+};
+
+static int perf_event_ksymbol_match(struct perf_event *event)
+{
+	return event->attr.ksymbol;
+}
+
+static void perf_event_ksymbol_output(struct perf_event *event, void *data)
+{
+	struct perf_ksymbol_event *ksymbol_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int ret;
+
+	if (!perf_event_ksymbol_match(event))
+		return;
+
+	perf_event_header__init_id(&ksymbol_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				ksymbol_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, ksymbol_event->event_id);
+	__output_copy(&handle, ksymbol_event->name, ksymbol_event->name_len);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
+			const char *sym)
+{
+	struct perf_ksymbol_event ksymbol_event;
+	char name[KSYM_NAME_LEN];
+	u16 flags = 0;
+	int name_len;
+
+	if (!atomic_read(&nr_ksymbol_events))
+		return;
+
+	if (ksym_type >= PERF_RECORD_KSYMBOL_TYPE_MAX ||
+	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
+		goto err;
+
+	strlcpy(name, sym, KSYM_NAME_LEN);
+	name_len = strlen(name) + 1;
+	while (!IS_ALIGNED(name_len, sizeof(u64)))
+		name[name_len++] = '\0';
+	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));
+
+	if (unregister)
+		flags |= PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER;
+
+	ksymbol_event = (struct perf_ksymbol_event){
+		.name = name,
+		.name_len = name_len,
+		.event_id = {
+			.header = {
+				.type = PERF_RECORD_KSYMBOL,
+				.size = sizeof(ksymbol_event.event_id) +
+					name_len,
+			},
+			.addr = addr,
+			.len = len,
+			.ksym_type = ksym_type,
+			.flags = flags,
+		},
+	};
+
+	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL);
+	return;
+err:
+	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -9912,6 +10006,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (is_cgroup_event(event))
 		inc = true;
+	if (event->attr.ksymbol)
+		atomic_inc(&nr_ksymbol_events);
 
 	if (inc) {
 		/*
-- 
2.20.1
