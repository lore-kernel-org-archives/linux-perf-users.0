Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B72DBF5B;
	Mon,  8 Sep 2025 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366105; cv=none; b=eucstYl5xdvIGjnyU+zxarTgQ+uGkRSS9mXFMtCcEeWKhDu4A5wC+ZvS+Q+aMp3uo4++zK5MzHCrdPhy9r1y6fJgP41f9B6ebbP175kFUuRh+aQM33GSlJngNz7D3xmP8373kTY7dWlGadRZfLlGmFnKlxMX3yk0Wl2B63BMJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366105; c=relaxed/simple;
	bh=hsYCj2pTYv/83bCogC3ysaSqXDPXrnhxEz3v+vbZBPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzmwYB9pfV1EAYTzYTzgFwvAgIbnqzMI3pGMJJTQWYGXHwRh41xE4mGvWXXbdGVRHvAWZWZQxY0kI5nsLWc7fjAeZ4naTvVvcZzVMGhJ+u88i1uSkcRwePxCTT2jgYsGdgG4OqYXqtNwX8JDQsIY9w2osneVdKp8uqrm8HsgUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6+uA+m/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6+uA+m/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC0FC4CEF7;
	Mon,  8 Sep 2025 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366105;
	bh=hsYCj2pTYv/83bCogC3ysaSqXDPXrnhxEz3v+vbZBPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6+uA+m/GKKxJHzF5Tf8G7KjkKhStbaJOzWHJVvj0TJjvFAxkZjd85xnk+31a3JWd
	 TVy3AJyvfjsT8i1HZy1XYX8ZR5JDvdVX+4Uxdiw+YlUCf29XEe3zy/E6dqsP6jS4yA
	 IBS0OycKZq+iaY+5qoEb9B4yH1s2ASK5aVavTWtJR6JlvXuXglpg0J/r2slOawxkXe
	 Zcg37cSH8v6lWUcDbHNbr2CA3GWEqGjz6LMGzo3O+x7kpkGmNkSKjZ62pqqFUSf7NP
	 SlnAEjxDehDNn6j9XoCNUT6ZC2iWBymjAbG1ZL67VDPBPq7yCUMNfbqRV4grMhTXc1
	 aClw0Vi9THT2g==
Date: Mon, 8 Sep 2025 18:15:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Brendan McGrath <bmcgrath@codeweavers.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	=?iso-8859-1?Q?R=E9mi?= Bernon <rbernon@codeweavers.com>,
	Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
Message-ID: <aL9HVT0F5m3c2sG6@x1>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org>
 <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
 <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
 <CAP-5=fXKthsZe3J4_UHHGwDafBq7pHzM18Mh=_2QrnSfCT3nOg@mail.gmail.com>
 <3db2d6af-3b21-4ce2-be1f-668270adbbeb@codeweavers.com>
 <CAP-5=fX33kGxfHzqVGzusMBiHJM6G75TbLyZazjp37yohwscGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX33kGxfHzqVGzusMBiHJM6G75TbLyZazjp37yohwscGg@mail.gmail.com>

On Mon, Sep 08, 2025 at 08:47:12AM -0700, Ian Rogers wrote:
> Anyway, what does this mean to fixing PE executables in LLVM? Perhaps
> the first 12 patches of:

Lots to digest, but to make progress, if you think you can resubmit a
trimmed down series after making sure it applies to perf-tools-next,
please do so and mention that in the cover letter.

- Arnaldo
