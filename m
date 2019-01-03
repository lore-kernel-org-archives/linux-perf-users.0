From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/29] perf python: Do not force closing original perf descriptor in evlist.get_pollfd()
Date: Thu,  3 Jan 2019 09:45:46 -0300
Message-ID: <20190103124609.29672-7-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Ond=C5=99ej=20Lyson=C4=9Bk?= <olysonek@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Ondřej reported that when compiled with python3, the python extension
regresses in evlist.get_pollfd function behaviour.

The evlist.get_pollfd function creates file objects from evlist's fds
and returns them in a list. The python3 version also sets them to 'close
the original descriptor' when the object dies (is closed), by passing
True via the 'closefd' arg in the PyFile_FromFd call.

The python's closefd doc says:

  If closefd is False, the underlying file descriptor will be kept open
  when the file is closed.

That's why the following line in python3 closes all evlist fds:

  evlist.get_pollfd()

the returned list is immediately destroyed and that takes down the
original events fds.

Passing closefd as False to PyFile_FromFd to fix this.

Reported-by: Ondřej Lysoněk <olysonek@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")
Link: http://lkml.kernel.org/r/20181226112121.5285-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 47628e85c5eb..dda0ac978b1e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -939,7 +939,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 		file = PyFile_FromFile(fp, "perf", "r", NULL);
 #else
-		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1, NULL, NULL, NULL, 1);
+		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1,
+				     NULL, NULL, NULL, 0);
 #endif
 		if (file == NULL)
 			goto free_list;
-- 
2.19.2
