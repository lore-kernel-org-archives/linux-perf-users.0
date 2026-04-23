Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1678F49
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917952; cv=none; b=ELq4u189rqQQ1y0SKXutqcXpOoOe/EnweME3IvgSyWFRJ7kSCz5nMV868PE1O9wO0WQ3/N2Yz5Z9dhfR4CvDsBsca9U6a0yRkKLmen35inzfASVq+On3VXPRC8g+KOCbQvzqCDC9bN7Og9mjVAIzm13S3mLVWhimAsxv/JetnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917952; c=relaxed/simple;
	bh=6CW48ocJplWKqrx00OM03/9eGei/anctY14mW35sKW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HaijzQVjt3ZlCi0WJclD7tORgFBTEL6Wuys8pPARyHxHjfzOav2iTzad/rwoWgGap9qMYy9fmaZic4voML90f1rvdJv/fAeYxFL+uMnKUX5srx1oKEe4Ffs4pqh8H+4PN+mHVw5NR9gATviXvus5lKYl/cxSvF47URpvdcUODX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHWxafkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHWxafkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58EBC2BCB2;
	Thu, 23 Apr 2026 04:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917951;
	bh=6CW48ocJplWKqrx00OM03/9eGei/anctY14mW35sKW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qHWxafkSgBMALOmqClKdt8hSNRz78vLf7Of/E1AA9k82m/5ZFcuBCN56N7Qfy9+0s
	 9vLqssIaH5AUkA8Oe9IKrYxkkX4nFwhSwZKXAicLpIdK+TP9jMwsW6W0OaIpcpNlmQ
	 6c8cPC/7fmw0z+Efi5qx0K2VXfaTgFdEw0OjyTjwRRrjYo5lJ7Z9AJCl+vQ/Uyy00a
	 FRGppPtBHXa60LMppOBSu9YgS4qj4s1IJ7FQd8FT1nihUdlZyqJA8mG+WxXVc0I1hA
	 hZtScI+EIObnlwFVWHwPcZD3kpLSApej5XWRTgocqHoDU/vI88iB7y2OuQuSmNjetL
	 gtG+AfyDf/g8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 47/58] perf failed-syscalls: Port failed-syscalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-48-irogers@google.com>
References: <20260423035526.1537178-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:19:11 +0000
Message-Id: <20260423041911.B58EBC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The script silently ignores `raw_syscalls:sys_exit` events due t=
o an incorrect prefix check.
- [Low] The `self.unhandled` dictionary is populated but its contents are n=
ever used.
--

commit 00a5944d7233719afa6bbf8555838ae7c50160e8
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls: Port failed-syscalls to use python module

This commit ports the legacy Perl failed-syscalls script to Python. It uses
the perf.session API to filter for sys_exit events, track failed syscalls,
and aggregate the counts per command name.

> diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/fai=
led-syscalls.py
> new file mode 100755
> index 0000000000000..178c1458430a2
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls.py
[ ... ]
> +class FailedSyscalls:
> +    """Tracks and displays failed system call totals."""
> +    def __init__(self, comm: Optional[str] =3D None) -> None:
> +        self.failed_syscalls: dict[str, int] =3D defaultdict(int)
> +        self.for_comm =3D comm
> +        self.session: Optional[perf.session] =3D None
> +        self.unhandled: dict[str, int] =3D defaultdict(int)

This isn't a bug, but self.unhandled is populated during event processing b=
ut
never printed or accessed later. Is this dictionary intended to be included
in print_totals()?

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process sys_exit events."""
> +        event_name =3D str(sample.evsel)
> +        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
> +           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):
> +            return

Does this incorrectly drop raw_syscalls:sys_exit events? The string
representation of the generic tracepoint is evsel(raw_syscalls:sys_exit)
which does not have a trailing underscore. Because of this, the startswith
check evaluates to false and triggers the early return.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D47
