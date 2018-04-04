From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/17] perf annotate stdio2: Print more descriptive event information header
Date: Tue,  3 Apr 2018 23:21:57 -0300
Message-ID: <20180404022158.12190-17-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match the recently added event header information to --tui, e.g.:

  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  Samples: 128  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 48617682
  _raw_spin_lock_irqsave() /proc/kcore
    0.78        nop
    7.03        push   %rbx
    3.12        pushfq
    6.25        pop    %rax
                nop
                mov    %rax,%rbx
    3.12        cli
                nop
                xor    %eax,%eax
                mov    $0x1,%edx
   79.69        lock   cmpxchg %edx,(%rdi)
                test   %eax,%eax
              ↓ jne    2b
                mov    %rbx,%rax
                pop    %rbx
              ← retq
          2b:   mov    %eax,%esi
              → callq  *ffffffffb30eaed0
                mov    %rbx,%rax
                pop    %rbx
              ← retq
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ujy46x7cldyhyxelyf2b9quy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b956bb7eabcf..fffe16af9797 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2325,7 +2325,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 	struct annotation_options opts = annotation__default_options;
-	const char *ev_name = perf_evsel__name(evsel);
+	struct annotation *notes = symbol__annotation(sym);
 	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
@@ -2337,12 +2337,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 		print_summary(&source_line, dso->long_name);
 	}
 
-	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
-		ev_name = buf;
-	}
-
-	fprintf(stdout, "%s() %s\nEvent: %s\n\n", sym->name, dso->long_name, ev_name);
+	annotation__scnprintf_samples_period(notes, buf, sizeof(buf), evsel);
+	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
-- 
2.14.3
