From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Date: Tue, 2 Oct 2018 12:32:36 -0300
Message-ID: <20181002153236.GD3541@kernel.org>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002073949.3297-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 02, 2018 at 09:39:49AM +0200, Milian Wolff escreveu:
> Only use the mapped IP to find inline frames, but keep
> using the unmapped IP for the callchain cursor. This
> ensures we properly show the unmapped IP when displaying
> a frame we received via the dso__parse_addr_inlines API
> for a module which does not contain sufficient debug symbols
> to show the srcline.

So, the patch came mangled, I fixed it up, please check, I'm adding Ravi
to the CC list, so that he can check as well and retest, right Ravi?

- Arnaldo

From d9ddee9653d5676130471de9bc688fc7ec7b4fc4 Mon Sep 17 00:00:00 2001
From: Milian Wolff <milian.wolff@kdab.com>
Date: Tue, 2 Oct 2018 09:39:49 +0200
Subject: [PATCH 1/1] perf record: use unmapped IP for inline callchain cursors

Only use the mapped IP to find inline frames, but keep using the unmapped IP
for the callchain cursor. This ensures we properly show the unmapped IP when
displaying a frame we received via the dso__parse_addr_inlines API for a module
which does not contain sufficient debug symbols to show the srcline.

Before:

  $ perf record -e cycles:u --call-graph ls
  $ perf script
  ...
  ls 12853  2735.563911:      43354 cycles:u:
                     17878 __GI___tunables_init+0xffff01d1d63a0118 (/usr/lib/ld-2.28.so)
                     19ee9 _dl_sysdep_start+0xffff01d1d63a02e9 (/usr/lib/ld-2.28.so)
                      3087 _dl_start+0xffff01d1d63a0287 (/usr/lib/ld-2.28.so)
                      2007 _start+0xffff01d1d63a0007 (/usr/lib/ld-2.28.so)

After:

  $ perf script
  ...
  ls 12853  2735.563911:      43354 cycles:u:
              7f1714e46878 __GI___tunables_init+0x118 (/usr/lib/ld-2.28.so)
              7f1714e48ee9 _dl_sysdep_start+0x2e9 (/usr/lib/ld-2.28.so)
              7f1714e32087 _dl_start+0x287 (/usr/lib/ld-2.28.so)
              7f1714e31007 _start+0x7 (/usr/lib/ld-2.28.so)

For frames with sufficient debug symbols, the behavior is still sane and works
as expected in my tests.

This patch series shows that we desperately need an automated test for inline
frame resolution. I'll try to come up with something for the various
regressions in the future.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: bfe16b0653 ("perf report: Don't crash on invalid inline debug information")
Link: http://lkml.kernel.org/r/20181002073949.3297-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 73a651f10a0f..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__rip_2objdump(map, ip);
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
 
 	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
@@ -2317,6 +2318,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
 
+	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
+		return 0;
+
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2324,9 +2328,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (entry->map)
 		addr = map__map_ip(entry->map, entry->ip);
 
-	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
-		return 0;
-
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-- 
2.14.4
