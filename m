Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64274C81;
	Wed, 12 Mar 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744836; cv=none; b=pfcHwwjcGaZE2uDZIa5uJulqoQwwfn52l0ydUWcYQx+9PnONh+tBm/RkNmpYUB++vMOV3PFOMoJQQm5pqj+1Rf7HnaszuQtOr+UOGZ00m6DF+BYuneik5+jivVYF4K51P3Ir9v/lb7uVePZLglQnWfvyPoZV1DDM9iw+UD/w370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744836; c=relaxed/simple;
	bh=b2KFyzQPt62EjuLD50rsCqVAb5LhVZON3gByzj5R9z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3bqt/N9kVrscdNYa7NBB8rVLqRCHzLRySdnqMuUiK9nZ1BdktXaiWh6u5ea6Ta2o3kk1bL+9NNjDDj8mY6YhB76r94QRZ59tUUbMXrXcrjMxjE2TNGMICOtBhVZOycH3ESmWPpYP91wvtl0J8wlki7cWFRstoKAh3TcQW7GuNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xka/51xQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xka/51xQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4DBC4CEE9;
	Wed, 12 Mar 2025 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741744836;
	bh=b2KFyzQPt62EjuLD50rsCqVAb5LhVZON3gByzj5R9z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xka/51xQCYDoUQkC8qacAZFwXEWR7+9kB9bxszPwlX4d3OqXq0P0C4UCAuVkFBR6A
	 FC5J4NO88zqrzfdDzBTC5uF1WR6I8/LI3UNxyGfXyKuwNA9IzA5lS8dOu8p+9p+Squ
	 FPaI0U99eYdOv9hzKelP46+kYnf2hlVZgSrfqQ3bmf5eaN+2OEfbYS/QplW5xRgDAs
	 cenCpLHha8pbmmfpX0+8s6MK2t4NFQ1zBign7MYnwRXiQem0TW0BgFuopyq0oHQtRS
	 z9+D6K47/exV3am8gPo+3IOoPtvJMqtHHe2BFilhvb7jlbhn6yUKIDhoAMzgAWwTSF
	 pYVCPeLpa3rfA==
Date: Tue, 11 Mar 2025 19:00:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH v2 4/5] perf x86 evlist: Update comments on topdown
 regrouping
Message-ID: <Z9Dqwd_7pyj7Gvqj@google.com>
References: <20250307023906.1135613-1-irogers@google.com>
 <20250307023906.1135613-4-irogers@google.com>
 <Z89Y5pUchAaJj4PY@google.com>
 <ba8dedbc-9a5f-4038-ad51-2b20baa6af65@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8dedbc-9a5f-4038-ad51-2b20baa6af65@linux.intel.com>

On Tue, Mar 11, 2025 at 08:45:20AM +0800, Mi, Dapeng wrote:
> 
> On 3/11/2025 5:25 AM, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Mar 06, 2025 at 06:39:05PM -0800, Ian Rogers wrote:
> >> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>
> >> Update to remove comments about groupings not working and with the:
> >> ```
> >> perf stat -e "{instructions,slots},{cycles,topdown-retiring}"
> >> ```
> >> case that now works.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> > Dapeng, can I get your Signed-off-by here?
> >
> > Thanks,
> > Namhyung
> >
> >> ---
> >>  tools/perf/arch/x86/util/evlist.c | 27 ++++++---------------------
> >>  1 file changed, 6 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> >> index ed205d1b207d..7905a28d7734 100644
> >> --- a/tools/perf/arch/x86/util/evlist.c
> >> +++ b/tools/perf/arch/x86/util/evlist.c
> >> @@ -39,28 +39,13 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> >>  	 *         26,319,024      slots
> >>  	 *          2,427,791      instructions
> >>  	 *          2,683,508      topdown-retiring
> >> -	 *
> >> -	 * If slots event and topdown metrics events are not in same group, the
> >> -	 * topdown metrics events must be first event after the slots event group,
> >> -	 * otherwise topdown metrics events can't be regrouped correctly, e.g.
> >> -	 *
> >> -	 * a. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
> >> -	 *    WARNING: events were regrouped to match PMUs
> >> -	 *     Performance counter stats for 'CPU(s) 0':
> >> -	 *         17,923,134      slots
> >> -	 *          2,154,855      instructions
> >> -	 *          3,015,058      cycles
> >> -	 *    <not supported>      topdown-retiring
> >> -	 *
> >> -	 * If slots event and topdown metrics events are in two groups, the group which
> >> -	 * has topdown metrics events must contain only the topdown metrics event,
> >> -	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
> >> -	 *
> >> -	 * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
> >> +	 * e. slots event and metrics event are in a group and not adjacent
> 
> Yes, here is my SoB.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks!

> 
> BTW, It seems there is a typo and missed the "not" word. It should be 
> "slots event and metrics event are not in a group and not adjacent"
 
Ok, will update.

Thanks,
Namhyung

> 
> >> +	 *    perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
> >>  	 *    WARNING: events were regrouped to match PMUs
> >> -	 *    Error:
> >> -	 *    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
> >> -	 *    event (topdown-retiring)
> >> +	 *         68,433,522      slots
> >> +	 *          8,856,102      topdown-retiring
> >> +	 *          7,791,494      instructions
> >> +	 *         11,469,513      cycles
> >>  	 */
> >>  	if (topdown_sys_has_perf_metrics() &&
> >>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
> >> -- 
> >> 2.49.0.rc0.332.g42c0ae87b1-goog
> >>
