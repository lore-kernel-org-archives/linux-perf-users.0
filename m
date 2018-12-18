From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/63] tools lib subcmd: Don't add the kernel sources to the include path
Date: Tue, 18 Dec 2018 19:06:43 -0300
Message-ID: <20181218220733.15839-14-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At some point we decided not to directly include kernel sources files
when building tools/perf/, but when tools/lib/subcmd/ was forked from
tools/perf it somehow ended up adding it via these two lines in its
Makefile:

  CFLAGS += -I$(srctree)/include/uapi
  CFLAGS += -I$(srctree)/include

As $(srctree) points to the kernel sources.

Removing those lines and keeping just:

  CFLAGS += -I$(srctree)/tools/include/

Is enough to build tools/perf and tools/objtool.

This fixes the build when building from the sources in environments such
as the Android NDK crossbuilding from a fedora:26 system:

  subcmd-util.h:11:15: error: expected ',' or ';' before 'void'
   static inline void report(const char *prefix, const char *err, va_list params)
                 ^
  In file included from /git/perf/include/uapi/linux/stddef.h:2:0,
                   from /git/perf/include/uapi/linux/posix_types.h:5,
                   from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h:36,
                   from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/unistd.h:33,
                   from run-command.c:2:
  subcmd-util.h:18:17: error: '__no_instrument_function__' attribute applies only to functions

The /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h
file that includes linux/posix_types.h ends up getting the one in the kernel
sources causing the breakage. Fix it.

Test built tools/objtool/ too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 4b6ab94eabe4 ("perf subcmd: Create subcmd library")
Link: https://lkml.kernel.org/n/tip-5lhaoecrj12t0bqwvpiu14sm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 95563b8e1ad7..ed61fb3a46c0 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -36,8 +36,6 @@ endif
 CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
-CFLAGS += -I$(srctree)/include/uapi
-CFLAGS += -I$(srctree)/include
 
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
-- 
2.19.2
