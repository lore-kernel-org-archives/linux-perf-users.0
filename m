Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43647F3C2;
	Thu,  1 Oct 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879699; cv=none; b=uZ9RZDTXB2ose3Nw2qjCtHxjljWjRqtx3bVpQqt+6Bu8O0XhcteOCTGzAn9uaSMWunG8ClXkD7JEDil2z7nmJIi5jEALAW2Z5Ik2phSxC+L78ICUgMYhgwtM4nKIvneeTS0ofCG5ZyoalzIEUVLhYjN0UfXw1h2jtyha+9xKcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879699; c=relaxed/simple;
	bh=W0bzw6R/eAwX/lhd3khCqViKQD6y4W8xetEena4xCrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3BMqPqH2/BkNMrXYqIi2NaonPUi3rwA290P0b2lolERj7bKJwX+ik/xv1VbI/i3PqWVXHa98ow/TrJzOsTOlA/eMBeQgJmzwuwcO/NJhID3qYdgWNdYb1MawcLebaQ/rbVYzl0XT72gtSf2b2+KLG88x1IXRyvtp1zIdkOStko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak9zpgVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak9zpgVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D0E1F000FF;
	Thu,  1 Oct 2026 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879698;
	bh=zT1YEDYo0d3e2k//+5S/EJIVhOpGFMEjofAL7yNpxT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ak9zpgVP871yrqOZIMJyAnDw19HNRYIfC1hPy6MOTimGG3lF23eJF3FYfWZRf8Lry
	 PAbnktI2DwCdkaHuv6bos+1K8kKHaQS80ogFZb/1PKuYm8LRvR81yZK/gG3R3FScRE
	 7n9FLJVzZnUdH5hzFETAAJY0Ef/am59K1Kttmlx33BC7dgut53rCmQAAihrqR+9AY4
	 wLavTn29TQjOB7H4mhKuA0mHYwBc3/RNSTOSvCUlYfxYYR6gEaAPtY/V8/o3Vo3a1T
	 GraBt73BBL/4KAKI2Fvhh/j0GS73nAwyOzABTyD79glXUR8gV7B+lFpKSuBMImIbNO
	 kyAntFPRRbuwQ==
Date: Thu, 1 Oct 2026 20:34:53 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their
 length
Message-ID: <ar6nzTSj17IxCy0j@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com>
 <ar1fon_Z4uT3Cd22@x2>
 <ar2WYemXnrbDx-Il@google.com>
 <ar4i6X8g9H4dfiah@x2>
 <CAP-5=fX8BW97JHE1G=L2G0T9LqqzfMkWgqZOQV_XJJxJzo80dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX8BW97JHE1G=L2G0T9LqqzfMkWgqZOQV_XJJxJzo80dA@mail.gmail.com>

On Thu, Oct 01, 2026 at 10:17:24AM -0700, Ian Rogers wrote:
> On Thu, Oct 1, 2026 at 2:07 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Sep 30, 2026 at 04:08:17PM -0700, Namhyung Kim wrote:
> > > On Wed, Sep 30, 2026 at 09:14:42PM +0200, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, Sep 28, 2026 at 11:25:45AM -0700, Ian Rogers wrote:
> > > > > +++ b/tools/perf/builtin-trace.c
> > > > > @@ -4159,7 +4159,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
> > > > >                           continue;

> > > > >                   bt = sc->arg_fmt[i].type;
> > > > > -                 beauty_array[i] = bt->size;
> > > > > +                 /* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> > > > > +                 if (strcmp(name, "sockaddr") == 0 && field->next &&
> > > > > +                     strstr(field->next->name, "len"))
> > > > > +                         beauty_array[i] = -((i + 1) + 1);
> > > > > +                 else
> > > > > +                         beauty_array[i] = bt->size;
> >
> > > > And it knows how many bytes to read by looking at socklen
> > > > (args->args[2]), i.e. not use the generic BPF handler that uses this
> > > > beauty_array, because knowing how many bytes to read in this case is
> > > > dynamic, varies with each syscall, according to one of its arguments :-\
> >
> > > > What am I missing?
> >
> > > I think Ian's patch update the beauty map which is used by
> > > augment_sys_enter() before tail-calling syscall-specific functions.
> >
> > > It'd be great if we cover all syscalls in the BPF skeleton and switch
> > > to the beauty-map and discard the functions.
> >
> > I was missing the convention that a negative size means read some
> > other argument with a cap, as Ian explained in his response.
> >
> > So checking if a syscall arg is of type sockaddr (or if the name is
> > always sockaddr as Ian did above) and the next arg has name "len", then
> > we can set the beauty_array[index_of_sockaddr_arg] = -index_of_len_arg,
> > that extra + 1 looks odd, but must be part of the convention too.
 
> Thanks for merging the series!

Good stuff, you're welcome to send more ;-) :-)
 
> Yes, the two + 1s are:
> - (i + 1): the 0-based index of the length argument right after the
> sockaddr argument.
> - -(j + 1): beauty_array's 1-based negative encoding (so arg 0 is -1
> rather than 0), which augment_arg() decodes with index = -(size + 1).

would be good to have some comment here or there about it.
 
> > Since we have it there already and we may not have BTF and BTF isn't yet
> > a hard requirement, we leave the fallbacks in place for the time being?
 
> Agreed, keeping the fallbacks for now makes sense. (Also, in
> trace__bpf_sys_enter_beauty_map(), only the struct/union size lookup
> actually uses trace->btf; strings, buffers and sockaddr only use the
> tracepoint format fields, so moving the trace->btf check into the
> bt->size branch would let those work without BTF too.)
 
> > I guess that clamp can be made bigger, 64 maybe? Applying the series
> > now.
> [ ... ]
> > And copying the sockaddr parameters according to its addrlen or the cap
> > in the augmented bpf, that probably needs to be a bit bigger for local
> > sockets:
> >
> >   ⬢ [acme@toolbx perf-tools-next]$ echo -n /var/run/.heim_org.h5l.kcm-soc | wc -c
> >   30
> >   ⬢ [acme@toolbx perf-tools-next]$ ls -la /var/run/.heim_org.h5l.kcm-socket
> >   srw-rw-rw-. 1 nobody nobody 0 Sep 14 23:13 /var/run/.heim_org.h5l.kcm-socket
 
> Right, 32 bytes is 2 bytes of sa_family plus 30 bytes of sun_path, so
> "/var/run/.heim_org.h5l.kcm-socket" lost its last 3 characters.
> augmented_arg->value already has room for PATH_MAX (4096) bytes, so
> raising TRACE_AUG_MAX_BUF to 64 (or 128, i.e. SS_MAXSIZE, which covers
> all 110 bytes of struct sockaddr_un) works without changing the map
> layout. Since syscall_arg__scnprintf_buf() prints all
> augmented_arg->size bytes for write(), if we want to keep write()
> buffers at 32 bytes while giving sockaddr up to 128 bytes, we could
> either cap syscall_arg__scnprintf_buf() at 32 or use a separate
> negative range in beauty_array for sockaddr. Happy to send a follow-up
> patch whichever way you prefer.

I think we need to cover the max size for sockaddr since it doesn't add
space costs to what we have already, if we want to have a shorter, by
default, capture for write, then we need another knob for that, one that
applies to write and other user->kernel typeless payloads.

Thanks,

- Arnaldo
