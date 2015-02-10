From: Vinson Lee <vlee@twopensource.com>
Subject: [PATCH] perf symbols: Define STT_GNU_IFUNC for glibc 2.9 and older.
Date: Mon,  9 Feb 2015 16:29:37 -0800
Message-ID: <1423528286-13630-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38649 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbbBJAcL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Feb 2015 19:32:11 -0500
Received: by pdbft15 with SMTP id ft15so34913335pdb.5
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2015 16:32:11 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Waiman Long <Waiman.Long@hp.com>, Stephane Eranian <eranian@google.com>, Anton Blanchard <anton@samba.org>, Avi Kivity <avi@cloudius-systems.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>

=46rom: Vinson Lee <vlee@twitter.com>

The token STT_GNU_IFUNC is not available with glibc 2.9 and older.
Define this token if it is not already defined.

This patch fixes this build errors with older versions of glibc.

  CC       util/symbol-elf.o
util/symbol-elf.c: In function =E2=80=98elf_sym__is_function=E2=80=99:
util/symbol-elf.c:75: error: =E2=80=98STT_GNU_IFUNC=E2=80=99 undeclared=
 (first use in this function)
util/symbol-elf.c:75: error: (Each undeclared identifier is reported on=
ly once
util/symbol-elf.c:75: error: for each function it appears in.)
make: *** [util/symbol-elf.o] Error 1

Cc: stable@vger.kernel.org # 3.17+
Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 tools/perf/util/symbol-elf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
index 06fcd1b..eafee11 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -69,6 +69,10 @@ static inline uint8_t elf_sym__type(const GElf_Sym *=
sym)
 	return GELF_ST_TYPE(sym->st_info);
 }
=20
+#ifndef STT_GNU_IFUNC
+#define STT_GNU_IFUNC 10
+#endif
+
 static inline int elf_sym__is_function(const GElf_Sym *sym)
 {
 	return (elf_sym__type(sym) =3D=3D STT_FUNC ||
--=20
1.8.2.1
