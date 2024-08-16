Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EB6F2F8;
	Fri, 16 Aug 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827930; cv=none; b=tnQUM+eObWH4XXBTPGmV6y2rG5lv4hFueoU2gs82RtLF6+kdhREk6KXbr42I8Qzoux84VZ/4vv12bR5CuuXK6gFbonmVZJEhbrp9GBQEUfddK4eEajC3lWouOMIautuYsnfKCs7+Bn6/hYPci4y5Q0Tikfs516np1nvmH9SSb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827930; c=relaxed/simple;
	bh=V54iIFmbnKqn3uHqs1C4I5uZ8x2fSzpyzRaYB5/dss4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2t4qukW13YTqh0y/mPYrFlLaizYkGy9fSC78J+1UFWE6JSuy/HyPz7iG7PQvX+NW7jdU32z6zHZBHGt4roCxhxhzUUT7D/jiJHJIYkgWZJSSOBREFhZzwC1SDCg7NhCwuNUCQoTezddbwb2HajfzM/BIml4bhgbseU1GHpHoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4G4Xsrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4G4Xsrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB1AC32782;
	Fri, 16 Aug 2024 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827929;
	bh=V54iIFmbnKqn3uHqs1C4I5uZ8x2fSzpyzRaYB5/dss4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4G4Xsrh1IdESY3gYtocw1Z6JdbvHckeurZlU0fTjuF3mFtk8TToB9jIghWAzLVPa
	 keremIZwrOL9SjdoJm7zZs5xhJ8MorQCknsfKbD9u0wxFCHVl7zvket7JOZ9Q/ACsq
	 75a2BznfZtH4VyRfJI8y13FwAbxWHQdQPqTPwwvFXosUkFV7HIxJ5qglTamLu7UBKE
	 yXLxRonEYeIZuY4gahHhwI4/dgfEiiFcNH1hd7HozW5axpP5GpoCjH8xViwhrCD5U5
	 rsBn2WbSAtEjJZ2UU+ojWSD2VnRKnh0R17poUM5M/pYCvlk7Wlm0DSDmhshbijbHSH
	 Ps2FRDm9F/GJg==
Date: Fri, 16 Aug 2024 10:05:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched timehist: Fixed timestamp error when unable
 to confirm event sched_in time
Message-ID: <Zr-G2IjXp_W2CkHi@google.com>
References: <20240806034357.1340216-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806034357.1340216-1-yangjihong@bytedance.com>

On Tue, Aug 06, 2024 at 11:43:57AM +0800, Yang Jihong wrote:
> If sched_in event for current task is not recorded, sched_in timestamp
> will be set to end_time of time window interest, causing an error in
> timestamp show. In this case, we choose to ignore this event.
> 
> Test scenario:
>   perf[1229608] does not record the first sched_in event, run time and sch delay are both 0
> 
>   # perf sched timehist
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
>    2090450.763231 [0000]  perf[1229608]                       0.000      0.000      0.000
>    2090450.763235 [0000]  migration/0[15]                     0.000      0.001      0.003
>    2090450.763263 [0001]  perf[1229608]                       0.000      0.000      0.000
>    2090450.763268 [0001]  migration/1[21]                     0.000      0.001      0.004
>    2090450.763302 [0002]  perf[1229608]                       0.000      0.000      0.000
>    2090450.763309 [0002]  migration/2[27]                     0.000      0.001      0.007
>    2090450.763338 [0003]  perf[1229608]                       0.000      0.000      0.000
>    2090450.763343 [0003]  migration/3[33]                     0.000      0.001      0.004
> 
> Before:
>   arbitrarily specify a time window of interest, timestamp will be set to an incorrect value
> 
>   # perf sched timehist --time 100,200
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
>        200.000000 [0000]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0001]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0002]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0003]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0004]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0005]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0006]  perf[1229608]                       0.000      0.000      0.000
>        200.000000 [0007]  perf[1229608]                       0.000      0.000      0.000
> 
>  After:
> 
>   # perf sched timehist --time 100,200
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
> 
> Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/builtin-sched.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..92b1113b22ad 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2683,9 +2683,12 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  	 * - previous sched event is out of window - we are done
>  	 * - sample time is beyond window user cares about - reset it
>  	 *   to close out stats for time window interest
> +	 * - If tprev is 0, that is, sched_in event for current task is
> +	 *   not recorded, cannot determine whether sched_in event is
> +	 *   within time window interest - ignore it
>  	 */
>  	if (ptime->end) {
> -		if (tprev > ptime->end)
> +		if (!tprev || (tprev && tprev > ptime->end))

This can be 'if (!tprev || tprev > ptime->end)'

Thanks,
Namhyung


>  			goto out;
>  
>  		if (t > ptime->end)
> -- 
> 2.25.1
> 
