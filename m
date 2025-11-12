Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAE311C35;
	Wed, 12 Nov 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970244; cv=none; b=Nv0SvhAJ0WwLgw8hzW5JTc+1zAINpOZ5rvjPZXPWXi7Xr8Wb96Q/q7NECtkifapXL/+UTQTayIYK3Bi310ItL3p5Rmis5vo0KF0qmllr5oTRbwbm6wT5ldsyC1rH64oehk2xud/YjKPwjQA5QZcCljBs4c+GWkrajJYs2bnU4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970244; c=relaxed/simple;
	bh=o1di7OuEst4aEZFZyN3PTmmE+QLUGKEIgtoF4458n9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcNGJLoxZyfvyHvqNBA2U1endzHVlQE5M4ska8dFplndsn80dB0K31MzieZPArFKTffbLY0yLwn4MaLWmLc3q6zsaRxXz4rl97rlDvBQIPXLtRqwi80g3osWsrRDuDfqT/mjr7HZsuwSEYuv+wu3YcEoD49b39KN5X5yb0jd50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcTLMq5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcTLMq5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4580C16AAE;
	Wed, 12 Nov 2025 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970243;
	bh=o1di7OuEst4aEZFZyN3PTmmE+QLUGKEIgtoF4458n9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcTLMq5XPKJywdyizwCrAV4/FNhS3SrNIe+ztycE5p5qWrdjHxLJlBpFhxtk0M7Uh
	 SajUcako1QYD/4V6hoo9kDzH95ckDmXHpbV2cSnLV24swYeadcs7jWXQID2MvhFIFY
	 5yzGZPTUb4E7DTraXh5LTzgl5VFxGPjLVYVVDdeS88G6170x1FNhfVqr1YD/0lFb7N
	 1gpQsqtLihvfXPxNUommXOyY6rj4p/VcgjFxkhdIPRx8JqPWj6I3N7+6zOvjVAJ4r8
	 p6WJKWg4hCjqBiXbk6DYk9+kgn3m6ncrRV2WtZxFmdgpydLnAngODrJ6Z0Po4QvSxW
	 g98n+lVGvUdSw==
Date: Wed, 12 Nov 2025 09:57:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Align metric output without events
Message-ID: <aRTKf6iw0sRuC0ww@google.com>
References: <20251106072834.1750880-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106072834.1750880-1-namhyung@kernel.org>

On Wed, Nov 05, 2025 at 11:28:34PM -0800, Namhyung Kim wrote:
> One of my concern in the perf stat output was the alignment in the
> metrics and shadow stats.  I think it missed to calculate the basic
> output length using COUNTS_LEN and EVNAME_LEN but missed to add the
> unit length like "msec" and surround 2 spaces.  I'm not sure why it's
> not printed below though.
> 
> But anyway, now it shows correctly aligned metric output.
> 
>   $ perf stat true
> 
>    Performance counter stats for 'true':
> 
>              859,772      task-clock                       #    0.395 CPUs utilized
>                    0      context-switches                 #    0.000 /sec
>                    0      cpu-migrations                   #    0.000 /sec
>                   56      page-faults                      #   65.134 K/sec
>            1,075,022      instructions                     #    0.86  insn per cycle
>            1,255,911      cycles                           #    1.461 GHz
>              220,573      branches                         #  256.548 M/sec
>                7,381      branch-misses                    #    3.35% of all branches
>                           TopdownL1                        #     19.2 %  tma_retiring
>                                                            #     28.6 %  tma_backend_bound
>                                                            #      9.5 %  tma_bad_speculation
>                                                            #     42.6 %  tma_frontend_bound
> 
>          0.002174871 seconds time elapsed                  ^
>                                                            |
>          0.002154000 seconds user                          |
>          0.000000000 seconds sys                          here
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

