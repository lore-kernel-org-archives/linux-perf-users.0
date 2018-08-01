From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/21] perf trace: Beautify the AF_INET & AF_INET6 'socket' syscall 'protocol' args
Date: Wed,  1 Aug 2018 18:36:35 -0300
Message-ID: <20180801213648.4814-9-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance:

  $ trace -e socket* ssh sandy
     0.000 ( 0.031 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     0.052 ( 0.015 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.568 ( 0.020 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.603 ( 0.012 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.699 ( 0.014 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.724 ( 0.012 ms): ssh/19919 socket(family: LOCAL, type: STREAM|CLOEXEC|NONBLOCK                   ) = 3
     1.804 ( 0.020 ms): ssh/19919 socket(family: INET, type: STREAM, protocol: TCP                      ) = 3
    17.549 ( 0.098 ms): ssh/19919 socket(family: LOCAL, type: STREAM                                    ) = 4
  acme@sandy's password:

Just like with other syscall args, the common bits are supressed so that
the output is more compact, i.e. we use "TCP" instead of "IPPROTO_TCP",
but we can make this show the original constant names if we like it by
using some command line knob or ~/.perfconfig "[trace]" section
variable.

Also needed is to make perf's event parser accept things like:

  $ perf trace -e socket*/protocol=TCP/

By using both the tracefs event 'format' files and these tables built
from the kernel sources.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-l39jz1vnyda0b6jsufuc8bz7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 632ef5f8f060..9aca65e6b9aa 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -761,10 +761,12 @@ static struct syscall_fmt {
 	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
 	{ .name	    = "socket",
 	  .arg = { [0] = STRARRAY(family, socket_families),
-		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
+		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ },
+		   [2] = { .scnprintf = SCA_SK_PROTO, /* protocol */ }, }, },
 	{ .name	    = "socketpair",
 	  .arg = { [0] = STRARRAY(family, socket_families),
-		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ }, }, },
+		   [1] = { .scnprintf = SCA_SK_TYPE, /* type */ },
+		   [2] = { .scnprintf = SCA_SK_PROTO, /* protocol */ }, }, },
 	{ .name	    = "stat", .alias = "newstat", },
 	{ .name	    = "statx",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	 /* fdat */ },
-- 
2.14.4
