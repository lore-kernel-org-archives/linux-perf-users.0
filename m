Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D938E126;
	Mon,  6 Apr 2026 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497884; cv=none; b=XAIlTxwBLYqLcJHJPKrkSnqcmMQeG8WfZeFMhkYHNMgMY19tVwf5eY3WtlgfinYv2FNScMwJfr8lqV2UJygXt8w7w5emTDQ6cNeKjAq+A30A94WISivZXFlJTdO4RIHvktxA3QWK5yE4iggXhoumw4mFtdtjRp49A7h9s69ZxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497884; c=relaxed/simple;
	bh=Raht2hMRD8r5iWIsBlgJs9eMy7Pwf3KEIYgWA6X/DXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoN56Qmim6DDfNvMrxrt0ma4dTipc2H7XatloNG2zylj1DhqyYGv7Ili40eBCZYHClOQLcn8ZWDD+/fHJe6DgTADo1i6SlBw4VQlHkmT7IWliWobMO4BU50hbnqZYtnBk67rfCsMqun8Fr2Wgy2vYRIeA4NyojP4EUuNR9gSJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx4Ffq1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx4Ffq1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535C4C4CEF7;
	Mon,  6 Apr 2026 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497883;
	bh=Raht2hMRD8r5iWIsBlgJs9eMy7Pwf3KEIYgWA6X/DXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx4Ffq1as7L5FF2oTV0eWxJJToYetjkqumdU+R87PAkfM2ZdK8kAryb40/jJfQdeq
	 gbXashnFN7AnVeRIOzWFqNo3f2dJXoj5XlIiLfKA0EZV8Sud01yuC6aOucgCoki+N5
	 QZoAOq26SI8TMRGu0GYn3175Xw/4WMI6H+bZ0YhlhzPxO55kYHvZTcVQJ8B1xq4+ea
	 6SWYRnV4WekNxUz1/AvhqAGnDWl6TFiRahEVxwjuB9R9GUfkcj6qfLyyOezpLjPUSF
	 6kymGfalqTKT1ywtqmbBWTe+VncEenqgCD0Vq6CE/gmnQGFN9jWU4m+g/ftzRvIXS2
	 rrMY4Y/wLBh0w==
Date: Mon, 6 Apr 2026 10:51:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [PATCH] perf test: Skip sched stats test for !root
Message-ID: <adPymtEcVTMgIZ0Q@google.com>
References: <20260405051644.61511-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260405051644.61511-1-namhyung@kernel.org>

On Sat, Apr 04, 2026 at 10:16:44PM -0700, Namhyung Kim wrote:
> Running perf sched stats requires root and it fails to open the
> schedstat file for regular users.  Let's skip the test.
> 
>   $ perf sched stats true
>   Failed to open /proc/sys/kernel/sched_schedstats
> 
> Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

