From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf build: Fix installation directory for bpf
Date: Tue, 31 Jul 2018 09:32:54 +0200
Message-ID: <20180731073254.91090-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Perf tool build and install is controlled via makefile. Make install
creates directories and copies files. Among them are header files
installed in /usr/lib/include/perf/bpf/.

However all listed examples are installing its header files in
  /usr/lib/<tool-name>/...[/include]/header.h
and not in
  /usr/lib/include/<tool-name>/.../header.h.

Background information:
Building the Fedora 28 glibc RPM on s390x and s390 fails on s390
(gcc -m31) as gcc is not able to find header-files like stdbool.h.
In the glibc.spec file, you can see that glibc is configured with
"--with-headers". In this case, first -nostdinc is added to the
CFLAGS and then further include paths are added via -isystem.
One of those paths should contain header files like stdbool.h.

In order to get this path, gcc is invoked with:
- on Fedora 28 (with 4.18 kernel):
  $ gcc -print-file-name=include
  /usr/lib/gcc/s390x-redhat-linux/8/include
  $ gcc -m31 -print-file-name=include
  /usr/lib/gcc/s390x-redhat-linux/8/../../../../lib/include
  => If perf is installed, this is: /usr/lib/include
  On my machine this directory is only containing the directory "perf".
  If perf is not installed gcc returns: /usr/lib/gcc/s390x-redhat-linux/8/\
						include

-on Ubuntu 18.04 (with 4.15 kernel):
  $ gcc  -print-file-name=include
  /usr/lib/gcc/s390x-linux-gnu/7/include
  $ gcc -m31 -print-file-name=include
  /usr/lib/gcc/s390x-linux-gnu/7/include
  => gcc returns the correct path even if perf is installed.

In each case, the introduction of the subdirectory /usr/lib/include
leads to the regression that one can not build the glibc RPM for
s390 anymore as gcc can not find headers like stdbool.h.

To remedy this install bpf.h to /usr/lib/perf/include/bpf/bpf.h

Output before using command ./perf test -Fv 40:
echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		 -I/root/lib/include/perf/bpf ...
                             ^^^^^^^^^^^^
...
[root@p23lp27 perf]# ./perf test -F 40
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Ok
40.2: BPF pinning                                         : Ok
40.3: BPF prologue generation                             : Ok
40.4: BPF relocation checker                              : Ok
[root@p23lp27 perf]#

Output after using command ./perf test -Fv 40:
echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		 -I/root/lib/perf/include/bpf ...
                             ^^^^^^^^^^^^
...
[root@p23lp27 perf]# ./perf test -F 40
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Ok
40.2: BPF pinning                                         : Ok
40.3: BPF prologue generation                             : Ok
40.4: BPF relocation checker                              : Ok
[root@p23lp27 perf]#

Suggested-by: Stefan Liebler <stli@linux.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f5a3b402589e..67b042738ed7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -905,8 +905,8 @@ bindir = $(abspath $(prefix)/$(bindir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
-perf_include_dir = lib/include/perf
-perf_examples_dir = lib/examples/perf
+perf_include_dir = lib/perf/include
+perf_examples_dir = lib/perf/examples
 sharedir = $(prefix)/share
 template_dir = share/perf-core/templates
 STRACE_GROUPS_DIR = share/perf-core/strace/groups
-- 
2.17.0
