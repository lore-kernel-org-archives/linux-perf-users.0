Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834624E433A;
	Mon, 28 Sep 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613516; cv=none; b=Whpl1VsQfcoJhidnFpniAw/FVDqSXIHXP8gfFNTTNoSVTnCokJL3SCoVXbfMpslrxGnDYNtvYMmPyk5JEfkyzTuv89iD9H1+ixe3Mx1FghmQuZEtmJHTXPkCw0DkD7Dn/jzayWb0BuMWcXq2PKtBM1aHEHTPHLxH/g0BHuG4094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613516; c=relaxed/simple;
	bh=8IGYsrmQjDLwYeUaicBX1VfgAQ0acsDasG1WuvpdtNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRAIYGXSw3sn6esc/BUzDV58WGasB/lJgSzL3HROZCi5f6eyyeVQoV/TeCtFfoQ8dMHZKq7X9QS9ZBcFnuHODdlECb8IO2FO4EuhQIN6qhelQX9GzHWl7DQZvcXqsCkOe8Ak8RZ74hh9sWR2dWCPGu4CSlgW+O8sNNsgjMhoBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXtWRFGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXtWRFGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9FA1F000FF;
	Mon, 28 Sep 2026 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613515;
	bh=EEs6XBwb7wcETBBUBOE2KSWJ90Sk3QjaTWGPUFquhvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nXtWRFGVW/S6IpHnH0eA/6SNG4v/wN22c2Sra6jafao5O6fKDxAWKmdkVw2/SePqr
	 D2SHC1cpXg+Vz52WG1LSYqfmuCygl/SAtZwW7TFwU5BQMc2Vm2SU3+mc5WQ7OMGfXc
	 gbbHgyVIyAAwwSHZl+CaSpGmbSBcbcAU3zB/qIilt5NBu9YFUIbR7kfIjHlrAcMfZU
	 VLAz3as3ShWWpG0XIeIosNeF83ugJRZeNxC1XV9NXaQ0akM75Z5YzfFbpVj4LwWf8V
	 yf09QtO3VRFAV53Lti9neU7yqeQJrDUQaTaOzlcA8mh+SyrzFlxX/LituGXwOTy8Z3
	 ajZj5UFxQbb2Q==
Date: Mon, 28 Sep 2026 18:38:31 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Markus Mayer <mmayer@broadcom.com>
Subject: Re: [PATCH] perf build: Improve fix for "argument list too long"
 error
Message-ID: <arqYB8gNWWsCpp51@x2>
References: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com>
 <8bc8b276-bc4e-4a6d-b770-5b02c79946d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bc8b276-bc4e-4a6d-b770-5b02c79946d4@linaro.org>

On Mon, Sep 28, 2026 at 10:15:47AM +0100, James Clark wrote:
> On 28/09/2026 09:55, Benoît Monin wrote:
> > Express the orphan file list as paths relative to $(OUT_DIR) by
> > stripping the common prefix and restoring it with printf, the same
> > approach used in scripts/Makefile.clean, so the shell arguments stay
> > short.

> > Fixes: b6712d91f8f5 ("perf build: Prevent "argument list too long" error")
> > Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> > Tested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
