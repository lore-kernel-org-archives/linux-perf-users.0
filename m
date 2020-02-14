From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/23] perf llvm: Fix script used to obtain kernel make directives to work with new kbuild
Date: Fri, 14 Feb 2020 16:10:57 -0300
Message-ID: <20200214191057.26266-24-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, He Kuang <hekuang@huawei.com>, Masahiro Yamada <masahiroy@kernel.org>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang Nan <wangnan0@huawei.com>, Zefan Li <lizefan@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before this patch:

  # ./perf test 39 41
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : FAILED!
  39.3: Compile source for BPF prologue generation          : Skip
  39.4: Compile source for BPF relocation                   : Skip
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : FAILED!
  41.4: BPF relocation checker                              : Skip
  #

Using 'perf test -v' for these tests shows that it is not finding
uapi/linux/fs.h, which ends up being because we don't setup the right header
path. Fix it.

After this patch:

  # perf test 39 41
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  #

Longer description:

In llvm-utils.c we use some techniques to obtain the kbuild make
directives and that recently stopped working as now 'ar' gets called and
expects to find the dummy.o used to echo these variables:

  $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS)

Add the $(CC) line to satisfy that, making sure this works with all
kernels, i.e. preserving the temp directory and files in it used for
this technique we can see that it works everywhere:

  # make -s -C /lib/modules/5.4.18-100.fc30.x86_64/build M=/tmp/tmp.qgaFHgxjZ4/ clean
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 4
  drwx------.  2 root root   80 Feb 14 09:42 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:42 ..
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  #
  # cat /tmp/tmp.qgaFHgxjZ4/Makefile
  obj-y := dummy.o
  $(obj)/%.o: $(src)/%.c
          @echo -n "$(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS)"
          $(CC) -c -o $@ $<
  #

Then build with an old kernel Makefile:

  # make -s -C /lib/modules/5.4.18-100.fc30.x86_64/build M=/tmp/tmp.qgaFHgxjZ4/ dummy.o
  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h
  #
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 8
  drwx------.  2 root root  100 Feb 14 09:43 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:43 ..
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  936 Feb 14 09:43 dummy.o
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  #

And a new one:

  # make -s -C /lib/modules/5.4.18-100.fc30.x86_64/build M=/tmp/tmp.qgaFHgxjZ4/ clean
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 4
  drwx------.  2 root root   80 Feb 14 09:43 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:43 ..
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  # make -s -C /lib/modules/5.6.0-rc1+/build M=/tmp/tmp.qgaFHgxjZ4/ dummy.o
   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h
  #
  # ls -la /tmp/tmp.qgaFHgxjZ4/
  total 16
  drwx------.  2 root root  160 Feb 14 09:44 .
  drwxrwxrwt. 47 root root 1200 Feb 14 09:44 ..
  -rw-r--r--.  1 root root  158 Feb 14 09:44 built-in.a
  -rw-r--r--.  1 root root  149 Feb 14 09:44 .built-in.a.cmd
  -rw-r--r--.  1 root root    0 Feb 13 17:14 dummy.c
  -rw-r--r--.  1 root root  936 Feb 14 09:44 dummy.o
  -rw-r--r--.  1 root root  121 Feb 13 17:14 Makefile
  -rw-r--r--.  1 root root    0 Feb 14 09:44 modules.order
  #

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: He Kuang <hekuang@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Zefan Li <lizefan@huawei.com>
Link: https://www.spinics.net/lists/linux-perf-users/msg10600.html
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index eae47c2509eb..b5af680fc667 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -288,6 +288,7 @@ static const char *kinc_fetch_script =
 "obj-y := dummy.o\n"
 "\\$(obj)/%.o: \\$(src)/%.c\n"
 "\t@echo -n \"\\$(NOSTDINC_FLAGS) \\$(LINUXINCLUDE) \\$(EXTRA_CFLAGS)\"\n"
+"\t\\$(CC) -c -o \\$@ \\$<\n"
 "EOF\n"
 "touch $TMPDIR/dummy.c\n"
 "make -s -C $KBUILD_DIR M=$TMPDIR $KBUILD_OPTS dummy.o 2>/dev/null\n"
-- 
2.21.1
