Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADC38C2B0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158767; cv=none; b=NwhCt35lGvCh1BCAWZdGCbz4647oMvH5rj2SGgN70QmUxvg32EcQjBjwZluW8XEWtblCElg9cRkYJEMOyXQipChoJHbLEj7bqgXObziBBVZ26diiEs48v5Xxw61lNSu14jduk5qN78UX8WS+L4Hyo2B0tpIIKrG1KXQ4chdEA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158767; c=relaxed/simple;
	bh=TTBIEXQRu4FXRjp/5hN479Hl42dIuu6CuvDBT286ClE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FqLVZbOK/i5O7sk3Zdy3FEKbIM9tUUBwPGymIvitvM2VfDuooq9xj5Zw9RphjKBb+2toaQbWngtzalPCenLgHRhfPPGpSBovZlooy7oAtBM/JuJJnkJjsjBFAjcrRWXDQ2xe73DqV32sG+OMHP6Vrg88n5No1sw5QxR1pkaFrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyMEGsD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyMEGsD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E4EC2BCB0;
	Sat, 25 Apr 2026 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158767;
	bh=TTBIEXQRu4FXRjp/5hN479Hl42dIuu6CuvDBT286ClE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AyMEGsD2kLV+B0+sFnAeJOzOFPrsTSg+0IYtpdaYWP6k01XvN6KkH8O9MawzDyqB+
	 yLqM/54XIPBDGERhqAsv4iqq0yISzszw1bh1tX+y7jCLO6YnDEoXbzOSY/h/XFmMfY
	 u74mqrcxHRhvd5Bgedtmty9oRiJuhDN44j1IYah9jc/6s3CjHHhaiyFGUM+XlR6cCI
	 7Ai4QVikfr0OR8J2XDtdb6uiLKVkNjfA89yuVF+T4M9H/SdoLlZo15NdG1k8gDa1F8
	 7ELQvNE7uahQv87HaqF4/TNQlheK7v8PvemOtXCnFF8mcf04e8+gk6tIolZ+56ZNhW
	 iML21IdO/AEoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 51/59] perf wakeup-latency: Port wakeup-latency to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-52-irogers@google.com>
References: <20260425224951.174663-52-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:12:46 +0000
Message-Id: <20260425231247.44E4EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incorrect initialization and reporting of min_wakeup_latency cau=
ses misleading statistics.
--

commit 227f7367d2013dd9389e4f1721e12c0d7a7bed57
Author: Ian Rogers <irogers@google.com>

perf wakeup-latency: Port wakeup-latency to use python module

This commit ports the legacy Perl script wakeup-latency.pl to a Python scri=
pt
using the perf.session API. It leverages a class-based architecture to track
timestamps between sched_wakeup and sched_switch events to measure latency.

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

If all recorded wakeup latencies happen to be greater than 1 second
(1,000,000,000 ns), will this hardcoded initialization cause the reported
minimum to be incorrectly capped at 1 second instead of reflecting the actu=
al
minimum latency?=20

Could this be initialized to float('inf') or the first observed latency
instead?

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
> +        print(f"max_wakeup_latency (ns): {self.max_wakeup_latency}")

When no wakeups are recorded during the session (total_wakeups =3D=3D 0),
does this code unconditionally print the initialized values for min and max?

It appears this might result in "min_wakeup_latency (ns): 1000000000" and
"max_wakeup_latency (ns): 0" being printed for an empty trace. Should these
outputs also be moved inside the `if self.total_wakeups:` block or given an
"N/A" fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D51
