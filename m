Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D91A76BC;
	Mon, 11 Nov 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346890; cv=none; b=IufQIDH3D2f8xJ8WgtaSFYL7f0Ggw0hMHFD1or0Sd1votoPrbanQ8kpm/ZceYnVx2lOd/GrmOJYjEnEDgvLmU3JI2V0b9H40MATX+ZKLklHc1rGCkPnP+Di9SsNcoV9IwTCvbw3la1DxRUKxtNA4X0Sm4DIiIfhxeawDQToYBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346890; c=relaxed/simple;
	bh=nBJeMF7J8dP9qNPnksnLqeuPoG6Qr8vVGzPaM8kGXyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPyp5DwglfH2a3kqifcIWEaUcvcGc7MXXAWiVh4Zh88nXuuZBF5AjUDIH4wH12C79VnoQV5KcesUpGKHVOxQ95bbZBdhVaSvRsND46ShXI36jy9Q9nAqfg23muDMi+qA4neW/h2aMh8L6S2F1vJ1VX/fGxNQQGW6LySKUOEOmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auDMnhZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auDMnhZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC72EC4CECF;
	Mon, 11 Nov 2024 17:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731346889;
	bh=nBJeMF7J8dP9qNPnksnLqeuPoG6Qr8vVGzPaM8kGXyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auDMnhZuyc1IWX6sXVHIf3fZdv1yRTy85Pl0enY+2NsnOEYHbNimwy+pfilEl7I4A
	 KiTZkG5PHMZj1yVlIOsuOdAcOl52AiHws54MSpGPJ7kdXQBS1DjqTR5iBU33KqsmvL
	 atMsQO1mdiC0UiTF/Xgjbp5GVIiYnBy4Ov0V6SqXNk9l6gy5FFJmlgFa6HMkmQa9yz
	 KZsMvKl1Sz4fszsT/5kyxr7QF3A/io9l8B8dZcIkAU+bO2cKYiMflDVHwKYIYZgQIW
	 +N76w3wfsnoezZzR+oF8ZVMUswI0luFPhM7nAR9hRYvYDzjUYsxuzLVOMEj/J4DqHF
	 fl5MMvE7GOdPA==
Date: Mon, 11 Nov 2024 14:41:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf timechart: Remove redundant variable assignment
Message-ID: <ZzJBxDERNnrekzJV@x1>
References: <20241111095209.276332-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111095209.276332-1-luoyifan@cmss.chinamobile.com>

On Mon, Nov 11, 2024 at 05:52:09PM +0800, Luo Yifan wrote:
> This patch makes a minor change that removes a redundant variable
> assignment. The assignment before the for loop is duplicated by the
> initialization within the loop header.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Thanks, applied to perf-tools-next,

- Arnaldo
> ---
>  tools/perf/builtin-timechart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 218c8b44d..8388e0d81 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -1158,7 +1158,6 @@ static void draw_io_bars(struct timechart *tchart)
>  			}
>  
>  			svg_box(Y, c->start_time, c->end_time, "process3");
> -			sample = c->io_samples;
>  			for (sample = c->io_samples; sample; sample = sample->next) {
>  				double h = (double)sample->bytes / c->max_bytes;
>  
> -- 
> 2.27.0
> 
> 
