Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B8199D8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645266; cv=none; b=s1jPMSTOLAkSqsASMIns5FerNsvuuJLqbCDGmHnIg/CQ2WvBUwOP+i3iqipCenigzb5E/CKB4kPOS4AmtIprFA1+6o4YHvTWboco0b3b3OxcC+c4JWoAI4XiqFu1XOqWPFtIeHmGq8qHlDhCm7uF4UvvxpzchSgb9agpMZFWYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645266; c=relaxed/simple;
	bh=7tZPS/G6isSy9MkcuVkzymuAn69iiJEQWqQttQDCh5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G4+L36LLhL4w44GvlIMfZ5SNn4CoQwMOUHVD25wqUhduOl4pR30aZseLc6TNi/ruDqU6rxu/L8IaoN8wJYYBHBDnxq1ZkjJ0zJt8ITeMRQvuznV+XEypIMsn3dRSWoIyS5Zx+GI9glOWz7v0PXCn0jPpGhmqIIrFJbC5hbAW9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvar9X7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvar9X7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD4FC2BCAF;
	Mon, 20 Apr 2026 00:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645265;
	bh=7tZPS/G6isSy9MkcuVkzymuAn69iiJEQWqQttQDCh5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Nvar9X7NLK/3g9fu6y5991gVUCkik/kN/smGNuwr3Ixdl1i+6i/ZDhzaEVMGfIC5I
	 54SMWf0n7NtsHT5UsNYB6kpZdP2OKB9+gtJrnLUm2jkmPMjqFT/ClHCNT1KY5ARrjh
	 1Bzufr3zM9nSyL+oGLNbP5/qYVGhyc+6OehpG5/gWB2rM1UQZ0P8ew+nDBt/odDJ0A
	 xtWyvicvzy1zaKFt4YPd4+I5mzYgu3GhyzyDeXf8dXKoSOqG0jFLiC0nNrLepHnPw1
	 aPzBNVRNrspmoNusOd1Czx5ZO23NEvGLyMJR04TAJdz8x/B82JT/uH9/vdOO0DBXzc
	 lqsrYpuO8l0/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 28/58] perf syscall-counts-by-pid: Port
 syscall-counts-by-pid to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-29-irogers@google.com>
References: <20260419235911.2186050-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:34:25 +0000
Message-Id: <20260420003425.AFD4FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Unhandled `TypeError` when looking up untracked PIDs crashes the s=
cript.
- [High] Python f-string formatting crashes with a `TypeError` for unknown =
syscall IDs.
- [High] The script ignores input file arguments and hardcodes 'perf.data',=
 breaking `-i`/`--input` support.
- [Medium] Feature regression: Removed the ability to filter syscall counts=
 by Process ID.
- [Low] Unused variable `id_keys` in the summary printing loop.
--

commit 4158f24426deccec5a61785f2dd5ad7903a4ad84
Author: Ian Rogers <irogers@google.com>

perf syscall-counts-by-pid: Port syscall-counts-by-pid to use python module

This commit rewrites the syscall-counts-by-pid script to use the perf Python
module, significantly improving execution performance. It replaces the lega=
cy
event processing and filtering logic.

> diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/pyth=
on/syscall-counts-by-pid.py
> new file mode 100755
> index 0000000000000..a5d91060b18d6
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts-by-pid.py
> @@ -0,0 +1,57 @@

[ ... ]

> +def print_syscall_totals():

[ ... ]

> +    comm_keys =3D syscalls.keys()
> +    for comm in comm_keys:
> +        pid_keys =3D syscalls[comm].keys()
> +        for pid in pid_keys:
> +            print(f"\n{comm} [{pid}]")
> +            id_keys =3D syscalls[comm][pid].keys()

This isn't a bug, but is the id_keys variable needed? It appears to be
unused.

> +            for id, val in sorted(syscalls[comm][pid].items(),
> +                                  key=3Dlambda kv: (kv[1], kv[0]), rever=
se=3DTrue):
> +                print(f"  {perf.syscall_name(id):<38} {val:>10}")

Will this crash with a TypeError if an unknown syscall ID is encountered?

If perf.syscall_name(id) returns None for an unmapped syscall, passing None
to the string format specifier (:<38) will raise a TypeError.

[ ... ]

> +def process_event(sample):
> +    event_name =3D str(sample.evsel)

[ ... ]

> +    pid =3D sample.sample_pid
> +    comm =3D session.process(pid).comm()

Is a try...except block needed here to handle untracked PIDs?

If the underlying C extension fails to find the thread for the PID (which
can happen for short-lived processes or dropped events), it raises a Python
TypeError.

Without handling this exception, encountering a single untracked PID could
abruptly terminate the entire analysis session.

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    ap =3D argparse.ArgumentParser()
> +    ap.add_argument("comm", nargs=3D"?", help=3D"Only report syscalls fo=
r comm")

Does this remove the ability to filter syscall counts by Process ID?

The original legacy script allowed users to filter by Process ID by checking
if the argument was parseable as an integer.

With this change, passing a PID will interpret the input as a literal string
command name, silently failing to filter.

> +    args =3D ap.parse_args()
> +    for_comm =3D args.comm
> +    session =3D perf.session(perf.data("perf.data"), sample=3Dprocess_ev=
ent)

Does hardcoding perf.data break the ability to use custom input files?

Because the script's argparse configuration does not accept an -i override,
it appears it will completely ignore custom input files passed via perf
script (e.g., perf script -i mytrace.data) and always process perf.data
from the current directory.

> +    session.process_events()
> +    print_syscall_totals()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D28
