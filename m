From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/11] perf cpu_map: Align cpu map synthesized events properly.
Date: Wed, 17 Oct 2018 19:54:58 -0300
Message-ID: <20181017225501.32150-9-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Miller <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Miller <davem@davemloft.net>

The size of the resulting cpu map can be smaller than a multiple of
sizeof(u64), resulting in SIGBUS on cpus like Sparc as the next event
will not be aligned properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: 6c872901af07 ("perf cpu_map: Add cpu_map event synthesize function")
Link: http://lkml.kernel.org/r/20181011.224655.716771175766946817.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..0988eb3b844b 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1081,6 +1081,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
 	}
 
 	*size += sizeof(struct cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 
-- 
2.14.4
