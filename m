From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/63] perf trace beauty: Beautify renameat2's fd arg wrt AT_FDCWD
Date: Tue, 18 Dec 2018 19:06:38 -0300
Message-ID: <20181218220733.15839-9-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like is done with the 'renameat' syscall.

  # strace -e renameat2 -f perf trace -e rename* mv c /tmp
  [pid 12334] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp", RENAME_NOREPLACE) = -1 EXDEV (Invalid cross-device link)
  [pid 12334] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp/c", RENAME_NOREPLACE) = -1 EEXIST (File exists)
     1.947 ( 0.007 ms): mv/12334 renameat2(olddfd: CWD, oldname: 0x7ffce8b7fd81, newdfd: CWD, newname: 0x7ffce8b7fd83, flags: 1) = -1 EXDEV Invalid cross-device link
     2.073 ( 0.009 ms): mv/12334 renameat2(olddfd: CWD, oldname: 0x7ffce8b7fd81, newdfd: CWD, newname: 0x55ce7f0a1cc0, flags: 1mv: ) = -1 EEXIST File exists'c' and '/tmp/c' are the same file
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8q9l92eh9eee3y2bwyqku3tc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 406bceda6a2b..60c61a89436f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -799,6 +799,9 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "renameat2",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
+		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_sigprocmask",
-- 
2.19.2
