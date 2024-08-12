Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C586188CB2;
	Mon, 12 Aug 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489421; cv=none; b=NM24BfnGc1xM31r8pDomduoeByePax8E4Q0ySXd2dfIFoRLeqedf3NF5uONT4/LPIXO/38dm/shtYo7gsmoL+SItSQeqv1cTwoqVf9U1Y8kanvhGJa37GYS4dblGlIJMqC2QkNwiUrPhYKMztXGTnCm+WWQrTnu4FmnG2M9whIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489421; c=relaxed/simple;
	bh=OlMd1C07NZUosXrHKp91DkV0g4a/oiJjSUGRUzv0+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANPdN7FFMX2/jEm3jpYSBFkh+NaDF/xVgVoj0KuZ0H5ecFJPI+o9XPHYlTIYQKrRRJ4DFkwCHfKmxxqNspW5nv1w+tGxGIhanX6QFSaimYkoQ5m9iyNMK3LwicMXfqUCUPTM5KVKWd+1/eMwW7ZlyZF5qq/RY1jCkbuCpF9eRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ0XqC84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ0XqC84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBB3C32782;
	Mon, 12 Aug 2024 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723489421;
	bh=OlMd1C07NZUosXrHKp91DkV0g4a/oiJjSUGRUzv0+FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZ0XqC84U7uxoWOapeBakoPKfkU+0wxqJAL9IiuPYCRXViE4LQtZGBwwnw59my5iD
	 p83f8SLNwyu4l8QhiM1rCe2ZvIsftbA/h4QSJDAQIEIIEyixQvL8XW/K3EV4fqjSup
	 193mbpKk2LRwG99znSqzsmPUpaPkEWOVzeT5hrXTw83uBJ9Fxeqm6FJ3T40xq94aM1
	 doKoS2gJFUHq5AyUYkJI8bm4lNhrjJPkJAelMFdbT+DToTZu0K7FRSvYielcxjGLPL
	 3lmVMlI74yPFXxjnkDi2UoyW7qLR8tRUmezai7hlvJPC74K3P1qR3jWysMe1lS1e/6
	 AAVJ9e8AFsUdw==
Date: Mon, 12 Aug 2024 12:03:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf sched timehist: Skip print non-idle task
 samples when only show idle events
Message-ID: <ZrpcioDOG42dPAll@google.com>
References: <20240812132606.3126490-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812132606.3126490-1-yangjihong@bytedance.com>

On Mon, Aug 12, 2024 at 09:26:05PM +0800, Yang Jihong wrote:
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

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-sched.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..177634df1ba5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2727,10 +2727,10 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  
>  			itr->last_thread = NULL;
>  		}
> -	}
>  
> -	if (!sched->summary_only)
> -		timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> +		if (!sched->summary_only)
> +			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> +	}
>  
>  out:
>  	if (sched->hist_time.start == 0 && t >= ptime->start)
> -- 
> 2.25.1
> 
