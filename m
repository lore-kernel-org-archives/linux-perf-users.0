Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0F1DFD0
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2023 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXnFJTIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A384C433C8;
	Tue, 31 Oct 2023 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698766935;
	bh=Dw8ImV/4ZAJzS87ziXlkmmx+cmvVvi27xsx4oc2kmrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXnFJTIh2x0y83gcmvEuK8CV8TjQKH41UVhXf27AvAwsI5iNQYERacAaa+GPM8JOY
	 GRXniM8O+WY4+aG2cXLYoDT4VRAPAk1gYW27oUbIg6AA40ahgYK0lev6cX+JQxusnI
	 BU1ZuftgtsO+vPlMasr7wsdrfzk4D38XybhlBNg9fJltLH9/Lw7+7kqnWxpbQ3a9uP
	 Nt5di+l2Wv7DX0qZXDpudwQOQMQSILEAtedOECu21mIj0KBj0EC6xQ+OaP90aJaTQS
	 QFrRPvmd6Hj9Dw+7GpS/WRCSNPYKNDY+VKA3kQYkVWkCpYtSEFisEcpk43jOTfnQd3
	 2KOUjrItefzeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 58E314035D; Tue, 31 Oct 2023 12:42:12 -0300 (-03)
Date: Tue, 31 Oct 2023 12:42:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf debug: List available options when no variable is
 specified
Message-ID: <ZUEgVDlBQjFQB2W/@kernel.org>
References: <20231031080823.1418025-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031080823.1418025-1-yangjihong1@huawei.com>
X-Url: http://acmel.wordpress.com

Em Tue, Oct 31, 2023 at 08:08:23AM +0000, Yang Jihong escreveu:
> Before:
 
>   # perf --debug
>   No variable specified for --debug.
 
> After:
 
>   # perf --debug
>   No variable specified for --debug, available options: verbose,ordered-events,stderr,data-convert,perf-event-open.

Looks useful, but the implementation can be different to reduce
maintainership costs, see below:

> +++ b/tools/perf/perf.c
> @@ -279,7 +279,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  		} else if (!strcmp(cmd, "--debug")) {
>  			if (*argc < 2) {
> -				fprintf(stderr, "No variable specified for --debug.\n");
> +				fprintf(stderr,
> +					"No variable specified for --debug, available options: %s.\n",
> +					perf_debug_options_string);
>  				usage(perf_usage_string);

> +++ b/tools/perf/util/debug.c
> @@ -215,6 +215,9 @@ void trace_event(union perf_event *event)
>  		     trace_event_printer, event);
>  }
>  
> +const char perf_debug_options_string[] =
> +	"verbose,ordered-events,stderr,data-convert,perf-event-open";

Instead of adding a new variable that has to be kept in sync with
debug_opts[], you could provide a function that iterates debug_opts,
printing its options names, then use that function on perf.c handle_options.

- Arnaldo

>  static struct sublevel_option debug_opts[] = {
>  	{ .name = "verbose",		.value_ptr = &verbose },
>  	{ .name = "ordered-events",	.value_ptr = &debug_ordered_events},
