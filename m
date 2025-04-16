Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CC41C63;
	Wed, 16 Apr 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833380; cv=none; b=XsvWVR96ARh0wz01L6AAw7niaKy+W20FPPgRRFOIv0WxdxYVX5wpJMA4iDo7JCOFa1bMIxc0ovGoNbh4+mZYDRlhQjqaLQ5ZUcCblnjyw+oIQyh/MyKdTQO2bqsZwNv/y5WoQpvMZHCeIdY0WAsFsRQHCW1BcSSPtiCKPvKAR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833380; c=relaxed/simple;
	bh=5wV13rrVkEDuGNmYV/mEsctwGgXsamDgPO9w3Z91qjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKvtuRStxfKBybncSL8Mxf/t3pBEO0ARYL0UDNhNHaWJFvw7O024+uLbhFMSxH9SuPqODuk/sSBkktiwprdUr8kQviBaRRRpe2eh5Yai17oT5q9KMLIZLzBG/vR5WVY1i1sstVfl06EWZdG/Yx8U88uRUVQDPEGECr261NjbSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KUK4eOTs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUK4eOTs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mrDLfqxt1x8j6OHaeYiFz7AQul6goHuC1IfjL7cTrvo=; b=KUK4eOTs2gccm8jooWH+YjPQFn
	EEDAg0jC676oMpEYrsJJcmIXMaX2mC0A5cD9JWV7x3ajU7V90pGkVu+mBzApzulPQ8Eyj1OVmEd3e
	gdC4GwNFywB4siIfxRdkO+Cs2iFjSoph8/yimthiwl7Fmdniv4jMrkImtSIlVv4wfkGAb+DSuRKrJ
	UPPMex+nfulESy4v83aRNzJhkzaYKWRW2Ie9otX5iaIqMLt+7Q55E7DccQgPxtqS4HajVzXBa7SFk
	OE9PNWtcpEl40e9aX9QST4bYg0I+r8Nk3lFrWWEQ0u3MX3lI69+PStEFavaUHSAcTPoxbVLS1kHS0
	y4g1hIfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u58rj-0000000AASu-0GMH;
	Wed, 16 Apr 2025 19:56:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74F8B3003C4; Wed, 16 Apr 2025 21:56:10 +0200 (CEST)
Date: Wed, 16 Apr 2025 21:56:10 +0200
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
Message-ID: <20250416195610.GC38216@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
 <20250415135323.GC4031@noisy.programming.kicks-ass.net>
 <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
 <20250416153226.GC17910@noisy.programming.kicks-ass.net>
 <e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com>

On Wed, Apr 16, 2025 at 03:45:24PM -0400, Liang, Kan wrote:

> I see. I think we can check the constraint table and update the overlap
> bit accordingly. Similar to what we did in the
> intel_pmu_check_event_constraints() for the fixed counters.
> 
> I'm thinking something as below (Just a POC, not tested.)

I'll try and digest in more detail tomorrow, but having overlap it *not*
a good thing. Which is why I've always asked to make sure this
doesn't happen :/

At the very least we should WARN if we find the dynamic constraint gets
us there.
