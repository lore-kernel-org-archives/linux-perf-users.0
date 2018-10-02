From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf record: use unmapped IP for inline callchain cursors
Date: Tue,  2 Oct 2018 09:39:49 +0200
Message-ID: <20181002073949.3297-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

Only use the mapped IP to find inline frames, but keep
using the unmapped IP for the callchain cursor. This
ensures we properly show the unmapped IP when displaying
a frame we received via the dso__parse_addr_inlines API
for a module which does not contain sufficient debug symbols
to show the srcline.

Before:
$ perf record -e cycles:u --call-graph ls
$ perf script
...
ls 12853  2735.563911:      43354 cycles:u:
                   17878 __GI___tunables_init+0xffff01d1d63a0118 (/usr/li=
b/ld-2.28.so)
                   19ee9 _dl_sysdep_start+0xffff01d1d63a02e9 (/usr/lib/ld=
-2.28.so)
                    3087 _dl_start+0xffff01d1d63a0287 (/usr/lib/ld-2.28.s=
o)
                    2007 _start+0xffff01d1d63a0007 (/usr/lib/ld-2.28.so)

After:

$ perf script
...
ls 12853  2735.563911:      43354 cycles:u:
            7f1714e46878 __GI___tunables_init+0x118 (/usr/lib/ld-2.28.so)
            7f1714e48ee9 _dl_sysdep_start+0x2e9 (/usr/lib/ld-2.28.so)
            7f1714e32087 _dl_start+0x287 (/usr/lib/ld-2.28.so)
            7f1714e31007 _start+0x7 (/usr/lib/ld-2.28.so)

For frames with sufficient debug symbols, the behavior is
still sane and works as expected in my tests.

This patch series shows that we desperately need
an automated test for inline frame resolution. I'll try to
come up with something for the various regressions in the future.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
# Tested-by:
# Reviewed-by:
# Suggested-b:
Fixes: bfe16b0653 ("perf report: Don't crash on invalid inline debug info=
rmation")
---
 tools/perf/util/machine.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 73a651f10a0f..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *=
cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
=20
-	addr =3D map__rip_2objdump(map, ip);
+	addr =3D map__map_ip(map, ip);
+	addr =3D map__rip_2objdump(map, addr);
=20
 	inline_node =3D inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
@@ -2317,6 +2318,9 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
=20
+	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) =3D=3D 0)
+		return 0;
+
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2324,9 +2328,6 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (entry->map)
 		addr =3D map__map_ip(entry->map, entry->ip);
=20
-	if (append_inlines(cursor, entry->map, entry->sym, addr) =3D=3D 0)
-		return 0;
-
 	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
--=20
2.19.0
