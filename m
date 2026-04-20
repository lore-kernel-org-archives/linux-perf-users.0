Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF6946C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646071; cv=none; b=AuqA60EtskqGw7aPf2PeMpAqRfG9AafIYADAsy778S2sI2sycEqbMldFd0+rpBDzK0D2jNQy6i9sDJ/LQJc/hz3MWQCQpQtW0B/cAafA8QQZyYGhvF5wFFCgaKT7a/sIKVKwvG3Z5JhOiggKsP6JijZRnNAyTLfVW9vddst4Hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646071; c=relaxed/simple;
	bh=YHQP1E2iHy+xYQejdT4Y7EdBEUpLtjIgyCIe6vCqL+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EA4Kmu9JNg4u6K0d4K5grKlX72C3siAAw9eMVvMT2J0SPDgsS6/Kn4JL9r6kMgQiJInkM2a6olubftiaf9Bp2i0CpXZUpfTv4KrJkIwtD1zlY8l+ouXmWvqbzYBZ7GZPadCO95EVWeb8KnIfXIbsz33so7AnCoxi9GWqfNgtRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikKW0Ovo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikKW0Ovo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2D5C2BCAF;
	Mon, 20 Apr 2026 00:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646071;
	bh=YHQP1E2iHy+xYQejdT4Y7EdBEUpLtjIgyCIe6vCqL+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ikKW0OvoKFXDQBcmPI872ULQbu0Av1b43cgnDmoKIC9JqO9BMXA7hRWv/XU147SUh
	 cf16FKthTjAjNMCOOZ3KxF2WupjVmCv59gwQv5L/lPJ8xrJFog66BNICLm0JbhRS5E
	 GO309ZJ0XmC/WV171VaqvSQghIS4nOZ6j3DU9xQCreos8s9BYLan1X9JqB61cDWzF8
	 emP0dHLEE8a3BWpqHs0SR4KK/uR/uijch7OGN0jlggLpzy0Xaj4SVTgV7yevGPfexV
	 K2fNs+beoufrenzpwapCCxWnwaHRJDOahlBw04xHZ9MeQvOUPID6252lbT+sExvcv1
	 Y/jXdKJ1xt7nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 51/58] perf wakeup-latency: Port wakeup-latency to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-52-irogers@google.com>
References: <20260419235911.2186050-52-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:47:50 +0000
Message-Id: <20260420004751.3F2D5C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Wakeup latency is calculated based on the target CPU rather than t=
he task being woken up, leading to invalid and meaningless statistics.
--

commit 6b0cef4a823ca1458fe5c3eb39e24c043a11d86f
Author: Ian Rogers <irogers@google.com>

perf wakeup-latency: Port wakeup-latency to use python module

This commit ports the legacy Perl script wakeup-latency.pl to a python scri=
pt
using the perf module in tools/perf/python. It tracks timestamps of
sched:sched_wakeup and sched:sched_switch events to measure latency.

> diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wake=
up-latency.py
> new file mode 100755
> index 0000000000000..109b751aefb30
> --- /dev/null
> +++ b/tools/perf/python/wakeup-latency.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D str(sample.evsel)
> +        sample_time =3D sample.sample_time
> +        cpu =3D sample.sample_cpu
> +
> +        if "sched:sched_wakeup" in event_name:
> +            try:
> +                target_cpu =3D sample.target_cpu
> +                self.last_wakeup[target_cpu] =3D sample_time
> +            except AttributeError:
> +                pass
> +        elif "sched:sched_switch" in event_name:
> +            wakeup_ts =3D self.last_wakeup[cpu]
> +            if wakeup_ts:
> +                latency =3D sample_time - wakeup_ts
> +                self.max_wakeup_latency =3D max(self.max_wakeup_latency,=
 latency)
> +                self.min_wakeup_latency =3D min(self.min_wakeup_latency,=
 latency)
> +                self.total_wakeup_latency +=3D latency
> +                self.total_wakeups +=3D 1
> +            self.last_wakeup[cpu] =3D 0

Does this logic accurately measure wakeup latency? It appears to be keyed by
the target CPU rather than the task being woken up.

If multiple tasks are woken up on the same CPU before a context switch
occurs, wouldn't the earlier wakeup timestamps get overwritten? When
sched_switch fires, the script pairs the last recorded wakeup timestamp with
whichever task is being switched in, even if the incoming task is completely
unrelated.

Additionally, if a task is load-balanced to a different CPU after wakeup,
would the latency calculation use the wrong CPU's last wakeup time or fail =
to
find one?

Tracking the wakeup timestamps per-task using the woken task's PID instead =
of
the CPU might be necessary to accurately measure wakeup latency, though I s=
ee
this behavior was ported directly from the legacy Perl script.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D51
