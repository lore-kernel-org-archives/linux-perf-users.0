Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF886277;
	Tue, 20 Jan 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941742; cv=none; b=JvlwHtMsE8RGYUq3I7qJ++qjV8C0K5loYdZ4RKG5Opcqr7uU5eEs8gb19P80OQA7oqbAennkH6L9Hias/boUTunTXFcp574ozJno5ZAwj/UztQscJGrwe86s4YLtHlL7J4/yae/vC8azGX9Zczel0yOcmHtpqbOFpVyuIiiyz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941742; c=relaxed/simple;
	bh=U9XtcS6SGnMCQXfPrjDwQsK082uXb9exkeo9uwuSYXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJKBt0cRcezpOQh/UXUiBiWKQ0PUlS7HFOfeXA5eNSTA7yuv4pC0EKgiy7IzJuN2FggNujJPjv8mfXc5lRUUp51F+ICep+0/BOHYj+WekSqtg9Ay/vw5ZqfSDVvmPy9oqYGAN/n01EAWFC/BE4MD2ZTC/dvYRcyZfpI7bvEBB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqxpQ21P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqxpQ21P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884E2C16AAE;
	Tue, 20 Jan 2026 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941741;
	bh=U9XtcS6SGnMCQXfPrjDwQsK082uXb9exkeo9uwuSYXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqxpQ21PI2UhqN/koWbLjfVpCeJPzMraKphjfy1VY6q95j40R0vcDs7jLyxGrGTmI
	 Wq49a8KQZ467OkiIulPTeO39G6xl3VAW4g7ge0nxIr1j822kPfeNgCZFPJ2qE9AwwL
	 7yOHXpx0FQ/2aFGfyUOka7MJQDdZwwa64B5DGEWSnaH4QG7JGSvhVwrFHtHA1mOLXn
	 VSbStBqMybS4lNkQ0KNvSyL2oUh7vChzW72j091BwFyhfTuubrYd4JB4nSlUGdxiBA
	 NrX+w7uldusD9WE+MkFHblyoeXvfmN5qb4hBq0KD263iD3auxj69qvbga+aWveKN1w
	 swhG5lBhl2VnQ==
Date: Tue, 20 Jan 2026 17:42:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf cs-etm: Test sparse CPU maps
Message-ID: <aW_oq49HegG5kZ6b@x1>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-2-56b956a629ee@linaro.org>
 <20260120112238.GH2732125@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120112238.GH2732125@e132581.arm.com>

On Tue, Jan 20, 2026 at 11:22:38AM +0000, Leo Yan wrote:
> On Mon, Jan 19, 2026 at 10:18:36AM +0000, Coresight ML wrote:
> > We only currently test with default (all CPUs) or --per-thread mode.
> > Different permutations of the "-C" option can affect decoding so add
> > tests for some of them.

> > Signed-off-by: James Clark <james.clark@linaro.org>
 
> LGTM and verified on Juno board:
 
> Tested-by: Leo Yan <leo.yan@arm.com>

Thanks, applied both patches to perf-tools-next,

- Arnaldo
