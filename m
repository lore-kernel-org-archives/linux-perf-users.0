Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82594C9D;
	Wed, 26 Nov 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139131; cv=none; b=TFKEA+LJ86ypftJ628vwCz49ODi3G2ggGdXXPjdBiUFvj37bo2RVJguyISEPF8hQfu18P/bQPfIqVVWZDokaeaSeGn6hOwNzBK4C5egzz7xOmetQwH1DXB0n5td2NCLUHF5hpqk2b2IVesy96Ew5sxdH/CRNpbnx7wP0ck3eMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139131; c=relaxed/simple;
	bh=wR30lNo0nwD9x0Dn3+l/MmIF3m2FG6nAAz2bzg9VC/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw4Ln/Qef0KXqNwVzFEA+rBBnKY09DJH4dAk9azl7z8IIRzrcMtRMfmc5bfwZYMwuxkDY2h3TA8ZZOTich18fRsBSRts0dCMsRMdzumOY40YlXSv44N5a3ZdoxOjhDcc2Cyn/l1sCRUYZvywdFmX+zBn+/qEEvxRUfe1vz6Neec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTyifArp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTyifArp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A278AC113D0;
	Wed, 26 Nov 2025 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764139131;
	bh=wR30lNo0nwD9x0Dn3+l/MmIF3m2FG6nAAz2bzg9VC/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTyifArpsO+iaBml3bAFhWLgGb9RmYRb1nR1NEUF2/8nm5Y2KQVOrRDnSpzmTZf2+
	 iGZgB9bzfyYWnfZuLRzjxlSiv0VnwRqPY3fPvZjvm2REgco0LL4XeIAWlzXJrbO8He
	 qjOHo1hPRSIRXWvmBoBng6JrCVn3TEwLqqJ+rUj9MX9hbuiL9Will9hPfDQNgKZtpE
	 kF/4otbNMSaQJvSZ3jxaaFp6lTpPKq4U5jVem3Qrvjq6GiJYnFK4wVVpv75gQ5iUNC
	 QWmz5jD08nQ/nabdWOC078IFQBJGiWuceF4yALmtqjcTOV3SPn2RwcFJcL+w1hrjv1
	 MjQuoU6ScjmoQ==
Date: Tue, 25 Nov 2025 22:38:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 02/17] perf timechart: Add record support for output
 perf.data path
Message-ID: <aSageLlTEnj8SRfF@google.com>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-3-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:14AM -0800, Ian Rogers wrote:
> The '-o' option exists for the SVG creation but not for `perf
> timechart record`. Add to better allow testing.

Can you please update the documentation as well?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-timechart.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 22050c640dfa..f8b49d69e9a5 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -1651,7 +1651,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
>  	return ret;
>  }
>  
> -static int timechart__io_record(int argc, const char **argv)
> +static int timechart__io_record(int argc, const char **argv, const char *output_data)
>  {
>  	unsigned int rec_argc, i;
>  	const char **rec_argv;
> @@ -1659,7 +1659,7 @@ static int timechart__io_record(int argc, const char **argv)
>  	char *filter = NULL;
>  
>  	const char * const common_args[] = {
> -		"record", "-a", "-R", "-c", "1",
> +		"record", "-a", "-R", "-c", "1", "-o", output_data,
>  	};
>  	unsigned int common_args_nr = ARRAY_SIZE(common_args);
>  
> @@ -1786,7 +1786,8 @@ static int timechart__io_record(int argc, const char **argv)
>  }
>  
>  
> -static int timechart__record(struct timechart *tchart, int argc, const char **argv)
> +static int timechart__record(struct timechart *tchart, int argc, const char **argv,
> +			     const char *output_data)
>  {
>  	unsigned int rec_argc, i, j;
>  	const char **rec_argv;
> @@ -1794,7 +1795,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
>  	unsigned int record_elems;
>  
>  	const char * const common_args[] = {
> -		"record", "-a", "-R", "-c", "1",
> +		"record", "-a", "-R", "-c", "1", "-o", output_data,
>  	};
>  	unsigned int common_args_nr = ARRAY_SIZE(common_args);
>  
> @@ -1934,6 +1935,7 @@ int cmd_timechart(int argc, const char **argv)
>  		.merge_dist = 1000,
>  	};
>  	const char *output_name = "output.svg";
> +	const char *output_record_data = "perf.data";
>  	const struct option timechart_common_options[] = {
>  	OPT_BOOLEAN('P', "power-only", &tchart.power_only, "output power data only"),
>  	OPT_BOOLEAN('T', "tasks-only", &tchart.tasks_only, "output processes data only"),
> @@ -1976,6 +1978,7 @@ int cmd_timechart(int argc, const char **argv)
>  	OPT_BOOLEAN('I', "io-only", &tchart.io_only,
>  		    "record only IO data"),
>  	OPT_BOOLEAN('g', "callchain", &tchart.with_backtrace, "record callchain"),
> +	OPT_STRING('o', "output", &output_record_data, "file", "output data file name"),
>  	OPT_PARENT(timechart_common_options),
>  	};
>  	const char * const timechart_record_usage[] = {
> @@ -2024,9 +2027,9 @@ int cmd_timechart(int argc, const char **argv)
>  		}
>  
>  		if (tchart.io_only)
> -			ret = timechart__io_record(argc, argv);
> +			ret = timechart__io_record(argc, argv, output_record_data);
>  		else
> -			ret = timechart__record(&tchart, argc, argv);
> +			ret = timechart__record(&tchart, argc, argv, output_record_data);
>  		goto out;
>  	} else if (argc)
>  		usage_with_options(timechart_usage, timechart_options);
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
