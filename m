From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/24] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
Date: Mon, 21 Jan 2019 20:56:57 -0300
Message-ID: <20190121235706.20005-16-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com, netdev@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Sync changes for PERF_RECORD_KSYMBOL.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-3-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ea19b5d491bf..1dee5c8f166b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
 
-- 
2.20.1
