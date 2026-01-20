Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F3413241;
	Tue, 20 Jan 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905907; cv=none; b=jRdX54jtFF7WTknIbbSM9GB3LfN3AFY5jen849FgLGP+EyBGBRg457AKr/ofgMGpaBM6zxdnydKXpXyNcJv/lNGS5sbcVYEJuGbo0HFNj6sUsmDm9zbQ7J2gXWZuDdTyNqztN7Uv7/9YLYHj8Bg351aulJ/y+DsZzkGfEcznMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905907; c=relaxed/simple;
	bh=rMyCI9rSdKmlc9sBaH3BxVnGNjGYLnxCHZ+3HQB9wyc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsmjUxuBajaAv+xoSlE5qSetMMTPUIiTDMrop5ZmCiYBBrwkWJGmNY/z6fLcpnUjij27Hz+3u8Nbr/nRFwvlpwFez1YiHwOJOJZmt4yzbD1x6v0LLba4E1shNuDtM9biZ8nNOskFmQuCyyLWtNhN+XRKTImT5ADgCUprTChyiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93E291476;
	Tue, 20 Jan 2026 02:44:53 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA503F694;
	Tue, 20 Jan 2026 02:44:59 -0800 (PST)
Date: Tue, 20 Jan 2026 10:44:57 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf cs-etm: Fix decoding for sparse CPU maps
Message-ID: <20260120104457.GG2732125@e132581.arm.com>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
 <20260119111509.GD1286628@e132581.arm.com>
 <3b06ea25-2516-406c-8b78-c359d3fb2aa6@linaro.org>
 <20260119145337.GB2732125@e132581.arm.com>
 <dd9a3cde-ea9f-4c53-b537-f15767bf4d99@linaro.org>
 <20260119153846.GD2732125@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119153846.GD2732125@e132581.arm.com>

On Mon, Jan 19, 2026 at 03:43:18PM +0000, Coresight ML wrote:

[...]

> > > > > > +		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;

> Indeed, per-thread mode needs to be handled separately.
> 
> On the Juno board (6 CPUs), I see "etmq->queue_nr=6".  It seems a bit
> odd that this value is used as the index.  Even in per-thread mode, the
> index is still set to 6.  For correctness, should we instead set the
> index to the CPU ID, and use 0 for per-thread mode?

Sorry I made a mistake.

I messed up "etm->queues.nr_queues" and "etmq->queue_nr".  I can confirm
that "etmq->queue_nr" stores the CPU ID and 0 for per-thread mode.  I
verified the patch:

Tested-by: Leo Yan <leo.yan@arm.com>
