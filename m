Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB98229127;
	Wed, 11 Dec 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922933; cv=none; b=Iqdn0amwJAqI5tPbpuPNtOvkbmvwMEqmOOWiY9AvcV1+CP2kuQ0JSHdKCGASvADtrju+1LMgQ03mDbam7wnlVaUl2KaaBb8Kv333ZTodlABVK8KnezNlXjFqcQp2iiVGoVgUQDBp099Wzay6ld9ccyzbdvSQpfftXZDW5MZ2jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922933; c=relaxed/simple;
	bh=6JTy6JZ21XP+nWSIAbj540zAQnm35RfeBlsbwpOE+PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHpYMlVIJgxn8Pp0G9AbqX5jaZLLOpkE/sbxpkxiw5m+T4eJOmQD0zhZoyLwZYqnvbcAa+LlRmfCdSgTgpu7U+3Cz84fLREvKwK+/wDURvfwoc8hJ4jJB8r+iSuHdbNHAmKwSw+dkfjtbCoSb+gpj2NX7zIh47peO6Hct498O+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evV3VxJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evV3VxJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF718C4CEE0;
	Wed, 11 Dec 2024 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733922933;
	bh=6JTy6JZ21XP+nWSIAbj540zAQnm35RfeBlsbwpOE+PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evV3VxJNdiTsewn917nD6KOqkNsL3Af2zWs0IRRm+NMas5XolrG2k1/2McoWSGUi7
	 WmXrdZvo51Jk86CpwNMfBZdD/dS1Rd0ccKP5mgha0HYf2by+zdT9Is2jacb54kxtxc
	 3gGdejVmr8u1DaAlz1H9fVqiRoS8/MSkF96LxKge53cZzIcCyWE3nEPbDMqqUJMWTo
	 Wxdt5Zl/wydOmrQgqmNdY8S1y8BpSJ3ELZ9nJEq1nY4GxmH8WXWywM3I4pwB+HXN4I
	 BRpCFPZCcQHQN9m00pgdRRmfR+WqQo2c2mbbb3zb12uZhVzpaE4JGwPO8birD2FtO/
	 +MvHsdrwFVCnQ==
Date: Wed, 11 Dec 2024 10:15:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	mhiramat@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf probe: Fix uninitialized variable
Message-ID: <Z1mQcsDCw0d8djjx@x1>
References: <20241211085525.519458-1-james.clark@linaro.org>
 <20241211085525.519458-2-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085525.519458-2-james.clark@linaro.org>

On Wed, Dec 11, 2024 at 08:55:23AM +0000, James Clark wrote:
> Since the linked fixes: commit, err is returned uninitialized due to the
> removal of "return 0". Initialize err to fix it.
> 
> This fixes the following intermittent test failure on release builds:
> 
>  $ perf test "testsuite_probe"
>  ...
>  -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
>  Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
>  ...

So Namhyung, this one should go to perf-tools, I can pick the second on
perf-tools-next, so that we keep perf-tools as small as possible.

- Arnaldo
 
> Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
> Tested-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/probe-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 6d51a4c98ad7..eaa0318e9b87 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  {
>  	char *buf = strdup(arg);
>  	char *p;
> -	int err;
> +	int err = 0;
>  
>  	if (!buf)
>  		return -ENOMEM;
> -- 
> 2.34.1
