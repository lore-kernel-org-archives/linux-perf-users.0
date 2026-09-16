Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BF3BF684
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560779; cv=none; b=mWyB1usqMKR89YIvgIZ7UacNuGETfcITo5+l5C/L4kXuKTUutT2BtGOIkR3vIuD5xYpAlh/uhzZhh8BWQD12AtvrrpJmskAk3fTXVQGhK67Y/NaI9o9Os2rEQz1qcXDWpK8IkTCXJ1aR2aF7AA8qTp+WnjaIgsjbd84J5EDII3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560779; c=relaxed/simple;
	bh=f6sOWq7hBiXwS8KlGTMo/OukRB0pHMjckby948N0O7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgw4xfy6Cs90h+qZYWFZ9gB+zE4dAZ06d8ei2eQx8z8CuODDNvSC56goiHrQoFhEnTT5x2aVBR1t5E6FGE4wtZKLtmt0N/iSEX22O3zL/IASuWpe1KiXuOihv02vAr/CIlfnfQ04ghPF8FFRDRO3wX4C7QdDELPEn30BKJYbAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmhgJI1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmhgJI1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC6A1F000FF;
	Wed, 16 Sep 2026 12:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560778;
	bh=tVYvNmMRKa8rOu5q2ltq/e8k45Y203malGlg9EsFBs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gmhgJI1SIag/RnH2PMhqbmkRIXWhuimaAIHIaIl/ZWnBeDycr0Gbe2StTTZzZbdJj
	 G2i1gksESDY13bFp2fFwb/+2VIoAJna0Apl4ZXmvGGtFzqfNfIvBksStcJzAluA9wF
	 e9Ur4fJsG4RhUXF8qZSRqLdaMk8jQUTD55zF1sI1HSZzsXh03ufr/y56iKoYZTI3Z6
	 DlpnErsY9/B9ir+trjvFK9HQX+ZTqCYpyAch0b2UthjRN7rTU8NsBAotqv8UsF+bwq
	 bERBMWHVEPCzOT06Qh6IfFplauqt8ftQptwOOaXX2rc9HXTBeFmmum7WREXZbhZdkX
	 2ZCOIbhBwHDeQ==
Date: Wed, 16 Sep 2026 09:12:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8] perf record: Fix unhandled POLLHUP on non_perf_event
 descriptors
Message-ID: <aqqHxvhiGxQjjRDS@x2>
References: <20260820200214.2865570-1-irogers@google.com>
 <20260820213757.2970316-1-irogers@google.com>
 <20260820214746.98B771F000E9@smtp.kernel.org>
 <CAP-5=fWRhOdjT+9wUqOy59Hz4fSZQgibanisytCy_3TNTN1ecg@mail.gmail.com>
 <CAP-5=fUFYbvxEnEBJt5g1TFHxxTKkgVqLuTEnXUKWQ1qACGFNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUFYbvxEnEBJt5g1TFHxxTKkgVqLuTEnXUKWQ1qACGFNg@mail.gmail.com>

On Tue, Sep 15, 2026 at 01:22:24PM -0700, Ian Rogers wrote:
> On Thu, Aug 20, 2026 at 3:00 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Aug 20, 2026 at 2:47 PM <sashiko-bot@kernel.org> wrote:
> > >
> > > > When processing POLLHUP on a non_perf_event control descriptor,
> > > > evlist__finalize_ctlfd() is invoked to finalize the setup, correctly
> > > > setting the core evlist's poll array file descriptor to -1. However,
> > > > this finalized teardown state is never propagated back to the
> > > > individual thread's local replica of the pollfd array.
> > > >
> > > > Consequently, on the next iteration of the main recording loop,
> > > > record__update_evlist_pollfd_from_thread() performs a strict
> > > > equivalence check between the core evlist's array and the thread's
> > > > localized poll array, detecting that the fd values no longer match.
> > > > This causes an immediate -EINVAL abort and a premature teardown.
> > > >
> > > > Fix the underlying logic within
> > > > record__update_evlist_pollfd_from_thread() to sustainably propagate
> > > > the finalized teardown statuses (-1) originating from the core evlist
> > > > back to the thread's localized poll structure. This correctly
> > > > maintains synchronization and entirely prevents the unhandled
> > > > index mismatch crashes.
> > > >
> > > > Additionally, add a unit test that explicitly validates that
> > > > fdarray__filter() preserves its invariants regarding
> > > > fdarray_flag__nonfilterable items to guard against regressions.
> > > >
> > > > Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi-threaded sessions")
> > > > Assisted-by: Gemini:gemini-3.1-pro
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Sashiko has reviewed this patch and found no issues. It looks great!
> 
> Ping. Thanks,
> Ian

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
