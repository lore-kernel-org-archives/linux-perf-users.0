From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/86] perf trace: Allow syscall arg formatters to request non suppression of zeros
Date: Wed, 19 Jul 2017 11:29:23 -0300
Message-ID: <20170719142950.3747-60-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'perf trace' tool is suppressing args set to zero, with the
exception of string tables (strarrays), which are kinda like enums, i.e.
we have maps to go from numbers to strings.

But the 'cmd' fcntl arg requires more specialized treatment, as its
value will regulate if the next fcntl syscall arg, 'arg', should be
ignored (not used) and also how to format the syscall return (fd, file
flags, etc), so add a 'show_zero" bool to struct syscall_arg_fmt, to
regulate this more explicitely.

Will be used in a following patch with fcntl, here is just the
mechanism.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-all738jctxets8ffyizp5lzo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 32778a621a08..b842bd93457f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -604,6 +604,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
 	void	   *parm;
+	bool	   show_zero;
 };
 
 static struct syscall_fmt {
@@ -1428,7 +1429,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
  			 */
 			if (val == 0 &&
 			    !(sc->arg_fmt &&
-			      (sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
+			      (sc->arg_fmt[arg.idx].show_zero ||
+			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
 			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
 			      sc->arg_fmt[arg.idx].parm))
 				continue;
-- 
2.9.4
