Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D222D59E8;
	Fri,  6 Feb 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395546; cv=none; b=o7Glu+4awOyuY3jAMCbICiYs9lH9pztcsMoxmwW6bWTWqEeGpikylNw7/h/C0dXJZDTVJCOg35BK9hrgHyM+DQNpGN+gmd/0Tp5CZLZCEbnJv8/M64fguD4usamQoSW5Z0nkdSacuqP9iv7aZJ01hZy6gd5D22N65cOmkyqGVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395546; c=relaxed/simple;
	bh=pLj5gfSpPNhHMqK08AguxHM0bMKKBT3fh/AiiFMTCo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ7x7YveMAphVaLZQ0mtX5ymdWx040xrSc4YEIwjdgtfv4h1R7Jikekit8TIdWfIfWRVl5g7M9RKxeS4qwkbRTArNm2eoGb8MTYZKPZhrfrqPg81jAtFkAHn4nlLJ3uKuem2Qip/nauNeBnLO1t67oRUfJSoKpEvW5J8ld9Y+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C8E4339;
	Fri,  6 Feb 2026 08:32:19 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398C13F632;
	Fri,  6 Feb 2026 08:32:25 -0800 (PST)
Date: Fri, 6 Feb 2026 16:32:22 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Make logs more readable for event open
 failures
Message-ID: <20260206163222.GH3529712@e132581.arm.com>
References: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
 <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com>
 <aYUOowQ_CZf3BDKo@x1>
 <CAP-5=fUObi2ZoY60VF-WMD0=4=EB4e5s7SUAQyf3zoNA1my6Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUObi2ZoY60VF-WMD0=4=EB4e5s7SUAQyf3zoNA1my6Og@mail.gmail.com>

On Thu, Feb 05, 2026 at 02:33:04PM -0800, Ian Rogers wrote:
> On Thu, Feb 5, 2026 at 1:42 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Wed, Feb 04, 2026 at 09:29:14AM -0800, Ian Rogers wrote:
> > > On Wed, Feb 4, 2026 at 6:26 AM Leo Yan <leo.yan@arm.com> wrote:
> > > >
> > > > Since commit ee27476fa300 ("perf record: Skip don't fail for events that
> > > > don't open"), if a user does not have permission to access a PMU event,
> > > > perf reports:
> > > >
> > > >   perf record -e cs_etm// -C 3 -- ls
> > > >   Error:
> > > >   Failure to open event 'cs_etm//u' on PMU 'cs_etm' which will be removed.
> > > >   No fallback found for 'cs_etm//u' for error 13
> > > >   Error:
> > > >   Failure to open event 'dummy:u' on PMU 'software' which will be removed.
> > > >   No fallback found for 'dummy:u' for error 13
> > > >   Error:
> > > >   Failure to open any events for recording.
> > > >
> > > > The log is not very helpful, as no clear indication of what "error 13"
> > > > means or how to address the issue.
> > > >
> > > > This commit restores evsel__open_strerror() to generate a readable error
> > > > message and print it out:
> >
> > I'm applying this one, maybe we can at least suppress the one for dummy
> > when it is auto added?
> 
> IIRC it was left in as "perf record -e dummy" can be a way of just
> tracking sideband data and you'd want errors opening dummy to be
> warned upon in that case.

As Arnaldo said this patch has been picked, I sent a following patch
for simplifying the logs:
https://lore.kernel.org/linux-perf-users/20260206-perf_improve_log_for_open_event_failures-v1-1-366903bebcd7@arm.com/T/#u

If want me to resend two patches in a series, or squash into one,
please let me know.  Thanks!

Leo
