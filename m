Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF49218AAA;
	Fri, 15 Aug 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290128; cv=none; b=Eu8hZro4PStQEvjHRJVW+Z8Bg3KFv7YAN/yheLJ1yp5WEwYhKHKio4Ox0+JS7u67qxuJPLEVgKp52bQ7rwrJ7FLxXyJLpM6+EgLn61/L6QSZBKR/tqOyvvYS28aX9YaA0lq0JCI8lxiNA2m3iWhpCk1dV8MxDzK78uPAUzk2sCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290128; c=relaxed/simple;
	bh=JK6lbI9y95Zx7VLNDbtyMGwLhO9btS8ZIQVDYDKSSE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPKyINR/2OktiN5Qz7o+2i/wPKUcrUqHzf26wZ77bcG20J+ntz+LF3FzA5wUc2itmEVzIsyMztppJW9a0fqW+wiJBMDTnTaoVu05oxbzQ+pQR0YdhbEUBb3B8D0RoPHhYNExwhz6j1ZWuSOPxVmfIICz6WO3sIbOfDrOtMBnj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3UhhGYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3UhhGYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7343C4CEF1;
	Fri, 15 Aug 2025 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755290128;
	bh=JK6lbI9y95Zx7VLNDbtyMGwLhO9btS8ZIQVDYDKSSE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3UhhGYulTKcLDmK2dvNXB9I3hO8lwBZG1Y2WKpKAxdZWgtSGI03Wb9xg/s3WBLjj
	 8m0JWTQPVKB2PHQ/xXXZp9Rtuxs+9Ye0lKGrAfmaTf7NwIecZ9aqlP6gLqetoJKXy+
	 Z65CNfcYD7GPPz6XxqHHFX2gd9rwvTGlD7sCOkUgMTjnxmmwSMbgtUnLSm7i/Lcz7w
	 GUFUbucSd0oL/W6EcAmchP+dlqsLbKw2jLyD4HH3BVIkggdSlkxSEFd4lhyvZvRmv/
	 MZeP+2tK0q2b3VwcQa1+51/HV0aEco4rsZNBRdfDaZI/vhElj269+N3ddcYwxJm+Do
	 eopwuKclXfOEA==
Date: Fri, 15 Aug 2025 13:35:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: pmu: Fix IS_ERR() vs NULL check bug in
 perf_pmu__init
Message-ID: <aJ-aDh8RG4CXcnI4@google.com>
References: <20250805063209.3678359-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805063209.3678359-1-linmq006@gmail.com>

Hello,

On Tue, Aug 05, 2025 at 10:32:07AM +0400, Miaoqian Lin wrote:
> Replace NULL check with IS_ERR() check after calling
> hashmap__new() since this function return error pointers (ERR_PTR).
> Using NULL check could lead to invalid pointer dereference.
> 
> Fixes: 754baf426e09 ("perf pmu: Change aliases from list to hashmap")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 5a291f1380ed..da6f05872493 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1176,7 +1176,7 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
>  		return -ENOMEM;
>  
>  	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
> -	if (!pmu->aliases)
> +	if (IS_ERR(pmu->aliases))
>  		return -ENOMEM;
>  
>  	return 0;
> -- 
> 2.25.1
> 
