From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core ] [BUGFIX] perf probe: Fix a segfault when
 removing uprobe events
Date: Fri, 18 Sep 2015 11:31:43 -0300
Message-ID: <20150918143143.GR11551@kernel.org>
References: <20150916125241.4446.44805.stgit@localhost.localdomain>
 <50399556C9727B4D88A595C8584AAB3752541831@GSjpTKYDCembx32.service.hitachi.net>
 <20150918142622.GP11551@kernel.org>
 <20150918142830.GQ11551@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150918142830.GQ11551@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Sep 18, 2015 at 11:28:30AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Fri, Sep 18, 2015 at 11:26:22AM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > Em Fri, Sep 18, 2015 at 01:39:13AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=
=E5=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> > > Could you pull this bugfix as an urgent patch, since this fixes a=
 critical
> > > problem?

> > Sure, thanks for the reminder.
=20
> But it is not applying, checking:
=20
> [acme@zoo linux]$ patch -p1 < /wb/1.patch=20
> patching file tools/perf/builtin-probe.c
> Hunk #1 FAILED at 380.
> 1 out of 1 hunk FAILED -- saving rejects to file tools/perf/builtin-p=
robe.c.rej
> [acme@zoo linux]$=20

The way you reported made me somehow think this was for perf/urgent, bu=
t
the function it patches is not even there, ok, applying to perf/core.

Applied.

- Arnaldo
