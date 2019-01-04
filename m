From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/16] tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
Date: Fri,  4 Jan 2019 15:33:31 -0300
Message-ID: <20190104183337.12771-11-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Will Deacon <will.deacon@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  b7d624ab4312 asm-generic: unistd.h: fixup broken macro include.
  4e21565b7fd4 asm-generic: add kexec_file_load system call to unistd.h

With this the 'kexec_file_load' syscall will be added to arm64's syscall
table and will appear on the output of 'perf trace' on that platform.

This silences this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-er8j7qhavtdw0kdga3zswynm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index c7f3321fbe43..d90127298f12 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
-- 
2.20.1
