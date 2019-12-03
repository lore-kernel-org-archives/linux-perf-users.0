From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/23] perf beauty: Add CLEAR_SIGHAND support for clone's flags arg
Date: Tue,  3 Dec 2019 10:56:02 -0300
Message-ID: <20191203135606.24902-20-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Adrian Reber <areber@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add support for the recently added CLONE_CLEAR_SIGHAND flag.

This takes advantage of the copy of the uapi/linux/sched.h we have in
tools/include, which allows us to build tools/perf in older systems and
have the binary support printing that flag whenever that system gets its
kernel updated to one where this feature is present.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Reber <areber@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org
Link: https://lkml.kernel.org/n/tip-1vnz497ubtu5oz16ygdcul0e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index 1a8d3be2030e..062ca849c8fd 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -45,6 +45,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(NEWPID);
 	P_FLAG(NEWNET);
 	P_FLAG(IO);
+	P_FLAG(CLEAR_SIGHAND);
 #undef P_FLAG
 
 	if (flags)
-- 
2.21.0
