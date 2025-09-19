Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC810957;
	Fri, 19 Sep 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314766; cv=none; b=jEn7czkRtVQVu8I1M6nts6k83grQWojCj2xMdpevcDJHQGP1ih3GqWkdLwiV+euLxiPtnozxSrKoO6vr+6jAa6BXSY/XerZyBQ5JTFNKcPaTut+nQ29YBZ/8joUWCZ8t5fUZykEah0FPC0/G2kCa3knLbUoZ6Vs0rsmCXBE+L64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314766; c=relaxed/simple;
	bh=+FZQDT4NwUe2IKpIfg9qxr0/yPqq9LxeRcWI1yCL45U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VijAjVOcR+HkUIfUJ7y0X4myjT6CP0SRDjOiaHEACrLwh/tHIjDS/GjZcgj4ndiKcz+VsiMpPiB2gYJ0UkJ2wlBH053Nbn82QLMM0Gju4pC2IMEQW47e92yuRzmPdOtmtCCcuGxRD1iftUXp8tUh+dAZMdRhaNQioAWairvJQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNgP8kRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNgP8kRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E290C4CEF0;
	Fri, 19 Sep 2025 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758314766;
	bh=+FZQDT4NwUe2IKpIfg9qxr0/yPqq9LxeRcWI1yCL45U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNgP8kREA9ZdQuo26uyN8X6iBJhBrzFgH1qP1JmtI/dvZb8QW8lHtVdqS1sZ0zvKy
	 oagR0OhhD4zMNNnGlzWoHrfJSkTRnhXCOouDrnT3MEhUH0tvq46QLh4L2Hauv4zsrr
	 hGNdC0EbXmcIfgxGNSAkQUd4bjtfAuOy8K1oDNmXb0BwvfBMjg4hpv/927mUEJVRpY
	 OyGywlBy9vKL6QAPPI9sK9Dgdl5cS1tUTHBkaX83v9iCjfECuMW5Jkp8diCeNcWg7f
	 k8l9iBbcJJW1yCbmFuE4MdVUhnJCJ9ALLSH+LuyvfPizM0sFndno+Cg4SQhhmUWUoO
	 LlcvCfwvDGkAA==
Date: Fri, 19 Sep 2025 17:46:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Test fixes and debug logging
Message-ID: <aM3BCr9DbBxnL5rV@x1>
References: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>

On Sun, Sep 14, 2025 at 11:28:56AM -0700, Ian Rogers wrote:
> Testing in a hypervisor guest showed some issues that these patches
> try to address, or improve the debug situation upon.
> 
> Ian Rogers (4):
>   perf test: Be tolerant of missing json metric none value
>   perf parse-events: Add debug logging to perf_event
>   perf test: Don't fail if user rdpmc returns 0 when disabled
>   perf stat-shadow: Display metric-only for 0 counters

Thanks, applied to perf-tools-next,

- Arnaldo
