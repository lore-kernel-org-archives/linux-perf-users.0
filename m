Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519BEAD7;
	Wed, 28 May 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455628; cv=none; b=KGxaJJg8tcceSz+8qWu+LHu+oPEdYPhWGB4GNnQ+qufIMWN+r2qzQOokIyCcZ7AcKZj69K5uFxIgR1Vkq4asLMbjBtPNKpCLOP8Atxtzmp7DjVc/ivFNTO/gc2IiHxYfNGrdCPZInjH0Fqqyu88RdSHnES6JYPQhqo8+XkDzU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455628; c=relaxed/simple;
	bh=n1jaTc09zu8RAZsHSVnrZVQ4yyD+khqHCH7iV6CHfjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7+Z73ty+0Oh3ZuYxIG5lRBWwvJ4H8O+eaVfAqVyViL3IfzqJXXpqPs9UmyYHozb7Z+wC2Wv3cq45roLHuF/YMUKbiwmyDJI3iymYhd/gPT1wCK0Vkl2CqS7EZ7dmVqW7bzIfWIY4VcB5FZdhG82bnB3RH0//tXRNedBSegFbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekUJQKQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekUJQKQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0B2C4CEE3;
	Wed, 28 May 2025 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748455627;
	bh=n1jaTc09zu8RAZsHSVnrZVQ4yyD+khqHCH7iV6CHfjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekUJQKQeHM9EXOmJDZydfKsoPIxDQlvT/v1hThSkSO1n/k8/Hz41baXXpT0UPNkBj
	 ir2dVwEiQFVDpxsE3Oyo45sg0WzDKtcz08smQ+jY6UTcB7mbGllcbIdLaZF0Iy7dqm
	 v3S/dDhnzVwogBjmawhVnyjJauRuiOE7MNY0W0ocZQxSWdiMijoAy3+NkfHWcrKNww
	 9xZ3cEgmvWrS4qJw2BCENWZCIH8z1wxf9f6KvwrAZPm8MRNOmJDdIIdOiEmGvvMUI3
	 8YREgHo5xu+oVEvEt9hC8NtlTZwjx8U+TVxN7JHzL2XULvFZ9bXfNw77WbwXYiWBU7
	 5ES1rAmz04/Uw==
Date: Wed, 28 May 2025 15:07:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Junhao He <hejunhao3@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH RESEND] perf stat: Fix JSON output formatting in
 iostat_prefix()
Message-ID: <aDdQyPNrnd4b-qWg@x1>
References: <20250520094525.97706-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520094525.97706-1-suchitkarunakaran@gmail.com>

On Tue, May 20, 2025 at 03:15:25PM +0530, Suchit Karunakaran wrote:
> The iostat_prefix() function previously included a TODO noting that its output
> format was incorrect in JSON mode. This patch corrects that by conditionally
> formatting the prefix string based on the output mode specified in
> perf_stat_config.

O don't have how to test this as I dont have:

access("/sys/bus/event_source/devices/uncore_iio_0", F_OK) = -1 ENOENT (No such file or directory)
write(2, ""..., 37Unsupported uncore pmu configuration
)                     = 37
write(2, ""..., 43
 Usage: perf stat [<options>] [<command>]
)                     = 43
write(2, ""..., 1
<SNIP>
write(2, ""..., 84                          measure I/O performance metrics provided by arch/platform
)                     = 84
exit_group(129)                         = ?
+++ exited with 129 +++
root@x1:~# strace -s0 perf stat --iostat --timeout 1000

Could someone with access to hardware with this capability to try this
patch and provide a  Tested-by?

- Arnaldo
 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/arch/x86/util/iostat.c | 35 ++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index 7442a2cd87ed..1d9c20dab5c7 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -403,18 +403,29 @@ void iostat_prefix(struct evlist *evlist,
>  	struct iio_root_port *rp = evlist->selected->priv;
>  
>  	if (rp) {
> -		/*
> -		 * TODO: This is the incorrect format in JSON mode.
> -		 *       See prepare_timestamp()
> -		 */
> -		if (ts)
> -			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
> -				ts->tv_sec, ts->tv_nsec,
> -				config->csv_sep, rp->domain, rp->bus,
> -				config->csv_sep);
> -		else
> -			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
> -				config->csv_sep);
> +		if (ts) {
> +			if (config->json_output)
> +				sprintf(prefix,
> +					"\"interval\" : %lu.%09lu, \"device\" : \"%04x:%02x\"",
> +					(unsigned long)ts->tv_sec, ts->tv_nsec,
> +					rp->domain, rp->bus);
> +			else if (config->csv_output)
> +				sprintf(prefix, "%lu.%09lu%s%04x:%02x%s",
> +					(unsigned long)ts->tv_sec, ts->tv_nsec,
> +					config->csv_sep,
> +					rp->domain, rp->bus, config->csv_sep);
> +			else
> +				sprintf(prefix, "%6lu.%09lu %04x:%02x%s",
> +					(unsigned long)ts->tv_sec, ts->tv_nsec,
> +					rp->domain, rp->bus, config->csv_sep);
> +		} else {
> +			if (config->json_output)
> +				sprintf(prefix, "\"device\" : \"%04x:%02x\"",
> +					rp->domain, rp->bus);
> +			else
> +				sprintf(prefix, "%04x:%02x%s", rp->domain,
> +					rp->bus, config->csv_sep);
> +		}
>  	}
>  }
>  
> -- 
> 2.49.0
