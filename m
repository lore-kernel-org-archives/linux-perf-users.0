Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F443172;
	Wed, 30 Apr 2025 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056193; cv=none; b=rqivZ4eaaOdG7B/+jpnxiZ20sb3YXkWcsANw3a6kOMbSAGDvxpUdf+rQejwbf5IP2X3fXGCF1IjoaDfHSI8BTr9ZINQRKEaTsGcEjS+WGxWsRLRVqcjYXDhcO5f1gkBeTxC4biOKpggM4pJxfUH0an1J/bCUFFwizEev/Dn/mEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056193; c=relaxed/simple;
	bh=36vVnkisvY+P4AlYmBbiWrdIm1AmGftJI8nb13UOMIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckyisrv8o7AEDn0r6R7ZRM9/5a0B8kQnv9IadHjPsko5zEL2oLTlq2hjdp6tyUEK011rB1bq8wfMI7k5LN/+SfjoDBdTHPtwSqZT5NLhcdiy4ZatY+r6jv3TJVmoXBws04B7iBWXY77YdR3+Bl1JwmbEcGDNCJLa8AafURs31Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tft/RG+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tft/RG+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B85C4CEE7;
	Wed, 30 Apr 2025 23:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746056192;
	bh=36vVnkisvY+P4AlYmBbiWrdIm1AmGftJI8nb13UOMIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tft/RG+VvpzRbHBXNM4V2si4qStApdUywL7XwbOQKw+UciKGIoo3JMgdOGV/2G8Zz
	 2Xhv7aCDX1IJrhQ+kUjsmIaH9gaQD8S0rT0AphmJr8rPnZBRImy83Q+FcR66mnutK7
	 mL4pK/TnMgXXP5xW1h/ZS69KJAcQ8H1wZPSR5Y4CPtQtOPXUr+6xBCTz24rxeB7o93
	 venh/5kFEPEtQIbFpzHZLgCTbTairBOSYiAfkkcVhIjasf9V3j2Hs3x6rfl2Vjb9v2
	 5g2WwdlfiffavGYQ46gC6/eVYUEvOMfUK1QU4yFGMOTGZ66VZRixf7LcDoEDwT60Xq
	 HqUIva96mxNWQ==
Date: Wed, 30 Apr 2025 20:36:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Brendan Gregg <brendan@intel.com>, gabriel.munoz@intel.com,
	matthew.olson@intel.com, brandon.kammerdiener@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/4] Add support for a DRM tool like PMU
Message-ID: <aBKz_Tg-s20Qsv6k@x1>
References: <20250403202439.57791-1-irogers@google.com>
 <CAP-5=fXkayZ7pj+EctOtSBiTcGuyi6SHm9c5RZ3HyyPYcot9zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXkayZ7pj+EctOtSBiTcGuyi6SHm9c5RZ3HyyPYcot9zA@mail.gmail.com>

On Wed, Apr 30, 2025 at 08:21:59AM -0700, Ian Rogers wrote:
> On Thu, Apr 3, 2025 at 1:24 PM Ian Rogers <irogers@google.com> wrote:
> >
> > DRM clients expose information through usage stats as documented in
> > Documentation/gpu/drm-usage-stats.rst (available online at
> > https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
> > PMU, similar to the hwmon PMU, that exposes DRM information.

Looks useful, I'll try to review and test tomorrow, but most probably
Friday, as tomorrow is labour day in this part of the world.

- Arnaldo
 
> I'm reminded by Brendan Gregg's new blog:
> https://www.brendangregg.com/blog/2025-05-01/doom-gpu-flame-graphs.html
> that this is still outstanding. The patches also reduce some directory
> scanning for the hwmon "PMU", they are in Google's tree:
> https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/tools/perf/util/drm_pmu.c
> 
> Thanks,
> Ian
> 
> > v3: Minor tweak to the test so the skip (exit 2) doesn't trigger the
> >     trap cleanup.
> >
> > v2: Add support to only scan hwmon and drm PMUs if the event or PMU
> > wildcard can match. Add a test as requested by Namhyung. Add file
> > comments.
> >
> > v1:
> > https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/
> >
> > Ian Rogers (4):
> >   perf parse-events: Avoid scanning PMUs that can't contain events
> >   perf parse-events: Avoid scanning PMUs that can't match a wildcard
> >   perf drm_pmu: Add a tool like PMU to expose DRM information
> >   perf tests: Add a DRM PMU test
> >
> >  tools/perf/tests/shell/drm_pmu.sh |  78 ++++
> >  tools/perf/util/Build             |   1 +
> >  tools/perf/util/drm_pmu.c         | 689 ++++++++++++++++++++++++++++++
> >  tools/perf/util/drm_pmu.h         |  39 ++
> >  tools/perf/util/evsel.c           |   9 +
> >  tools/perf/util/parse-events.c    |  30 +-
> >  tools/perf/util/pmu.c             |  15 +
> >  tools/perf/util/pmu.h             |   4 +-
> >  tools/perf/util/pmus.c            | 101 ++++-
> >  tools/perf/util/pmus.h            |   2 +
> >  10 files changed, 952 insertions(+), 16 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/drm_pmu.sh
> >  create mode 100644 tools/perf/util/drm_pmu.c
> >  create mode 100644 tools/perf/util/drm_pmu.h
> >
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
