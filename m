Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC28267B1A;
	Tue, 25 Feb 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484500; cv=none; b=ucd/qDMWYiOiyn593+X5K6Ysw1zvjUqdlvQy4NadQQ5blWJuJh91WYgEpt+qFpXr+tFAVwxDR9KeHG1LgOESLkJJyUuSoEIAAhF2asS8vZLuHn+4DB2jtEzYlPslfq3HVTvVpbku/ksVm5Y3hcio+6UrsjwRzJHRsrdjXSOAlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484500; c=relaxed/simple;
	bh=E1UiImK7HiBVAZTVZn9ze5hYX73BB1At/dEM5V2uerQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPilCcUIYXEHWcpi7rSgTwVg/MhvYYndbTExlbK+QCFM6hcM2xEt87+RdoTgYKC4pWCxaWPtvmh4yt7TKr/XRZt5pNWagc4y4ruHrDLQ9JXiOAGb7Ub03V7hLyBf8xlk8ftDxZue9zBqwubl3xbQtHbpLMvlNoLIf5y66ae16VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OQ5LQnBL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQ5LQnBL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3JYW+lzJ9mJjGI/TG2SfSa1bdDtNck9SjC05vgZ0aSQ=; b=OQ5LQnBLLPSt9yHOBvRbHlY1BE
	9uU8rXBDMlGJ7T6O+chUSo389a2gyBEuTfDWMhDTfBmCa7E4vQySMf/+rFFp7YWz3KqQPxtnhBIO2
	jZtXZ8jboBd9KbYT1tL9pHZSxm4qPG4qYnTd+Yr5UtKUWtSgK6eX/XBi4pJoXIOcUmac1+xWrRd/4
	J+N16M70oe+n4uRpo3gxpF8cXCGIMBbHyD3zC4XI8tXL9V0+uAkfsu9GyRV8uIshApzcMmn+1uPA2
	0hGdNOF1fXDGdSIMwO4FhIAWy2o1+iiAds3zdbipQ6AVUTa3DEMDGQHMmmYCtXjvY2aMUWf6c5Q7f
	MpnIOCwg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmtWV-0000000B9wf-1M2L;
	Tue, 25 Feb 2025 11:54:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A43C7300472; Tue, 25 Feb 2025 12:54:50 +0100 (CET)
Date: Tue, 25 Feb 2025 12:54:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 15/24] perf/x86/intel: Add SSP register support for
 arch-PEBS
Message-ID: <20250225115450.GO11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-16-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-16-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:09PM +0000, Dapeng Mi wrote:

> @@ -651,6 +651,16 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> +	/* sample_regs_user never support SSP register. */
> +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
> +		return -EINVAL;

We can easily enough read user SSP, no?

Should be possible even on todays machines; MSR_IA32_PL3_SSP provides.


