From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/28] perf trace beauty: Allow syscalls to mask an argument before considering it
Date: Wed, 31 Oct 2018 13:44:45 -0300
Message-ID: <20181031164508.4784-6-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Benjamin Peterson <benjamin@python.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Take mount's 'flags' arg, to cope with this semantic, as defined in do_mount in fs/namespace.c:

  /*
   * Pre-0.97 versions of mount() didn't have a flags word.  When the
   * flags word was introduced its top half was required to have the
   * magic value 0xC0ED, and this remained so until 2.4.0-test9.
   * Therefore, if this magic number is present, it carries no
   * information and must be discarded.
   */

We need to mask this arg, and then see if it is zero, when we simply
don't print the arg name and value.

The next patch will use this for mount's 'flag' arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-btue14k5jemayuykfrwsnh85@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7081d7ea12e5..14fb63e17de5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -614,6 +614,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
 	bool	   show_zero;
@@ -1487,6 +1488,19 @@ static size_t syscall__scnprintf_name(struct syscall *sc, char *bf, size_t size,
 	return scnprintf(bf, size, "arg%d: ", arg->idx);
 }
 
+/*
+ * Check if the value is in fact zero, i.e. mask whatever needs masking, such
+ * as mount 'flags' argument that needs ignoring some magic flag, see comment
+ * in tools/perf/trace/beauty/mount_flags.c
+ */
+static unsigned long syscall__mask_val(struct syscall *sc, struct syscall_arg *arg, unsigned long val)
+{
+	if (sc->arg_fmt && sc->arg_fmt[arg->idx].mask_val)
+		return sc->arg_fmt[arg->idx].mask_val(arg, val);
+
+	return val;
+}
+
 static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
 				     struct syscall_arg *arg, unsigned long val)
 {
@@ -1535,6 +1549,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				continue;
 
 			val = syscall_arg__val(&arg, arg.idx);
+			/*
+			 * Some syscall args need some mask, most don't and
+			 * return val untouched.
+			 */
+			val = syscall__mask_val(sc, &arg, val);
 
 			/*
  			 * Suppress this argument if its value is zero and
-- 
2.14.4
