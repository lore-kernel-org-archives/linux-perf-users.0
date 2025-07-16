Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F429B778
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694563; cv=none; b=g07oyOdUF6SgzBlULTM7kYLQdP8tPKLKTD3Iu8VwLCHRhyIqVldPC4kiwsRKtr0syEzH0lQfNUWxo5Z6d9uQOMIRVWdgdW74q7Rbe/R9gn0F0AJ1v//bZaXHe40qjU+81m9vI4hkOJ/6jOIeiGK+IduBlfmCufa+iymEknNx4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694563; c=relaxed/simple;
	bh=c/atSN3Z2FI7M4WDOFgAqgC7FXC3zTbOpIohX9ldXPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKNVGYjRkTIBLGx+H5rWhvhtFItf9CKIH1U1oTXh3Hv8FyTSHK+wWr4QTYMQPWoORbF3rAyMFabW/RnoZ00i6KH2zp+Uvh8mT+9pkfKstG6fO162IcVkHyVSuqXagpvEQMkRDjGlqaYSboR/QzEQgAUoONXAdVb78fv+4liyypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQesbcTX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQesbcTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A9FC4CEE7;
	Wed, 16 Jul 2025 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694562;
	bh=c/atSN3Z2FI7M4WDOFgAqgC7FXC3zTbOpIohX9ldXPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQesbcTX2tJUPDpadTdMvBDA0hanCTL9XkJqkbVKVlK9KdgjNFznrh/0rq+4JRdEx
	 9UPC2hgS8CD8bTb1bpKksBSbKhVOS+rVVQIAmIxUJG60QYsXHtfTPytz/YSn0OcwU5
	 NiHpi5rUmhNqU22+gZ93a8ziz3jCmHRz9lbopsGYqiIAHGGzjl/u8kzGpDsiT+Gx7G
	 QvmzCb+jyTvdDy06NmnBk1xcM/cH3wDlsl3lGf2h5vq5IEVTRKFX1/eiz6JHNIBZOh
	 DNPVBquOFIA46fdFCXENF2ScY5bDieyw34yoeKA1nWL2263W80Gk/zCWdLz6tc8NYl
	 YBPc7GhqED2WQ==
Date: Wed, 16 Jul 2025 12:36:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf sched timehist: decode process names of processes
 in zombie state
Message-ID: <aHf_IDvsyOubNm24@google.com>
References: <20250709143119.91147-2-ashelat@redhat.com>
 <aHFtzFZEvCp0B6V2@google.com>
 <CA+G8DhKB3H-nNyKNmgOd_uj-YnfBTS8pSz6dFqZ5+gnxf-z7oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G8DhKB3H-nNyKNmgOd_uj-YnfBTS8pSz6dFqZ5+gnxf-z7oQ@mail.gmail.com>

On Tue, Jul 15, 2025 at 11:59:29AM -0400, Anubhav Shelat wrote:
> When I tried to build, it threw the error:
> 
> builtin-sched.c: In function ‘timehist_print_sample’:
> builtin-sched.c:2186:29: error: declaration of ‘prev_comm’ shadows a
> previous local [-Werror=shadow]
>  2186 |                 const char *prev_comm = evsel__strval(evsel,
> sample, "prev_comm");
>       |                             ^~~~~~~~~
> builtin-sched.c:2154:21: note: shadowed declaration is here
>  2154 |         const char *prev_comm = evsel__strval(evsel, sample,
> "prev_comm");
>       |                     ^~~~~~~~~
> builtin-sched.c:2154:21: error: unused variable ‘prev_comm’
> [-Werror=unused-variable]

Yep, you need to delete the old code.

Thanks,
Namhyung

> 
> On Fri, Jul 11, 2025 at 4:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Jul 09, 2025 at 10:31:20AM -0400, Anubhav Shelat wrote:
> > > Previously when running perf trace timehist --state, when recording
> > > processes in the zombie state the process name would not be decoded
> > > properly and appears with just the PID:
> > >
> > > 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
> > > 1140057.412222 [0012]  :1248612[1248612]                   0.000      0.000      0.332      Z
> > > 1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
> > > 1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
> > > 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S
> > >
> > > Now some extra processing has been added to decode the process name:
> > >
> > > 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
> > > 1140057.412222 [0012]  sleep[1248612]                      0.000      0.000      0.332      Z
> > > 1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
> > > 1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
> > > 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S
> >
> > Thanks for the fix.  A nitpick below.
> >
> > >
> > > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > > ---
> > >  tools/perf/builtin-sched.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > > index 26ece6e9bfd1..e1a931341bc8 100644
> > > --- a/tools/perf/builtin-sched.c
> > > +++ b/tools/perf/builtin-sched.c
> > > @@ -2023,11 +2023,15 @@ static int comm_width = 30;
> > >  static char *timehist_get_commstr(struct thread *thread)
> > >  {
> > >       static char str[32];
> > > -     const char *comm = thread__comm_str(thread);
> > > +     char *comm = (char *) thread__comm_str(thread);
> > > +     char *empty = (char *) "";
> > >       pid_t tid = thread__tid(thread);
> > >       pid_t pid = thread__pid(thread);
> > >       int n;
> > >
> > > +     if (*comm == ':')
> > > +             comm = empty;
> > > +
> > >       if (pid == 0)
> > >               n = scnprintf(str, sizeof(str), "%s", comm);
> > >
> > > @@ -2147,6 +2151,8 @@ static void timehist_print_sample(struct perf_sched *sched,
> > >       struct thread_runtime *tr = thread__priv(thread);
> > >       const char *next_comm = evsel__strval(evsel, sample, "next_comm");
> > >       const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
> > > +     const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
> > > +     char *comm_str = timehist_get_commstr(thread);
> > >       u32 max_cpus = sched->max_cpu.cpu + 1;
> > >       char tstr[64];
> > >       char nstr[30];
> > > @@ -2173,8 +2179,15 @@ static void timehist_print_sample(struct perf_sched *sched,
> > >               }
> > >               printf(" ");
> > >       }
> > > -
> > > -     printf(" %-*s ", comm_width, timehist_get_commstr(thread));
> > > +
> > > +     /* if a process is in zombie state commstr will start with a '[' and
> > > +      * we need to do extra processing to decode the process name */
> > > +     if (*comm_str == '[') {
> > > +             printf(" %s", evsel__strval(evsel, sample, "prev_comm"));
> > > +             printf("%-*s ", comm_width - (int) strlen(prev_comm), comm_str);
> > > +     }
> > > +     else
> > > +             printf(" %-*s ", comm_width, comm_str);
> >
> > What about just updating thread comm if it's missing?
> >
> >         if (!thread__comm_set(thread)) {
> >                 const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
> >                 thread__set_comm(thread, prev_comm, sample->time);
> >         }
> >
> >         printf(" %-%s ", comm_width, timehist_get_commstr(thread));
> >
> > Thanks,
> > Namhyung
> >
> > >
> > >       if (sched->show_prio)
> > >               printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
> > > --
> > > 2.50.0
> > >
> >
> 
