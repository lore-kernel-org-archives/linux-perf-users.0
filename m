Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23461DB122;
	Thu, 27 Feb 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675027; cv=none; b=I2UGSRMz/YlmwKm+pI90bFMis4IjSmBgPKd5ScQiNpl2S4IJBCSSgC/duDbLyze27dDt77nJpt1LTVvFoyv3qMfYT5jhCQaXPZl7qDG8fyNXktAivWD6dYZ8itmOcTSmcb8P6oKH7gyjTeWQzrdhZFgTtD1zdsloHNpeCWFQBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675027; c=relaxed/simple;
	bh=JAe7NAiJZKeZrRwd/2AkQMazx4iDKgezMJFcr6WCo14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=muS/l18bvfTCwPmRDAB67g4tFknf+1a6NpmaFzgVQkCilqKeXJQVyRYZNVC9BzXS63zfr8D4dQkWe2S6ZvSvKL9eljnkcfCZoG79yu/zCObC5geoLVBn1L9p7oIbPjyA3hCSEQ6vYAM7hEZhDG2vR7lH/eNY0GgOBfqrnv1hkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKXbEBY1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKXbEBY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA7C4CEF4;
	Thu, 27 Feb 2025 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675027;
	bh=JAe7NAiJZKeZrRwd/2AkQMazx4iDKgezMJFcr6WCo14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JKXbEBY1k8DrqkH96t6sCq71iBnahff6YsUjY/xSCLPy1ZcW69jUpFzu3J8L0Z7cy
	 wrMXH+j4O9RaBRibak9FQc/J0Eohg4zT1+NYRVyZy0aOaSmg5Cm1ScIf1Syw5bKKDT
	 Aw6XVA629tBugagj+5osdRIkOe9O2iBsWH2pZ/lVbDNvwALI5vDH90R4w5N8gsLY8t
	 An5aDy6B2oLoFkpQkD8y3RWVQUN+2DCZefxHPKSAB20qw2MA1GV9IXF1mUDtpsC7jK
	 iQTOcSMuXoTuW2QdeSYt81ddxQzKZ4OMZuTH+PWrkgfWiV431otDQpJ/yM7I0d+KNx
	 jcDP6CJrT0RhA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, irogers@google.com, cyy@cyyself.name, 
 James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
 Weilin Wang <weilin.wang@intel.com>, Junhao He <hejunhao3@huawei.com>, 
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226104111.564443-1-james.clark@linaro.org>
References: <20250226104111.564443-1-james.clark@linaro.org>
Subject: Re: [PATCH v2 0/3] perf pmu: Dynamically allocate tool PMU
Message-Id: <174067502701.1401960.11028274407047299720.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 26 Feb 2025 10:40:59 +0000, James Clark wrote:
> A few minor fixes that I came across when poking around with the Perf
> list behavior on hybrid Arm.
> 
> Changes since v1:
>   * Rename perf_pmus__new_tool_pmu() -> tool_pmu__new()
> 
> James Clark (3):
>   perf pmu: Dynamically allocate tool PMU
>   perf pmu: Don't double count common sysfs and json events
>   perf list: Document -v option deduplication feature
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


