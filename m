Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5016415;
	Fri, 10 Jan 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468999; cv=none; b=ZiQLJIYc4wJ4RY3uqy982r6oviI7a1JAuTF3h/sMMQm82ogBIME3xguhANBxTcv0gLJr/a3E87p6d+LQbk3PpzXmRqNeknry27RRD6gFKwwz5/aDH2UYUataZJAVs2dOM9McX2LIah60e66C2YDeQEqrd44bjqdlf7vHPxCZOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468999; c=relaxed/simple;
	bh=lyNkIRM3WpV2eVdbjNsqi8jW6RXk6toRyYc1bzeJ5Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY5ITHQgOyicR3sO3Aw7EyMypj0RFiQZvnVMwhbjQUaOzyRlivnQYoX/Iq7U1ms4IgZ5T7yc4qjarTBjZQRIJWzf/bKfyB8RJWCUk9qBshyePOGJUFsJOk6Br26kYVcLwAWn/nu9mUa3Ac75qOQ8Ys0Az/2pBJInKGS7pgvEXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NElTRYLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NElTRYLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2CAC4CED2;
	Fri, 10 Jan 2025 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736468999;
	bh=lyNkIRM3WpV2eVdbjNsqi8jW6RXk6toRyYc1bzeJ5Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NElTRYLTheEugJkwRJdhbUuVQ68U4TRPuf3F91Xmc4MJfeBjWOA2su+xYhQprt7Xy
	 Rb1+JxFNVRPaO4asP9GyCpcb3LAmviYcFPaL8/rIk9dy5UyoMqZda94lmitA7bbNZd
	 9CD0KWlAwkokWU4ipRz5GafhAM9dWogiTt526iFrRpCfmArsJpqEs5ELevQ1AULXBU
	 qbpm1gs1ngVdxx7n+S+/UpPBzAEFoxsA8OYjnBl8feaXPrQZlnao6ZpW4EYZ8NZ/zX
	 WXK58gqHtkG4zDKlYa+CF5gX+MGK2ZqE5thzI/cOrQvHXhqZBlqNbh8VII/Cr1dugX
	 LtL1bQqneQDhg==
Date: Thu, 9 Jan 2025 16:29:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Jiachen Zhang <me@jcix.top>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] perf: Fix a wrong help message
Message-ID: <Z4BqBewL5zZFVl0J@google.com>
References: <20250109152220.1869581-1-me@jcix.top>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109152220.1869581-1-me@jcix.top>

On Thu, Jan 09, 2025 at 11:22:19PM +0800, Jiachen Zhang wrote:
> The wrong help message may mislead users. This commit fixes it.
> 
> Fixes: 328ccdace885 ("perf report: Add --no-demangle option")
> Signed-off-by: Jiachen Zhang <me@jcix.top>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 048c91960ba9..a5672749f781 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1422,7 +1422,7 @@ int cmd_report(int argc, const char **argv)
>  	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>  		   "addr2line binary to use for line numbers"),
>  	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
> -		    "Disable symbol demangling"),
> +		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>  		    "Enable kernel symbol demangling"),
>  	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
> -- 
> 2.34.1
> 
