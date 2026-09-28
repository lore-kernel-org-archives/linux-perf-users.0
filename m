Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F704E73CA
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613453; cv=none; b=BIB5qklcjwEjyc9rDhPfEQaVQrxdpVvp6k+5kSoYeqjmFaB06DbojsQ7XnHT4rRld5utBLcF3ZowdY+u6vGv+flAtxDYFMMkCIUth3Fu/j2anr/Z+OV7ZSXZOPwd8GBuHlOOS2aeNy26d4rBBeHwmNH93OT2ugv6Dl6db4lvHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613453; c=relaxed/simple;
	bh=teJCwboeiyhU8sVvPFU7J/wUjKz8zNK1ge5Ds68OGGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQEI35XCIJ0Y16GUvxDlQ1RFKzT6K4g3Cy6dY8KGi5IQIXzKkC2oNbrqMliKUvFOi1YM3s3JrmxQGN7GWxclBVwf0nSsoiSFP5PsyEJpsXFmGvbwgcN7ZjVJ35ukdDstbEcKuRwx/4tMvQqfr8LbK7HlOK0R3P7VRbC2y49KfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhpSpwn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhpSpwn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F441F0089A;
	Mon, 28 Sep 2026 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613452;
	bh=6LQazLdOP6g67VxMRZsUBIycQ9hqUisOxN7GBfOe1sQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhpSpwn4btn9ap9yiwXboaG5lX6qjQr52lifoSXGF5kh/PYqq9mR4APK87hXpG0mE
	 aLkZ48MOD/yFlGqLWVZzdO1Sm+QQvvvh25mqlus3XcASkEwkcgKNY5wDaCsdRUCjux
	 rWLp7+WrMCOtWYnIXuzXoTg0iUyxJomz9myPl5310YlSqxBGczqm7YS0cyN1H9hvQa
	 xAdTz2utgIuBzQfmFM6LLYwxDLr8nywRKFM6B40hnowTA0TWYHhZQPfWVrULhG4nvh
	 qQ/ZqKvyDMDH58EAmr55YfNDVnPpyai08ZsEelCiQThAfTZsVa50PvgqEAWs07/mgc
	 D89a6aBSM6Ocw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928162250.2413383-4-acme@kernel.org>
References: <20260928162250.2413383-1-acme@kernel.org>
 <20260928162250.2413383-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:37:31 +0000
Message-Id: <20260928163731.E3F441F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf-stuck: hang detection fails if progress log is empty
- [Medium] perf-stuck.gdb: libdw inferior calls lack function pointer casts
- [Medium] perf-stuck.gdb: structure access fails with REFCNT_CHECKING enab=
led
- [Medium] perf-stuck.gdb: perf-dso macro accesses non-existent dso->name f=
ield
--

commit 95092b23c716d33f8c9a4a12147c43af4f703f93
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit adds a prototype perf-stuck.sh script to monitor a running perf
process and detect hangs using /proc sampling. If it detects a hang, it uses
perf-stuck.gdb to attach GDB and print the DWARF type chasing loops to
diagnose where it is stuck.

> diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-=
stuck.gdb
> index 0000000000000..ad595392f6beb
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.gdb
[ ... ]
> +define perf-die-chain
[ ... ]
> +      # Pointer type DIEs have no DW_AT_name, so dwarf_diename() can
> +      # return NULL: printf %s of it would error out and abort this
> +      # batch script, handle it.
> +      set $perf_die_chain_name =3D (char *) dwarf_diename($arg1)
> +      printf "chain[%d] die=3D%p addr=3D%p cu=3D%p off=3D0x%lx tag=3D%d =
name=3D", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off) dw=
arf_dieoffset($arg1)), ((int) dwarf_tag($arg1))

[Severity: Medium]
Will these inferior calls to libdw functions like dwarf_diename(),
dwarf_dieoffset(), and dwarf_tag() fail without explicit function pointer
casts?

Since GDB typically lacks debug information for the shared libdw library, it
does not know the return type of these functions. This can cause modern GDB
to abort the script with an "unknown return type" error.

On older GDB versions, this might truncate the 64-bit pointer return to 32
bits, leading to an invalid memory access during the (char *) cast.

[ ... ]
> +define perf-dso
> +  if $_any_caller_is("find_data_type", 20)
> +    frame function find_data_type
> +    printf "dso=3D%s ip=3D0x%lx sym=3D%s\n", dloc->ms->map->dso->name, d=
loc->ip, dloc->ms->sym->name

[Severity: Medium]
Does struct dso have a name field?

In the perf codebase, struct dso uses short_name and long_name rather than
name. Accessing a non-existent structure field will cause GDB to throw an
error like "There is no member named name" and immediately abort the
execution of the perf-dso macro.

[Severity: Medium]
Will direct structure accesses like dloc->ms->map->dso fail when perf is
compiled with Address/Leak Sanitizers (which enables REFCNT_CHECKING)?

When REFCNT_CHECKING is enabled, reference-counted structures like map and
dso are wrapped in an intermediary proxy struct.

The true data fields are hidden behind an orig pointer, so GDB will throw an
evaluation error like "There is no member named dso" instead of resolving t=
he
fields.

> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> index 0000000000000..3b9b22124dbda
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
[ ... ]
> +	if [ -n "$prev_cpu" ]; then
> +		cpu_delta=3D$(( cpu - prev_cpu ))
> +		# With a progress log, count the samples that show no progress,
> +		# without one there is no progress to look at, so count them all:
> +		# -g then looks at where the process is after two intervals.
> +		if [ -z "$progress_log" ] ||
> +		   { [ -n "$progress" ] && [ "$progress" =3D "$prev_progress" ]; }; th=
en
> +			stuck=3D$((stuck + 1))
> +		else
> +			stuck=3D0
> +		fi

[Severity: Medium]
Does this logic unintentionally disable hang detection if a progress log fi=
le
is specified but remains empty?

If a progress log file is specified but hasn't been written to (e.g., during
early initialization hangs), the progress variable remains empty. The check
[ -n "$progress" ] evaluates to false, causing the script to fall back to t=
he
else block and unconditionally set stuck=3D0.

This continuously resets the stuck counter, which will prevent the script
from ever triggering GDB.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928162250.2413=
383-1-acme@kernel.org?part=3D3
