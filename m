Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FE3A4F35;
	Wed, 29 Apr 2026 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448029; cv=none; b=mb3SyCRhEcvzUmByiml22FphWBmIMwj+pXBNdMHhjF4BGwfeZrNUOJGIluPa+7tZrC0t0CdkpL5LL5QHIRQkKPzlErWP1vWM5xjXuJLcyKPx34yj5CsA5lnoA1qBUJoD9RSirwZBDmGeJ7I7IQ4n/xZMYSTSiJrGsRnjeoZsddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448029; c=relaxed/simple;
	bh=DGVd3j5pXvdaIQe1A122ZTTMfX3GPs6Kf7pPmGcP48c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTJVstQGo61v5UUThfALs8t5j1XC4O3f0ZSS12hIzbcvP5Ls018H2ooRKobEjfkMeVD9hbWoF+HQUt3X08p5VNUiexmqfm9hSyHCdTIrPvd4CBc+SOUF1mnnDyec2GlcZgo7dtxfA/v4uo8ZLHfXnyDM0oiqvjc5Ls/J4ttan/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faXG1Vwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faXG1Vwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9E7C2BCB3;
	Wed, 29 Apr 2026 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777448028;
	bh=DGVd3j5pXvdaIQe1A122ZTTMfX3GPs6Kf7pPmGcP48c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faXG1VwiRlzi7Mi6QrSAI3CSuRORiFuqwygRa6+QDUvzP1fER+A9CmSFSkUSzgzME
	 SQk7QH/m660mf++0hIxgRqoaf1DJIIPUZHbnfZ9LRGVal+5EZSCvHlWCYK3thfT+DD
	 8TCgcyJpZ9yN9yzW1hOcIw3P14UH7R4mCFM09IN2nPX6OLGeFJgbS4kcU9vWoAvwz7
	 znFYXiG9XGqfkzlXqxZ7LzjaD0JqzSKCc0GpOgVUkiRjivYnlsoNrgdfEZO3kSR8mx
	 hZ7t7flTiOj8PpXIntukhN8XJn8fIAZgDqT9PyjOg5x9WMa1J+33tKyUlLrSsw1VcB
	 QZebvFyZpktdw==
Date: Wed, 29 Apr 2026 00:33:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v8 10/58] perf evsel: Add reference count
Message-ID: <afG0WoBnoxC8VJNx@z2>
References: <20260425224951.174663-1-irogers@google.com>
 <20260428071903.1886173-1-irogers@google.com>
 <20260428071903.1886173-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428071903.1886173-11-irogers@google.com>

On Tue, Apr 28, 2026 at 12:18:15AM -0700, Ian Rogers wrote:
> As with evlist this a no-op for most of the perf tool. The reference
> count is set to 1 at allocation, the put will see the 1, decrement it
> and perform the delete. The purpose for adding the reference count is
> for the python code. Prior to this change the python code would clone
> evsels, but this has issues if events are opened, etc. leading to
> assertion failures. With a reference count the same evsel can be used
> and the reference count incremented for the python usage.  To not
> change the python evsel API getset functions are added for the evsel
> members, no set function is provided for size as it doesn't make sense
> to alter this.

Can we make the reference counting model simpler by just using evlist's
refcount?  Assuming python code generates no evsel from the shared
evlist, can we just think evsels belong to an evlist and manage their
lifetime together?

Maybe I talked it to you already.. but I forgot the details. :-p

Thanks,
Namhyung
