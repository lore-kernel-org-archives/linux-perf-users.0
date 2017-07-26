From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/40] perf tools: Add tools/include/uapi/asm-generic/fcntl.h to the MANIFEST
Date: Wed, 26 Jul 2017 11:17:30 -0300
Message-ID: <20170726141730.30750-41-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This file was copied from the kernel so that we could build tools/perf/
on older systems where some newer defines, such as these are available:

    CC       trace/beauty/fcntl.o
  trace/beauty/fcntl.c: In function ‘syscall_arg__scnprintf_fcntl_arg’:
  trace/beauty/fcntl.c:93:13: error: ‘F_OFD_SETLK’ undeclared (first use in this function)
        cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
               ^
  trace/beauty/fcntl.c:93:13: note: each undeclared identifier is reported only once for each function it appears in
  trace/beauty/fcntl.c:93:35: error: ‘F_OFD_SETLKW’ undeclared (first use in this function)
        cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
                                     ^
  trace/beauty/fcntl.c:93:58: error: ‘F_OFD_GETLK’ undeclared (first use in this function)
        cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
                                                            ^
  mv: cannot stat ‘trace/beauty/.fcntl.o.tmp’: No such file or directory
  make[4]: *** [trace/beauty/fcntl.o] Error 1
  make[3]: *** [trace/beauty] Error 2
  make[3]: *** Waiting for unfinished jobs....
    CC       tests/llvm.o

But we need to make sure that it is also in the tools/perf/MANIFEST file, that
is used to build a tarball for detached (from the kernel sources) compilation,
which was failing, with the above message, on a RHEL7.4 system, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 84d1d8a12df3 ("tools include uapi asm-generic: Grab a copy of fcntl.h")
Link: http://lkml.kernel.org/n/tip-2d5px7aq5stbwi24pgirwtlm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/MANIFEST | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 9f2267b82eb2..705bdb147e73 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -70,6 +70,7 @@ tools/include/linux/hash.h
 tools/include/linux/kernel.h
 tools/include/linux/list.h
 tools/include/linux/log2.h
+tools/include/uapi/asm-generic/fcntl.h
 tools/include/uapi/asm-generic/mman-common.h
 tools/include/uapi/asm-generic/mman.h
 tools/include/uapi/linux/bpf.h
-- 
2.9.4
