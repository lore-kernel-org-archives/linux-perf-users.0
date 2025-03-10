Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B29BA3D;
	Mon, 10 Mar 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638136; cv=none; b=RluL7TbqBZkKC/+E/0pBWPH5ksLdrWiS+rwUHkn7aTJR2Xt7A90x6DePUK4ylnOTTjvPn3Q7cBmvnPXrtSHQ8icQMxl9FEb0WXOTOxTFerMZPV7UgoCbsNLW9KkfYNThsX/JEi93Wqv6bCSOkCKMFj+9qxKTwRbL0P9EighR2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638136; c=relaxed/simple;
	bh=n9sdS/Fwyhr90nPUU/QemA+AnfUzn9wCLqKTTeOnJ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi9u7u9wnqg0GBTzV9vnM+ElVU8HbMqOMtKMAA52pHEFniwX8rBr2eDRGftnmc3K17icI1BthXBvVFVoIPvboqBfX/rJeNCeSnkw/QMbGpTdVf6WgT8wzx53aI+xXjyJd59S5+K8UcogimLDT+rpetrpcgckcL8dLZY3g4waRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIiZo3su; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIiZo3su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD2FC4CEE5;
	Mon, 10 Mar 2025 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638136;
	bh=n9sdS/Fwyhr90nPUU/QemA+AnfUzn9wCLqKTTeOnJ/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIiZo3su+WIsHI8UBUWfjTKgJJZ7nuNfpHgWLVUEU/NKV6aUYFOmv9CYhnKL+xmbA
	 A9nTYoT/pdxVRZB0DtOrgKJvZioYkJtuPSE+cgIy25UnA3x4eH/T7m390ukVEPkD75
	 Pi8AmwkHmjg0QUx2gL+kzTHI20SnljZxo1riQWh42jZpvZ9oJ6dw56hXk0jH+SMZHG
	 2QFXoYUTqZ4k2nQhOyY7W0oKX/hFfTI3NVWU5L93IFVdjz0wYrOAs+tjF0/kQUyl11
	 XQyeF4wI0yfQjB5D3z5ug1ps/e3FwK9Ip6zYvx5VwsJbiI3+P7OP6tYV11OyE6LD+U
	 pkijGkX+HYG8w==
Date: Mon, 10 Mar 2025 17:22:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 01/11] perf debug: Avoid stack overflow in recursive
 error message
Message-ID: <Z89J9cBUR6NCMaaj@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-2-irogers@google.com>

On Fri, Feb 28, 2025 at 02:22:58PM -0800, Ian Rogers wrote:
> In debug_file, pr_warning_once is called on error. As that function
> calls debug_file the function will yield a stack overflow. Switch the
> location of the call so the recursion is avoided.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Good to add this so that stable picks it:

Fixes: ec49230cf6dda704 ("perf debug: Expose debug file")

- Arnaldo

> ---
>  tools/perf/util/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 995f6bb05b5f..f9ef7d045c92 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -46,8 +46,8 @@ int debug_type_profile;
>  FILE *debug_file(void)
>  {
>  	if (!_debug_file) {
> -		pr_warning_once("debug_file not set");
>  		debug_set_file(stderr);
> +		pr_warning_once("debug_file not set");
>  	}
>  	return _debug_file;
>  }
> -- 
> 2.48.1.711.g2feabab25a-goog
