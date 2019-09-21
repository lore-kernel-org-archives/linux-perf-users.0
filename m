From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/10] tools uapi asm-generic: Sync unistd.h with the kernel sources
Date: Sat, 21 Sep 2019 09:42:33 -0300
Message-ID: <20190921124240.15741-4-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change from:

  78e05972c5e6 ("ipc: fix semtimedop for generic 32-bit architectures")

Which doesn't trigger any change in tooling and silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hpnjuyjzoudltqe7dvbokqdt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1be0e798e362..1fc8faa6e973 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -569,7 +569,7 @@ __SYSCALL(__NR_semget, sys_semget)
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+__SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
 #endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
-- 
2.21.0
