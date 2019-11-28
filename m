From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/22] perf regs: Make perf_reg_name() return "unknown" instead of NULL
Date: Thu, 28 Nov 2019 10:40:23 -0300
Message-ID: <20191128134027.23726-19-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To avoid breaking the build on arches where this is not wired up, at
least all the other features should be made available and when using
this specific routine, the "unknown" should point the user/developer to
the need to wire this up on this particular hardware architecture.

Detected in a container mipsel debian cross build environment, where it
shows up as:

  In file included from /usr/mipsel-linux-gnu/include/stdio.h:867,
                   from /git/linux/tools/perf/lib/include/perf/cpumap.h:6,
                   from util/session.c:13:
  In function 'printf',
      inlined from 'regs_dump__printf' at util/session.c:1103:3,
      inlined from 'regs__printf' at util/session.c:1131:2:
  /usr/mipsel-linux-gnu/include/bits/stdio2.h:107:10: error: '%-5s' directive argument is null [-Werror=format-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cross compiler details:

  mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909

Also on mips64:

  In file included from /usr/mips64-linux-gnuabi64/include/stdio.h:867,
                   from /git/linux/tools/perf/lib/include/perf/cpumap.h:6,
                   from util/session.c:13:
  In function 'printf',
      inlined from 'regs_dump__printf' at util/session.c:1103:3,
      inlined from 'regs__printf' at util/session.c:1131:2,
      inlined from 'regs_user__printf' at util/session.c:1139:3,
      inlined from 'dump_sample' at util/session.c:1246:3,
      inlined from 'machines__deliver_event' at util/session.c:1421:3:
  /usr/mips64-linux-gnuabi64/include/bits/stdio2.h:107:10: error: '%-5s' directive argument is null [-Werror=format-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In function 'printf',
      inlined from 'regs_dump__printf' at util/session.c:1103:3,
      inlined from 'regs__printf' at util/session.c:1131:2,
      inlined from 'regs_intr__printf' at util/session.c:1147:3,
      inlined from 'dump_sample' at util/session.c:1249:3,
      inlined from 'machines__deliver_event' at util/session.c:1421:3:
  /usr/mips64-linux-gnuabi64/include/bits/stdio2.h:107:10: error: '%-5s' directive argument is null [-Werror=format-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cross compiler details:

  mips64-linux-gnuabi64-gcc (Debian 9.2.1-8) 9.2.1 20190909

Fixes: 2bcd355b71da ("perf tools: Add interface to arch registers sets")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-95wjyv4o65nuaeweq31t7l1s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/perf_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index e014c2c038f4..a45499126184 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -41,7 +41,7 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
-	return NULL;
+	return "unknown";
 }
 
 static inline int perf_reg_value(u64 *valp __maybe_unused,
-- 
2.21.0
