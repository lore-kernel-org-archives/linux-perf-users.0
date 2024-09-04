Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B11E132F;
	Wed,  4 Sep 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471967; cv=none; b=qLjQKUDtmZRlQUzGxg8hzY/uqeuG4QjusGLsblsy8ZByhu6Pw/+PJC+e98me9kNW+V/qZGmxnIYKrk2JNL/O7IOqa7i1eEMRFM8yfax9Bil8kUTiimtyjHy3IvNv0V8uznx+gYSovjALz7xXARA9XGErAlYW778YI2exZaTJHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471967; c=relaxed/simple;
	bh=irxYBNFy4EClqg+5d7p7Vn8xZAMgVMf7T7CNAtDKyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8LdK5OHeLslGJts3qnhIHwHzszkVpMxTuQWB4QJcz9aRQ/y1erCnGOalMX/hCVQUR9mlitODgMVzB/eWsbMxTJVTtCs6oKIUKC/RjKCcRBNEbE0Tvb1TO4o5Vw8zKc5f2NcOmI39uAbqvSNNYDsDfA0JLess/6uioZGf3h0NvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfA/i04C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfA/i04C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53720C4CEC2;
	Wed,  4 Sep 2024 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725471966;
	bh=irxYBNFy4EClqg+5d7p7Vn8xZAMgVMf7T7CNAtDKyzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfA/i04C1wzL9s43385zxc0pEM8iayfJ/cy+nOLorVz6Ju7drxZwXi9OcvCZYhikQ
	 CkGgMsNkTJx9ETcqUBSGkiiTfrqJt0VF63GA7HcPeP10u/xvGCZekMfll+2qJ6pffX
	 DjXfDc0iNl2GKe393+LHOkM9NqSXC7VfnWKcdZDXtcEQUgguU+wVLY8/8Rizj4TCOy
	 02Q6J0svWqNjawI9IjZcDNN/CRP8tY/r5x/OX0pUA2z9RaTyk6fZeQPg1OqaLq9wEs
	 qP2Y1isVBlZHYXzAwFVMLAZrxEF8LlOgoJlZGUuC7/DsEssM8TO7il/3LG73MsKh7j
	 mqbPidgyt9s2w==
Date: Wed, 4 Sep 2024 10:46:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [RFC/PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v2)
Message-ID: <Ztic3BR4UUdhIVrq@google.com>
References: <20240904064131.2377873-1-namhyung@kernel.org>
 <CAP-5=fU5UeHER5hPAUhq_9_fSUR9okp_i0sOk_E7Q_aZkvo+DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU5UeHER5hPAUhq_9_fSUR9okp_i0sOk_E7Q_aZkvo+DQ@mail.gmail.com>

Hi Ian,

On Wed, Sep 04, 2024 at 09:36:02AM -0700, Ian Rogers wrote:
> On Tue, Sep 3, 2024 at 11:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > I found perf tools set exclude_guest bit inconsistently.  It used to
> > set the bit but now the default event for perf record doesn't.  So I'm
> > wondering why we want the bit in the first place.
> >
> > Actually it's not good for PMUs don't support any exclusion like AMD
> > IBS because it disables new features after the exclude_guest due to
> > the missing feature detection logic.
> 
> I think trying to clean this up is good but there's a wac-a-moie
> problem whenever a default or fallback is changed - it can break a
> hard to test platform in unthought of ways. I wonder if we can expand
> PMU testing to at least capture the differences in behavior. For

Right, that's why I use a software event to test kernel features and
separate branch stack, precise_ip and excludes testing.


> example, pick an event that works, like legacy cycles, then increase
> the precision to 3 and the event should either open again or fail with
> EINVAL, if it opens then it should count. Similarly for the exclude_*

But sometimes precision and exclude_* interfere each other.  AMD IBS
accepts precise_ip up to 2 but it'd fail if exclude_guest is set.  And
sometimes the same PMU requires different exclude bits.  For instance,
Intel branch stack sampling needs exclude_hv as well as exclude_kernel
for regular users, but normally it is enough to have exclude_kernel
for other events.

I agree that we need to save this info to per-PMU and reuse it for
other events.  Actually I tried this but failed to get it working.
IIRC sometimes legacy events don't have evsel->pmu and looking up a
PMU for the evsel failed to get a correct PMU.  Also I couldn't come
up with an absolute way to make sure if it checks the PMU features
100% correct.  I think I need to add something to the kernel to show
supported (and required?) PMU exclude_* capabilities.

Maybe we can revisit this later, but having the missing kernel feature
checks separate from the PMU specific checks is an improvement IMHO.
Also having another fallback for exclude_guest would fix an existing
problem on Apple M1.


> bits. I think some PMUs don't behave like they should and we can add
> ifs to the test to capture these behaviours - for example an
> exclude_.. is accepted for an event but then the event doesn't count
> if the bit is set. There are many cases where a large group of events

So I want to start from no exclude_* and to add a bit at a time until
the PMU accepts the event so that it won't have unnecessary bits.

Thanks,
Namhyung


> will cause the group to stop counting, in metrics we work around this
> with grouping flags for the metric:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/pmu-events.h?h=perf-tools-next#n16
> but these shouldn't be necessary as the PMU kernel driver should
> reject the perf_event_open.
> 
> Thanks,
> Ian
> 
> > v2 changes)
> >  * update the missing feature detection logic
> >  * separate exclude_hv fallback
> >  * add new fallback for exclude_guest
> >
> > v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
> >
> > AFAIK it doesn't matter for the most cases but perf kvm.  If users
> > need to set the bit, they can still use :H modifier.  For vPMU pass-
> > through or Apple M1, it'd add the exclude_guest during the fallback
> > logic.  Please let me know if it's ok for you.
> >
> > The code is available at 'perf/exclude-v2' branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (8):
> >   perf tools: Don't set attr.exclude_guest by default
> >   perf tools: Simplify evsel__add_modifier()
> >   perf stat: Add --exclude-guest option
> >   perf tools: Do not set exclude_guest for precise_ip
> >   perf tools: Detect missing kernel features properly
> >   perf tools: Separate exclude_hv fallback
> >   perf tools: Add fallback for exclude_guest
> >   perf tools: Check fallback error and order
> >
> >  tools/perf/Documentation/perf-stat.txt      |   7 +
> >  tools/perf/builtin-kvm.c                    |   1 +
> >  tools/perf/builtin-stat.c                   |   2 +
> >  tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
> >  tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
> >  tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
> >  tools/perf/tests/parse-events.c             |  30 +-
> >  tools/perf/util/evsel.c                     | 393 ++++++++++++++------
> >  tools/perf/util/evsel.h                     |   1 -
> >  tools/perf/util/parse-events.c              |   6 +-
> >  tools/perf/util/util.c                      |  10 +-
> >  tools/perf/util/util.h                      |   3 +
> >  12 files changed, 322 insertions(+), 137 deletions(-)
> >
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >
