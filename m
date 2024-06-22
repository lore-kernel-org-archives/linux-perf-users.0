Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809F2AF15;
	Sat, 22 Jun 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719080925; cv=none; b=BKfrZmAxxRjFjFIa39cEOQrkvd14wSauckc76aHzYAq7/db+Z8fUtd6/JmB/AuOHC6qS30mTU9AUVWuxQnYWTBI4dKjF07yPbR46A3GWn6qDgVzwNe2L6SkmsRCohQlB8G2iYphg3+enQIBdp/txIdt8oacORybVV8F/S16/W1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719080925; c=relaxed/simple;
	bh=TYM2VNt2CUY/B2T6+mkg8JEEmTUYNPCbB+1WqiK7Nuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL1WhSCo4N5AaOJKEVB5eD/X1eCjYe33BDpRyaWtLEEenOHbfAsabNR6vnLUJIBpHa6kojo6XNWv83uby02U+XcFdwP4dw8uknd8ig9iOOUhevpPA7jMYcPSsYGKbX1VaProBsIv9V0znALnHosAQ9jXx8QH+JYRwhXTysCg8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2NtQLig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2NtQLig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBCCC3277B;
	Sat, 22 Jun 2024 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719080924;
	bh=TYM2VNt2CUY/B2T6+mkg8JEEmTUYNPCbB+1WqiK7Nuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2NtQLigfysa0cImXIizwJcoic5xJBLDtzK9bTTVMnw5lBt+ttN0l+0TpOR7NFhcb
	 QDxNsYGp2GNd4sqCkhnqdld0DeX35MS62vWxQtknHS0WQ+yaPxL7XlhZP8Eeii7aZL
	 y69FfkVatvvP5vZzTAij1hlf1xKMTgISxo1ztKrROVOsS+FwyxJeo8JcQ+da/GDngW
	 G/UaEQ4wGA+jZsJsFkAIPQjRMPgtBJULwmfX+Zaromie1LjmGxkINfXAplv99hU9y2
	 FSINLuVvekONnAFssE7iTt30Ditx0pkpyQnEZBPfDl1x2AkfvlM4hj+gsfOt0cCLkC
	 1FADcyxfiBZAA==
Date: Sat, 22 Jun 2024 15:28:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with
 BTF
Message-ID: <ZncX2JxXL0HJY7Rn@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com>
 <ZnLgstTgrFRYu0aD@x1>
 <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
 <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
 <CAH0uvohe2WssHZGYNyMCq=xpasXOYxaznRsGPe49iYQBME8_QQ@mail.gmail.com>
 <ZnWCxgeFClpo2k3M@x1>
 <CAH0uvohMLkgRBF48evgU=-CMFsHsGZxKs3nA6bWSS_Vv-tqM=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohMLkgRBF48evgU=-CMFsHsGZxKs3nA6bWSS_Vv-tqM=g@mail.gmail.com>

On Sat, Jun 22, 2024 at 12:18:10AM +0800, Howard Chu wrote:
> Hello Arnaldo,
> 
> I think I need to add some explanations here, for the all-in-one patch
> that I have on the tree.
> 
> Firstly, no use_btf is passed when constructing syscall argument
> format. We just write is_enum when the type is enum. This is because
> we don't load btf when we are constructing the formats, we load
> vmlinux when a tracepoint hits.
> 
> before:
> 
> } else if (strstr(field->type, "enum") && use_btf != NULL) {
> *use_btf = arg->is_enum = true;
> 
> after:
> 
> } else if (strstr(field->type, "enum")) {
> arg->is_enum = true;
> 
> Another confusing place is when we do the filtering. When a user
> passes an enum name, say --filter="mode==HRTIMER_MODE_ABS", we do not
> know what 'HRTIMER_MODE_ABS' means. For this case, we have to load the
> vmlinux BTF, and match the strings to get a value, not delaying till a
> tracepoint hits.

Right, I worked on your latest series before the combined patch, and to
solve that at filter expansion time, I did:

@@ -3861,9 +3903,16 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
                        if (fmt->strtoul) {
                                u64 val;
                                struct syscall_arg syscall_arg = {
-                                       .parm = fmt->parm,
+                                       .trace = trace,
+                                       .fmt   = fmt,
                                };
 
+                               if (fmt->is_enum) {
+                                       syscall_arg.parm = type;
+                               } else {
+                                       syscall_arg.parm = fmt->parm;
+                               }
+
                                if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {


And then in the enum btf strtoul we can load the btf:

+static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
+{
+       const struct btf_type *bt;
+       char *type = arg->parm;
+       struct btf_enum *be;
+       struct btf *btf;
+
+       trace__load_vmlinux_btf(arg->trace);
+
+       btf = arg->trace->btf;
+       if (btf == NULL)
+               return false;
+
+       if (syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type) < 0)
+               return false;
+
+       bt = arg->fmt->type;
+       be = btf_enum(bt);
+       for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
+               const char *name = btf__name_by_offset(btf, be->name_off);
+               int max_len = max(size, strlen(name));
+
+               if (strncmp(name, bf, max_len) == 0) {
+                       *val = be->val;
+                       return true;
+               }
+       }
+
+       return false;
+}

And:

+static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+{
+       int id;
+
+       // Already cached?
+       if (arg_fmt->type != NULL)
+               return 0;
+
+       type = strstr(type, "enum ");
+       if (type == NULL)
+               return -1;
+
+       type += 5; // skip "enum " to get the enumeration name
+
+       id = btf__find_by_name(btf, type);
+       if (id < 0)
+               return -1;
+
+       arg_fmt->type = btf__type_by_id(btf, id);
+       return arg_fmt->type == NULL ? -1 : 0;
+}

So that in all cases we do the lookup for the BTF enum type just once
and cache it in the syscall_arg_fmt->type.
 
> Next thing is, for this section in trace__expand_filter():
> 
> ```
> struct btf_parm bparm;
> 
> if (fmt->is_enum) {
>     if (trace->btf == NULL)
>         trace__load_vmlinux_btf(trace);
> 
>     /* btf could be NULL */
>     bparm.btf  = trace->btf;
>     bparm.type = type;
>     syscall_arg.parm = &bparm;
> }
> ```
> 
> I don't handle the return value of trace__load_vmlinux_btf(), because
> I want to make the latter " if (fmt->strtoul(right, right_size,
> &syscall_arg, &val)) {
> " evaluated to be false, so that we can fall into the else block,
> therefore prints the pr_err of no resolver. This could be confusing.
> 
> pr_err("No resolver (strtoul) for \"%s\" in \"%s\", can't set filter \"%s\"\n",
>        arg, evsel->name, evsel->filter);
> return -1;
> 
> And another confusing part is, originally we discard 0 value for enum
> arguments, now with enum aug, printed a 0-value enum makes sense,
> therefore these lines:
> 
> if (val == 0 && !trace->show_zeros &&
>     !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
> #ifdef HAVE_LIBBPF_SUPPORT
>         if (!(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum))
> #endif
>         continue;
> 
> It suits as an &&, I don't know if it's the best way to do it.

Excellent observation, that show_zero needs to be conditional on non-BTF
enum augmentation, i.e. if we're going to just print a zero and 'perf
trace' is configured not to show it but we are printing the enum entry,
then we should not consider that .show_zero setting. But this can be
done as a follow up patch to reduce the size of this one.
 
> That's it for all, thank you for finding time in your busy schedule to
> review my code. I'll develop my skills to do self-checks in the
> future,
> 
> Thanks,
> Howard
> 
> On Fri, Jun 21, 2024 at 9:40 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Jun 21, 2024 at 03:16:26AM +0800, Howard Chu wrote:
> > > Hello,
> > >
> > > The fixes are on the perf-tools-next branch at:
> > > https://github.com/Sberm/linux.git
> > >
> > > please use
> > > ```
> > > git pull https://github.com/Sberm/linux.git perf-tools-next
> > > ```
> > >
> > > I'm no git expert so please tell me if something is wrong.
> >
> > So, you combined everything into just one patch and there is no commit
> > log message, I'll see if I can redo it from the last broken out patch
> > series you submitted.
> >
> > - Arnaldo
> >
> > > P.S. not my proudest patch, changed too many things, might be buggy.
> > > If there're bugs please let me know.
> > >
> > > On Fri, Jun 21, 2024 at 12:34 AM Howard Chu <howardchu95@gmail.com> wrote:
> > > >
> > > > Hello Arnaldo,
> > > >
> > > > Thanks for the review, the code is refined based on your comments.
> > > > There is just a little thing:
> > > >
> > > > On Thu, Jun 20, 2024 at 1:59 AM Howard Chu <howardchu95@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > Thanks for the in-depth review.
> > > > >
> > > > > On Wed, Jun 19, 2024 at 9:44 PM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> > > > > > > This is a feature implemented on the basis of the previous bug fix
> > > > > > > https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t
> > > > > > >
> > > > > > > In this patch, BTF is used to turn enum value to the corresponding
> > > > > > > enum variable name. There is only one system call that uses enum value
> > > > > > > as its argument, that is `landlock_add_rule()`.
> > > > > > >
> > > > > > > The vmlinux btf is loaded lazily, when user decided to trace the
> > > > > > > `landlock_add_rule` syscall. But if one decides to run `perf trace`
> > > > > > > without any arguments, the behaviour is to trace `landlock_add_rule`,
> > > > > > > so vmlinux btf will be loaded by default.
> > > > > > >
> > > > > > > before:
> > > > > > >
> > > > > > > ```
> > > > > > > perf $ ./perf trace -e landlock_add_rule
> > > > > > >      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
> > > > > > >      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
> > > > > > > ```
> > > > > > >
> > > > > > > after:
> > > > > > >
> > > > > > > ```
> > > > > > > perf $ ./perf trace -e landlock_add_rule
> > > > > > >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
> > > > > > >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
> > > > > > > ```
> > > > > > > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > > > > > ---
> > > > > > >  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
> > > > > > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > > > > > index c4fa8191253d..d93f34e9af74 100644
> > > > > > > --- a/tools/perf/builtin-trace.c
> > > > > > > +++ b/tools/perf/builtin-trace.c
> > > > > > > @@ -19,6 +19,7 @@
> > > > > > >  #ifdef HAVE_LIBBPF_SUPPORT
> > > > > > >  #include <bpf/bpf.h>
> > > > > > >  #include <bpf/libbpf.h>
> > > > > > > +#include <bpf/btf.h>
> > > > > > >  #ifdef HAVE_BPF_SKEL
> > > > > > >  #include "bpf_skel/augmented_raw_syscalls.skel.h"
> > > > > > >  #endif
> > > > > > > @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
> > > > > > >       const char *name;
> > > > > > >       u16        nr_entries; // for arrays
> > > > > > >       bool       show_zero;
> > > > > > > +     bool       is_enum;
> > > > > > > +     struct {
> > > > > > > +             void    *entries;
> > > > > > > +             u16     nr_entries;
> > > > > > > +     }          btf_entry;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct syscall_fmt {
> > > > > > > @@ -140,6 +146,7 @@ struct trace {
> > > > > > >  #ifdef HAVE_BPF_SKEL
> > > > > > >       struct augmented_raw_syscalls_bpf *skel;
> > > > > > >  #endif
> > > > > > > +     struct btf              *btf;
> > > > > > >       struct record_opts      opts;
> > > > > > >       struct evlist   *evlist;
> > > > > > >       struct machine          *host;
> > > > > > > @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
> > > > > > >           .strtoul    = STUL_STRARRAY_FLAGS, \
> > > > > > >           .parm       = &strarray__##array, }
> > > > > > >
> > > > > > > +static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> > > > > > > +{
> > > > > > > +     const struct btf_type *bt;
> > > > > > > +     char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> > > > > > > +     int id;
> > > > > > > +     size_t i;
> > > > > > > +
> > > > > > > +     for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> > > > > > > +             ep = enum_prefix[i];
> > > > > > > +             if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
> > > > > >
> > > > > > No need for the strlen test? I.e. plain using strstarts() should be
> > > > > > enough?
> > > > >
> > > > > Agree. Thanks for pointing that out. Although if string 'type' is
> > > > > 'enum' and prefix is 'enum', strstarts() will be true, but to do 'type
> > > > > += strlen(ep) + 1', and then access 'type', might give us an
> > > > > out-of-range access, but I don't think 'type' will ever be just 'enum'
> > > > > or 'const enum', so I'll delete it then.
> > > > >
> > > > > >
> > > > > > > +                     type += strlen(ep) + 1;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     id = btf__find_by_name(btf, type);
> > > > > > > +     if (id < 0)
> > > > > > > +             return -1;
> > > > > > > +
> > > > > > > +     bt = btf__type_by_id(btf, id);
> > > > > > > +     if (bt == NULL)
> > > > > >
> > > > > > a pr_debug() stating that something that tracefs says should be in BTF
> > > > > > and isn't found there seems to be of value here.
> > > > >
> > > > > Sure.
> > > > >
> > > > > >
> > > > > > > +             return -1;
> > > > > > > +
> > > > > > > +     arg_fmt->btf_entry.entries    = btf_enum(bt);
> > > > > > > +     arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
> > > > > > > +                              struct syscall_arg_fmt *arg_fmt)
> > > > > > > +{
> > > > > > > +     struct btf_enum *be;
> > > > > > > +     int i;
> > > > > > > +
> > > > > > > +     /* if btf_entry is NULL, find and save it to arg_fmt */
> > > > > > > +     if (arg_fmt->btf_entry.entries == NULL)
> > > > > > > +             if (btf_enum_find_entry(btf, type, arg_fmt))
> > > > > > > +                     return 0;
> > > > > > > +
> > > > > > > +     be = (struct btf_enum *)arg_fmt->btf_entry.entries;
> > > > > >
> > > > > >         struct btf_enum *be = (struct btf_enum *)arg_fmt->btf_entry.entries;
> > > > > >
> > > > > >  arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
> > > > > > btf_enum *) cast here, removing it makes the code more compact. And
> > > > > > since we move the declaration to the same line, the info about its type
> > > > > > is there as well.
> > > > >
> > > > > Sure, thanks.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +     for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > > > >
> > > > > >
> > > > > >         for (int i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >
> > > > I did this, it's all good. But here:
> > > >
> > > > for (i = 0, be = arg_fmt->btf_entry.entries; i <
> > > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >
> > > > I can't do
> > > >
> > > > for (int i = 0, struct btf_enum *be = arg_fmt->btf_entry.entries; i <
> > > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >
> > > > The compiler will show errors:
> > > >
> > > > builtin-trace.c: In function ‘btf_enum_scnprintf’:
> > > > builtin-trace.c:996:25: error: expected identifier or ‘(’ before ‘struct’
> > > >   996 |         for (int i = 0, struct btf_enum *be =
> > > > arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> > > > ++be) {
> > > >       |                         ^~~~~~
> > > > builtin-trace.c:996:117: error: ‘be’ undeclared (first use in this
> > > > function); did you mean ‘bf’?
> > > >   996 |         for (int i = 0, struct btf_enum *be =
> > > > arg_fmt->btf_entry.entries; i < arg_fmt->btf_entry.nr_entries; ++i,
> > > > ++be) {
> > > >       |
> > > >                                                      ^~
> > > >       |
> > > >                                                      bf
> > > > builtin-trace.c:996:117: note: each undeclared identifier is reported
> > > > only once for each function it appears in
> > > >
> > > > This is not good either:
> > > >
> > > > for (int i = 0, be = arg_fmt->btf_entry.entries; i <
> > > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >
> > > > builtin-trace.c: In function ‘btf_enum_scnprintf’:
> > > > builtin-trace.c:998:25: error: declaration of ‘be’ shadows a previous
> > > > local [-Werror=shadow]
> > > >   998 |         for (int i = 0, be = arg_fmt->btf_entry.entries; i <
> > > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >       |                         ^~
> > > > builtin-trace.c:991:26: note: shadowed declaration is here
> > > >   991 |         struct btf_enum *be;
> > > >       |                          ^~
> > > > builtin-trace.c:998:30: error: initialization of ‘int’ from ‘void *’
> > > > makes integer from pointer without a cast [-Wint-conversion]
> > > >   998 |         for (int i = 0, be = arg_fmt->btf_entry.entries; i <
> > > > arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > >       |                              ^~~~~~~
> > > >
> > > > But I can do:
> > > >
> > > > ```
> > > > be = arg_fmt->btf_entry.entries;
> > > >
> > > > for (int i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> > > > ```
> > > >
> > > > Thanks,
> > > > Howard
> > > >
> > > >
> > > > > >
> > > > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/perf/ | wc -l
> > > > > > 99
> > > > > > ⬢[acme@toolbox perf-tools-next]$
> > > > > >
> > > > > > Doing it this way makes the code more compact and is allowed even in
> > > > > > kernel code since some time ago:
> > > > >
> > > > > Sure.
> > > > >
> > > > > >
> > > > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers/ | wc -l
> > > > > > 294
> > > > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/ | wc -l
> > > > > > 12
> > > > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | wc -l
> > > > > > 3
> > > > > > ⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | wc -l
> > > > > > 21
> > > > > > ⬢[acme@toolbox perf-tools-next]$
> > > > > >
> > > > > > > +             if (be->val == val) {
> > > > > > > +                     return scnprintf(bf, size, "%s",
> > > > > > > +                                      btf__name_by_offset(btf, be->name_off));
> > > > > > > +             }
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  #include "trace/beauty/arch_errno_names.c"
> > > > > > >  #include "trace/beauty/eventfd.c"
> > > > > > >  #include "trace/beauty/futex_op.c"
> > > > > > > @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *trace)
> > > > > > >       symbol__exit();
> > > > > > >  }
> > > > > > >
> > > > > > > +static void trace__load_vmlinux_btf(struct trace *trace)
> > > > > > > +{
> > > > > > > +     trace->btf = btf__load_vmlinux_btf();
> > > > > > > +     if (verbose > 0) {
> > > > > > > +             fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> > > > > > > +                                                 "Failed to load vmlinux BTF\n");
> > > > > > > +     }
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> > > > > > >  {
> > > > > > >       int idx;
> > > > > > > @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
> > > > > > >  }
> > > > > > >
> > > > > > >  static struct tep_format_field *
> > > > > > > -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
> > > > > > > +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field, bool *use_btf)
> > > > > > >  {
> > > > > > >       struct tep_format_field *last_field = NULL;
> > > > > > >       int len;
> > > > > > > @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > > > > > >                        * 7 unsigned long
> > > > > > >                        */
> > > > > > >                       arg->scnprintf = SCA_FD;
> > > > > > > +             } else if (strstr(field->type, "enum") && use_btf != NULL) {
> > > > > > > +                     *use_btf = arg->is_enum = true;
> > > > > >
> > > > > > Here you have to check if use_btf is NULL, as you, in this patch, later
> > > > > > call syscall_arg_fmt__init_array(arg, field, NULL) in
> > > > > > evsel__init_tp_arg_scnprintf(), probably you tested it all at the end of
> > > > > > the patch series, we have to make sure that it works after each patch,
> > > > > > so that we keep the codebase bisectable.
> > > > >
> > > > > I'm sorry, could you enlighten me on this? I thought:
> > > > > ```
> > > > > else if (strstr(field->type, "enum") && use_btf != NULL) {
> > > > > ```
> > > > > is doing the NULL checking. If you mean making sure the NULL checking
> > > > > appears in all patches, I thought this is where we should introduce
> > > > > the checking. Tiny reminder, the [1/5] patch is your syscalltbl
> > > > > traversal bug fix.
> > > > >
> > > > > >
> > > > > > >               } else {
> > > > > > >                       const struct syscall_arg_fmt *fmt =
> > > > > > >                               syscall_arg_fmt__find_by_name(field->name);
> > > > > > > @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> > > > > > >       return last_field;
> > > > > > >  }
> > > > > > >
> > > > > > > -static int syscall__set_arg_fmts(struct syscall *sc)
> > > > > > > +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
> > > > > > >  {
> > > > > > > -     struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
> > > > > > > +     struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
> > > > > > > +                                                                       use_btf);
> > > > > > >
> > > > > > >       if (last_field)
> > > > > > >               sc->args_size = last_field->offset + last_field->size;
> > > > > > > @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> > > > > > >  {
> > > > > > >       char tp_name[128];
> > > > > > >       struct syscall *sc;
> > > > > > > +     int err;
> > > > > > >       const char *name = syscalltbl__name(trace->sctbl, id);
> > > > > > > +     bool use_btf = false;
> > > > > > >
> > > > > > >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> > > > > > >       if (trace->syscalls.table == NULL) {
> > > > > > > @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> > > > > > >       sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
> > > > > > >       sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
> > > > > > >
> > > > > > > -     return syscall__set_arg_fmts(sc);
> > > > > > > +     err = syscall__set_arg_fmts(sc, &use_btf);
> > > > > > > +
> > > > > > > +     if (use_btf && trace->btf == NULL)
> > > > > > > +             trace__load_vmlinux_btf(trace);
> > > > > > > +
> > > > > > > +     return err;
> > > > > > >  }
> > > > > > >
> > > > > > >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > > > > > @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > > > > > >       struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
> > > > > > >
> > > > > > >       if (fmt != NULL) {
> > > > > > > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
> > > > > > > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
> > > > > > >               return 0;
> > > > > > >       }
> > > > > > >
> > > > > > > @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> > > > > > >                       if (trace->show_arg_names)
> > > > > > >                               printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> > > > > > >
> > > > > > > +                     if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
> > > > > > > +                             size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
> > > > > > > +                                                           trace->btf, field->type,
> > > > > > > +                                                           &sc->arg_fmt[arg.idx]);
> > > > > > > +                             if (p) {
> > > > > > > +                                     printed += p;
> > > > > > > +                                     continue;
> > > > > > > +                             }
> > > > > > > +                     }
> > > > > > > +
> > > > > > >                       printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> > > > > > >                                                                 bf + printed, size - printed, &arg, val);
> > > > > > >               }
> > > > > > > --
> > > > > > > 2.45.2
> > > > > > >
> > > > >
> > > > > Thanks,
> > > > > Howard
