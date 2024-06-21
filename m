Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318979D8;
	Fri, 21 Jun 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977225; cv=none; b=Aanopwt6SxZ1z6JHrieGaILol3a63bmNVxLD3yCvq0suIYGr+AV6pZgyNyp7ZDZi1V+jzbDkeHCDi2PCx+TzhoAiYRsYfxijnmW10p5yycAdGVDOObEJ9KdtjCJdIJ9h57MTxtkhp9Uk178jT/nL/JwTCAhXuQsiC1k7IBDR4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977225; c=relaxed/simple;
	bh=fOM9ylRhcgz7ECY4ZWBxL26DxUUgMk2Ed4FUd7Ji+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZeB6yVDZ5KJ9vBTomCxx/qWbkvCDv7TJ7SJNCm7X6Esz6tTzABML7hEdW/PJQUUEtzMo8JmtwpNY8P1sswRh1eajednpn5BBrv/D0R6+1P8qSZdh8Ft+woa1Ab06Xigz8Yw1A0MaDybP3C8J84dbqbEdt+ylNhcGUY4DTt9HPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFWEwid5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFWEwid5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D28AC2BBFC;
	Fri, 21 Jun 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718977225;
	bh=fOM9ylRhcgz7ECY4ZWBxL26DxUUgMk2Ed4FUd7Ji+6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFWEwid5hPzLHOOsv6GRlXK77oTJTmYrJ+9RYGaGj27q9SUUEFK91cNe1FmlNF/KO
	 yTeYnA+VyXkvNXqHiB8InaMF+8NeszlOKHFEoTe8ujJvPy7BjGjJLnsoV2J34aLyPa
	 Wp0+6yYfpSaPwd//HeQfFSkNYseTHKUznZIklu+u+wFJJQzLjNpfadlpOcAtqp7nnE
	 mo4+YER6IPhNNnX1iQJzdlaugqSjihe0G+JMyRZxKrc1RYSKex+JE9X5aHJ5Qhp0VQ
	 nqwnoyMoCbVX5T6cI/Y2OfD2ZQ+0MvgW4nNvIb81kWJ7zMrVrldbU81mqdr7Mu6JD+
	 HwWVht1Xsm9zQ==
Date: Fri, 21 Jun 2024 10:40:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with
 BTF
Message-ID: <ZnWCxgeFClpo2k3M@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com>
 <ZnLgstTgrFRYu0aD@x1>
 <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
 <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
 <CAH0uvohe2WssHZGYNyMCq=xpasXOYxaznRsGPe49iYQBME8_QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohe2WssHZGYNyMCq=xpasXOYxaznRsGPe49iYQBME8_QQ@mail.gmail.com>

On Fri, Jun 21, 2024 at 03:16:26AM +0800, Howard Chu wrote:
> Hello,
> 
> The fixes are on the perf-tools-next branch at:
> https://github.com/Sberm/linux.git
> 
> please use
> ```
> git pull https://github.com/Sberm/linux.git perf-tools-next
> ```
> 
> I'm no git expert so please tell me if something is wrong.

So, you combined everything into just one patch and there is no commit
log message, I'll see if I can redo it from the last broken out patch
series you submitted.

- Arnaldo
 
> P.S. not my proudest patch, changed too many things, might be buggy.
> If there're bugs please let me know.
> 
> On Fri, Jun 21, 2024 at 12:34 AM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hello Arnaldo,
> >
> > Thanks for the review, the code is refined based on your comments.
> > There is just a little thing:
> >
> > On Thu, Jun 20, 2024 at 1:59 AM Howard Chu <howardchu95@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > Thanks for the in-depth review.
> > >
> > > On Wed, Jun 19, 2024 at 9:44 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > > > > This is a feature implemented on the basis of the previous bug fix
> > > > > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t
> > > > >
> > > > > In this patch, BTF is used to turn enum value to the corresponding
> > > > > enum variable name. There is only one system call that uses enum value
> > > > > as its argument, that is `landlock_add_rule()`.
> > > > >
> > > > > The vmlinux btf is loaded lazily, when user decided to trace the
> > > > > `landlock_add_rule` syscall. But if one decides to run `perf trace`
> > > > > without any arguments, the behaviour is to trace `landlock_add_rule`,
> > > > > so vmlinux btf will be loaded by default.
> > > > >
> > > > > before:
> > > > >
> > > > > ```
> > > > > perf $ ./perf trace -e landlock_add_rule
> > > > >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
> > > > >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
> > > > > ```
> > > > >
> > > > > after:
> > > > >
> > > > > ```
> > > > > perf $ ./perf trace -e landlock_add_rule
> > > > >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
> > > > >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
> > > > > ```
> > > > > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > > > ---
> > > > >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > > > index c4fa8191253d..d93f34e9af74 100644
> > > > > --- a/tools/perf/builtin-trace.c
> > > > > +++ b/tools/perf/builtin-trace.c
> > > > > @@ -19,6 +19,7 @@
> > > > >  #ifdef HAVE_LIBBPF_SUPPORT
> > > > >  #include <bpf/bpf.h>
> > > > >  #include <bpf/libbpf.h>
> > > > > +#include <bpf/btf.h>
> > > > >  #ifdef HAVE_BPF_SKEL
> > > > >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> > > > >  #endif
> > > > > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> > > > >       const char *name;
> > > > >       u16        nr_entries; // for arrays
> > > > >       bool       show_zero;
> > > > > +     bool       is_enum;
> > > > > +     struct {
> > > > > +             void    *entries;
> > > > > +             u16     nr_entries;
> > > > > +     }          btf_entry;
> > > > >  };
> > > > >
> > > > >  struct syscall_fmt {
> > > > > @@ -140,6 +146,7 @@ struct trace {
> > > > >  #ifdef HAVE_BPF_SKEL
> > > > >       struct augmented_raw_syscalls_bpf *skel;
> > > > >  #endif
> > > > > +     struct btf              *btf;
> > > > >       struct record_opts      opts;
> > > > >       struct evlist   *evlist;
> > > > >       struct machine          *host;
> > > > > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
> > > > >           .strtoul    = STUL_STRARRAY_FLAGS, \
> > > > >           .parm       = &strarray__##array, }
> > > > >
> > > > > +static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> > > > > +{
> > > > > +     const struct btf_type *bt;
> > > > > +     char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> > > > > +     int id;
> > > > > +     size_t i;
> > > > > +
> > > > > +     for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > > > > +             ep = enum_prefix[i];
> > > > > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
> > > >
> > > > No need for the strlen test? I.e. plain using strstarts() should be
> > > > enough?
> > >
> > > Agree. Thanks for pointing that out. Although if string 'type' is
> > > 'enum' and prefix is 'enum', strstarts() will be true, but to do 'type
> > > += strlen(ep) + 1', and then access 'type', might give us an
> > > out-of-range access, but I don't think 'type' will ever be just 'enum'
> > > or 'const enum', so I'll delete it then.
> > >
> > > >
> > > > > +                     type += strlen(ep) + 1;
> > > > > +     }
> > > > > +
> > > > > +     id = btf__find_by_name(btf, type);
> > > > > +     if (id < 0)
> > > > > +             return -1;
> > > > > +
> > > > > +     bt = btf__type_by_id(btf, id);
> > > > > +     if (bt == NULL)
> > > >
> > > > a pr_debug() stating that something that tracefs says should be in BTF
> > > > and isn't found there seems to be of value here.
> > >
> > > Sure.
> > >
> > > >
> > > > > +             return -1;
> > > > > +
> > > > > +     arg_fmt->btf_entry.entries    = btf_enum(bt);
> > > > > +     arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
> > > > > +                              struct syscall_arg_fmt *arg_fmt)
> > > > > +{
> > > > > +     struct btf_enum *be;
> > > > > +     int i;
> > > > > +
> > > > > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > > > > +     if (arg_fmt->btf_entry.entries == NULL)
> > > > > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > > > > +                     return 0;
> > > > > +
> > > > > +     be = (struct btf_enum *)arg_fmt->btf_entry.entries;
> > > >
> > > >         struct btf_enum *be = (struct btf_enum *)arg_fmt->btf_entry.entries;
> > > >
> > > >  arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
> > > > btf_enum *) cast here, removing it makes the code more compact. And
> > > > since we move the declaration to the same line, the info about its type
> > > > is there as well.
> > >
> > > Sure, thanks.
> > >
> > > >
> > > > > +
> > > > > +     for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >
> > > >
> > > >         for (int i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> > I did this, it's all good. But here:
> >
> > for (i = 0, be = arg_fmt->btf_entry.entries; i <
> > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> > I can't do
> >
> > for (int i = 0, struct btf_enum *be = arg_fmt->btf_entry.entries; i <
> > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> > The compiler will show errors:
> >
> > builtin-trace.c: In function ‘btf_enum_scnprintf’:
> > builtin-trace.c:996:25: error: expected identifier or ‘(’ before ‘struct’
> >   996 |         for (int i = 0, struct btf_enum *be =
> > arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> > ++be) {
> >       |                         ^~~~~~
> > builtin-trace.c:996:117: error: ‘be’ undeclared (first use in this
> > function); did you mean ‘bf’?
> >   996 |         for (int i = 0, struct btf_enum *be =
> > arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> > ++be) {
> >       |
> >                                                      ^~
> >       |
> >                                                      bf
> > builtin-trace.c:996:117: note: each undeclared identifier is reported
> > only once for each function it appears in
> >
> > This is not good either:
> >
> > for (int i = 0, be = arg_fmt->btf_entry.entries; i <
> > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> > builtin-trace.c: In function ‘btf_enum_scnprintf’:
> > builtin-trace.c:998:25: error: declaration of ‘be’ shadows a previous
> > local [-Werror=shadow]
> >   998 |         for (int i = 0, be = arg_fmt->btf_entry.entries; i <
> > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >       |                         ^~
> > builtin-trace.c:991:26: note: shadowed declaration is here
> >   991 |         struct btf_enum *be;
> >       |                          ^~
> > builtin-trace.c:998:30: error: initialization of ‘int’ from ‘void *’
> > makes integer from pointer without a cast [-Wint-conversion]
> >   998 |         for (int i = 0, be = arg_fmt->btf_entry.entries; i <
> > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >       |                              ^~~~~~~
> >
> > But I can do:
> >
> > ```
> > be = arg_fmt->btf_entry.entries;
> >
> > for (int i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > ```
> >
> > Thanks,
> > Howard
> >
> >
> > > >
> > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/perf/ | wc -l
> > > > 99
> > > > ⬢[acme@toolbox perf-tools-next]$
> > > >
> > > > Doing it this way makes the code more compact and is allowed even in
> > > > kernel code since some time ago:
> > >
> > > Sure.
> > >
> > > >
> > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers/ | wc -l
> > > > 294
> > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/ | wc -l
> > > > 12
> > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | wc -l
> > > > 3
> > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | wc -l
> > > > 21
> > > > ⬢[acme@toolbox perf-tools-next]$
> > > >
> > > > > +             if (be->val == val) {
> > > > > +                     return scnprintf(bf, size, "%s",
> > > > > +                                      btf__name_by_offset(btf, be->name_off));
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  #include "trace/beauty/arch_errno_names.c"
> > > > >  #include "trace/beauty/eventfd.c"
> > > > >  #include "trace/beauty/futex_op.c"
> > > > > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *trace)
> > > > >       symbol__exit();
> > > > >  }
> > > > >
> > > > > +static void trace__load_vmlinux_btf(struct trace *trace)
> > > > > +{
> > > > > +     trace->btf = btf__load_vmlinux_btf();
> > > > > +     if (verbose > 0) {
> > > > > +             fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> > > > > +                                                 "Failed to load vmlinux BTF\n");
> > > > > +     }
> > > > > +}
> > > > > +
> > > > >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> > > > >  {
> > > > >       int idx;
> > > > > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
> > > > >  }
> > > > >
> > > > >  static struct tep_format_field *
> > > > > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
> > > > > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field, bool *use_btf)
> > > > >  {
> > > > >       struct tep_format_field *last_field = NULL;
> > > > >       int len;
> > > > > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > > > >                        * 7 unsigned long
> > > > >                        */
> > > > >                       arg->scnprintf = SCA_FD;
> > > > > +             } else if (strstr(field->type, "enum") && use_btf != NULL) {
> > > > > +                     *use_btf = arg->is_enum = true;
> > > >
> > > > Here you have to check if use_btf is NULL, as you, in this patch, later
> > > > call syscall_arg_fmt__init_array(arg, field, NULL) in
> > > > evsel__init_tp_arg_scnprintf(), probably you tested it all at the end of
> > > > the patch series, we have to make sure that it works after each patch,
> > > > so that we keep the codebase bisectable.
> > >
> > > I'm sorry, could you enlighten me on this? I thought:
> > > ```
> > > else if (strstr(field->type, "enum") && use_btf != NULL) {
> > > ```
> > > is doing the NULL checking. If you mean making sure the NULL checking
> > > appears in all patches, I thought this is where we should introduce
> > > the checking. Tiny reminder, the [1/5] patch is your syscalltbl
> > > traversal bug fix.
> > >
> > > >
> > > > >               } else {
> > > > >                       const struct syscall_arg_fmt *fmt =
> > > > >                               syscall_arg_fmt__find_by_name(field->name);
> > > > > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > > > >       return last_field;
> > > > >  }
> > > > >
> > > > > -static int syscall__set_arg_fmts(struct syscall *sc)
> > > > > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
> > > > >  {
> > > > > -     struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
> > > > > +     struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
> > > > > +                                                                       use_btf);
> > > > >
> > > > >       if (last_field)
> > > > >               sc->args_size = last_field->offset + last_field->size;
> > > > > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> > > > >  {
> > > > >       char tp_name[128];
> > > > >       struct syscall *sc;
> > > > > +     int err;
> > > > >       const char *name = syscalltbl__name(trace->sctbl, id);
> > > > > +     bool use_btf = false;
> > > > >
> > > > >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> > > > >       if (trace->syscalls.table == NULL) {
> > > > > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> > > > >       sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
> > > > >       sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
> > > > >
> > > > > -     return syscall__set_arg_fmts(sc);
> > > > > +     err = syscall__set_arg_fmts(sc, &use_btf);
> > > > > +
> > > > > +     if (use_btf && trace->btf == NULL)
> > > > > +             trace__load_vmlinux_btf(trace);
> > > > > +
> > > > > +     return err;
> > > > >  }
> > > > >
> > > > >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > > > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > > >       struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
> > > > >
> > > > >       if (fmt != NULL) {
> > > > > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
> > > > > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
> > > > >               return 0;
> > > > >       }
> > > > >
> > > > > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> > > > >                       if (trace->show_arg_names)
> > > > >                               printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> > > > >
> > > > > +                     if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
> > > > > +                             size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
> > > > > +                                                           trace->btf, field->type,
> > > > > +                                                           &sc->arg_fmt[arg.idx]);
> > > > > +                             if (p) {
> > > > > +                                     printed += p;
> > > > > +                                     continue;
> > > > > +                             }
> > > > > +                     }
> > > > > +
> > > > >                       printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> > > > >                                                                 bf + printed, size - printed, &arg, val);
> > > > >               }
> > > > > --
> > > > > 2.45.2
> > > > >
> > >
> > > Thanks,
> > > Howard
