Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC078C9C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140360; cv=none; b=jGgYx46SaIhMLGGOG8hJofTSvk5HbQrE8NSBRZFBomhpUpb3WqY9G1sQPTIcVMar9MTT+bQcURpSYQSJnFK7lk2U9pojbbLkfxzmT5o0YPoS1d6sJKbyV0kUQ+FaAKR0UXDw93JBPy2zKObljhnld4yWHwA8Jp7HMuR3oX9JOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140360; c=relaxed/simple;
	bh=KCR8CnJbX4AxvU/GdFsmxcsnrdCHU+cDj0/mIJJN1Fw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mc/6zcsKQSs6CBbigcwa4OKA2gVqlFe114Y9C1LBjp+weiiAoelZjbAREob5ABHOJhR7okCPhyex1r0Q/mQYxPXKOkID2kLCnk+qbB86gisuSl6ZMg3uOSQAitkIxzHhJWgdsQWX03F/iHo245S83igiVb3gQjNF4HywVrSska0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAZ5L2YN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAZ5L2YN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89972C2BCB3;
	Sat, 25 Apr 2026 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140359;
	bh=KCR8CnJbX4AxvU/GdFsmxcsnrdCHU+cDj0/mIJJN1Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sAZ5L2YNkwaCHxFGZks6XvCib2SjK1Z/S04cTRf2Rc82xLG3IaIqd4cX+aUd7ceAB
	 37On51OhBnvWRiLmukh/lDVP8/B8mmrQ/ua94N6dpfAuYTbrqpY2cYgrwCl/65opYL
	 86/aL2oHYnxXE3MopCpc5jnLkW/2h9yrgZK0f1DDBpEtaTrmas0BT9k/hpXhbx/9oc
	 jqIe9Du9usODSsPWow0DzLNdviaq/5vjB/jWkzpo1q9aR8cybHlmNicJsHqY9yx7BS
	 I8CTDpCA33XZphMMqqdp953OqY+KxzxwXuXPnas+WpDPitbOEmzT+D6Sz9QnepDXkk
	 6ScPZE8FLIWvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 38/59] perf failed-syscalls-by-pid: Port
 failed-syscalls-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-39-irogers@google.com>
References: <20260425174858.3922152-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:05:58 +0000
Message-Id: <20260425180559.89972C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The script aborts event processing entirely when an unknown pid is=
 encountered because `find_thread()` raises an unhandled `TypeError`.
- [Medium] Output formatting and sorting logic regression: the script flatt=
ens the statistics dictionary, breaking the original script's grouping and =
frequency sorting.
- [Low] Dead state: `self.unhandled` dictionary is populated but never util=
ized.
--

commit eacb529b7da7cf23229d6c50135173dbc91ab92e
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls-by-pid: Port failed-syscalls-by-pid to use python modu=
le

This commit ports the failed-syscalls-by-pid script to the newer perf
Python module API. It updates syscall name resolution, error string
lookups, and adds command-line filtering for COMM or PID.

> - Used standard collections.defaultdict for nested statistics
>   aggregation.

The commit message states the script uses nested statistics aggregation, but
the implemented code defines a flat dictionary. Should this be a nested
dictionary, or should the commit message be updated?

> diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/pyt=
hon/failed-syscalls-by-pid.py
> new file mode 100755
> index 000000000000..f57b13c5d34f
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls-by-pid.py
[ ... ]
> +class SyscallAnalyzer:
> +    """Analyzes failed syscalls and aggregates counts."""
> +
> +    def __init__(self, for_comm: Optional[str] =3D None, for_pid: Option=
al[int] =3D None):
> +        self.for_comm =3D for_comm
> +        self.for_pid =3D for_pid
> +        self.session: Optional[perf.session] =3D None
> +        self.syscalls: dict[tuple[str, int, int, int], int] =3D defaultd=
ict(int)
> +        self.unhandled: dict[str, int] =3D defaultdict(int)

Does the unhandled dictionary get used anywhere else? It appears to be
populated during event processing but is never printed or accessed in the
summary output.

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        event_name =3D str(sample.evsel)
> +        if "sys_exit" not in event_name:
> +            return
> +
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.find_thread(pid).comm()

Can this raise a TypeError if the thread is not found? The perf Python
module's C implementation raises a TypeError when a thread lookup fails,
rather than returning None.=20

If an unmapped thread is encountered, will this terminate the script
prematurely?

[ ... ]
> +    def print_summary(self) -> None:
[ ... ]
> +        sorted_keys =3D sorted(self.syscalls.keys(), key=3Dlambda k: (k[=
0], k[1], k[2]))
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

Since current_syscall_id is not tracked during this iteration, will the scr=
ipt
print the syscall name header multiple times if a single syscall returns
several different error codes?

Also, is it intended that the output is now sorted alphabetically by the ke=
ys
rather than in descending order by occurrence count? The original script
sorted by frequency to highlight the most common failures.

[ ... ]
> +if __name__ =3D=3D "__main__":
[ ... ]
> +    try:
> +        print("Press control+C to stop and show the summary")
> +        session =3D perf.session(perf.data(args.input), sample=3Danalyze=
r.process_event)
> +        analyzer.session =3D session
> +        session.process_events()
> +        analyzer.print_summary()
> +    except KeyboardInterrupt:
> +        analyzer.print_summary()
> +    except Exception as e:
> +        print(f"Error processing events: {e}")

If process_events terminates early due to an exception, like the TypeError
mentioned above, will the script exit without showing any of the accumulated
metrics?=20

Would it be helpful to call analyzer.print_summary() in this exception
handler as well so partial results are not lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D38
