Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE337AA8C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574181; cv=none; b=aLVUJE+dME2JHUBiGRtBduj88yBtlpq4c24f/Ez/2IDNtc4ZoupAh/zoJPZb0wPyv3I+KalUbUssRkLILfx/s4+keBUwm/DUYzJ+TWD2QyyxJpK2abPpAs4rfj9uX9ebn8DIXJinmMPUlyUM27ombT6X4IiFftfMICmvE3ivpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574181; c=relaxed/simple;
	bh=BQMpp+qmcNrxADVjfy/u6pYZzGI9VUahHfyRRwlLHIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RiLzI04rjFo9lHfeLk/XpTt0EK43wsOaFBtdSbGJJuANVmDr233CP3EuLd774zFJyiFdR5XMrtw38UjblinTKwsqK3iEw2cZ9x1zv6Cv5V17LQVnUHBT1rUIJ0O/OGxorZYsCH6XlYyGHFpPzw+URRu7qlwFN71DCeEhV13GMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHx3o1xV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHx3o1xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDBC1F000E9;
	Tue, 16 Jun 2026 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574180;
	bh=ujd5LAnMBIlGcsGYooZ2fVcRlIN0cWdT8MPu4FTM12E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nHx3o1xVgCq2dj0IXOeqGtqi8rMiU5TgIyLklfrcNGuEKsF5bh/l3gmjmOt6L7U4z
	 bkN/3ny/hkGoF4Hj/k68Yj/NeZz1eaQDKKfpTRLNbxwBGi7HJ6QJI8NaINsKm7smR7
	 YPFPz0Lu6Vojw/N8GWUUfMFwesIxeN2gBXCs1wATXDBZsGqucUmsQsMgAi2cdtRQw0
	 5TNrX+glMQcmKLfdCvl7Ob+8ODH7aLNO+ioxK+y9s7Ev5oVndcLzCH2D5V4uby81Rk
	 VoYgN+TkUZeclY4RpCRkujQ0uHo9uDS6Sneq+2ypgjh6E3kP2pimtNGOb5c+THgTg9
	 GCE7kg9eKIGUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/12] perf tests: Fix flakiness in trace record and
 replay test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-8-irogers@google.com>
References: <20260616012744.4049193-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:42:59 +0000
Message-Id: <20260616014300.6BDBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Deleting a safely created `mktemp` file before reuse creates a Tim=
e-Of-Check to Time-Of-Use (TOCTOU) race condition, allowing arbitrary file =
overwrites.
- [High] The use of a predictable logfile path in `/tmp` combined with unsa=
fe shell redirection allows local attackers to overwrite arbitrary files.
--

commit 9a64d257cf386372ecbfc443356890a8a5a33cd2
Author: Ian Rogers <irogers@google.com>

perf tests: Fix flakiness in trace record and replay test

The perf trace record and replay test fails intermittently on slow or
virtualized hosts because the default recording workload occasionally
completes without scheduling the target nanosleep system calls. Generalize
perf_record_with_retry to support a custom record command prefix via
PERF_RECORD_CMD and retry with scaled sleep durations.

Fixes: 15bcfb96d0dd ("perf test: Add trace record and replay test")

> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> index c5de252447705..5c7feb294ebbf 100644
> --- a/tools/perf/tests/shell/lib/perf_record.sh
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -21,9 +21,14 @@ perf_record_with_retry() {
>    local duration
>    local first_run=3Dtrue
>    local ret=3D1
> +  local cmd_prefix=3D"perf record"
> +  if [ -n "${PERF_RECORD_CMD}" ]; then
> +    cmd_prefix=3D"${PERF_RECORD_CMD}"
> +  fi
> +
>    for duration in 0.01 0.1 0.3 1.0 2.0; do
>      rm -f "${perfdata}" "${perfdata}".old

[Severity: High]
Does this rm -f introduce a time-of-check to time-of-use race condition?

In trace_record_replay.sh, the perfdata file is securely created using
mktemp:

tools/perf/tests/shell/trace_record_replay.sh:
file=3D$(mktemp /tmp/temporary_file.XXXXX)
...
PERF_RECORD_CMD=3D"perf trace record" perf_record_with_retry "${file}" ...

By explicitly deleting this securely created file here in
perf_record_with_retry before executing the command, the script relinquishes
the uniqueness and security guarantees of mktemp.

Since the test enforces running as root, a local attacker monitoring /tmp
could create a symlink with the deleted file's name pointing to an arbitrary
critical system file.

When the perf command later calls open_file_write() in tools/perf/util/data=
.c
using O_TRUNC and without O_NOFOLLOW, it will follow the symlink and trunca=
te
the attacker's target file.

> -    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$l=
ogfile" 2>&1
> +    ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "=
$logfile" 2>&1

[Severity: High]
Could this shell redirection allow for arbitrary file overwrites via symlink
attacks?

This issue was introduced in an earlier patch in this series when
perf_record_with_retry was added. The logfile path is predictable:

tools/perf/tests/shell/lib/perf_record.sh:perf_record_with_retry() {
    logfile=3D"/tmp/__perf_record_retry.$(id -u).$BASHPID.log"
}

Since the process ID space is limited, a local attacker could pre-create
symlinks for likely process IDs pointing to sensitive system files.

When the script executes and the shell performs redirection without
noclobber enabled, it will blindly follow the symlink as root and
overwrite the target file.

>      local record_exit=3D$?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D7
