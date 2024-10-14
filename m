Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBF3E499;
	Mon, 14 Oct 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872689; cv=none; b=qaBE6aYiSNLay6722ZxlpDgvQZ6IcOoV+bXOoHLFItCkrASFh98pKx0lFd1M2zWQxaulAzxojpy3EhgouX1b2rqNJN72Gg9LFOEekmNU/J8p1luLSf9DIxMOwjekM5Q0COTPb1cC+7hRc8IYH0G5PYcqZhNRR8d49jLw1RUTnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872689; c=relaxed/simple;
	bh=g/DAxs5dzK8K8pQYu35Djg8/2ZKXMriYr9hwS4xw9Vs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HsMjipkMJo581PYpQIFrSz5H7Sz/m0CNqHIpWmxrVmSXNrxCferby20f0TVQcuAaQBDw1S3K/OJca6GoVEf/DorHto5u4ugmxmnYruXasUU7z3PG8OhhXZcHjTjQJzxLhHuB6o4dGf6VaDx4cRWD1I1o2lw9+ppGWxD1DPDlMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7I0mxWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7I0mxWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2FC4CEC5;
	Mon, 14 Oct 2024 02:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728872689;
	bh=g/DAxs5dzK8K8pQYu35Djg8/2ZKXMriYr9hwS4xw9Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7I0mxWQPO1NP6XxnSt/xCKZYnNeFPA6xxE4/tB3rximKv7jSHckBLO32HWgeDW1I
	 me3LSdMNsvwQldl+e4aweJnsQPwM65Z3tlnwb8cNmTdll0dSuHKF/Qby8AHHVlnKE1
	 mDVgavh/qmpFCL62tgOgVX7rN9F5gXWK55+lFBIUGf47xM55HfinL2wykDA+Z55v5q
	 f81Z5B5FHT1n8TZHGRwMVple0PI+JW00fDHZ4fwU69U/PMmH4fJlXzR8aPj5KxO0eW
	 l8giR7PCctCRmlN15j9UJXapFfXpBZ3jyobL2W38tLmm3IlG/0jK3GrT+NC/Fva9HK
	 By/oti/sMYpAg==
Date: Mon, 14 Oct 2024 11:24:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf probe: Improve log for long event name
 failure
Message-Id: <20241014112443.97b129e774d9f313dc32568e@kernel.org>
In-Reply-To: <20241012204725.928794-4-leo.yan@arm.com>
References: <20241012204725.928794-1-leo.yan@arm.com>
	<20241012204725.928794-4-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 21:47:25 +0100
Leo Yan <leo.yan@arm.com> wrote:

> If a symbol name is longer than the maximum event length (64 bytes), the
> perf tool reports error:
> 
>   # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
>     snprintf() failed: -7; the event name nbase='this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)' is too long
>     Error: Failed to add events.
> 
> An information is missed in the log that the symbol name and the event
> name can be set separately. Especially, this is recommended for adding
> probe for a long symbol.
> 
> This commit refines the log for reminding event syntax.
> 
> After:
> 
>   # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
>     snprintf() failed: -7; the event name 'this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)' is too long
>       Hint: Set a shorter event with syntax "EVENT=PROBEDEF"
>             EVENT: Event name (max length: 64 bytes).
>       Error: Failed to add events.
> 

Nice!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-event.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 224ec6818803..2a2fc5e78c5c 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2760,7 +2760,10 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
>  	/* Try no suffix number */
>  	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
>  	if (ret < 0) {
> -		pr_warning("snprintf() failed: %d; the event name nbase='%s' is too long\n", ret, nbase);
> +		pr_warning("snprintf() failed: %d; the event name '%s' is too long\n"
> +			   "  Hint: Set a shorter event with syntax \"EVENT=PROBEDEF\"\n"
> +			   "        EVENT: Event name (max length: %d bytes).\n",
> +			   ret, nbase, MAX_EVENT_NAME_LEN);
>  		goto out;
>  	}
>  	if (!strlist__has_entry(namelist, buf))
> @@ -2780,7 +2783,10 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
>  	for (i = 1; i < MAX_EVENT_INDEX; i++) {
>  		ret = e_snprintf(buf, len, "%s_%d", nbase, i);
>  		if (ret < 0) {
> -			pr_debug("snprintf() failed: %d\n", ret);
> +			pr_warning("Add suffix failed: %d; the event name '%s' is too long\n"
> +				   "  Hint: Set a shorter event with syntax \"EVENT=PROBEDEF\"\n"
> +				   "        EVENT: Event name (max length: %d bytes).\n",
> +				   ret, nbase, MAX_EVENT_NAME_LEN);
>  			goto out;
>  		}
>  		if (!strlist__has_entry(namelist, buf))
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
