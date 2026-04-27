Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563736655D
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269400; cv=none; b=rIelIqPqRDuJh5QGSnMkXJZ1d6y9OsW8o2kOAzO3YiAHO0DCuZj0QjDDEEqaSXG+eumjYAKpNejOR+g5PvPd2ufURjDEp13ol7kpgshtJao15q+gYxLf3pnWSsIeYop24nSuv5ql4+w3YJhVtWPJ5jg2nttBSp2UXu0wsE4kLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269400; c=relaxed/simple;
	bh=WP2+G4hRWfzaVFm8oC7HX5jbTu90noitIkr3w7x2K1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnhtmm8xJbViyEDmvpkIrRTgrIRYm3C7Vfu0pY/dp9rthjpW9GwAxBb7M5bWwfnuHqZ/Ac4yTS7Q7/PVhOn4HPk9ZGF+W9bvdbCzYhoWq97ZO7PRiSjKw4XYGmf0mV18Nmvq+Rw62uvUeNmL/OZ+0oYmT8wD/SONfEpBu1Dmcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdqO5rle; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdqO5rle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652B0C19425;
	Mon, 27 Apr 2026 05:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269399;
	bh=WP2+G4hRWfzaVFm8oC7HX5jbTu90noitIkr3w7x2K1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdqO5rleukqvrkxBFs/0lYE1PM2xj6ar24SiocdCMM90kJhRpkmkGIxMJflP9nco3
	 xHX4wL/JYNrRgfQILqc7CoSCqMTJRyquSDwIAT+XiGVtOPigNnxL3FX8J5SfxF+Ol4
	 8SxjETTAwqgEDgC5GAEzpDS3zLIFSPqoClpR3iswl6FvshYzm6tXxodKFI0Zjas5DD
	 2SUaFJW9fyv55hu/jNgQywKYQJ4FDOGGfT/AxRZNanKHc4P+Z4OehR9LetY86Xz52X
	 3xe8J6pxCdhTCcjqIbBcGb0VlRPHUTdujAit20cvDiiOhSEYKDZu9dXOFS8bTECPqM
	 5x1xSr5rNvV7g==
Date: Sun, 26 Apr 2026 22:56:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
Message-ID: <ae76k1BvfgcYI18K@google.com>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260426093930.47809-1-atrajeev@linux.ibm.com>

On Sun, Apr 26, 2026 at 03:09:30PM +0530, Athira Rajeev wrote:
> In redhat perftool testsuite, observed fail for this test:
>     -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)
> 
> This led to analysis of "perf sched timehist" summary options.
> 
>   # perf sched record -a -o ./perf.data -- sleep 0.1
>    This will record using perf sched record
> 
> perf sched timeliest has two options "-s" and "-S"
>   # perf sched -i ./perf.data timehist -S
>  -S : Captures summary also at the end
> 
>   # perf sched -i ./perf.data timehist -s
>  -s : Captures only summary
> 
> The test saves -s result which has only summary and compares with
> summary which comes at the end from -S . Since there is a difference
> in these two, test fails.
> 
> Checking the behaviour change in -S and -s results, difference is:
> 
>                   rcu_sched[16]       2          4        0.013      0.001       0.003       0.006   33.23       0
>                migration/11[73]       2          1        0.006      0.006       0.006       0.006    0.00       0
>                 migration/3[33]       2          1        0.006      0.006       0.006       0.006    0.00       0
>  -               :216753[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
>  +                 sleep[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
>                 migration/8[58]       2          1        0.005      0.005       0.005       0.005    0.00       0
>             NetworkManager[811]       1          2        0.089      0.028       0.044       0.060   36.06       0
>                migration/13[83]       2          1        0.005      0.005       0.005       0.005    0.00       0
> 
> Here 216753 is pid for sleep which is a zombie process. This is
> happening in latest kernel due to an update in "-S" result.
> In -S, the process name appears in the results "sleep[216753]",
> where as in the -s, only pid is present in the summary result
> ":216753[216753]".
> 
> After commit 39f473f6d0b2 ("perf sched timehist: decode process names
> of processes in zombie state")
> for -S option, if process name is using pid, it uses different way to
> set it. So that we get the process name and not just Pid.
> 
> This change went in only for timehist_print_sample() function.
> Add this improvement in generic place so that even -s option (which
> captures summary) also will have meaningful information.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-sched.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..ee1b89a6af50 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2197,11 +2197,6 @@ static void timehist_print_sample(struct perf_sched *sched,
>  		printf(" ");
>  	}
>  
> -	if (!thread__comm_set(thread)) {
> -                const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
> -                thread__set_comm(thread, prev_comm, sample->time);
> -        }
> -
>  	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
>  
>  	if (sched->show_prio)
> @@ -2890,6 +2885,15 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  			itr->last_thread = NULL;
>  		}
>  
> +		/*
> +		 * If the process name is not set for the thread, use "prev_comm"
> +		 * to set it. Otherwise the sched summary will have just pid information
> +		 */
> +		if (!thread__comm_set(thread)) {
> +			const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
> +			thread__set_comm(thread, prev_comm, sample->time);
> +		}
> +
>  		if (!sched->summary_only)
>  			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
>  	}
> -- 
> 2.47.3
> 
