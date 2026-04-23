Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA01377543
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917618; cv=none; b=fmLXdoqrfdqbYFBjHzSVLd21DDcaEsnnBeCFECg168FJ81a94FZe3f95fSRzQ9G5sJ5OiUNiQsI84znoHHx0mJPL+R4IYfVk5XGOOfmNC3DFjfUwhL3tgCu/GLzIg1LGhDP/uZGKCYl619AUjKUn0fKvJEG+lIwEfps4+n0Wv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917618; c=relaxed/simple;
	bh=qVnjPSBuc7+Tq68ts9LY+lS2Ol6h2C36GIgZ86J44C8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsbA0ugMNG96YVdxFVqwdz2E9naWi1eEVJBk+/IZCAs7+4HUk4UvPbsUamxYu/xxMwGymRHQGStg9l/2txRsePVl3KsjkTjnxMAn/HAgwDDaZd/VejrJgHyEhHt1dcrFQ3SiX0eaqzXC+7Scd4i9F+qn/U0MWRFCeSvmlO0OU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO/GCrfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO/GCrfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F4C2BCB2;
	Thu, 23 Apr 2026 04:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917618;
	bh=qVnjPSBuc7+Tq68ts9LY+lS2Ol6h2C36GIgZ86J44C8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qO/GCrfTglpbAr3RTh8z9dMV/GxLd5uErBb4e9RcV3wkkOGdSPFvg4dBVyMoh5VaR
	 ZgivdDBa04aSa6PExLLv+6nzvhqCVYVf1m24BQsJRJWqhQXaUF3sR6XkkgHwVSpPfR
	 ZkNHRAevA3pcedDsS+D6A687/IC5OL6FUvDOvN0YKdTBnlYoGPQPAY/PxNLnRdrac+
	 ziuwm8rGKdeDpzW+Bt8ZdOijw5jfLUqKj+olgLrBmqDTXn0RSPppDE16CaIyJAjTLg
	 1w8YkRstJT23lwDFF1+wpIAsuSMacSAXnSbJq6iVgExIHtUIFgG2YDvStm9qHTX1ol
	 beHBINbC2e0Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/58] perf futex-contention: Port futex-contention
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-30-irogers@google.com>
References: <20260423035526.1537178-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:13:37 +0000
Message-Id: <20260423041337.D66F4C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script silently drops futex wait events and causes a perform=
ance regression when a thread's process name cannot be resolved.
--

commit 3b120818238ad05dcc6b4174bcbcdb6273b4f67b
Author: Ian Rogers <irogers@google.com>

perf futex-contention: Port futex-contention to use python module

This commit ports the futex-contention.py script to use the perf Python mod=
ule,
along with several style changes. The rewrite avoids the overhead of perf
script execution, resulting in significant performance improvements.

> diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/fu=
tex-contention.py
> new file mode 100755
> index 0000000000000..7c5c3d0ca60a2
> --- /dev/null
> +++ b/tools/perf/python/futex-contention.py

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

If session.process(tid) throws an exception, the script catches it and retu=
rns
early. Does this cause the event to be dropped since start_times[tid] is not
recorded?

Also, if session.process(tid) returns None or throws an exception,
process_names[tid] isn't populated with a fallback value. Since the thread
remains missing from process_names, won't this force the script to repeat t=
he
expensive lookup for every subsequent event from this thread, hurting
performance?

> +        start_times[tid] =3D (uaddr, start_time)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D29
