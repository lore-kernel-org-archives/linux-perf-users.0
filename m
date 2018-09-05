From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/77] perf bpf: Add linux/socket.h to the headers accessible to bpf proggies
Date: Wed,  5 Sep 2018 19:03:36 -0300
Message-ID: <20180905220440.20256-14-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't have to define sockaddr_storage in the
augmented_syscalls.c bpf example when hooking into syscalls needing it,
idea is to mimic the system headers. Eventually we probably need to have
sys/socket.h, etc.  Start by having at least linux/socket.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yhzarcvsjue8pgpvkjhqgioc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              |  4 +++-
 tools/perf/include/bpf/linux/socket.h | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/include/bpf/linux/socket.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5224ade3d5af..92514fb3689f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -779,7 +779,9 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, bpf-headers) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
-		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'; \
+		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
+		$(INSTALL) include/bpf/linux/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'
 	$(call QUIET_INSTALL, bpf-examples) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
 		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
diff --git a/tools/perf/include/bpf/linux/socket.h b/tools/perf/include/bpf/linux/socket.h
new file mode 100644
index 000000000000..7f844568dab8
--- /dev/null
+++ b/tools/perf/include/bpf/linux/socket.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SOCKET_H
+#define _UAPI_LINUX_SOCKET_H
+
+/*
+ * Desired design of maximum size and alignment (see RFC2553)
+ */
+#define _K_SS_MAXSIZE	128	/* Implementation specific max size */
+#define _K_SS_ALIGNSIZE	(__alignof__ (struct sockaddr *))
+				/* Implementation specific desired alignment */
+
+typedef unsigned short __kernel_sa_family_t;
+
+struct __kernel_sockaddr_storage {
+	__kernel_sa_family_t	ss_family;		/* address family */
+	/* Following field(s) are implementation specific */
+	char		__data[_K_SS_MAXSIZE - sizeof(unsigned short)];
+				/* space to achieve desired size, */
+				/* _SS_MAXSIZE value minus size of ss_family */
+} __attribute__ ((aligned(_K_SS_ALIGNSIZE)));	/* force desired alignment */
+
+#define sockaddr_storage __kernel_sockaddr_storage
+
+#endif /* _UAPI_LINUX_SOCKET_H */
-- 
2.14.4
