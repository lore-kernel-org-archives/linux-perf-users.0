Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9D1ADC83;
	Mon, 17 Aug 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787007756; cv=none; b=sWz6a5NI2DF/lL9D0HlSdOUIjgZ2GPcIhfYvViuz5A8IRGNR5LzuR5CbolnNWGoa9WpYXt6X6pjQqhrURXQD6w4MRfZNs1eTD58WeqPcHXgIIihHORWLjO2XpgFuDgiY2zZVGg2UMueuKcwesHcBu8LaoZfwplpH5w12BDzfNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787007756; c=relaxed/simple;
	bh=e8EMNXxq9+iQqD4gfu3pmmm1zRF3xeK5FsZcBR+U1xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsHkbU5caJ29dH09wMYRqLdhe/I3U6QVjriJ0HIf+4HMk6df+fM4u8WBFBfJiyzSygVCE4bs8LF3Rlc60skAq/CiZNR3R2C7L05+LKBpOs0DMxCoQd2qBxPAU8Pjq6XuQT53WdtxU+kujZ4BphVhQ4yOfF+ZkMeMQlePDTBaETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCUYOw4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCUYOw4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1891F000E9;
	Mon, 17 Aug 2026 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787007754;
	bh=CLw/VAoIJPd9unoZwVARUPa1a4eEuhEV58nV4ukbC2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iCUYOw4djGhfWuJPrm48urhfv59bI/VwqjtWlyGQ/cQFp29DgiyoUc0XH6sAv5IOO
	 uagvm9Fo4IGCLtgyydn8U/tuuHUn0E1pd78d4rM5ORmqS9xKmeztQXjPgrk16N6FeE
	 XQB6o4D4oHSpzqOL9sd8WZIoFtIXorYsmXvfYagF6Ate321zOlgRgmbUpxmebGiv3S
	 bJNtqxTMak3OoEW/0Zoxr4BBx6gCtsJPnj38sOKqf8/ApBIbjA+YdTbgKc7WSzLGtc
	 3iMlQ/QLO1MLh+qIBtgpHuno+/sm4LYd+5gofAo7x0fq7jNav1F5/laSI6hi9pvuzE
	 py2G40gjDE1FQ==
Date: Tue, 18 Aug 2026 08:02:33 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tshah@linux.ibm.com
Subject: Re: [PATCH v2] perf evlist: Warn when 'sleep' workload is used
 without system-wide (-a) option
Message-ID: <aoOTCbDeBldwyeOr@google.com>
References: <20260806021038.2291417-1-irogers@google.com>
 <20260806041414.20327-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806041414.20327-1-irogers@google.com>

On Wed, Aug 05, 2026 at 09:14:14PM -0700, Ian Rogers wrote:
> A common mistake when trying to record system-wide profiles for a given
> duration is running commands like 'perf record sleep 1' or 'perf stat
> sleep 1' without passing '-a' / '--all-cpus'. When '-a' is omitted, perf
> defaults to per-process monitoring of the sleep process itself, which
> does not collect system-wide activity and records very few events.
> 
> Add a warning in evlist__prepare_workload() when the workload executable
> is 'sleep' and system-wide mode is not enabled.
> 
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evlist.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index eb7c0d7be064..b3dd097fbb2c 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -11,6 +11,7 @@
>  #include <inttypes.h>
>  #include <signal.h>
>  #include <stdlib.h>
> +#include <string.h>
>  
>  #include <fcntl.h>
>  #include <linux/bitops.h>
> @@ -1562,6 +1563,20 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
>  	int child_ready_pipe[2], go_pipe[2];
>  	char bf;
>  
> +	if (argv && argv[0] && target && target__none(target)) {

As I read the code, argv and target should be provided.  So the
condition simply can be target__none().  I'll make the change.


> +		const char *cmd = strrchr(argv[0], '/');
> +
> +		if (cmd)
> +			cmd++;
> +		else
> +			cmd = argv[0];
> +
> +		if (!strcmp(cmd, "sleep")) {
> +			ui__warning("workload '%s' specified without the system-wide (-a) option\n",
> +				    cmd);

Now it's not just the system-wide option, but I guess it's most likey
what users want.  I hope this would improve UX of the tool a bit. :)

Thanks,
Namhyung


> +		}
> +	}
> +
>  	evlist__set_workload_cork_fd(evlist, -1);
>  
>  	if (pipe(child_ready_pipe) < 0) {
> -- 
> 2.55.0.629.g250fe7f194-goog
> 
