Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F26FDA8;
	Thu, 23 Oct 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256245; cv=none; b=A1/ufTmPjUQ98JzCLjH+7JGjovnN2s8Qpl2ghfkWlwOx/LUv07CnQMJRD5FSwbF7+vQtO5z4XmYNt4MD8KEgJGqMg+xit2JormBtoLOzjL7Vh1YEqN+Iug7MbFNos21nG21i9BuwquSccRruo101jPl8IS5nOeqLGEM/qKYyMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256245; c=relaxed/simple;
	bh=vdDtr5ZpU96YQs1o92cgvoGfM6tYwvsvWlDHE+63wII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUu3kJQCx+NnmQW3mCHGuRFyl6FqOxgPKldxfKM4V1tdUHGlkr/kG8fJFaqxuy3PFnuoHHYgS4/eS7hlUzvk56LXkC8BtayWeFxdUN8EK7lIytYBkYr4OqG7uV/DieZQ95Rpw3Gang7ZXXra719KpYXmJyycnDuNSuafrUJ55vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mthlZBXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mthlZBXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA20DC4CEE7;
	Thu, 23 Oct 2025 21:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761256245;
	bh=vdDtr5ZpU96YQs1o92cgvoGfM6tYwvsvWlDHE+63wII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mthlZBXKS1lwJ9lGuHcVyDYb/bdV8mHdBPwPMhnC2jwLf2Sn5of72CraL9etYBxsY
	 gM3mEZszEhZasDtc76TNAhQ39PHmd0jW6dZLU5DfNaXEuk+J88bgHZgIfIEKTAa0hj
	 c99M/YSs0epAfTJNin1AjJo/LXpbnRt4KLl+xBSAkB3T3SuTCzMqhoHyFqjAd8oiKd
	 HMq10nd0WUPr+C2SbP3tnRys5ZA4MT4whHzaRCwPgmAka0J0jcRQH05G/MxUHRiz1i
	 UB2jYObG9Yg5MVwmLyHlmFh0RvLoIPkJyrJ5jotY5DbqMC3nCYD5wE26rgwuqCWRJH
	 6q+An+nYnPBrQ==
Date: Thu, 23 Oct 2025 14:50:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH] perf hwmon_pmu: Fix uninitialized variable warning
Message-ID: <aPqjMzxyYeKCp91K@google.com>
References: <20251022103839.19550-1-msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022103839.19550-1-msuchanek@suse.de>

Hello,

On Wed, Oct 22, 2025 at 12:38:35PM +0200, Michal Suchanek wrote:
> The line_len is only set on success. Check the return value instead.

Can you please share the actual warning messages from the compiler?

Thanks,
Namhyung

> 
> Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/perf/util/hwmon_pmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index 416dfea9ffff..5c27256a220a 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -742,8 +742,7 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
>  			continue;
>  		}
>  		io__init(&io, name_fd, buf2, sizeof(buf2));
> -		io__getline(&io, &line, &line_len);
> -		if (line_len > 0 && line[line_len - 1] == '\n')
> +		if (io__getline(&io, &line, &line_len) > 0 && line[line_len - 1] == '\n')
>  			line[line_len - 1] = '\0';
>  		hwmon_pmu__new(pmus, buf, class_hwmon_ent->d_name, line);
>  		close(name_fd);
> -- 
> 2.51.0
> 
