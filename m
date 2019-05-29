From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/41] perf trace: Beautify 'fsconfig' arguments
Date: Wed, 29 May 2019 10:35:37 -0300
Message-ID: <20190529133605.21118-14-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Use existing beautifiers for the first arg, fd, assigned using the
heuristic that looks for syscall arg names and associates SCA_FD with
'fd' named argumes, and wire up the recently introduced fsconfig cmd
table generator.

Now it should be possible to just use:

   perf trace -e fsconfig

As root and see all fsconfig syscalls with its args beautified, more
work needed to look at the command and according to it handle the 'key',
'value' and 'aux' args, using the 'fcntl' and 'futex' beautifiers as a
starting point to see how to suppress sets of these last three args that
may not be used by the 'cmd' arg, etc.

  # cat sys_fsconfig.c
  #define _GNU_SOURCE         /* See feature_test_macros(7) */
  #include <unistd.h>
  #include <sys/syscall.h>   /* For SYS_xxx definitions */
  #include <fcntl.h>

  #define __NR_fsconfig 431

  enum fsconfig_command {
  	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
  	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
  	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
  	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
  	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
  	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
  	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
  	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
  };

  static inline int sys_fsconfig(int fd, int cmd, const char *key, const void *value, int aux)
  {
  	syscall(__NR_fsconfig, fd, cmd, key, value, aux);
  }

  int main(int argc, char *argv[])
  {
  	int fd = 0, aux = 0;

  	open("/foo", 0);
  	sys_fsconfig(fd++, FSCONFIG_SET_FLAG,	     "/foo1", "/bar1", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_STRING,	     "/foo2", "/bar2", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_BINARY,	     "/foo3", "/bar3", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_PATH,	     "/foo4", "/bar4", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_PATH_EMPTY,  "/foo5", "/bar5", aux++);
  	sys_fsconfig(fd++, FSCONFIG_SET_FD,	     "/foo6", "/bar6", aux++);
  	sys_fsconfig(fd++, FSCONFIG_CMD_CREATE,	     "/foo7", "/bar7", aux++);
  	sys_fsconfig(fd++, FSCONFIG_CMD_RECONFIGURE, "/foo8", "/bar8", aux++);
  	return 0;
  }
  # trace -e fsconfig ./sys_fsconfig
  fsconfig(0, FSCONFIG_SET_FLAG, 0x40201b, 0x402015, 0) = -1 EINVAL (Invalid argument)
  fsconfig(1, FSCONFIG_SET_STRING, 0x402027, 0x402021, 1) = -1 EINVAL (Invalid argument)
  fsconfig(2, FSCONFIG_SET_BINARY, 0x402033, 0x40202d, 2) = -1 EINVAL (Invalid argument)
  fsconfig(3, FSCONFIG_SET_PATH, 0x40203f, 0x402039, 3) = -1 EBADF (Bad file descriptor)
  fsconfig(4, FSCONFIG_SET_PATH_EMPTY, 0x40204b, 0x402045, 4) = -1 EBADF (Bad file descriptor)
  fsconfig(5, FSCONFIG_SET_FD, 0x402057, 0x402051, 5) = -1 EINVAL (Invalid argument)
  fsconfig(6, FSCONFIG_CMD_CREATE, 0x402063, 0x40205d, 6) = -1 EINVAL (Invalid argument)
  fsconfig(7, FSCONFIG_CMD_RECONFIGURE, 0x40206f, 0x402069, 7) = -1 EINVAL (Invalid argument)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fb04b76cm59zfuv1wzu40uxy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf   | 8 ++++++++
 tools/perf/builtin-trace.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index fe93f8c46080..22e92a9ee871 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,6 +425,12 @@ fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 $(fspick_arrays): $(linux_uapi_dir)/fs.h $(fspick_tbls)
 	$(Q)$(SHELL) '$(fspick_tbls)' $(linux_uapi_dir) > $@
 
+fsconfig_arrays := $(beauty_outdir)/fsconfig_arrays.c
+fsconfig_tbls := $(srctree)/tools/perf/trace/beauty/fsconfig.sh
+
+$(fsconfig_arrays): $(linux_uapi_dir)/fs.h $(fsconfig_tbls)
+	$(Q)$(SHELL) '$(fsconfig_tbls)' $(linux_uapi_dir) > $@
+
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
 pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -640,6 +646,7 @@ build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
 	$(fadvise_advice_array) \
+	$(fsconfig_arrays) \
 	$(fspick_arrays) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
@@ -936,6 +943,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(fadvise_advice_array) \
+		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fspick_arrays) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1643da631699..87b6dd3c33f5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -482,6 +482,10 @@ static const char *bpf_cmd[] = {
 };
 static DEFINE_STRARRAY(bpf_cmd, "BPF_");
 
+#include "trace/beauty/generated/fsconfig_arrays.c"
+
+static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
+
 static const char *epoll_ctl_ops[] = { "ADD", "DEL", "MOD", };
 static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, "EPOLL_CTL_", 1);
 
@@ -713,6 +717,8 @@ static struct syscall_fmt {
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
 	{ .name	    = "flock",
 	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
+	{ .name     = "fsconfig",
+	  .arg = { [1] = STRARRAY(cmd, fsconfig_cmds), }, },
 	{ .name     = "fspick",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
 		   [1] = { .scnprintf = SCA_FILENAME,	  /* path */ },
-- 
2.20.1
