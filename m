Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931532A817;
	Fri, 12 Sep 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701663; cv=none; b=ijArKtPEOeHHb7IQf0GCw8I0cl1SiygKWD5VR771DJcjMu63GADq7vN4d+Qf0RgrJQJXd+MnLk/e+QG5sPS+1FgQUtmNUhtaNEXgZvBVianNvShdDz4Bmm0/7Na80So1awT1YmW26c+Wn+tDIOGcaHt1E0+vde4xA/BsrHu0bJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701663; c=relaxed/simple;
	bh=giny/t9N6iQo9VgTX/KMvXx1csABBtT4GXJJNz+cGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lluvOYTv0bjT7Y44XJDuDblHm2Umy1if3y/f0ythxrc46HRagWf1iOAr36HpY4tqoASlVaaz+5HvWTR3hh4W07T6uzre98E8rZ9gb+prQs41/NUvFkH4ExqBH8J/XYks5qMydLyvxy1Dnj7h8qotZBggNJmjGrskHRXVH9SP+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxOTH7q1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxOTH7q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9094EC4CEF1;
	Fri, 12 Sep 2025 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757701663;
	bh=giny/t9N6iQo9VgTX/KMvXx1csABBtT4GXJJNz+cGzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxOTH7q1UIMLIqN7+St3a6ke0DPxW51/2hEN6KE2K9Wugc6N3Z+FSUW5XJPuWCxOp
	 0bukNnj+/D5FS5ezcLbAUBEIxXnW3Bm7r8fuHedpMr1n7C7QnyQBGRuRpfRhJEen4+
	 Xnk+7ACAf3zc095OmEqes5RhJhOfW3DgAjHQ9Bb+0qD9DjSsaH0nfRkJLA96Up/eCs
	 HBQI77oq/fYy4JFa6tHBryIAz4AicBcJM31ZcpzelcpQiYONSf5jrFohCzNuP36sLW
	 dKWjvGlLHDe1CR8CgEo3NLWfFNk2zGUfiInh3MwgwKwxot5rKgqleKUsyPEChMO2BR
	 tVNlRhkxykZFA==
Date: Fri, 12 Sep 2025 15:27:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf vendor events arm64 AmpereOne: Fix typos in
 metrics' descriptions
Message-ID: <aMRmHFNWjB74Bwy8@x1>
References: <20250910195214.50814-1-ilkka@os.amperecomputing.com>
 <20250910195214.50814-3-ilkka@os.amperecomputing.com>
 <fc2ee38c-b163-4b7e-9ba2-c2b93d0fc691@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2ee38c-b163-4b7e-9ba2-c2b93d0fc691@linaro.org>

On Thu, Sep 11, 2025 at 09:26:47AM +0100, James Clark wrote:
> On 10/09/2025 8:52 pm, Ilkka Koskinen wrote:
> > While fixing a typo in "l1d_cache_access_prefetches" in AmpereOneX,
> > a few other typos were found in metrics' descriptions too. While AmpereOne
> > doesn't have the metric, it did have the typos in the descriptions.
> > 
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
