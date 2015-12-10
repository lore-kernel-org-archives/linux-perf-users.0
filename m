From: 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Subject: Re: [PATCH perf/core  14/22] perf: Fix dso__load_sym to put dso
Date: Thu, 10 Dec 2015 16:26:19 -0300
Message-ID: <20151210192619.GK17996@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021118.10245.49869.stgit@localhost.localdomain>
 <20151209141601.GE15864@kernel.org>
 <50399556C9727B4D88A595C8584AAB375264F788@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46298 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbbLJT02 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 14:26:28 -0500
Content-Disposition: inline
In-Reply-To: <50399556C9727B4D88A595C8584AAB375264F788@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Thu, Dec 10, 2015 at 08:52:46AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=
=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> >
> >Em Wed, Dec 09, 2015 at 11:11:18AM +0900, Masami Hiramatsu escreveu:
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -1045,6 +1045,8 @@ int dso__load_sym(struct dso *dso, struct ma=
p *map,
> >>  				/* kmaps already got it */
> >>  				map__put(curr_map);
> >>  				dsos__add(&map->groups->machine->dsos, curr_dso);
> >> +				/* curr_map and machine->dsos already got it */
> >> +				dso__put(curr_dso);
> >>  				dso__set_loaded(curr_dso, map->type);
> >>  			} else
> >>  				curr_dso =3D curr_map->dso;
> >
> >Right, to make the code smaller, how about doing it this way, i.e. d=
rop
> >the reference once we have that curr_dso object with a ref held by
> >curr_map, if curr_map doesn't get it, then we don't need and will dr=
op
> >it anyway:
>=20
> But as above code, curr_dso is passed to dsos__add after curr_map is =
put.
> Even if the curr_map is hold by kmaps, isn't the kmaps controlled by =
other pthreads?
> If no, I'm OK if we move above dsos__add() before map__put() for safe=
ty, because
> curr_dso is held by curr_map at that point.

Good catch, so I'll do as you suggest and move dsos__add() to before we
drop that map reference, as then we're sure that we hold it and it hold=
s
the dso.
=20
> Thank you,
>=20
> >
> >diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-e=
lf.c
> >index 53f19968bfa2..84d787074152 100644
> >--- a/tools/perf/util/symbol-elf.c
> >+++ b/tools/perf/util/symbol-elf.c
> >@@ -1026,8 +1026,8 @@ int dso__load_sym(struct dso *dso, struct map =
*map,
> > 				curr_dso->long_name_len =3D dso->long_name_len;
> > 				curr_map =3D map__new2(start, curr_dso,
> > 						     map->type);
> >+				dso__put(curr_dso);
> > 				if (curr_map =3D=3D NULL) {
> >-					dso__put(curr_dso);
> > 					goto out_elf_end;
> > 				}
> > 				if (adjust_kernel_syms) {
