From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/14] perf arm64: Fix mksyscalltbl when system kernel headers are ahead of the kernel
Date: Tue, 28 May 2019 14:50:08 -0300
Message-ID: <20190528175020.13343-3-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Michael Petlan <mpetlan@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org>

When a host system has kernel headers that are newer than a compiling
kernel, mksyscalltbl fails with errors such as:

  <stdin>: In function 'main':
  <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
  <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
  <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
  <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
  <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
  <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
  tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied

mksyscalltbl is compiled with default host includes, but run with
compiling kernel tree includes, causing some syscall numbers to being
undeclared.

Committer testing:

Before this patch, in my cross build environment, no build problems, but
these new syscalls were not in the syscalls.c generated from the
unistd.h file, which is a bug, this patch fixes it:

perfbuilder@6e20056ed532:/git/perf$ tail /tmp/build/perf/arch/arm64/include/generated/asm/syscalls.c
	[292] = "io_pgetevents",
	[293] = "rseq",
	[294] = "kexec_file_load",
	[424] = "pidfd_send_signal",
	[425] = "io_uring_setup",
	[426] = "io_uring_enter",
	[427] = "io_uring_register",
	[428] = "syscalls",
};
perfbuilder@6e20056ed532:/git/perf$ strings /tmp/build/perf/perf | egrep '^(io_uring_|pidfd_|kexec_file)'
kexec_file_load
pidfd_send_signal
io_uring_setup
io_uring_enter
io_uring_register
perfbuilder@6e20056ed532:/git/perf$
$

Well, there is that last "syscalls" thing, but that looks like some
other bug.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190521030203.1447-1-vt@altlinux.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index c88fd32563eb..459469b7222c 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -56,7 +56,7 @@ create_table()
 	echo "};"
 }
 
-$gcc -E -dM -x c  $input	       \
+$gcc -E -dM -x c -I $incpath/include/uapi $input \
 	|sed -ne 's/^#define __NR_//p' \
 	|sort -t' ' -k2 -nu	       \
 	|create_table
-- 
2.20.1
