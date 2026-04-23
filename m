Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7C8F49
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918021; cv=none; b=BRrnFLp6kooJYcJ1zkZQceOkYTDc58aaCibwWFeUDbVgLhyRNlhSpJ8WzNdVT2DAC8pYDY9hMtATqnqeqpXTM1z6iG9x6WPaLUd4SFWHjDkpw7m1pREEuz8PAy2L1uo8IrLwVS45pr7xYLBmWbn/zMiMaUuaAiDT0VQoCXNcN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918021; c=relaxed/simple;
	bh=ryUbI6WDceqh22H8TJ+1Yb6Ukgl0mycENVAKkbqBwdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZmBFITHsAjEu2M1+KOCINd3FxLWFzJNdvr9X4iVSvOVGcMWIFwOKL6Co5Jlxs0uBoTmxlL65qfz1DIiQ0i92nkgt/Fi40CL2lyuMnITnk9OKajeFfNCDzC1v8sfIQHC5cMUHAu8I41yjdi05DdwYSBf+L5yGMOnBPMR6BhtN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV1VVFAi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV1VVFAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CA8C2BCB2;
	Thu, 23 Apr 2026 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918021;
	bh=ryUbI6WDceqh22H8TJ+1Yb6Ukgl0mycENVAKkbqBwdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NV1VVFAihvRUhZXsPQZDs+C3BtMDGbIZieE0lBvgEqNIXd9hjAfdfzPJdCVCm2iib
	 PuK4OloYTx6WQz9iasla/AGErmiyuMKoqyZMKE92YIXXA8oKhMQGRuFpRajiuAX/Z7
	 OSkshnWzkdCW4sI2BLP6SYF1IJNepWrgJp+GA8LkMSBBA1mQVQTaW4IRik1A3rsmpH
	 7TmDIefVPFQi7mP23or6pBQMev9SL/9RLELtdWLiqzfQaTHDwRUweFKdvHJc4/NQtI
	 4Hd1y9bfKVPvJ7hzqc9E93Iqq4HA8o/byEpwIetzON4MbSovEYCESyI1f9Y7nqP2uU
	 jeBz0dz2pq6mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 44/58] perf sctop: Port sctop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-45-irogers@google.com>
References: <20260423035526.1537178-45-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:20:20 +0000
Message-Id: <20260423042021.74CA8C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Live mode process filtering is broken due to non-existent `comm` a=
ttribute on sample events.
- [High] Offline mode interval reporting is non-functional due to incorrect=
 timestamp attribute and timer starvation.
- [Low] Outdated hardcoded usage message contradicts standalone script exec=
ution.
--

commit abb433706222dd69bc39b0037938568f893314f9
Author: Ian Rogers <irogers@google.com>

perf sctop: Port sctop to use python module

This commit ports sctop.py from tools/perf/scripts/python/ to
tools/perf/python/, refactoring it into a class-based structure. It also ad=
ds
support for live mode using LiveSession when no input file is specified.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 0000000000000..d7ac922da510c
> --- /dev/null
> +++ b/tools/perf/python/sctop.py
[ ... ]
> @@ -0,0 +1,174 @@
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect syscall events."""
> +        name =3D str(sample.evsel)
> +        syscall_id =3D getattr(sample, "id", -1)
> +
> +        if syscall_id =3D=3D -1:
> +            return
> +
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.process(sample.sample_pid).comm()
> +        else:
> +            comm =3D getattr(sample, "comm", "Unknown")

Are we sure the sample object has a comm attribute in live mode?

Since perf.sample_event objects do not natively possess a comm attribute,
it looks like this will always evaluate to Unknown. If a user specifies a
process to filter via the command line, the filter condition will always dr=
op
the events because Unknown won't match the requested process name.

> +
> +        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys=
_enter)"):
> +            if self.for_comm is not None and comm !=3D self.for_comm:
> +                return
> +            with self.lock:
> +                self.syscalls[syscall_id] +=3D 1
> +
> +        if self.offline and hasattr(sample, "time"):

Does the C extension export the timestamp field as time, or is it sample_ti=
me?

If the attribute is actually sample_time, hasattr(sample, "time") will alwa=
ys
be false, preventing offline periodic updates from being printed.

Additionally, this timer update block is placed after the early returns for
unmatched events.

If the monitored process goes idle while other processes continue generating
events, will the offline timer freeze and prevent steady periodic updates?

> +            interval_ns =3D self.interval * (10 ** 9)
> +            if self.last_print_time is None:
> +                self.last_print_time =3D sample.time
> +            elif sample.time - self.last_print_time >=3D interval_ns:
> +                self.print_current_totals()
> +                self.last_print_time =3D sample.time
[ ... ]
> +def main():
> +    """Main function."""
> +    ap =3D argparse.ArgumentParser(description=3D"System call top")
> +    ap.add_argument("args", nargs=3D"*", help=3D"[comm] [interval] or [i=
nterval]")
> +    ap.add_argument("-i", "--input", help=3D"Input file name")
> +    args =3D ap.parse_args()
> +
> +    for_comm =3D None
> +    default_interval =3D 3
> +    interval =3D default_interval
> +
> +    if len(args.args) > 2:
> +        print("Usage: perf script -s sctop.py [comm] [interval]")

This isn't a bug, but since the script was ported to a standalone executable
using argparse, this usage message seems outdated and contradicts the new
execution model.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D44
