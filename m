From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/18] perf trace beauty ioctl: Improve 'cmd' beautifier
Date: Tue,  1 Aug 2017 16:56:35 -0300
Message-ID: <20170801195645.16986-9-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By using the _IOC_(DIR,NR,TYPE,SIZE) macros to lookup a 'type' keyed
table that then gets indexed by 'nr', falling back to a notation similar
to the one used by 'strace', only more compact, i.e.:

   474.356 ( 0.007 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: (READ|WRITE, 0x64, 0xae, 0x1c), arg: 0x7ffc934f7880) = 0
   474.369 ( 0.053 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: (READ|WRITE, 0x64, 0xb0, 0x18), arg: 0x7ffc934f77d0) = 0
   505.055 ( 0.014 ms): gnome-shell/22401 ioctl(fd: 8</dev/dri/card0>, cmd: (READ|WRITE, 0x64, 0xaf, 0x4), arg: 0x7ffc934f741c) = 0

This also moves it out of builtin-trace.c and into trace/beauty/ioctl.c
to better compartimentalize all these formatters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-s3enursdxsvnhdomh6qlte4g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 44 +-------------------
 tools/perf/trace/beauty/Build    |  3 ++
 tools/perf/trace/beauty/beauty.h |  3 ++
 tools/perf/trace/beauty/ioctl.c  | 88 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/trace/beauty/ioctl.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 05d24b6570ee..de02413a25d3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -338,20 +338,6 @@ size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
 	return scnprintf(bf, size, "%d", arg->val);
 }
 
-#if defined(__i386__) || defined(__x86_64__)
-/*
- * FIXME: Make this available to all arches as soon as the ioctl beautifier
- * 	  gets rewritten to support all arches.
- */
-static size_t syscall_arg__scnprintf_strhexarray(char *bf, size_t size,
-						 struct syscall_arg *arg)
-{
-	return __syscall_arg__scnprintf_strarray(bf, size, "%#x", arg);
-}
-
-#define SCA_STRHEXARRAY syscall_arg__scnprintf_strhexarray
-#endif /* defined(__i386__) || defined(__x86_64__) */
-
 #ifndef AT_FDCWD
 #define AT_FDCWD	-100
 #endif
@@ -525,33 +511,6 @@ static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
 
 #define SCA_PIPE_FLAGS syscall_arg__scnprintf_pipe_flags
 
-#if defined(__i386__) || defined(__x86_64__)
-/*
- * FIXME: Make this available to all arches.
- */
-#define TCGETS		0x5401
-
-static const char *tioctls[] = {
-	"TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
-	"TCSETAF", "TCSBRK", "TCXONC", "TCFLSH", "TIOCEXCL", "TIOCNXCL",
-	"TIOCSCTTY", "TIOCGPGRP", "TIOCSPGRP", "TIOCOUTQ", "TIOCSTI",
-	"TIOCGWINSZ", "TIOCSWINSZ", "TIOCMGET", "TIOCMBIS", "TIOCMBIC",
-	"TIOCMSET", "TIOCGSOFTCAR", "TIOCSSOFTCAR", "FIONREAD", "TIOCLINUX",
-	"TIOCCONS", "TIOCGSERIAL", "TIOCSSERIAL", "TIOCPKT", "FIONBIO",
-	"TIOCNOTTY", "TIOCSETD", "TIOCGETD", "TCSBRKP", [0x27] = "TIOCSBRK",
-	"TIOCCBRK", "TIOCGSID", "TCGETS2", "TCSETS2", "TCSETSW2", "TCSETSF2",
-	"TIOCGRS485", "TIOCSRS485", "TIOCGPTN", "TIOCSPTLCK",
-	"TIOCGDEV||TCGETX", "TCSETX", "TCSETXF", "TCSETXW", "TIOCSIG",
-	"TIOCVHANGUP", "TIOCGPKT", "TIOCGPTLCK", "TIOCGEXCL",
-	[0x50] = "FIONCLEX", "FIOCLEX", "FIOASYNC", "TIOCSERCONFIG",
-	"TIOCSERGWILD", "TIOCSERSWILD", "TIOCGLCKTRMIOS", "TIOCSLCKTRMIOS",
-	"TIOCSERGSTRUCT", "TIOCSERGETLSR", "TIOCSERGETMULTI", "TIOCSERSETMULTI",
-	"TIOCMIWAIT", "TIOCGICOUNT", [0x60] = "FIOQSIZE",
-};
-
-static DEFINE_STRARRAY_OFFSET(tioctls, 0x5401);
-#endif /* defined(__i386__) || defined(__x86_64__) */
-
 #ifndef GRND_NONBLOCK
 #define GRND_NONBLOCK	0x0001
 #endif
@@ -670,8 +629,7 @@ static struct syscall_fmt {
 /*
  * FIXME: Make this available to all arches.
  */
-		   [1] = { .scnprintf = SCA_STRHEXARRAY, /* cmd */
-			   .parm      = &strarray__tioctls, },
+		   [1] = { .scnprintf = SCA_IOCTL_CMD, /* cmd */ },
 		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
 #else
 		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index eaa1e8e8e100..6f3f159f97e0 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,3 +1,6 @@
 libperf-y += clone.o
 libperf-y += fcntl.o
+ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
+libperf-y += ioctl.o
+endif
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 69a5c8a2d420..47a36a8eb842 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -75,6 +75,9 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_ARG syscall_arg__scnprintf_fcntl_arg
 
+size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_IOCTL_CMD syscall_arg__scnprintf_ioctl_cmd
+
 size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
 
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
new file mode 100644
index 000000000000..5f0dba8aaa88
--- /dev/null
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -0,0 +1,88 @@
+/*
+ * trace/beauty/ioctl.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ *
+ * Released under the GPL v2. (and only v2, not any later version)
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+
+/*
+ * FIXME: to support all arches we have to improve this, for
+ * now, to build on older systems without things like TIOCGEXCL,
+ * get it directly from our copy.
+ *
+ * Right now only x86 is being supported for beautifying ioctl args
+ * in 'perf trace', see tools/perf/trace/beauty/Build and builtin-trace.c
+ */
+#include <uapi/asm-generic/ioctls.h>
+
+static size_t ioctl__scnprintf_tty_cmd(int nr, char *bf, size_t size)
+{
+	static const char *ioctl_tty_cmd[] = {
+	"TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
+	"TCSETAF", "TCSBRK", "TCXONC", "TCFLSH", "TIOCEXCL", "TIOCNXCL", "TIOCSCTTY",
+	"TIOCGPGRP", "TIOCSPGRP", "TIOCOUTQ", "TIOCSTI", "TIOCGWINSZ", "TIOCSWINSZ",
+	"TIOCMGET", "TIOCMBIS", "TIOCMBIC", "TIOCMSET", "TIOCGSOFTCAR", "TIOCSSOFTCAR",
+	"FIONREAD", "TIOCLINUX", "TIOCCONS", "TIOCGSERIAL", "TIOCSSERIAL", "TIOCPKT",
+	"FIONBIO", "TIOCNOTTY", "TIOCSETD", "TIOCGETD", "TCSBRKP",
+	[_IOC_NR(TIOCSBRK)] = "TIOCSBRK", "TIOCCBRK", "TIOCGSID", "TCGETS2", "TCSETS2",
+	"TCSETSW2", "TCSETSF2", "TIOCGRS48", "TIOCSRS485", "TIOCGPTN", "TIOCSPTLCK",
+	"TIOCGDEV", "TCSETX", "TCSETXF", "TCSETXW", "TIOCSIG", "TIOCVHANGUP", "TIOCGPKT",
+	"TIOCGPTLCK", [_IOC_NR(TIOCGEXCL)] = "TIOCGEXCL", "TIOCGPTPEER",
+	[_IOC_NR(FIONCLEX)] = "FIONCLEX", "FIOCLEX", "FIOASYNC", "TIOCSERCONFIG",
+	"TIOCSERGWILD", "TIOCSERSWILD", "TIOCGLCKTRMIOS", "TIOCSLCKTRMIOS",
+	"TIOCSERGSTRUCT", "TIOCSERGETLSR", "TIOCSERGETMULTI", "TIOCSERSETMULTI",
+	"TIOCMIWAIT", "TIOCGICOUNT", };
+	static DEFINE_STRARRAY(ioctl_tty_cmd);
+
+	if (nr < strarray__ioctl_tty_cmd.nr_entries && strarray__ioctl_tty_cmd.entries[nr] != NULL)
+		return scnprintf(bf, size, "%s", strarray__ioctl_tty_cmd.entries[nr]);
+
+	return scnprintf(bf, size, "(%#x, %#x)", 'T', nr);
+}
+
+static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
+{
+	int dir	 = _IOC_DIR(cmd),
+	    type = _IOC_TYPE(cmd),
+	    nr	 = _IOC_NR(cmd),
+	    sz	 = _IOC_SIZE(cmd);
+	int printed = 0;
+	static const struct ioctl_type {
+		int	type;
+		size_t	(*scnprintf)(int nr, char *bf, size_t size);
+	} ioctl_types[] = { /* Must be ordered by type */
+		{ .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, }
+	};
+	const int nr_types = ARRAY_SIZE(ioctl_types);
+
+	if (type >= ioctl_types[0].type && type <= ioctl_types[nr_types - 1].type) {
+		const int index = type - ioctl_types[0].type;
+
+		if (ioctl_types[index].scnprintf != NULL)
+			return ioctl_types[index].scnprintf(nr, bf, size);
+	}
+
+	printed += scnprintf(bf + printed, size - printed, "%c", '(');
+
+	if (dir == _IOC_NONE) {
+		printed += scnprintf(bf + printed, size - printed, "%s", "NONE");
+	} else {
+		if (dir & _IOC_READ)
+			printed += scnprintf(bf + printed, size - printed, "%s", "READ");
+		if (dir & _IOC_WRITE)
+			printed += scnprintf(bf + printed, size - printed, "%s%s", dir & _IOC_READ ? "|" : "", "WRITE");
+	}
+
+	return printed + scnprintf(bf + printed, size - printed, ", %#x, %#x, %#x)", type, nr, sz);
+}
+
+size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long cmd = arg->val;
+
+	return ioctl__scnprintf_cmd(cmd, bf, size);
+}
-- 
2.9.4
