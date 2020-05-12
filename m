From: Anand K Mistry <amistry@google.com>
Subject: [PATCH] perf record: Use an eventfd to wakeup when done
Date: Tue, 12 May 2020 14:59:36 +1000
Message-ID: <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Anand K Mistry <amistry@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The setting and checking of 'done' contains a rare race where the signal
handler setting 'done' is run after checking to break the loop, but
before waiting in evlist__poll(). In this case, the main loop won't wake
up until either another signal is sent, or the perf data fd causes a
wake up.

The following simple script can trigger this condition (but you might
need to run it for several hours):
for ((i = 0; i >= 0; i++)) ; do
  echo "Loop $i"
  delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
  ./perf record -- sleep 30000000 >/dev/null&
  pid=$!
  sleep $delay
  kill -TERM $pid
  echo "PID $pid"
  wait $pid
done

At some point, the loop will stall. Adding logging, even though perf has
received the SIGTERM and set 'done = 1', perf will remain sleeping until
a second signal is sent.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

 tools/perf/builtin-record.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe90469..099ecaa66732a2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,7 @@
 #include <unistd.h>
 #include <sched.h>
 #include <signal.h>
+#include <sys/eventfd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/types.h>
@@ -518,15 +519,28 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 
 static volatile int signr = -1;
 static volatile int child_finished;
+static int done_fd = -1;
 
 static void sig_handler(int sig)
 {
+	u64 tmp = 1;
 	if (sig == SIGCHLD)
 		child_finished = 1;
 	else
 		signr = sig;
 
 	done = 1;
+
+	/*
+	 * It is possible for this signal handler to run after done is checked
+	 * in the main loop, but before the perf counter fds are polled. If this
+	 * happens, the poll() will continue to wait even though done is set,
+	 * and will only break out if either another signal is received, or the
+	 * counters are ready for read. To ensure the poll() doesn't sleep when
+	 * done is set, use an eventfd (done_fd) to wake up the poll().
+	 */
+	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
+		pr_err("failed to signal wakeup fd\n");
 }
 
 static void sigsegv_handler(int sig)
@@ -1424,6 +1438,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	int fd;
 	float ratio = 0;
 
+	done_fd = eventfd(0, EFD_NONBLOCK);
+	if (done_fd < 0) {
+		pr_err("Failed to create wakeup eventfd, error: %m\n");
+		return -1;
+	}
+	err = evlist__add_pollfd(rec->evlist, done_fd);
+	if (err < 0) {
+		pr_err("Failed to add wakeup eventfd to poll list\n");
+		return -1;
+	}
+
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
-- 
2.26.2.645.ge9eca65c58-goog
