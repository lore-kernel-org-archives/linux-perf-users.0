Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325836606E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140545; cv=none; b=oCdFMH5oZ6eaT++GyhLmhLszeTdzcUQjPt2MJZPPuOmAstnP5wQKSNyyNV00bfUAxo3gv8o85FPT5lv+yAQoezZLT6ft+EOpR3AdzLbsSYr34g20QQrKCHfLi283ocXbq7VziMwVqFsFCQow1YS+Ijo5EeGBBnS7lf2WZ22ZwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140545; c=relaxed/simple;
	bh=zsaz+GZqRbnPtlBCpoq9DXseyqKXyo0VvEtBKu0B+7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LtYOyhyhp4Eft7qYz46xKnohaLiHhGxt/TLZazbvpea3a/xbv+Iptyaid4Azg9PYyUpQgz99YeWwJBrVj1NouTi3PvjXiiDI1ehwKKzPwrYXmhtmCWc8AmPn/egk4Cm4jLT2X8U7O+NYcr0kAfd5pOCN/7O6I97Lg0W9+YMjlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESHS1VKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESHS1VKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317B9C2BCB0;
	Sat, 25 Apr 2026 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140544;
	bh=zsaz+GZqRbnPtlBCpoq9DXseyqKXyo0VvEtBKu0B+7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ESHS1VKNsBhHfQ9+ZrN7zQgLk/6YFp4XJJxjw5bKY0fEsMZGodflD/GRwpaBeBGrU
	 3BwpSSlazQVx6aSpSgoIsfZ/ZKroI/BYva8w90laFPLQXH8DchHpZTp187wV/AIxGL
	 Dv8s3umBpWHK3BvTd5mU8zLHBL7eglccZkVtepFRjTN1/oDfENMzXKx7L8AaQ8u56r
	 YN8XvVpki2W1WONQ/Z4l2Gzrq+dXYnAlZYqsJOf+HbBLU9yAueX5tmOm4qYYknZHVr
	 bznscWJXAfp8OD8gCWeFzj026POU9Fs2EbMjvJzV5rdDafapuojdtmpmwJjX66YyZK
	 Ys/XL7dPzHPkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 42/59] perf powerpc-hcalls: Port powerpc-hcalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-43-irogers@google.com>
References: <20260425174858.3922152-43-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:09:03 +0000
Message-Id: <20260425180904.317B9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The ported powerpc-hcalls script incorrectly tracks hypercall st=
ate by `sample_pid` instead of CPU or thread ID, corrupting statistics for =
multi-threaded virtual machines.
- [Medium] The powerpc-hcalls script attempts to access a non-existent `sam=
ple.time` attribute, causing an AttributeError that aborts event processing.
--

commit af2c8e27d359ae456d9222ea9cdb2ce0d235611b
Author: Ian Rogers <irogers@google.com>

perf powerpc-hcalls: Port powerpc-hcalls to use python module

This commit ports the powerpc-hcalls script to use the perf python module.
It refactors the script to use a class structure and tracks hypercall
entry/exit to calculate duration and aggregate statistics.

> diff --git a/tools/perf/python/powerpc-hcalls.py b/tools/perf/python/powe=
rpc-hcalls.py
> new file mode 100755
> index 000000000000..c4fa539174c9
> --- /dev/null
> +++ b/tools/perf/python/powerpc-hcalls.py

[ ... ]

> +class HCallAnalyzer:
> +    """Analyzes hypervisor calls and aggregates statistics."""

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid

Will using sample_pid (which corresponds to the Thread Group ID) cause
statistics to be corrupted for multi-threaded virtual machines?

Since QEMU uses multiple vCPU threads under a single process, concurrent
hypercalls from different vCPUs might share the same sample_pid and
overwrite each other's entry state in self.d_enter.

Should this use sample.sample_tid or CPU ID to track individual threads
instead?

> +        time =3D sample.time

Does the perf Python API expose the timestamp as sample.time?

Looking at the perf Python extension, the timestamp is typically exposed as
sample.sample_time. If the time attribute doesn't exist, will it raise
an AttributeError and cause the script to fail on the first event?

> +        opcode =3D getattr(sample, "opcode", -1)
> +
> +        if opcode =3D=3D -1:
> +            return
> +
> +        if name =3D=3D "evsel(powerpc:hcall_entry)":
> +            self.d_enter[pid] =3D (opcode, time)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D42
