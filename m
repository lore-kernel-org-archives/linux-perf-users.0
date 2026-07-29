Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5499432BF4;
	Wed, 29 Jul 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364172; cv=none; b=NkHuN4KZ7KENZf6ImVtK+iumkcTGa3z5yOmFYODtQ5SvFhUzdijLxIwyNv8Bfb0kaVtTpwEv5dJgMl4PR4EAlWNtdyU9ysGKbKflTA12lWVbYEVKIaQRyDG5soshpR2DITRSt/OINaM21jPjrTs9jM4YNhQ/tB3GoBqJ2kvu6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364172; c=relaxed/simple;
	bh=37z9+LqiOrwnmYGEkRWmGoCt7mFclFuiVWkTxFxzz4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3ind83Bl5IHP8z2F6t+c1qB4X2pJP8977e/wWTJ1Kxi5rxiB23NegvO/x6CEw3kl+Y5U9V5nz/xo2IhXhaLsTUSJ7QZa7dJJKEAfkgy6eQ5TylLC+J6eiI64Fjut5AZ41sihCN/8YdhUjoUNC8GQjNXPQDwe62096aWAZ+FPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1IX1HWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1IX1HWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A801F000E9;
	Wed, 29 Jul 2026 22:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785364171;
	bh=x6n/h7j6UiRNWh36uhnx6kkrahhow7yjBJ0zpEn3t5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e1IX1HWwbiBn110ryRxB4J/dh19ZvKXmLWe/kj90gej/Q344r12Tu4iwn6N/nh5ed
	 Q5zMi0fi860vElhFJvrjq3DpJAYBVxdSlWb0CzydmFsgyjjzb5ToxGImSlKe9430pu
	 t5BWHoEFCRf5KPXK93JgtdHWauFI23KHVcs2EtUL9E1Wi6GhqJfswNqTsA3vxMlt1R
	 vGntG2agu6UYrE9XDaLjQmGKEf7WI6rPePXFY7RejeVxK6/5kTJI81ZuD/Tgtbg7pk
	 2jFdiBo/i/436ga3Qi9VC75GbAzpXg1HujodNqkXLXck67zBVcnH1iODIXp9vzonpd
	 I+udPF0ZxDiaQ==
Date: Wed, 29 Jul 2026 23:29:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] perf/cxl: Program the requested event group on
 configurable counters
Message-ID: <20260729232927.0ebdffff@jic23-huawei>
In-Reply-To: <20260729145555.3919550-2-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 07:55:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
> never sets *event_idx, so hwc->event_base stays 0 and cxl_pmu_event_start()
> programs event group 0 regardless of the group the user requested.
> 
> Return the matched capability's event_idx.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One minor thing.  Otherwise LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---

>  drivers/perf/cxl_pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8..e77c0650a7eb 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -552,6 +552,8 @@ static int cxl_pmu_get_event_idx(struct perf_event *event, int *counter_idx,
>  			return -EINVAL;
>  
>  		*counter_idx = i;
> +		if (event_idx)
Hmm. We never want to get counter_idx and not event_idx.  Perhaps
add this check to the one for counter_idx at the top of this scope.

> +			*event_idx = pmu_ev->event_idx;
>  		return 0;
>  	}
>  

