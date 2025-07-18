Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09941E520A;
	Fri, 18 Jul 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861794; cv=none; b=nSslb7sO/nKEGucjlWto9E0vT9dWpJFbB5a8YV72LscmoN63g2WZsgx9vAJcUkb4cssSYmaJ/NsQXdKLcDAUIyxU92e5HmaZX8mKsFTenKsOx5QP6faCTKu7QiW9DzZne26kvYMQlvUtFAGdnhpKilsGjtgNY5s/Kc5muAx10G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861794; c=relaxed/simple;
	bh=Ymuq3fcOG4bE6fjU8jHkkC7O6c7maXrC0fNf+qQK+pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nywBb7iIHwh3ZGfH5ghmChMVu6bHwi7BTj5rLzose5RqE75Eh0Vneb60lxn7rJUxSTsTaBV1ARWdckHrOiXOwmKIFIlZiphUFxq3AGVi49/9X/snGWNf9JYKHUHWSjNCY5t13v7zPUOcLOCxiOCKwfWBf8eqj/Uv+MovcjacwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEkjQJbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEkjQJbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4FFC4CEEB;
	Fri, 18 Jul 2025 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752861793;
	bh=Ymuq3fcOG4bE6fjU8jHkkC7O6c7maXrC0fNf+qQK+pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEkjQJbJAhyzumWpB8tp+SVQwbCqd/LrVlNaiA8kjqe4+bO2YIwJPPudDZCFGiAFk
	 GrPgbqP06JjuR7RW7vu2lxXl5LfNxee19mOsfZvSumNmxG5Ftzs2aqMLfbmWrEom8e
	 73HHriPVcCAZgH98HIE4wcS2PjNbZVvxvfQdQXH7pcyQtG+HbQ2aaBiJp4etiART9A
	 buBjicJW6YrjFsSbTlsX6CAcvMkVJ4kyF8dQcMXLBx/BocelTIW1OzRlzwV3mXO0gr
	 ny+hQ8x/sjudh2ZydQvh1mTdULDYJQNYIWhaD86d5SlEVaEh+tm8NIXLPydk5FtZe2
	 XsF0rFHHvbjUw==
Date: Fri, 18 Jul 2025 11:03:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] perf stat: Fix JSON output formatting in
 iostat_prefix()
Message-ID: <aHqMXz9KOpRuQNcj@google.com>
References: <20250713151224.43764-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250713151224.43764-1-suchitkarunakaran@gmail.com>

Hello,

On Sun, Jul 13, 2025 at 08:42:24PM +0530, Suchit Karunakaran wrote:
> The iostat_prefix() function previously included a TODO noting that its output
> format was incorrect in JSON mode. This patch corrects that by conditionally
> formatting the prefix string based on the output mode specified in
> perf_stat_config. Note, I didn't test it since my system doesn't support
> it.

Can any Intel folks verify this with combination of various options
like -x/-j, -I and --metric-only?

Thanks,
Namhyung

> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/arch/x86/util/iostat.c | 40 +++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> Changes since v1:
> - Fix issues in formatting
> 
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index 7442a2cd87ed..d7ae19fb83e5 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -403,18 +403,34 @@ void iostat_prefix(struct evlist *evlist,
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
> +		if (config->json_output) {
> +			if (ts) {
> +				double timestamp = ts->tv_sec + (double)ts->tv_nsec / 1e9;
> +				sprintf(prefix, "{\"interval\": %.6f, \"device\": \"%04x:%02x\", ",
> +					timestamp, rp->domain, rp->bus);
> +			} else {
> +				sprintf(prefix, "{\"device\": \"%04x:%02x\", ",
> +					rp->domain, rp->bus);
> +			}
> +		} else if (config->csv_output) {
> +			if (ts) {
> +				sprintf(prefix, "%lu.%09lu%s%04x:%02x%s",
> +					(unsigned long)ts->tv_sec, ts->tv_nsec,
> +					config->csv_sep, rp->domain, rp->bus, config->csv_sep);
> +			} else {
> +				sprintf(prefix, "%04x:%02x%s",
> +					rp->domain, rp->bus, config->csv_sep);
> +			}
> +		} else {
> +			if (ts) {
> +				sprintf(prefix, "%6lu.%09lu %04x:%02x ",
> +					(unsigned long)ts->tv_sec, ts->tv_nsec,
> +					rp->domain, rp->bus);
> +			} else {
> +				sprintf(prefix, "%04x:%02x ",
> +					rp->domain, rp->bus);
> +			}
> +		}
>  	}
>  }
>  
> -- 
> 2.50.1
> 
