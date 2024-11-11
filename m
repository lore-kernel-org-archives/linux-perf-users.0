Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7C36B;
	Mon, 11 Nov 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731300429; cv=none; b=p8m3BCrmtNn2WiGyKeHgRzwihwbdeeGGWItN095zYdds7tFN7sd4WIi/f1r9XshCmEjw1RVoInMhPZD1Wjw5WqVFTPMtciMZELWIA/CnjNwdHo8ivX5nWtTt1KIcjvLP/dwXw8/zeuV7I1YHfuo6xWJvmwLkj9yiSQFGrJfhBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731300429; c=relaxed/simple;
	bh=EhIIMS56ksJvmkC2J5FJfRvQpQBY4ZwHz0e0AMGl1q0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qTmEY+4R4T+ZYMORFc+4g6zMhXb4IYy0nmsgzJe2Yl7ZT/Rh8g3lEoBTAFF57Z+HhUKH0AV6mEdZVpio10mhBfPubEdmWmMG/CiRjPgeRGHWBb4YqyDQwI5c2v4JIt0+ofHXZPcrYubu4Io44OPtGeZ1nkN0IYFSpiK1scVU9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtbwppxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtbwppxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44410C4CED0;
	Mon, 11 Nov 2024 04:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731300429;
	bh=EhIIMS56ksJvmkC2J5FJfRvQpQBY4ZwHz0e0AMGl1q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qtbwppxqaHaZUogmTwiuRCgKzo4hz7Cw0J+FQeNHFH/IpFOwF80DTbe1dMf/9LrGO
	 CMq5YiWTRszfLgfUj472FVRzz9q/Ylvj8H0yVzRcnQ1VQ5g41pdO383bdvuzjaM6iE
	 rCs9jvzRy9xeJsay4SuffpNi+kvSDQ3kqrijsU3a29yTY5jv2C2TWilWUp/4qN1rz8
	 ivoxKEJZdlCVZhdxZKkneFI3uiUqzA6PbLAKxMqgQixzfeeKTmssv3xU9IzXkQb3wU
	 pWVdYRtu7dn0uKg/IBw1fIAcA5A2/MkNx8xPJn7ORMETEVfoZ36JNf+HOvjT8L2Xi6
	 6snx8zQkD+0rA==
Date: Mon, 11 Nov 2024 13:47:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <namhyung@kernel.org>, <mark.rutland@arm.com>,
 <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
 <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <dima@secretsauce.net>,
 <aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf probe: Reset old content before processing the
 next event string
Message-Id: <20241111134705.021f73408c0aff41918ab2a5@kernel.org>
In-Reply-To: <20241108181909.3515716-1-lihuafei1@huawei.com>
References: <20241108181909.3515716-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Nov 2024 02:19:08 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> I added two probe events:
> 
>   # perf probe -f -a schedule+8
>   Added new event:
>     probe:schedule       (on schedule+8)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:schedule -aR sleep 1
> 
>   # perf probe -f -a schedule+20
>   Added new event:
>     probe:schedule_1     (on schedule+20)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:schedule_1 -aR sleep 1
> 
> However, 'perf probe -l' shows the same offset:
> 
>   # perf probe -l
>     probe:schedule       (on schedule+8@kernel/sched/core.c)
>     probe:schedule_1     (on schedule+8@kernel/sched/core.c)
> 
> __show_perf_probe_events() does not clean up the 'pev' content when
> parsing the rawlist. If the 'pev->offset' is not set while processing
> the next probe event string, the offset value of the previous event will
> be used.  After adding debug information, it was found that indeed there
> was line number information when processing 'probe:schedule_1', so the
> offset was not set and used the offset from 'probe:schedule'.
> 
> To fix this, in the loop that parses the rawlist, reset the contents of
> 'tev' and 'pev' to ensure it does not affect the next parsing.
> 
> After the modification,  'perf probe -l' shows the following:
> 
>   # perf probe -l
>     probe:schedule       (on schedule+8@kernel/sched/core.c)
>     probe:schedule_1     (on schedule:-6751@kernel/sched/core.c)
> 
> Note that 'probe:schedule_1' is displayed with line number, but the line
> number seem to be incorrect. This issue is independent of the problem
> fixed by the current patch and will be addressed in the next patch.
> 

Good catch! But we should do the cleanup in clear_perf_probe_event()
and clear_probe_trace_event().

> Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")

What we need is to revert this change for above 2 functions, because
without that, it "clear"s the structure correctly. Current code
releases allocated fields, but not clear all fields. This can lead
another bug.

Thank you,

> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/probe-event.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a17c9b8a7a79..ec0b11f8d881 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2695,6 +2695,8 @@ static int __show_perf_probe_events(int fd, bool is_kprobe,
>  next:
>  		clear_perf_probe_event(&pev);
>  		clear_probe_trace_event(&tev);
> +		memset(&tev, 0, sizeof(tev));
> +		memset(&pev, 0, sizeof(pev));
>  		if (ret < 0)
>  			break;
>  	}
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
