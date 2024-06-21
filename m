Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0804178CD6;
	Fri, 21 Jun 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993032; cv=none; b=H1iX6C2xu9JGphwYPmPF2V8xSRwH8M9W4k5lgNfNNBLlPXjoPaJYSe81TAlxbBFIlbwYi0OLVfhkv4m56a7zwAH0yIM7nnA2Bx5GsTM4LBNE7uV29RA1JcxurUaY/HO8O1zGbWZZjMxEaGkRs9WvdkZpd7dmqGvP9E/MNYsc63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993032; c=relaxed/simple;
	bh=cEx2mciPnmR8aprzyHavr7YyTwPHQK5NbQ4Nvyt5BBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnrY6aB2tlasoybX8I8rsdkZw6A3f6W0d0ijVuPrwKqKJb3tvIcgPt5FPhM5YC+c43FJJ4f+4TG40PmQ6dygBxSCTsmwCRw63fHgNIVF4TzRbObqRIuXd5krBeoZJpN0DO5FTh7IrozoFm9MK4gzT1V4lTP0/Ry5eejwAGTJCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdFmulGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdFmulGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5577C2BBFC;
	Fri, 21 Jun 2024 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718993032;
	bh=cEx2mciPnmR8aprzyHavr7YyTwPHQK5NbQ4Nvyt5BBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdFmulGeo25hjqsKKj/cff71Z2MyqzpEkhPy3566uzJeAx4Pb+RlmdMjEApHjVm/N
	 sUAh0hrJlbFakLPhpOUWqAzfeatr7D6EYRM7Fdavxn/3ctJmnMA2bpGFCrCgxaq4mF
	 wuSFYbZFqjchTsKw63tE1IvpqSLxlxrKZqPDz915rUT9zk/0PNC4O4aVvWxipckyYh
	 0kPb3pR0qSKy4ubLI8A61PgCYWepej9/lIb8i0T5bCsjIHsGtszYL6YWQWlXHBsliu
	 I1Yt6vIKAYbuInlDHchuySFfuy0yWg2XYspOJuytQ9Mi+6K9IDekVn8KQGkPJj90ZE
	 0Y9fSEnIraaaQ==
Date: Fri, 21 Jun 2024 15:03:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with
 BTF
Message-ID: <ZnXAhFflUl_LV1QY@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com>
 <ZnLgstTgrFRYu0aD@x1>
 <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qHm5er9783+uyhU7"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>


--qHm5er9783+uyhU7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 20, 2024 at 01:59:37AM +0800, Howard Chu wrote:
> Hello,
> 
> Thanks for the in-depth review.
> 
> On Wed, Jun 19, 2024 at 9:44 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > > This is a feature implemented on the basis of the previous bug fix
> > > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t
> > >
> > > In this patch, BTF is used to turn enum value to the corresponding
> > > enum variable name. There is only one system call that uses enum value
> > > as its argument, that is `landlock_add_rule()`.
> > >
> > > The vmlinux btf is loaded lazily, when user decided to trace the
> > > `landlock_add_rule` syscall. But if one decides to run `perf trace`
> > > without any arguments, the behaviour is to trace `landlock_add_rule`,
> > > so vmlinux btf will be loaded by default.
> > >
> > > before:
> > >
> > > ```
> > > perf $ ./perf trace -e landlock_add_rule
> > >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
> > >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
> > > ```
> > >
> > > after:
> > >
> > > ```
> > > perf $ ./perf trace -e landlock_add_rule
> > >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
> > >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
> > > ```
> > > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index c4fa8191253d..d93f34e9af74 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -19,6 +19,7 @@
> > >  #ifdef HAVE_LIBBPF_SUPPORT
> > >  #include <bpf/bpf.h>
> > >  #include <bpf/libbpf.h>
> > > +#include <bpf/btf.h>
> > >  #ifdef HAVE_BPF_SKEL
> > >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> > >  #endif
> > > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> > >       const char *name;
> > >       u16        nr_entries; // for arrays
> > >       bool       show_zero;
> > > +     bool       is_enum;
> > > +     struct {
> > > +             void    *entries;
> > > +             u16     nr_entries;
> > > +     }          btf_entry;
> > >  };
> > >
> > >  struct syscall_fmt {
> > > @@ -140,6 +146,7 @@ struct trace {
> > >  #ifdef HAVE_BPF_SKEL
> > >       struct augmented_raw_syscalls_bpf *skel;
> > >  #endif
> > > +     struct btf              *btf;
> > >       struct record_opts      opts;
> > >       struct evlist   *evlist;
> > >       struct machine          *host;
> > > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
> > >           .strtoul    = STUL_STRARRAY_FLAGS, \
> > >           .parm       = &strarray__##array, }
> > >
> > > +static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> > > +{
> > > +     const struct btf_type *bt;
> > > +     char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> > > +     int id;
> > > +     size_t i;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > > +             ep = enum_prefix[i];
> > > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
> >
> > No need for the strlen test? I.e. plain using strstarts() should be
> > enough?
> 
> Agree. Thanks for pointing that out. Although if string 'type' is
> 'enum' and prefix is 'enum', strstarts() will be true, but to do 'type
> += strlen(ep) + 1', and then access 'type', might give us an
> out-of-range access, but I don't think 'type' will ever be just 'enum'
> or 'const enum', so I'll delete it then.

So, I did some changes to this patch to fix some issues:

1) We need to make this conditional on libbpf being available, i.e. we
need to build with 'make NO_LIBBPF=1' so I had to add some ifdefs for
HAVE_LIBBPF_SUPPORT, and moved some checks for trace->btf to the
functions where it is used, so that we can pass just 'trace'.

2) syscall_arg_fmt->btf_entry became just syscall_arg_fmt->type, a
'struct btf_type' pointer, this way we can have:

#ifdef HAVE_LIBBPF_SUPPORT
static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
{
	int id;

	type = strstr(type, "enum ");
	if (type == NULL)
		return -1;

	type += 5; // skip "enum " to get the enumeration name

	id = btf__find_by_name(btf, type);
	if (id < 0)
		return -1;

	arg_fmt->type = btf__type_by_id(btf, id);
	return arg_fmt->type == NULL ? -1 : 0;
}


static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, int val)
{
	struct btf_enum *be = btf_enum(type);
	const int nr_entries = btf_vlen(type);

	for (int i = 0; i < nr_entries; ++i, ++be) {
		if (be->val == val) {
			return scnprintf(bf, size, "%s",
					 btf__name_by_offset(btf, be->name_off));
		}
	}

	return 0;
}

static size_t trace__btf_enum_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
					size_t size, int val, char *type)
{
	if (trace->btf == NULL)
		return 0;
	/* if btf_entry is NULL, find and save it to arg_fmt */
	if (arg_fmt->type == NULL &&
	    syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) < 0)
		return 0;

	return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
}
#else // HAVE_LIBBPF_SUPPORT
static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
					char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
					char *type __maybe_unused)
{
	return 0;
}
#endif // HAVE_LIBBPF_SUPPORT

The patch on top of yours is attached. I'll fixup the following ones and
have them in a branch for you to check and see if you agree with the
changes.

- Arnaldo

> >
> > > +                     type += strlen(ep) + 1;
> > > +     }
> > > +
> > > +     id = btf__find_by_name(btf, type);
> > > +     if (id < 0)
> > > +             return -1;
> > > +
> > > +     bt = btf__type_by_id(btf, id);
> > > +     if (bt == NULL)
> >
> > a pr_debug() stating that something that tracefs says should be in BTF
> > and isn't found there seems to be of value here.
> 
> Sure.
> 
> >
> > > +             return -1;
> > > +
> > > +     arg_fmt->btf_entry.entries    = btf_enum(bt);
> > > +     arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
> > > +                              struct syscall_arg_fmt *arg_fmt)
> > > +{
> > > +     struct btf_enum *be;
> > > +     int i;
> > > +
> > > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > > +     if (arg_fmt->btf_entry.entries == NULL)
> > > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > > +                     return 0;
> > > +
> > > +     be = (struct btf_enum *)arg_fmt->btf_entry.entries;
> >
> >         struct btf_enum *be = (struct btf_enum *)arg_fmt->btf_entry.entries;
> >
> >  arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
> > btf_enum *) cast here, removing it makes the code more compact. And
> > since we move the declaration to the same line, the info about its type
> > is there as well.
> 
> Sure, thanks.
> 
> >
> > > +
> > > +     for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> >
> >         for (int i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> >
> > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/perf/ | wc -l
> > 99
> > ⬢[acme@toolbox perf-tools-next]$
> >
> > Doing it this way makes the code more compact and is allowed even in
> > kernel code since some time ago:
> 
> Sure.
> 
> >
> > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers/ | wc -l
> > 294
> > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/ | wc -l
> > 12
> > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | wc -l
> > 3
> > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | wc -l
> > 21
> > ⬢[acme@toolbox perf-tools-next]$
> >
> > > +             if (be->val == val) {
> > > +                     return scnprintf(bf, size, "%s",
> > > +                                      btf__name_by_offset(btf, be->name_off));
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  #include "trace/beauty/arch_errno_names.c"
> > >  #include "trace/beauty/eventfd.c"
> > >  #include "trace/beauty/futex_op.c"
> > > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *trace)
> > >       symbol__exit();
> > >  }
> > >
> > > +static void trace__load_vmlinux_btf(struct trace *trace)
> > > +{
> > > +     trace->btf = btf__load_vmlinux_btf();
> > > +     if (verbose > 0) {
> > > +             fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> > > +                                                 "Failed to load vmlinux BTF\n");
> > > +     }
> > > +}
> > > +
> > >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> > >  {
> > >       int idx;
> > > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
> > >  }
> > >
> > >  static struct tep_format_field *
> > > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
> > > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field, bool *use_btf)
> > >  {
> > >       struct tep_format_field *last_field = NULL;
> > >       int len;
> > > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > >                        * 7 unsigned long
> > >                        */
> > >                       arg->scnprintf = SCA_FD;
> > > +             } else if (strstr(field->type, "enum") && use_btf != NULL) {
> > > +                     *use_btf = arg->is_enum = true;
> >
> > Here you have to check if use_btf is NULL, as you, in this patch, later
> > call syscall_arg_fmt__init_array(arg, field, NULL) in
> > evsel__init_tp_arg_scnprintf(), probably you tested it all at the end of
> > the patch series, we have to make sure that it works after each patch,
> > so that we keep the codebase bisectable.
> 
> I'm sorry, could you enlighten me on this? I thought:
> ```
> else if (strstr(field->type, "enum") && use_btf != NULL) {
> ```
> is doing the NULL checking. If you mean making sure the NULL checking
> appears in all patches, I thought this is where we should introduce
> the checking. Tiny reminder, the [1/5] patch is your syscalltbl
> traversal bug fix.

scrap my comment, was a brain fart ;-/ of course you are alreadyu
checking if use_btf is NULL, doh.
 
> >
> > >               } else {
> > >                       const struct syscall_arg_fmt *fmt =
> > >                               syscall_arg_fmt__find_by_name(field->name);
> > > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > >       return last_field;
> > >  }
> > >
> > > -static int syscall__set_arg_fmts(struct syscall *sc)
> > > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
> > >  {
> > > -     struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
> > > +     struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
> > > +                                                                       use_btf);
> > >
> > >       if (last_field)
> > >               sc->args_size = last_field->offset + last_field->size;
> > > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> > >  {
> > >       char tp_name[128];
> > >       struct syscall *sc;
> > > +     int err;
> > >       const char *name = syscalltbl__name(trace->sctbl, id);
> > > +     bool use_btf = false;
> > >
> > >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> > >       if (trace->syscalls.table == NULL) {
> > > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> > >       sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
> > >       sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
> > >
> > > -     return syscall__set_arg_fmts(sc);
> > > +     err = syscall__set_arg_fmts(sc, &use_btf);
> > > +
> > > +     if (use_btf && trace->btf == NULL)
> > > +             trace__load_vmlinux_btf(trace);
> > > +
> > > +     return err;
> > >  }
> > >
> > >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > >       struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
> > >
> > >       if (fmt != NULL) {
> > > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
> > > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
> > >               return 0;
> > >       }
> > >
> > > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> > >                       if (trace->show_arg_names)
> > >                               printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> > >
> > > +                     if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
> > > +                             size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
> > > +                                                           trace->btf, field->type,
> > > +                                                           &sc->arg_fmt[arg.idx]);
> > > +                             if (p) {
> > > +                                     printed += p;
> > > +                                     continue;
> > > +                             }
> > > +                     }
> > > +
> > >                       printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> > >                                                                 bf + printed, size - printed, &arg, val);
> > >               }
> > > --
> > > 2.45.2
> > >
> 
> Thanks,
> Howard

--qHm5er9783+uyhU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btf_enum_fprintf.patch"

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3a1c031aff9ad049..49d99c20b7f711ef 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -112,10 +112,9 @@ struct syscall_arg_fmt {
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
 	bool	   is_enum;
-	struct {
-		void	*entry;
-		u16	nr_entries;
-	}	   btf_entry;
+#ifdef HAVE_LIBBPF_SUPPORT
+	const struct btf_type *type;
+#endif
 };
 
 struct syscall_fmt {
@@ -146,7 +145,9 @@ struct trace {
 #ifdef HAVE_BPF_SKEL
 	struct augmented_raw_syscalls_bpf *skel;
 #endif
+#ifdef HAVE_LIBBPF_SUPPORT
 	struct btf		*btf;
+#endif
 	struct record_opts	opts;
 	struct evlist	*evlist;
 	struct machine		*host;
@@ -894,47 +895,32 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
-static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
+#ifdef HAVE_LIBBPF_SUPPORT
+static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
 {
-	const struct btf_type *bt;
-	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
 	int id;
-	size_t i;
 
-	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
-		ep = enum_prefix[i];
-		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
-			type += strlen(ep) + 1;
-	}
+	type = strstr(type, "enum ");
+	if (type == NULL)
+		return -1;
+
+	type += 5; // skip "enum " to get the enumeration name
 
 	id = btf__find_by_name(btf, type);
 	if (id < 0)
 		return -1;
 
-	bt = btf__type_by_id(btf, id);
-	if (bt == NULL)
-		return -1;
-
-	arg_fmt->btf_entry.entry      = btf_enum(bt);
-	arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
-
-	return 0;
+	arg_fmt->type = btf__type_by_id(btf, id);
+	return arg_fmt->type == NULL ? -1 : 0;
 }
 
-static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
-				 struct syscall_arg_fmt *arg_fmt)
-{
-	struct btf_enum *be;
-	int i;
-
-	/* if btf_entry is NULL, find and save it to arg_fmt */
-	if (arg_fmt->btf_entry.entry == NULL)
-		if (btf_enum_find_entry(btf, type, arg_fmt))
-			return 0;
 
-	be = (struct btf_enum *)arg_fmt->btf_entry.entry;
+static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, int val)
+{
+	struct btf_enum *be = btf_enum(type);
+	const int nr_entries = btf_vlen(type);
 
-	for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
+	for (int i = 0; i < nr_entries; ++i, ++be) {
 		if (be->val == val) {
 			return scnprintf(bf, size, "%s",
 					 btf__name_by_offset(btf, be->name_off));
@@ -944,6 +930,27 @@ static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf
 	return 0;
 }
 
+static size_t trace__btf_enum_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
+					size_t size, int val, char *type)
+{
+	if (trace->btf == NULL)
+		return 0;
+	/* if btf_entry is NULL, find and save it to arg_fmt */
+	if (arg_fmt->type == NULL &&
+	    syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) < 0)
+		return 0;
+
+	return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
+}
+#else // HAVE_LIBBPF_SUPPORT
+static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
+					char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
+					char *type __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .strtoul	= STUL_STRARRAY, \
@@ -1757,13 +1764,18 @@ static void trace__symbols__exit(struct trace *trace)
 	symbol__exit();
 }
 
-static void trace__load_vmlinux_btf(struct trace *trace)
+static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
 {
+#ifdef HAVE_LIBBPF_SUPPORT
+	if (trace->btf != NULL)
+		return;
+
 	trace->btf = btf__load_vmlinux_btf();
 	if (verbose > 0) {
 		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
 						    "Failed to load vmlinux BTF\n");
 	}
+#endif
 }
 
 static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
@@ -1959,7 +1971,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	err = syscall__set_arg_fmts(sc);
 
 	/* after calling syscall__set_arg_fmts() we'll know whether use_btf is true */
-	if (sc->use_btf && trace->btf == NULL)
+	if (sc->use_btf)
 		trace__load_vmlinux_btf(trace);
 
 	return err;
@@ -2182,10 +2194,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
-				size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
-							      trace->btf, field->type,
-							      &sc->arg_fmt[arg.idx]);
+			if (sc->arg_fmt[arg.idx].is_enum) {
+				size_t p = trace__btf_enum_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
+								     size - printed, val, field->type);
 				if (p) {
 					printed += p;
 					continue;

--qHm5er9783+uyhU7--
