Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C271B3925
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113348; cv=none; b=hCSFN5EJw+3GVtOkEX9FnibGGiJkPfQLLwfPHUjhS0Sxt/J+79Lfa8BexjeRqSSWddI9XD/6VSKGYYcn0bYrF3+XWaRK9NMfHldMpSBxBBf7fiupjiMRhDCXBCZpYU1P8g6KMknWuR6AgNP/7ney7IDFmW0TqC0X1ysGfWLHcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113348; c=relaxed/simple;
	bh=101/yr1lluSDprutMk9XWjbg5amAkrbMYeVDWyYiqLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofI/R64r0vBF1Mob2cVMzJPOjT3ArqY3uaPbMQg3VpgBMhAaP08xZ3K+oSDb2MN321w1319IIzk5Z1GXIhDKx7KWBUahKz9OpWWs1lMawVU/N6JDCf8aftk+Qb6drmYChdp9mGg0RMEUWXFTJpqNGiOL3Ud3pF12LflrkAb5r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2nKYAiy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2nKYAiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D16C4CEF5;
	Wed, 17 Sep 2025 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113348;
	bh=101/yr1lluSDprutMk9XWjbg5amAkrbMYeVDWyYiqLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2nKYAiy6u583jJ4O5CbiS91M1uX6h41GfnXroO3Cx23BdpbDeZNTNhSc3jaTihiX
	 Eoe/0FHltrQk3CQvwQuXsuoPfPfqHRyG6+B0aGOyeZuoLgqucWWilRILsZhlXmIAck
	 zNGEcU3oud+sSoJKw1K3F79GpLWV6XxLbItJTsfnn8CC2leabSS84fd8Y4IvxZl7Gw
	 CeB/HltT1MQA2yRVDlT57Ve1S8CiS6tzCBXohGCE1x3o7C9wkJCd7X3xWkUkqmiDwH
	 aFrPKejDE54xWlsLHFrx7v4t5L/rDIkvEGZDhsExT+ZzPrt3VCx9mxlofwfOd+jiFB
	 Irh0kxrSVqd0g==
Date: Wed, 17 Sep 2025 09:49:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Trevor Allison <tallison@redhat.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf test attr: Add missing int_mist.uop_dropping event
 to test-stat files
Message-ID: <aMquQS_5PuC2el1f@x1>
References: <20250916193046.10054-1-tallison@redhat.com>
 <CAP-5=fXdxNLA4Ey51HdMCrY0SZuzp1WUc5A+n9EFLtaajtYEiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXdxNLA4Ey51HdMCrY0SZuzp1WUc5A+n9EFLtaajtYEiA@mail.gmail.com>

On Tue, Sep 16, 2025 at 01:23:54PM -0700, Ian Rogers wrote:
> On Tue, Sep 16, 2025 at 12:31 PM Trevor Allison <tallison@redhat.com> wrote:
> >
> > Setup struct perf-event-attr test was failing on EMR cpu because perf stat
> > was providing an event that was not included in the test. Type 4 Config 4269
> > or 10ad, int_misc.uop_dropping.
> >
> > Add event type=4 config=4269 to test-stat-default and test-stat-detailed-*
> > files with optional=1 so EMR machines can pass test
> >
> > Signed-off-by: Trevor Allison <tallison@redhat.com>
> 
> Thanks! I wonder why this wasn't seen on SapphireRapids.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Fixes: 50e2eb259650 perf vendor events: Update emeraldrapids events/metrics

You mean:

commit d9a6bb9e359e6f816c746fc8d6aa0999f4594a0c
Author: Ian Rogers <irogers@google.com>
Date:   Mon Aug 18 12:04:02 2025 -0700

    perf vendor events: Update emeraldrapids events/metrics
    
    Update events from v1.14 to v1.16. Update metrics from TMA 5.0 to 5.1.
    
    The event updates come from:
    
    https://github.com/intel/perfmon/commit/9020e49e790349f86141a1f6ef6f009f189a0f48
    https://github.com/intel/perfmon/commit/a0567b56185fea4b968391aae344e9d8ed9782d8

?

As I didn't find 50e2eb259650 in upstream or perf-tools-next.

⬢ [acme@toolbx perf-tools-next]$ git log --oneline tools/perf/pmu-events/arch/x86/emeraldrapids/
d9a6bb9e359e6f81 perf vendor events: Update emeraldrapids events/metrics
31c8714cf5b91da6 perf vendor events: Update EmeraldRapids events
4ecf9eab4a04c75d perf vendor events: Update emeraldrapids events/metrics
5ee60fbf7375abeb perf vendor events: Update EmeraldRapids events/metrics
40ccd6aa3e2e05be perf vendor events: Add/update emeraldrapids events/metrics
36f353a1ebf88280 perf vendor events intel: Update emeraldrapids to 1.06
ea518afc992032f7 perf vendor events intel: Update emeraldrapids events to v1.03
576d7fed09c7edba perf vendor events intel: Update emeraldrapids events to v1.02
8a94d3bfaf45e799 perf vendor events intel: Update emeraldrapids to v1.01
8c994eff8fcfe8ec perf vendor events intel: Add emeraldrapids, update sapphirerapids to v1.16
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
 
> Ian
> 
> > ---
> >  tools/perf/tests/shell/attr/test-stat-default    | 7 +++++++
> >  tools/perf/tests/shell/attr/test-stat-detailed-1 | 7 +++++++
> >  tools/perf/tests/shell/attr/test-stat-detailed-2 | 7 +++++++
> >  tools/perf/tests/shell/attr/test-stat-detailed-3 | 7 +++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/attr/test-stat-default b/tools/perf/tests/shell/attr/test-stat-default
> > index e47fb4944679..8dd27c1fb661 100644
> > --- a/tools/perf/tests/shell/attr/test-stat-default
> > +++ b/tools/perf/tests/shell/attr/test-stat-default
> > @@ -227,3 +227,10 @@ fd=28
> >  type=4
> >  config=270
> >  optional=1
> > +
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> > +[event29:base-stat]
> > +fd=29
> > +type=4
> > +config=4269
> > +optional=1
> > \ No newline at end of file
> > diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-1 b/tools/perf/tests/shell/attr/test-stat-detailed-1
> > index 3d500d3e0c5c..12a2ebf4e64a 100644
> > --- a/tools/perf/tests/shell/attr/test-stat-detailed-1
> > +++ b/tools/perf/tests/shell/attr/test-stat-detailed-1
> > @@ -269,3 +269,10 @@ fd=32
> >  type=3
> >  config=65538
> >  optional=1
> > +
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> > +[event33:base-stat]
> > +fd=33
> > +type=4
> > +config=4269
> > +optional=1
> > \ No newline at end of file
> > diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-2 b/tools/perf/tests/shell/attr/test-stat-detailed-2
> > index 01777a63752f..66ea25b7d38f 100644
> > --- a/tools/perf/tests/shell/attr/test-stat-detailed-2
> > +++ b/tools/perf/tests/shell/attr/test-stat-detailed-2
> > @@ -329,3 +329,10 @@ fd=38
> >  type=3
> >  config=65540
> >  optional=1
> > +
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> > +[event39:base-stat]
> > +fd=39
> > +type=4
> > +config=4269
> > +optional=1
> > \ No newline at end of file
> > diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-3 b/tools/perf/tests/shell/attr/test-stat-detailed-3
> > index 8400abd7e1e4..4a27bbfb9f87 100644
> > --- a/tools/perf/tests/shell/attr/test-stat-detailed-3
> > +++ b/tools/perf/tests/shell/attr/test-stat-detailed-3
> > @@ -349,3 +349,10 @@ fd=40
> >  type=3
> >  config=66048
> >  optional=1
> > +
> > +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> > +[event41:base-stat]
> > +fd=41
> > +type=4
> > +config=4269
> > +optional=1
> > \ No newline at end of file
> > --
> > 2.39.5 (Apple Git-154)
> >
