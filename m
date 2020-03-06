From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/5] perf env: Do not return pointers to local variables
Date: Fri,  6 Mar 2020 16:11:36 -0300
Message-ID: <20200306191144.12762-4-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is possible to return a pointer to a local variable when looking up
the architecture name for the running system and no normalization is
done on that value, i.e. we may end up returning the uts.machine local
variable.

While this doesn't happen on most arches, as normalization takes place,
lets fix this by making that a static variable and optimize it a bit by
not always running uname(), only the first time.

Noticed in fedora rawhide running with:

  [perfbuilder@a5ff49d6e6e4 ~]$ gcc --version
  gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8)

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6242a9215df7..4154f944f474 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -343,11 +343,11 @@ static const char *normalize_arch(char *arch)
 
 const char *perf_env__arch(struct perf_env *env)
 {
-	struct utsname uts;
 	char *arch_name;
 
 	if (!env || !env->arch) { /* Assume local operation */
-		if (uname(&uts) < 0)
+		static struct utsname uts = { .machine[0] = '\0', };
+		if (uts.machine[0] == '\0' && uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
 	} else
-- 
2.21.1
