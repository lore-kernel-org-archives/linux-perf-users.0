From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/17] perf record: Remove suggestion to enable APIC
Date: Fri, 20 Apr 2018 11:32:23 -0300
Message-ID: <20180420143227.16030-14-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

'perf record' suggests to enable the APIC on errors.

APIC is practically always used today and the problem is usually
somewhere else.

Just remove the outdated suggestion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66b62570c855..3e87486c28fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2870,8 +2870,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 #if defined(__i386__) || defined(__x86_64__)
 		if (evsel->attr.type == PERF_TYPE_HARDWARE)
 			return scnprintf(msg, size, "%s",
-	"No hardware sampling interrupt available.\n"
-	"No APIC? If so then you can boot the kernel with the \"lapic\" boot parameter to force-enable it.");
+	"No hardware sampling interrupt available.\n");
 #endif
 		break;
 	case EBUSY:
-- 
2.14.3
