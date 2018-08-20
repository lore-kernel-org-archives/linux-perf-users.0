From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/21] perf tools: Get rid of dso__needs_decompress() call in __open_dso()
Date: Mon, 20 Aug 2018 13:15:48 -0300
Message-ID: <20180820161602.6830-8-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 51cf82cf1882..8ee1faa5726f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -468,6 +468,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	int fd = -EINVAL;
 	char *root_dir = (char *)"";
 	char *name = malloc(PATH_MAX);
+	bool decomp = false;
 
 	if (!name)
 		return -ENOMEM;
@@ -491,12 +492,13 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 			goto out;
 		}
 
+		decomp = true;
 		strcpy(name, newpath);
 	}
 
 	fd = do_open(name);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(name);
 
 out:
-- 
2.14.4
