From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/27] perf help: Add missing subcommand `version`
Date: Mon, 24 Sep 2018 12:02:16 -0300
Message-ID: <20180924150242.14235-2-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

There isn't subcommand `version` when typing `perf help`.

Before :

  $ perf help | grep version
   usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

So add perf-version in command-list.txt for listing it when typing `perf
help`.

After :

$ perf help | grep version

 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
   version         display the version of perf binary

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180919074911.41931-1-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 2d0caf20ff3a..bc6c585f74fc 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -30,3 +30,4 @@ perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
+perf-version			mainporcelain common
-- 
2.14.4
