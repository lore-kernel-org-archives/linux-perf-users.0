Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F873F8D1;
	Fri, 10 May 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350624; cv=none; b=Ao3tAUELDaR2TTNb2mbVtDkF5VTBf3EkZWd7+qUdp0787FoQgfYqLv0M9fN4NiUxFo/GFEjt4Y/bMjbBJ2RxGsIuEK01zVOcJFZuZsvYqCW/QYghziwYhRyhwcr36fE2jlvCkieuVHuq8CcLzVIVIM2duRnqId1V9rqu3KJsS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350624; c=relaxed/simple;
	bh=V450PsVFKYuLz/CjQ5KVeg3wqYL5FGkcrDqCeTiCgww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY2TdYyAnLmXi5DcKSY58daNSKxGRPgSs3eMqXt3o/uupqz830QQYlpZPO742DejStKP7dmxAJYJoywRCa0vbohpEZRwtZty8PM1o0DHYBmqpvMNQsZpwCw/2xUjCKZo1QWPBKkg+1wcJLR0cC2m1MUNd3Yc74NFUpdUgALMTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+ocGzjW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+ocGzjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21174C113CC;
	Fri, 10 May 2024 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715350623;
	bh=V450PsVFKYuLz/CjQ5KVeg3wqYL5FGkcrDqCeTiCgww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+ocGzjWS4vHjZml0C7t25uCD7NfD9xoTBfNCQwEMwNXA2c5JhqEQOTWTP7bjW54C
	 gDQsceixmbfHBaaqZFd5eS0DqcbxSkLS5dET3l+EDUION8wB39IdzngRyxhlfZy4aM
	 OmxWcDVFsTL0SsjBJn7D1rg146sx+dtVjslXIzwaVr/5AmoZS5cdb/BCctZBttNu1W
	 qxZi92HgtWPEsIwQJ352XeQGTMS7QszVM2VJsacB0OhLgGo23lsiD4pa1LZ+ERXRii
	 FtmVabvdSCn11qll6YcaTTE4DAZBaNAmJc2XEE9B42lEzGfVjp9BRgM21szFbec2eS
	 oHmqybYxI9PEw==
Date: Fri, 10 May 2024 11:17:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] libsubcmd: Fix parse-options memory leak
Message-ID: <Zj4sXKG9WNY_bDa2@x1>
References: <20240509052015.1914670-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509052015.1914670-1-irogers@google.com>

On Wed, May 08, 2024 at 10:20:15PM -0700, Ian Rogers wrote:
> If a usage string is built in parse_options_subcommand, also free it.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/parse-options.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index 9fa75943f2ed..d943d78b787e 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -633,11 +633,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>  			const char *const subcommands[], const char *usagestr[], int flags)
>  {
>  	struct parse_opt_ctx_t ctx;
> +	char *buf = NULL;
>  
>  	/* build usage string if it's not provided */
>  	if (subcommands && !usagestr[0]) {
> -		char *buf = NULL;
> -
>  		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
>  
>  		for (int i = 0; subcommands[i]; i++) {
> @@ -679,7 +678,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>  			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
>  		usage_with_options(usagestr, options);
>  	}
> -
> +	if (buf) {
> +		usagestr[0] = NULL;
> +		free(buf);
> +	}
>  	return parse_options_end(&ctx);
>  }
>  
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
