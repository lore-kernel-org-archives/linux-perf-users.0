From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core ] [BUGFIX] perf probe: Fix a segfault when
 removing uprobe events
Date: Fri, 18 Sep 2015 11:26:22 -0300
Message-ID: <20150918142622.GP11551@kernel.org>
References: <20150916125241.4446.44805.stgit@localhost.localdomain>
 <50399556C9727B4D88A595C8584AAB3752541831@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51891 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbbIRO01 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Sep 2015 10:26:27 -0400
Content-Disposition: inline
In-Reply-To: <50399556C9727B4D88A595C8584AAB3752541831@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Milian Wolff <milian.wolff@kdab.com>

Em Fri, Sep 18, 2015 at 01:39:13AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=
=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> Hi Arnaldo,
>=20
> Could you pull this bugfix as an urgent patch, since this fixes a cri=
tical
> problem?

Sure, thanks for the reminder.

- Arnaldo
=20
> Thanks,
>=20
> From: Masami Hiramatsu [mailto:masami.hiramatsu.pt@hitachi.com]
> >
> >Fix a segfault bug and a small mistake in perf probe -d.
> >
> >Since the "ulist" in perf_del_probe_events is never initialized,
> >strlist__add(ulist, *) always causes a segfault when removing
> >uprobe events by perf probe -d.
> >
> >Also, the "str" local variable is never released if fail to
> >allocate the "klist". This fixes it too.
> >
> >This has been introduced by the commit e607f1426b58 ("perf probe:
> >Print deleted events in cmd_probe()").
> >
> >Reported-by: Milian Wolff <milian.wolff@kdab.com>
> >Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> >---
> > tools/perf/builtin-probe.c |    7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >
> >diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> >index 94385ee..f7882ae 100644
> >--- a/tools/perf/builtin-probe.c
> >+++ b/tools/perf/builtin-probe.c
> >@@ -380,8 +380,11 @@ static int perf_del_probe_events(struct strfilt=
er *filter)
> > 		goto out;
> >
> > 	klist =3D strlist__new(NULL, NULL);
> >-	if (!klist)
> >-		return -ENOMEM;
> >+	ulist =3D strlist__new(NULL, NULL);
> >+	if (!klist || !ulist) {
> >+		ret =3D -ENOMEM;
> >+		goto out;
> >+	}
> >
> > 	ret =3D probe_file__get_events(kfd, filter, klist);
> > 	if (ret =3D=3D 0) {
> >
>=20
