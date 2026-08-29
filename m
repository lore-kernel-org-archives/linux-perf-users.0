Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686883F1055;
	Sat, 29 Aug 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788036143; cv=none; b=HYQ3VeYQd8iqTK08eytQmYQTBoPVkwA38O7NLi0DuCuXVr9rZWIKpwClLXq13mDGgTXL3r2tY1My6uKT6atdW6DZfIYKSz7CYDPw9gexfKTrkc/O3BoRZmEaGXDnbulrdEqfLkTnhzosJXpQ7PLcIkaSIghxwh5KQ32v3s/pU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788036143; c=relaxed/simple;
	bh=7pnisAbPvZCl6hLVMmKKSLCR5ypPoXZrCyuBQrB8SHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+H5pJyd/VZ9oojEpvHPG7+Cu+znwha2gOAJICDlryGybA+Pl2Oiay4OMNV/rEK/XR2B0flA81tC651kQ7ZiQ6QLor89TJAsJhB/f1BpJdVKrf0hYLUHwWhFFMqiHzt+VTBAplxE2yT0HnrzshDNMiJBRA+vFm/rytc+tRkOM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPZtiwog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPZtiwog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68F11F000E9;
	Sat, 29 Aug 2026 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788036142;
	bh=AIe+WCr6esoZ5QMqOj0zl4Z3E8z646FJXD6VeghVE0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPZtiwogselmZhmHLaFQ7HjmJ5Y1mUWLACb+/EYUaQ2t6lTFMRf5ctnIMmSHXPGYM
	 XFYkNyKBT0VIg/WRIIJZ7qGfvV5EKbAuwNBnu60ZIwbOFMM9Pivlz/MugDHRkSKtba
	 mM7qiuKfonLETNygzYWbq75hMmyjYyrX3NHZWk33/qQjzMgn06Fosg6eMut8FrKlmy
	 QVVbE70C915UeCcXy9DYFE9IT1f9y4iIDdWC4lRTiq2Y3eX2djI9HsRTNGq1bxew4H
	 VO1DRZrIwnMEqNNfKVmeql7TkZ3O/U+48tHUPeD3bj7PjHzYOOLe13Bq1uDo++XkaF
	 scWrcQ+QjXXZQ==
Date: Sat, 29 Aug 2026 13:42:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] perf unwind: handle allocation failure in
 libdw__get_entries()
Message-ID: <apNELHaLHzBrPwrd@google.com>
References: <20260818142902.639F51F000E9@smtp.kernel.org>
 <20260818144837.741469-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818144837.741469-1-triet.hoang.dev@gmail.com>

On Tue, Aug 18, 2026 at 02:48:37PM +0000, Triet Hoang wrote:
> Check the return value of zalloc() before dereferencing the allocated
> dwfl_ui_ti structure.
> 
> Return -ENOMEM when the allocation fails to avoid a NULL pointer
> dereference.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changes in v2:
> - Free the ui structure before returning -ENOMEM to avoid memory leak.
> ---
>  tools/perf/util/unwind-libdw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index 7f35042be567..fd8a5125468c 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -379,6 +379,11 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
>  		dwfl = dwfl_ui_ti->dwfl;
>  	} else {
>  		dwfl_ui_ti = zalloc(sizeof(*dwfl_ui_ti));
> +		if (!dwfl_ui_ti) {
> +			free(ui);
> +			return -ENOMEM;
> +		}
> +
>  		dwfl = dwfl_begin(&offline_callbacks);
>  		if (!dwfl)
>  			goto out;
> -- 
> 2.53.0
> 
