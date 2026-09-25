Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF45370D71;
	Fri, 25 Sep 2026 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790306904; cv=none; b=eCzSwjJPHHDfz+kO1eRh6s7lEeneun+e0eej1vsApQCI+bYgsBWhKqR1Xw7O1tzIGZMk1qK38q39rpdt37JRxngzxFuWos5p686TQH5txVU/9TRCjaLVQQW8yFhXvRNs9mWxv6xx/nQlSKn/Yga1JNglJndooRizfZuGBQp9wqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790306904; c=relaxed/simple;
	bh=cmJCh8+m8ClXR+bMiupMUm/aRczJDF8W6Y3Lir9kGlM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f7T9NTkjG4j63nFcGVhJy3vnt5soazntxhk2nzp1FUlApeCa6yKo3i5aEa0gUg8ZcKb8aNJ8oX9+kIpiEW9FSFlMDtCkzICj8xgMbf3V9qM5GRyGrV+9QyzFOWmTOnjFjrYsaszNbo7U6S+b7BwvmLRSDWfPw3p6nqkTOmozBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9ZiKJTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9ZiKJTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011661F000FF;
	Fri, 25 Sep 2026 03:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790306899;
	bh=9rAcCuEFXM9HtGMO8q0ClCEQchh2fl8Mu2KdCg7j1nQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e9ZiKJTOf+wNWPvxlwyK4fF2T3NYRfYAr5/5HSqrEyNdTOKvvTkKLh5OlJPB7ssiQ
	 X510cBC5f7wJrO9Xayb9kEYmziArOG2mrzassuIAg4S0k4RoFh6OJW078u1N9tBfdJ
	 SXjVYCEL/1JmxPPQMpTBT7v98Q4zdGAQ9eRJpzQCCYF4n3zq0511tpgVTz2Oywek2y
	 TnQjFWYFte9/mhvvJFoQunahsNqJhNceeKcmcfSGuTNiTcXLWLDhoxDPAzEj2RpLc8
	 MAv6qxBO5CvBzNI+TQbt6PjLrpmCsSAIhZLJ4hB2YQyKVbhOUDVgubPujeVe3jQeNG
	 0Fg+ep8Bi+EOQ==
Date: Fri, 25 Sep 2026 12:28:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v17 11/13] selftests: tracing: Add wprobe trigger
 testcases
Message-Id: <20260925122815.b7125301dbd466d408ca7896@kernel.org>
In-Reply-To: <20260922044153.ADE881F00893@smtp.kernel.org>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005121474.388919.14749093387340836147.stgit@devnote2>
	<20260922044153.ADE881F00893@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 04:41:53 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] kselftest: trace buffer not cleared before verifying offline wprobe triggers
> - [Low] kselftest: missing set_wprobe dependency check in requires lines
> --
> 
> commit 0d531760cdf15ae449a5bc0545ea39a43134b990
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> selftests: tracing: Add wprobe trigger testcases
> 
> This commit adds several test scripts for wprobe triggers in the ftrace
> selftests. The test scripts verify setting and clearing wprobe triggers,
> CPU hotplug behavior for wprobes, and syntax error logging.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-hotplug.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-hotplug.tc
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-hotplug.tc
> > @@ -0,0 +1,150 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test wprobe trigger across cpu hotplug
> > +# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README events/sched/sched_process_fork/trigger "[(structname[,field])]<argname>[->field[->field|.field...]]":README
> 
> [Severity: Low]
> Should we check for set_wprobe in the README in this requires line? If a kernel
> has CONFIG_WPROBE_EVENTS=y but CONFIG_WPROBE_TRIGGERS=n, it seems this test
> will execute and fail unexpectedly with "Failed to set set_wprobe trigger"
> instead of being gracefully skipped as UNRESOLVED.

Ah, good catch! OK, let me add that in the requires line.

> 
> [ ... ]
> 
> > +:;: "Take target CPU offline" ;:
> > +echo 0 > $cpu/online
> > +sleep 1
> > +
> > +# Wait for sample_timer_cb to fire and set_wprobe trigger to activate while CPU is offline
> > +sleep 2
> > +
> > +:;: "Check set_wprobe trigger activated the watchpoint" ;:
> > +if ! grep -q watch trace; then
> > +  fail "Failed to trigger watchpoint while CPU is offline"
> > +fi
> 
> [Severity: Low]
> Does this grep falsely match events generated while the CPU was still online?
> Because the target fprobe (sample_timer_cb) fires continuously, the trace
> buffer could log a watch event before the offlining process actually completes.
> Should we add a clear_trace call either before or right after taking the CPU
> offline?

OK, let me add it.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
