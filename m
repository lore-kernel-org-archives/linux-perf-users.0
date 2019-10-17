From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/11] perf tools: Fix mode setting in copyfile_mode_ns()
Date: Thu, 17 Oct 2019 13:02:55 -0300
Message-ID: <20191017160301.20888-6-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

slow_copyfile() opens the file by name, so "write" permissions must not
be removed in copyfile_mode_ns() before calling slow_copyfile().

Example:

 Before:

  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -k /proc/kcore
  Couldn't add /proc/kcore

 After:

  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -v -k /proc/kcore
  kcore added to build-id cache directory /home/ahunter/.debug/[kernel.kcore]/37e340b1b5a7cf4f57ba8de2bc777359588a957f/2019100709562289

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20191007070221.11158-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/copyfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
index 3fa0db136667..47e03de7c235 100644
--- a/tools/perf/util/copyfile.c
+++ b/tools/perf/util/copyfile.c
@@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
 	if (tofd < 0)
 		goto out;
 
-	if (fchmod(tofd, mode))
-		goto out_close_to;
-
 	if (st.st_size == 0) { /* /proc? do it slowly... */
 		err = slow_copyfile(from, tmp, nsi);
+		if (!err && fchmod(tofd, mode))
+			err = -1;
 		goto out_close_to;
 	}
 
+	if (fchmod(tofd, mode))
+		goto out_close_to;
+
 	nsinfo__mountns_enter(nsi, &nsc);
 	fromfd = open(from, O_RDONLY);
 	nsinfo__mountns_exit(&nsc);
-- 
2.21.0
