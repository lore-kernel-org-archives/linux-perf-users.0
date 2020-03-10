From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/19] perf llvm: Add debug hint message about missing kernel-devel package
Date: Tue, 10 Mar 2020 08:15:35 -0300
Message-ID: <20200310111551.25160-4-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help in debugging, add this extra message:

  detect_kbuild_dir: Couldn't find "/lib/modules/5.4.20-200.fc31.x86_64/build/include/generated/autoconf.h", missing kernel-devel package?.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index b5af680fc667..dbdffb6673fe 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -265,6 +265,8 @@ static int detect_kbuild_dir(char **kbuild_dir)
 			return -ENOMEM;
 		return 0;
 	}
+	pr_debug("%s: Couldn't find \"%s\", missing kernel-devel package?.\n",
+		 __func__, autoconf_path);
 	free(autoconf_path);
 	return -ENOENT;
 }
-- 
2.21.1
