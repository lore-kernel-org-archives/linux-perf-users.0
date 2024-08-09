Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41BE148823;
	Fri,  9 Aug 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234352; cv=none; b=gelkK7hhCi99UZlgSZ8VM+YIJkhXditEe1LIf4Ab3mL4SAg7rlusV1G4O2KgBxpq9cdIyUh5kMD9GRKDorBXcnlKM5U7WAaDyUtL1feZa6qf7oAb3UOzts4g7SZJNVvtMxYsbf7oieRjXtSFIv0ajf3CMPFeWpikoNgbJoCvd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234352; c=relaxed/simple;
	bh=lfYB0FW/wjA0IG7TtrciXw9cT3EbzR04+wRaHmnFmRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM1WQxIBQKDKTtDl+O1zYb81anaD+PPji8+gUdsy5zSJuLmBt6lFwlOMPiGn+bbDEqRohu/xDwo6I747BprzVpPkw/GjcQgTNl9qQbXRiIFuVq1nv9vh9ISUJRMHx/Ve6y5u5Zy/qikTsIYWx3U7F0PTGc2DyPlILYsoYmm8+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwNL9uhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwNL9uhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6D5C32782;
	Fri,  9 Aug 2024 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723234351;
	bh=lfYB0FW/wjA0IG7TtrciXw9cT3EbzR04+wRaHmnFmRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwNL9uhn4/LXxYIksEahdoIEXqHNdDDpIwz02ugA9WHS0XFYSKN+izcLRonlCfO0u
	 dFGhdMyrEyqfr4DzHNyniWySjux6t1RRaG8/uDGetSfQBpwOwGfsgrk5BcV2nd6mLj
	 DWdzPhlYxEGiadizimykNdwVZu5LjB64P9wAfB1L3Hgzw+u+8WAXWrTchqkqe845Bl
	 SJMR+PyJ1x/XogpyfgkPz7ZaozFy5XpfZmBvR87KhG8rguMsM0tw2SUaJALkwTo3VV
	 aDVv2fKDzGJzU3AX1x42SbNUZ1X6BCJKRl29BcbqwW7osDVtLFGbjX1C0QJlIZrOC7
	 3ZeX7RwGS8udQ==
Date: Fri, 9 Aug 2024 13:12:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched timehist: Skip print non-idle task samples
 when only show idle events
Message-ID: <ZrZ4LX20hN5w7MsJ@google.com>
References: <20240806075131.1382728-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806075131.1382728-1-yangjihong@bytedance.com>

Hello,

On Tue, Aug 06, 2024 at 03:51:31PM +0800, Yang Jihong wrote:
> when only show idle events, runtime stats of non-idle tasks is not updated,
> and the value is 0, there is no need to print non-idle samples.
> 
> Before:
> 
>   # perf sched timehist -I
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
>    2090450.763235 [0000]  migration/0[15]                     0.000      0.000      0.000
>    2090450.763268 [0001]  migration/1[21]                     0.000      0.000      0.000
>    2090450.763309 [0002]  migration/2[27]                     0.000      0.000      0.000
>    2090450.763343 [0003]  migration/3[33]                     0.000      0.000      0.000
>    2090450.763469 [0004]  migration/4[39]                     0.000      0.000      0.000
>    2090450.763501 [0005]  migration/5[45]                     0.000      0.000      0.000
>    2090450.763622 [0006]  migration/6[51]                     0.000      0.000      0.000
>    2090450.763660 [0007]  migration/7[57]                     0.000      0.000      0.000
>    2090450.763741 [0009]  migration/9[69]                     0.000      0.000      0.000
>    2090450.763862 [0010]  migration/10[75]                    0.000      0.000      0.000
>    2090450.763894 [0011]  migration/11[81]                    0.000      0.000      0.000
>    2090450.764021 [0012]  migration/12[87]                    0.000      0.000      0.000
>    2090450.764056 [0013]  migration/13[93]                    0.000      0.000      0.000
>    2090450.764135 [0014]  migration/14[99]                    0.000      0.000      0.000
>    2090450.764163 [0015]  migration/15[105]                   0.000      0.000      0.000
>    2090450.764292 [0016]  migration/16[111]                   0.000      0.000      0.000
>    2090450.764371 [0017]  migration/17[117]                   0.000      0.000      0.000
>    2090450.764422 [0018]  migration/18[123]                   0.000      0.000      0.000
>    2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
>    2090450.764505 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
>    2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
>    2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
>    2090450.764590 [0016]  s1-agent[7179/7162]                 0.000      0.000      0.000
>    2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
>    2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
>    2090450.764639 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
>    2090450.764668 [0017]  s1-agent[7180/7162]                 0.000      0.000      0.000
>    2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
>    2090450.764672 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
>    2090450.764683 [0000]  <idle>                              0.003      0.003      0.010
> 
> After:
> 
>   # perf sched timehist -I
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
>    2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
>    2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
>    2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
>    2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
>    2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
>    2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
>    2090450.764683 [0000]  <idle>                              0.003      0.003      0.010
>    2090450.764688 [0016]  <idle>                              0.019      0.019      0.097
>    2090450.764694 [0000]  <idle>                              0.001      0.001      0.009
>    2090450.764706 [0000]  <idle>                              0.001      0.001      0.010
>    2090450.764725 [0002]  <idle>                              0.000      0.000      1.415
>    2090450.764728 [0000]  <idle>                              0.002      0.002      0.019
>    2090450.764823 [0000]  <idle>                              0.003      0.003      0.091
>    2090450.764838 [0019]  <idle>                              0.000      0.000      0.154
>    2090450.764865 [0002]  <idle>                              0.109      0.109      0.029
>    2090450.764866 [0000]  <idle>                              0.012      0.012      0.030
>    2090450.764880 [0002]  <idle>                              0.013      0.013      0.001
>    2090450.764880 [0000]  <idle>                              0.002      0.002      0.011
>    2090450.764896 [0000]  <idle>                              0.001      0.001      0.013
>    2090450.764903 [0019]  <idle>                              0.063      0.063      0.002
>    2090450.764908 [0019]  <idle>                              0.003      0.003      0.001
> 
> Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/builtin-sched.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..04770c2ae008 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2729,8 +2729,14 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  		}
>  	}
>  
> -	if (!sched->summary_only)
> +	/*
> +	 * when only show idle events, only runtime stats of idle tasks
> +	 * need to update, and can skip non-idle tasks sample.
> +	 */
> +	if (!sched->summary_only &&
> +	    !(sched->idle_hist && thread__tid(thread) != 0)) {
>  		timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> +	}

I think we already have the same condition in the previous block, maybe
better to move this code into the block.  Or, we can change it to goto
out and reduce the indentation level of the block.

Thanks,
Namhyung

>  
>  out:
>  	if (sched->hist_time.start == 0 && t >= ptime->start)
> -- 
> 2.25.1
> 
