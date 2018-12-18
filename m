From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/63] tools uapi asm: Update asm-generic/unistd.h copy
Date: Tue, 18 Dec 2018 19:07:33 -0300
Message-ID: <20181218220733.15839-64-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the change in:

  b7d624ab4312 ("asm-generic: unistd.h: fixup broken macro include.")

That doesn't imply in any changes in the tools.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2e7xwm5i2qcc88jp2lyawdyd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 538546edbfbd..c7f3321fbe43 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -760,8 +760,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_ftruncate __NR3264_ftruncate
 #define __NR_lseek __NR3264_lseek
 #define __NR_sendfile __NR3264_sendfile
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR_newfstatat __NR3264_fstatat
 #define __NR_fstat __NR3264_fstat
+#endif
 #define __NR_mmap __NR3264_mmap
 #define __NR_fadvise64 __NR3264_fadvise64
 #ifdef __NR3264_stat
@@ -776,8 +778,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_ftruncate64 __NR3264_ftruncate
 #define __NR_llseek __NR3264_lseek
 #define __NR_sendfile64 __NR3264_sendfile
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR_fstatat64 __NR3264_fstatat
 #define __NR_fstat64 __NR3264_fstat
+#endif
 #define __NR_mmap2 __NR3264_mmap
 #define __NR_fadvise64_64 __NR3264_fadvise64
 #ifdef __NR3264_stat
-- 
2.19.2
