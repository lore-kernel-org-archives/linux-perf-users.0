From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 1/3] perf report: don't try to map ip to invalid map
Date: Wed, 26 Sep 2018 15:52:05 +0200
Message-ID: <20180926135207.30263-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Sandipan Das <sandipan@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Fixes a crash when the report encounters an address that
could not be associated with an mmaped region:

#0  0x00005555557bdc4a in callchain_srcline (ip=3D<error reading variable=
: Cannot access memory at address 0x38>, sym=3D0x0, map=3D0x0) at util/ma=
chine.c:2329
#1  unwind_entry (entry=3Dentry@entry=3D0x7fffffff9180, arg=3Darg@entry=3D=
0x7ffff5642498) at util/machine.c:2329
#2  0x00005555558370af in entry (arg=3D0x7ffff5642498, cb=3D0x5555557bdb5=
0 <unwind_entry>, thread=3D<optimized out>, ip=3D18446744073709551615) at=
 util/unwind-libunwind-local.c:586
#3  get_entries (ui=3Dui@entry=3D0x7fffffff9620, cb=3D0x5555557bdb50 <unw=
ind_entry>, arg=3D0x7ffff5642498, max_stack=3D<optimized out>) at util/un=
wind-libunwind-local.c:703
#4  0x0000555555837192 in _unwind__get_entries (cb=3D<optimized out>, arg=
=3D<optimized out>, thread=3D<optimized out>, data=3D<optimized out>, max=
_stack=3D<optimized out>) at util/unwind-libunwind-local.c:725
#5  0x00005555557c310f in thread__resolve_callchain_unwind (max_stack=3D1=
27, sample=3D0x7fffffff9830, evsel=3D0x555555c7b3b0, cursor=3D0x7ffff5642=
498, thread=3D0x555555c7f6f0) at util/machine.c:2351
#6  thread__resolve_callchain (thread=3D0x555555c7f6f0, cursor=3D0x7ffff5=
642498, evsel=3D0x555555c7b3b0, sample=3D0x7fffffff9830, parent=3D0x7ffff=
fff97b8, root_al=3D0x7fffffff9750, max_stack=3D127) at util/machine.c:237=
8
#7  0x00005555557ba4ee in sample__resolve_callchain (sample=3D<optimized =
out>, cursor=3D<optimized out>, parent=3Dparent@entry=3D0x7fffffff97b8, e=
vsel=3D<optimized out>, al=3Dal@entry=3D0x7fffffff9750,
    max_stack=3D<optimized out>) at util/callchain.c:1085

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c4acd2001db0..0cb4f8bf3ca7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2312,7 +2312,7 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 {
 	struct callchain_cursor *cursor =3D arg;
 	const char *srcline =3D NULL;
-	u64 addr;
+	u64 addr =3D entry->ip;
=20
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
@@ -2324,7 +2324,8 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	addr =3D map__map_ip(entry->map, entry->ip);
+	if (entry->map)
+		addr =3D map__map_ip(entry->map, entry->ip);
=20
 	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
--=20
2.19.0
