Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053D29ACE4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752632; cv=none; b=n0ZxldqisZDlQf8oqlLK/U6Gl3o37BlXRIF6DzKD6c+D/RSp8yUN7mYcYq5Fwr8E/a2H+YnQrk3L5mPmW8PGmtacanfIixf+eypBupsJUAx/JGAm50ZQehQd+cSe7QwfK0te6bJf0IZ2vEdL2tCl8cDJL1s+nmWYp4DfhcwHx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752632; c=relaxed/simple;
	bh=6uGhnGeIROplMLbWKJi+hQJH1Pv8f8Jn73TRI+B3DjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjCkCH5xiNGoE32IM3fQUWzaObsURcuiTrY3wfF4fbCjPXgpj8+k9F/tGEuh7//OrbpofQ/tmR+M3yCO8fkwuxsK5sWIuz89lOvoNSpTLspTGMJ5EzF5wcxkufbzTcmICFfxEAMKLqgCDk4U/4P+qEJXw6zdm5JwyYWZyG1b4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWDFeqpu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWDFeqpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90063C4CEE3;
	Thu, 17 Jul 2025 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752752632;
	bh=6uGhnGeIROplMLbWKJi+hQJH1Pv8f8Jn73TRI+B3DjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWDFeqpu1wpW9lQnbm7r3vnK65+k2/8NqWUgTzdpBDYXQ4LjXVGKwfqjGwiLa6//F
	 zVT0g2+P2X1lBoIowaCY5SwmSZmF3WGCesIC78MypjeoNcBm/yNgnCfpzThxEyhTUF
	 aWgt8ExwkjEyfMQChTtPw1svY7EoKBITHmidm3sFsjsfzGQtIklK6B6H+8geOTfBmQ
	 Cnh5iy1auCZ1lhAYnJTvf/lM4LS1ooDOv+hqyYLZtH6g5O8rA4KTb3uZVG+PpQF2va
	 MxFevnQ2ajttxyILn3m2GvXwbWvAlU5rVcUKBAKfZJlDEuoQ4D8X1yjWo0z08sRqcQ
	 NOpIwoHebajuQ==
Date: Thu, 17 Jul 2025 12:43:46 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <aHjh8sqeEPQDVg0z@willie-the-truck>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
 <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>
 <aHUBFGPck-O3vs9b@willie-the-truck>
 <20250714150921.GE1093654@e132581.arm.com>
 <aHUerfpLyAPEc9R_@willie-the-truck>
 <20250714154251.GF1093654@e132581.arm.com>
 <f3393b26-a1ca-4d8f-9c22-0330956090b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3393b26-a1ca-4d8f-9c22-0330956090b4@linaro.org>

On Tue, Jul 15, 2025 at 12:15:07PM +0100, James Clark wrote:
> On 14/07/2025 4:42 pm, Leo Yan wrote:
> > On Mon, Jul 14, 2025 at 04:13:49PM +0100, Will Deacon wrote:
> > 
> > [...]
> > 
> > > > > In other words, remove arm_spe_pmsevfr_res0() and the two checks that
> > > > > use it in arm_spe_pmu_event_init(). If userspace tries to filter events
> > > > > that aren't implemented, then it gets to keep the pieces.
> > > > 
> > > > Then the question is: what information should be exposed to userspace
> > > > so that tools can decide which events are valid?
> > > > 
> > > > I would suggest to expose a new entry, "caps/version", to indicate the
> > > > SPE version number. Tools can use this to apply the appropriate event
> > > > validation. Please let me know if this works for you.
> > > 
> > > I thought userspace typically had midr-based json files to figure this
> > > stuff out?
> > 
> > Yes, the perf tool records the CPU MIDR in the metadata.
> > 
> > However, I deliberately tried to avoid relying on this approach,
> > because the perf would then need to maintain a mapping between:
> > 
> >    MIDR -> Arm SPE version -> Events
> > 
> > Given the large number of CPU variants, maintaining this relationship
> > between CPU ID and SPE version, and subsequently mapping it to supported
> > events, would be quite complex. Additional effort would be required each
> > time a new CPU variant is introduced.
> > 
> > > The supported events aren't probe-able afaict so I don't
> > > think the driver can help.
> > 
> 
> If the RAZ/WI for not implemented is guaranteed, can we not discover the
> supported filter by writing all ones and reading back what stuck?

That might be the best option.

Looking back at older versions of the architecture, unallocated fields
in PMSEVFR_EL1 were RES0 in revision D.a of the Arm ARM but everything
became RAZ/WI in revision D.b, so the whole reason we were maintaining
these masks in the driver is no longer relevant.

As you say, we can just probe the thing and report the result back to
userspace.

Will
