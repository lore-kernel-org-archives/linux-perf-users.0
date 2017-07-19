From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/86] tools include uapi x86: Grab a copy of unistd.h
Date: Wed, 19 Jul 2017 11:28:55 -0300
Message-ID: <20170719142950.3747-32-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In older distros we were not including our copies of unistd_{32,64}.h,
as we were relying on the system's asm/unistd.h, and a log time ago
the files to be included were asm-{x86_64,i386}/unistd.h.

Fix it by also carrying a copy of asm/unistd.h, that will be the same
as in modern distros and will allow us to provide missing __NR_setns,
for instance, in older distros.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-iwmgm0c4m1ynstktzmkjh8di@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/unistd.h | 17 +++++++++++++++++
 tools/perf/check-headers.sh              |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 tools/arch/x86/include/uapi/asm/unistd.h

diff --git a/tools/arch/x86/include/uapi/asm/unistd.h b/tools/arch/x86/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..a26df0d75cd0
--- /dev/null
+++ b/tools/arch/x86/include/uapi/asm/unistd.h
@@ -0,0 +1,17 @@
+#ifndef _UAPI_ASM_X86_UNISTD_H
+#define _UAPI_ASM_X86_UNISTD_H
+
+/* x32 syscall flag bit */
+#define __X32_SYSCALL_BIT	0x40000000
+
+#ifndef __KERNEL__
+# ifdef __i386__
+#  include <asm/unistd_32.h>
+# elif defined(__ILP32__)
+#  include <asm/unistd_x32.h>
+# else
+#  include <asm/unistd_64.h>
+# endif
+#endif
+
+#endif /* _UAPI_ASM_X86_UNISTD_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 83fe2202382e..47abd3325190 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -16,6 +16,7 @@ arch/x86/include/uapi/asm/perf_regs.h
 arch/x86/include/uapi/asm/kvm.h
 arch/x86/include/uapi/asm/kvm_perf.h
 arch/x86/include/uapi/asm/svm.h
+arch/x86/include/uapi/asm/unistd.h
 arch/x86/include/uapi/asm/vmx.h
 arch/powerpc/include/uapi/asm/kvm.h
 arch/s390/include/uapi/asm/kvm.h
-- 
2.9.4
