From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/46] perf test code-reading: Fix perf_env setup for PTI entry trampolines
Date: Tue,  5 Jun 2018 14:50:23 -0300
Message-ID: <20180605175030.32549-40-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The "Object code reading" test will not create maps for the PTI entry
trampolines unless the machine environment exists to show that the arch is
x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1528183800-21577-1-git-send-email-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index afa4ce21ba7c..4892bd2dc33e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -560,6 +560,7 @@ static int do_test_code_reading(bool try_kcore)
 	pid = getpid();
 
 	machine = machine__new_host();
+	machine->env = &perf_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
-- 
2.14.3
