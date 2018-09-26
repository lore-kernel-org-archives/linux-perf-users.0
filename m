From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 2/3] perf report: use the offset address to find inline frames
Date: Wed, 26 Sep 2018 15:52:06 +0200
Message-ID: <20180926135207.30263-2-milian.wolff@kdab.com>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926135207.30263-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Sandipan Das <sandipan@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

To correctly find inlined frames, we have to use the file offset
instead of the virtual memory address. This was already fixed for
displaying srcline information while displaying in commit
2a9d5050dc84fa20 ("perf script: Show correct offsets for DWARF-based
unwinding"). We just need to use the same corrected address also when
trying to find inline frames.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cb4f8bf3ca7..73a651f10a0f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2317,9 +2317,6 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
=20
-	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) =3D=3D 0)
-		return 0;
-
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2327,6 +2324,9 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (entry->map)
 		addr =3D map__map_ip(entry->map, entry->ip);
=20
+	if (append_inlines(cursor, entry->map, entry->sym, addr) =3D=3D 0)
+		return 0;
+
 	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
--=20
2.19.0
