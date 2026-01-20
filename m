Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32F337B99;
	Tue, 20 Jan 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940623; cv=none; b=VOjo6RNxsC89lU9VeF247zotjJ+MRsc1miypUXkuAck5XBDSbF7tTk3z4t7G2MPMtDr6N0DIKc90voctbG6kfDmGIEV6uSWmZ+IvePdqLYWI9g4QGOfUeWAAICIERXA96ygS/xfJ7cJJNWn6agRR27moiEI+RZ7kQM+pYEBowAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940623; c=relaxed/simple;
	bh=LK8+2MCBBrDrWy0WW5g2Ga4WxQFjadp/WWgX9LodJ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opNP3YT/VB2v2DLrROIfUXYGxhQWkbtghAa3chHp50DxiHNu+XUc4jTS/oIem8Y21CCgZOJbyjZrGUvmtC/BOjV69fvbTi9n4lH5Ky0pKS0J+I7xaL7zMc8mPeOAyKIcua1Mlk6ZQzz8AVT7S7lsdZgpYPWNeDTGd9wc/bz2nKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjBijoX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjBijoX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B0C16AAE;
	Tue, 20 Jan 2026 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768940623;
	bh=LK8+2MCBBrDrWy0WW5g2Ga4WxQFjadp/WWgX9LodJ5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjBijoX5dFUAQhYlA24qFpC0lX3rdffFHkAB6IWA+zUxA2+DmNELVjxxp13+5DW0a
	 ol/Hx5FqrLV/UL5hsxNu6e0Ms2IBTvd3ObHPX8EZKuZhfFMMYSbm1SSnCZDdNFulh4
	 /HxdsXB8mdo6PjuH/trDQ0e9UwYVBC8t/JGTQwkmF34+rlchFc3OGcjOhZPfz5SGDB
	 2H8N8HO3jw4TuReGDA/686J2hIPAjRxd/kpfqSRYjShGxUhudxLqGxWiqeWtcx/9K5
	 0IYLRjh1qAJkfilV8X8duxRuI1gygex2MDMECMwh99KckwAaDhRcslTq/X7CNL+ZKP
	 4PZTl4ucAg3fg==
Date: Tue, 20 Jan 2026 17:23:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Get debug info of DSO properly
Message-ID: <aW_kTD04UaLM6Zco@x1>
References: <20260113233757.62347-1-namhyung@kernel.org>
 <CAP-5=fX+zw-CUEYEtrPA6vYUKqpp4LZp-p==QsbZaNwLcX0Whw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX+zw-CUEYEtrPA6vYUKqpp4LZp-p==QsbZaNwLcX0Whw@mail.gmail.com>

On Tue, Jan 13, 2026 at 04:45:50PM -0800, Ian Rogers wrote:
> On Tue, Jan 13, 2026 at 3:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The dso__debuginfo() just used the path name to open the file but it may
> > be outdated.  It should check build-ID and use the file in the build-ID
> > cache if available rather than just using the path name.
> >
> > Let's factor out dso__get_filename() to avoid code duplicate.
> 
> This change lgtm:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, and yeah, consolidation on how we
use dwfl for various purposes is in order, doing it lazily is the way to
go, the first one that needs it does, just like with other things like
BTF, etc, some sort of garbage collection at some point will be needed
not to stay with tons of resources auto-loaded and not needed after some
time.

- Arnaldo
 
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
> 
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
> > -                                  char *root_dir, char *filename, size_t size)
> > +                                  const char *root_dir, char *filename, size_t size)
> >  {
> >         char build_id_hex[SBUILD_ID_SIZE];
> >         int ret = 0;
> > @@ -564,20 +564,15 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
> >         return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
> >  }
> >
> > -static int __open_dso(struct dso *dso, struct machine *machine)
> > -       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > +static char *dso__get_filename(struct dso *dso, const char *root_dir,
> > +                              bool *decomp)
> >  {
> > -       int fd = -EINVAL;
> > -       char *root_dir = (char *)"";
> >         char *name = malloc(PATH_MAX);
> > -       bool decomp = false;
> >
> > -       if (!name)
> > -               return -ENOMEM;
> > +       *decomp = false;
> >
> > -       mutex_lock(dso__lock(dso));
> > -       if (machine)
> > -               root_dir = machine->root_dir;
> > +       if (name == NULL)
> > +               return NULL;
> >
> >         if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
> >                                             root_dir, name, PATH_MAX))
> > @@ -602,20 +597,38 @@ static int __open_dso(struct dso *dso, struct machine *machine)
> >                 size_t len = sizeof(newpath);
> >
> >                 if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
> > -                       fd = -(*dso__load_errno(dso));
> > +                       errno = *dso__load_errno(dso);
> >                         goto out;
> >                 }
> >
> > -               decomp = true;
> > +               *decomp = true;
> >                 strcpy(name, newpath);
> >         }
> > +       return name;
> > +
> > +out:
> > +       free(name);
> > +       return NULL;
> > +}
> >
> > -       fd = do_open(name);
> > +static int __open_dso(struct dso *dso, struct machine *machine)
> > +       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> > +{
> > +       int fd = -EINVAL;
> > +       char *name;
> > +       bool decomp = false;
> > +
> > +       mutex_lock(dso__lock(dso));
> > +
> > +       name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
> > +       if (name)
> > +               fd = do_open(name);
> > +       else
> > +               fd = -errno;
> >
> >         if (decomp)
> >                 unlink(name);
> >
> > -out:
> >         mutex_unlock(dso__lock(dso));
> >         free(name);
> >         return fd;
> > @@ -1912,3 +1925,23 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
> >         return __dso__read_symbol(dso, symfs_filename, start, len,
> >                                   out_buf, out_buf_len, is_64bit);
> >  }
> > +
> > +struct debuginfo *dso__debuginfo(struct dso *dso)
> > +{
> > +       char *name;
> > +       bool decomp = false;
> > +       struct debuginfo *dinfo = NULL;
> > +
> > +       mutex_lock(dso__lock(dso));
> > +
> > +       name = dso__get_filename(dso, "", &decomp);
> > +       if (name)
> > +               dinfo = debuginfo__new(name);
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
> > @@ -777,7 +777,7 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
> >
> >  char dso__symtab_origin(const struct dso *dso);
> >  int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
> > -                                  char *root_dir, char *filename, size_t size);
> > +                                  const char *root_dir, char *filename, size_t size);
> >  bool is_kernel_module(const char *pathname, int cpumode);
> >  bool dso__needs_decompress(struct dso *dso);
> >  int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
> > @@ -926,14 +926,7 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
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
> >  const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
> >                            const struct map *map, const struct symbol *sym,
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
