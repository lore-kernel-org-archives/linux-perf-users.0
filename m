Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25858364949
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140239; cv=none; b=lytawoqb96lkbNmTOjAn47KrmB4E8m2T/5OlNdX+Y6RrX2koqucooYMaxSU6hJmkjzb4toLPPF2BsXqccjEN8rBzEHTpe5Mc2bGP/GM/F7IR13dEVDdIq2HNH8B6H9K5pXIg4J7omsFs68oWhO4g/xVXjxUBF3gTr/v6z4NNkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140239; c=relaxed/simple;
	bh=bpluEfiMLcDWWpATVd5CHq1B52om5z/1W2jux97HYis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ieqgjo3v6mATKlOY3eSvTlvonjzvyVdC5DVpovocLHSDaJmz3048THKZ7b+bvrUFmcS81TIDUou6ihZAXlk2JtpnMhdeUScdRrMHQsVJkbHELz48cbY1MaIMl6OBWOy0d6gByblagu4GJUwwV0/GXcLsIDfZC8naiRwAnqaadJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy2bcsuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy2bcsuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F15C2BCB0;
	Sat, 25 Apr 2026 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140238;
	bh=bpluEfiMLcDWWpATVd5CHq1B52om5z/1W2jux97HYis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Oy2bcsukJcGvwPInVgqdxlVcemJjgZAJBCCcnN5/XrEPd/T3QKnFkaekLCO6pHjQK
	 W+EBfbVvQQeIP0dsT/HbESKxbCfJAzZ9Ex3dVR5Ku4oEYu9QMIM8tlcmmEHgE+lOjf
	 rvqV5xHltJpS/ba28FMX3nTkbfdTu+minAh7tlYgsK5BLa6pjAKKPdFuyVyr1B5t1A
	 7J59k+5D4OqxtrHHznE19HyeOH15vEZXkjDLv9Zt1RZsc4SK/V1uEdsb3omAYQqIRa
	 FtkZs1kibOQBuWEQawdJ5+7/GlXm5gzS7rWp/P1YDqzbLVxfHE+WnxggPEVgqw71oc
	 b+tKe8AmBLnnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 28/59] perf syscall-counts-by-pid: Port
 syscall-counts-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-29-irogers@google.com>
References: <20260425174858.3922152-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:03:57 +0000
Message-Id: <20260425180358.83F15C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Output is sorted by syscall ID instead of event count, contradic=
ting the commit message.
- [Medium] Filtering by PID 0 fails because the filter value is evaluated a=
s falsy.
--

commit 4c85b8ae5e1c60397dc5980ed736963359e2b677
Author: Ian Rogers <irogers@google.com>

perf syscall-counts-by-pid: Port syscall-counts-by-pid to use python module

This commit rewrites the syscall-counts-by-pid.py script to use the perf
python module. This avoids the overhead of executing the perf script tool
and improves performance.

> diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/pyth=
on/syscall-counts-by-pid.py
> new file mode 100755
> index 000000000000..ff962334a143
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts-by-pid.py
> @@ -0,0 +1,88 @@
[ ... ]
> +def print_syscall_totals():
> +    """Print aggregated statistics."""
[ ... ]
> +    print(f"{'comm [pid]/syscalls':<40} {'count':>10}")
> +    print("---------------------------------------- -----------")
> +
> +    sorted_keys =3D sorted(syscalls.keys(), key=3Dlambda k: (k[0], k[1],=
 k[2]))

Does this sort the output by syscall ID instead of the event count?

The commit message demonstrates the expected output being sorted in descend=
ing
order by event count, but this seems to sort in ascending order by syscall =
ID.

> +    current_comm_pid =3D None
> +    for comm, pid, sc_id in sorted_keys:
[ ... ]
> +def process_event(sample):
> +    """Process a single sample event."""
[ ... ]
> +    pid =3D sample.sample_pid
> +
> +    if for_pid and pid !=3D for_pid:

Can this fail to filter correctly if the user filters by PID 0?

Since for_pid would be 0, it evaluates as falsy in Python, which would bypa=
ss
this early return and process syscalls for all processes. Should this check
for_pid is not None instead?

> +        return
> +
> +    comm =3D "unknown"
> +    try:
> +        if session:
> +            proc =3D session.find_thread(pid)
> +            if proc:
> +                comm =3D proc.comm()
> +    except (TypeError, AttributeError):
> +        pass
> +
> +    if for_comm and comm !=3D for_comm:

Similarly, if an empty string is provided for for_comm, does it evaluate as
falsy and bypass the filter?

> +        return
> +    syscalls[(comm, pid, sc_id)] +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D28
