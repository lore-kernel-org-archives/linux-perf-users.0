Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D23A0E92;
	Wed, 14 Jan 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405646; cv=none; b=bKVTGSRTrkF2kQTpUE4kOpkj7iCHB3A0DAtGRAp7172dToCZh95GtDzMmOljXpedpi44sQG/DzCHyGg+rYR8X5002CSv9x/jw9mVncy6lZSKq5afwR1BsXCIoaP8yE6LY7vRtYwLXkPF96Sr7FAV+xLZL31kLlbCPvhcFby/2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405646; c=relaxed/simple;
	bh=StlWp9SlvJnlDU6iyBFhbKlgusG5Kwh8+x4EmYEVyRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyQPdjeK0qY8MzqoftZ1fRuFJE7Oi14yodMIVjiiEafIdQNVB0Nfy5zL+2FrjLBc8yrHhCiBLU3XbZNdVgp73/teb9msb5Y+crShHMNZu1r7eoZGrSjef0uU7V2pfvcLuRrYaPCrXuxmyZxGFDGuXpJRah0uGZ9dYGHHaJSQ5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGGxtXsi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGGxtXsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDF5C16AAE;
	Wed, 14 Jan 2026 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768405645;
	bh=StlWp9SlvJnlDU6iyBFhbKlgusG5Kwh8+x4EmYEVyRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGGxtXsibtNTAMVb3D+xeu/7EtrYgBrlypiOS/VJ8u/q9bUzEBiorJ2izIQh/NS/z
	 3QsCsW+/hCmaksTrpfGA0DQ/EangxU+hCyC3Ez5bT55/GSaQF8oUfBJekvcCDJVRBR
	 2CY/3uBfPKU4Bv3WL1OLcqm4vlZ71ZwALutBrMsDw/TfbM2Saums5pM1/f5Abo0110
	 m8myOEkA7JcMOtpzJs2CmMOjBQtnQ0ymoOumuIUbRGfYtIbnH2IviP3ODGkGYDoqKu
	 9pVShB6PljaXL9ZHFHn9JkWrHkkiBe67hSGXH68yJ+47BN3RWHw1RoEjOWYCQBKKUj
	 imZCCx+wj1Dlg==
Date: Wed, 14 Jan 2026 12:47:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 02/14] perf evsel: Refactor
 evsel__set_config_if_unset() arguments
Message-ID: <aWe6igmKMq25GJP9@x1>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
 <20251222-james-perf-config-bits-v4-2-0608438186fc@linaro.org>
 <aWbDg0kmo-isxkz2@x1>
 <4eda1bd6-ec36-4d0b-85de-ef0bd190e5e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eda1bd6-ec36-4d0b-85de-ef0bd190e5e7@linaro.org>

On Wed, Jan 14, 2026 at 12:14:43PM +0000, James Clark wrote:
> On 13/01/2026 10:13 pm, Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 22, 2025 at 03:14:27PM +0000, James Clark wrote:
> > > Make the evsel argument first to match the other evsel__* functions
> > > and remove the redundant pmu argument, which can be accessed via evsel.

> > I haven't checked if this is the exactly where this takes place but
> > should be in this series, 32-bit build is broken:

> >     3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> > WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> >      21.72 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
> >       1378 |         perf_pmu__format_pack(&bits, val, vp, /*zero=*/true);
> >            |                               ^~~~~
> >            |                               |
> >            |                               u64 * {aka long long unsigned int *}
> >      In file included from util/evsel.h:14,
> >                       from util/evsel.c:38:
> >      util/pmu.h:282:43: note: expected ‘long unsigned int *’ but argument is of type ‘u64 *’ {aka ‘long long unsigned int *’}
> >        282 | void perf_pmu__format_pack(unsigned long *format, __u64 value, __u64 *v,
> >            |                            ~~~~~~~~~~~~~~~^~~~~~
 
> > What I have is in perf-tools-next/tmp.perf-tools-next BTW, I'll try and
> > fix this tomorrow if you don't do it first. :-)
 
> Taking a look, but I'm wondering if this is already not working properly.
> There are existing "unsigned long"s in pmu.c that operate on the config bits
> which is what I copied.
 
> On this target an unsigned long is 32bits but struct
> perf_event_attr->configs are __u64. So it looks like it might leave the top
> bits unset sometimes.
 
> I'll look at a fix for that which should fix the compilation error at the
> same time.
 
> Another question is, do we actually care about this platform?

It failed for other 32-bit platforms too, so the question is if we care
about 32-bit at all.

- Arnaldo
