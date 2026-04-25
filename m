Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C40179A3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140517; cv=none; b=U3qm9aHoyvr1W9nGU1w9TNxnFHNnwADHbf3sXyKuPjiOHmFt+IEMMgOdy+q0TkVXuaLekVeWHIdwMGZoLRFc1xpRV7BYvKHZn8WAlR/TVUB8PHWoySkF2tqzTHSE3AVEfF2B+Kq1WVuxUClx6u6faL88/uAr9Znrs1PgLmn4yZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140517; c=relaxed/simple;
	bh=m8wZhLg+VHJJ4tlItIvjO5q2lsu5WZEuUtDrInE1lIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=syKAD2QTRLJ5fWPruEL+4qmR+3peWe/er9+uKmoR7dkTeOBDqWTYaN/tzxcUzG6VK1atRHRZQZQdyaA8ezBBrpAQA/Y31jo942TjMRoZA4eVXzJnWfHuv2VpLLpRIwfQNW+VmnvBrWPCATT0tN7khUJspSPmVbKGI73B5PLwqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrTvgogP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrTvgogP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969A7C2BCB0;
	Sat, 25 Apr 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140517;
	bh=m8wZhLg+VHJJ4tlItIvjO5q2lsu5WZEuUtDrInE1lIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OrTvgogP/vSi7pNdoDiXgt1J4y1URpG8CdpeoK749CD1dOjfc/ia8ujMvWFAInVoZ
	 hbitP8l+UUNcFG6CKay7bqMoegmB2IiN5UCbBsz3Lt1pnqxTUuoKWK//e4DmtwLScN
	 Us0zGnBVvHMJ5q/zBSZ1lwydVduXURZKYn95TCG6QWqn1jdM9seXSt2FZUTNcmaVP7
	 enqgpjsnvnIJEDjrnXDlvv9UYgGZlTDbX2/KObqLEzmypDfaSuvYrAEHlrucb8Av5R
	 ofTrmBB6T/W3ILMi1+o142kCy0XVR4WA5pHHCmbimyLMC5QswP74vpq8U68CzFLSak
	 c7tzyerMg7Qyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 33/59] perf check-perf-trace: Port check-perf-trace
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-34-irogers@google.com>
References: <20260425174858.3922152-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:08:37 +0000
Message-Id: <20260425180837.969A7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The script will crash with an unhandled TypeError if a thread is n=
ot found by session.find_thread().
- [Medium] Incorrect thread lookup using sample_pid instead of sample_tid l=
eads to inaccurate event attribution.
- [Medium] Type hinting with collections.defaultdict[str, int] uses PEP 585=
 syntax, which crashes on module load in Python versions older than 3.9.
--

commit 4e0bca6abdc96a8b064133ab4674a7ddb85d72dd
Author: Ian Rogers <irogers@google.com>

perf check-perf-trace: Port check-perf-trace to use python module

This commit ports the check-perf-trace script to directly use the perf pyth=
on
module. This avoids creating intermediate dictionaries for all event fields,
making execution significantly faster than using perf script callbacks.

> diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/ch=
eck-perf-trace.py
> new file mode 100755
> index 000000000000..7c1c7632a091
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

Will this syntax cause a module load crash on older Python versions?=20

Subscripting standard collections directly for type hints was introduced
in Python 3.9. On older versions, like Python 3.6 or 3.8, this raises a
TypeError indicating the type object is not subscriptable, which prevents
the script from running.

[ ... ]

> +def print_header(event_name: str, sample: perf.sample_event) -> None:
> +    """Prints common header for events."""
> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000
> +    comm =3D session.find_thread(sample.sample_pid).comm() if session el=
se "[unknown]"

Are we looking up the correct thread for the event here? By passing
sample.sample_pid, which corresponds to the process ID, instead of
sample.sample_tid, we might systematically look up the main thread
instead of the specific secondary thread that triggered the event.

How does the script handle threads that are not found?

Looking at pyrf_session__find_thread() in tools/perf/util/python.c,
failing to locate a thread results in a Python TypeError being raised.
Since there is no try/except block around the find_thread() call,
encountering an unknown thread (which can happen with ring buffer
overruns or dropped events) could cause the script to immediately crash.

> +    print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D33
