From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/23] tools headers UAPI: Sync copy of arm64's asm/unistd.h with the kernel sources
Date: Fri, 14 Feb 2020 16:10:43 -0300
Message-ID: <20200214191057.26266-10-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Amanieu d'Antras <amanieu@gmail.com>, Christian Brauner <christian.brauner@ubuntu.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  3e3c8ca5a351 ("arm64: Move __ARCH_WANT_SYS_CLONE3 definition to uapi headers")

Silencing this tools/perf/ build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/unistd.h' differs from latest version at 'arch/arm64/include/uapi/asm/unistd.h'
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h

Which will probably end up enabling the use of "clone3" in 'perf trace -e',
haven't checked the build with this change on an arm64 system.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amanieu d'Antras <amanieu@gmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index 4703d218663a..f83a70e07df8 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -19,5 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
-- 
2.21.1
