From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/63] perf beauty mmap: Print PROT_READ before PROT_EXEC to match strace output
Date: Tue, 18 Dec 2018 19:07:27 -0300
Message-ID: <20181218220733.15839-58-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Helps with comparing 'strace' and 'perf trace' output, for mutual
regression testing.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-va0qe95xbhep5hy52aq5qe0v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 138f36a47fb1..eb31089790e3 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -17,8 +17,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 		prot &= ~PROT_##n; \
 	}
 
-	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(READ);
+	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(WRITE);
 	P_MMAP_PROT(SEM);
 	P_MMAP_PROT(GROWSDOWN);
-- 
2.19.2
