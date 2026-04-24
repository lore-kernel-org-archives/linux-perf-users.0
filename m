Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563935DA6F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050455; cv=none; b=sFqnXycsky65hmZSO5TQEW56S4TkJloEaxrkb9jDdRulvWD3wg2t7y0HAAEM/kiISLnyviZ+9Z6BPCyvGC4Bb9a6YS9wKj0ZcPZjlUB4gHHRGKWpM0WbFp05zV6j7baH+h0xd0FWR2FDn/FySKVSWvOXYIAzIaUejn0rB38lwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050455; c=relaxed/simple;
	bh=k55HzhsTlCOdqI6KtxFFrHHMex7nwvFaFMKrH98o/2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jY+Mp4Wf5T6SgABoQ04vbVYuqkNRNQ6GH3DduULjyTONGEwoBfdeNFcTewhI/tazlI6kdy7ZOdxSwBLxCd05DgVSVjrtTyH/o8ePqyCcNzhRzpjWrf56GqMQcU1li1b791gPOyqZBsqGQV6+LR4mDRTeH3/5ES3ByLWr0DIhl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdb4h/0+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdb4h/0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07750C19425;
	Fri, 24 Apr 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050455;
	bh=k55HzhsTlCOdqI6KtxFFrHHMex7nwvFaFMKrH98o/2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vdb4h/0+Ha00EqG/LYeY9em5LVJoyHKSljZTmzhne6oc7BxvMQ4e07qblSP1ZlswB
	 w/7/z19GWvjQrXGzbUKvntq7OPjjxSKAXZcmArFP+KjhFBSHKRu9tP141GgVPwu+G5
	 uHVsMD6oq6yysa8xULweLh7PiOkj3x0afX0RSSyNP3diQrriT7EZU2S02IFqUMI6NG
	 LOyUlS3hPr96VtuefKwmXNP3E3HRXUamAPC14L762xPFLZI5Fj8AKYKujs33F7TPsE
	 cn7/ePu8uECxcPPKAtvlhs7E/uW67KmOqRr/ujMiuB1GiNk2NytJY5Bb6XGrm7zAc7
	 nsjZYZ4FLvYNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 28/58] perf syscall-counts-by-pid: Port
 syscall-counts-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-29-irogers@google.com>
References: <20260424164721.2229025-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:07:34 +0000
Message-Id: <20260424170735.07750C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] PID filtering silently fails and ignores the filter when the tar=
get PID is 0.
- [Low] The module docstring contradicts the implemented filtering capabili=
ties.
--

commit d2f57c46d57c5dfad5388599b6ab23e865e28d4e
Author: Ian Rogers <irogers@google.com>

perf syscall-counts-by-pid: Port syscall-counts-by-pid to use python module

This commit rewrites the syscall-counts-by-pid.py script to utilize the perf
python module directly. By bypassing the overhead of standard perf script
execution, it yields significant performance improvements.

> diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/pyth=
on/syscall-counts-by-pid.py
> new file mode 100755
> index 00000000000000..45a98e6e8e0116
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts-by-pid.py
> @@ -0,0 +1,88 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +Displays system-wide system call totals, broken down by syscall.
> +If a [comm] arg is specified, only syscalls called by [comm] are display=
ed.
> +"""

This isn't a bug, but the docstring only mentions filtering by comm. Should
it be updated to also document the PID filtering capability that the script
provides?

[ ... ]

> +def process_event(sample):
> +    """Process a single sample event."""

[ ... ]

> +    pid =3D sample.sample_pid
> +
> +    if for_pid and pid !=3D for_pid:
> +        return

Does this filtering logic work correctly when targeting PID 0 (the
swapper/idle process)?

In Python, the integer 0 evaluates as false, which means the condition
evaluates to false and bypasses the check entirely when filtering for PID 0.
As a result, the script aggregates syscalls for all processes rather than
filtering just for PID 0.

Would it be better to explicitly check if for_pid is not None to ensure PID=
 0
is properly filtered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D28
