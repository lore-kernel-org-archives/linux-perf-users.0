From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/44] perf annotate: Use the default annotation options for --stdio2
Date: Sat, 24 Mar 2018 17:01:59 -0300
Message-ID: <20180324200211.21326-33-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With an empty '[annotate]' section in ~/.perfconfig:

  # perf record -a --all-kernel -e '{cycles,instructions}:P' sleep 5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.243 MB perf.data (5513 samples) ]
  # perf annotate --stdio2 _raw_spin_lock | head -20

                     Disassembly of section .text:

                     ffffffff81868790 <_raw_spin_lock>:
                     _raw_spin_lock():
                     EXPORT_SYMBOL(_raw_spin_trylock_bh);
                     #endif

                     #ifndef CONFIG_INLINE_SPIN_LOCK
                     void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
                     {
                     → callq  __fentry__
                     atomic_cmpxchg():
                             return xadd(&v->counter, -i);
                     }

                     static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
                     {
  # perf annotate --stdio2 _raw_spin_lock | head -20
                     → callq  __fentry__
                       xor    %eax,%eax
                       mov    $0x1,%edx
   87.50 100.00        lock   cmpxchg %edx,(%rdi)
    6.25   0.00        test   %eax,%eax
                     ↓ jne    16
    6.25   0.00        repz   retq
                 16:   mov    %eax,%esi
                     ↑ jmpq   ffffffff810e96b0 <queued_spin_lock_slowpath>
  #
  # cat ~/.perfconfig
  [annotate]

    hide_src_code = false
    show_linenr = true
  # perf annotate --stdio2 _raw_spin_lock | head -20

                 3   Disassembly of section .text:

                 5   ffffffff81868790 <_raw_spin_lock>:
                 6   _raw_spin_lock():
                 143 EXPORT_SYMBOL(_raw_spin_trylock_bh);
                 144 #endif

                 146 #ifndef CONFIG_INLINE_SPIN_LOCK
                 147 void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
                 148 {
                     → callq  __fentry__
                 150 atomic_cmpxchg():
                 187         return xadd(&v->counter, -i);
                 188 }

                 190 static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
                 191 {
  #
  # cat ~/.perfconfig
  [annotate]

    hide_src_code = true
    show_total_period = true
  # perf annotate --stdio2 _raw_spin_lock | head -20
                               → callq  __fentry__
                                 xor    %eax,%eax
                                 mov    $0x1,%edx
      1411316      152339        lock   cmpxchg %edx,(%rdi)
       344694           0        test   %eax,%eax
                               ↓ jne    16
        80806           0        repz   retq
                           16:   mov    %eax,%esi
                               ↑ jmpq   ffffffff810e96b0 <queued_spin_lock_slowpath>
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nu4rxg5zkdtgs1b2gc40p7v7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cfa641bc1df6..ea83b9754ab0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2243,9 +2243,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation_options opts = {
-		.use_offset	= true,
-	};
+	struct annotation_options opts = annotation__default_options;
 
 	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
 		return -1;
-- 
2.14.3
