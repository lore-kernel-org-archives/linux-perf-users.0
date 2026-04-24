Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946A288AD
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052378; cv=none; b=daUDtJhb9sUjJ95h0k4+r3xQgu/A2iCbHkwaOTSRVlbPpttk3X+oMMJUVmoO86DwF382NrmYFx17hhLFOk8lHE7BLdoUCqBpJILDEH83tWpA64YVWB4O6dUaBzRFgZiL2DKtJEYBOcOnjEh0qaSl/Y+F6VrGyhpiZtf/oFvlQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052378; c=relaxed/simple;
	bh=fzx14Fo94+FtJqJQuwh+fcF/tz6fcIh49IzC23He+24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sBMccdSxliiqFnUVyByQL9Jsq7Fe248sPBRwtfCSDwByOxSzTAHbafxgG1FxerrQygjeJJzTyHai0xF9Oviq/yCnA2CJ8qHLg0j+4cqcBocCjSXfPQqU7W+HDxLBgDiXn+YkVOfN5fbzfu6uTkicsDb0rHbkZFVcKHCfDo4203s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7reFH0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7reFH0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA2DC2BCB0;
	Fri, 24 Apr 2026 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052378;
	bh=fzx14Fo94+FtJqJQuwh+fcF/tz6fcIh49IzC23He+24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D7reFH0SlvXFlCm356uOO1HFWc1kP5UmFZzz/JqnVXWWgaC7QXIUQNKz/+ztu7EWW
	 LbI6WCmNStxhvQPH3gaDm0WNit2TzDag/+eLdTh0fgG7rteGkLVLGrCKdDh8qrdz33
	 nkUp1/fYk2Ss3BMonGTnNj1LuEhVIwml9/f1b57vZpppFIvMX6V9p0H6SGngSAcqTS
	 P6P80P2BGA21n/5rkPabyxu0NjQTxwuHKJzyBVWXfL+HJiKPHqUWWomjz+1EZCMVC/
	 P9yAJLEgG6BBmKarbvU4f30YLnbBS5V6jbrZFs784Xx8DP9CVC6i2wURTvl24lf48Y
	 2nTDeqfQGqFTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 51/58] perf wakeup-latency: Port wakeup-latency to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-52-irogers@google.com>
References: <20260424164721.2229025-52-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:39:36 +0000
Message-Id: <20260424173937.3AA2DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The script hardcodes `min_wakeup_latency` to 1,000,000,000 ns (1=
 second), which will silently discard true minimum latencies greater than 1=
 second and print a fabricated value if no valid events are processed.
- [Medium] The script fundamentally alters the performance metric being mea=
sured from per-CPU scheduling latency to per-task wakeup latency, breaking =
compatibility with the legacy script it replaces.
- [Medium] The event matching logic uses loose substring matching, which un=
intentionally catches `sched_wakeup_new` events in addition to `sched_wakeu=
p`.
--

commit e4dd02fc9011f547e0777e05bab49c7bfc0e5168
Author: Ian Rogers <irogers@google.com>

perf wakeup-latency: Port wakeup-latency to use python module

This commit ports the legacy Perl script wakeup-latency.pl to a Python scri=
pt
using the perf module. It leverages the perf.session API for event processi=
ng
to measure wakeup latency.

> diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wake=
up-latency.py
> new file mode 100755
> index 00000000000000..1b0db115abcf05
> --- /dev/null
> +++ b/tools/perf/python/wakeup-latency.py
[ ... ]
> +class WakeupLatency:
> +    """Tracks and displays wakeup latency statistics."""
> +    def __init__(self) -> None:
> +        self.last_wakeup: Dict[int, int] =3D defaultdict(int)
> +        self.max_wakeup_latency =3D 0
> +        self.min_wakeup_latency =3D 1000000000

Is there a regression with how minimum latencies are tracked here? If all
recorded latencies in a trace exceed 1,000,000,000 ns, it appears the minim=
um
will be capped at exactly 1 second, discarding real data.

Additionally, if no valid events are processed, this prints 1000000000
instead of "N/A".

Could min_wakeup_latency be initialized to infinity, such as float('inf'), =
to
avoid discarding real data?

> +        self.total_wakeup_latency =3D 0
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D str(sample.evsel)
> +        sample_time =3D sample.sample_time
> +
> +        if "sched:sched_wakeup" in event_name:

Can this substring check cause a regression by unintentionally matching
"sched:sched_wakeup_new" events?

The condition evaluates to True for both tracepoints, silently merging norm=
al
wakeups with new task wakeups.

Would using strict equality or explicitly matching the exact event name
prevent this?

> +            try:
> +                pid =3D sample.pid
> +                self.last_wakeup[pid] =3D sample_time
> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif "sched:sched_switch" in event_name:
> +            try:
> +                next_pid =3D sample.next_pid
> +                wakeup_ts =3D self.last_wakeup.get(next_pid, 0)
> +                if wakeup_ts:
> +                    latency =3D sample_time - wakeup_ts

Could this logic introduce a regression in the performance metric being
measured?

By tracking the timestamp using the task pid and measuring latency when that
specific next_pid schedules in, the metric changes to per-task wakeup
latency.

The legacy Perl script measured per-CPU responsiveness by tracking the
timestamp of a wakeup using the target CPU and calculating the latency upon
the next context switch on that same CPU.

Does this change break compatibility with the legacy script's output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D51
