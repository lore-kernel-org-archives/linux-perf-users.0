From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  14/22] perf: Fix dso__load_sym to put dso
Date: Wed, 09 Dec 2015 11:11:18 +0900
Message-ID: <20151209021118.10245.49869.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Fix dso__load_sym to put dso because dsos__add already got it.

Refcnt debugger explain the problem:
  ----
  ==== [0] ====
  Unreclaimed dso: 0x19dd200
  Refcount +1 => 1 at
    ./perf(dso__new+0x1ff) [0x4a62df]
    ./perf(dso__load_sym+0xe89) [0x503509]
    ./perf(dso__load_vmlinux+0xbf) [0x4aa77f]
    ./perf(dso__load_vmlinux_path+0x8c) [0x4aa8dc]
    ./perf() [0x50539a]
    ./perf(convert_perf_probe_events+0xd79) [0x50ad39]
    ./perf() [0x45600f]
    ./perf(cmd_probe+0x6c) [0x4566bc]
    ./perf() [0x47abc5]
    ./perf(main+0x610) [0x421f90]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f74dd0efaf5]
    ./perf() [0x4220a9]
  Refcount +1 => 2 at
    ./perf(dso__get+0x34) [0x4a65f4]
    ./perf(map__new2+0x76) [0x4be216]
    ./perf(dso__load_sym+0xee1) [0x503561]
    ./perf(dso__load_vmlinux+0xbf) [0x4aa77f]
    ./perf(dso__load_vmlinux_path+0x8c) [0x4aa8dc]
    ./perf() [0x50539a]
    ./perf(convert_perf_probe_events+0xd79) [0x50ad39]
    ./perf() [0x45600f]
    ./perf(cmd_probe+0x6c) [0x4566bc]
    ./perf() [0x47abc5]
    ./perf(main+0x610) [0x421f90]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f74dd0efaf5]
    ./perf() [0x4220a9]
  Refcount +1 => 3 at
    ./perf(dsos__add+0xf3) [0x4a6bc3]
    ./perf(dso__load_sym+0xfc1) [0x503641]
    ./perf(dso__load_vmlinux+0xbf) [0x4aa77f]
    ./perf(dso__load_vmlinux_path+0x8c) [0x4aa8dc]
    ./perf() [0x50539a]
    ./perf(convert_perf_probe_events+0xd79) [0x50ad39]
    ./perf() [0x45600f]
    ./perf(cmd_probe+0x6c) [0x4566bc]
    ./perf() [0x47abc5]
    ./perf(main+0x610) [0x421f90]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f74dd0efaf5]
    ./perf() [0x4220a9]
  Refcount -1 => 2 at
    ./perf(dso__put+0x2f) [0x4a664f]
    ./perf(map_groups__exit+0xb9) [0x4bee29]
    ./perf(machine__delete+0xb0) [0x4b93d0]
    ./perf(exit_probe_symbol_maps+0x28) [0x506718]
    ./perf() [0x45628a]
    ./perf(cmd_probe+0x6c) [0x4566bc]
    ./perf() [0x47abc5]
    ./perf(main+0x610) [0x421f90]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f74dd0efaf5]
    ./perf() [0x4220a9]
  Refcount -1 => 1 at
    ./perf(dso__put+0x2f) [0x4a664f]
    ./perf(machine__delete+0xfe) [0x4b941e]
    ./perf(exit_probe_symbol_maps+0x28) [0x506718]
    ./perf() [0x45628a]
    ./perf(cmd_probe+0x6c) [0x4566bc]
    ./perf() [0x47abc5]
    ./perf(main+0x610) [0x421f90]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f74dd0efaf5]
    ./perf() [0x4220a9]
  ----
So, in the dso__load_sym, dso is gotten 3 times, by dso__new,
map__new2, and dsos__add. The last 2 is actually released by
map_groups and machine__delete correspondingly. However, the
first reference by dso__new, is never released.

This solves this issue by putting dso right after dsos__add.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/symbol-elf.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 53f1996..a5703ac 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1045,6 +1045,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
 				/* kmaps already got it */
 				map__put(curr_map);
 				dsos__add(&map->groups->machine->dsos, curr_dso);
+				/* curr_map and machine->dsos already got it */
+				dso__put(curr_dso);
 				dso__set_loaded(curr_dso, map->type);
 			} else
 				curr_dso = curr_map->dso;
