From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/17] perf ui: Make 'exit_msg' optional in ui__question_window()
Date: Tue, 20 Aug 2019 16:27:28 -0300
Message-ID: <20190820192733.19180-13-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We will not need it when refactoring this function to be
non-interactive, so make it optional.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pnx1dn17bsz7lqt9ty95nnjx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/util.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index fe5e571816fc..5d65ea8b6496 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -188,7 +188,9 @@ int ui__question_window(const char *title, const char *text,
 	pthread_mutex_lock(&ui__lock);
 
 	max_len += 2;
-	nr_lines += 4;
+	nr_lines += 2;
+	if (exit_msg)
+		nr_lines += 2;
 	y = SLtt_Screen_Rows / 2 - nr_lines / 2,
 	x = SLtt_Screen_Cols / 2 - max_len / 2;
 
@@ -199,14 +201,20 @@ int ui__question_window(const char *title, const char *text,
 		SLsmg_write_string((char *)title);
 	}
 	SLsmg_gotorc(++y, x);
-	nr_lines -= 2;
+	if (exit_msg)
+		nr_lines -= 2;
 	max_len -= 2;
 	SLsmg_write_wrapped_string((unsigned char *)text, y, x,
 				   nr_lines, max_len, 1);
 	SLsmg_gotorc(y + nr_lines - 2, x);
 	SLsmg_write_nstring((char *)" ", max_len);
 	SLsmg_gotorc(y + nr_lines - 1, x);
-	SLsmg_write_nstring((char *)exit_msg, max_len);
+	if (exit_msg) {
+		SLsmg_gotorc(y + nr_lines - 2, x);
+		SLsmg_write_nstring((char *)" ", max_len);
+		SLsmg_gotorc(y + nr_lines - 1, x);
+		SLsmg_write_nstring((char *)exit_msg, max_len);
+	}
 	SLsmg_refresh();
 
 	pthread_mutex_unlock(&ui__lock);
-- 
2.21.0
