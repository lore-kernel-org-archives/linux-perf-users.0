From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: RE: Records call-graphs on ARM, reporting on x86_64
Date: Mon, 12 Feb 2018 16:37:33 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989263D223@AZ-US1EXMB02.global.avaya.com>
References: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
 <2197547.58bztnllri@milian-kdab2>
 <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
 <30C2D590D16A5C46ADFE6521910377989262D993@AZ-US1EXMB02.global.avaya.com>
 <20180209145608.1f37b8ddc53b398d2fc17013@arm.com>
 <30C2D590D16A5C46ADFE6521910377989262DACC@AZ-US1EXMB02.global.avaya.com>
 <20180212082835.GA6253@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co300216-co-outbound.net.avaya.com ([198.152.13.100]:62013 "EHLO
        co300216-co-outbound.net.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964902AbeBLQhh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Feb 2018 11:37:37 -0500
In-Reply-To: <20180212082835.GA6253@krava>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>, Milian Wolff <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> > That is true. But if perf is compiled for x86_64, then it is compiled
> > with arch/x86/... and knows nothing of arch/arm/... The architecture
> > selection is done at compile time.
> 
> right, seems like a problem for libdw, but it shouldn't be problem for
> linwunwind where it's compiled in via util/libunwind/arm64.o

To build perf for ARM on x86_64 with libunwind, you would need libunwind-arm
compiled for x86_64. I decided not to try to go down that road, since libdw is
already multi-platform capable.

> > I recompiled perf with 'ARCH=arm' on my x86_64 host and, with a few
> > hacks and the fix to problem (2), it now works fine and can unwind my
> > ARM call stacks just fine.
> 
> could you please share those hacks?

Sure, but please keep in mind this is designed to satisfy my specific use cases
only, and YMMV.

My objective was to get symbols, annotation and call graphs working.

My target is ARM926EJ-S, my host is x86_64. My ARM images are built with OE-based
Yocto. On the host, I have installed the SDK from Yocto, which includes the sysroot,
including debug packages.

To build perf for ARM on the x86_64 host:
- In tools/perf, remove tests and arch/arm/tests directories
- In additions to the patches I published over the week-end, apply the patches below
- ARCH=arm NO_LIBUNWIND=1 NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 make
- sudo prefix=/usr/local ARCH=arm NO_LIBUNWIND=1 NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 make install
This installs perf-arm in /usr/local/bin

To use it, you need:
- The sysroot or equivalent with debug info
- A populated build-id cache (under --symfs)
- A copy of unstripped vmlinux image (optional), or a copy of /proc/kallsyms from target
- If you want annotations to work, you also need
  - objdump for ARM
  - cannot use "separate debug files", objdump cannot handle it

I invoke 'perf report' with --symfs (pointing to sysroot), --vmlinux and --objdump options.
You can use --kallsyms instead of --vmlinux, at the expense of annotation and unwinding.

Two peculiarities of my build system that may or may not be applicable:
- It produces separate debug files. So I have a script to populate the build-id cache with
  "reconstituted" binaries, using eu_unstrip from elfutils
- The source paths in debug info are absolute paths starting with "/usr/src" so objdump
  cannot find them. I use a wrapper script (which I pass to --objdump option) that adds
  the "--prefix" option to the arguments passed by perf and forwards the lot to the real
  ARM objdump.

Now the "hack" patches:

diff --git a/tools/include/asm/atomic.h b/tools/include/asm/atomic.h
index 8c9bfff..3b0be05 100644
--- a/tools/include/asm/atomic.h
+++ b/tools/include/asm/atomic.h
@@ -2,10 +2,10 @@
 #ifndef __TOOLS_LINUX_ASM_ATOMIC_H
 #define __TOOLS_LINUX_ASM_ATOMIC_H
 
-#if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/asm/atomic.h"
-#else
+//#if defined(__i386__) || defined(__x86_64__)
+//#include "../../arch/x86/include/asm/atomic.h"
+//#else
 #include <asm-generic/atomic-gcc.h>
-#endif
+//#endif
 
 #endif /* __TOOLS_LINUX_ASM_ATOMIC_H */
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9b0351d..ce7f317 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -815,7 +815,7 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
 
-install-bin: install-tools install-tests install-traceevent-plugins
+install-bin: install-tools install-traceevent-plugins
 
 install: install-bin try-install-man
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e7f1b18..9e6b2bc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -628,15 +628,15 @@ static struct syscall_fmt {
 	{ .name	    = "gettid",	    .errpid = true, },
 	{ .name	    = "ioctl",
 	  .arg = {
-#if defined(__i386__) || defined(__x86_64__)
-/*
- * FIXME: Make this available to all arches.
- */
-		   [1] = { .scnprintf = SCA_IOCTL_CMD, /* cmd */ },
+//#if defined(__i386__) || defined(__x86_64__)
+///*
+// * FIXME: Make this available to all arches.
+// */
+//		   [1] = { .scnprintf = SCA_IOCTL_CMD, /* cmd */ },
+//		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
+//#else
 		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
-#else
-		   [2] = { .scnprintf = SCA_HEX, /* arg */ }, }, },
-#endif
+//#endif
 	{ .name	    = "kcmp",	    .nr_args = 5,
 	  .arg = { [0] = { .name = "pid1",	.scnprintf = SCA_PID, },
 		   [1] = { .name = "pid2",	.scnprintf = SCA_PID, },
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 05745f3..f8a6529 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -33,7 +33,7 @@ int cmd_probe(int argc, const char **argv);
 int cmd_kmem(int argc, const char **argv);
 int cmd_lock(int argc, const char **argv);
 int cmd_kvm(int argc, const char **argv);
-int cmd_test(int argc, const char **argv);
+//int cmd_test(int argc, const char **argv);
 int cmd_trace(int argc, const char **argv);
 int cmd_inject(int argc, const char **argv);
 int cmd_mem(int argc, const char **argv);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8e..1ad6923 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -72,7 +72,7 @@ static struct cmd_struct commands[] = {
 	{ "kmem",	cmd_kmem,	0 },
 	{ "lock",	cmd_lock,	0 },
 	{ "kvm",	cmd_kvm,	0 },
-	{ "test",	cmd_test,	0 },
+	//{ "test",	cmd_test,	0 },
 #if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
 	{ "trace",	cmd_trace,	0 },
 #endif
@@ -513,7 +513,7 @@ int main(int argc, const char **argv)
 	}
 	cmd = argv[0];
 
-	test_attr__init();
+	//test_attr__init();
 
 	/*
 	 * We use PATH to find perf commands, but we prepend some higher
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index cfe4623..f9ed9ed 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -7,13 +7,13 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 
-extern bool test_attr__enabled;
-void test_attr__ready(void);
-void test_attr__init(void);
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
-		     int fd, int group_fd, unsigned long flags);
+//extern bool test_attr__enabled;
+//void test_attr__ready(void);
+//void test_attr__init(void);
+//void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+//		     int fd, int group_fd, unsigned long flags);
 
-#define HAVE_ATTR_TEST
+//#define HAVE_ATTR_TEST
 #include "perf-sys.h"
 
 static inline unsigned long long rdclock(void)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef35168..e95fd0d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -50,7 +50,7 @@ static int perf_evsel__no_extra_init(struct perf_evsel *evsel __maybe_unused)
 	return 0;
 }
 
-void __weak test_attr__ready(void) { }
+//void __weak test_attr__ready(void) { }
 
 static void perf_evsel__no_extra_fini(struct perf_evsel *evsel __maybe_unused)
 {
@@ -1776,7 +1776,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 			pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				  pid, cpus->map[cpu], group_fd, flags);
 
-			test_attr__ready();
+			//test_attr__ready();
 
 			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
 						 group_fd, flags);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b1e999b..6f371af 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1282,11 +1282,11 @@ PyMODINIT_FUNC initperf(void)
 		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
 }
 
-/*
- * Dummy, to avoid dragging all the test_attr infrastructure in the python
- * binding.
- */
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
-                     int fd, int group_fd, unsigned long flags)
-{
-}
+///*
+// * Dummy, to avoid dragging all the test_attr infrastructure in the python
+// * binding.
+// */
+//void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+//                     int fd, int group_fd, unsigned long flags)
+//{
+//}
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ce7f317..067123f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -755,8 +755,8 @@ endif
 install-tools: all install-gtk
 	$(call QUIET_INSTALL, binaries) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'; \
-		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
-		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'
+		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)/perf-arm'; \
+		#$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'
 ifndef NO_PERF_READ_VDSO32
 	$(call QUIET_INSTALL, perf-read-vdso32) \
 		$(INSTALL) $(OUTPUT)perf-read-vdso32 '$(DESTDIR_SQ)$(bindir_SQ)';
