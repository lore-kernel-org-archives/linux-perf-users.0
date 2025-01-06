Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCE1D5175;
	Mon,  6 Jan 2025 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197488; cv=none; b=qSd1W8KCqOi8c02hwIoMyatBO/eTZCgjSvojOg+f6P4hETtMA7riE5zg+Gw6Dq/riXYUyUgjYK1g6hyZD+/R1iAIaklx0yyZeUCyjnpCsgbf98oVOdsPgeKX9Uo19bQNB8m8H4FtLJv4eAByIjggi9+wEfMcNZYAeZDkJ+cuRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197488; c=relaxed/simple;
	bh=oDtN7QYOY2V9sus39VeyWp74MWdRbretx+PUBmHdp/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6XJ/doLtbjnmlowiIHik28Wg3Y9O6euZGN4XDD7HVNOopT+hGryWYalyOV5yNhfo0A7jEoeCta2Nqsxofs1zubr5/dCF4QaRlLz3g2ZbuoqeWMaJkmaHhNxJJDWPZ0LrKMUvcDbBU4tccEeehz9e+LJppzSEuXzaDhMXYW79xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAhg59CP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAhg59CP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C83C4CED2;
	Mon,  6 Jan 2025 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736197487;
	bh=oDtN7QYOY2V9sus39VeyWp74MWdRbretx+PUBmHdp/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAhg59CPrYdrOOliQeIi+d6JcgdYHOpSyDnmIa92yruc+8W/60t6ytbSfrkJWeK5H
	 0tn7J9xgO+4lNqCGXwf0pqB7mzqF5wzPMxLHxGXmcEC7LV9DAiwSbHNHDW4oYqjS2y
	 eQ8KHf9yPzvlXcPBKARj4OApGOEwj1bQfXdL3F1HRmsnF7kJmzRXRUX7CP5Wqk3Ftt
	 ILLSWydqbV+ZkXs46c5kBN0I879wKfMqEZw3yiCvAZyM4dHUrRmABLD0DP7FG/XqsA
	 X9B0e+TWjYf06xpD81In5L3VpiYkaL67CT1BQSXmNn17fJIF+V0DEFX4UwkLVG7c71
	 ALqsTvEcDXxiQ==
Date: Mon, 6 Jan 2025 13:04:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools-next] perf top: Don't complain about lack
 of vmlinux when not resolving some kernel samples
Message-ID: <Z3xFbYjkPz_u1UeK@google.com>
References: <Z3gUl1guIXi4bU0a@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3gUl1guIXi4bU0a@x1>

Hi Arnaldo,

On Fri, Jan 03, 2025 at 01:47:19PM -0300, Arnaldo Carvalho de Melo wrote:
> Recently we got a case where a kernel sample wasn't being resolved due
> to a bug that was not setting the end address on kernel functions
> implemented in assembly (see Link: tag), and then those were not being
> found by machine__resolve() -> map__find_symbol().
> 
> So we ended up with:
> 
>   # perf top --stdio
>   PerfTop: 0 irqs/s  kernel: 0%  exact: 0% lost: 0/0 drop: 0/0 [cycles/P]
>   -----------------------------------------------------------------------
> 
>   Warning:
>   A vmlinux file was not found.
>   Kernel samples will not be resolved.
>   ^Z
>   [1]+  Stopped                 perf top --stdio
>   #
> 
> But then resolving all other kernel symbols.
> 
> So just fixup the logic to only print that warning when there are no
> symbols in the kernel map.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Link: https://lore.kernel.org/lkml/Z3buKhcCsZi3_aGb@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Looks like an old bug since d88205db9caa0e9d ("perf dso: Add
dso__has_symbols() method"). :)

Thanks,
Namhyung

> ---
>  tools/perf/builtin-top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 724a7938632126bf..ca3e8eca6610e851 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -809,7 +809,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
>  		 * invalid --vmlinux ;-)
>  		 */
>  		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
> -		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
> +		    __map__is_kernel(al.map) && !map__has_symbols(al.map)) {
>  			if (symbol_conf.vmlinux_name) {
>  				char serr[256];
>  
> -- 
> 2.47.0
> 
