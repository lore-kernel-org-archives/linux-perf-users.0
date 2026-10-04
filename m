Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25039F16B
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135533; cv=none; b=Qoi7QoDffEXXdMjoaux9WWkpy4bzg79runGUwbSO3DbRqI6ZPmFA8AAknkZBDU0u9uGKfnInqSIHo0dAPUgNdEfGtM2H6Hi2O+ny187GDqyG8se92Npb/apkzoRnfbIGWSWlOckRadqpC5kI8pEex8PUPrg9cl+HRZjmPA2uEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135533; c=relaxed/simple;
	bh=maHiYZ44ihtCcjJphMyqISkqygas7jFurrm6NON5f3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uvMoFmxX6Geg42ZC8ws3AzPQt+jiiq/Dt4WLKywjDnFWywBUgdVvNObDvPkAscQPLJr5a2DAR0EZqNhN545u/1WvRJ87+wlHzGfdngjW0DJQskzIhbdytb6PWBVIjiiJmGe+ZcmBlbrRuxTyuxgCkOn9PoVv9JyeN+rSzgT7a+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVFvmTy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVFvmTy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4E31F000FF;
	Sun,  4 Oct 2026 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135531;
	bh=a3Ie1yVswZf6RJs4wXESroVl1gw0zEzOT3wJjMhDGRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eVFvmTy5OF4qz6A3uCVWtaY6LfrDlTSkDwzyH/S02SxRAA51Lm4IzFZUdjOIpnUa6
	 sNxAF6qRoDJ3dyufBjvP+ElsJ8NUAH6wRhjKL/pE1ot1/pMYcI/w5DGWdOF8w7/Qs9
	 yK5IwF2MnAuPKMddjCPXNRI27VvsYKNaAMPr7nHIqYNJ6MHf+91bJvR4POa0VsDyY6
	 iG3ByqPvJiPSJ2F5NJn1pHoHXohH96mFlLPhKCbuOoEDmxrpRA/GYafC2+KmVDAghJ
	 BGscgbJlYyVWXkP6q2iwTsEKWESvMa+2s6PmS6mMCE89TrAiRufF+eZvc3Wy645TOL
	 JRsOn3AiNFTng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 8/9] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-9-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:38:50 +0000
Message-Id: <20261004173851.4F4E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf scripts: incorrect parsing of /proc/pid/stat starttime caus=
es premature exit
--

commit aa0fa29f56caddf899075009e74dfa310ea7373b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit adds a new script to monitor a running process's progress and
identify if it is stuck in a loop. It samples the target process at a fixed
interval and optionally invokes gdb when no progress is observed, verifying
process identity using the start time from the stat file.

> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> new file mode 100755
> index 0000000000000..57c979f6e58c5
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
[ ... ]
> +# Its start time, in clock ticks, pins the process instance: a PID can
> +# name a different process later, samples or gdb would land on it.
> +pid_ticks=3D$(awk '{print $22}' /proc/"$pid"/stat)

[Severity: Medium]
In tools/perf/scripts/perf-stuck.sh, will this correctly parse the starttime
if the process name contains spaces? Because awk splits fields by whitespac=
e,
spaces inside the parentheses of the comm field will shift the remaining
fields. If the name contains spaces, capturing field 22 might read volatile
metrics like num_threads or stime instead of the process starttime.

> +
> +echo "watching $pid ($cmdline) every ${interval}s"
> +
> +while :; do
> +	# The PID may name some other process by now, if the watched one
> +	# exited and its PID was recycled, e.g. within one interval:
> +	# checking existence alone is not enough, samples or gdb would
> +	# land on the stranger.
> +	if [ "$(awk '{print $22}' /proc/"$pid"/stat 2>/dev/null)" !=3D "$pid_ti=
cks" ]; then

[Severity: Medium]
Could this cause the script to exit prematurely? Since the initial extracti=
on
of pid_ticks above might capture a volatile metric when the comm field
contains spaces, this check might trigger when that metric dynamically
updates, falsely detecting that the process has exited.

> +		echo "$(date +%T) process gone"
> +		break
> +	fi
> +
> +	# Field 2, the command name, is in parentheses and can contain
> +	# spaces, so drop it together with the pid before splitting so the
> +	# fields line up.  %d keeps the CPU time out of scientific
> +	# notation, that bash arithmetic can't parse past six digits.
> +	if ! stat_line=3D$(awk '{ sub(/^[^ ]+ \(.*\) /, "");
> +			       printf "%s %d %d\n", $1, $12 + $13, $22 }' \
> +			 /proc/"$pid"/stat 2>/dev/null); then

[Severity: Medium]
This isn't a bug here, but since the comm field is correctly stripped of
spaces in this awk call to avoid shifting fields, could the same protective
logic be applied to the earlier awk commands extracting the starttime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D8
