Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902463E51E3
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050818; cv=none; b=e8PEbXWC9djSTmQa43yoU+tHqxKpf7nR0vSdJF5EZoofvV/TNxhuv+cH5cZtYTTFggUsbIjlWpVqUD9DoOBPm9OAEZ0ZklppMzFSJU9S5s3xvJSAFYcTUG8y5WpupMG0uiaLYy0tkpxy/uZv+5/nb4ut0CUPSQICGb27PizwhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050818; c=relaxed/simple;
	bh=41WsabH2a+lyN52Kaht85txwrGWscX5FiN6qPXG2IrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vu2vPOq1VWo71AIOqlxI27Pm1jLw7XTrIxUba5nU8+tnTALIlsdyGhbzsv9Rc250grrjj6Fey7rNAe0LtPvXtSCIkGVvdSZCrmAfISucWdqe0JoJYgSW3rfNeyejdnw8pa5WYdjQ//cCVf6wpnx8nz4Bk/UzOGx04hzXSa34Ysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvHgCFMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvHgCFMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5FFC2BCB5;
	Fri, 24 Apr 2026 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050818;
	bh=41WsabH2a+lyN52Kaht85txwrGWscX5FiN6qPXG2IrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JvHgCFMDLfO0CeSXC1JtslMKY9Zkuu1rtfwmkveHa9a+BuCebx50qtAlebbPdzcFh
	 YrsbGKIzxgQgDZYjMMuU96YOS9M10RcuRD8d0R+5f2jfRvD/Hy0H1nvVckS9/1FlQh
	 L+jeCLPaBg1/fgu6PbyjFGL05SyiyKkpjxcBRcB/O9lyni1sOKQARDQr4bwIYiGxpR
	 au2RNXnKBfl63RXirZxUtlNDa+6fQMC9LjsGzI1RV9KgtGmtqglOc3jhzTJGlGvtz/
	 cPITrylcZ12LJVQ9XgXacpy05215aIsZR7f6knOoGV7L/D/yrIlMBqFSR5vXd6eZKQ
	 8/Wu8B+0vwuvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 27/58] perf syscall-counts: Port syscall-counts to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-28-irogers@google.com>
References: <20260424164721.2229025-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:13:37 +0000
Message-Id: <20260424171338.3E5FFC2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The script is vulnerable to crashes from unhandled `OverflowError`=
 and `SystemError` exceptions when processing malformed or edge-case trace =
data.
- [Medium] The script uses strict string equality for event names, causing =
it to drop events recorded with modifiers (e.g., :k or :u).
- [Medium] The script drops support for the generic `syscalls:sys_enter` fa=
llback event, breaking compatibility with older environments.
--

commit a62a8fdbc0cd35bc8b0e51cb5929e23578afa7d5
Author: Ian Rogers <irogers@google.com>

perf syscall-counts: Port syscall-counts to use python module

This commit rewrites the tools/perf/scripts/python/syscall-counts.py script
to use the Python module directly. This avoids the overhead of executing via
perf script, improving performance significantly.

> diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/sysc=
all-counts.py
> new file mode 100755
> index 00000000000000..cdeae6c1e9f912
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts.py

[ ... ]

> +def print_syscall_totals():

[ ... ]

> +    for sc_id, val in sorted(syscalls.items(),
> +                             key=3Dlambda kv: (kv[1], kv[0]), reverse=3D=
True):
> +        name =3D perf.syscall_name(sc_id) or str(sc_id)

Can perf.syscall_name() raise an OverflowError if tracepoint parsing fails
and sc_id ends up holding the 64-bit generic perf event ID from the
getattr(sample, "id", -1) call?

The C extension expects a 32-bit integer, and an uncaught exception would
crash the script.

> +        print(f"{name:<40} {val:>10}")
> +
> +
> +def process_event(sample):
> +    """Process a single sample event."""
> +    event_name =3D str(sample.evsel)
> +    if event_name =3D=3D "evsel(raw_syscalls:sys_enter)":

Is it possible for events recorded with modifiers (like
perf record -e raw_syscalls:sys_enter:k) to be missed here?

The exact string match would evaluate to false for
evsel(raw_syscalls:sys_enter:k) and silently ignore valid events.

> +        sc_id =3D getattr(sample, "id", -1)
> +    elif event_name.startswith("evsel(syscalls:sys_enter_"):

Does this condition break compatibility with older environments that use the
generic syscalls:sys_enter fallback event?

The trailing underscore in the startswith() check prevents matching the base
event evsel(syscalls:sys_enter), causing these fallback events to be
dropped.

> +        sc_id =3D getattr(sample, "__syscall_nr", None)
> +        if sc_id is None:
> +            sc_id =3D getattr(sample, "nr", -1)
> +    else:
> +        return
> +
> +    if sc_id =3D=3D -1:
> +        return
> +
> +    comm =3D "unknown"
> +    try:
> +        if session:
> +            proc =3D session.process(sample.sample_pid)
> +            if proc:
> +                comm =3D proc.comm()
> +    except (TypeError, AttributeError):
> +        pass

Could proc.comm() trigger a SystemError if a thread lacks a resolved command
string?

If thread__comm_str() returns null, passing it to PyUnicode_FromString()
in the C extension natively raises a SystemError in CPython, which is not
caught by the current except block.

> +
> +    if for_comm and comm !=3D for_comm:
> +        return

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D27
