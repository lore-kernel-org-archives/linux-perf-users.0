From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf report: include partial stacks unwound with libdw
Date: Thu,  1 Jun 2017 23:00:21 +0200
Message-ID: <20170601210021.20046-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

So far the whole stack was thrown away when any error occurred
before the maximum stack depth was unwound. This is actually a very
common scenario though. The stacks that got unwound so far are
still interesting. This removes a large chunk of differences when
comparing perf script output for libunwind and libdw perf unwinding.

E.g. with libunwind:

~~~~~
heaptrack_gui  2228 135073.388524:     479408 cycles:
        ffffffff811749ed perf_iterate_ctx ([kernel.kallsyms])
        ffffffff81181662 perf_event_mmap ([kernel.kallsyms])
        ffffffff811cf5ed mmap_region ([kernel.kallsyms])
        ffffffff811cfe6b do_mmap ([kernel.kallsyms])
        ffffffff811b0dca vm_mmap_pgoff ([kernel.kallsyms])
        ffffffff811cdb0c sys_mmap_pgoff ([kernel.kallsyms])
        ffffffff81033acb sys_mmap ([kernel.kallsyms])
        ffffffff81631d37 entry_SYSCALL_64_fastpath ([kernel.kallsyms])
                   192ca mmap64 (/usr/lib/ld-2.25.so)
                    59a9 _dl_map_object_from_fd (/usr/lib/ld-2.25.so)
                    83d0 _dl_map_object (/usr/lib/ld-2.25.so)
                    cda1 openaux (/usr/lib/ld-2.25.so)
                   1834f _dl_catch_error (/usr/lib/ld-2.25.so)
                    cfe2 _dl_map_object_deps (/usr/lib/ld-2.25.so)
                    3481 dl_main (/usr/lib/ld-2.25.so)
                   17387 _dl_sysdep_start (/usr/lib/ld-2.25.so)
                    4d37 _dl_start (/usr/lib/ld-2.25.so)
                     d87 _start (/usr/lib/ld-2.25.so)

heaptrack_gui  2228 135073.388677:     611329 cycles:
                   1a3e0 strcmp (/usr/lib/ld-2.25.so)
                    82b2 _dl_map_object (/usr/lib/ld-2.25.so)
                    cda1 openaux (/usr/lib/ld-2.25.so)
                   1834f _dl_catch_error (/usr/lib/ld-2.25.so)
                    cfe2 _dl_map_object_deps (/usr/lib/ld-2.25.so)
                    3481 dl_main (/usr/lib/ld-2.25.so)
                   17387 _dl_sysdep_start (/usr/lib/ld-2.25.so)
                    4d37 _dl_start (/usr/lib/ld-2.25.so)
                     d87 _start (/usr/lib/ld-2.25.so)
~~~~~

With libdw without this patch:

~~~~~
heaptrack_gui  2228 135073.388524:     479408 cycles:
        ffffffff811749ed perf_iterate_ctx ([kernel.kallsyms])
        ffffffff81181662 perf_event_mmap ([kernel.kallsyms])
        ffffffff811cf5ed mmap_region ([kernel.kallsyms])
        ffffffff811cfe6b do_mmap ([kernel.kallsyms])
        ffffffff811b0dca vm_mmap_pgoff ([kernel.kallsyms])
        ffffffff811cdb0c sys_mmap_pgoff ([kernel.kallsyms])
        ffffffff81033acb sys_mmap ([kernel.kallsyms])
        ffffffff81631d37 entry_SYSCALL_64_fastpath ([kernel.kallsyms])

heaptrack_gui  2228 135073.388677:     611329 cycles:
~~~~~

With this patch applied, the libdw unwinder will produce the same
output as the libunwind unwinder.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 943a06291587..b4c20124d2ee 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -224,7 +224,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 
 	err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
 
-	if (err && !ui->max_stack)
+	if (err && ui->max_stack != max_stack)
 		err = 0;
 
 	/*
-- 
2.13.0
