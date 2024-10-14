Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981E37B;
	Mon, 14 Oct 2024 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728866774; cv=none; b=pK1MLraVHlSP/0FKA/BixCKg1PNcV2OiZYCGZgDift/JR2kr2iUmxgDS7g0mxpTUTIMUzmRlk4lSH2SXCwKLu3cBUiAmguh2hZWm0pLSQ3LmGdHdJgQyjNHstNmYYLEsnBBEFGWW7jrHxq+EMcBGLrwriunIHjKiT4/dXkGKXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728866774; c=relaxed/simple;
	bh=38G992Ww7kFw7743ZNB4MknzmmN3LnzgutWxjnXBHH0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fLaOWscGKzw86IQlznUFLYEX5pyQyeXpHdu1mGHEA04P1vKJ2d9dMfNs50MUqk2eSrIw3P+b9NLMM5cgVcSFZKLNd5t6RqZYCni5UvmF2ohcbnab2jHpx6leJea+sl03N5r9DSa38Qwx1nCd8vRWodj4d/5cFijJ2NSZiBhUMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhKnlhTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhKnlhTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D5C4CEC5;
	Mon, 14 Oct 2024 00:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728866774;
	bh=38G992Ww7kFw7743ZNB4MknzmmN3LnzgutWxjnXBHH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GhKnlhTgZSkjALwg0jCwVektkyJQ+xaeEKJ6NDjthwcc+GOhWjt0fxGQumhTNsgft
	 JfRUzo9LrzCxL5G9N+PdO6vwBZeZO2FMA9rd6JLNpHk+3xfCnDCj2AP3ifpD7/u7tm
	 AtK19wbanbHloo946BSjIHP9X/cshZKblOJa0UivfCPh+4fDUQMAUb+MizDyVR31Qj
	 4rowCSOS1ueaVO7uMVZuQksx04+NHSVVdm1r7CchBZlmwObb6TA4fCBDZGdqxxQ87+
	 m8RiXo5lUIkV0nxmWp8OCgRpnGzASOPGzHnt+NbtkG6nXbxbWC6mAl23zB3l9+G42y
	 QgNEw9P2RCFUA==
Date: Mon, 14 Oct 2024 09:46:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf probe: Use the MAX_EVENT_NAME_LEN macro
Message-Id: <20241014094608.4b19fc04df6d57b6601c739b@kernel.org>
In-Reply-To: <20241012204725.928794-2-leo.yan@arm.com>
References: <20241012204725.928794-1-leo.yan@arm.com>
	<20241012204725.928794-2-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 21:47:23 +0100
Leo Yan <leo.yan@arm.com> wrote:

> The MAX_EVENT_NAME_LEN macro has been defined in the kernel. Use the
> same definition in the tool for more readable.
> 

Looks good to me. Thanks!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-event.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a17c9b8a7a79..061a0412dec2 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -51,6 +51,9 @@
>  
>  #define PERFPROBE_GROUP "probe"
>  
> +/* Defined in kernel/trace/trace.h */
> +#define MAX_EVENT_NAME_LEN	64
> +
>  bool probe_event_dry_run;	/* Dry run flag */
>  struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
>  
> @@ -2841,7 +2844,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  				       bool allow_suffix)
>  {
>  	const char *event, *group;
> -	char buf[64];
> +	char buf[MAX_EVENT_NAME_LEN];
>  	int ret;
>  
>  	/* If probe_event or trace_event already have the name, reuse it */
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
