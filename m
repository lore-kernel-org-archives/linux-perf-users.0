From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 53/57] perf trace: Use strtoul for the fcntl 'cmd' argument
Date: Mon, 21 Oct 2019 10:38:30 -0300
Message-ID: <20191021133834.25998-54-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since its values are in two ranges of values we ended up codifying it
using a 'struct strarrays', so now hook it up with STUL_STRARRAYS so
that we can do:

  # perf trace -e syscalls:*enter_fcntl --filter=cmd==SETLK||cmd==SETLKW
     0.000 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4dee0)
     1.523 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4de90)
     1.629 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4de90)
     2.711 sssd_kcm/19021 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7ffcf0a4de70)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mob96wyzri4r3rvyigqfjv0a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 265ea876f00b..72ef3b395504 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -894,7 +894,8 @@ static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "fchownat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "fcntl",
-	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD, /* cmd */
+	  .arg = { [1] = { .scnprintf = SCA_FCNTL_CMD,  /* cmd */
+			   .strtoul   = STUL_STRARRAYS,
 			   .parm      = &strarrays__fcntl_cmds_arrays,
 			   .show_zero = true, },
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
-- 
2.21.0
