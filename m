Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75778366567
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140292; cv=none; b=peg1E5RQYZwU4n9p861iMVCjj8iDE/FRcLmqd0Ozawwc37E6Mxsyj1iUL7uZnKPnMREEcEWqSEv5VxME7QBAZM2o73cqIBOIBRDP+dMnkfQXqsx0H/LlXl9eMJu8xljul1wVnapX7AHRlM0zu2iR9m0zHsoBWjukTScIt0g1bAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140292; c=relaxed/simple;
	bh=x7cV2GA89meDrE/CjED9M93TmJhFk03/C4bRkxhMjHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l9oUBdDUu2NdlAQnhT3JfrlbvFUvMnD2CQo36jZ1iF/tG0/sBQMDu3+gpfvZe+hfqQZ7TXaFXDFlSvU39ywO0dldS/rVkp+lD6eVHzMW4j+P0/9AyhJk+rP5sWddToBv5dfI96z3pkBl1fXv/xpfZwgIURCPrG6gKPG8gt03wsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew4bLXo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew4bLXo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1393C2BCB0;
	Sat, 25 Apr 2026 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140291;
	bh=x7cV2GA89meDrE/CjED9M93TmJhFk03/C4bRkxhMjHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ew4bLXo6q8LbnOOA2mExR7auBQnh/d+z6gpustEj0G0LFe29tLyxt/wOSZ4JNYMuP
	 udNwX319GXRUSgsqW9pTlxuvJhwD04c1h8TKQ1ZQDGnEVdxkPQQ8O2xrsu1Nexp1Ws
	 VT0sYKgRBLqXPMirN6UTV+k5sWTG5bEHI0pNjb/Zj+XxbH+UlN2XpMeJD8Fj2IjJLN
	 teOO6xINgbpxtAnIOUUKsb0BIyyfCh4F9CVcqTFrK+bZs2mdY/Ys+lsC5CErjPwta+
	 S53/aCWMmRdwhJvCy8zEH/RhbuPUtKBmozTIfLOE2HbQmbpu5EduVQx/6fqcrDq0FV
	 a5khRUDmCYwdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 51/59] perf wakeup-latency: Port wakeup-latency to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-52-irogers@google.com>
References: <20260425174858.3922152-52-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:04:51 +0000
Message-Id: <20260425180451.C1393C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incorrect initialization of `min_wakeup_latency` artificially ca=
ps the minimum latency at 1 second and reports an incorrect value when no w=
akeups are processed.
--

commit 02a26dde701533f15dfaafd348b2b2126ca947be
Author: Ian Rogers <irogers@google.com>

perf wakeup-latency: Port wakeup-latency to use python module

This commit ports the legacy Perl script wakeup-latency.pl to a Python scri=
pt
utilizing the perf module. It implements a class-based architecture to
measure wakeup latency by tracking timestamps of sched:sched_wakeup and
sched:sched_switch events.

> diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wake=
up-latency.py
> new file mode 100755
> index 000000000000..1b0db115abcf
> --- /dev/null
> +++ b/tools/perf/python/wakeup-latency.py

[ ... ]

> +class WakeupLatency:
> +    """Tracks and displays wakeup latency statistics."""
> +    def __init__(self) -> None:
> +        self.last_wakeup: Dict[int, int] =3D defaultdict(int)
> +        self.max_wakeup_latency =3D 0
> +        self.min_wakeup_latency =3D 1000000000

Is it possible for the true minimum wakeup latency to exceed 1 second
(1,000,000,000 ns)? By initializing the minimum latency to this hardcoded
value, any actual latency greater than 1 second will be ignored since the
min() calculation will prefer the initialized value, artificially capping
the results.

[ ... ]

> +    def print_totals(self) -> None:
> +        """Print summary statistics."""
> +        print("wakeup_latency stats:\n")
> +        print(f"total_wakeups: {self.total_wakeups}")
> +        if self.total_wakeups:
> +            avg =3D self.total_wakeup_latency // self.total_wakeups
> +            print(f"avg_wakeup_latency (ns): {avg}")
> +        else:
> +            print("avg_wakeup_latency (ns): N/A")
> +        print(f"min_wakeup_latency (ns): {self.min_wakeup_latency}")

Will this output an incorrect minimum latency if no wakeups are processed?
The average latency correctly handles the zero-wakeup case by printing N/A,
but the minimum latency will unconditionally print the hardcoded
initialization value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D51
