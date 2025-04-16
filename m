Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FF1A0BD6;
	Wed, 16 Apr 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817561; cv=none; b=blLtym6srWPhxxVxd65dURknFGJBvtpyOGGakG7AEOifFKGHSezjEt0cnekiBOUxMvLoACUraFweuQ0j57WWY2eyiAcCyrAMWMOuiTKIvyTlbtugpGBY6U08h23m296W/wAcz3Jp6A61d4LMvyuRs+8EpqOmsFBTw92nAjO3Rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817561; c=relaxed/simple;
	bh=+DEB4buvUkcr0ScnFRrV+N60OYURSVURedGqXEXvmZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzcP5EjqQwFrMcQsk7SZSF5dGbd9NyfAt57UoAReUTxCTZr9gtGtNsADV682+vGz59ESXJ6YZ5UQLrwA01+/IYAbwbMBTuczuf8SoLD+7sb6PWQjk9f9wsYJHkgGTecBKBcijO8w39XsMsX5SuJi9LB9ank0J5NZirYy4KMZRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SF/wSLYX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SF/wSLYX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p0m5NUPN9uBa6K88Gs2hZG/MKzDGj93gJd39YPVQ2o4=; b=SF/wSLYXNRxwe1ZhQ2VLRL7n1Y
	aUEWNvdUyZKp0Pd7BzWtsWHJy9j4J1UDeewpJM6fUiW75xHE7mVVtArwzy8bJET9EV+Mk2D3QuB4C
	/0YoL46bFNsmQflXiL4fQ2tbufQPqB4tNZd0he+P6W2jy5OWZXCbvSbraB2jxRlOoGNkaIflLM71/
	k90DR4jqPM8/FS+prXoH8WuX011B4cjIeHH/OODGv7QElz8XA9j0RYztiUm4vDEaqcp5Zxh+1K0sJ
	R8pr0wQi+uDPJksHVhgNtXjhCdAYUQswYJ86oseslYRZFanO1NlErtSI0onqVE952C1WfBgzcKlG5
	r4fCqSJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u54kU-0000000AGWZ-3gIl;
	Wed, 16 Apr 2025 15:32:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 860553003C4; Wed, 16 Apr 2025 17:32:26 +0200 (CEST)
Date: Wed, 16 Apr 2025 17:32:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20250416153226.GC17910@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
 <20250415135323.GC4031@noisy.programming.kicks-ass.net>
 <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>

On Tue, Apr 15, 2025 at 12:31:03PM -0400, Liang, Kan wrote:

> > This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?

> The dyn_constraint is a supplement of the static constraints. It doesn't
> overwrite the static constraints.

That doesn't matter.

> In the intel_get_event_constraints(), perf always gets the static
> constraints first. If the dyn_constraint is defined, it gets the common
> mask of the static constraints and the dynamic constraints. All
> constraint rules will be complied.
> 
> 	if (event->hw.dyn_constraint != ~0ULL) {
> 		c2 = dyn_constraint(cpuc, c2, idx);
> 		c2->idxmsk64 &= event->hw.dyn_constraint;
> 		c2->weight = hweight64(c2->idxmsk64);
> 	}

Read the comment that goes with EVENT_CONSTRAINT_OVERLAP().

Suppose we have (from intel_lnc_event_constraints[]):

  INTEL_UEVENT_CONSTRAINT(0x012a, 0xf)
  INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff)

Then since the first is fully contained in the latter, there is no
problem.

Now imagine PEBS gets a dynamic constraint of 0x3c (just because), and
then you try and create a PEBS event along with the above two events,
and all of a sudden you have:

	0x000f
	0x003c
	0x03ff

And that is exactly the problem case.

Also, looking at that LNC table, please explain:

  INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc)

that looks like the exact thing I've asked to never do, exactly because
of the above problem :-(
