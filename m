Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE1558A5;
	Fri, 16 Aug 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827688; cv=none; b=tozJQQF1c/f6uJ7zvoowpw+YGNuYj0Nzl7CTEhuQXObb2dRthPxc6i8BDXG9Taozs4gpn8vqPocb70Yd0FY1Zkbc5qHQLDUh7idPrgxIUJiAQjij03iCIKPe1+cmI8pd/u6DyqIrk9jARfn+9D1i4eB20koiE0QvH1IU+KuVUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827688; c=relaxed/simple;
	bh=0vUEPje41/WDviVBNGdvXYZXEw5VqyE6qGf9NqE85Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXEF9YjPzzhu9MpOG34GUenwp9l5Aet1NH6eZkUFgRcvcAd6N4EROGkPV4QpqwRnnDOu7yau4DKESW51H3sbDNrtGZeHFOCRb22ZM3QC0gDUlxGHHtrDYpSf2eFmJMexXgOc6xgIdPWtSM8fr0F3OVsE4YoGhr7KmfZ4RBTSHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0My2Uyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0My2Uyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6850C32782;
	Fri, 16 Aug 2024 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827688;
	bh=0vUEPje41/WDviVBNGdvXYZXEw5VqyE6qGf9NqE85Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0My2Uyq4KbfOzoXRlE/UO1F5zsEqI9tWACHPzezWPWLo8DWfl7RUn41s4YyV3B+X
	 DaFV57KBleN6hdMgtbU5w8YG157xlTrBxAPEa7ck0B930av3Aoxu8cLI/oiAitOCNI
	 MmJucZODB20SmvpJKU1WHKNGwUk7D74RHC/oj4OB+1OsUa/hgOHhzEGsT0RkLfP96x
	 R128pMzSTa1i6a5SlyJF8C5e5kDxTocUMx4GZE/m5zcBQcOQHk5XdrJjDQaA+HxrW9
	 YDUxvJbTDyacWpDEwNrrSc0p12aIF26C0HelXzJ86qCwI6WJs50lqYjpBO3cNydXXz
	 xBMqmT4ovDayQ==
Date: Fri, 16 Aug 2024 10:01:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched timehist: Fix missing free of session in
 perf_sched__timehist()
Message-ID: <Zr-F5gFbV1zSbO2M@google.com>
References: <20240806023533.1316348-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806023533.1316348-1-yangjihong@bytedance.com>

On Tue, Aug 06, 2024 at 10:35:33AM +0800, Yang Jihong wrote:
> When perf_time__parse_str() fails in perf_sched__timehist(),
> need to free session that was previously created, fix it.
> 
> Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..928b9041535d 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3121,7 +3121,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  
>  	if (perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
>  		pr_err("Invalid time string\n");
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>  	}
>  
>  	if (timehist_check_attr(sched, evlist) != 0)
> -- 
> 2.25.1
> 
