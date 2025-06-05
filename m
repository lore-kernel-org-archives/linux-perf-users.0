Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0256D17;
	Thu,  5 Jun 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749105606; cv=none; b=jTw0G7RrtYr9PFduuyAxhmDakBsXITx25mrM7sVLT/ZavxniswSbqIFV+mG3dFrxjHyoHGMWsHuaSYGJuLHZE5lzvpn8XbBX1zOjncFwTOADuZ/TZ+OI7Oxa0f3leIImKD/WOx7Wz4/mMVgUldrsTP61lE3KXkb6p69b1NNyCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749105606; c=relaxed/simple;
	bh=hm4ir1iJh/8wNf3RCcJDbD6E9SByD9vdEn922y5Hvj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHwTYOoIT8yks0JyVpb5133iQ2+gf7xLCNl01kSxYyH2rXzF9xFc+n6/QuaOvKJmMPrMFPSrjOaArhpZMXc5wBqDCzEwySRW0clLeoIislckW7AMC7ZjxbYelFS6VzWv6MY9PzDYBHiqhQQhzC4Zxk9KisQx3tlq+Y97amrvcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmtXKMGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmtXKMGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C172C4CEF0;
	Thu,  5 Jun 2025 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749105605;
	bh=hm4ir1iJh/8wNf3RCcJDbD6E9SByD9vdEn922y5Hvj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmtXKMGoXr50ominqCNQNwUwKGIpLkFEgYQW1S3b2op9CUqla4NBqxSApT7DHQ20t
	 g1ZexsbkaEiQOFFpk+mtuPtYAifpG0YMGSNM2kpbyhpSy83qZ3DkjAjFeINuN1wux/
	 ie2SixbkChSFFwdHFkzGCxLWeSS8S3V4Lm40/KmHMirsoVk4EG4/36O5Yd3uWNOCxk
	 3J5MkMmOIO3V+Qvfrzs5Sgygi81PFpq6LkuaUhsnA4zUfBg2Doky0bWnUDLPUZx1l5
	 h8fzTmpi9lWIgDlwbR+1VgqvRGmhBvsFxhq50BmFTBA2r/O+ElV3LVbd6SmdeM1FrM
	 mMdL8dOiRlAzA==
Date: Thu, 5 Jun 2025 08:39:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Leo Yan <leo.yan@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
Message-ID: <aEE7ug56bPS_ZJUQ@gmail.com>
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604171554.3909897-1-kan.liang@linux.intel.com>


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
> below perf command.
>   perf record -a -e cpu-clock -- sleep 2
> 
> The issue is introduced by the generic throttle patch set, which
> unconditionally invoke the event_stop() when throttle is triggered.
> 
> The cpu-clock and task-clock are two special SW events, which rely on
> the hrtimer. The throttle is invoked in the hrtimer handler. The
> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
> be used to stop the timer.
> 
> There may be two ways to fix it.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
>   perf_event_throttle() if the flag is detected.
>   It has been implemented in the
>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>   The new flag was thought to be an overkill for the issue.
> - Add a check in the event_stop. Return immediately if the throttle is
>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>   method to stop the timer.
> 
> The latter is implemented here.
> 
> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
> the order the same as perf_event_unthrottle(). Except the patch, no one
> checks the hw.interrupts in the stop(). There is no impact from the
> order change.
> 
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Any idea which commit introduced this bug?

Was it:

  9734e25fbf5a perf: Fix the throttle logic for a group
 
plus the followup driver updates?

Thanks,

	Ingo
