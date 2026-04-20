Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F393A1C9
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645754; cv=none; b=cimihPLd0D4wWY3QG6UGEAr52SYBa+X2AHI0OwbFdF9CnYiytyzWN+7mfDvhH7PKRX7ZpY15aJDUJ/Vwid/79ZE3JtCx9eDqElitEHvkg3elOmq8R+RB5PmwiPvbLCF+uOCCql8i0APWJd6IdFA99wpHKtF2b3lwWMJYmBqWzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645754; c=relaxed/simple;
	bh=5Oi0XFlYX29NLKN4pyGyeU6WguXiZYYWiPZULg3qMKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AXbij98z6T4nMR612Mn06PWOsGV8FA2C3YfEwAMNvqnt7jL5+8cIwqW/U7f9tUCoLgNhyLbAmgopNFGKGEyyrjMAB7FIUUe1AeUXW9dM8dkxNpC8+5yDkh7A6EDVMb6HiaUJ49a5H+957s5IuIWvhyCg8Yp8Mprjp+nLq1wLzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QamUyTfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QamUyTfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12100C2BCAF;
	Mon, 20 Apr 2026 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645754;
	bh=5Oi0XFlYX29NLKN4pyGyeU6WguXiZYYWiPZULg3qMKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QamUyTfm1HqiFloM+gh/f7kOSXK+TnZtLnHKfvvaZ7EoRhhBDPTsTmyVtGUmj99Ig
	 MF0GVXfh2ZooBixRHgRWAmh7m8HGScU5F/fI+DBWKvQ9WgLib2/8BZHh1Ubt81FxIN
	 31RK05ZAJPFdgUVLzhLygAVInTeaD8gv3U51HJ/AxXTlSLIynmB5ZipPStVvL9nIni
	 C7ZhE9m61rfhi3D45iAOVDo35Wve3LowsSMqNpEok6tyMWHx6CLvZ8+iKTCuDdw89U
	 s7FQWewA3+HZNC/ONeq2ZyPB9QW3nDEJjVmoeBF9hsC9qALKf1zNb8Vng7jrM6SZkI
	 A8ahmSnHkgVFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 50/58] perf rwtop: Port rwtop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-51-irogers@google.com>
References: <20260419235911.2186050-51-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:42:33 +0000
Message-Id: <20260420004234.12100C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Loose substring matching for tracepoint names matches unrelated =
syscalls and desynchronizes operation counts from byte counts.
- [Medium] Hardcoded ANSI clear-screen escapes combined with event-time flu=
shing breaks offline processing.
- [Medium] Writes track requested bytes instead of actual bytes written, le=
ading to incorrect accounting.
- [Low] Error tracking dictionaries are populated but never used or display=
ed.
--

commit 2f7b010334a549f6b163fe08533ebb5646479da4
Author: Ian Rogers <irogers@google.com>

perf rwtop: Port rwtop to use python module

This commit ports the legacy Perl script rwtop.pl to a python script using
the perf module in tools/perf/python. It uses a class-based architecture to
periodically display system-wide r/w call activity, broken down by PID.

> diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
> new file mode 100755
> index 0000000000000..e895b34b71147
> --- /dev/null
> +++ b/tools/perf/python/rwtop.py

[ ... ]

> +        if "sys_enter_read" in event_name:
> +            self._handle_sys_enter_read(sample, pid, comm)
> +        elif "sys_exit_read" in event_name:
> +            self._handle_sys_exit_read(sample, pid)
> +        elif "sys_enter_write" in event_name:
> +            self._handle_sys_enter_write(sample, pid, comm)
> +        elif "sys_exit_write" in event_name:
> +            self._handle_sys_exit_write(sample, pid)
> +        else:
> +            self.unhandled[event_name] +=3D 1

Will this loose substring match catch unrelated syscalls like
sys_enter_readv?

If sys_enter_readv is caught, it lacks a count field, which raises an
AttributeError in _handle_sys_enter_read() that is silently caught. But
sys_exit_readv has a ret field, so _handle_sys_exit_read() will add to
bytes_read without incrementing the read count.

Does this lead to desynchronized operation counts from byte counts, and
hide these unhandled variants from the unhandled events dictionary?

[ ... ]

> +    def _handle_sys_enter_write(self, sample: perf.sample_event, pid: in=
t, comm: str) -> None:
> +        try:
> +            count =3D sample.count
> +            self.writes[pid]["bytes_written"] +=3D count
> +            self.writes[pid]["total_writes"] +=3D 1
> +            self.writes[pid]["comm"] =3D comm
> +        except AttributeError:
> +            pass
> +
> +    def _handle_sys_exit_write(self, sample: perf.sample_event, pid: int=
) -> None:
> +        try:
> +            ret =3D sample.ret
> +            if ret <=3D 0:
> +                self.writes[pid]["errors"][ret] +=3D 1
> +        except AttributeError:
> +            pass

Does this code incorrectly track requested bytes instead of actual bytes
written?

For reads, bytes_requested and bytes_read are separated, but here
bytes_written uses the requested count and ignores sample.ret on successful
writes, which might overcount partial writes.

This isn't a bug, but it looks like the error tracking dictionaries are
populated here and in _handle_sys_exit_read(), but never used or displayed
in print_totals().

[ ... ]

> +    def print_totals(self) -> None:
> +        """Print summary tables."""
> +        # Clear terminal using ANSI escape codes
> +        print("\x1b[H\x1b[2J", end=3D"")

The commit message states this is "robust for file-based processing", but
does the combination of event-time flushing and hardcoded ANSI clear-screen
escapes break offline processing?

When parsing an offline perf.data file, the processing happens at CPU speed,
which will instantly clear the terminal for every interval and only leave
the final output visible, or garble the output if piped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D50
