Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB41C2443;
	Thu, 31 Oct 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394731; cv=none; b=lAt2atzU1QMpzrGLa+MgbJw0rxJDsgmSHmKj+wRsAtosEy49pbgTC5QRbnsM7pk//kpNHQw3Cqx+SAoHd5Mf3645Lt0VO9Gh8jcypPC7rub+T14zger1Yb/CjZ/h5lh+sXWjzrcqIexlMXqUtfL6f1RhyINUffb1rnOwXNieDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394731; c=relaxed/simple;
	bh=S6ui0jUNmLRpfkePigYcEav2MlplNOKq2rw+nywpyi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fxYfF9kj5qOcE4v6WQQROXHs7NAcxcE7DXedtKIBIBbInkGOh3napy2/pvU7fBb2yknB8mq5bZjAoOGlno/baOIxL+IDI+5Tr4lgB0psIGfvbTO3EdWBoQY7aoPI7rFn6Ebtot6TCXmi3DCvx4vlkN3ycf69oTdF8zwMiiZZt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXU4H8e2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXU4H8e2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35127C4CECF;
	Thu, 31 Oct 2024 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730394730;
	bh=S6ui0jUNmLRpfkePigYcEav2MlplNOKq2rw+nywpyi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GXU4H8e25gOVMUlTowR7d9PmglWHqD6Ee97M5jFximnNfE76Nj+dpqir6TMRsI4p/
	 pweyDcFQu1Q1fF3AbyLUz4nJShmf4BqPjgB6+UOeBFrv/vM37voSRcQd7fQHiorR0z
	 x1hye27mSB2cBkYXkD+nlg+tIK2AS2ejgWfB3y1Bq6/e9Woyp9UjhvbtwifcRnS5ox
	 QzuqnM66boRfrFLy2QJA5fNuaC6zjgpiV8HyQJsQ3HMmpEiQpSc1RLm3w6MR3Msq1/
	 XljM7LtBXGFWQipAlvYuXNBwWTcJRo4NXkM/std2bucqfyRx2KusDgZOrGo0na2wG/
	 PgYG6smySMo3Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, leo.yan@arm.com, 
 James Clark <james.clark@linaro.org>
Cc: Ryan.Roberts@arm.com, Kiel.Friedt@arm.com, Julio.Suarez@arm.com, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Besar Wicaksono <bwicaksono@nvidia.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241029143734.291638-1-james.clark@linaro.org>
References: <20241029143734.291638-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf arm-spe: Use old behavior when opening old SPE
 files
Message-Id: <173039473017.1704862.15529653734308857023.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 10:12:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 29 Oct 2024 14:37:33 +0000, James Clark wrote:

> Since the linked commit, we stopped interpreting data source if the
> perf.data file doesn't have the new metadata version. This means that
> perf c2c will show no samples in this case.
> 
> Keep the old behavior so old files can be opened, but also still show
> the new warning that updating might improve the decoding.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

