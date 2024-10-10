Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAA1CDA23;
	Thu, 10 Oct 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576661; cv=none; b=dvDechEOUeWXAYs2Xk32rYiRl4BCENeyoiFUQYK+OphSaYsoMMwStvJG7N9rRwLxWVmhCZ4H0RSXO4h0tQmDWGgckIyWH5i2vVIfO20ldx7xAF5BXlf5wsGVidnjyeU1JHHqHrDrYrU0MDmy9T1KY3xbmNHuLDHf9UP+JosMZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576661; c=relaxed/simple;
	bh=mO1M5lVTa79bIuXQiFTo7ewhsi/XZ+4dYMG4cO7vlzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n274qQt2fRuGFItuiLfImaO/A5Y6tvC0eHrQqy4zrN9dVtwdaPRZtG4rDeXtALdf9/mpeI05c+sduhh/+/UjXXOE1cAadTTFHid3++5IY/Sk4EkVhlaI4N/ax9OIOECyBNUamNZJOX4VIzUlMlEv4faRoCcK+IICRFk8DICkBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df7q5HwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df7q5HwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3BBC4CEC5;
	Thu, 10 Oct 2024 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576660;
	bh=mO1M5lVTa79bIuXQiFTo7ewhsi/XZ+4dYMG4cO7vlzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Df7q5HwWj/ddG1mQzfquoASd/P0ba6/mLr/A9DsPRwiQkm9mzBLIVW5gcDFXuABps
	 jBe4/N6UmIPD3v1EeDhAejGxfFIm9Odrdnu8/Rw9X01AJ5tVu1Ow9wyvvKHNCq5UkP
	 RAh2EKxkReQWRYoGgiL1YnY/oytaaDJoiImzmoej2JIiAtoiPqVQETD2KrF++cd3u4
	 JKIoQyQIS2hqIyP0nOaknfOtDOn8Y9g+yxqLqxizWMWKzavnXcGibtwjsxdTcl+aEy
	 enBdSDQuZ38nkzkJgqnhkq/q4Tc657nKFd1Ho+P5EItZVdnH5LdTL8BKkLCLvcbQKF
	 8QZYy5MnYyc3Q==
Date: Thu, 10 Oct 2024 09:10:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf cpumap: Correct for perf_cpu_map__merge()
Message-ID: <Zwf8kTiphIRniYw9@google.com>
References: <20240925195325.426533-1-leo.yan@arm.com>
 <0a0bebe6-b104-4a84-9415-68fdee086a5f@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a0bebe6-b104-4a84-9415-68fdee086a5f@arm.com>

On Thu, Oct 10, 2024 at 04:01:21PM +0100, Leo Yan wrote:
> On 9/25/24 20:53, Leo Yan wrote:
> > perf_cpu_map__merge() has two arguments, 'orig' and 'other', as
> > described in its original comment:
> > 
> > "orig either gets freed and replaced with a new map, or reused
> > with no reference count change (similar to "realloc")
> > other has its reference count increased."
> > 
> > This causes confusion due to the different reference counting on the CPU
> > map objects, which complicates its usage and makes maintenance
> > difficult. We also discussed this in the email [1].
> > 
> > This patch series makes that a new CPU map is allocated for the
> > merging result, or the reference count is increased if an existing CPU
> > map is reused. This means that once perf_cpu_map__merge() is invoked,
> > the caller gains ownership of the resulting map and must release it
> > with perf_cpu_map__put().
> 
> Gentle ping ...

Ian and Adrian, can you please review this patchset?

Thanks,
Namhyung

