Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BB946C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645135; cv=none; b=j8rtMdqpXiUoTx/bPQ69swqFF6UmUIg/yj3c1zdAHMso0HKXbj2aBb8hQ7IWOMGY1F9lMpyfMup9fiXIT7Iv/MZpPp0Y91auXcDMMhYAayRTGeUKCho7hjsdjhd3imxWYL7WQ1M0+idX0E8hRkoycNJ5gi3xk+SAAbg3LfVJVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645135; c=relaxed/simple;
	bh=pWcLhDqg6Oo4J7R+6oaWaO6uncd5MDVKZI29pHq0rRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qsi1mYci3iZhPH14ktP7LgHeaH/owHCzEEJ5YfAHbELdGzW7TuvN5r1rveyWF/nkk9TvKD5ekFWQEag4Qp7kN/rq5aRPKlybJTdfdI2d6l1xB4dHXwL1B/ckQhaDf8CZmkl5Q8zxccNu04Nxp8kzao267DoQZZdfGppfwOFOCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZZOeG4D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZZOeG4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C212C2BCAF;
	Mon, 20 Apr 2026 00:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645134;
	bh=pWcLhDqg6Oo4J7R+6oaWaO6uncd5MDVKZI29pHq0rRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VZZOeG4DZo75U5/FVJsRcOqoFK/Dwv44WuiJpiIYfPycx10V6emNVINTlyjjBg6hW
	 +gHwgG0lkeyWHCHsB+zRtgjRZEQf/Of8qpUIadUVCmdUKel6KaiO+2C38FdPP9v7Qe
	 cnhTVvfcNHbVhgLuDHpb8kH7rjr5/yLaR73hh9DHrI6JJX+uZz3aXbGKjY7v4cuZVh
	 gYFDLywQ06LLIttoZeh8WoacE4jNnHTfMkai2S3RfZIHgQcJ8JnFqCMA66s0CW7QeL
	 0xCVk5jMx9lPv3m8JGfYeRIwadKHTffjvMM5bBYLxa6STnOC8npzngtcWtoQA+yOSy
	 ypumNnNX6YnvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 38/58] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-39-irogers@google.com>
References: <20260419235911.2186050-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:32:13 +0000
Message-Id: <20260420003214.7C212C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The script attempts to extract the process comm using `getattr(sam=
ple, 'comm', 'Unknown')`, but the new perf Python module does not inject `c=
omm` into the sample object. This causes all events to be aggregated under =
'Unknown', fundamentally breaking the output grouping and causing the `--co=
mm` filter to drop all events.
- [High] Formatting a potentially `None` syscall name with a width specifie=
r causes a `TypeError` crash.
--

commit 9366fa7bfa752a994e4a854653a22852e8debe63
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls-by-pid: Port failed-syscalls-by-pid to use python modu=
le

This commit ports the failed-syscalls-by-pid script to the new perf Python
module API. It updates syscall name resolution, statistic aggregation, error
string lookup, and adds optional COMM/PID filtering.

> diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/pyt=
hon/failed-syscalls-by-pid.py
> new file mode 100755
> index 0000000000000..3873cff947bcd
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls-by-pid.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        if str(sample.evsel) not in ("evsel(raw_syscalls:sys_exit)", "ev=
sel(syscalls:sys_exit)"):
> +            return
> +
> +        comm =3D getattr(sample, "comm", "Unknown")

Does the perf.sample_event object expose a comm attribute in the new Python
API?=20

If it is missing, getattr will fall back to "Unknown" for every event. This
would cause all events to be aggregated together under a single name, and
would drop all events if the comm filter is active.

Should this resolve the comm by querying the session, for example by
calling session.process(sample.pid).comm() instead?

[ ... ]

> +    def print_summary(self) -> None:
> +        """Print aggregated statistics."""

[ ... ]

> +        for comm in sorted(self.syscalls.keys()):
> +            for pid in sorted(self.syscalls[comm].keys()):
> +                print(f"\n{comm} [{pid}]")
> +                for syscall_id in sorted(self.syscalls[comm][pid].keys()=
):
> +                    try:
> +                        name =3D perf.syscall_name(syscall_id)
> +                    except AttributeError:
> +                        name =3D str(syscall_id)
> +                    print(f"  syscall: {name:<16}")

If perf.syscall_name() returns None for invalid or unknown syscall IDs
(such as the fallback -1), will applying a width format specifier (<16) to
a NoneType cause a TypeError and crash the script?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D38
