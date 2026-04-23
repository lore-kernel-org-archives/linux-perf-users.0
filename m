Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFE23EAA6
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917567; cv=none; b=Hmnsy6yYCkAS9igbA+3gFyPDUtZjNuOco+KLljmlzDM29x1BIe2pNkmuTTXBC3vPvwbd11c7r3LiTvXm85SqLOLLDKAG5dWIh2BFDb4m8dXdWOqtSB93dAbjfvBA5nrY6zSAfHGdASFUncqSXxt6ucht/LQsQ+g6iWSCyCya3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917567; c=relaxed/simple;
	bh=gjL6ZVR0Z9em677MEnptlzNHFAm7Ede8+Df/CB7ny88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XXXyLy4acSYgmr1fLq0CyfmDrcZCk0ALanUgXutV8whe8vgVBh6/0TVBO2TJba76EB3i/W/K+4IGrFnqQesBkuo2TmCoFC8O8KGyA1WJrpiEHHBLm1oKtY3ODVcMTmDbb/MEkYeFgLy0pq+lXtZYGk/W1I6sR/whqF2+S2xtAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGURLX7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGURLX7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2BCC2BCB2;
	Thu, 23 Apr 2026 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917566;
	bh=gjL6ZVR0Z9em677MEnptlzNHFAm7Ede8+Df/CB7ny88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vGURLX7ZZRPHgL3ttqc0+2INPDOUiZgt7fobaU5PzVhT8UO8BXXTZA765ICJqTVio
	 QU/mmgTzaHcOFtIOLBswvbnxry9yV92x8BCrxXdH7/N2RU5/MdcbgcuxqQKdMfr9Hd
	 37EB//ZRLhU5AwK18Sx351rm9oPDOA3gdHhWEBuO/jFA5Nq68EaFpgl/3MUaKZexy9
	 rn6HjMHwA+B3+Tj8rff8Tag9BLasXdkKl7xclpL6sMkPrMIr7ouSwIqvLbnCiDh7Ps
	 oUpa5eDxKy05PjaAtBo34gTRfNyUizjFdjoVpmoms+kco8ddxCSv5k7LJWNUQSsSlP
	 mjWj47DjD3cfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 38/58] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-39-irogers@google.com>
References: <20260423035526.1537178-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:12:46 +0000
Message-Id: <20260423041246.AD2BCC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Calling `self.session.process(pid)` can raise an unhandled `TypeEr=
ror` if the thread is not found, terminating event processing prematurely.
- [Medium] The refactored script fails to group output by syscall, causing =
the `syscall: <name>` header to be printed redundantly for every distinct e=
rror code.
- [Medium] The script no longer sorts the error counts by occurrence freque=
ncy.
- [Low] The `self.unhandled` dictionary tracks unhandled events but is neve=
r used or printed.
--

commit ea714362c33707f9c91e8b539107f9364d4a3bf9
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls-by-pid: Port failed-syscalls-by-pid to use python modu=
le

This commit ports the failed-syscalls-by-pid script from the legacy Util
library to the perf Python module API. It uses perf.syscall_name() for
resolution and standard dictionaries for aggregation.

> diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/pyt=
hon/failed-syscalls-by-pid.py
> new file mode 100755
> index 0000000000000..1a8c9bb7e90c4
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls-by-pid.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        event_name =3D str(sample.evsel)
> +        if "sys_exit" not in event_name:
> +            return
> +
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.process(pid).comm()

Can self.session.process(pid) raise a TypeError here if the thread is not
found?

If a thread is untracked or short-lived, the C extension in
tools/perf/util/python.c:pyrf_session__process() raises a TypeError. Since
there is no try/except block here, this exception will cause the C extension
to return -1 and immediately abort the underlying
perf_session__process_events() loop.

> +        else:
> +            comm =3D "Unknown"
[ ... ]
> +        ret =3D getattr(sample, "ret", 0)
> +        if ret < 0:
> +            syscall_id =3D getattr(sample, "id", -1)
> +            if syscall_id =3D=3D -1:
> +                syscall_id =3D getattr(sample, "sys_id", -1)
> +
> +            if syscall_id !=3D -1:
> +                self.syscalls[(comm, pid, syscall_id, ret)] +=3D 1
> +            else:
> +                self.unhandled[event_name] +=3D 1

This isn't a bug, but the unhandled dictionary is populated here and never
used or printed in the print_summary() method.

> +    def print_summary(self) -> None:
> +        """Print aggregated statistics."""
[ ... ]
> +        print(f"{'comm [pid]':<30}  {'count':>10}")
> +        print(f"{'-' * 30:<30}  {'-' * 10:>10}")
> +
> +        sorted_keys =3D sorted(self.syscalls.keys(), key=3Dlambda k: (k[=
0], k[1], k[2]))

Does this sort the output incorrectly compared to the original script?

The original script sorted the error counts for a given syscall in descendi=
ng
order by frequency. This sorts only by the dictionary keys, ignoring the
actual error counts stored in the values.

> +        current_comm_pid =3D None
> +        for comm, pid, syscall_id, ret in sorted_keys:
> +            if current_comm_pid !=3D (comm, pid):
> +                print(f"\n{comm} [{pid}]")
> +                current_comm_pid =3D (comm, pid)
> +            try:
> +                name =3D perf.syscall_name(syscall_id) or str(syscall_id)
> +            except AttributeError:
> +                name =3D str(syscall_id)
> +            print(f"  syscall: {name:<16}")
> +            err_str =3D strerror(ret)
> +            count =3D self.syscalls[(comm, pid, syscall_id, ret)]
> +            print(f"    err =3D {err_str:<20}  {count:10d}")

Will this print the syscall name header redundantly for every distinct error
code?

The loop tracks current_comm_pid to avoid redundant process headers, but it
doesn't track the current syscall_id. If a single syscall returns multiple
different error codes, the syscall name header will be printed for each one.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D38
