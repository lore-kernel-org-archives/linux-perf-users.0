From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/35] perf session: Fix double free in perf_data__close
Date: Thu,  7 Mar 2019 14:44:32 -0300
Message-ID: <20190307174433.28819-35-acme@kernel.org>
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

We can't call perf_data__close and subsequently perf_session__delete,
because it will call perf_data__close again and cause double free for
data->file.path.

  $ perf report -i .
  incompatible file format (rerun with -v to learn more)
  free(): double free detected in tcache 2
  Aborted (core dumped)

In fact we don't need to call perf_data__close at all, because at the
time the got out_close is reached, session->data is already initialized,
so the perf_data__close call will be triggered from
perf_session__delete.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: 2d4f27999b88 ("perf data: Add global path holder")
Link: http://lkml.kernel.org/r/20190305152536.21035-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c764bbc91009..db643f3c2b95 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -140,7 +140,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 		if (perf_data__is_read(data)) {
 			if (perf_session__open(session) < 0)
-				goto out_close;
+				goto out_delete;
 
 			/*
 			 * set session attributes that are present in perf.data
@@ -181,8 +181,6 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 	return session;
 
- out_close:
-	perf_data__close(data);
  out_delete:
 	perf_session__delete(session);
  out:
-- 
2.20.1
