From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/35] perf data: Force perf_data__open|close zero data->file.path
Date: Thu,  7 Mar 2019 14:44:33 -0300
Message-ID: <20190307174433.28819-36-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, Nageswara R Sastry <nasastry@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Making sure the data->file.path is zeroed on perf_data__open error path
and in perf_data__close, so we don't double free it in case someone call
it twice.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 7bd5ddeb7a41..e098e189f93e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -237,7 +237,7 @@ static int open_file(struct perf_data *data)
 	     open_file_read(data) : open_file_write(data);
 
 	if (fd < 0) {
-		free(data->file.path);
+		zfree(&data->file.path);
 		return -1;
 	}
 
@@ -270,7 +270,7 @@ int perf_data__open(struct perf_data *data)
 
 void perf_data__close(struct perf_data *data)
 {
-	free(data->file.path);
+	zfree(&data->file.path);
 	close(data->file.fd);
 }
 
-- 
2.20.1
