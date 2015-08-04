From: Milian Wolff <mail@milianw.de>
Subject: Re: [PATCH 001/001] perf: let trace write to stderr by default
Date: Tue, 04 Aug 2015 19:14:22 +0200
Message-ID: <3494762.Lck5LtIdUB@milian-kdab2>
References: <3305230.aOMPB1fPqd@milian-kdab2> <CA+JHD92yJxikRUQ57Hb+C4pZ12gcFAn6paWenbAY5FbwtgQFDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:54554 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbHDROY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Aug 2015 13:14:24 -0400
In-Reply-To: <CA+JHD92yJxikRUQ57Hb+C4pZ12gcFAn6paWenbAY5FbwtgQFDg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Tuesday 04 August 2015 13:50:14 Arnaldo Carvalho de Melo wrote:
> Le 4 ao=FBt 2015 1:46 PM, "Milian Wolff" <mail@milianw.de> a =E9crit =
:
> > See attached trivial patch which brings trace a bit closer to strac=
e.
> >=20
> > I've never published a patch to the Kernel yet, I hope it's OK as-i=
s. I
>=20
> can
>=20
> > amend it at will if you have any requests to the style
>=20
> Start by not using attachments :-)

:)

=46rom 188476d65bab17ad99f5bdf65294160ef2d5f49b Mon Sep 17 00:00:00 200=
1
=46rom: Milian Wolff <milian.wolff@kdab.com>
Date: Tue, 4 Aug 2015 18:30:52 +0200
Subject: [PATCH] perf: let trace write to stderr by default

Without this patch, it is cumbersome to read the trace output
but ignoring the normal, potentially verbose, output of the debuggee.
One common example is doing something like the following:

perf trace -s find /tmp > /dev/null

Without this patch, the trace summary will be lost. Now, it will
still be printed at the end. This behavior is also applied by strace.
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 39ad4d0..d183d88 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2778,7 +2778,7 @@ int cmd_trace(int argc, const char **argv, const =
char=20
*prefix __maybe_unused)
 			.mmap_pages    =3D UINT_MAX,
 			.proc_map_timeout  =3D 500,
 		},
-		.output =3D stdout,
+		.output =3D stderr,
 		.show_comm =3D true,
 		.trace_syscalls =3D true,
 	};
--=20
2.5.0

--=20
Milian Wolff
mail@milianw.de
http://milianw.de
