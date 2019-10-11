From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/69] perf trace: Add array of chars scnprintf beautifier
Date: Fri, 11 Oct 2019 17:05:12 -0300
Message-ID: <20191011200559.7156-23-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Needed for sched's traceoints prev/next comm, where, unlike with
syscalls, we are not dealing with an integer or pointer, but an array
straight out from the ring buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rlll7tmcqe1g4odtaifil5re@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f30296c72415..b3fb208cbd30 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -91,6 +91,7 @@ struct syscall_arg_fmt {
 	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
+	u16	   nr_entries; // for arrays
 	bool	   show_zero;
 };
 
@@ -522,6 +523,16 @@ size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *ar
 	return scnprintf(bf, size, "%ld", arg->val);
 }
 
+static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct syscall_arg *arg)
+{
+	// XXX Hey, maybe for sched:sched_switch prev/next comm fields we can
+	//     fill missing comms using thread__set_comm()...
+	//     here or in a special syscall_arg__scnprintf_pid_sched_tp...
+	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries, arg->val);
+}
+
+#define SCA_CHAR_ARRAY syscall_arg__scnprintf_char_array
+
 static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
 	"MAP_GET_NEXT_KEY", "PROG_LOAD",
@@ -1491,7 +1502,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
 			arg->scnprintf = SCA_MODE_T;
-		else if ((strcmp(field->type, "int") == 0 ||
+		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstarts(field->type, "char")) {
+			arg->scnprintf = SCA_CHAR_ARRAY;
+			arg->nr_entries = field->arraylen;
+		} else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
 			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
-- 
2.21.0
