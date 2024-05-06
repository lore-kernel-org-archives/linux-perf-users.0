Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5513DDC1
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009176; cv=none; b=mgADsTN6DFnrGqIcMfiXHUjWI9NE8oUTDGpLWEqKQHJeb9kCDhQJl/isS63pr9JYcN+OlyEn3RbH+t5j+x9V+W0YfMbiG+mUs+YaUQzxpLx+0eqcwwagFzOZaia/XF6P1xute1ZdbPuCp0Nx0VHofpLMfw3gyD5NIpJmHioyQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009176; c=relaxed/simple;
	bh=IYfsImZ4AFHnBekixgmBwUha+kYXhGoKXLnaG9QqyhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8dm96xLK72pPv78+41H7NxNn1pk276s1PXQt1eW6ngEEce3uWCbusyXlKC6PYaE4ZayGPcgitrE1Gh7jFp6VvzzePsvc7fc1dCPWFSfdU1E2zedI0NWug5N+2f1/LVwxfn9jZNVNBUMaAmL06qcuzLhJOp0eTieT7x/5eDcnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHD10UMJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHD10UMJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec76185cb3so280095ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715009174; x=1715613974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty7OpvklFHEWkrJGhuaaPi+UlmcofEYkSWUTSEvzR9c=;
        b=UHD10UMJ9GAKGiMRCfDmtWAWSq84Beax93gtu/Gxzwg0L4TXSvTgsNgcKbhqWBlmgr
         HQj4Nf8914fcnV0QQiV6wYSwgRCvJV5JxGznX6NUwZ7tTqzm96ypwsF2APc9YbxeE4ip
         bq+6nYoDmtT3FWfBMF4u4yJnGiDOSKDImwgX1x12QJFiNdi6St/NrBy11SwwHRt1giDC
         L7D1CCDB3XEkSD42Z0gHnxgj67PkwQ3whLyRDVW7ni2IxGw+gIzbnXRr+m7M9mtfYMGQ
         vI9RvQAdFowMdTAxn9dzS76urRpprqBJ4JoeGzVzEnynuQZwCJOo/99pLIohOkLStFTQ
         vUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715009174; x=1715613974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty7OpvklFHEWkrJGhuaaPi+UlmcofEYkSWUTSEvzR9c=;
        b=vK55/jZg6ngHWFmSbX5esMG4AmjyvJAKlTKYCS3JJnrQVN2/OLLb6RspaZuVf3dhSZ
         XThxybGrhFt9aC1JEngcwI7YQhGE2tCQHu5h/w403N91Ryp8yNkSuB6yaHjTZWvQgWcr
         YL3uak/lP+tjrHKc+vi+Rrmeh32D7PGhAskdKh8k50vwaBsnRpbFO1PKE7vZ2kAL5FkH
         RKeT6tV+3yNGwIYlDeV1ceujDBkzfO15HCcOEOvWyr6w77nzibYalJtmj5wnFZ88oJX6
         cLHvbTxaHBUTpoqX1Y73kgcc8QSigucMMDH/snuQN4lpK2H6j5y8OF6JbJpXBncvAtl1
         OXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/jvruIgRBuPyS5XddjMo0DsxFPA8omaobfcRJ3H7OKkZqja5WH8zzJ6wD1yZ0d6Rib8r3L8WFxUQmwkjpPf7VJWcGoV/Rs9/wlP40ApOM4g==
X-Gm-Message-State: AOJu0YyIm6uOyG+clWfHu5IhQn/uhXWKw/b60/EuhrkaRJk3jyyav7r4
	mVIXryxGtrT3t+gKYdVlvUCEzBlyJteZew9tkoFUWs9UsaNRU73sDagH0E4AHhgYReO1Wa3F7go
	WpI2SDN612wtqAPnBF8BhmS9HJey2duO0/0R+
X-Google-Smtp-Source: AGHT+IEUbCzgWcHuyFYm4y0AbtMMqdlGbgMjPK+3WhvrhtXEm/ub8Zd/XIiwUX2gP+4YzeJqU+lNUWbJyW/LZ43BzH8=
X-Received: by 2002:a17:902:f64a:b0:1e5:1138:e29d with SMTP id
 d9443c01a7336-1ed85d79154mr3394205ad.29.1715009173441; Mon, 06 May 2024
 08:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504213803.218974-1-irogers@google.com> <20240504213803.218974-7-irogers@google.com>
 <Zjjsvah8TU_Yubdn@x1>
In-Reply-To: <Zjjsvah8TU_Yubdn@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 May 2024 08:26:02 -0700
Message-ID: <CAP-5=fVi-qDAP1D+ZOgLD19Cp0K1yn13cgq65g3MuOFNoefc3Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] perf dso: Reference counting related fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, nabijaczleweli@nabijaczleweli.xyz, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 7:44=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sat, May 04, 2024 at 02:38:02PM -0700, Ian Rogers wrote:
> > Ensure gets and puts are better aligned fixing reference couting
> > checking problems.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/machine.c    |  4 +--
> >  tools/perf/util/map.c        |  1 +
> >  tools/perf/util/symbol-elf.c | 51 ++++++++++++++++++------------------
> >  3 files changed, 28 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 0b8fb14f5ff6..4a4541a2e887 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -683,7 +683,7 @@ static int machine__process_ksymbol_register(struct=
 machine *machine,
> >                                            struct perf_sample *sample _=
_maybe_unused)
> >  {
> >       struct symbol *sym;
> > -     struct dso *dso;
> > +     struct dso *dso =3D NULL;
> >       struct map *map =3D maps__find(machine__kernel_maps(machine), eve=
nt->ksymbol.addr);
> >       int err =3D 0;
> >
> > @@ -696,7 +696,6 @@ static int machine__process_ksymbol_register(struct=
 machine *machine,
> >               }
> >               dso__set_kernel(dso, DSO_SPACE__KERNEL);
> >               map =3D map__new2(0, dso);
> > -             dso__put(dso);
> >               if (!map) {
> >                       err =3D -ENOMEM;
> >                       goto out;
> > @@ -735,6 +734,7 @@ static int machine__process_ksymbol_register(struct=
 machine *machine,
> >       dso__insert_symbol(dso, sym);
> >  out:
> >       map__put(map);
> > +     dso__put(dso);
> >       return err;
> >  }
>
> This seems to match the patch description, good, just aligning the puts
>
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 117c4bb78b35..e1d14936a60d 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 s=
tart, u64 len,
> >                               dso__set_build_id(dso, dso__bid(header_bi=
d_dso));
> >                               dso__set_header_build_id(dso, 1);
> >                       }
> > +                     dso__put(header_bid_dso);
> >               }
> >               dso__put(dso);
> >       }
>
> But this is a missing one, so not aligning, but fixing a separate issue,
> i.e. a missing put? Should go on a different patch, probably with a
> Fixes.

The Fixes would be for a patch in the series - albeit that we've spent
over half a year landing this and a month since that change landed:
https://lore.kernel.org/all/20240410064214.2755936-3-irogers@google.com/
The issue is that previously a find wouldn't do a get, so per the old
code no put is necessary. Gets were added to finds to cover the race
between a dso being returned from dsos and the item potentially being
removed from dsos.

> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index 3be5e8d1e278..e398abfd13a0 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1419,7 +1419,7 @@ void __weak arch__sym_update(struct symbol *s __m=
aybe_unused,
> >  static int dso__process_kernel_symbol(struct dso *dso, struct map *map=
,
> >                                     GElf_Sym *sym, GElf_Shdr *shdr,
> >                                     struct maps *kmaps, struct kmap *km=
ap,
> > -                                   struct dso **curr_dsop, struct map =
**curr_mapp,
> > +                                   struct dso **curr_dsop,
>
> This one removes an argument, so look like a separate patch as well,
> needs a description of why removing the argument is the right thing to
> do here.
>
> >                                     const char *section_name,
> >                                     bool adjust_kernel_syms, bool kmodu=
le, bool *remap_kernel,
> >                                     u64 max_text_sh_offset)
> > @@ -1470,8 +1470,8 @@ static int dso__process_kernel_symbol(struct dso =
*dso, struct map *map,
> >                       map__set_pgoff(map, shdr->sh_offset);
> >               }
> >
> > -             *curr_mapp =3D map;
> > -             *curr_dsop =3D dso;
> > +             dso__put(*curr_dsop);
> > +             *curr_dsop =3D dso__get(dso);
> >               return 0;
> >       }
> >
> > @@ -1484,8 +1484,8 @@ static int dso__process_kernel_symbol(struct dso =
*dso, struct map *map,
> >        */
> >       if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) =
&&
> >           shdr->sh_offset <=3D max_text_sh_offset) {
> > -             *curr_mapp =3D map;
> > -             *curr_dsop =3D dso;
> > +             dso__put(*curr_dsop);
> > +             *curr_dsop =3D dso__get(dso);
> >               return 0;
> >       }
> >
> > @@ -1507,10 +1507,10 @@ static int dso__process_kernel_symbol(struct ds=
o *dso, struct map *map,
> >               dso__set_binary_type(curr_dso, dso__binary_type(dso));
> >               dso__set_adjust_symbols(curr_dso, dso__adjust_symbols(dso=
));
> >               curr_map =3D map__new2(start, curr_dso);
> > -             dso__put(curr_dso);
> > -             if (curr_map =3D=3D NULL)
> > +             if (curr_map =3D=3D NULL) {
> > +                     dso__put(curr_dso);
> >                       return -1;
> > -
> > +             }
> >               if (dso__kernel(curr_dso))
> >                       map__kmap(curr_map)->kmaps =3D kmaps;
> >
> > @@ -1524,21 +1524,15 @@ static int dso__process_kernel_symbol(struct ds=
o *dso, struct map *map,
> >               dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
> >               if (maps__insert(kmaps, curr_map))
> >                       return -1;
> > -             /*
> > -              * Add it before we drop the reference to curr_map, i.e. =
while
> > -              * we still are sure to have a reference to this DSO via
> > -              * *curr_map->dso.
> > -              */
> >               dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
> > -             /* kmaps already got it */
> > -             map__put(curr_map);
> >               dso__set_loaded(curr_dso);
> > -             *curr_mapp =3D curr_map;
> > +             dso__put(*curr_dsop);
> >               *curr_dsop =3D curr_dso;
> >       } else {
> > -             *curr_dsop =3D map__dso(curr_map);
> > -             map__put(curr_map);
> > +             dso__put(*curr_dsop);
> > +             *curr_dsop =3D dso__get(map__dso(curr_map));
> >       }
> > +     map__put(curr_map);
> >
> >       return 0;
> >  }
> > @@ -1549,11 +1543,9 @@ dso__load_sym_internal(struct dso *dso, struct m=
ap *map, struct symsrc *syms_ss,
> >  {
> >       struct kmap *kmap =3D dso__kernel(dso) ? map__kmap(map) : NULL;
> >       struct maps *kmaps =3D kmap ? map__kmaps(map) : NULL;
> > -     struct map *curr_map =3D map;
> > -     struct dso *curr_dso =3D dso;
> > +     struct dso *curr_dso =3D NULL;
> >       Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
> >       uint32_t nr_syms;
> > -     int err =3D -1;
> >       uint32_t idx;
> >       GElf_Ehdr ehdr;
> >       GElf_Shdr shdr;
> > @@ -1656,6 +1648,7 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
> >       if (kmodule && adjust_kernel_syms)
> >               max_text_sh_offset =3D max_text_section(runtime_ss->elf, =
&runtime_ss->ehdr);
> >
> > +     curr_dso =3D dso__get(dso);
> >       elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
> >               struct symbol *f;
> >               const char *elf_name =3D elf_sym__name(&sym, symstrs);
> > @@ -1744,9 +1737,13 @@ dso__load_sym_internal(struct dso *dso, struct m=
ap *map, struct symsrc *syms_ss,
> >                       --sym.st_value;
> >
> >               if (dso__kernel(dso)) {
> > -                     if (dso__process_kernel_symbol(dso, map, &sym, &s=
hdr, kmaps, kmap, &curr_dso, &curr_map,
> > -                                                    section_name, adju=
st_kernel_syms, kmodule,
> > -                                                    &remap_kernel, max=
_text_sh_offset))
> > +                     if (dso__process_kernel_symbol(dso, map, &sym, &s=
hdr,
> > +                                                    kmaps, kmap, &curr=
_dso,
> > +                                                    section_name,
> > +                                                    adjust_kernel_syms=
,
> > +                                                    kmodule,
> > +                                                    &remap_kernel,
> > +                                                    max_text_sh_offset=
))
>
> Can you please avoid reflowing to reduce the cost of reviewing? If this
> was just:
>
> -                       if (dso__process_kernel_symbol(dso, map, &sym, &s=
hdr, kmaps, kmap, &curr_dso, &curr_map,
>                                                        section_name, adju=
st_kernel_syms, kmodule,
>                                                        &remap_kernel, max=
_text_sh_offset))
> +                       if (dso__process_kernel_symbol(dso, map, &sym, &s=
hdr, kmaps, kmap, &curr_dso,
>                                                        section_name, adju=
st_kernel_syms, kmodule,
>                                                        &remap_kernel, max=
_text_sh_offset))
>
> The actual change would be quickly spotted as just the line where it
> takes place gets changed.
>
> I applied all the patches in this series but this one, please split it
> as described.

*sigh* 28 line change...

Ian

> The tests I run after each patch before this one passed, thanks for
> addressing the issues I reported,
>
> I'm pushing what I have to tmp.perf-tools-next,
>
> - Arnaldo
>
> >                               goto out_elf_end;
> >               } else if ((used_opd && runtime_ss->adjust_symbols) ||
> >                          (!used_opd && syms_ss->adjust_symbols)) {
> > @@ -1795,6 +1792,7 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
> >               __symbols__insert(dso__symbols(curr_dso), f, dso__kernel(=
dso));
> >               nr++;
> >       }
> > +     dso__put(curr_dso);
> >
> >       /*
> >        * For misannotated, zeroed, ASM function sizes.
> > @@ -1810,9 +1808,10 @@ dso__load_sym_internal(struct dso *dso, struct m=
ap *map, struct symsrc *syms_ss,
> >                       maps__fixup_end(kmaps);
> >               }
> >       }
> > -     err =3D nr;
> > +     return nr;
> >  out_elf_end:
> > -     return err;
> > +     dso__put(curr_dso);
> > +     return -1;
> >  }
> >
> >  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *sym=
s_ss,
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
