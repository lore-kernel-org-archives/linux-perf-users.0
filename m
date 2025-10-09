Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E1262FD3;
	Thu,  9 Oct 2025 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989087; cv=none; b=a3f2pDVxuko7oaEjshoKfElHct/7leMbQ9zahR1Br25qapZyPLUy1E7qlnAXaV+EPJ0Ktkm+m+X3+GeDwsSMq3peZmqSEQQY37PmksKmJgmay1wpClp1ZyOWOEJca8XYfSlGp/GBQUZ5bVQbEBNVJ3RTk3enYNaT9QJHhNjsiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989087; c=relaxed/simple;
	bh=BOuoov5UaCWQ7f+U6VJXu4q09HPgNoOO7XKkcmRmmCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGv7HTxmPJmxd3g2cATgBmpEWcBXbNWp+CqckieCwidrhciBHF3c5STJQv3kKXRErKBDzvuKSiq+1jFYbgXuToFtcCEv5sL8XT5kdP7uwAHhE7bYvE39xFYYtxSTMEaS6LszypOJY/9MfWRQLKE6NqaTcfmD2HAqx7ZT3jQFrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDokne8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDokne8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B7EC4CEF7;
	Thu,  9 Oct 2025 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759989087;
	bh=BOuoov5UaCWQ7f+U6VJXu4q09HPgNoOO7XKkcmRmmCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDokne8gTwqMm6cxcqchRXArJJ6OayhRrApiA6hmx31qM8Syvh353znRrpXFwem/N
	 W4YkVvT5vFqg0ewZ2YAxjB88BSNkFERJqAvsO8Nvsp+s/sF7k1eksTZCUOUutLMV4R
	 I3bknTAN6DFgjcn4v25O3JvyVWSlZZdA1o6VBZ5O40SW6gMDp/Iq7yJ29JPiY4JAL/
	 d8qwxe4Fdtwg5e46XeeIO1LKO8hlNwczSNd+Cjvvv1r9Hs4tJNP/gTx+kUjF1+B6k3
	 EFo8CHhbbOw1j4klFnLepfr+9GT6nRTZgTyWEiHNG6y68UawRILBFfYHcyOBLvUuUj
	 AQ0gYe+8efIBQ==
Date: Thu, 9 Oct 2025 14:51:22 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Additional verbose details for <not
 supported> events
Message-ID: <aOdNWrIAQMkaVsqR@google.com>
References: <20251005181421.2787960-1-irogers@google.com>
 <aOYkRdU5pn_jTOq3@google.com>
 <CAP-5=fUqYeaE_P3ApXvq7j9SRuNXpLf+mK-4XBsvv2R=OTccbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUqYeaE_P3ApXvq7j9SRuNXpLf+mK-4XBsvv2R=OTccbQ@mail.gmail.com>

On Wed, Oct 08, 2025 at 09:31:53AM -0700, Ian Rogers wrote:
> On Wed, Oct 8, 2025 at 1:43 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sun, Oct 05, 2025 at 11:14:21AM -0700, Ian Rogers wrote:
> > > If an event shows as "<not supported>" in perf stat output, in verbose
> > > mode add the strerror output to help diagnose the issue.
> > >
> > > Consider:
> > > ```
> > > $ perf stat -e cycles,data_read,instructions true
> > >
> > >  Performance counter stats for 'true':
> > >
> > >            357,457      cycles:u
> > >    <not supported> MiB  data_read:u
> > >            156,182      instructions:u                   #    0.44  insn per cycle
> > >
> > >        0.001250315 seconds time elapsed
> > >
> > >        0.001283000 seconds user
> > >        0.000000000 seconds sys
> > > ```
> > >
> > > To understand why the data_read uncore event failed, with this change:
> > > ```
> > > $ perf stat -v -e cycles,data_read,instructions true
> > > Using CPUID GenuineIntel-6-8D-1
> > > cycles -> cpu/cycles/
> > > data_read -> uncore_imc_free_running_0/data_read/
> > > data_read -> uncore_imc_free_running_1/data_read/
> > > instructions -> cpu/instructions/
> > > Control descriptor is not initialized
> > > Warning:
> > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > Warning:
> > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > Warning:
> > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > Warning:
> > > data_read:u event is not supported by the kernel.
> > > Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> > > Warning:
> > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > Warning:
> > > data_read:u event is not supported by the kernel.
> > > Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> > > cycles:u: 351621 362833 362833
> > > failed to read counter data_read:u
> > > failed to read counter data_read:u
> > > instructions:u: 156184 362833 362833
> > >
> > >  Performance counter stats for 'true':
> > >
> > >            351,621      cycles:u
> > >    <not supported> MiB  data_read:u
> > >            156,184      instructions:u                   #    0.44  insn per cycle
> > >
> > >        0.001584472 seconds time elapsed
> > >
> > >        0.001811000 seconds user
> > >        0.000000000 seconds sys
> > > ```
> > > where without this change only "data_read:u event is not supported by
> > > the kernel." is shown.
> >
> > I think what you say is:
> >
> > Before:
> >   data_read:u event is not supported by the kernel.
> >
> > After:
> >   data_read:u event is not supported by the kernel.
> >   Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> 
> I kept things verbose as unfortunately the
> "kernel.perf_event_paranoid=2" is important as is the use of
> per-thread mode. Different paranoia levels lead to different errors
> and unfortunately a lot of the time the error gets reported as "
> data_read:u event is not supported by the kernel." and I'm not sure
> all users will get that the key part there is the :u modifier.

Yep, I'm ok with the change.  But the changelog was a bit unclear what
is being added exactly.  IIUC we already have the paranoid message with
the verbose level 1.


> However, fixing  evsel__open_strerror wasn't in scope for this change.

Sure, we can handle that separately.

Thanks,
Namhyung

> 
> > Off-topic, it'd be great if we reduce the number of the same warning
> > messages.  I think the data_read is from two uncore PMUs so the message
> > was repeated.  If we can connect the related evsels and show the
> > messages once, then the output is more readable.  Maybe we also want to
> > show the fallback message just once (globally).
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 7006f848f87a..84e06ec09cc2 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -624,8 +624,9 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
> > >        */
> > >       if (err == EINVAL || err == ENOSYS || err == ENOENT || err == ENXIO) {
> > >               if (verbose > 0) {
> > > -                     ui__warning("%s event is not supported by the kernel.\n",
> > > -                                 evsel__name(counter));
> > > +                     evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
> > > +                     ui__warning("%s event is not supported by the kernel.\n%s\n",
> > > +                                 evsel__name(counter), msg);
> > >               }
> > >               return COUNTER_SKIP;
> > >       }
> > > @@ -649,10 +650,11 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
> > >               }
> > >       }
> > >       if (verbose > 0) {
> > > +             evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
> > >               ui__warning(err == EOPNOTSUPP
> > > -                     ? "%s event is not supported by the kernel.\n"
> > > -                     : "skipping event %s that kernel failed to open.\n",
> > > -                     evsel__name(counter));
> > > +                     ? "%s event is not supported by the kernel.\n%s\n"
> > > +                     : "skipping event %s that kernel failed to open.\n%s\n",
> > > +                     evsel__name(counter), msg);
> > >       }
> > >       return COUNTER_SKIP;
> > >  }
> > > --
> > > 2.51.0.618.g983fd99d29-goog
> > >
