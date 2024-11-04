Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F11CC178;
	Mon,  4 Nov 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751045; cv=none; b=uHkNEgTaCMOxfIihVirB95SbrzKyQqpdhHNJHOk2Z81ZNu1D/zcaEKJcrIIlbVwIY6RNxG6RfgdcnzAEWn+zczjA4QnG5YYGbUJRwx/j0uB4tw7jKfQyH413d5E7LVP1K/Gm0ZeymwVelAYOXqOIBxsdhRiAkxkRFSbCiHtX6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751045; c=relaxed/simple;
	bh=tUNWRUswbV+yPH0A+ffgjWD45tdsi4QpLxmNsVWjNXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9iKCG5VRrVn519Ow6JE2qWyEhs2GsYwoDlABF0bEBm5WLEo7pMBwQRnDVA5/fTXiUAb3SZhayETBrfGJ0Y39+kHmY1TBcMUOTvNQIElNlSu76pgCmCt//7cdDtCBOq8GyXTdgFVYd0J4js+BuKJnxKf+ZVUcfUoVNaY+dN+/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJIeWv9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJIeWv9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DAAC4CECE;
	Mon,  4 Nov 2024 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730751045;
	bh=tUNWRUswbV+yPH0A+ffgjWD45tdsi4QpLxmNsVWjNXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJIeWv9NUsgwdg//+YiqX2FuQ63C9QanxWn19n2uEI3hK31cWhpUrpjoyXS8kqVZW
	 FG1SllCQedJHqY03AxnwXLjOnamVbDtp324BR3PfvYHgSxt7o33hI2VyKJK+r9xYIK
	 s1e6zCK9jcL7HPR06U2vXHks0PHsb2swuY2m1r2SioEhEfpxMc6kcGX2CxEkSsm45B
	 rfCMBiJ+2FZvHm7R64Fv7Sp4O8FTL7d8LXTMxaIIv8eEtuRetALg+8SqNf70GLGBD6
	 RiSsEUtfj1hsZ00V6srBUaWbwEh69RfmVSjEPt0wU/WyY2aUCoxQjo/qMQ7OLV4pl7
	 AuseJn+IzoTpw==
Date: Mon, 4 Nov 2024 17:10:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf-probe: Require '@' prefix for filename always
Message-ID: <ZykqQTMbA8PlaIBW@x1>
References: <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
 <173073704685.2098439.2208365513857043203.stgit@mhiramat.roam.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173073704685.2098439.2208365513857043203.stgit@mhiramat.roam.corp.google.com>

On Tue, Nov 05, 2024 at 01:17:26AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
 
> Currently perf probe allows user to specify probing place without '@'
> prefix, for example, both `-V file:line` and `-V function:line` are
> allowed. But this makes a problem if a (demangled) function name is
> hard to be distinguished from a file name.
 
> This changes the perf-probe to require '@' prefix for filename even
> without function name. For example, `-V @file:line` and
> `-V function:line` are acceptable.
 
> With this change, users can specify filename or function correctly.

Well, this will break scripts that use perf probe for a given file,
probably the right thing not to break backwards compatibility is to
continue accepting and when there is a real conflict, an ambiguity that
makes differentiating from file to function names, then refuse it,
stating that it is ambiguous, probably spelling out the names of the
files and functions that match so and stating that to make it
unambiguoius, prefix file names with @.

- Arnaldo
 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |   31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 665dcce482e1..913a27cbb5d9 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1341,7 +1341,7 @@ static bool is_c_func_name(const char *name)
>   * Stuff 'lr' according to the line range described by 'arg'.
>   * The line range syntax is described by:
>   *
> - *         SRC[:SLN[+NUM|-ELN]]
> + *         @SRC[:SLN[+NUM|-ELN]]
>   *         FNC[@SRC][:SLN[+NUM|-ELN]]
>   */
>  int parse_line_range_desc(const char *arg, struct line_range *lr)
> @@ -1404,16 +1404,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  			err = -ENOMEM;
>  			goto err;
>  		}
> +		if (*name != '\0')
> +			lr->function = name;
> +	} else
>  		lr->function = name;
> -	} else if (strpbrk_esc(name, "/."))
> -		lr->file = name;
> -	else if (is_c_func_name(name))/* We reuse it for checking funcname */
> -		lr->function = name;
> -	else {	/* Invalid name */
> -		semantic_error("'%s' is not a valid function name.\n", name);
> -		err = -EINVAL;
> -		goto err;
> -	}
>  
>  	return 0;
>  err:
> @@ -1463,7 +1457,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
>  
>  	/*
>  	 * <Syntax>
> -	 * perf probe [GRP:][EVENT=]SRC[:LN|;PTN]
> +	 * perf probe [GRP:][EVENT=]@SRC[:LN|;PTN]
>  	 * perf probe [GRP:][EVENT=]FUNC[@SRC][+OFFS|%return|:LN|;PAT]
>  	 * perf probe %[GRP:]SDT_EVENT
>  	 */
> @@ -1516,19 +1510,12 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
>  	/*
>  	 * Check arg is function or file name and copy it.
>  	 *
> -	 * We consider arg to be a file spec if and only if it satisfies
> -	 * all of the below criteria::
> -	 * - it does not include any of "+@%",
> -	 * - it includes one of ":;", and
> -	 * - it has a period '.' in the name.
> -	 *
> +	 * We consider arg to be a file spec if it starts with '@'.
>  	 * Otherwise, we consider arg to be a function specification.
>  	 */
> -	if (!strpbrk_esc(arg, "+@%")) {
> -		ptr = strpbrk_esc(arg, ";:");
> -		/* This is a file spec if it includes a '.' before ; or : */
> -		if (ptr && memchr(arg, '.', ptr - arg))
> -			file_spec = true;
> +	if (*arg == '@') {
> +		file_spec = true;
> +		arg++;
>  	}
>  
>  	ptr = strpbrk_esc(arg, ";:+@%");
