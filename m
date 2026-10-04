Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AC1DF98F
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109842; cv=none; b=EroBkvMWyAD87vO3DZumGTOMi03QT/gXw75SWanw5Xm/u5cgkc4cLQCBSPAh4vc+kUY6FBm7hjVocd4JFKawZn7ilhAhelHVRrHVw17e79fsOpxc2W124aUKb9qsxh+apQ0U4RNYddFFVM5AtI8eiFy1cbJxdZUbXKFei7RlDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109842; c=relaxed/simple;
	bh=J8JeOg8pCFbFLdhu9z5b5G6p+ZNOg3sRzei//cp8uxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hpJW9/EZm4FK8jxIJUG175KKRT/YDE4YLhAvN4omEHAmrtvEUsiFWdZygnjV9/IkJpwa2g0MT29cYsWJc+vXQwGEErRYHx2HBLhF1TMqny5i4m/3TnYneQ2TWiCpzWO0NWu7YubP1w/qmpVT69RG6I83lIblsEZ3D8G5hE8o1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1juqQYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1juqQYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBE71F000FF;
	Sun,  4 Oct 2026 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109840;
	bh=rH74fgW3J0+Hjt0TZuwtCWnsoOfC4fDE1eo3HdhbRgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1juqQYPNc28hIW+XkbKqmhpQyTjJ0gtbYh3nSf9o2X0bRAib4nNvHoFrk31Q88Kj
	 eFkUeYOKmTMpZ4dJTLPUDe2GTBJICh06pW3tvc/SQEyaJzh9K+507eXddCP7CUxMYn
	 r0pmFv9eV5gp3Xb6WQnrnpnPXikRXihDBeWEwEUS0IEKb3kzt7S77+BD93lxVJANgE
	 4GZy2Lj7gDbzq245NJzftLi4/v0IqkpUqUOyFheP27Fux8ENwuNW1nyfzPzJwwvqoh
	 6uKaBL/DLy35BoMOb4DQJbGr0wu0A5uFyW704qzWGY5wAI6rqW/wQY7bzuG5LdL3M5
	 e2L8xhfShhRtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/9] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-9-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:30:40 +0000
Message-Id: <20261004103040.8CBE71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: PID reuse race condition (TOCTOU) allows attaching GDB to =
arbitrary process
- [Medium] perf: terminal escape sequence injection via unsanitized progres=
s log
--

commit 4d621a8585d05e62b3a0241c056ece1b77cc057c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

A perf that takes forever is hard to tell apart from one stuck in a
loop, and there is no way to see where without attaching gdb.
perf-stuck.sh samples a running process' /proc entries and its progress
line at a fixed interval, and with -g runs gdb when no progress is made
across two samples.

> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> new file mode 100755
> index 0000000000000..0bbcef6c82a4b
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
[ ... ]
> +while :; do
> +	if [ ! -d /proc/"$pid" ]; then
> +		echo "$(date +%T) process gone"
> +		break
> +	fi

[Severity: Medium]
Could this simple directory existence check allow a race condition if the P=
ID
terminates and gets recycled by another process?

If an attacker recycles the PID exactly during the sleep interval, gdb coul=
d be
attached to their process unwittingly, exposing the debugging session to
untrusted data when it later runs timeout below.

[ ... ]
> +	# Progress updates overwrite in place, \r separated, so the log is
> +	# one ever longer line: take the last update from a bounded tail
> +	# window and drop the \r's, so printing it doesn't reset the
> +	# terminal cursor on the state line.
> +	progress=3D
> +	if [ -n "$progress_log" ] && [ -s "$progress_log" ]; then
> +		progress=3D$(tail -c 8192 -- "$progress_log" | tr '\r\n' '\n\n' | tail=
 -1)
> +	fi

[Severity: Medium]
Should the control characters in this string be explicitly stripped?

The cmdline variable is stripped of control characters, but progress only
replaces carriage returns and newlines.

If an untrusted log is monitored, could this allow terminal escape sequence
injection?

[ ... ]
> +	printf '%s state=3D%s cpu=3D+%d (%d.%02ds) rss=3D%dkB stack=3D%s %s %s\=
n' \
> +	       "$(date +%T)" "$state" "$cpu_delta" \
> +	       $(( cpu_delta / hz )) $(( (cpu_delta % hz) * 100 / hz )) \
> +	       "$rss" "$stack_txt" "$stuck_txt" "${progress:-(no progress log)}"

The unsanitized string is written directly to the terminal context here.

> +
> +	if [ -n "$use_gdb" ] && [ -z "$gdb_done" ] && [ "$stuck" -ge 2 ]; then
> +		gdb_log=3D$(mktemp /tmp/perf-stuck-gdb.XXXXXX)
> +		# The gdb script makes inferior calls, and a call into a perf
> +		# wedged in a loop never returns, so bound the run; SIGINT
> +		# releases the inferior instead of leaving perf stopped.
> +		timeout --signal=3DINT 30 gdb -p "$pid" -batch -x "$gdb_cmds" -ex bt \
> +		    -ex 'perf-die-chain-all' -ex perf-dso -ex detach > "$gdb_log" 2>&1

This is where gdb could be attached to a recycled PID.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D8
