From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/28] perf top: Set display thread COMM to help with debugging
Date: Wed, 14 Aug 2019 15:40:30 -0300
Message-ID: <20190814184051.3125-8-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we want to attach just to the thread that updates the display it
helps having its COMM stand out, so change it from the default "perf" to
"perf-top-UI".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5w0hmlk3zfvysxvpsh763k9w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1a4615a5f6c9..94e34853a238 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -601,6 +601,8 @@ static void *display_thread_tui(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	perf_top__sort_new_samples(top);
 
 	/*
@@ -651,6 +653,8 @@ static void *display_thread(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	display_setup_sig();
 	pthread__unblock_sigwinch();
 repeat:
-- 
2.21.0
