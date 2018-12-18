From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/63] perf bpf: Move perf_event_output() from stdio.h to bpf.h
Date: Tue, 18 Dec 2018 19:06:53 -0300
Message-ID: <20181218220733.15839-24-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't always carry that __bpf_output__ map, leaving that to
the scripts wanting to use that facility.

'perf trace' will be changed to look if that map is present and only
setup the bpf-output events if so.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-azwys8irxqx9053vpajr0k5h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h   | 2 ++
 tools/perf/include/bpf/stdio.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index bd5d7b4d7760..e667577207dc 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -55,4 +55,6 @@ int _version SEC("version") = LINUX_VERSION_CODE;
 static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
 static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
 
+static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
+
 #endif /* _PERF_BPF_H */
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 2899cb7bfed8..316af5b2ff35 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -9,9 +9,6 @@ struct bpf_map SEC("maps") __bpf_stdout__ = {
        .max_entries = __NR_CPUS__,
 };
 
-static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) =
-	(void *)BPF_FUNC_perf_event_output;
-
 #define puts(from) \
 	({ const int __len = sizeof(from); \
 	   char __from[__len] = from; \
-- 
2.19.2
