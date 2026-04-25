Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B035AC0B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140475; cv=none; b=gmwOYyPYlskD5kG78OxaN0O4AaANKLbZnKkcxkaoEY7Se/RoyI7MDXMYXRd2I6jbChmTn/wS6TSd/elA8M9HYmafmXZaUR7Ij3UwCuAdUYwrGqyQOxiwI0TxqI6rEnNXMcejf2vdMU00ZSRf1bfJHf5KekFaZFewirpcpctDYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140475; c=relaxed/simple;
	bh=TmqQjvLdoxuCv05YmK1d4pk+n5UyjJUuTw6Vc1LPTyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a1FPWvjpjRxFT7hkgNr98sDt64StlUW/ZiqL+yQL4I1RC9sd7INxzJ2o8ECtFqcu4idCO0dU38ohmLtjfKeRqhHXScond/Os3FnWZwz62SVqHFKeeE5kQ2Td0BOVnzdUednWpb81kznHXlHeHkbwB1aCYSGiThtbyIvy1KhORAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVoQjbBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVoQjbBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9220AC2BCB0;
	Sat, 25 Apr 2026 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140474;
	bh=TmqQjvLdoxuCv05YmK1d4pk+n5UyjJUuTw6Vc1LPTyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YVoQjbBrI6QSj7F5QPvOzw2cYqlDLAFhiUXASpbuueb5p92azW5WZGGgWsuU2wAoo
	 0SIwWM3zU2S+ZcdQPQ22STYamdFbDkR6GRaCOR/LQyEHF1NHTOfh/ScnEXJ76BzMhP
	 o5Jnjh3F/1n+eAWjlbfQUzh0Z8rfcbl/IIbRhGZyR56BOYc6VU/XaoakNwcx0i/cTp
	 p+/9KWnr/Ic0605tUVIloYf2LBSyEBfpuZhfYuTDNbNDS/LhT/wll6Fgal4GiV8649
	 E6cqW6FBEG7NaVymALWmzw1fUUkh2nTZqWuPVTq5AkBChQl1JILCVnlKfO4+9oSf20
	 z0cPIiXubGO6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/59] perf stat-cpi: Port stat-cpi to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-26-irogers@google.com>
References: <20260425174858.3922152-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:07:54 +0000
Message-Id: <20260425180754.9220AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] In live mode, `store()` incorrectly subtracts previous values from=
 `counts` that are already computed as deltas, resulting in invalid (often =
negative) counter and multiplexing scaling values.
--

commit e4c0de46cf600fa6527454dc5cc7c9aea1ab53f1
Author: Ian Rogers <irogers@google.com>

perf stat-cpi: Port stat-cpi to use python module

This patch ports stat-cpi.py from the legacy framework to a standalone scri=
pt
that supports both file processing and live mode. It accumulates cycles and
instructions to calculate and display Cycles Per Instruction per interval p=
er
CPU or thread.

> diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
> new file mode 100755
> index 000000000000..4b1f1f69c94a
> --- /dev/null
> +++ b/tools/perf/python/stat-cpi.py

[ ... ]

> +    def store(self, event: str, cpu: int, thread: int, counts: tuple[int=
, int, int]) -> None:
> +        """Store counter values, computing difference from previous abso=
lute values."""
> +        self.store_key(cpu, thread)
> +        key =3D self.get_key(event, cpu, thread)
> +
> +        val, ena, run =3D counts
> +        if key in self.prev_data:
> +            prev_val, prev_ena, prev_run =3D self.prev_data[key]
> +            cur_val =3D val - prev_val
> +            cur_ena =3D ena - prev_ena
> +            cur_run =3D run - prev_run

Does this subtraction work correctly for both file and live modes?

In file mode, PERF_RECORD_STAT events provide cumulative, absolute values, =
so
taking the difference here extracts the interval delta correctly.

However, in live mode, read_counters() calls evsel.read(). The Python perf
extension (pyrf_evsel__read in tools/perf/util/python.c) already computes
and returns the delta since the last read.

If counts already contains the interval delta in live mode, won't subtracti=
ng
prev_val here effectively calculate current_delta - previous_delta, leading=
 to
invalid or negative values?

Also, since the run delta is typically constant across intervals, wouldn't
cur_run become near zero and break the multiplexing scaling math in get()?

> +        else:
> +            cur_val =3D val
> +            cur_ena =3D ena
> +            cur_run =3D run
> +
> +        self.data[key] =3D (cur_val, cur_ena, cur_run)
> +        self.prev_data[key] =3D counts # Store absolute value for next t=
ime

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D25
