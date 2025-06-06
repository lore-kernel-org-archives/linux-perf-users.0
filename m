Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD72AF10;
	Fri,  6 Jun 2025 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182276; cv=none; b=IyFgOYb+QjsDuLI1FD8Ai0C2KP0D4Ug47PduUUOAMgHXX3QJLL/A0hEs6caOxdGDy5h/ChrjW74bJqZ5W+b+MLOLynh/gSQq4RS3h5uDRuEIyRKyvQSWGjB4fiUazf8s72zLux1rhKoLBsgOjIdsMbvBr/6SOSJiGNuQyHexb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182276; c=relaxed/simple;
	bh=+G79hgSmIG6oW9WzrBUTNEwLWgrs6kdcW4Ux99u8tkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0mZQ/dAtboh826U4ZU0bp3tPwG6F4Yaa2t4pZg21qFAy3CmmZsGnVaCqkbV/hEyRv3ObUkCeITAuNCB5/mCyuJ5HE4yR3Pt0pThSHPTEXWjE369AK3JHOejP3u6dxPAjRmU2N37hvWZgEyG0SgpBJ3X8dEe6/pFBgmclZLQQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edfkVOT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edfkVOT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581BDC4CEED;
	Fri,  6 Jun 2025 03:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749182275;
	bh=+G79hgSmIG6oW9WzrBUTNEwLWgrs6kdcW4Ux99u8tkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edfkVOT8tJIHy17rb46G4tnRJDqlpRvUkbFQ5xYXK7tFccZ2CmJqLMT3ybMTEY/eP
	 5VlmF+UhoI0sDHJnTyFRvOu0IWHzl1z/PHKrqFIeTP/KW6W4Lelzz1mb4pmI9EQdUU
	 +1net7gUcsZHIwRRpjYiOceLQba56gYDZMU5wSBtgVP9f3/ZZtDTj5t5psfmqMJcqn
	 OyDrjI6BMLThmeTvXcW6OsEFwOAfxTqr5DRi+fTXkhM1qob0YfN7d7DJUlVbVqAM3V
	 L6C8OFmRmhwMZCeLCz1mHLGgIVVB48mkvcPyxsV1U1D1GCJB5vtmK/CDmi3JDR6ocs
	 VEEML7OeFkRNg==
Date: Thu, 5 Jun 2025 20:57:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH RESEND] perf stat: Fix JSON output formatting in
 iostat_prefix()
Message-ID: <aEJnQIviayEi-Jsv@google.com>
References: <20250605180012.16788-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605180012.16788-1-suchitkarunakaran@gmail.com>

Hello,

On Thu, Jun 05, 2025 at 11:30:11PM +0530, Suchit Karunakaran wrote:
> The iostat_prefix() function previously included a TODO noting that its output
> format was incorrect in JSON mode. This patch corrects that by conditionally
> formatting the prefix string based on the output mode specified in
> perf_stat_config.

I've tested this.  It doesn't work well.

Before:
  # ./perf iostat -j -I 1000 true
  #          time    port              0.000517525 0000:00 "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
       0.000517525 0000:80 
       0.000517525 0000:17 , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
       0.000517525 0000:85 
       0.000517525 0000:3a , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
       0.000517525 0000:ae 
       0.000517525 0000:5d , "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
       0.000517525 0000:d7 


After:
  # ./perf iostat -j -I 1000 true
  #          time    port         "interval" : 0.000463559, "device" : "0000:00""Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
  "interval" : 0.000463559, "device" : "0000:80"
  "interval" : 0.000463559, "device" : "0000:17", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
  "interval" : 0.000463559, "device" : "0000:85"
  "interval" : 0.000463559, "device" : "0000:3a", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
  "interval" : 0.000463559, "device" : "0000:ae"
  "interval" : 0.000463559, "device" : "0000:5d", "Inbound Read(MB)" : "0", "Inbound Write(MB)" : "0", "Outbound Read(MB)" : "0", "Outbound Write(MB)" : "0"
  "interval" : 0.000463559, "device" : "0000:d7"

Thanks,
Namhyung

> 
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
> 
