Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE227703E;
	Wed,  6 Aug 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523608; cv=none; b=mOru2CYRVlsojSzUxiMwJThOVS+crGo0FhjWypmrS1r7RG8lHmM1aGTtuoIgOKye+MphlXFgHx+EwiHeTN5z055F6fC9MRC5ByqPq2Z/b9yLBKxVhoMw2VD6jjx2nZi5d2f+O+zPwf6PxMyovBtJJ5ov4wYVKqwd4oTwWcUg4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523608; c=relaxed/simple;
	bh=38fEaMQu3DP3UBV6Q/qLyG/nax+cnSD8Gp0DBlgTSWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJNg971bzgdusN442uV8iS/kE5cUp/VotU7Q3lppGNnXqUOUFHnuw6zuxurN11/jXuuhoAcwGSSxwvbBSBO/IQiBJ1EbuzlXZqJ+bHjfjkWkmCmSQ34War7UJtAZBwnMCrXUFIc0751pFTBIqp6uk8RAdvV9igMC8VyIMvc214o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFOvBogi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFOvBogi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FE4C4CEE7;
	Wed,  6 Aug 2025 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754523607;
	bh=38fEaMQu3DP3UBV6Q/qLyG/nax+cnSD8Gp0DBlgTSWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFOvBogiTPW9YnC0223cEg1jcfCZ5qzAtLPh0TjmwWEi5XCQJ+F1u6V/HpZZOJ0Rm
	 9rEn7kjKagp44EONcJvbZcGaXB9ebY9+YnYRFoYPptDKnwoAIwAbkqF3MrT4DvBr8P
	 P8l1s2ZhUAoZQrR/bhL3oCTdJfYEUlH+G/nz+jvZfg496ECCzwF7AfXGJZD5y9ZmLM
	 1NOuV7XxRHT7qhVsFZVLPBNUgMdA4OWYh+5LNSKZ/J1bfijJshOXdiaT2HQ2n4/V3e
	 r1zp/bXpWAWLwGvp9otRNX2KQ/WEkWIPi79P3nlHJT2af61DbvKfcs/tkIf51zqyab
	 dXwo9Jfe9Niog==
Date: Wed, 6 Aug 2025 16:40:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 1/5] perf tools kvm: Add missed memory allocation check
 and free
Message-ID: <aJPn1Z5zxqOjZ-Ym@google.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805004633.135904-2-dapeng1.mi@linux.intel.com>

On Tue, Aug 05, 2025 at 08:46:29AM +0800, Dapeng Mi wrote:
> Current code allocates rec_argv[] array, but doesn't check if the
> allocation is successful and explicitly free the rec_argv[] array.
> 
> Add them back.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/builtin-kvm.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 7b15b4a705e4..f78a67a199ff 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1719,7 +1719,9 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
>  	set_option_flag(record_options, 0, "transaction", PARSE_OPT_DISABLED);
>  
>  	record_usage = kvm_stat_record_usage;
> -	return cmd_record(i, rec_argv);
> +	ret = cmd_record(i, rec_argv);
> +	free(rec_argv);

Well.. it's not enough just to free rec_argv.  You also need to free all
items in the rec_argv[].  Probably you want to add more STRDUP_FAIL_EXIT
when copying the original argv (here and other places).

Thanks,
Namhyung


> +	return ret;
>  }
>  
>  static int
> @@ -2006,6 +2008,9 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>  
>  	rec_argc = argc + 2;
>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
> +	if (!rec_argv)
> +		return -ENOMEM;
> +
>  	rec_argv[i++] = strdup("record");
>  	rec_argv[i++] = strdup("-o");
>  	rec_argv[i++] = strdup(file_name);
> @@ -2014,16 +2019,21 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>  
>  	BUG_ON(i != rec_argc);
>  
> -	return cmd_record(i, rec_argv);
> +	ret = cmd_record(i, rec_argv);
> +	free(rec_argv);
> +	return ret;
>  }
>  
>  static int __cmd_report(const char *file_name, int argc, const char **argv)
>  {
> -	int rec_argc, i = 0, j;
> +	int rec_argc, i = 0, j, ret;
>  	const char **rec_argv;
>  
>  	rec_argc = argc + 2;
>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
> +	if (!rec_argv)
> +		return -ENOMEM;
> +
>  	rec_argv[i++] = strdup("report");
>  	rec_argv[i++] = strdup("-i");
>  	rec_argv[i++] = strdup(file_name);
> @@ -2032,17 +2042,22 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
>  
>  	BUG_ON(i != rec_argc);
>  
> -	return cmd_report(i, rec_argv);
> +	ret = cmd_report(i, rec_argv);
> +	free(rec_argv);
> +	return ret;
>  }
>  
>  static int
>  __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>  {
> -	int rec_argc, i = 0, j;
> +	int rec_argc, i = 0, j, ret;
>  	const char **rec_argv;
>  
>  	rec_argc = argc + 2;
>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
> +	if (!rec_argv)
> +		return -ENOMEM;
> +
>  	rec_argv[i++] = strdup("buildid-list");
>  	rec_argv[i++] = strdup("-i");
>  	rec_argv[i++] = strdup(file_name);
> @@ -2051,7 +2066,9 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>  
>  	BUG_ON(i != rec_argc);
>  
> -	return cmd_buildid_list(i, rec_argv);
> +	ret = cmd_buildid_list(i, rec_argv);
> +	free(rec_argv);
> +	return ret;
>  }
>  
>  int cmd_kvm(int argc, const char **argv)
> -- 
> 2.34.1
> 
