Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415584E0E;
	Mon,  3 Jun 2024 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407483; cv=none; b=HrXzx4I0YOy5hyU0uTlsPqSFjleq96baLchrgPFFX8sQvd1RQiVPdiSHDWJSXjIJLTtVPd1jfiHCQ8638jhj/eyO/YhEMBK1ZAVX88Cyr/lHTBvQuUhgdSf6kfv7O8fVn8wYbU8wZy9QARR+hm1sBWIowLBv+gf9qROCr41u2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407483; c=relaxed/simple;
	bh=lPJ1JmCapYhEez5XfczXf0VJ7ZKz/jUNpv2J1VIled8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ8SLnnqINrEyLei6raNNpkSv67MX+mbSezcCVNsMM104gR+0P+AECLJschVJs1VcAz8XVuMMt4sk24GcJ/yoY+p2+IzorQrwUyV0vlFQ56vMt9fmGCr32MDzikTTeBitoTAItIQJJ/GL3IxFuAajq59hR9nm3PlreO6Wc/DHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 634F21042;
	Mon,  3 Jun 2024 02:38:25 -0700 (PDT)
Received: from [10.57.69.99] (unknown [10.57.69.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680F43F762;
	Mon,  3 Jun 2024 02:37:59 -0700 (PDT)
Message-ID: <cf08f5ee-ccd5-4c37-90a6-c88fb3ab2a49@arm.com>
Date: Mon, 3 Jun 2024 10:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf lock info: Display both map and thread by
 default
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 namhyung@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240513091413.738537-1-nick.forrington@arm.com>
 <20240513091413.738537-2-nick.forrington@arm.com>
Content-Language: en-GB
From: Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <20240513091413.738537-2-nick.forrington@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Is this ok to be applied now?

Thanks,
Nick

On 13/05/2024 10:14, Nick Forrington wrote:
> Change "perf lock info" argument handling to:
>
> Display both map and thread info (rather than an error) when neither are
> specified.
>
> Display both map and thread info (rather than just thread info) when
> both are requested.
>
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>   tools/perf/Documentation/perf-lock.txt |  4 ++--
>   tools/perf/builtin-lock.c              | 27 ++++++++++++++------------
>   2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index f5938d616d75..57a940399de0 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -111,11 +111,11 @@ INFO OPTIONS
>   
>   -t::
>   --threads::
> -	dump thread list in perf.data
> +	dump only the thread list in perf.data
>   
>   -m::
>   --map::
> -	dump map of lock instances (address:name table)
> +	dump only the map of lock instances (address:name table)
>   
>   
>   CONTENTION OPTIONS
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 230461280e45..7eb115aeb927 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1477,20 +1477,16 @@ static void dump_map(void)
>   		fprintf(lock_output, " %#llx: %s\n", (unsigned long long)st->addr, st->name);
>   }
>   
> -static int dump_info(void)
> +static void dump_info(void)
>   {
> -	int rc = 0;
> -
>   	if (info_threads)
>   		dump_threads();
> -	else if (info_map)
> +
> +	if (info_map) {
> +		if (info_threads)
> +			fputc('\n', lock_output);
>   		dump_map();
> -	else {
> -		rc = -1;
> -		pr_err("Unknown type of information\n");
>   	}
> -
> -	return rc;
>   }
>   
>   static const struct evsel_str_handler lock_tracepoints[] = {
> @@ -1992,7 +1988,7 @@ static int __cmd_report(bool display_info)
>   
>   	setup_pager();
>   	if (display_info) /* used for info subcommand */
> -		err = dump_info();
> +		dump_info();
>   	else {
>   		combine_result();
>   		sort_result();
> @@ -2578,9 +2574,9 @@ int cmd_lock(int argc, const char **argv)
>   
>   	const struct option info_options[] = {
>   	OPT_BOOLEAN('t', "threads", &info_threads,
> -		    "dump thread list in perf.data"),
> +		    "dump the thread list in perf.data"),
>   	OPT_BOOLEAN('m', "map", &info_map,
> -		    "map of lock instances (address:name table)"),
> +		    "dump the map of lock instances (address:name table)"),
>   	OPT_PARENT(lock_options)
>   	};
>   
> @@ -2694,6 +2690,13 @@ int cmd_lock(int argc, const char **argv)
>   			if (argc)
>   				usage_with_options(info_usage, info_options);
>   		}
> +
> +		/* If neither threads nor map requested, display both */
> +		if (!info_threads && !info_map) {
> +			info_threads = true;
> +			info_map = true;
> +		}
> +
>   		/* recycling report_lock_ops */
>   		trace_handler = &report_lock_ops;
>   		rc = __cmd_report(true);
