From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/21] perf bpf: Show better message when failing to load an object
Date: Wed,  1 Aug 2018 18:36:45 -0300
Message-ID: <20180801213648.4814-19-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  libbpf: license of tools/perf/examples/bpf/etcsnoop.c is GPL
  libbpf: section(6) version, size 4, link 0, flags 3, type=1
  libbpf: kernel version of tools/perf/examples/bpf/etcsnoop.c is 41200
  libbpf: section(7) .symtab, size 120, link 1, flags 0, type=2
  bpf: config program 'syscalls:sys_enter_openat'
  libbpf: load bpf program failed: Operation not permitted
  libbpf: failed to load program 'syscalls:sys_enter_openat'
  libbpf: failed to load object 'tools/perf/examples/bpf/etcsnoop.c'
  bpf: load objects failed

After: (just the last line changes)

  bpf: load objects failed: err=-4009: (Incorrect kernel version)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wi44iid0yjfht3lcvplc75fm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index cee658733e2c..3d02ae38ec56 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -747,7 +747,9 @@ int bpf__load(struct bpf_object *obj)
 
 	err = bpf_object__load(obj);
 	if (err) {
-		pr_debug("bpf: load objects failed\n");
+		char bf[128];
+		libbpf_strerror(err, bf, sizeof(bf));
+		pr_debug("bpf: load objects failed: err=%d: (%s)\n", err, bf);
 		return err;
 	}
 	return 0;
-- 
2.14.4
