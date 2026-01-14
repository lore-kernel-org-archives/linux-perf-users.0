Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5E33D6E7
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417967; cv=pass; b=huOQNk5HIMJJDyxvsa1fPuH3NZL7ias/uicXBEscDA9UwLvVoNyAlBeTaaQ5kYKY43zOjNP9vZBdcTHu2X+KGKiQbBKnVhqWv+Nt0qYaVUHLj4ImxnoRo4RLYL2G03GN/nD9MC43Q88w4zzSsY4mR59iJ7O2yZFQ1iMQ9O6/0Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417967; c=relaxed/simple;
	bh=SsNkfZW7ATNXztX9wLmijt3sey7a3fW2slKgy229kLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy+AfLsdShb0iKqnammtAwr9LyD7VmFVT2lmKcEBfS2mgakSSs80BfTjtoHB5ATfeuaweYDz5V5LZiufHpP4basoVbALY93MFRuk3PWFpME0eLgcE3O4lJd7GP9SjqGBezElujHCPC45Veh0LFKiDCjC+19nCgyiNcirxwsZN9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqW9VRn4; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqW9VRn4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a35ae38bdfso8695ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 11:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768417964; cv=none;
        d=google.com; s=arc-20240605;
        b=d0lOMJ10zImJBUyTKZKiCjLTjsGXo4ooCKQNvjeAy0eAP7gtV9QwF801eIi4/P7ppn
         aNC31u3ha+Yxvr8jQnfigiptvW46rM09VOgcWpJTtdg+Q15RzRtmUb/P7c+91QbgUwnT
         wZhvbhsdau3bc3s1tCAt9hzy6vWNtPude/TZBpqiC2VXtcPwEEawms/SQf3I+Yr72hZU
         Zt2TVR3SCoY6CLOL59EQVYPQnRlushukNiO5CbvM+SFJbTaf9GmVX5PTYU7UG4MTd1Me
         5272WLQpoML7NiokqGGR3A3DMOuOCLRACH3+H6zbUlVLJQEZC/Zoi9Jn4U6wQFYxBfcm
         r+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQKqA0U6rRMDFhv+54aItcrxL5S52xy/CYSVVCmTCxI=;
        fh=J/OOSdy/Png30+SOdonavYKEz1x8vF/S3IJk1jiQ7Zw=;
        b=XoTnnLabUbuZTn55lt1vzlxBRFel6hc/Puywua7RO2fkTjogJoZ0JHiCn+87W+dwaE
         NCI0DBOGDnb9NvBZXNKN0+aq1heR+icX5xT0YWXfqOL3ydMDVZO4NsUMslwLKlRB2zl/
         67tb6tGIZn47ZLHc2/w/+RH0ELC53GgdwBk14iJheICjLSoujqbms0LZ+UjwQoSlFZho
         63oQ4pwjPPvm+3WqxbLQMRuSbgfPURXuTnOnPkffCcD7/DOknxgtkCH1kCnRQOiqnFHl
         pBLGBRkl24T3xvEn3g5p9amUCxGLLt/JgZsMRtB+FFzhi/N8srS6hCxfk3wMyViqClp6
         m6zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768417964; x=1769022764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQKqA0U6rRMDFhv+54aItcrxL5S52xy/CYSVVCmTCxI=;
        b=pqW9VRn4B+SyKf/arnP8lHxXqziAJLEEe/aBUwqxwC9dJtN6FauuSCoyXY435kW+MP
         E5W02jhJUmb9Zb0hPXgHQ2BQFv9+NWyPYYB4h60Bcq0uXR/f6VP6CW6Br2gQSL3rljCh
         Xvqa6jdB7lfgnMKCkaCfas/OFxsBNd9Qk5Wr+wfwrfHqX1C4ZANywDe8VxsfdMEF1iM4
         gHUpJVJe+skXYuCXvv9EkHRTxgHc4A95HKc3FXQcJAN2N7UlVzCaifAWs4Qcs/9ViXxw
         w7sK5VE0jj93WjXlX34s/QTyP//7GaSXYAVEJGjunBADyNpz15cvHu5MyoEIfULDFGjm
         g+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768417964; x=1769022764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQKqA0U6rRMDFhv+54aItcrxL5S52xy/CYSVVCmTCxI=;
        b=hnMJGno8fDOwh7UfKLREHpp43rpFavB6vPJAxojwzEbG68oY0av8QkDzFVe7Ad41Mb
         3/Mbdd7nLjqD9/u6MaRmIOROuuOwE1/raB3pxnw8b/LrivzVdRErOV6geHQmp2k5nJZQ
         6JmWkRkfj79JX/ICbRI/8zZkHkRWtQ7RjQUhhN4GguuqBoyFLZHrwxeT9yjJdWPzCXBU
         BFCaNWUFpIYhYYnsJPQHub2+zaE33zpMOhEfx+Fm3UIZ84K08QWOW3T/EBHiXhpKeAjA
         0gHyL3UCQjz6NqgvkbV2YqGC/qNXOQ4pvqxEtR2ovGzQzfhDMD37YFI7OL4hmTWK9J4s
         YLgg==
X-Forwarded-Encrypted: i=1; AJvYcCWBdgFYeDiJD1bSACQk7EX+FjXHUO6+NnSbtDTGwTpKmx6ZXLXOaSx+99sXF/iYNXJvgTaefVMLECr8tOF61pqy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Uu/YrTINCTXNLBvVNj9GmbdvQRtH6/KVHofhnhb5znQof84X
	tEC+rlVOeoW8TLYH3at8F6XQRIMp7M7YUGPgvdTzKUNsS+LAU58nx0H3/Zqj7SUvGDHWNEAtuOl
	JOjvUHSbL51v/b/EA17sxjZZj+jqTOo7drDbgpv3R
X-Gm-Gg: AY/fxX43B2t/ZjdYIhQzL8Db3F+zFA8ZQTT6I+PLUiKe9kPBtJTp7p3NuHJyAqSDkMY
	PNQ8XBF0aHQPXCkSRjiZZPcpSq5+2VMwigzcvZYyPGeGfAdGrtbLchXurYGqMTK1zcozEFZ5irL
	fdTfcQoS/sXRWGYFYBYFaUMHTfZMEwyVTURrj/kKeOUfc/nB7M/W7ZOWSuEOkn07heG8U/JT8Oh
	0tgm1wsABE1S5BeOD/qC4w4i/qHJ71hQ4ltCaOxv/SBjsA56swoUm3KyRq1WHWwOXU7UrQRR7JL
	PSQIRNli4WijG0og821+HVMxKQ==
X-Received: by 2002:a17:902:f611:b0:297:fe6f:a26e with SMTP id
 d9443c01a7336-2a70203e41dmr259575ad.14.1768417963189; Wed, 14 Jan 2026
 11:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113233757.62347-1-namhyung@kernel.org> <CAP-5=fX+zw-CUEYEtrPA6vYUKqpp4LZp-p==QsbZaNwLcX0Whw@mail.gmail.com>
In-Reply-To: <CAP-5=fX+zw-CUEYEtrPA6vYUKqpp4LZp-p==QsbZaNwLcX0Whw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Jan 2026 11:12:31 -0800
X-Gm-Features: AZwV_Qgk53aMWT_TydOPc59QhbUyDzgdrcuvCl620hk3Xh8dhkSFPpxUIN1QI8I
Message-ID: <CAP-5=fX=g1we4EezvCatfDFSZkKvs9QjnG_N3Vpi1oQoRx0L1w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Get debug info of DSO properly
To: Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 4:45=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Jan 13, 2026 at 3:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > The dso__debuginfo() just used the path name to open the file but it ma=
y
> > be outdated.  It should check build-ID and use the file in the build-ID
> > cache if available rather than just using the path name.
> >
> > Let's factor out dso__get_filename() to avoid code duplicate.
>
> This change lgtm:
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> I should have recognized this earlier, we seem to be getting multiple
> copies of the dwfl and I wonder repeatedly parsing the debug info has
> costs:
> 1) for arch powerpc there is a dwfl used in
> tools/perf/arch/powerpc/util/skip-callchain-idx.c
> 2) there is a dwfl for the libdw addr2line
> 3) there is a dwfl in debuginfo
> 4) there is a dwfl in unwind_info in unwind-libdw
>
> So 1 and 2 both associate the dwfl with the dso and lazily add it, 1
> leaks the dwfl whereas 2 ties it to the lifetime of the dso.
> For 3 there are individual debuginfo uses as well as a debuginfo cache
> in probe-event.
> For 4 the lifetime is an unwind of a stacktrace by unwind__get_entries.
>
> 1 and 4 load an ELF with a path using dwfl_report_elf  and specifying
> a base load address.
> 2 and 3 use dwfl_report_offline with no load address.
>
> My understanding is that if you have the Dwfl the Dwfl_module and
> Dwarf are cheap to compute. The module is cached in the Dwfl and with
> a single Dwfl/Dwfl_module per dso then there should only ever be 1
> value:
> https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwflP.h#L131
> And the Dwarf is held in the module:
> https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwflP.h#L195
> This makes me think the debuginfo may be holding onto more values than
> it needs to and perhaps we can simplify it.
>
> I think ideally we'd have a single Dwfl but that means the
> Dwfl_modules will need different addresses to avoid overlapping. It
> doesn't seem to be possible to relocate a module once it is loaded
> (e.g with dwfl_module_relocate_address -
> https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwfl.h#L397)
> and so we'd need some way to come up with an address to keep the
> modules separate (we couldn't just use the virtual address for a
> thread as the module address may differ per thread in different
> processes).
>
> So I wonder if we should have a single global Dwfl, and have each dso
> have a made up load address to get the Dwfl_Module from it - the dso
> could hold the Dwfl_Module* or the made up load address. 1 and 4 can
> use their current base load address and adjust it by the made up load
> address that would be associated with the dso. 2 and 3 can just use
> the made up load address with the dso to get the module and possibly
> with (2) remove some of the bias logic. This should speed up a bunch
> of things by avoiding unnecessary/repeated dwfl_report_elf and
> dwfl_report_offline calls, it would also cut down on duplication.

So perhaps a less aggressive clean up would be to have a Dwfl per dso
and the base address be 0, as with the addr2line code. The debuginfo
and unwind info cases would need migrating to use the dso, they'd also
need to map their IPs from the virtual address to the DSO offset
version. The powerpc code could also be migrated to this with an
updated base address. The scope of the debuginfo and unwind info
change seems unfortunately large, but on the upside this would do a
single dwfl_report_offline per dso rather than per unwind - there may
be similar debuginfo savings, but I'm not immediately sure where.

Thanks,
Ian

> Thanks,
> Ian
>
> > Fixes: 53a61a6ca279165d ("perf annotate: Add dso__debuginfo() helper")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/dso.c | 63 ++++++++++++++++++++++++++++++++-----------
> >  tools/perf/util/dso.h | 11 ++------
> >  2 files changed, 50 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 06980844c014ec9b..922fcc2f798baa57 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -112,7 +112,7 @@ bool dso__is_object_file(const struct dso *dso)
> >
> >  int dso__read_binary_type_filename(const struct dso *dso,
> >                                    enum dso_binary_type type,
> > -                                  char *root_dir, char *filename, size=
_t size)
> > +                                  const char *root_dir, char *filename=
, size_t size)
> >  {
> >         char build_id_hex[SBUILD_ID_SIZE];
> >         int ret =3D 0;
> > @@ -564,20 +564,15 @@ char *dso__filename_with_chroot(const struct dso =
*dso, const char *filename)
> >         return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso))=
, filename);
> >  }
> >
> > -static int __open_dso(struct dso *dso, struct machine *machine)
> > -       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > +static char *dso__get_filename(struct dso *dso, const char *root_dir,
> > +                              bool *decomp)
> >  {
> > -       int fd =3D -EINVAL;
> > -       char *root_dir =3D (char *)"";
> >         char *name =3D malloc(PATH_MAX);
> > -       bool decomp =3D false;
> >
> > -       if (!name)
> > -               return -ENOMEM;
> > +       *decomp =3D false;
> >
> > -       mutex_lock(dso__lock(dso));
> > -       if (machine)
> > -               root_dir =3D machine->root_dir;
> > +       if (name =3D=3D NULL)
> > +               return NULL;
> >
> >         if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
> >                                             root_dir, name, PATH_MAX))
> > @@ -602,20 +597,38 @@ static int __open_dso(struct dso *dso, struct mac=
hine *machine)
> >                 size_t len =3D sizeof(newpath);
> >
> >                 if (dso__decompress_kmodule_path(dso, name, newpath, le=
n) < 0) {
> > -                       fd =3D -(*dso__load_errno(dso));
> > +                       errno =3D *dso__load_errno(dso);
> >                         goto out;
> >                 }
> >
> > -               decomp =3D true;
> > +               *decomp =3D true;
> >                 strcpy(name, newpath);
> >         }
> > +       return name;
> > +
> > +out:
> > +       free(name);
> > +       return NULL;
> > +}
> >
> > -       fd =3D do_open(name);
> > +static int __open_dso(struct dso *dso, struct machine *machine)
> > +       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > +{
> > +       int fd =3D -EINVAL;
> > +       char *name;
> > +       bool decomp =3D false;
> > +
> > +       mutex_lock(dso__lock(dso));
> > +
> > +       name =3D dso__get_filename(dso, machine ? machine->root_dir : "=
", &decomp);
> > +       if (name)
> > +               fd =3D do_open(name);
> > +       else
> > +               fd =3D -errno;
> >
> >         if (decomp)
> >                 unlink(name);
> >
> > -out:
> >         mutex_unlock(dso__lock(dso));
> >         free(name);
> >         return fd;
> > @@ -1912,3 +1925,23 @@ const u8 *dso__read_symbol(struct dso *dso, cons=
t char *symfs_filename,
> >         return __dso__read_symbol(dso, symfs_filename, start, len,
> >                                   out_buf, out_buf_len, is_64bit);
> >  }
> > +
> > +struct debuginfo *dso__debuginfo(struct dso *dso)
> > +{
> > +       char *name;
> > +       bool decomp =3D false;
> > +       struct debuginfo *dinfo =3D NULL;
> > +
> > +       mutex_lock(dso__lock(dso));
> > +
> > +       name =3D dso__get_filename(dso, "", &decomp);
> > +       if (name)
> > +               dinfo =3D debuginfo__new(name);
> > +
> > +       if (decomp)
> > +               unlink(name);
> > +
> > +       mutex_unlock(dso__lock(dso));
> > +       free(name);
> > +       return dinfo;
> > +}
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 4aee23775054cf83..3dd7d0fc00797f37 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -777,7 +777,7 @@ int dso__kernel_module_get_build_id(struct dso *dso=
, const char *root_dir);
> >
> >  char dso__symtab_origin(const struct dso *dso);
> >  int dso__read_binary_type_filename(const struct dso *dso, enum dso_bin=
ary_type type,
> > -                                  char *root_dir, char *filename, size=
_t size);
> > +                                  const char *root_dir, char *filename=
, size_t size);
> >  bool is_kernel_module(const char *pathname, int cpumode);
> >  bool dso__needs_decompress(struct dso *dso);
> >  int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
> > @@ -926,14 +926,7 @@ u64 dso__findnew_global_type(struct dso *dso, u64 =
addr, u64 offset);
> >  bool perf_pid_map_tid(const char *dso_name, int *tid);
> >  bool is_perf_pid_map_name(const char *dso_name);
> >
> > -/*
> > - * In the future, we may get debuginfo using build-ID (w/o path).
> > - * Add this helper is for the smooth conversion.
> > - */
> > -static inline struct debuginfo *dso__debuginfo(struct dso *dso)
> > -{
> > -       return debuginfo__new(dso__long_name(dso));
> > -}
> > +struct debuginfo *dso__debuginfo(struct dso *dso);
> >
> >  const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename=
,
> >                            const struct map *map, const struct symbol *=
sym,
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
