From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/54] perf report: Display perf.data header info
Date: Thu,  8 Mar 2018 16:50:16 -0300
Message-ID: <20180308195029.14991-42-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Display more header info from perf.data file, following values:

  $ perf report -i perf.data --header-only
  ...
  # header version : 1
  # data offset    : 424
  # data size      : 3364280
  # feat offset    : 3364704

It's handy for debuging.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a326e0d8b5b6..e0c3cad0fd8d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2318,7 +2318,12 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	fprintf(fp, "# captured on: %s", ctime(&st.st_ctime));
+	fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
+
+	fprintf(fp, "# header version : %u\n", header->version);
+	fprintf(fp, "# data offset    : %" PRIu64 "\n", header->data_offset);
+	fprintf(fp, "# data size      : %" PRIu64 "\n", header->data_size);
+	fprintf(fp, "# feat offset    : %" PRIu64 "\n", header->feat_offset);
 
 	perf_header__process_sections(header, fd, &hd,
 				      perf_file_section__fprintf_info);
-- 
2.14.3
