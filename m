From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Date: Wed, 26 Sep 2018 15:52:07 +0200
Message-ID: <20180926135207.30263-3-milian.wolff@kdab.com>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926135207.30263-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

When the function name for an inline frame is invalid, we must
not try to demangle this symbol, otherwise we crash with:

#0  0x0000555555895c01 in bfd_demangle ()
#1  0x0000555555823262 in demangle_sym (dso=3D0x555555d92b90, elf_name=3D=
0x0, kmodule=3D0) at util/symbol-elf.c:215
#2  dso__demangle_sym (dso=3Ddso@entry=3D0x555555d92b90, kmodule=3D<optim=
ized out>, kmodule@entry=3D0, elf_name=3Delf_name@entry=3D0x0) at util/sy=
mbol-elf.c:400
#3  0x00005555557fef4b in new_inline_sym (funcname=3D0x0, base_sym=3D0x55=
5555d92b90, dso=3D0x555555d92b90) at util/srcline.c:89
#4  inline_list__append_dso_a2l (dso=3Ddso@entry=3D0x555555c7bb00, node=3D=
node@entry=3D0x555555e31810, sym=3Dsym@entry=3D0x555555d92b90) at util/sr=
cline.c:264
#5  0x00005555557ff27f in addr2line (dso_name=3Ddso_name@entry=3D0x555555=
d92430 "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d=
24fce5/elf", addr=3Daddr@entry=3D2888, file=3Dfile@entry=3D0x0,
    line=3Dline@entry=3D0x0, dso=3Ddso@entry=3D0x555555c7bb00, unwind_inl=
ines=3Dunwind_inlines@entry=3Dtrue, node=3D0x555555e31810, sym=3D0x555555=
d92b90) at util/srcline.c:313
#6  0x00005555557ffe7c in addr2inlines (sym=3D0x555555d92b90, dso=3D0x555=
555c7bb00, addr=3D2888, dso_name=3D0x555555d92430 "/home/milian/.debug/.b=
uild-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf")
    at util/srcline.c:358

So instead handle the case where we get invalid function names
for inlined frames and use a fallback '??' function name instead.

While this crash was originally reported by Hadrien for rust code,
I can now also reproduce it with trivial C++ code. Indeed, it seems
like libbfd fails to interpret the debug information for the inline
frame symbol name:

$ addr2line -e /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926d=
a66033d24fce5/elf -if b48
main
/usr/include/c++/8.2.1/complex:610
??
/usr/include/c++/8.2.1/complex:618
??
/usr/include/c++/8.2.1/complex:675
??
/usr/include/c++/8.2.1/complex:685
main
/home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/ma=
in.cpp:39

I've reported this bug upstream and also attached a patch there
which should fix this issue:
https://sourceware.org/bugzilla/show_bug.cgi?id=3D23715

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Hadrien Grasland <grasland@lal.in2p3.fr>
---
 tools/perf/util/srcline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 09d6746e6ec8..e767c4a9d4d2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -85,6 +85,9 @@ static struct symbol *new_inline_sym(struct dso *dso,
 	struct symbol *inline_sym;
 	char *demangled =3D NULL;
=20
+	if (!funcname)
+		funcname =3D "??";
+
 	if (dso) {
 		demangled =3D dso__demangle_sym(dso, 0, funcname);
 		if (demangled)
--=20
2.19.0
