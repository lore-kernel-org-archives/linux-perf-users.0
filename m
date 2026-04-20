Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE040DFCE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644522; cv=none; b=g8dXB2SmRqiUmhCcSUfZJCDh4s9KN+1/RPPTbDgiDdZpLzT9T361BwJuCHB21YJR3xv9C+X4QgV7dm5I4aRaQ2kcKBKUYjPD07PGKqWEIDJgDnTAhTRaa3Znxkp+Nr0t6UouCr2Y7geJ0+2C7a5SOGkwfcAIQwQVyYjZeedkbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644522; c=relaxed/simple;
	bh=gzjjWtuZSL9ZMifnn3M7BUxrAzT/z/VWEsgqRg3F3FM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KdjylexamrMVzbi8dcQIpqJKTxSym+Yqnap7hQKy0RSKYvKpoYdsamgNNOcOPRxPzPE8NUtfenmDbzoQgDjnDtnG6jdMVoOSBOFzd2LAwXyVAH9I4RvSvnF3hHDGZ4GzFSHXLQc3moBL0dNX01gvXsfmXB/RitDQO+74HLlk/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Pv3gg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Pv3gg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDC1C2BCAF;
	Mon, 20 Apr 2026 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644521;
	bh=gzjjWtuZSL9ZMifnn3M7BUxrAzT/z/VWEsgqRg3F3FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=i/Pv3gg6fotlXfX7KtNsrVGCufEIn+a31V9ywE5mEJrmIjMAapehOHDUsvMyoW2KM
	 uo8dbO25Ku7+Y3LlxN6qTSTEUhAFz4lyCM8D7wV0c79P7RTnCCUij81am7pfIO9thP
	 5VtHOUMY8isTIH8R/ym8BW7fZvjU0gGkn7gRTsGe4d/+gQbNjQsMsz7uQAIifIqqp6
	 0Y5jXK7Gzqc5k+GpV2ZZv4IAJIrxnJ8c31jB0TUexrLfhGRxIu4at8wxt5TN+6rDPK
	 JPP1qKMgwccC/viiMy/fMI687MpUWrentmbIg8eYamMn7QBofZpNKW+sxHRGMwdx+4
	 ziNLJAMZYWf3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-25-irogers@google.com>
References: <20260419235911.2186050-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:22:01 +0000
Message-Id: <20260420002201.BCDC1C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Moving parallel-perf.py breaks the parallel-perf test in tools/p=
erf/tests/shell/script.sh.
- [Low] Usage examples in exported-sql-viewer.py reference the old script p=
ath.
--

commit 015eb1b3b886beef12696f70686c41ba97d413c0
Author: Ian Rogers <irogers@google.com>

perf python: Move exported-sql-viewer.py and parallel-perf.py to tools/perf=
/python/

This commit moves the exported-sql-viewer.py and parallel-perf.py scripts
from tools/perf/scripts/python/ to tools/perf/python/ as they are standalone
and do not use the perf script libpython support.

> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/per=
f/python/exported-sql-viewer.py
> similarity index 100%
> rename from tools/perf/scripts/python/exported-sql-viewer.py
> rename to tools/perf/python/exported-sql-viewer.py

This isn't a bug, but do the usage examples inside exported-sql-viewer.py
still reference the old script path?

The comments at the top of the script appear to instruct users to run it
using the old path, which might lead to confusion when the examples fail to
execute:

python tools/perf/scripts/python/exported-sql-viewer.py

> diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/pyth=
on/parallel-perf.py
> similarity index 100%
> rename from tools/perf/scripts/python/parallel-perf.py
> rename to tools/perf/python/parallel-perf.py

Does this move break the parallel-perf test in
tools/perf/tests/shell/script.sh?

The test_parallel_perf() function seems to hardcode the script path:

tools/perf/tests/shell/script.sh:test_parallel_perf() {
    ...
    pp=3D$(dirname "$0")/../../scripts/python/parallel-perf.py
    if [ ! -f "${pp}" ]; then
        ...
}

Since the path in the test is not updated in tandem with the script move, w=
ill
this cause the check to evaluate to true and silently skip the test?

This appears to result in a permanent loss of test coverage, as subsequent
commits do not seem to resolve the path mismatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D24
