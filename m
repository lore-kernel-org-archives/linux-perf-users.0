From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/11] perf buildid-cache: Document for Node.js USDT
Date: Fri, 24 Nov 2017 12:02:29 -0300
Message-ID: <20171124150232.18676-9-acme@kernel.org>
References: <20171124150232.18676-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171124150232.18676-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hansuk Hong <flavono123@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Hansuk Hong <flavono123@gmail.com>

Add a tip for Node.js USDT(User-Level Statically Defined Tracing) probes
in tips.txt

Signed-off-by: Hansuk Hong <flavono123@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20171123160546.9722-1-flavono123@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/tips.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index db0ca3063eae..3dd1dbe28407 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -32,3 +32,4 @@ Order by the overhead of source file name and line number: perf report -s srclin
 System-wide collection from all CPUs: perf record -a
 Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
+To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
-- 
2.13.6
