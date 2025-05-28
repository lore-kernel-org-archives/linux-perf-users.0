Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870F20125F;
	Wed, 28 May 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463214; cv=none; b=T1BHbXRHBX2yMumSLi734XvmsnNQp+2OvRPK04iwZpb1nuPPhro/cw5ROlOROTnHctsQNcKyrmhAQxguhvgFUc5eQm6OelCV348UZfDoQ4oTIuW0RX6x/Q6Fl3S59uQYez1cKASt2W9XRWsaz0HQOcAxh9tLL/N2oDOlXU/Qlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463214; c=relaxed/simple;
	bh=H/q7p0NOjUgTX/uIjMDeBfLzozjaxRdEErrF+u5VULw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6jY6uYC3WdWqZtWaO6oahIFc5wKi/8DNW6Uj6wSW0/P7W3O601cHe1h7KkFg3g0t5+k7V45/nuDVL9ASu87cpfl4Sg8V+cgLCpfTq/4IU2PLy+gkrAqa99KUq5WVBoXgV2HmqcTlKVjPsGjYG/YVMTLU/TBqNlmq8+Dcqk3CSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuPk+UZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuPk+UZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A943AC4CEE3;
	Wed, 28 May 2025 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748463214;
	bh=H/q7p0NOjUgTX/uIjMDeBfLzozjaxRdEErrF+u5VULw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuPk+UZVYlNH/Be9UX72m/FQN/N5v2WzcINgv//zzn+OGIedhffD5LOV98DpPytgK
	 +iMwC9jAZDJa6AHqXZ/6KqFnBuwVzkt/S2wh4FgnqY7FOQNtm+rzZdsdjdVAJOAxCo
	 fY0HyX+pbyU49fD2/qoeN5mtZjfEPi0LOteeaDnDYBeF2ZAttZVDkoGaCuHey5yv0L
	 7STL96gz9tnFUr6C8fb+OSJUsiL8WTZ+S+ErEbUtjw4iVbNI6iYm+k0iGjuVwrOUx9
	 JwQDOaq5uGza9OJr/6urI6uqKaXfbbSuIvzlgYbEeCejXWwrE/eL2WjfyL+VR9mZDK
	 XK/QHTAJu5jow==
Date: Wed, 28 May 2025 13:13:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] perf intel-tpebs: Avoid race when evlist is being
 deleted
Message-ID: <aDdua_Kp6Dz91xwm@google.com>
References: <20250528032637.198960-1-irogers@google.com>
 <20250528032637.198960-5-irogers@google.com>
 <aDdNk1IOqtyM44AX@google.com>
 <CAP-5=fUmrnOUOBWcypD=Q7bCSQ3HTnicRXhr8nmSRqcbZv7Mmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUmrnOUOBWcypD=Q7bCSQ3HTnicRXhr8nmSRqcbZv7Mmw@mail.gmail.com>

On Wed, May 28, 2025 at 11:02:44AM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 10:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 27, 2025 at 08:26:34PM -0700, Ian Rogers wrote:
> > > Reading through the evsel->evlist may seg fault if a sample arrives
> > > when the evlist is being deleted. Detect this case and ignore samples
> > > arriving when the evlist is being deleted.
> > >
> > > Fixes: bcfab08db7fb ("perf intel-tpebs: Filter non-workload samples")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/intel-tpebs.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> > > index 4ad4bc118ea5..3b92ebf5c112 100644
> > > --- a/tools/perf/util/intel-tpebs.c
> > > +++ b/tools/perf/util/intel-tpebs.c
> > > @@ -162,9 +162,17 @@ static bool is_child_pid(pid_t parent, pid_t child)
> > >
> > >  static bool should_ignore_sample(const struct perf_sample *sample, const struct tpebs_retire_lat *t)
> > >  {
> > > -     pid_t workload_pid = t->evsel->evlist->workload.pid;
> > > -     pid_t sample_pid = sample->pid;
> > > +     pid_t workload_pid, sample_pid = sample->pid;
> > >
> > > +     /*
> > > +      * During evlist__purge the evlist will be removed prior to the
> > > +      * evsel__exit calling evsel__tpebs_close and taking the
> > > +      * tpebs_mtx. Avoid a segfault by ignoring samples in this case.
> > > +      */
> > > +     if (t->evsel->evlist == NULL)
> > > +             return true;
> > > +
> > > +     workload_pid = t->evsel->evlist->workload.pid;
> >
> > I'm curious if there's a chance of TOCTOU race.  It'd certainly help
> > the segfault but would this code prevent it completely?
> 
> Good point. I think the race is already small as it doesn't happen
> without sanitizers for me.
> Thinking about the evlist problem. When a destructor (evlist__delete)
> it is generally assumed the code is being single threaded and in C++
> clang's -Wthread-safety will ignore destructors for this reason
> (annoying imo as it hides bugs). I don't see a good way to solve that
> for the evlist and evsel for the TPEBS case without using reference
> counting. Adding reference counts to evlist and evsel would be do-able
> as we could use reference count checking, but it would be a large and
> invasive change. Wdyt?

Would it be possible to kill the TPEBS thread before deleting evlist?

Thanks,
Namhyung

