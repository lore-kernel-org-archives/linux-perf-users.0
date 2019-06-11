From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/85] perf trace: Consume the augmented_raw_syscalls payload
Date: Tue, 11 Jun 2019 15:58:17 -0300
Message-ID: <20190611185911.11645-32-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To support the SCA_FILENAME beautifier in more than one syscall arg, as
needed for syscalls such as the rename* family, we need to, after
processing one such arg, bump the augmented pointers so that the next
augmented arg don't reuse data for the previous augmented arguments.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4e4cmzyjxb3wkonfo1x9a27y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 19f22127f02e..905e57c336b0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1233,8 +1233,17 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
+	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	/*
+	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
+	 * we would have two strings, each prefixed by its size.
+	 */
+	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
-	return scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	arg->augmented.args += consumed;
+	arg->augmented.size -= consumed;
+
+	return printed;
 }
 
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
-- 
2.20.1
