Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40D3C65E0;
	Tue, 18 Aug 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052666; cv=none; b=S6jq7tkkwdUpQdIfqWaVF/LQebqpOMf/nxgSFj/o4G91kfPt7+dKCfGeZOfm6ZjW5DQw7V1wIppYBcHKQi7iU17UORNKQoXU4Zwsfv854EL8WXOxGxmasMaAXuEUwvO6/za2O5sQaAnT9TxTE4IzosrCHYOFOfMIm7vXu20pwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052666; c=relaxed/simple;
	bh=Ls3tTg/kUxRBo2SWN2k1jSvKjqkinzEBa9B+bq64Fig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g338DJ2WofUONqVovHkx4E0e7WXWOuT6psLIma3dbEqcoWKPNLQ88+2D7futl2attNUK9WUtCk8hi7XAh20PxIES5CVtioMBW8piFKOdbNaMK+A/gPfcNo9L+oYX53XVabDC4RVbRyj5HOz4cqZVdsN2hNJRhaSZ1LTqBvlcgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MZxjLLKm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZxjLLKm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iua164pNL6sjMSaxIspO9ZUB8blUcQK4HSZ+59lbvos=; b=MZxjLLKmS9yBgIQSt7981K6t/c
	zsahZ8ypecV4Bp4uRSoieq/AySkH4bsnEotl/oBh802WftHkX1UScNqfAtwmhLr87AuwoKvg61mtf
	MzEyXYFmbFtOqA8Va7bW5HM5+WKtBJ+Vq5L6+0sqJMSlOJJTPY9QL6cHgL5nuEby3XHHXi7DofBiY
	/t+de+lpLpsGAwh1tRsaGeSveh9IEQ7nGwio/CJlvbPnYRF7M2QyZfTlFP+JLfgP4FiOaggE3gFcC
	U4pWBxsKt+a465DatnQORMNHa67FgZFx+OfEoAMTfaE8XHY+gvJYWfm2W5YhNPvAHzajbiTSJwKWU
	PktEZfKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwI1p-0000000Bmkk-23Lb;
	Tue, 18 Aug 2026 11:30:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5184A300242; Tue, 18 Aug 2026 13:30:48 +0200 (CEST)
Date: Tue, 18 Aug 2026 13:30:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Huang Shijie <huangsj@hygon.cn>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, zhongyuan@hygon.cn,
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuqi@hygon.cn, lijing@hygon.cn
Subject: Re: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
Message-ID: <20260818113048.GD687043@noisy.programming.kicks-ass.net>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
 <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>
 <20260818080024.GB1247881@noisy.programming.kicks-ass.net>
 <638cf844-8422-4706-b028-60d8722ce487@amd.com>
 <20260818091913.GD1247881@noisy.programming.kicks-ass.net>
 <aoQ8P8MN8XN4JQIo@hsj-2U-Workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoQ8P8MN8XN4JQIo@hsj-2U-Workstation>

On Tue, Aug 18, 2026 at 07:04:31PM +0800, Huang Shijie wrote:
> On Tue, Aug 18, 2026 at 11:19:13AM +0200, Peter Zijlstra wrote:
> > > >>
> > > >> PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
> > > >> IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
> > > >> for IBS Fetch seems reasonable.
> > > >>
> > > >> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > > > 
> > > > Well, why confuse things?
> > > > 
> > > > As you say, PHYS_ADDR is for ADDR, which is the *data* address, and
> > > > FETCH is an instruction address, which we find in IP, not DATA.
> > > > 
> > > > What would be the purpose of confusing things and making PHYS_ADDR
> > > > relate to IP?
> > > 
> > > Agreed, that would create confusion.
> > > 
> > > Do you think we should introduce a new type PERF_SAMPLE_IP_PHYS_ADDR?
> > > I didn't suggest it earlier because I thought it would be overkill.
> > 
> > Well, that all depends on how useful this data is. As is, I see very
> > little words on the benefit of having this data.
> 
> I just use this patch to track a program's memory footprint, including
> the front-end(Fetch samples) and back-end(Op samples) in NUMA server.
> 
> So I also think there is no need to add a PERF_SAMPLE_IP_PHYS_ADDR for this.

Ah, so I think me asking about the use of PHYS_ADDR previously, resulted
in the two PAGE_SIZE numbers. I suppose what you're looking for is
PAGE_NODE.

The trouble with physical addresses is that it is very hard for
userspace to do anything useful with them. At least the node mapping is
somewhat doable I suppose.

