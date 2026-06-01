Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036233AD8B;
	Mon,  1 Jun 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302493; cv=none; b=tzFzIclgPt7jEaVZ15Ebh73CwRDstnm2SOWbBrrvHUg6RBqBUfmq1OqfOxoYSra0cT0NsI8FZo8Upy42dffAuvwnt16hXLkwz1tkTECKwBONM1kMcnfFKKBRhPfNhQ9N/dVhn/OfYIuQ4jdnzZIwDkEc/mZXdcwu4GIGJ1XEbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302493; c=relaxed/simple;
	bh=LMbQNbbosE23r8NICGcafZV2XSlutvfWK58auoUVBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFXuXQa8TCGJJkrT2OHHonBYMFXG+p8HoYNc9tV0/TSxCR4Y96vy4qMAJYfLffZyiZS/u+HLxWi7MzRuDp/+kLL5nqQ4hxwW0ID4IxNkPEonTOQ4XO9dRPxzTUKokr5cGDHsicCSQ1dTTHukQUJbFCaAMsdfkFCgI5P1E8sm3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LnpsZWwm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LnpsZWwm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nZGlAvyyBUpC/yrv0k0VZZ+hUZOuVhmy0A/Cwg4Zlh4=; b=LnpsZWwmLbNCTWtv920zxjctm5
	hJ3B2ThMSSvRsWlLySdrpXM8EHz5MXDwbY9BccI1yreHVUjyKzknabS1nKonB/o9pzCk/ZLsoLobO
	4TGpGIHW5BgCmUukHLHBmTfmY4UN3FNHgaz8+qU32Nup7v3ZpCPTJA0m7oL5AmP2wt9ENqmpq9G5u
	K+uLsEKflgCorZ2tNRo6KiXT9Q4wtfSgiMo4OJAsIaPEWCRajqeM3gx/GOx+gVN2hjF6xE8fEE2Nt
	2PUX8WEW1+5YuU344Ml5LtNW80sFaRCdSZlSoRk7BBAPpGHP2eW+Pylv2Oleak6tfsSmgVZ2OYLRS
	BQ4Fwh1A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTy0B-000000064H7-3XkN;
	Mon, 01 Jun 2026 08:28:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B778C300454; Mon, 01 Jun 2026 10:28:02 +0200 (CEST)
Date: Mon, 1 Jun 2026 10:28:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v8 07/23] x86/fpu/xstate: Add xsaves_nmi() helper
Message-ID: <20260601082802.GK3102624@noisy.programming.kicks-ass.net>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-8-dapeng1.mi@linux.intel.com>
 <20260529113218.GJ3493090@noisy.programming.kicks-ass.net>
 <5f60950a-0cad-4d05-9997-3a8af307992a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f60950a-0cad-4d05-9997-3a8af307992a@linux.intel.com>

On Mon, Jun 01, 2026 at 10:31:59AM +0800, Mi, Dapeng wrote:

> > Sashiko raises a fun point vs skid; if an exclude_kernel=1 event trips
> > inside the kernel this can potentially leak a whole pile of kernel regs.
> >
> > But of course the same thing is true for the existing setup. So perhaps
> > that doesn't need to concern us now.
> >
> > There used to be discussions about this case, and I think we had generic
> > code to sanitize such boundary events, but I can't seem to find that in
> > the current tree.
> >
> > Mark, ISTR you were involved at some point, any idea what happened?
> 
> Just consult this question if current code has such kind of boundary check
> with Gemini, his answer is no.

Yeah, correct. There used to be (I think) and there definitely has been
much discussion on this point. But yeah, the current code has no such
checks.

As such, I'm not going to hold this series up for that. So don't worry
about it for now.

