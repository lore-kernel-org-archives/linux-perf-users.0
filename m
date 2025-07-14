Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54731E5B82
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507776; cv=none; b=RMAqT1SB9SuqKrHoQRDFeKP03zbCeq/uhma50sSHYNzpn3GEMfhWvGnHO87JfEgvWW7pJrUVmzDHm+G9QftBUbolF2xiCTY1UeHaV1AnJAs6mqbNVNshIe5mpkaMgMKkN3gucrDQfS23PmPiI1GBJzXM5nT5gIyxYlILbMghuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507776; c=relaxed/simple;
	bh=7PYeXmDmGTi0TRD3Ms4YdoP5z6Qf1/2r6kTx90111KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg4cuMh1epTbhdGqd64Ud48tw1ySz1QkWsJ6iqP5C9MBLPnNrpDZC8EOW41JsuvuwhAwr6K5XiR+7VteuNl3MaJElnEcrbu9YJ+Gl2RnJLON6CEcMO8HPv1eA6GtQMbHM2IwhYAuzJFiXr2r874N/LfHr3E6qsiUr5U3ZoqD4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B279B1BC0;
	Mon, 14 Jul 2025 08:42:44 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717183F66E;
	Mon, 14 Jul 2025 08:42:53 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:42:51 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	German Gomez <german.gomez@arm.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 01/14] drivers/perf: arm_spe: Expose event filter
Message-ID: <20250714154251.GF1093654@e132581.arm.com>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
 <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>
 <aHUBFGPck-O3vs9b@willie-the-truck>
 <20250714150921.GE1093654@e132581.arm.com>
 <aHUerfpLyAPEc9R_@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUerfpLyAPEc9R_@willie-the-truck>

On Mon, Jul 14, 2025 at 04:13:49PM +0100, Will Deacon wrote:

[...]

> > > In other words, remove arm_spe_pmsevfr_res0() and the two checks that
> > > use it in arm_spe_pmu_event_init(). If userspace tries to filter events
> > > that aren't implemented, then it gets to keep the pieces.
> > 
> > Then the question is: what information should be exposed to userspace
> > so that tools can decide which events are valid?
> > 
> > I would suggest to expose a new entry, "caps/version", to indicate the
> > SPE version number. Tools can use this to apply the appropriate event
> > validation. Please let me know if this works for you.
> 
> I thought userspace typically had midr-based json files to figure this
> stuff out?

Yes, the perf tool records the CPU MIDR in the metadata.

However, I deliberately tried to avoid relying on this approach,
because the perf would then need to maintain a mapping between:

  MIDR -> Arm SPE version -> Events

Given the large number of CPU variants, maintaining this relationship
between CPU ID and SPE version, and subsequently mapping it to supported
events, would be quite complex. Additional effort would be required each
time a new CPU variant is introduced.

> The supported events aren't probe-able afaict so I don't
> think the driver can help.

Although the events are not probe-able, some events are specific to
certain Arm SPE versions. For example, E[23]:

  | Data snooped.
  | When FEAT_SPEv1p4 is implemented

With SPE version information, the perf tool can decode E[23] == 0 as:

  "No snooping" for SPEv4

  "No available information for snooping" for earlier SPE versions

Without SPE version information, it's impossible to distinguish
between these two cases.

Thanks,
Leo
