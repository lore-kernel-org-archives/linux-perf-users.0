Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F9277C88
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917915; cv=none; b=BE67z7N3u3+mazDFyR2N7QVwbb41MRy09TvdhbrkOoGEKAgQ4p7oP10Fj3e3WGbXEJtrex+qdDVteRiEloCjZSYwuB4RTGbCfmmEH8m+Z6VexmZhiGQVGubaQnOJ/4f5RT24hNiGNMHcPY8L7DJoswbBc2n3B/3np5VVD+vI/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917915; c=relaxed/simple;
	bh=NzJpHCIr0G/+srGE+2Eenc3a5NW4ncB4sgnydO4uWqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMpr5kffTvnxanGbNOYtJ0rTh8EjVHOBLOeuUUWWdTXLXgUW1qLrd8q+2B0MCJ9O0PvJBcD6eyw4I5/XhbjdVR8lhUZMrVH91uXHri2xJs+5DJ+J1V4arioyfuoAVlM2Q0QE0kucclI6lewfLv3Q5meN+fIDTy2QI3mttz7kbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSrLe2mr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSrLe2mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39746C2BCB2;
	Thu, 23 Apr 2026 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917915;
	bh=NzJpHCIr0G/+srGE+2Eenc3a5NW4ncB4sgnydO4uWqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PSrLe2mrGLuG3CPW0Ou1BDZUvwnZJBYqkCwN8ZpMEnbh7rZOuOTiF+FUZciI12Viq
	 DxZ7hZlVxu1D+ITaGQ03uD+OHBHLvkDTyZB3YFblPkLdA8e894qpAq1m4VhmquR0eh
	 J3MvrzqsdcPFYZdvGW/fG2tJYcUNgPryJTNU8aUJKyLXoptAB9ZqeYB85yFjomeUCh
	 iuS50izB3Ons2XKHKj7mtU/ttsQLuUZwGDzwQcNZq9Q84GtvF056AROg5U0Y0b0DF4
	 sYwQULaphBFkB4hdtKWBkNBDhSkGE/Zx/j4KOuTUHx67CYT0fm+51oy7yKf4woOfY/
	 8Q7QzQU2jugqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 33/58] perf check-perf-trace: Port check-perf-trace
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-34-irogers@google.com>
References: <20260423035526.1537178-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:18:34 +0000
Message-Id: <20260423041835.39746C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] The ported script hardcodes tracepoint string resolution, removi=
ng its intended test coverage.
- [Medium] The script uses `sample_pid` instead of `sample_tid`, causing in=
correct thread reporting.
- [Medium] An unhandled `TypeError` when looking up untracked threads will =
crash the script.
- [Medium] The PEP-585 type hint causes a runtime crash on Python 3.8 and o=
lder.
--

commit 928333ee9c2bd4abdb3f2cca77abb3355dd5e54f
Author: Ian Rogers <irogers@google.com>

perf check-perf-trace: Port check-perf-trace to use python module

This commit adds a port of the check-perf-trace script that uses the perf
python module directly, aiming for faster execution by avoiding intermediate
dictionaries.

> diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/ch=
eck-perf-trace.py
> new file mode 100755
> index 0000000000000..4c05540bdc057
> --- /dev/null
> +++ b/tools/perf/python/check-perf-trace.py
> @@ -0,0 +1,113 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +Basic test of Python scripting support for perf.
> +Ported from tools/perf/scripts/python/check-perf-trace.py
> +"""
> +
> +import argparse
> +import collections
> +import perf
> +
> +unhandled: collections.defaultdict[str, int] =3D collections.defaultdict=
(int)

Will this type hint cause a runtime crash on older Python versions?

Using subscripted standard collections like collections.defaultdict[str, in=
t]
was introduced in PEP 585 for Python 3.9. Without a future import, Python
3.8 and earlier will evaluate this at runtime and raise a TypeError.

> +session =3D None
> +
> +softirq_vecs =3D {
> +    0: "HI_SOFTIRQ",
> +    1: "TIMER_SOFTIRQ",
> +    2: "NET_TX_SOFTIRQ",

[ ... ]

> +    8: "HRTIMER_SOFTIRQ",
> +    9: "RCU_SOFTIRQ",
> +}

[ ... ]

> +def symbol_str(event_name: str, field_name: str, value: int) -> str:
> +    """Resolves symbol values to strings."""
> +    if event_name =3D=3D "irq__softirq_entry" and field_name =3D=3D "vec=
":
> +        return softirq_vecs.get(value, str(value))
> +    return str(value)

Does hardcoding the tracepoint string resolution here bypass the original
intent of the test?

The original script delegated trace field resolution to the perf scripting
engine to verify its correctness, but using a hardcoded dictionary drops
that test coverage for the Python scripting API.

[ ... ]

> +def print_header(event_name: str, sample: perf.sample_event) -> None:
> +    """Prints common header for events."""
> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000
> +    comm =3D session.process(sample.sample_pid).comm() if session else "=
[unknown]"

Does using sample.sample_pid instead of sample.sample_tid cause incorrect
thread reporting?

In the perf subsystem, the pid field corresponds to the process group leader
(TGID) while the tid field corresponds to the actual thread ID, which might
output the group leader's name instead of the specific thread generating
the event.

Also, can session.process() raise an unhandled TypeError here?

When machine__find_thread() cannot find the thread (which is common in
truncated traces), the C extension raises a TypeError. Without a try-except
block, this could crash the script.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D33
