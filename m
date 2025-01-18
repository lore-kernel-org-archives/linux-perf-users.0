Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774DA95C;
	Sat, 18 Jan 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737224553; cv=none; b=VToxIrHgQxjUPjYrYDv83McvjUpdNHzwm1cLXyPxB5BGAuLZsTUrMl8TORTPNDidIXSctohXi0nAwYRAgRor6VbfcmNrmekJp6X3m3bNwd9rNhAYuuUY1RLb45kllK1If1Uu+XEMPPyLDk7zqP0dxS4cMFTu74g21q1KoXwdCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737224553; c=relaxed/simple;
	bh=01DSwYqRpSJ8Rt/wkPDDfZiBI9kDYIOhQvGlKBCpzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU1a0HpOT55v1bs/F0sUFHHdkPrYDhLS1mXFLKx9W2HMUZ9Y0alEN6y3QutUyDlu4HA/pWIdsWLqWYLcRAB/m0FIaJEeAygh5xJnr7K+eWyiLtv9JnqOU4VarT0w1FHEZUR81BU92HOrJAX3fvhJn0RrzPg9g6KkpHPJk6iYzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzIU50bI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzIU50bI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F321C4CED1;
	Sat, 18 Jan 2025 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737224552;
	bh=01DSwYqRpSJ8Rt/wkPDDfZiBI9kDYIOhQvGlKBCpzFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzIU50bIa0R/uPc/vmIIlriGK2SgOK/4bK0TN13w2PJ7xYeL8tGYLwGtQwDU05Vlg
	 i5t1zYRg06Avhzg8JYahGXeAvCJ95SNt9e3iTAIcMn0e7mGQwq1B0TD3o++A4uoMZ6
	 OI0qimAYpnZkPBHEGDaRWOpJk7JK+pwfmXaldiJY3O905PwMm0xto8ENu5W9GkUtbK
	 7eocAFcC74XJm0c3K3jvMFPD86qgFzTObLRGqGBTB3kSl/ppTgEprxoaTicy05raKt
	 mYRbD5jRxtpbovy2f+gM4fmsiLHoXslX7wPV9zwBsdokSZRhTUIsOicCoKX3rgYffc
	 77ZK+VReBKxfw==
Date: Sat, 18 Jan 2025 10:22:30 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Nick Forrington <nick.forrington@arm.com>
Subject: Re: [PATCH v1 1/2] perf vendor events arm64: Add N3 events/metrics
Message-ID: <Z4vxZj2YzfwU-m46@google.com>
References: <20250110172006.680753-1-irogers@google.com>
 <da5792c3-8f53-4be8-8f53-e1cf6660feab@linaro.org>
 <CAP-5=fXyVtZChi1fkochiyKw6AztdhEE_rfpJUsz_P9po5bhXA@mail.gmail.com>
 <d0ebae42-99b6-42be-beaa-947160da3b88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0ebae42-99b6-42be-beaa-947160da3b88@linaro.org>

Hello,

On Mon, Jan 13, 2025 at 04:48:06PM +0000, James Clark wrote:
> 
> 
> On 13/01/2025 3:51 pm, Ian Rogers wrote:
> > On Mon, Jan 13, 2025 at 4:35 AM James Clark <james.clark@linaro.org> wrote:
> > > 
> > > 
> > > 
> > > On 10/01/2025 5:20 pm, Ian Rogers wrote:
> > > > Using the scripts at:
> > > > https://gitlab.arm.com/telemetry-solution/telemetry-solution/
> > > > 
> > > > Generate perf json for neoverse-n3 using the following command:
> > > > ```
> > > > $ telemetry-solution/tools/perf_json_generator/generate.py \
> > > >     tools/perf/ --telemetry-files \
> > > >     telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3
> > > > ```
> > > > 
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >    .../arm64/arm/neoverse-n3/core-imp-def.json   | 930 ++++++++++++++++++
> > > 
> > > I assume you got warnings about missing groups, if one is missing that
> > > results in everything being dumped in core-imp-def.json. I have an
> > > internal ticket open about it which is why I didn't post N3 and V3 jsons
> > > yet, I'll check on it again.
> > 
> > I was testing with JEVENTS_ARCH=all. I'm not sure what the group
> > warning is, do you have a link?
> > 
> 
> From the perf_json_generator:
> 
>  $ telemetry-solution/tools/perf_json_generator/generate.py \
>    tools/perf/ --telemetry-files \
>    telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3
> 
>  Warning: Not writing events which do not have a group (note that the
>  mnemonic printed may differ to the one in the source json if it differs
>  in the common Perf files):
> 
>  IMP_CT_FLUSH: Counts flushes including architectural,
>  microarchitectural, and branch redirects.
>  ...
> 
> > > Up to you whether you want to continue with it like this and I can send
> > > a fix up later but there's also a conflict with the recent Fujitsu
> > > Monaka events.
> > 
> > I'm happy to let you push the updates. An alternative, that may work
> > around the group issue, is just to push the event updates. Any chance
> > on an ETA?
> > 
> > Thanks,
> > Ian
> 
> Can't say on an eta. There was a fix already done but not made live yet, but
> now it turns out maybe we don't want to put these particular events into
> Perf because they're not in the TRM. Could be several weeks before anything
> goes live.
> 
> It's a bit of a hack but I can regenerate them without these particular
> events in a V2, and then whatever the outcome is from above will be an
> incremental change later.
 
So what's the final decision?

James, do you want to publish the metrics later at once or are you ok
with this patch for now (and do the incremental change later)?

Thanks,
Namhyung

