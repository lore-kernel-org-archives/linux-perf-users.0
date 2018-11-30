From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/22] perf env: Also consider env->arch == NULL as local operation
Date: Fri, 30 Nov 2018 15:26:35 -0300
Message-ID: <20181130182652.23620-6-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll set a new machine field based on env->arch, which for live mode,
like with 'perf top' means we need to use uname() to figure the name of
the arch, fix perf_env__arch() to consider both (env == NULL) and
(env->arch == NULL) as local operation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/n/tip-vcz4ufzdon7cwy8dm2ua53xk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 59f38c7693f8..4c23779e271a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -166,7 +166,7 @@ const char *perf_env__arch(struct perf_env *env)
 	struct utsname uts;
 	char *arch_name;
 
-	if (!env) { /* Assume local operation */
+	if (!env || !env->arch) { /* Assume local operation */
 		if (uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
-- 
2.19.1
