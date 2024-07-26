Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6F184F;
	Fri, 26 Jul 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002836; cv=none; b=W8kaT3CATsu3EmEPE2GtSx2eCnoojjl9IMOVPMsQi20IdDKv5QHgSbXe8MqACoZfbIlsasR26NFUiviTfv3Uul8xCjGaBT+gKGX42JRlMJJouM9c2XeCBU9R/HPmDaj1gT6pJU8f5UbCqeujxbacoV7cDyNXLj8Fc/g9LUZZcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002836; c=relaxed/simple;
	bh=Z+PvFq/xBgikryp/KyfhhKR9iFSUp9SZLnwUq3AWFm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcJas59hY5wI69BQbg2dtyiWerje2v3E9ZO2PS+Gug2mW+5YTMIaXV6DdXkku3NFJM5gG5y0q18zUu8SPV/jhA1VYQshykmQR2bBKyx5e6t6BRVWDlC17tV9DMgmT2g0vcN72XHhzkq/lr1pcp9TRGg2Cw9sjFzGnJxXc3pjnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6BJRdbM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6BJRdbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EFFC32782;
	Fri, 26 Jul 2024 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722002836;
	bh=Z+PvFq/xBgikryp/KyfhhKR9iFSUp9SZLnwUq3AWFm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6BJRdbMDgd8F6TpGJglbd5VrGos3y+vwxFwFAEeTRXIuaOZtqgT8t+SSsx+kpWtc
	 rjj2Hif+jddLKB+pLRSe2cD4yCIOt5NgHUKLE9DVFpYuDX/8CIZcCJ1CM5l1kiqaMY
	 BfWgvCj/f/PCcNPUkNHxD3g2Z0JxokE2rTlsuP4MpjJv9bjejezaw8ast4ysO9IcI3
	 3VcEWvYQ7aT7929h4BUzPCoQoQHe+/HBtJOiiZ/slhmihYHk0bIx7LA+GSpZFcYaB9
	 RWGpaPvhR2Q0KH8Yopcwz+3M+24uX9XXNhSxa0/UmLY4W5bWkL6kHmfz/9vgDpGUuj
	 FjQ6rHAdxJIeA==
Date: Fri, 26 Jul 2024 11:07:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, yzhong@purestorage.com
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
Message-ID: <ZqOtkPGcijWW52aj@x1>
References: <20240722211548.61455-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722211548.61455-1-cachen@purestorage.com>

On Mon, Jul 22, 2024 at 03:15:48PM -0600, Casey Chen wrote:
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> thread__find_map() could return with al->maps being NULL.
> 
> The path below could add a callchain_cursor_node with NULL ms.maps.
> 
> add_callchain_ip()
>   thread__find_symbol(.., &al)
>     thread__find_map(.., &al)   // al->maps becomes NULL
>   ms.maps = maps__get(al.maps)
>   callchain_cursor_append(..., &ms, ...)
>     node->ms.maps = maps__get(ms->maps)
> 
> Then the path below would dereference NULL maps and get segfault.
> 
> fill_callchain_info()
>   maps__machine(node->ms.maps);
> 
> Fix it by checking if maps is NULL in fill_callchain_info().
> 
> Signed-off-by: Casey Chen <cachen@purestorage.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> ---
>  tools/perf/util/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1730b852a947..6d075648d2cc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
>  int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
>  			bool hide_unresolved)
>  {
> -	struct machine *machine = maps__machine(node->ms.maps);
> +	struct machine *machine = node->ms.maps ? maps__machine(node->ms.maps) : NULL;
>  
>  	maps__put(al->maps);
>  	al->maps = maps__get(node->ms.maps);
> -- 
> 2.45.2
> 
