Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18C1B5EB7;
	Mon,  9 Sep 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892814; cv=none; b=YdDjXvxkPZYOkAXU7CBr7i+Hs0MdF7SCMhxiYp1Evy6I670T9IfkoYEoVjBw+yuNxtoYt2iFZsPiQr2xqyXEXGDjsJ8GVUvI9Fz7SdV11zaL5IR8M4r4YsN3Sdq6tXPQAEyW2clqWKLIqE6Q7V56jcjYUr+0WBzj590Y48FZhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892814; c=relaxed/simple;
	bh=151wFbPZm2CYnXfm5jDu3SZ70DfkdMdZsViLXdsDykg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHP6uzdT7ZOlWYj75Nx7mUUaXfI7H80hsyQSkf7wWTvcplttTw5LNzeep/qJ8lpxkkAYHgeH4u6Xy9GTGwcZMI9OksXGajKl+z/5eJkTRSLO0nI0vLzGLpFHnFlhistdaa4SGCMVaONdxtGgiA7ZH8ixeDKS4g0JnCChAxS+1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+V7K4ZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+V7K4ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8088AC4CEC5;
	Mon,  9 Sep 2024 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892813;
	bh=151wFbPZm2CYnXfm5jDu3SZ70DfkdMdZsViLXdsDykg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+V7K4ZSGetC81I+vJfuM3zeMqzaWCRwDoyfZG6r4rVp8sPnVd7FjUsTkgvZwX4yG
	 lfqG3JIy9Pjy6viEpS3B5QMCuKOp0uG9gPH3vaEz4+/rTUxc2rX43HR1kJu42Eo8LM
	 3ZzwfzstoColSjk8bDVDj5wpaEAvv4Rj/QJtal5iliq/Wpk8gm6urJZ+wDcMeK8ree
	 dUhyow+X0vTiV+7C/rBwC8mlthbo1GBz3+zKjiYSh/HDjPpYfozLX31mG7sYwS7A9b
	 T/VSF3fhP4RKS5jaZxWsi/Lj+k+o2qnlj3TUkdhVp2xJfy3iZ4adnkT4mJ87WBPlJ/
	 5np8GSMgvFhQw==
Date: Mon, 9 Sep 2024 11:40:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 4/8] perf trace: Pretty print struct data
Message-ID: <Zt8IypiWo0OuK5cR@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-5-howardchu95@gmail.com>
 <Zs-Q-ZyZKd_NzsIv@x1>
 <CAH0uvoge5QUsioZ-j8OS+VoxJAXuP9CyXOJbBkJPwUXWhEryMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoge5QUsioZ-j8OS+VoxJAXuP9CyXOJbBkJPwUXWhEryMg@mail.gmail.com>

On Fri, Aug 30, 2024 at 08:16:38AM +0800, Howard Chu wrote:
> Hello Arnaldo,
> 
> On Thu, Aug 29, 2024 at 5:05 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Sun, Aug 25, 2024 at 12:33:18AM +0800, Howard Chu wrote:
> > > Change the arg->augmented.args to arg->augmented.args->value to skip the
> > > header for customized pretty printers, since we collect data in BPF
> > > using the general augment_sys_enter(), which always adds the header.
> > >
> > > Use btf_dump API to pretty print augmented struct pointer.
> > >
> > > Prefer existed pretty-printer than btf general pretty-printer.
> > >
> > > set compact = true and skip_names = true, so that no newline character
> > > and argument name are printed.
> > >
> > > Committer notes:
> > >
> > > Simplified the btf_dump_snprintf callback to avoid using multiple
> > > buffers, as discussed in the thread accessible via the Link tag below.
> > >
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Link: https://lore.kernel.org/r/20240815013626.935097-7-howardchu95@gmail.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/builtin-trace.c                | 65 +++++++++++++++++++++--
> > >  tools/perf/trace/beauty/perf_event_open.c |  2 +-
> > >  tools/perf/trace/beauty/sockaddr.c        |  2 +-
> > >  tools/perf/trace/beauty/timespec.c        |  2 +-
> > >  4 files changed, 63 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 43b1f63415b4..048bcb92624c 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -990,6 +990,54 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
> > >       return 0;
> > >  }
> > >
> > > +struct trace_btf_dump_snprintf_ctx {
> > > +     char   *bf;
> > > +     size_t printed, size;
> > > +};
> > > +
> > > +static void trace__btf_dump_snprintf(void *vctx, const char *fmt, va_list args)
> > > +{
> > > +     struct trace_btf_dump_snprintf_ctx *ctx = vctx;
> > > +
> > > +     ctx->printed += vscnprintf(ctx->bf + ctx->printed, ctx->size - ctx->printed, fmt, args);
> > > +}
> > > +
> > > +static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg)
> > > +{
> > > +     struct trace_btf_dump_snprintf_ctx ctx = {
> > > +             .bf   = bf,
> > > +             .size = size,
> > > +     };
> > > +     struct augmented_arg *augmented_arg = arg->augmented.args;
> > > +     int type_id = arg->fmt->type_id, consumed;
> > > +     struct btf_dump *btf_dump;
> > > +
> > > +     LIBBPF_OPTS(btf_dump_opts, dump_opts);
> > > +     LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> > > +
> > > +     if (arg == NULL || arg->augmented.args == NULL)
> > > +             return 0;
> > > +
> > > +     dump_data_opts.compact     = true;
> > > +     dump_data_opts.skip_names  = true;
> > > +
> > > +     btf_dump = btf_dump__new(btf, trace__btf_dump_snprintf, &ctx, &dump_opts);
> > > +     if (btf_dump == NULL)
> > > +             return 0;
> > > +
> > > +     /* pretty print the struct data here */
> > > +     if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
> > > +             return 0;
> > > +
> > > +     consumed = sizeof(*augmented_arg) + augmented_arg->size;
> > > +     arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> > > +     arg->augmented.size -= consumed;
> > > +
> > > +     btf_dump__free(btf_dump);
> > > +
> > > +     return ctx.printed;
> > > +}
> > > +
> > >  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
> > >                                  size_t size, int val, char *type)
> > >  {
> > > @@ -1009,6 +1057,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
> > >
> > >       if (btf_is_enum(arg_fmt->type))
> > >               return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
> > > +     else if (btf_is_struct(arg_fmt->type))
> > > +             return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
> > >
> > >       return 0;
> > >  }
> > > @@ -2222,6 +2272,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> > >               .show_string_prefix = trace->show_string_prefix,
> > >       };
> > >       struct thread_trace *ttrace = thread__priv(thread);
> > > +     void *default_scnprintf;
> > >
> > >       /*
> > >        * Things like fcntl will set this in its 'cmd' formatter to pick the
> > > @@ -2263,11 +2314,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> > >                       if (trace->show_arg_names)
> > >                               printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> > >
> > > -                     btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
> > > -                                                        size - printed, val, field->type);
> > > -                     if (btf_printed) {
> > > -                             printed += btf_printed;
> > > -                             continue;
> > > +                     default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
> > > +
> > > +                     if (default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
> > > +                             btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
> > > +                                                                size - printed, val, field->type);
> > > +                             if (btf_printed) {
> > > +                                     printed += btf_printed;
> > > +                                     continue;
> > > +                             }
> >
> > Ok, we agreed on this one, and you noted that that in this cset comment,
> > good.
> >
> > Next time make a note after the cset commit log message and before the
> > actual patch, something like:
> >
> > vN: prefer pre-existing userspace scnprintf if explicitely specified,
> > only fallbacking to the generic BTF one when none is specified.
> >
> > >                       }
> > >
> > >                       printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> > > diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
> > > index 01ee15fe9d0c..632237128640 100644
> > > --- a/tools/perf/trace/beauty/perf_event_open.c
> > > +++ b/tools/perf/trace/beauty/perf_event_open.c
> > > @@ -76,7 +76,7 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
> >
> > But this part will work if we use the old collectors in the BPF skel?
> >
> 
> You are right, it won't. The one scenario is that when a vmlinux file
> is presented, the general collector (the new one, based on BTF) will
> fallback to the old collectors, and now we have new
> consumers(ptr->value). This will break.
> 
> > I.e. isn't this a change in the protocol of the BPF colector with the
> > userpace augmented snprintf routines?
> >
> > If I remember we discussed that first you make this change in the
> > protocol, test it with the pre-existing BPF collector, it works. Ok, now
> > we have a new protocol and we then use it in the generic BTF-based BPF
> > collector. This way that option of using the BTF-based collector or the
> > preexisting BPF collector works.
> >
> > I'll try to do this.
> 
> Thank you so much.

Now that I have:

6b22c2b502a1c21b (x1/perf-tools-next, perf-tools-next/tmp.perf-tools-next, acme/tmp.perf-tools-next) perf trace: Use a common encoding for augmented arguments, with size + error + payload
5d9cd24924f57066 perf trace augmented_syscalls.bpf: Move the renameat aumenter to renameat2, temporarily

And also:

7bedcbaefdf5d4f7 perf trace: Pass the richer 'struct syscall_arg' pointer to trace__btf_scnprintf()
8df1d8c6cbd6825b perf trace: Fix perf trace -p <PID>

I can move to this patch, but then it doesn't build as it uses things
that will only be available when we get to adding the new BPF components
in a later patch:

builtin-trace.c: In function ‘trace__init_syscalls_bpf_prog_array_maps’:
builtin-trace.c:3725:58: error: ‘struct <anonymous>’ has no member named ‘beauty_map_enter’
 3725 |         int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
      |                                                          ^
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
make[3]: *** Waiting for unfinished jobs....

It will only come when we add:

Subject: [PATCH v3 6/8] perf trace: Collect augmented data using BPF

Where we have:

+struct beauty_map_enter {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, __u32[6]);
+	__uint(max_entries, 512);
+} beauty_map_enter SEC(".maps");


So I'll try to combine the addition of the map with the code that uses
it in the builtin-trace.c codebase.

- Arnaldo
