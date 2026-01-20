Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B423D28C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941393; cv=pass; b=imOibJatjECC9NHpOkefUTRTxPJ7SxFfLagUMzWB9oZSOghknt6LuGZcMapgUU3gIIiGU4S+Nt/x7wy49zcKGceFpV5gEoXWhfpqJwWF9i4ytEBkvxkW1CtMaXrR8BeOKPRXly447WMqO9MgSiHWwPKQwVhoitFuxU8TnjUKaZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941393; c=relaxed/simple;
	bh=u/aCPFbboI2ISPKq4c2S2FwuzjmatdH2ObWteUp70as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCLR0SUzRARsCkVyWAaEkP1zYF2pijW4mfmei/v50LMmXsf8NFHOvHnmGNG3v1EXLHyQUuBtew1bbK06VcUCTpT79axmEkFyLs93Wp4j0l3gaz1Ce9W1YHzGyUz3YEJDqTaasxbhtncaUB/qoszGThfebFhseLaN8H4XDe0ykmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcIXNwoC; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcIXNwoC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d06cfa93so3315ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 12:36:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768941390; cv=none;
        d=google.com; s=arc-20240605;
        b=hM/c/Y2ttLe+5W7Qlx5pf2DIY6dhqQtbYaqSreOx9hLl3Tx4CAPDqIiuJ32uXOtfh/
         Vo9QxAYAEnAA2J4FwCkavFyw7fkxd+4eTP5B48IuAxQvnRg2fC/5AnjCtZu8bFef6Gro
         35ec4xF7BCI5K45S+eIKnzEJFFEF2WSHdfqil4yW19LPIrpfpgpl/0j1q1sAF3nBo5Fb
         FgBVK3h+CA7zxLdj8JxGzgS38UStK6MumytRG1lynQ8R9uvJ9CwrdUNg0itZa0n8ns4m
         1h1S9DplT1KQdetAS6A3EZmT5bRYkoXR+Nvqj67xmt2PVnPxP61DjRjGzemmAuLnOK/e
         HJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EisCJXmr7YBMl5gYvvlr0246N5yEjB6WcdsmZJDqygg=;
        fh=6tEI0iX9pnYJexwimhoJCaxNlF5X66M9Rlt5xwqdhG0=;
        b=W8XBUgFODib9Vnh2YIOAERg1HxYJaJFSZXRWCWAM/MO8G6f5WCQlp14Q9zcPh0QGME
         jV1joqep9QhCzZ/op5+M2Qwx+am/SVglP45UcdEVprJtju1Cii58vVy4hui0QJhrVkaz
         KkXLdP208R5flYRHoO9ivlpnp3T+HogYZX/Hfk760NVGmFjPFxUfF5yZ/vp0Rw4nL3gv
         H3zoreFelF91IFh6jAIFjb+2yA+YngT669lqA6BA7kYw5bXdKuiHi/laU6bccO9cx/mm
         9ao0Krubs0//9lZUvP2FlxpJcOdeqqse94GlKPBvtoX5ZSnGHQZ22Svswndjkhf4LDTv
         zOFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768941390; x=1769546190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EisCJXmr7YBMl5gYvvlr0246N5yEjB6WcdsmZJDqygg=;
        b=qcIXNwoCp0Z4ld9Vz7aoifi++sNHXkXlOWNu3ZOyI7fHdWP7bNdfbilNiVJnvMzx1l
         A/ST1RJ+bGL66zdApgCqb7ArJXC46n/dMbMAIiu2Odgpc4cY8wmjIpHCX0YqpP3jG2ev
         Iza2z+U6P8LaKmS+3+h7t/iB9fnBPC5QURfvWl5ibHk3GyIQRT774vIIrfWs3WoLyUiJ
         uAMtrtc8dAgtZYA4ynO3vWG/FQDUvXMmuJk9zOEfYnhKZOwP6wZpWxLLt6XQ09oeeb85
         mcnBpFmmUzTITVaYjeBDRxgoCxlXICLfV4Friy5Pja+oO35h14llyUBzqXOIEP2qIvsp
         /4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941390; x=1769546190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EisCJXmr7YBMl5gYvvlr0246N5yEjB6WcdsmZJDqygg=;
        b=jNCNjzw1x+NamaRNE2soviIVNyT1AEDmNVmFN5vtTQdeVfLy+NUcyt2lR1rtxFRcPl
         nzSneZ1IVEINthtHRFCruloxHpCCKSWRwx7otNWWSxGSjvM573KEnwfVZmwHiunZ5smd
         Yl1R7Rw2zbxRCc6aOGCR3zc3MXEO8rZL3jO/bdfgq3cxmb7JbtcMfyugM7HrsUrAjnRw
         6iuUgn6kEpPGwfVNkzPTl+DJ4CaQiny2AGzbGfAMEvvueZGm+4QSPhnMgTTreFb01WdY
         rt4daPw6XPetBUcIdg/bZC81/nVcYFAFHJBnppkkp6p5f+o2NXS3/acRxq+J4aV9QCre
         zsvA==
X-Forwarded-Encrypted: i=1; AJvYcCWSCE1Ij7RdQkHzCr/PPFevKegEoVjKqxd3KCEy55YZ3CJXavV973U2t7Id/V1VXnZs9iBCEni7t7Ci5V/3GKHq@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3nOKZ1GudHecFj0UhEXjXEDNPMjTCV2hcORc3zDCB6qA4Gsh
	YF5eHsKstgzAjlVWJc2AlmcSRfw7cHvH4K2Byr45QlcFTp8FQv67VRGgKf8tw5EIZMhgawArQFx
	JwH9svDCzx4MumkmWrlnM7lIlZczntHjc1NMRn3wG
X-Gm-Gg: AZuq6aI74awNAKrnG0tcPqhjsROEEmW3dIwS5+ut2nJx9vusmGUfohvDRwfChqDlkLR
	7Tdi2jRTa7Dq9HhIUh35G1S7TGzZU1NISSk3wrcUhq5/LDWXGmnBG+q9d34j5wc3vfJjsn5cqj+
	A4chfhuVZfxIhIMvHgIV7dSVAIp1WTBTK4g39Q4pLwWcqixCU4bA8bKdOnYaFfMR0E75gYiSeQ5
	JmEwguEolNuxKV48Q5H7xrAVwRpI6hDG7KsEfLZah+o/vGeAQEorJ87lspN87+qcJk0H5u7Imbf
	LQrZOusVfDToKPYGI+t0XfIK4Q==
X-Received: by 2002:a17:903:4b07:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-2a79a61719dmr460505ad.10.1768941389291; Tue, 20 Jan 2026
 12:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113233757.62347-1-namhyung@kernel.org> <CAP-5=fX+zw-CUEYEtrPA6vYUKqpp4LZp-p==QsbZaNwLcX0Whw@mail.gmail.com>
 <aW_kTD04UaLM6Zco@x1>
In-Reply-To: <aW_kTD04UaLM6Zco@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 12:36:17 -0800
X-Gm-Features: AZwV_Qj0-pG5HoHYT-UPfCVF8VZlrAkKoRAidCznO63n5sy066adfIv0dpCisz4
Message-ID: <CAP-5=fUN9ywWRjBM4fNqQqnH9xiwzyK3o80ODi_brpLmYGGQpA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Get debug info of DSO properly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:23=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jan 13, 2026 at 04:45:50PM -0800, Ian Rogers wrote:
> > On Tue, Jan 13, 2026 at 3:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > The dso__debuginfo() just used the path name to open the file but it =
may
> > > be outdated.  It should check build-ID and use the file in the build-=
ID
> > > cache if available rather than just using the path name.
> > >
> > > Let's factor out dso__get_filename() to avoid code duplicate.
> >
> > This change lgtm:
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks, applied to perf-tools-next, and yeah, consolidation on how we
> use dwfl for various purposes is in order, doing it lazily is the way to
> go, the first one that needs it does, just like with other things like
> BTF, etc, some sort of garbage collection at some point will be needed
> not to stay with tons of resources auto-loaded and not needed after some
> time.

Yeah, with the libdw unwinding:
https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
the dwfl is in the thread's maps and those go away in the session
unless keep_exited_threads is enabled:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/symbol_conf.h#n49
struct dso dwfl references are a bit more of a pain as we keep the
dsos in the machine meaning the reference count never lowers to one
except when perf is exiting. We could do with some periodic processing
of the dsos so that any with reference count 1 are removed, and the
associated dwfl cleaned up.

Thanks,
Ian

> - Arnaldo
>
> > I should have recognized this earlier, we seem to be getting multiple
> > copies of the dwfl and I wonder repeatedly parsing the debug info has
> > costs:
> > 1) for arch powerpc there is a dwfl used in
> > tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > 2) there is a dwfl for the libdw addr2line
> > 3) there is a dwfl in debuginfo
> > 4) there is a dwfl in unwind_info in unwind-libdw
> >
> > So 1 and 2 both associate the dwfl with the dso and lazily add it, 1
> > leaks the dwfl whereas 2 ties it to the lifetime of the dso.
> > For 3 there are individual debuginfo uses as well as a debuginfo cache
> > in probe-event.
> > For 4 the lifetime is an unwind of a stacktrace by unwind__get_entries.
> >
> > 1 and 4 load an ELF with a path using dwfl_report_elf  and specifying
> > a base load address.
> > 2 and 3 use dwfl_report_offline with no load address.
> >
> > My understanding is that if you have the Dwfl the Dwfl_module and
> > Dwarf are cheap to compute. The module is cached in the Dwfl and with
> > a single Dwfl/Dwfl_module per dso then there should only ever be 1
> > value:
> > https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwflP.h#L131
> > And the Dwarf is held in the module:
> > https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwflP.h#L195
> > This makes me think the debuginfo may be holding onto more values than
> > it needs to and perhaps we can simplify it.
> >
> > I think ideally we'd have a single Dwfl but that means the
> > Dwfl_modules will need different addresses to avoid overlapping. It
> > doesn't seem to be possible to relocate a module once it is loaded
> > (e.g with dwfl_module_relocate_address -
> > https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwfl.h#L397)
> > and so we'd need some way to come up with an address to keep the
> > modules separate (we couldn't just use the virtual address for a
> > thread as the module address may differ per thread in different
> > processes).
> >
> > So I wonder if we should have a single global Dwfl, and have each dso
> > have a made up load address to get the Dwfl_Module from it - the dso
> > could hold the Dwfl_Module* or the made up load address. 1 and 4 can
> > use their current base load address and adjust it by the made up load
> > address that would be associated with the dso. 2 and 3 can just use
> > the made up load address with the dso to get the module and possibly
> > with (2) remove some of the bias logic. This should speed up a bunch
> > of things by avoiding unnecessary/repeated dwfl_report_elf and
> > dwfl_report_offline calls, it would also cut down on duplication.
> >
> > Thanks,
> > Ian
> >
> > > Fixes: 53a61a6ca279165d ("perf annotate: Add dso__debuginfo() helper"=
)
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/dso.c | 63 ++++++++++++++++++++++++++++++++---------=
--
> > >  tools/perf/util/dso.h | 11 ++------
> > >  2 files changed, 50 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > index 06980844c014ec9b..922fcc2f798baa57 100644
> > > --- a/tools/perf/util/dso.c
> > > +++ b/tools/perf/util/dso.c
> > > @@ -112,7 +112,7 @@ bool dso__is_object_file(const struct dso *dso)
> > >
> > >  int dso__read_binary_type_filename(const struct dso *dso,
> > >                                    enum dso_binary_type type,
> > > -                                  char *root_dir, char *filename, si=
ze_t size)
> > > +                                  const char *root_dir, char *filena=
me, size_t size)
> > >  {
> > >         char build_id_hex[SBUILD_ID_SIZE];
> > >         int ret =3D 0;
> > > @@ -564,20 +564,15 @@ char *dso__filename_with_chroot(const struct ds=
o *dso, const char *filename)
> > >         return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso=
)), filename);
> > >  }
> > >
> > > -static int __open_dso(struct dso *dso, struct machine *machine)
> > > -       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > > +static char *dso__get_filename(struct dso *dso, const char *root_dir=
,
> > > +                              bool *decomp)
> > >  {
> > > -       int fd =3D -EINVAL;
> > > -       char *root_dir =3D (char *)"";
> > >         char *name =3D malloc(PATH_MAX);
> > > -       bool decomp =3D false;
> > >
> > > -       if (!name)
> > > -               return -ENOMEM;
> > > +       *decomp =3D false;
> > >
> > > -       mutex_lock(dso__lock(dso));
> > > -       if (machine)
> > > -               root_dir =3D machine->root_dir;
> > > +       if (name =3D=3D NULL)
> > > +               return NULL;
> > >
> > >         if (dso__read_binary_type_filename(dso, dso__binary_type(dso)=
,
> > >                                             root_dir, name, PATH_MAX)=
)
> > > @@ -602,20 +597,38 @@ static int __open_dso(struct dso *dso, struct m=
achine *machine)
> > >                 size_t len =3D sizeof(newpath);
> > >
> > >                 if (dso__decompress_kmodule_path(dso, name, newpath, =
len) < 0) {
> > > -                       fd =3D -(*dso__load_errno(dso));
> > > +                       errno =3D *dso__load_errno(dso);
> > >                         goto out;
> > >                 }
> > >
> > > -               decomp =3D true;
> > > +               *decomp =3D true;
> > >                 strcpy(name, newpath);
> > >         }
> > > +       return name;
> > > +
> > > +out:
> > > +       free(name);
> > > +       return NULL;
> > > +}
> > >
> > > -       fd =3D do_open(name);
> > > +static int __open_dso(struct dso *dso, struct machine *machine)
> > > +       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > > +{
> > > +       int fd =3D -EINVAL;
> > > +       char *name;
> > > +       bool decomp =3D false;
> > > +
> > > +       mutex_lock(dso__lock(dso));
> > > +
> > > +       name =3D dso__get_filename(dso, machine ? machine->root_dir :=
 "", &decomp);
> > > +       if (name)
> > > +               fd =3D do_open(name);
> > > +       else
> > > +               fd =3D -errno;
> > >
> > >         if (decomp)
> > >                 unlink(name);
> > >
> > > -out:
> > >         mutex_unlock(dso__lock(dso));
> > >         free(name);
> > >         return fd;
> > > @@ -1912,3 +1925,23 @@ const u8 *dso__read_symbol(struct dso *dso, co=
nst char *symfs_filename,
> > >         return __dso__read_symbol(dso, symfs_filename, start, len,
> > >                                   out_buf, out_buf_len, is_64bit);
> > >  }
> > > +
> > > +struct debuginfo *dso__debuginfo(struct dso *dso)
> > > +{
> > > +       char *name;
> > > +       bool decomp =3D false;
> > > +       struct debuginfo *dinfo =3D NULL;
> > > +
> > > +       mutex_lock(dso__lock(dso));
> > > +
> > > +       name =3D dso__get_filename(dso, "", &decomp);
> > > +       if (name)
> > > +               dinfo =3D debuginfo__new(name);
> > > +
> > > +       if (decomp)
> > > +               unlink(name);
> > > +
> > > +       mutex_unlock(dso__lock(dso));
> > > +       free(name);
> > > +       return dinfo;
> > > +}
> > > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > > index 4aee23775054cf83..3dd7d0fc00797f37 100644
> > > --- a/tools/perf/util/dso.h
> > > +++ b/tools/perf/util/dso.h
> > > @@ -777,7 +777,7 @@ int dso__kernel_module_get_build_id(struct dso *d=
so, const char *root_dir);
> > >
> > >  char dso__symtab_origin(const struct dso *dso);
> > >  int dso__read_binary_type_filename(const struct dso *dso, enum dso_b=
inary_type type,
> > > -                                  char *root_dir, char *filename, si=
ze_t size);
> > > +                                  const char *root_dir, char *filena=
me, size_t size);
> > >  bool is_kernel_module(const char *pathname, int cpumode);
> > >  bool dso__needs_decompress(struct dso *dso);
> > >  int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
> > > @@ -926,14 +926,7 @@ u64 dso__findnew_global_type(struct dso *dso, u6=
4 addr, u64 offset);
> > >  bool perf_pid_map_tid(const char *dso_name, int *tid);
> > >  bool is_perf_pid_map_name(const char *dso_name);
> > >
> > > -/*
> > > - * In the future, we may get debuginfo using build-ID (w/o path).
> > > - * Add this helper is for the smooth conversion.
> > > - */
> > > -static inline struct debuginfo *dso__debuginfo(struct dso *dso)
> > > -{
> > > -       return debuginfo__new(dso__long_name(dso));
> > > -}
> > > +struct debuginfo *dso__debuginfo(struct dso *dso);
> > >
> > >  const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filena=
me,
> > >                            const struct map *map, const struct symbol=
 *sym,
> > > --
> > > 2.52.0.457.g6b5491de43-goog
> > >
