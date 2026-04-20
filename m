Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705852135AD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645480; cv=none; b=mCghEi1w5h/1VPpPfRlk9bA9UcHp3upGDL6m9NU14Mz5BikhE8oSGxx4GCJeJdz968Drup6YWnLCnHn8j7C3GlqKsPJjT6wevGmMVVRzNCsNZEAAO0xw7+Z5UepzPB1kCHqUMjydsmbqrH2xOWXdYQ2U8sYtdV+iOpTH/7H8T8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645480; c=relaxed/simple;
	bh=oO/onD8PHZ+iX6AL2MnMcenjtLIKwceTn9uccrIggSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NqDoyFUAGbq3t9usJ283R374RJgLRUPFn6uuoYR0+PCDcpqfmUTontyWRx2RqRq2KN2VKt4pqOBDhhuK58q2fzFJ65X0HtiW0vJxZcrE+ZJ8l9Y+rf+2rHlEenq346LF8gbR/QFvVn18ujnlak0b5KyGksp3Z6RcfxzS176wEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtU2UgDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtU2UgDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10243C2BCAF;
	Mon, 20 Apr 2026 00:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645480;
	bh=oO/onD8PHZ+iX6AL2MnMcenjtLIKwceTn9uccrIggSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jtU2UgDD9eI0zrpFfzbAa81uInnDStUrREJ7K8iHmcU2+NldVZPTxmOJvbIEPGAPo
	 ckINleb6qTl5WZia1UxuNvLkK53c+010VGbl1fVOFAoOe4zgBeYYvQNw03Sig0trDz
	 gUeA2IQZCmq5CgI8tyDlD8OOtzpNOLe6ebEiCnS5yq3tqmqLf0+n6zDDG9r858Vc+1
	 a3pnxBxs6g02bfDb399heCqge9ZfOqw/VkxgEtVIsEwlIB3aQICjvmwSu5K8qLHr6L
	 Pwvh7WnGjX4RqqvhAQ8QQX+4IEz49AvpXJosIMZX2Lw6Z+dUp+kwks6izYwQHLV9qm
	 yFD9kaM+vqaVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 29/58] perf futex-contention: Port futex-contention
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-30-irogers@google.com>
References: <20260419235911.2186050-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:37:59 +0000
Message-Id: <20260420003800.10243C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Fatal TypeError due to invalid type hinting syntax.
- [Medium] Unbounded memory growth leading to OOM risks on large trace file=
s.
- [Medium] Hardcoded input file drops support for custom trace files.
--

commit 1b6a7eb3db688a2d738e2a6cae094deea81591b4
Author: Ian Rogers <irogers@google.com>

perf futex-contention: Port futex-contention to use python module

This commit rewrites tools/perf/scripts/python/futex-contention.py to use
the python module. It aims to improve performance by avoiding the overheads
in the perf script execution.

> diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/fu=
tex-contention.py
> new file mode 100755
> index 0000000000000..153583de9cdee
> --- /dev/null
> +++ b/tools/perf/python/futex-contention.py
> @@ -0,0 +1,54 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Measures futex contention.
> +from collections import defaultdict
> +from typing import Dict
> +import perf
> +
> +process_names: Dict[int, str] =3D {}
> +start_times: Dict[int, [int, int]] =3D {}
> +session =3D None
> +durations: Dict[[int, int], list] =3D defaultdict(list)

Will this raise a TypeError at module import time? typing.Dict requires
types as arguments, not list instances. Should this use Tuple[int, int]
instead?

[ ... ]

> +    def handle_end(tid: int, end_time: int) -> None:
> +        if tid not in start_times:
> +            return
> +        (uaddr, start_time) =3D start_times[tid]
> +        del start_times[tid]
> +        durations[(tid, uaddr)].append(end_time - start_time)

Does storing every single duration in a list risk unbounded memory growth
and potential Out-Of-Memory crashes on large traces with high-frequency
futex workloads?

The original perf script based utility function maintained a running O(1)
memory aggregate (min, max, avg, count) for each lock.

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    session =3D perf.session(perf.data("perf.data"), sample=3Dprocess_ev=
ent)

Does this hardcode the input file to perf.data in the current working
directory?

Unlike other ported scripts that use argparse and sys.argv, this script
drops support for custom trace files. This breaks compatibility with
workflows where users specify custom trace locations (e.g., perf script -i
my_trace.data).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D29
