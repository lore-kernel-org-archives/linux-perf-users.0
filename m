From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/43] perf header: Get rid of write_it label
Date: Thu, 14 Feb 2019 21:45:37 -0300
Message-ID: <20190215004539.23571-42-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Simplifying the code a bit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..f1508adefc16 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1042,11 +1042,9 @@ static int write_cpuid(struct feat_fd *ff,
 	int ret;
 
 	ret = get_cpuid(buffer, sizeof(buffer));
-	if (!ret)
-		goto write_it;
+	if (ret)
+		return -1;
 
-	return -1;
-write_it:
 	return do_write_string(ff, buffer);
 }
 
-- 
2.19.1
