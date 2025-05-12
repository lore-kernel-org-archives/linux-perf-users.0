Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1F1C84DE;
	Mon, 12 May 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068395; cv=none; b=p7ovukZu0iODKmcVbFdF/6WbsK7FlscOWjZ2b4A045xU0Uznl4ejE7sDCUd4LAgB2OxLQUc4FQjJkTnsXwZQ5u84FoTPv+Jtm8s8BPbBpXDZ5I8sjHCRPzu3+r+Xh78MaUGpogotogNo7sWxPgxflyWTf9AYGwixKuhGk3/mxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068395; c=relaxed/simple;
	bh=GwZlY2b0tKZfe41eon1DKjEtn8ZXjyuesZ7d2StAMoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0PbcG33rPDaI7OSfTm+DrE6pKDSbGfOQ622c7KaOmuJJKxlLs4fZ1d9S/OAT2Vmoz25/ijafNUPinOvO16ZkZhWh0WxjcT+XwTJka9iYTg7UBdWTOjjNk7jyXC6sN4Wg+bhy8U1JavUuS9lGLlNw8vj6oEKjZD3hGJzxL9ddw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T21HUW4j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T21HUW4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0327C4CEEF;
	Mon, 12 May 2025 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747068395;
	bh=GwZlY2b0tKZfe41eon1DKjEtn8ZXjyuesZ7d2StAMoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T21HUW4jJe8XX3W1o7BFNnWfCJ8Kt+w4YvUeqLXatxMNTY3nYkjQsbsEqzXcrJQ/a
	 fBs8XdvNZROeE+g35jUxfTgtKehLOQ7T67ppd/9f/7bCKDnA9DCFy/b/libygdlZlL
	 PJ63D1PlpsWvFImAvTHVoo7QcCZvtPXpmaeJjmQT03mStOKpyhOHJiPzIwE1+D6UPX
	 aeDC1krlhtgLo9ZUDNpYfDt/dxBHFX03R8wmp7Rt3eaLxVFp/ngAEsEKCrrqUfscEe
	 yni8MjqIq4XvcaG3ZoNYvi9NmBArkjANR3h+Yd9rWWnykQLHVF3ZHruOxYkshVkQY8
	 nKwZV0UNPEyAw==
Date: Mon, 12 May 2025 13:46:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Kan@google.com,
	Liang@google.com, kan.liang@linux.intel.com,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf evsel: Add per-thread warning for EOPNOTSUPP
 open failues
Message-ID: <aCIl6G9yUCE8ySlp@x1>
References: <20250412004704.2297939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412004704.2297939-1-irogers@google.com>

On Fri, Apr 11, 2025 at 05:47:03PM -0700, Ian Rogers wrote:
> The mrvl_ddr_pmu will return EOPNOTSUPP if opened in per-thread
> mode. Give a warning for this similar to EINVAL. Doing this better
> supports metric testing with limited permissions when the mrvl_ddr_pmu
> is present, as the failure to open causes the test to skip and not
> fail.


Thanks, applied to perf-tools-next,

- Arnaldo
