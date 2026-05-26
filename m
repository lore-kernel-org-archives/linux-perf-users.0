Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A38F7D;
	Tue, 26 May 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755777; cv=none; b=ulL7AiEMrmMEeYrgLrScs3UwlsVA2yqoTU30KFtId46FncI8vHxtoPjda+n0eWXkP2FHamNFiSS2PylqeXCAjJN24mdBCsi/S3AbVnKUqWhgRHBTinunD7NXYLsRtTk6ZXuJjhsHJCzkbOQZLIlxyUn+facErDzvu7Mhy8CzVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755777; c=relaxed/simple;
	bh=qMagAOr9ycXyO1DrUJIL2dh2VuzNJSGKk6PbGWEQnZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe98qgwesXlzJKJBqWNXKXyAX1lWjHyr6W33kksEpsRUiUCqgbN4f5oc8z62QRNfPAOf3LwdjvJi9AJB9hO2RP3i52OC/wnltE4dBLI4/XY/yKT17tYoQcEwPG8OQHIwOOnMCA4teVaJ993YUwLkxSWdFbKiUDd3PG1w+/pShFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0jpn/jL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0jpn/jL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFB01F000E9;
	Tue, 26 May 2026 00:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755776;
	bh=UYSzyCnRfkbGvYmjVFNQOma+CAUK4X7j6Q3neoMpKbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P0jpn/jL3qQEM0a9SLXlroUwzMVDhs5N/pHt121fHBqplnElvGyIULUz33iYLlYDu
	 B0Hm+UOeLshaQS70MoaorFeFnvcgfA0VRNlPxQlJTpVc7zwwqy+0VqTn3D3A8ua0UU
	 Mu2g97UozyCYowT6b/10mSmic4dsbJnJV4qnw0cQVHdiMNrAvkCGoCHhjqrCi8VzH3
	 1n4smKPZdrVQHbRC/fp9mHP1GDGpV41olMU3IjDzNWmpFsciGjnwvldGim4BkJwOOY
	 OvU3qseA8mFYI4xiAgCDK7LmBON8YUJZO5Rve+8VzPDGaijx43RRo69x04XEXZKwNs
	 NjhXvJNvzGN/Q==
Date: Mon, 25 May 2026 19:36:13 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 05/23] perf util: Sort includes and add missed
 explicit dependencies
Message-ID: <ahTq_Wb-S9o3OV0o@google.com>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
 <20260522220435.2378363-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522220435.2378363-6-irogers@google.com>

On Fri, May 22, 2026 at 03:04:16PM -0700, Ian Rogers wrote:
> Fix missing includes found while cleaning the evsel/evlist header
> files. Sort the remaining header files for consistency with the rest
> of the code.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf_off_cpu.c       | 30 +++++-----
>  tools/perf/util/bpf_trace_augment.c |  8 +--
>  tools/perf/util/evlist.c            | 91 +++++++++++++++--------------
>  tools/perf/util/evsel.c             | 75 ++++++++++++------------
>  tools/perf/util/map.h               |  9 ++-
>  tools/perf/util/perf_api_probe.c    | 18 +++---
>  tools/perf/util/s390-sample-raw.c   | 19 +++---
>  tools/perf/util/stat-shadow.c       | 20 ++++---
>  tools/perf/util/stat.c              | 16 +++--
>  9 files changed, 152 insertions(+), 134 deletions(-)
