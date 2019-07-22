From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/37] perf trace: Add "sendfile64" alias to the "sendfile" syscall
Date: Mon, 22 Jul 2019 14:38:36 -0300
Message-ID: <20190722173839.22898-35-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were looking in tracefs for:

  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile/format when

what is there is just

  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile/format

Its the same id, 40 in x86_64, so just add an alias and let the existing
logic take care of that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-km2hmg7hru6u4pawi5fi903q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 200fbe33d5de..ca28c48f812e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -895,6 +895,7 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_SECCOMP_OP,	   /* op */ },
 		   [1] = { .scnprintf = SCA_SECCOMP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "select", .timeout = true, },
+	{ .name	    = "sendfile", .alias = "sendfile64", },
 	{ .name	    = "sendmmsg",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendmsg",
-- 
2.21.0
