Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5B1A3142;
	Sat, 13 Sep 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774676; cv=none; b=bBuNosnn+5YixvV/6PMeuoJPnAKGW1Ip/TEbCm5m8imLXuxBgsSxl2ZXgct6EOiW3NQvoWWMTtdbRd3AyrD4BVEaoC3YtDUzA1JABTHt0BlKC1Xxr9IlkuFTDQDzDRn3Si3x2r8+XRWEnDooKVndWd91OqQ/hGQDSyfnKyCo0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774676; c=relaxed/simple;
	bh=xkegx/Z21qGqjTPNAUri8Dbkk6SWbOWhpz7wEsBGvGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a34lVUPUe/uGrYTotc9QIlaEQnoSHh7gnDCSjLiJ7iOq7l9C3ueyJB5s3T8lJKosgJJt1Hs7WI38ZEtIJglMfPo4WtsdZjAySx+NgsZWy1hD+OE9Ini2E/+9ZzYM9oY20gpyDpdFTqTF3oi0GC4bGxRTWKzSVtYQN2zd11qfv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p96ks/zW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p96ks/zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADB3C4CEEB;
	Sat, 13 Sep 2025 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757774675;
	bh=xkegx/Z21qGqjTPNAUri8Dbkk6SWbOWhpz7wEsBGvGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p96ks/zWaDDlQyI4WJy2+gLzzREic9f56WhZfTlSy5lAK7zT2UNq5O7EIJx+9CLxB
	 564bOSkbr7KP9jgiCqa17xQjqDFPjdbkFhjk3MOsUa3Zz7owHihBKTZPsTYEtvGzuh
	 aZMoVoTkGkAiEij6UWNrI/REP1dRz9BCshuOo/grVFmoa4vZYUpnGkcWjZenNjN6fK
	 Lwsh7e7kMbgw/ox2+v6LzrebcJhszD4C0WSOObfE90Mxl0jwZ6Z/VdDswqKW2j1GTX
	 ptIDJdxoMHgdXgQ49BrXEyfzm0DCwbMu8VepL6OOT6R9+7MsojMG8TIdMm13RP9Ci1
	 HT0XzqT3rOVOQ==
Date: Sat, 13 Sep 2025 11:44:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Collin Funk <collin.funk1@gmail.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
Message-ID: <aMWDUGfg7kVlbjE4@x1>
References: <20250913000350.1306948-1-irogers@google.com>
 <aMS9uykyD5u5gqWf@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMS9uykyD5u5gqWf@google.com>

On Fri, Sep 12, 2025 at 05:41:31PM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Fri, Sep 12, 2025 at 05:03:50PM -0700, Ian Rogers wrote:
> > If not root and the perf_event_paranoid is set >1 swfilt will fail to
> > open the event failing the test. Add check to skip the test in that
> > case.
> > 
> 
> Fixes: 0e71bcdcf1f0b10b ("perf test: Add AMD IBS sw filter test")
> 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
