From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/29] perf bpf examples: Convert etcsnoop to use bpf_map()
Date: Sat, 26 Jan 2019 00:18:42 +0100
Message-ID: <20190125231843.2895-29-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Making the code more compact, end result is the same:

  # trace -e /home/acme/git/perf/tools/perf/examples/bpf/etcsnoop.c
     0.000 (         ): sed/7385 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
  2727.723 (         ): cat/7389 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
  2728.543 (         ): cat/7389 openat(dfd: CWD, filename: "/etc/passwd")                          ...
  ^C

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-znhgz24p0daux2kay200ovc1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/etcsnoop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/etcsnoop.c b/tools/perf/examples/bpf/etcsnoop.c
index 550e69c2e8d1..e81b535346c0 100644
--- a/tools/perf/examples/bpf/etcsnoop.c
+++ b/tools/perf/examples/bpf/etcsnoop.c
@@ -21,12 +21,8 @@
 
 #include <stdio.h>
 
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-       .key_size = sizeof(int),
-       .value_size = sizeof(u32),
-       .max_entries = __NR_CPUS__,
-};
+/* bpf-output associated map */
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct augmented_filename {
 	int	size;
-- 
2.20.1
