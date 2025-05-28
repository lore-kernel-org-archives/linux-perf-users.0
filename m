Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC722127B;
	Wed, 28 May 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471039; cv=none; b=svvh6U+KAZYSYu2BebaGVKoDo09PICpNhF9UHqqx1mpsb9HQAm9vFDDhbeFKIMJ56KFz8FabGYuBjYaxe0yFZglbFd8FIhlnRaFWW6azNXx6TnXK7+f6RLcWgOKxhD2yUDdfb+vkLdQLfT4Kxk5vcUjwMXg3GxwnawY/jXIbLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471039; c=relaxed/simple;
	bh=Ybhp3KvNqPkgBfetx6MH61FR5XoPqg2KSxi54T8oRy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYopTwI7WtoVekTZJzUzthgEiULd+ra20PKpGMn6Yg8ziAaHLeMhIFT/cP0GcVxPeUWAIveQHLqNRoAcPrD5R+7KpWeDxGLLgamA1P+ejVoFgQvwfrl2NjhNF0ZsjA9pJ8ipaUcqd5K/rOfYoiJOgH04sDIT+y6kU5Omjq8Jgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI3BvqKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI3BvqKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE06BC4CEE3;
	Wed, 28 May 2025 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471038;
	bh=Ybhp3KvNqPkgBfetx6MH61FR5XoPqg2KSxi54T8oRy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DI3BvqKvDHOL8hbxfTDxCmcgtPoP3QxXF27xi4/sprQMbiT8hH1zqpPkkZ9ujWtG4
	 T47mwBmX3Qno7FcJMu8JDwI1oyHjc1KSClZt/MXXfhzT0Nb+oPwVzLHbOJkqerq98Q
	 gMyJHzW0fQLSe6m/gIjKKNY0a+SFlWW3STbiTPcqa8mHXdrAgCQGCK4tIXCMZcWevs
	 nuBWZaeidxEgYBe07Q4JV/J/ZrSUxam8RygVj9VPgTFSAt8avgPZtFNFPPowPj2l/U
	 ipZ2IBIMKcfCY9Bdgl8HmZETeL1C9bVuF7gL4dGqx8YVNT5KSSScdDZkTXVjVWJNyl
	 hnNeP2QMwOdDA==
Date: Wed, 28 May 2025 15:23:56 -0700
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
Message-ID: <aDeM_OlCkNUBDkis@google.com>
References: <20250528032637.198960-1-irogers@google.com>
 <20250528032637.198960-5-irogers@google.com>
 <aDdNk1IOqtyM44AX@google.com>
 <CAP-5=fUmrnOUOBWcypD=Q7bCSQ3HTnicRXhr8nmSRqcbZv7Mmw@mail.gmail.com>
 <aDdua_Kp6Dz91xwm@google.com>
 <CAP-5=fW17hJkTCEu6pCwN1CoEVHQAmVggi=wLwcNcM_dbeVAAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW17hJkTCEu6pCwN1CoEVHQAmVggi=wLwcNcM_dbeVAAg@mail.gmail.com>

On Wed, May 28, 2025 at 01:44:36PM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 1:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 28, 2025 at 11:02:44AM -0700, Ian Rogers wrote:
> > > On Wed, May 28, 2025 at 10:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Tue, May 27, 2025 at 08:26:34PM -0700, Ian Rogers wrote:
> > > > > Reading through the evsel->evlist may seg fault if a sample arrives
> > > > > when the evlist is being deleted. Detect this case and ignore samples
> > > > > arriving when the evlist is being deleted.
> > > > >
> > > > > Fixes: bcfab08db7fb ("perf intel-tpebs: Filter non-workload samples")
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/util/intel-tpebs.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> > > > > index 4ad4bc118ea5..3b92ebf5c112 100644
> > > > > --- a/tools/perf/util/intel-tpebs.c
> > > > > +++ b/tools/perf/util/intel-tpebs.c
> > > > > @@ -162,9 +162,17 @@ static bool is_child_pid(pid_t parent, pid_t child)
> > > > >
> > > > >  static bool should_ignore_sample(const struct perf_sample *sample, const struct tpebs_retire_lat *t)
> > > > >  {
> > > > > -     pid_t workload_pid = t->evsel->evlist->workload.pid;
> > > > > -     pid_t sample_pid = sample->pid;
> > > > > +     pid_t workload_pid, sample_pid = sample->pid;
> > > > >
> > > > > +     /*
> > > > > +      * During evlist__purge the evlist will be removed prior to the
> > > > > +      * evsel__exit calling evsel__tpebs_close and taking the
> > > > > +      * tpebs_mtx. Avoid a segfault by ignoring samples in this case.
> > > > > +      */
> > > > > +     if (t->evsel->evlist == NULL)
> > > > > +             return true;
> > > > > +
> > > > > +     workload_pid = t->evsel->evlist->workload.pid;
> > > >
> > > > I'm curious if there's a chance of TOCTOU race.  It'd certainly help
> > > > the segfault but would this code prevent it completely?
> > >
> > > Good point. I think the race is already small as it doesn't happen
> > > without sanitizers for me.
> > > Thinking about the evlist problem. When a destructor (evlist__delete)
> > > it is generally assumed the code is being single threaded and in C++
> > > clang's -Wthread-safety will ignore destructors for this reason
> > > (annoying imo as it hides bugs). I don't see a good way to solve that
> > > for the evlist and evsel for the TPEBS case without using reference
> > > counting. Adding reference counts to evlist and evsel would be do-able
> > > as we could use reference count checking, but it would be a large and
> > > invasive change. Wdyt?
> >
> > Would it be possible to kill the TPEBS thread before deleting evlist?
> 
> The TPEBS thread and other data structures are global and not tied to
> the evlist, so there can and are multiple evlists at play. When using
> TPEBS there is the evlist for perf stat, there is also the evlist for
> the samples. There's sense in having the evlist own the TPEBS data
> structures, there's also sense in things being global. I think if I'd
> done it I'd have gone with TPEBS within the evlist, but I suspect in
> the original changes there was a worry about adding cost on non-x86
> builds.

Ok, I thought deleting evlist is quite late in the execution and it may
be easy to make the change.  If not, let's see how the current fix will
work before going further. :)

Thanks,
Namhyung

