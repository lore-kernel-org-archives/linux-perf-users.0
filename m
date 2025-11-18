Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E833CE81;
	Tue, 18 Nov 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463015; cv=none; b=m3SJNKVVClozKvp2vYhkFqESn0uS5MS7DJ6CM7L2rgHX0mtUdBRLMJkP+9uapjjRYjgdK/oDGFwfnBonbCSSjj5Y80KVl3NtUFNE7JpuGZpcyasZm72cbxec0yQfQl/qgHE1Kx1erP7Dx6lMc0APP68n+IlPJK94fsc9APblOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463015; c=relaxed/simple;
	bh=3p2xWosiiawhZ1WL68g+FysAotCrIiMIDchdasDr0e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol8Ieiu09B8rfRgCeuQPZBrxWSXym1SkPfrzmFl5c38eWkgkkp+334BIsmyTcVtIdt9ZY7iuzbucnisUkmZkwWfA0Aa3u24QvoKqZm4d1X4/mZnilN6jo7NEUIHgIJ6wPsbdI737Jf5SUeafzc15KZH4T2XK9756Loxk/ZJKmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HpMQjWMM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpMQjWMM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3mtbjmfwi8NbH9cqJIbkNye+XvkZflYAQa9PKPj9G1w=; b=HpMQjWMM8r8lcUaSd3ZgpLv0Ae
	Q75RK2xOL2EbKbj5Lhp7NHum9vQgaldbA9PlFI5w3OB2fkFnSki9UKOmfvgpM6b5YYciyzLnc8U17
	j+7iMh733O1H2H16XE+RS16q5q2XjVcyXSSJr22dqPgHo4M1YjWHY5Ba6qs2Ymb2jGg8NIrFbjWfD
	Frag8mitwk6qcu7eIgGejsU0UBAZ9TpVHCfoD296LNBIBe9VqicPzs1wFAo+nfjqtZqYpznG+7YQu
	5gMFhzaT1a/baBHnbV9IAwFyExKA4Km0tbFaRF6vpFfVlPMcGl1TzvxkC2amCWTppxqjtEyfpnmIz
	pRScR/ZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLJHj-0000000FLyQ-05l9;
	Tue, 18 Nov 2025 10:50:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13568300342; Tue, 18 Nov 2025 11:50:06 +0100 (CET)
Date: Tue, 18 Nov 2025 11:50:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
Message-ID: <20251118105006.GO3245006@noisy.programming.kicks-ass.net>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>

On Wed, Nov 12, 2025 at 04:05:26PM +0800, Dapeng Mi wrote:
> Currently cpu-clock event always returns 0 count, e.g.,
> 
> perf stat -e cpu-clock -- sleep 1
> 
>  Performance counter stats for 'sleep 1':
>                  0      cpu-clock                        #    0.000 CPUs utilized
>        1.002308394 seconds time elapsed
> 
> The root cause is the commit 'bc4394e5e79c ("perf: Fix the throttle
>  error of some clock events")' adds PERF_EF_UPDATE flag check before
> calling cpu_clock_event_update() to update the count, however the
> PERF_EF_UPDATE flag is never set when the cpu-clock event is stopped in
> counting mode (pmu->dev() -> cpu_clock_event_del() ->
> cpu_clock_event_stop()). This leads to the cpu-clock event count is
> never updated.
> 
> To fix this issue, force to set PERF_EF_UPDATE flag for cpu-clock event
> just like what task-clock does. Besides, or flags with PERF_EF_UPDATE
> for task-clock although currently the flags argument would always be 0.
> 
> Fixes: bc4394e5e79c ("perf: Fix the throttle error of some clock events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

So I'm forever struggling to find what tree a particular commit is in,
but afaict the above fingered commit is already in Linus' tree and so
this should go to perf/urgent, right?
