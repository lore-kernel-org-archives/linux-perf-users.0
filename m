From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core ] [BUGFIX] perf probe: Fix a segfault when
 removing uprobe events
Date: Fri, 18 Sep 2015 11:28:30 -0300
Message-ID: <20150918142830.GQ11551@kernel.org>
References: <20150916125241.4446.44805.stgit@localhost.localdomain>
 <50399556C9727B4D88A595C8584AAB3752541831@GSjpTKYDCembx32.service.hitachi.net>
 <20150918142622.GP11551@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52039 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbbIRO2e (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Sep 2015 10:28:34 -0400
Content-Disposition: inline
In-Reply-To: <20150918142622.GP11551@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Milian Wolff <milian.wolff@kdab.com>

Em Fri, Sep 18, 2015 at 11:26:22AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Fri, Sep 18, 2015 at 01:39:13AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=
=E5=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> > Hi Arnaldo,
> >=20
> > Could you pull this bugfix as an urgent patch, since this fixes a c=
ritical
> > problem?
>=20
> Sure, thanks for the reminder.

But it is not applying, checking:


[acme@zoo linux]$ patch -p1 < /wb/1.patch=20
patching file tools/perf/builtin-probe.c
Hunk #1 FAILED at 380.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/builtin-pro=
be.c.rej
[acme@zoo linux]$=20


- Arnaldo
