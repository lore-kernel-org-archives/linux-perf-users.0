Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7C1442E8;
	Tue, 10 Jun 2025 04:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531556; cv=none; b=kUeDV7UGmnF0XgRtqGGL/BAiuYiUiqLNeJbimvvpIc92HPV0g8meQEjK+q+XYmGka4CVG3rQDPN7MARwV3lwY8Wgh2PrK4uJ3OTw/g7+9PTAfxeR+RP/o+RZmzGAI1C6QFHE2EoX0ISud3+sziFWeKxfV9pMG03lgktiHYbJRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531556; c=relaxed/simple;
	bh=Bl0VU031wuanwqojfXK8seZUYjDoo2UHxIphASGINsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozvvmX6cR1As6I1vxmMXQj76C4W/YLIwuWLizOx8mjsFQB37hmWDQUkl+/AwvMYTN6QuDsBMIxEivhLb7vUSGgveRPhmjyXO7dU83Vkx9ixg6LT+RYQhBagOrBBslILxdHM8nusKpFsqUkuwTa4tvI3sG5p38Ehb+LNVvhVT1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijFRs3FJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijFRs3FJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A4C4CEEF;
	Tue, 10 Jun 2025 04:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749531556;
	bh=Bl0VU031wuanwqojfXK8seZUYjDoo2UHxIphASGINsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijFRs3FJy2TRBzsORyb5E0q1Ojzpt5edAEwVMFxK3rq9bxqFt4NCtUsVoS5dEEJRO
	 B4sluDrFNTNWINoXjfMTCjbNxlcHL0NA5cxHHb9JXulrAFa03/2ClZ3GBbcnZrBNHu
	 CEfjfvS+mXcAVmEnUm7aI1v6iI1LB7Ul6zFyyzGEvrrYIcX1tv6zY2NMzuzvxe24is
	 p2lM0BccGBt5+qXMKSogqNAPwz+9FHcreSMYlRuz7xE85FsymVeXIzlledONZUeKwc
	 1yaHrLzHil5b6AmRTuG6hct3mLb1LM0cKguk38DYMo1Jke1JKvow3jHlgqP8O41am/
	 PNTO+rK2KJJOg==
Date: Mon, 9 Jun 2025 21:59:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnaldo.melo@gmail.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] perf probe: Extend the quiet option
Message-ID: <aEe7ojjNf-3k_OzU@google.com>
References: <20250504104351.1549583-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250504104351.1549583-1-atomlin@atomlin.com>

Hello,

Sorry for the long delay.

On Sun, May 04, 2025 at 11:43:51AM +0100, Aaron Tomlin wrote:
> To provide a consistent and complete quiet mode, this patch expands the
> scope of the [-q|--quiet] option to suppress all informational messages,
> including those indicating successful event creation, in addition to the
> currently suppressed warnings and messages. For example:
> 
>     ❯ sudo ./perf probe --quiet --add proc_sys_open
>     ❯ echo $?
>     0

I don't think this change is needed.  I also see no messages before this
change.

Indeed, using -q/--quiet option makes verbose to be -1 which disables
any pr_info() messages.

Thanks,
Namhyung

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-probe.c    | 16 +++++++++++-----
>  tools/perf/util/probe-event.h |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 69800e4d9530..aee756aad19d 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -391,7 +391,7 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
>  	}
>  
>  	/* Note that it is possible to skip all events because of blacklist */
> -	if (event) {
> +	if (event && !probe_conf.quiet) {
>  #ifndef HAVE_LIBTRACEEVENT
>  		pr_info("\nperf is not linked with libtraceevent, to use the new probe you can use tracefs:\n\n");
>  		pr_info("\tcd /sys/kernel/tracing/\n");
> @@ -467,8 +467,11 @@ static int perf_del_probe_events(struct strfilter *filter)
>  
>  	ret = probe_file__get_events(kfd, filter, klist);
>  	if (ret == 0) {
> -		strlist__for_each_entry(ent, klist)
> +		strlist__for_each_entry(ent, klist) {
> +			if (probe_conf.quiet)
> +				continue;
>  			pr_info("Removed event: %s\n", ent->s);
> +		}
>  
>  		ret = probe_file__del_strlist(kfd, klist);
>  		if (ret < 0)
> @@ -478,8 +481,11 @@ static int perf_del_probe_events(struct strfilter *filter)
>  
>  	ret2 = probe_file__get_events(ufd, filter, ulist);
>  	if (ret2 == 0) {
> -		strlist__for_each_entry(ent, ulist)
> +		strlist__for_each_entry(ent, ulist) {
> +			if (probe_conf.quiet)
> +				continue;
>  			pr_info("Removed event: %s\n", ent->s);
> +		}
>  
>  		ret2 = probe_file__del_strlist(ufd, ulist);
>  		if (ret2 < 0)
> @@ -531,7 +537,7 @@ __cmd_probe(int argc, const char **argv)
>  	struct option options[] = {
>  	OPT_INCR('v', "verbose", &verbose,
>  		    "be more verbose (show parsed arguments, etc)"),
> -	OPT_BOOLEAN('q', "quiet", &quiet,
> +	OPT_BOOLEAN('q', "quiet", &probe_conf.quiet,
>  		    "be quiet (do not show any warnings or messages)"),
>  	OPT_CALLBACK_DEFAULT('l', "list", NULL, "[GROUP:]EVENT",
>  			     "list up probe events",
> @@ -631,7 +637,7 @@ __cmd_probe(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, probe_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  
> -	if (quiet) {
> +	if (probe_conf.quiet) {
>  		if (verbose != 0) {
>  			pr_err("  Error: -v and -q are exclusive.\n");
>  			return -EINVAL;
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 71905ede0207..55771113791f 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -10,6 +10,7 @@ struct nsinfo;
>  
>  /* Probe related configurations */
>  struct probe_conf {
> +	bool	quiet;
>  	bool	show_ext_vars;
>  	bool	show_location_range;
>  	bool	force_add;
> -- 
> 2.47.1
> 
