Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC5179A3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140486; cv=none; b=gpAYLwW79f7KYfyEkts7xIMVSTXiLO+C2/6V/epA/xJr9//IBZ8irSP/vLJusgusvl2TAYG1Fyf7zsfnLL/K9rkr16mTVRnBnnA3GW2utRp5RrE1RXFpzd//PguUHYE/ZgNVdO5vNjgt5iLPUidttYVFwTja4UV55G7BdgJTqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140486; c=relaxed/simple;
	bh=l1XQF0drAwfMlTgb5IuV6asC38lJa1m2iSLpMokOHK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWEJe7LB5hH2R0uPCY2cJrgPhRy2D6U6BdUQbEmJ9IXDz4Dp1aYJoWx5Ahtr8HSPQX0DX3mbagzCEl3k6mQ+Qpt/hIL0c1/3xQHd4zDSd/mPl17/90KQPLmY1qiN+KMke/Nd+gmCoBCg6T8AtjYujFogZ9gNuDWljhvKEgJX3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSh5aW8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSh5aW8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F5EC2BCB0;
	Sat, 25 Apr 2026 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140485;
	bh=l1XQF0drAwfMlTgb5IuV6asC38lJa1m2iSLpMokOHK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uSh5aW8aME57+2KK+69JXOzVGaZutLUccba6uwQ2HOvMxjxWcSp9GSHx0EDEvcngJ
	 WUktOUQefhg4G9c+a79PjY7iL2qvB0Zq3ZE4WAcmnmSOLi4G4k/paHkDeG+IxOKt1j
	 e5SLWxeEGj6Bu4eVHboXv1FX0ffwA+kS0RYFGZAxRGFQoCoyu88yFMk0sxFHu6sCiA
	 yrw6uwczJ+CcyfhrODZV+w1wXELqSLydTmRjP6lqcdU6l1g80tppQaStIweBGNJsqL
	 H3PzIQ26MRXjZ6GObr0fxUI5VydM3lQnC8A3wdNgSkc9wjI3wVXf9oHGO+tS1d3z5g
	 8t0XAowwIb08A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 47/59] perf failed-syscalls: Port failed-syscalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-48-irogers@google.com>
References: <20260425174858.3922152-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:08:04 +0000
Message-Id: <20260425180805.73F5EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script incorrectly filters out `raw_syscalls:sys_exit` event=
s because it requires the event name to end with an underscore.
--

commit d0669a431485bb5878875ee3c2d4a44c47d0f2ae
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls: Port failed-syscalls to use python module

This commit ports the legacy failed-syscalls.pl Perl script to Python using
the perf module. It leverages the perf.session API to filter sys_exit event=
s,
track failed system calls, and aggregate the counts per command name.

> diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/fai=
led-syscalls.py
> new file mode 100755
> index 000000000000..c3b58664eb57
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process sys_exit events."""
> +        event_name =3D str(sample.evsel)
> +        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
> +           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):

Will this condition unintentionally drop raw_syscalls:sys_exit events?

The stringified event name for raw syscall exits is
"evsel(raw_syscalls:sys_exit)", which does not have a trailing underscore.
Because the startswith check here specifically includes the trailing
underscore, it looks like traces recorded with raw_syscalls:sys_exit will be
discarded prematurely, leaving the script with empty output.

> +            return

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D47
