Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35718733D;
	Tue,  7 May 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113259; cv=none; b=DxZ7vnaqAUMU12/jXW8jIOSbYP4DBAevZevLOmG0nhQms+l3lCeV+hiSWIGQ1q1BZVf6xI8ru3g8YJn5HE6xnPV2viAkqSNC9UhXKJ5oI2IosX+d4TbmleexJFUODKH8lgIpZyJWbfUjzc0UticQkboM/3GbhgvNneB7yQMKp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113259; c=relaxed/simple;
	bh=qgkgWJ6hcc+kLK5jJ2rjoDUnCXJexR2EWKimTvT98Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADa8Tlg8usKCk+Ldn4fo4W7yg0hZ+XjcvckELxtxigP4A8U5bZNoaLOeyg9AMYTCJfEh+p8QndfRBN7x9LzaWRjCk+zJGwkrX5WV1eLCskDKTHvJH5A+ieMxQLltw+PvOLJH180qM7fu85aaN+122tsE6G3Wm/K0VLN5McRy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgrRuc0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgrRuc0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BD5C2BBFC;
	Tue,  7 May 2024 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113259;
	bh=qgkgWJ6hcc+kLK5jJ2rjoDUnCXJexR2EWKimTvT98Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgrRuc0vDNKHe1SLI2TEjr6N1r1ndxQH6wjicKasHQzQT6m3T1CPhuTRVW7dgRddM
	 tMJ5O0A9/HFOSPuCo5nD1OEDitxNen0+WvpjTEHGux/GYjc79Ey61nQWCtzvtVsEXe
	 d4kFgtMLoxbk8PyLoU4Ty/M0zDHHoD+EUSMkX8h+UhSlA5OU/4v269RsvA9wRlaJnP
	 tWYkxoCaBFOCwG7IlnNacHUzKhSFYoFmtFhDfwBU1mn1lC2nukdwUUYWTTF7ycGnX8
	 QAes6I53KVDdIitBmvqJDsJaa8C70zdWUUYgVJxlce8LHIQSkoPM0+BlzYErzlYpX1
	 A6kfCCBZUOF2w==
Date: Tue, 7 May 2024 17:20:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Clark <james.clark@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>,
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack
 memory
Message-ID: <ZjqNKPgWR7mBFaV4@x1>
References: <20240507183545.1236093-1-irogers@google.com>
 <20240507183545.1236093-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507183545.1236093-2-irogers@google.com>

On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> ui_browser__show is capturing the input title that is stack allocated
> memory in hist_browser__run. Avoid a use after return by strdup-ing
> the string.

But everything happens in that context, i.e. hist_brower__run() will
call ui_browser__ methods and then exit.

We end up having browser->title pointing to returned stack memory
(invalid) but there will be no references to it, no?

If we return to hist_browser__run() we then call ui_browser__show
passing a new title, for "live" stack memory, rinse repeat. Or have you
noticed an actual use-after-"free"?

- Arnaldo
 
> Fixes: 05e8b0804ec4 ("perf ui browser: Stop using 'self'")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/ui/browser.c | 4 +++-
>  tools/perf/ui/browser.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index 603d11283cbd..c4cdf2ea69b7 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -287,7 +287,8 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
>  	mutex_lock(&ui__lock);
>  	__ui_browser__show_title(browser, title);
>  
> -	browser->title = title;
> +	free(browser->title);
> +	browser->title = strdup(title);
>  	zfree(&browser->helpline);
>  
>  	va_start(ap, helpline);
> @@ -304,6 +305,7 @@ void ui_browser__hide(struct ui_browser *browser)
>  	mutex_lock(&ui__lock);
>  	ui_helpline__pop();
>  	zfree(&browser->helpline);
> +	zfree(&browser->title);
>  	mutex_unlock(&ui__lock);
>  }
>  
> diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
> index 510ce4554050..6e98d5f8f71c 100644
> --- a/tools/perf/ui/browser.h
> +++ b/tools/perf/ui/browser.h
> @@ -21,7 +21,7 @@ struct ui_browser {
>  	u8	      extra_title_lines;
>  	int	      current_color;
>  	void	      *priv;
> -	const char    *title;
> +	char	      *title;
>  	char	      *helpline;
>  	const char    *no_samples_msg;
>  	void 	      (*refresh_dimensions)(struct ui_browser *browser);
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
