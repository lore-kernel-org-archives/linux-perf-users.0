From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/69] perf beauty: Make strarray's offset be u64
Date: Fri, 11 Oct 2019 17:05:16 -0300
Message-ID: <20191011200559.7156-27-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need it for things like MSRs that are sparse and go over MAXINT.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-g8t2d0jr0mg3yimg2qrjkvlt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 4cc4f6b3d4a1..5ad7542b428b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -7,7 +7,7 @@
 #include <sys/types.h>
 
 struct strarray {
-	int	    offset;
+	u64	    offset;
 	int	    nr_entries;
 	const char *prefix;
 	const char **entries;
-- 
2.21.0
