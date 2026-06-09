Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DE383C95;
	Tue,  9 Jun 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989528; cv=none; b=mAtgEgS7MQvHhU8LkpAMBOp1PZJuvVA63PtIKvlY7WKqiEOytwpoHlq6pq9pY69lELs8pVot4uBZ9GneYfQU21sogTNQX03q0ui0MjWE9h6rQXdYLZGXB+GuvzdCtwfoPM/NVJRr7gITO//lje8Esa/eZ7QT3a8RhCPaHMGnrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989528; c=relaxed/simple;
	bh=Y3CPgw+pVgZ/2lsXgP9Ba/iZFxCpNeCBZ8dHG7CEbug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qPDJ0xncUolRCsigoyAGHtDRk8W3OmJ/iJok1eiRrNpD1MoMCxR5kKRJ0mAQJlyystnt6ZagELGvGeZiB4mq/NwsBMWfAuRdgiKmqLXYgxbOiCbr9QMC/IVYBOAu3ZSlokG+6HuzeG0w3bRHoLf1ei+C9ZtXQJpzrgDZbnCmdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZPKXesw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZPKXesw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F831F00893;
	Tue,  9 Jun 2026 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989527;
	bh=pcv7sDNZbJME6Bx2JyiV4cKqcw03zevxtq/Py/xZc3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZPKXeswdcUSevzf4lIGVa11E5/FbXkwUxZTP8Yi9PcZiQGAcYzdREwggS9lHm2e3
	 jxlPCyfS+y708GQq0CXlXjjLFm2GrmTm0B+Wa28sfVR5IhhCToXC0nT9AohSICPJPz
	 45ypIxpiFkg2+LeAqNgb/e44RI0eKbpcb6OnyRYOYt1m+FtCsKYRWaD71hQp+wMGvp
	 a8qYAbOL3qvcyGIovd3wTCbBMutFL/v+G2n0kGV9XK2V8nso66YtayVHS5KMxeqECL
	 5Grec7EyUQd3fTnUYQhJDnDOhaDLI4/pDmE7tXBhahEG26IEEZV1XxCLlnZKDXkmIC
	 HW6dJXzkZnicQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] perf test: Add BPF JIT annotation test coverage
 for all disassemblers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609070732.545416-8-irogers@google.com>
References: <20260609070732.545416-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:18:46 +0000
Message-Id: <20260609071847.24F831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] System-wide profiling of ambient BPF programs creates a race con=
dition that can randomly fail the test.
- [Low] Signal interruption leaks the original perfdata file and the bpftmp=
 directory due to temporary variable override.
--

commit 2a2752d1eb68187d4c05ebd5a52ce3cce359db69
Author: Ian Rogers <irogers@google.com>
Subject: perf test: Add BPF JIT annotation test coverage for all disassembl=
ers

This commit expands the annotate.sh shell test to verify BPF JIT disassembly
using supported backends. It attempts to capture system BPF programs using
perf record, extracts a JITted BPF program symbol, and runs perf annotate
on it to validate temporary ELF generation.

> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> index 2c06d2670cb18..9719e592befd2 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh

[ ... ]

> +test_bpf() {
> +  echo "Test annotate with BPF JIT output"
> +
> +  if ! perf check -q feature libbpf-strings ; then
> +    echo "BPF annotation test [Skipped - libbpf-strings not supported]"
> +    return 0
> +  fi
> +
> +  bpftmp=3D$(mktemp -d /tmp/__perf_test.bpf.XXXXXX)
> +  bpf_perfdata=3D"${bpftmp}/perf.data"
> +
> +  if ! perf record -a -e cycles -F 4000 -o "${bpf_perfdata}" -- sleep 1 =
2> /dev/null

[Severity: Medium]
Will this probabilistic test setup cause unpredictable failures or silent s=
kips?

By using perf record -a -- sleep 1 to capture ambient BPF programs, a race
condition occurs. If a short-lived BPF program unloads between the time the
kernel emits the KSYMBOL/BPF_EVENT and when perf record's sideband thread c=
alls
bpf_prog_get_fd_by_id() to fetch the instructions, the JITed code won't be
saved in the perf.data file.

Later, perf report will list the BPF symbol, but perf annotate will fail
to disassemble it, causing a false test failure. Furthermore, if no ambient
BPF programs are active, the test silently skips, providing zero coverage in
most environments.

> +  then
> +    echo "BPF annotation test [Skipped - perf record -a failed, probably=
 no privileges]"
> +    rm -rf "${bpftmp}"
> +    return 0
> +  fi

[ ... ]

> +  # temporarily override perfdata so test_bpf_disassembler uses the righ=
t file
> +  local old_perfdata=3D"${perfdata}"
> +  perfdata=3D"${bpf_perfdata}"
> +
> +  test_bpf_disassembler "objdump" ""
> +  test_bpf_disassembler "llvm" "libLLVM"
> +  test_bpf_disassembler "capstone" "libcapstone"
> +  test_bpf_disassembler "libasm" "libasm"
> +
> +  perfdata=3D"${old_perfdata}"

[Severity: Low]
Is it possible for the original perfdata and bpftmp directory to be leaked
if the script is interrupted during this section?

The script uses a signal trap to run the cleanup() handler, which relies on
the global perfdata variable:

cleanup() {
  rm -rf "${perfdata}" "${perfout}"
  ...

If a signal like SIGINT occurs while perfdata is temporarily overridden,
cleanup() will only remove the inner bpf_perfdata and fail to delete the
original global perfdata file. Additionally, the new bpftmp directory is
never registered with the cleanup routine and will be left stranded in /tmp.

> +  rm -rf "${bpftmp}"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070732.5454=
16-1-irogers@google.com?part=3D7
