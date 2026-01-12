Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130F350D6A;
	Mon, 12 Jan 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215469; cv=none; b=hCZWM1GuC6sQ3P8mK3sPzJb3F4hzay8LwKEnyCbr66nR64suCpJZg+2c5P7plX4VM+etNPMbrawDBehIinJWnvFk4ayHmRv6obA1uWZWWMqWPkovzqukSy6OKb7bawozVuoKCi5WRguPH6jWNW+TrOp+VuAv0r2zmYXtjviJomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215469; c=relaxed/simple;
	bh=aqmgFJqoq+sRbX/d7uvbp7uVQ1qGOuV2Y/cA3UUSzy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM+w9myIYtjWGgP8RzyVpMjvowJbh7hlBrDXa1BVWeIl/2oYoy8r33rE+pE0518pfMn64qwD1HHwhci3nhBHDHy60QzwfqeIGylcUTBLmcMXoTZSIKpJEv18UKYpeFyQ5CP8CvVf6ImV/dhE0sdtFO0QDrWDDTnNwT00B4TPVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vc/a1bCb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vc/a1bCb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mlLiP8DceCanvvcw8ELE79oxWC0eZ+xK873wn4SXydI=; b=Vc/a1bCbXJp+G6mhuU9r5aHaxm
	2LDh2/1H8wb8nu8vHRx8IfErgaELwSxVpqd4YRl4O6E8q6KpWRLjLdkXOzknmGQGysKFOJAxwSdA9
	EloiR1mKJBBNPhQ9f0JlSJ2IxCF9SZuUU6Xj/MUvpcTIKHXn86Dy0tNxSgPSeF/s5ExBTvPHYmatg
	L0pRrHzxsNrSjA3hY2w1D/BJYn0tImZEblrC1AaBmS3QWiru9wbMavVklpgW3ku4u1yUSfD/N4FGj
	j6NFvZ9t2Lr1J2QJOzfjRPGByrYorjR53lhe+tHpEW1qiQFVJz/Qch++MER51CBzOwGibf6qaaL7n
	H3eb4dcw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFcA-000000037g5-32V7;
	Mon, 12 Jan 2026 10:57:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E3833030B0; Mon, 12 Jan 2026 11:57:38 +0100 (CET)
Date: Mon, 12 Jan 2026 11:57:38 +0100
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
Subject: Re: [Patch v2 7/7] perf/x86/intel: Add support for rdpmc user
 disable feature
Message-ID: <20260112105738.GG830755@noisy.programming.kicks-ass.net>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>

On Mon, Jan 12, 2026 at 01:16:49PM +0800, Dapeng Mi wrote:

> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
> +{
> +	/*
> +	 * Counter scope's user-space rdpmc is disabled by default
> +	 * except two cases.
> +	 * a. rdpmc = 2 (user space rdpmc enabled unconditionally)
> +	 * b. rdpmc = 1 and the event is not a system-wide event.
> +	 *    The count of non-system-wide events would be cleared when
> +	 *    context switches, so no count data is leaked.
> +	 */
> +	if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
> +		if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
> +		    (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
> +		     event->ctx->task))
> +			event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> +		else
> +			event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> +	}
> +}

Is it not simpler to invert that condition?

	if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_NEVER ||
	    !event->ctx->task)
		event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
	else
		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
