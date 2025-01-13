Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3B1F9AAB;
	Mon, 13 Jan 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807377; cv=none; b=YZ/76Th3+o6WzyxTLocLWN+PgmU2LBeXmihfpWhvHmO8YpVPU6Ge7/KGM8C0KMj6jHYoV3UjewDjsCcmc7FQVwojjsZysYY4879TWJ6FI+mmPQFr7WEklPtxlG8dUTFbRdbc9VEjpPPSIuCJk2XhGvyp/DMl02kLXZSfSXQ0LWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807377; c=relaxed/simple;
	bh=CG1KLyI53KK2u2As1S5AP+auoOM2LNmzocUNkjp2d5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS8Hyq1lymF+lOfii9dZ0uUSQJEQId1ADta1UoZV4N/NOnQ8q241AgCJbFc9XyyK1bsjfb4fvNxcYHalrsilwewWpMxUjTP/w5ZgHM/G8urOI9D/I1m0mHgKQO7cQXNj1ssdknyOoKSBaiwhso3nqbFdcCLSxFDWFYKRvhLQL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEtmy6D+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEtmy6D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E1EC4CEE2;
	Mon, 13 Jan 2025 22:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736807376;
	bh=CG1KLyI53KK2u2As1S5AP+auoOM2LNmzocUNkjp2d5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEtmy6D+xQ9118Sdji4S5z6b9hpy9ZLXfILiXD+wuWQMwKMg+BmXIFnAzF8KNF5bu
	 d55FkyJy2Sf5w9+S3PF+jR0ev00wtKOCJrBDZ4odlikU6bSn7stAjipX+h2zn75m7m
	 muuamSEMcdDotNSDIEqb6g8sxFoqrzvM0kC545Zw2n1aiES5jIeyF6tH4lqg7GsOXE
	 CukCw6YdL3diLX+YWqter8U1gk1duQ2kNYb8gR/r2AqnOHUOE9lV4nHiBzUNwUw9wF
	 zoxPSIv54L94k5teZrfO9AhJYXnOuxvHmjRCrbngOnwdzYlple7eVmqG5tZxBQAaX9
	 1LtXTAaTBzECw==
Date: Mon, 13 Jan 2025 14:29:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] perf test: Add a runs-per-test option
Message-ID: <Z4WTzkVh61cYoOsW@google.com>
References: <20250110045736.598281-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110045736.598281-1-irogers@google.com>

On Thu, Jan 09, 2025 at 08:57:31PM -0800, Ian Rogers wrote:
> Add a runs-per-test option to perf test inorder to better diagnose
> flakes. Each runs executes as if it were a different test, the tests
> appear together in the output:
> 
> ```
> $ perf test -r 3 lbr -v
> 122: perf record LBR tests                                           : Ok
> 122: perf record LBR tests                                           : Ok
> 122: perf record LBR tests                                           : Ok
> ```
> 
> v5: Fix the patch that updates the documentation for the sequential
>     option, as spotted by Namhyung.
> v4: Fix crash in dont_fork mode caused by cleanup work.
> v3: Improve perf test documentation, including for the new option, and
>     add some example output to the commit messages as requested by
>     Namhyung.
> v2: In the v1 patch Kan and I noted cleanup that would make the code
>     cleaner and less indented:
>     https://lore.kernel.org/lkml/20241109160219.49976-1-irogers@google.com/
>     Add patches doing some builtin-test.c cleanup and then add the
>     runs-per-test flag.
> 
> Ian Rogers (5):
>   perf test: Rename functions and variables for better clarity
>   perf test: Send list output to stdout rather than stderr
>   perf test: Fix parallel/sequential option documentation
>   perf test: Add a runs-per-test flag
>   perf test: Improve verbose documentation

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-test.txt |  20 ++-
>  tools/perf/tests/builtin-test.c        | 223 ++++++++++++-------------
>  2 files changed, 119 insertions(+), 124 deletions(-)
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
