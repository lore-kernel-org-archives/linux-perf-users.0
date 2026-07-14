Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCA3F1ABB;
	Tue, 14 Jul 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050649; cv=none; b=aENYAxx/22RXoEi25FqZXzHqMMd7ZkH8RuKBuF0EC87Ds+WhV92sPHoU9mIjz9184K5G048LyqakVJqdZmP383AoM/XqbrqozL4UoIY7fwqNncpaIcsfWewuGUbT9qCvNa2oLxZHi2ITL5Q55TzypVN4t4B1LFS6mStrKLRdMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050649; c=relaxed/simple;
	bh=d75fpgkbo8DGQsySMMRX7CfKHKkIk/JZZtDpcqjTmPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3zYFF4KNokDe4Zg8os1t3Sk+6FpOgWBpAFpPn7ItrkQ8zECmWgbHv/4JDQfLlf0N8ODpb5zEBltxAkZ0RxRNsMLVokcgz6tIajs1tKXcenGRZx+It02FoBeGsDXy3zi6WFpBJ3paa7S6GiK4HMO3w0vTkXB5Ya6bQIl5dA2OZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9OZ83Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9OZ83Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F321F000E9;
	Tue, 14 Jul 2026 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784050645;
	bh=QgkyV9iZP62zNU1CeYPWCDHEi9IJe4PTmY+fNk7ne+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e9OZ83OsfZmfCxyNmNW7vCbBkCk5vq5cDktT2ADgm3VcXAkHBM6OkWkZYACo8f0Eb
	 mhaf7RaF5sXtSSCS4mxrHuM+TTpd5pbuvG39jKduQTY8vpkzQGyFulO1Isyz0J+mSF
	 h4cJs3ZOfBsblRDa4l+xmMrccuwjsCKBQTI1fV4TOLa7WpYgJNUxTZl5qm8c0vHnAz
	 gErNiabwEVW+qG26JebZKRo4R8RSusBwusGSX4v1BqUbsKZeCo089K8Z+m1o5s/bcl
	 G48NDQ60WjScB5AR2czfZyhD9vgA/BHfT5PrHOnCOgMKVDFDNgDxlCbfEb6F7X50n6
	 aZsCbw3XU6I+g==
Date: Tue, 14 Jul 2026 10:37:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de,
	mani@kernel.org, thomas.falcon@intel.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	perry.taylor@intel.com
Subject: Re: [PATCH v1 0/12] perf vendor events intel: update
Message-ID: <alZz0xH7h98uzLo1@google.com>
References: <20260713181757.481164-1-ctshao@google.com>
 <2e182845-6771-473c-a82a-bf96953b458e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e182845-6771-473c-a82a-bf96953b458e@linux.intel.com>

Hello,

On Tue, Jul 14, 2026 at 01:21:46PM +0800, Mi, Dapeng wrote:
> The patchset looks good to me. But It depends on this patch
> https://lore.kernel.org/all/20260708053226.3776183-1-dapeng1.mi@linux.intel.com/.
> Without this patch, the building on NVL would fail. Thanks.

I'll pick that up too.

> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks for the review!

Namhyung

> 
> On 7/14/2026 2:17 AM, Chun-Tse Shao wrote:
> > Sync the Linux kernel perf PMU events with the latest upstream Intel
> > perfmon repository.
> >
> > This patchset includes event and metric updates for Alder Lake, Alder
> > Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
> > bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
> > Lake, Panther Lake, and Sierra Forest, as well as adding initial event
> > support for Nova Lake v1.00.
> >
> > Chun-Tse Shao (12):
> >   perf vendor events intel: Update alderlake events from 1.39 to 1.40
> >   perf vendor events intel: Update alderlaken events from 1.39 to 1.40
> >   perf vendor events intel: Update arrowlake events from 1.19 to 1.20
> >   perf vendor events intel: Update clearwaterforest events from 1.02 to
> >     1.04
> >   perf vendor events intel: Update grandridge events from 1.12 to 1.13
> >   perf vendor events intel: Update graniterapids events from 1.19 to
> >     1.20
> >   perf vendor events intel: Update lunarlake events from 1.25 to 1.26
> >   perf vendor events intel: Update meteorlake events from 1.21 to 1.22
> >   perf vendor events intel: Add novalake v1.00 events
> >   perf vendor events intel: Update pantherlake events from 1.06 to 1.07
> >   perf vendor events intel: Update sierraforest events from 1.17 to 1.18
> >   perf vendor events intel: Update emeraldrapids metrics
> >
> >  .../arch/x86/alderlake/adl-metrics.json       |   80 +-
> >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
> >  .../arch/x86/alderlake/metricgroups.json      |    2 +-
> >  .../arch/x86/alderlake/pipeline.json          |    6 +-
> >  .../pmu-events/arch/x86/alderlaken/cache.json |   32 +
> >  .../arch/x86/arrowlake/arl-metrics.json       |  152 +-
> >  .../arch/x86/arrowlake/metricgroups.json      |    2 +-
> >  .../arch/x86/arrowlake/pipeline.json          |    2 +-
> >  .../arch/x86/arrowlake/uncore-memory.json     |   84 +-
> >  .../arch/x86/clearwaterforest/memory.json     |   33 +
> >  .../arch/x86/clearwaterforest/pipeline.json   |   19 +
> >  .../clearwaterforest/uncore-interconnect.json |   10 +
> >  .../x86/clearwaterforest/uncore-memory.json   |    2 +-
> >  .../arch/x86/emeraldrapids/emr-metrics.json   |  135 +-
> >  .../arch/x86/emeraldrapids/metricgroups.json  |    2 +-
> >  .../pmu-events/arch/x86/grandridge/cache.json |   25 +
> >  .../arch/x86/grandridge/counter.json          |   42 -
> >  .../arch/x86/grandridge/floating-point.json   |   56 +
> >  .../arch/x86/grandridge/memory.json           |   57 +
> >  .../arch/x86/grandridge/pipeline.json         |  140 ++
> >  .../arch/x86/grandridge/uncore-memory.json    |    2 +-
> >  .../arch/x86/grandridge/virtual-memory.json   |    8 +
> >  .../arch/x86/graniterapids/gnr-metrics.json   |  102 +-
> >  .../arch/x86/graniterapids/metricgroups.json  |    2 +-
> >  .../arch/x86/graniterapids/pipeline.json      |    2 +-
> >  .../arch/x86/lunarlake/lnl-metrics.json       |  142 +-
> >  .../arch/x86/lunarlake/metricgroups.json      |    2 +-
> >  .../arch/x86/lunarlake/pipeline.json          |    2 +-
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   21 +-
> >  .../pmu-events/arch/x86/meteorlake/cache.json |   11 +-
> >  .../arch/x86/meteorlake/metricgroups.json     |    2 +-
> >  .../arch/x86/meteorlake/mtl-metrics.json      |   88 +-
> >  .../arch/x86/meteorlake/pipeline.json         |    4 +-
> >  .../arch/x86/meteorlake/uncore-memory.json    |   84 +-
> >  .../pmu-events/arch/x86/novalake/cache.json   |  749 +++++++
> >  .../pmu-events/arch/x86/novalake/counter.json |   17 +
> >  .../arch/x86/novalake/floating-point.json     |  452 ++++
> >  .../arch/x86/novalake/frontend.json           |  600 +++++
> >  .../pmu-events/arch/x86/novalake/memory.json  |  299 +++
> >  .../pmu-events/arch/x86/novalake/other.json   |  144 ++
> >  .../arch/x86/novalake/pipeline.json           | 1976 +++++++++++++++++
> >  .../arch/x86/novalake/uncore-memory.json      |   42 +
> >  .../arch/x86/novalake/virtual-memory.json     |  338 +++
> >  .../arch/x86/pantherlake/pipeline.json        |    2 +-
> >  .../arch/x86/sierraforest/counter.json        |   77 -
> >  .../x86/sierraforest/uncore-interconnect.json |   10 +
> >  .../arch/x86/sierraforest/uncore-memory.json  |    2 +-
> >  47 files changed, 5615 insertions(+), 482 deletions(-)
> >  delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/counter.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/floating-point.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/frontend.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/other.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/pipeline.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
> >  delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json
> >
