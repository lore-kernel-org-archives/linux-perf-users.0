From: James Clark <James.Clark@arm.com>
Subject: [PATCH] Fixes issue when debugging debug builds of Perf.
Date: Mon, 28 Oct 2019 11:34:01 +0000
Message-ID: <20191028113340.4282-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: nd <nd@arm.com>, "acme@redhat.com" <acme@redhat.com>, "irogers@google.com" <irogers@google.com>, James Clark <James.Clark@arm.com>
List-Id: linux-perf-users.vger.kernel.org

When a 'make DEBUG=3D1' build is done, the command parser
is still built with -O6 and is hard to step through.

This change also moves EXTRA_WARNINGS and EXTRA_FLAGS to
the end of the compilation line, otherwise they cannot be
used to override the default values.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/lib/subcmd/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS +=3D --no-print-directory
=20
 LIBFILE =3D $(OUTPUT)libsubcmd.a
=20
-CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
+CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
=20
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -28,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
=20
-ifeq ($(CC_NO_CLANG), 0)
+ifeq ($(DEBUG),1)
+  CFLAGS +=3D -O0
+else ifeq ($(CC_NO_CLANG), 0)
   CFLAGS +=3D -O3
 else
   CFLAGS +=3D -O6
@@ -43,6 +44,8 @@ CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D6=
4 -D_GNU_SOURCE
=20
 CFLAGS +=3D -I$(srctree)/tools/include/
=20
+CFLAGS +=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+
 SUBCMD_IN :=3D $(OUTPUT)libsubcmd-in.o
=20
 all:
--=20
2.23.0
