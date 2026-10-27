Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133731;
	b=DGXMhZAV6yoVZZFhVGoLG+SYXpLo1hEZYD2Gv3xYhleBKU9y8lknXXmv1uFjPQDxQoU1
	 OPqkIg7ZUKq4ke7GXB5kuHyughO3Cjs93SWk67MiB5wrEA1unIF5AkVVvfUKk3RmeVpgI
	 DZyaUY+g5n7uPhe0+2jTDcLWy2lXWLSdAAoy52cPiBwzXypBwi+sKAtlyvkOQStJPVEtk
	 wlUSU5pAfLvRiD/GVXUQ6x4qeHdAJyzaYPJqCqIqhpgFlNwaL4d600Of5iGaMl/dFKj1y
	 EzXTnh3LePTXi2cUY/LzDRkpVtpjtvYhc+gz5H3gQnoa1VuAqrC2auHvzXhhcgVq/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133731;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xsAXCmPy2AQ6xbWetWn8WV29UW1AEYzY6mgJ9A0JnoU=;
	b=f3Cv2rFVPa3hdw2hpxo4Qf1tSw9ybR3dJTdj5em3ao1ULYG/qgXUCmaVHjcs13njPeK/
	 gtxmJ/ZVhzuYcPUwzcyXeA88sWS0x69Ik0X6a59p5oBZl6Q1/R3B7QC8XFvTJlXlZU6i2
	 6xB28kMr8pIo4wjSu2jQPdtmAAsIvGKbJ+lzU7dZ5WsRO0CyRsWxX7lP4JL301TVLmnPv
	 kFRUPDYu92gKbHsyR8qeD5ttIrSi6E2uotRiysMcwWrY+9uCTOiHDLPOjNIYTqc8U7VLN
	 sezWDxM72HU34gvzJ6tt/lOxnJqxu8IfSX7C41o6EelIyQjFmQ5AEgqBg/wEsjDe4kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoR1pyrb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B4606A31D;
	Tue, 27 Oct 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoR1pyrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9E71F01825;
	Tue, 27 Oct 2026 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133731;
	bh=xsAXCmPy2AQ6xbWetWn8WV29UW1AEYzY6mgJ9A0JnoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JoR1pyrbKliOTl832yMruH2Wv1mnDA/1SHx2q1wwi9Y4BuMI1zd5PVFubby1xx0Bv
	 e+QOjvl2R5iWZpSWOiKzBo9eqUPMm3YhCmr73b9HW5pQ64/lD9DWrACWiduFN9d2+T
	 DgJpSLw2nmAAEdhwTDcr81u31H9a2lxgmQOoKPNHkgACT6KgPqO7qo1Q90yUcALmMq
	 l2kgslucL4936HG+AVTWclD2El2YAsxoiDvv0NNteFFd4BRacr42vUUmJK8Yt6xU0m
	 s7WAXbnNVhGahsaVvQuqB5nLuglhOHY5+B5DQcVmlSfVi8ZvQ6ifRVobFP6CY9yAsH
	 Egfy1ZHb+5Qlg==
Date: Tue, 27 Oct 2026 17:42:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Alireza Haghdoost <haghdoost@uber.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alessio Podda <aleph.pi.gh@gmail.com>,
	Michael Liang <mliang@purestorage.com>,
	Shimin Guo <shimin.guo@skydio.com>,
	Tanushree Shah <tshah@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf: Fix libdw addr2line fallback, pr_debugN
 overhead, and cumulative hist decay
Message-ID: <auEMn2SA50YBXBPC@phoenix2>
References: <cover.1792995775.git.irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792995775.git.irogers@google.com>

On Sun, Oct 25, 2026 at 11:50:42PM -0700, Ian Rogers wrote:
> Three standalone fixes found while profiling `perf top` and DSO symbol/DWARF
> resolution:

Thanks, applied for v7.4.

- Arnaldo
