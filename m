Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A461B6527
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644920; cv=none; b=SuMRL5FIsFlnZNZskgqbplVrCxc+O0UpFK+8qBzjBkkyu4FbW6zjp0FApQniXGZhvxWs2ifhH6aUattXOPsXG1eWZfKRHG7FMMKJnIQITe9FCrvDU6LCm+pGs2IwSnb6zMhAdgvFb+iDnJdr/XzTfL21TiDmwht8ITmPr3NYUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644920; c=relaxed/simple;
	bh=7m8iG9Aq4PJ9LMPVsmGI2mZaekJwXqP8HgYH2/fCrzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h1WK3L51U0vSZjqeidL7Dmpw0zOw5+GLup0HnSW+z+xy6PZliKot/Sn64H/lmzenQHoWIIguzoUmrD7C3CXEV3CEu2pOr6lwHDnQ9n04dVQXUkMlZxcZ+MhYfdfhAR388Sd6cc6SsJOwRO39z4L0WMXDBrjoZmjj7AoT5+r4e7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Us+IG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Us+IG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C43C2BCAF;
	Mon, 20 Apr 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644920;
	bh=7m8iG9Aq4PJ9LMPVsmGI2mZaekJwXqP8HgYH2/fCrzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R0Us+IG91h9LgfpmNGsxdU9XeNlm4NFWZYqBn6G19cc7eoaAJ8yNRfmKyJ3arOaZu
	 o/iDE246SaD/qXm+6+gczE2JX5tmuryawcYnUkFuswuyxsZO+Hs+Tsjs2rbWaj6HxG
	 +SEzHNJasfhX1hkmL1ebKfCGkyIu5m40ob1RiL/LjfXzo/Lv503Jt6FIAI00RrPPfI
	 V/vsSO4evojTBk4MoKKV024lw5V/QkXhFBVLiWs8f07R4oRdx6qV/2+tCLv7bJ742B
	 xI9oqWo9sZ0PVEcxhLYVpRGNN8cQf7+QXuJ5x4mbedyzbjwWHWDWK9+LvCK9hPLGCD
	 Okbi0v1Nm4KgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 32/58] perf arm-cs-trace-disasm: Port
 arm-cs-trace-disasm to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-33-irogers@google.com>
References: <20260419235911.2186050-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:28:39 +0000
Message-Id: <20260420002840.34C43C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Missing `import perf` causes immediate runtime crash.
- [High] Runtime crash due to unpacking mismatch on `sample.srccode()`.
- [Medium] Broken test integration due to stale script path.
- [Medium] Missing early termination causes severe performance regression.
--

commit 5bdc3caf81b1523e22044cb273de9d509ecc0c13
Author: Ian Rogers <irogers@google.com>

perf arm-cs-trace-disasm: Port arm-cs-trace-disasm to use python module

This commit adds a port of the arm-cs-trace-disasm script that uses the
perf python module directly to improve performance. It also updates the
testing to use the newly ported script.

> diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python=
/arm-cs-trace-disasm.py
> new file mode 100755
> index 0000000000000..3557a02b03fbc
> --- /dev/null
> +++ b/tools/perf/python/arm-cs-trace-disasm.py
> @@ -0,0 +1,333 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember using =
perf python module
> +"""
> +
> +import os
> +from os import path
> +import re
> +from subprocess import check_output
> +import argparse
> +import platform
> +import sys
> +from typing import Dict, List, Optional
> +

Does this script need an import for the perf module? The code uses it
directly in several places like perf.config_get() and perf.sample_event,
but it does not appear to be imported.

[ ... ]

> +def print_srccode(comm: str, sample: perf.sample_event, symbol: str, dso=
: str) -> None:
> +    """Print source code and symbols for a sample."""

[ ... ]

> +    global GLB_SOURCE_FILE_NAME, GLB_LINE_NUMBER, GLB_DSO
> +
> +    source_file_name, line_number, source_line, _ =3D sample.srccode()

Can this cause a runtime error when unpacking? The underlying
pyrf_sample_event__srccode in python.c constructs a 3-element tuple using
Py_BuildValue("(sIs#)", ...), but this code attempts to unpack 4 elements.

[ ... ]

> +class TraceDisasm:
> +    """Class to handle trace disassembly."""
> +    def __init__(self, cli_options: argparse.Namespace):
> +        self.options =3D cli_options
> +        self.sample_idx =3D -1
> +        self.session: Optional[perf.session] =3D None
> +
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single perf event."""
> +        self.sample_idx +=3D 1
> +        global SAMPLE_IDX
> +        SAMPLE_IDX =3D self.sample_idx
> +
> +        if self.options.start_time and sample.sample_time < self.options=
.start_time:
> +            return
> +        if self.options.stop_time and sample.sample_time > self.options.=
stop_time:
> +            return
> +        if self.options.start_sample and self.sample_idx < self.options.=
start_sample:
> +            return
> +        if self.options.stop_sample and self.sample_idx > self.options.s=
top_sample:
> +            return

Does returning here correctly stop the analysis? Since
self.session.process_events() loops through all records, returning only ski=
ps
the current callback instead of terminating the session like the original
script did.

[ ... ]

> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> index 0dfb4fadf5317..9749501cbf783 100755
> --- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh

[ ... ]

> @@ -45,8 +45,9 @@ branch_search=3D"\sbl${sep}b${sep}b.ne${sep}b.eq${sep}c=
bz\s"
>  if [ -e /proc/kcore ]; then
>  	echo "Testing kernel disassembly"
>  	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/n=
ull 2>&1
> -	perf script -i ${perfdata} -s python:${script_path} -- \
> -		-d --stop-sample=3D30 2> /dev/null > ${file}
> +	# shellcheck source=3Dlib/setup_python.sh
> +	. "$(dirname "$0")"/lib/setup_python.sh
> +	$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=3D30 2> /dev/nul=
l > ${file}

Will this test fail because script_path still points to the old legacy
script? The new python module was added to tools/perf/python/ instead of
tools/perf/scripts/python/.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D32
