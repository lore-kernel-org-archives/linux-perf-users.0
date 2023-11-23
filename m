Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BB2FC23
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdhEehH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35997C433C7;
	Thu, 23 Nov 2023 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700749105;
	bh=5dH3Z1NJbf5X4mxp0nH6utgpxlpIoWc66IrPh9xa4qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdhEehH/Lvn6xsUmZaa7Zn9iR0bMce7f6LD6JAW6bDLzFqIjJxD8Bl5bEVb6Ahihm
	 EqwjJPRkegwijJcIsTzWndIeKmz1Ow2ocG5GHU5wY2xNQRnOsfVwSYQqjyo350lXIg
	 4SS0w8Xne4/DjKsZAif6vltTDfFBqgx7i5GtBJycK+1VTTyGg23R91OsfznvTNq/83
	 waqcF7ms9GmCtzvilcMajKyR4qQFqG75e3Phb9gEOEIYNfr0M3rIfaIzacCMG+kW6y
	 /Xqrlgf4zqiCf760au146jJMKWCrXhHlYiACWV+l6+zmvgPEiZQUPYPb5XafHOmqxN
	 sFp/Ap0v/yidQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7B56140094; Thu, 23 Nov 2023 11:18:22 -0300 (-03)
Date: Thu, 23 Nov 2023 11:18:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hector Martin <marcan@marcan.st>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
	Marc Zyngier <maz@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZV9fLgHshKGoAPYK@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <ac4cf01d-4bb5-4b4d-bd87-bf05ddb67f2d@marcan.st>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4cf01d-4bb5-4b4d-bd87-bf05ddb67f2d@marcan.st>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 23, 2023 at 05:45:19PM +0900, Hector Martin escreveu:
> On 2023/11/23 13:29, Ian Rogers wrote:
> > The bulk of this change is updating all of the parse-events test
> > expectations so that if a sysfs/json event exists for a PMU the test
> > doesn't fail - a further sign, if it were needed, that the legacy
> > event priority was a known and tested behavior of the perf tool.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > This is a large behavioral change:
> > 1) the scope of the change means it should bake on linux-next and I
> > don't believe should be a 6.7-rc fix.
> > 2) a fixes tag and stable backport I don't think are appropriate. The
> > real reported issue is with the PMU driver. A backport would bring the
> > risk that later fixes, due to the large behavior change, wouldn't be
> > backported and past releases get regressed in scenarios like
> > hybrid. Backports for the perf tool are also less necessary than say a
> > buggy PMU driver, as distributions should be updating to the latest
> > perf tool regardless of what Linux kernel is being run (the perf tool
> > is backward compatible).
> 
> Tested-by: Hector Martin <marcan@marcan.st>

Thanks, applied locally, doing some tests and then will push for
linux-next to pick it up.

Mark, can I have your Reviewed-by or Acked-by?

- Arnaldo
 
> $ sudo taskset -c 2 ./perf stat -e apple_icestorm_pmu/cycles/ -e
> apple_firestorm_pmu/cycles/ -e cycles echo
> 
> 
>  Performance counter stats for 'echo':
> 
>      <not counted>      apple_icestorm_pmu/cycles/
>                        (0.00%)
>             34,622      apple_firestorm_pmu/cycles/
> 
>             30,751      cycles
> 
> 
>        0.000429625 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.000443000 seconds sys
> 
> 
> $ sudo taskset -c 0 ./perf stat -e apple_icestorm_pmu/cycles/ -e
> apple_firestorm_pmu/cycles/ -e cycles echo
> 
> 
>  Performance counter stats for 'echo':
> 
>             13,413      apple_icestorm_pmu/cycles/
> 
>      <not counted>      apple_firestorm_pmu/cycles/
>                        (0.00%)
>      <not counted>      cycles
>                        (0.00%)
> 
>        0.000898458 seconds time elapsed
> 
>        0.000908000 seconds user
>        0.000000000 seconds sys
> 
> (It would be nice to have "cycles" match/aggregate both PMUs, but that's
> a story for another day. The behavior above is what was there in 6.4 and
> earlier.)
