Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419D770EC;
	Wed, 26 Jun 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375217; cv=none; b=XJ+9PqtJx0kj74fPy8GNWI52ZFJItYttdMdApqHCDIoN96sHe8DFkha0DAFu0HoexCeAgPL4XM5HRPNL4KhLuc8XjHLEmNOfUUQ9qJKl+HRWYXWmaQ2VCp9KnvlRuVscrZqh9v1IazukhwQUYL+0zizkdDCAuh1w2kLSGRyuaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375217; c=relaxed/simple;
	bh=UPDHBoCVzIDbFSBsqoVLTZDNXdQT2C1pQXnDIU9g8W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2y2EaUhKhFAtIcjN76OwxVAlhtdRTQZK6YpJPs6187f8L/zH0fl0DEJ1MmhHaYhTnknN1PvbJPKEFtjdxRmbmMn5fdsbiNsByCX770s5YX7rMlN9XUZZwyAavOpJ9VL7qNFGuzXEPAxuQRRbvrJoFgXx40pfTWegoobi42fMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/xsreQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/xsreQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE5C4AF09;
	Wed, 26 Jun 2024 04:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719375216;
	bh=UPDHBoCVzIDbFSBsqoVLTZDNXdQT2C1pQXnDIU9g8W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/xsreQgKVu5MkLMmwJBFtSwww4pLUOdcK8efxwjYC4mi2A1sXv1/gM00IOtPlcsS
	 /BrIbE3cBLqO2UFNKmlP2IwZvRFcUwbhprxvfJiT4zPEtiqdAvE8IuZIPdcw+qFqdj
	 pfTI+aAjx2JxhuEh7g/yQzlVVKD/gU5QhLl/6RxBkUgbX9NjGeZIwvQ3MhRrhVZ4cA
	 uLEjr4XoqDtQ9ES6N483gy3cpemSCxCNW0r9sm7bQsT9EZV2XTNKwlrpLvVANEUsGh
	 hZo9WhA5dlQ7PN42+z1EynGIkb2yMoLCs1ytZ5URG+y0fmnePS9vd8yJS5FyM21mcb
	 zS/N5wNE1ohrw==
Date: Tue, 25 Jun 2024 21:13:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf pmu: Restore full PMU name wildcard support
Message-ID: <ZnuVbnOyXmjT4Njo@google.com>
References: <20240617134348.208241-1-james.clark@arm.com>
 <20240617134348.208241-2-james.clark@arm.com>
 <CAP-5=fUZkAs9h+fLiJOeL9p_K3auQcn30mXvXZWRYMchmT9ZPA@mail.gmail.com>
 <b2008905-686b-4494-a10d-c3357cce91da@arm.com>
 <CAP-5=fUkZnG0gaJ_76Azn643DXZSq9xhpX=+U6Mjhtnko8PyLw@mail.gmail.com>
 <197e62e3-d34a-442a-97cf-6edf6c8c013f@arm.com>
 <CAP-5=fVqf0B+Fs8vSAvyPf7UpUo1U8HMkDbgb3csJ4s0O1kiog@mail.gmail.com>
 <fa69d868-5229-4ea2-b32e-c7928706d27a@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa69d868-5229-4ea2-b32e-c7928706d27a@arm.com>

On Tue, Jun 18, 2024 at 04:47:01PM +0100, James Clark wrote:
> 
> 
> On 18/06/2024 16:25, Ian Rogers wrote:
> > On Tue, Jun 18, 2024, 8:06 AM James Clark <james.clark@arm.com> wrote:
> > 
> >>
> >>
> >> On 18/06/2024 15:23, Ian Rogers wrote:
> >>> On Tue, Jun 18, 2024, 3:59 AM James Clark <james.clark@arm.com> wrote:
> >>>
> >>>>
> >>>>
> >>>> On 17/06/2024 22:25, Ian Rogers wrote:
> >>>>> On Mon, Jun 17, 2024, 6:44 AM James Clark <james.clark@arm.com> wrote:
> >>>>>
> >>>>>> Commit b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in
> >> dynamic
> >>>>>> pmu events") gives the following example for wildcarding a subset of
> >>>>>> PMUs:
> >>>>>>
> >>>>>>   E.g., in a system with the following dynamic pmus:
> >>>>>>
> >>>>>>         mypmu_0
> >>>>>>         mypmu_1
> >>>>>>         mypmu_2
> >>>>>>         mypmu_4
> >>>>>>
> >>>>>>   perf stat -e mypmu_[01]/<config>/
> >>>>>>
> >>>>>> Since commit f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()"),
> >> only
> >>>>>> "*" has been supported, removing the ability to subset PMUs, even
> >> though
> >>>>>> parse-events.l still supports ? and [] characters.
> >>>>>>
> >>>>>> Fix it by using fnmatch() when any glob character is detected and add
> >> a
> >>>>>> test which covers that and other scenarios of
> >>>>>> perf_pmu__match_ignoring_suffix().
> >>>>>>
> >>>>>> Fixes: f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()")
> >>>>>> Signed-off-by: James Clark <james.clark@arm.com>
> >>>>>>
> >>>>>
> >>>>> We use regular expression matching elsewhere rather than fnmatch. We
> >> can
> >>>>> also precompile the matchers using lex. I'm not sure we shouldn't be
> >>>>> looking for an opportunity to remove fnmatch rather than expand upon
> >> it.
> >>>>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>
> >>>> Presumably you mean we can do the removal of fnmatch after this fix goes
> >>>> in,
> >>>> rather than instead of? Because this is a user facing change in
> >> behaviour
> >>>> but the removal of fnmatch would be an non-user facing code refactor?
> >>>>
> >>>> It's technically not an "expansion" because we always used fnmatch and
> >> the
> >>>> linked commit hasn't made it to a release yet.
> >>>>
> >>>
> >>> The main place the expansion gets added is parse-events.c, previously
> >>> parse-events.y. If we're adding the expansion ourselves then we can
> >> choose
> >>> the form we add it. Some coming servers will have 100s of PMUs and so I'm
> >>> worried about the scanning cost when a PMU isn't specified.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>
> >> I think I might not be following. If a PMU isn't specified then
> >> perf_pmu__match() is never called so no cost is incurred. I also don't
> >> add any new calls to fnmatch().
> >>
> >> I only updated the gate on whether the existing fnmatch() is called from
> >> "*" to "*[?". So it only happens when one of those characters is in the
> >> PMU name, but it already happens when '*' is in the name.
> >>
> > 
> > Right. I'm not saying there is anything wrong in the change or an
> > additional cost, what the issue is is that currently only really '*'
> > requires fnmatch and that's because the event parsing adds it. It could
> 
> It's not only '*' that requires it, see the example I added in the
> commit message:
> 
>   ./perf stat -e mypmu_[01]/<config>/
> 
> '?' was supported before as well which could be useful.
> 
> > similarly add '.*' if we did regular expression matching. By expanding what
> > we pass to fnmatch from the command line the more committed we are to
> > fnmatch rather than regular expressions - which is what we use everywhere
> > else in the code. So maybe it was a feature that this wasn't working.
> > 
> 
> But we haven't had a release of Perf yet where more is passed to
> fnmatch(). Before f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()")
> everything was passed to fnmatch(). After that unreleased commit only
> things with '*' are. Now with this change only "*?[", so it's less not more.
> 
> I don't think there is any commitment to keep it, we can always remove
> fnmatch in the future. But it looks like a mistake to me because the
> title says "refactor" when it actually removes a feature.

Ian, are you ok with this now?

Thanks,
Namhyung

