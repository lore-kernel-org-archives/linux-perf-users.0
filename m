Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630733E120A
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050840; cv=none; b=a9Mgpg/nzacvxY8Uk/o4eIT4uxggJjZmAyzsh1iSZb/dgKCoX+Ce9nJujYyaQ9eGEX/eFUCL75yitIoWlFJGWWxyqtfcWfFi540z3ACJn0IyJMu0+NivA/ovBnWa2KlXTnM7NFHQImRGVD41ZHa/gEACG1O+wBx5MVP9izR1auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050840; c=relaxed/simple;
	bh=GpXStT8+g+Ae9UoajxYprfYnMo50xzPzaZp4GCNnY20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=edhtJTkv+4jU2SUz9d6cNA0N9DVJ2kf9r+qDFNlHanfQEoeQBhxW3tWB1e6lmJRDE8+/jj4usnQXNry/ODyt9oobflgwD9HSHMcZeTcSY6hfgln3kNQl4eipUT9HDMIQUoWqL+FADeX4Y6RAG/oS+71nHxeAVdhW4wIzQ1yV108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1DDp/3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1DDp/3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61E3C19425;
	Fri, 24 Apr 2026 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050840;
	bh=GpXStT8+g+Ae9UoajxYprfYnMo50xzPzaZp4GCNnY20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Q1DDp/3R1PrX2cu49fQujJM3d6WxHCqBvORMwW8AeoU8JfTtwXpP6kE+BZwSs8Gp7
	 wpCt6eS8bIuBX5gejZTBzVE9Y22omGHLb0BY4BXRqmmEY/72JTjsQr8IzaEsq/qTQg
	 jF0kEriIUdZIahP2HM8ElAQ/vw8husu5CEJNp+4lY2vJnbwfq3X/V1DnNlBv6YZ8YS
	 CKeHVCAKyRUEAUPE1VNeuuaBI+sVvmLUJQa829kVvmft3BgFexkQ/DhGAYq1bHi2LZ
	 5to3jTYsvDW9lLEfronPljDjy8rQ/yC0INyC903HO1scyzh46Ri0vKawahdUXc0vsb
	 i+ycK6zKvpnpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 29/58] perf futex-contention: Port futex-contention
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-30-irogers@google.com>
References: <20260424164721.2229025-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:13:59 +0000
Message-Id: <20260424171359.E61E3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unintended early return in the exception handler drops valid loc=
k contention events if process name resolution fails.
--

commit 539a8e47af3e961be17e3e9f6a30d0a7b8bb091e
Author: Ian Rogers <irogers@google.com>

perf futex-contention: Port futex-contention to use python module

This commit rewrites the futex-contention script to use the perf python
module directly. This avoids the overhead of perf script execution and
improves performance.

> diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/fu=
tex-contention.py
> new file mode 100755
> index 00000000000000..7c5c3d0ca60a2c
> --- /dev/null
> +++ b/tools/perf/python/futex-contention.py
[ ... ]
> @@ -0,0 +1,87 @@
[ ... ]
> +def process_event(sample: perf.sample_event) -> None:
> +    """Process a single sample event."""
> +    def handle_start(tid: int, uaddr: int, op: int, start_time: int) -> =
None:
> +        if (op & FUTEX_CMD_MASK) !=3D FUTEX_WAIT:
> +            return
> +        if tid not in process_names:
> +            try:
> +                if session:
> +                    process =3D session.process(tid)
> +                    if process:
> +                        process_names[tid] =3D process.comm()
> +            except (TypeError, AttributeError):
> +                return

Will this early return drop valid lock contention events if the process name
cannot be resolved?

It looks like if session.process(tid) or process.comm() raises a TypeError
or AttributeError, we exit handle_start() entirely and skip recording the
start time for the wait event.

Since the final reporting loop safely handles missing process names by
defaulting to unknown via process_names.get(t, 'unknown'), should this
exception handler just fall through instead of returning?

> +        start_times[tid] =3D (uaddr, start_time)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D29
