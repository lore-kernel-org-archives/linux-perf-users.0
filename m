Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB0293B61;
	Thu, 10 Apr 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302666; cv=none; b=q0x9yQYkFixUFsdTWNwwp0M1zMdTZL7jdpy9mbMJJTb5+t7W/B/bOz1lFOmsU90ffh1IaT9VgSPNR80V7PMZwd+7T5f57f3dcF16w0GQvvPfxNQxFoI4Wlzr0OMy+iMuRVauGJalwh89+FSs0yO96g0o0TU128FQxaEfzwpPH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302666; c=relaxed/simple;
	bh=/6J5a/388DLFHMqzPccT2y2Pj4UzDqFXCQ23zqugdow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2EDIYIohmR2YH9Aypbk689pOhOvMZYGsomed/uaf0ex4cL4DelfI3laGqOq6C1Xbqfz01rAmMkOyHOvzM5aTpgxPkHCFreTAQM6Pc/4bB/60cTykKYzAihcG/cjhkUtT7X3N8XyCUuptXmPfAHkjQ5km5I5QzCynpDQZSCzFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+y20LhU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+y20LhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD46C4CEEA;
	Thu, 10 Apr 2025 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744302665;
	bh=/6J5a/388DLFHMqzPccT2y2Pj4UzDqFXCQ23zqugdow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+y20LhUQL07cdE3bmS+dP6Tncub7K/a2+Im2bp+Fx7cr5FIj5BGZwOtfAIRJ0TqJ
	 FCTis6aT+cWGyoSn706uL+nj6H15Ju9DDRvhLGdkAN3fbz+ZGnikDY3OjYoLkHrAgo
	 I50zG5FugyR/5dYEraqMDkICxuIK+S/xfHMYu4rRzU6Gnb3BrlnRDZpIr+VJyaTHyO
	 1nG0E8nqi1Qz1E9cJTN5wr54chtB9nE5zya7SsVSeVeG1CTDAViKJfss/Z9muk7Qqy
	 VEknqYR8NPL4/FeY1/vXfq64FAc3vAPCVD1gcbXqR1EEBOqbcjPNwh1kwYwPjbvIhs
	 gWy7G50YyRoBA==
Date: Thu, 10 Apr 2025 09:31:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf tools: Remove evsel__handle_error_quirks()
Message-ID: <Z_fyRpjnXjXukLwM@google.com>
References: <20250410010252.402221-1-namhyung@kernel.org>
 <CAJpZYjWTN09uXcArncRVXRRDcCH042MeN4UC1FAokoUNzsuG6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjWTN09uXcArncRVXRRDcCH042MeN4UC1FAokoUNzsuG6A@mail.gmail.com>

Hello,

On Wed, Apr 09, 2025 at 08:26:07PM -0700, Chun-Tse Shao wrote:
> On Wed, Apr 9, 2025 at 6:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The evsel__handle_error_quirks() is to fixup invalid event attributes on
> > some architecture based on the error code.  Currently it's only used for
> > AMD to disable precise_ip not to use IBS which has more restrictions.
> >
> > But the commit c33aea446bf555ab changed call evsel__precise_ip_fallback
> > for any errors so there's no difference with the above function.  To
> > make matter worse, it caused a problem with branch stack on Zen3.
> >
> > The IBS doesn't support branch stack so it should use a regular core
> > PMU event.  The default event is set precise_max and it starts with 3.
> > And evsel__precise_ip_fallback() tries with it and reduces the level one
> > by one.  At last it tries with 0 but it also failed on Zen3 since the
> > branch stack is not supported for the cycles event.
> >
> > At this point, evsel__precise_ip_fallback() restores the original
> > precise_ip value (3) in the hope that it can succeed with other modifier
> > (like exclude_kernel).  Then evsel__handle_error_quirks() see it has
> > precise_ip != 0 and make it retry with 0.  This created an infinite
> > loop.
> >
> > Before:
> >
> >   $ perf record -b -vv |& grep removing
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   removing precise_ip on AMD
> >   ...
> >
> > After:
> >
> >   $ perf record -b true
> >   Error:
> >   Failure to open event 'cycles:P' on PMU 'cpu' which will be removed.
> >   Invalid event (cycles:P) in per-thread mode, enable system wide with '-a'.
> >   Error:
> >   Failure to open any events for recording.
> >
> > Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Tested-by: Chun-Tse Shao <ctshao@google.com>

Thanks for the test.

Arnaldo, I think we can have this in the perf-tools tree.

Thanks,
Namhyung


> > ---
> >  tools/perf/util/evsel.c | 22 ----------------------
> >  1 file changed, 22 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 1974395492d7da5e..3c030da2e477c707 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2566,25 +2566,6 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
> >         return false;
> >  }
> >
> > -static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> > -{
> > -       /*
> > -        * AMD core PMU tries to forward events with precise_ip to IBS PMU
> > -        * implicitly.  But IBS PMU has more restrictions so it can fail with
> > -        * supported event attributes.  Let's forward it back to the core PMU
> > -        * by clearing precise_ip only if it's from precise_max (:P).
> > -        */
> > -       if ((error == -EINVAL || error == -ENOENT) && x86__is_amd_cpu() &&
> > -           evsel->core.attr.precise_ip && evsel->precise_max) {
> > -               evsel->core.attr.precise_ip = 0;
> > -               pr_debug2_peo("removing precise_ip on AMD\n");
> > -               display_attr(&evsel->core.attr);
> > -               return true;
> > -       }
> > -
> > -       return false;
> > -}
> > -
> >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >                 struct perf_thread_map *threads,
> >                 int start_cpu_map_idx, int end_cpu_map_idx)
> > @@ -2730,9 +2711,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >         if (evsel__precise_ip_fallback(evsel))
> >                 goto retry_open;
> >
> > -       if (evsel__handle_error_quirks(evsel, err))
> > -               goto retry_open;
> > -
> >  out_close:
> >         if (err)
> >                 threads->err_thread = thread;
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
