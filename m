Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CC15FA71;
	Tue,  7 May 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093998; cv=none; b=jNVkZaDn5XVP2vTxWWPPzGEXt1UxORU/Objf9dRn+wOLJnb7dndghD1HwnkxlFnWnlpE/Tly7edoUnpOaGGU5VbEAjOc+G/zywmSBWOnNWNbq1lD+EIwgcU82iy6PlcwW4I2uzLaIGRWl5pO16q22VdFQddLIyp3cRSmcAo4q0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093998; c=relaxed/simple;
	bh=m1MQLaFDGrfN6P6zi84CA547mIdGW4QH5fBBCzDskGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcwOB5L/v5aHNDnc6eLYxfbqjDas4nTtsaRWeT75XJ17Jh0Z/ZkRaKsI3uFvg1Nzm8oWwCf4abv6iTTm//ZqTGHpzBklEG9rfwCmDJGuFzw49dx3/PZ8pIRHjdXtTnvBt6fCjVcFYQKmn2D/a9c8vq+0ty6Wftt9wLEH+wIJQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bET6S8Sp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bET6S8Sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C703C2BBFC;
	Tue,  7 May 2024 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093997;
	bh=m1MQLaFDGrfN6P6zi84CA547mIdGW4QH5fBBCzDskGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bET6S8Sp6njAjTyzEh5PxJ/obAZrJkfB+xs0RRD04XD+2DffyIaw71eDNvfBUyNNk
	 U7PG9Jtc9nRYPuedBSlCvtzJ9H20k8j0sLzQvSK1icS521V/DaGRcmIJGWUe26E7rS
	 SEyeKRkqunXq/PsvI4peOSv+z2IG8EGRecMC0UQTSF5GuDhluuCC8kRs51NzQ8quKq
	 LQulxLIV7twktBPiL0Egc0z9hn602kOtx3LlA2k6h9B63Rydk+9VEPX42xpXnpLGmI
	 vyGaaEQpZfB9tM3hLsXtL8Yy4AXg54TnAtFNh9UeIwIhB4hA9NuwCDdnlKm3sF4yT3
	 TNDmUpynzoe8w==
Date: Tue, 7 May 2024 11:59:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
	suzuki.poulose@arm.com, mike.leach@linaro.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
Message-ID: <ZjpB65YJcMGIJFoH@x1>
References: <20240429152207.479221-1-james.clark@arm.com>
 <ZjVH118DtAdZKo2v@x1>
 <4ab27bea-ac94-48c3-827c-9f2eddcdd50a@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab27bea-ac94-48c3-827c-9f2eddcdd50a@arm.com>

On Tue, May 07, 2024 at 11:01:07AM +0100, James Clark wrote:
> On 03/05/2024 21:23, Arnaldo Carvalho de Melo wrote:
> > I guess I can pick the tooling part now, right? Further reviewing would
> > be nice tho.
 
> Is it ok if we wait for the driver changes to be merged first? There
> might some review comments which need a format change to the packets and
> then a re-write of the tool changes.

Ok
 
> You could take 1 and 2 though because they're unrelated.

Done.

- Arnaldo
