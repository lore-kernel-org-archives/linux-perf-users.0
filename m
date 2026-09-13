Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A9374A1F
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267455; cv=none; b=dA+kbm4uVH/kbDkOMpocmIHWksuyUN2vj9LO2NtQd8ZGyb37RzighG2L1cCKaz4oj4Xigtp80VvB+CY/tcNSkyAtJGstnsqxpwuwbvKyd/AwlTaslp4LK+hhoktjL3boj6oG7nNzUSoY6HtwnKJQct7Yz2paZiwcdPDnrjs6Hks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267455; c=relaxed/simple;
	bh=SqcNJQo9eDbplGVdO8Ofekj0otP/dz1z4egIFKMRl9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MpKs1rshrcet/pMPVqxnd5mTUYAWBJ3MO1EcLONVtVYbDpym5rcgSRM1QheuKKZGwq8RCfyjOU8yCGQe3P4EXOnHgquGLCauG+OY+JThACZtfeh+z/vd6NbmM3pHRwta88q1tgYsWJinUTsr26n3k+c5XVHrQM1rZvLaodjxkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg7ui+Ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg7ui+Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6B21F000FF;
	Sun, 13 Sep 2026 02:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267454;
	bh=LzugcMTF4nkANWWWSUtP/MtCGf3YM5p/TplTc/BEqxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hg7ui+EkPVbnw3h6tAbtDak3QJ0mc7CCfv/H9cHf4zvMS5pbLdRXW4TXYsnxta4Sk
	 O2bRV+WySRmR4tNIvs35tANkv2+l5HgVnOBEz/0wyXc/QsmSRe1zz+yV9XPbKe+7WT
	 qiqhGOuGhr2OS1+SdcBUzyGfDI7kmuieWK5+yN3U5Sb/NlxxQgBDaWLcBa/OaW1aJD
	 n39kr7C9EN3W3Hhklb7Tn/zRaw3/bNZieauPLQvuLoxDMgzjK1J4L5yl2yDXjLJxTC
	 I9ZwGkKQ5t/jZ+bKrhcYYfu2elg9e9bNNGB1axwsTu6mcQCKlPPPU80n3wEPwLk8rg
	 0Yb6u4y5gWb7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/8] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-7-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:44:13 +0000
Message-Id: <20260913024413.CE6B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Time-of-check to time-of-use race condition when accessing proce=
ss statistics leads to script crash.
- [Medium] Incorrect parsing of /proc/[pid]/stat for processes with spaces =
in their name.
- [Medium] Unsanitized output of process command lines allows terminal esca=
pe sequence injection.
- [Medium] Arithmetic evaluation failure due to awk outputting scientific n=
otation for large CPU times.
--

commit bb6bb44a87ff31de8100a51a6f3b35196458dff1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit introduces the perf-stuck.sh script and an accompanying gdb scr=
ipt
to help identify where a running perf process is stuck. It samples /proc/<p=
id>
at fixed intervals to distinguish between spinning, blocking, and recursion,
and can automatically attach gdb if no progress is made.

> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> new file mode 100755
> index 0000000000000..8b284bcf5e313
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
> @@ -0,0 +1,165 @@

[ ... ]

> +hz=3D$(getconf CLK_TCK)
> +psz=3D$(getconf PAGESIZE)
> +prev_cpu=3D
> +prev_stack=3D
> +prev_progress=3D
> +stuck=3D0
> +gdb_done=3D
> +nsample=3D0
> +
> +echo "watching $pid ($(tr '\0' ' ' < /proc/"$pid"/cmdline)) every ${inte=
rval}s"

[Severity: Medium]
Does directly printing the process command line allow for terminal escape
sequence injection?

The tr command does not sanitize non-printable characters, which could allow
a process launched with malicious ANSI escape sequences in its command line
arguments to corrupt the local terminal when monitored.

> +
> +while :; do
> +	if [ ! -d /proc/"$pid" ]; then
> +		echo "$(date +%T) process gone"
> +		break
> +	fi
> +
> +	stat=3D($(awk '{print $3, $14 + $15, $24}' /proc/"$pid"/stat))

[Severity: Medium]
If the monitored process has a space in its command name (e.g., "(my script=
)"),
will awk split the name into multiple fields using its default whitespace
delimiter, incorrectly shifting positional variables like $14 and $24?

[Severity: Medium]
If the process terminates immediately after the directory check on the prev=
ious
lines, but before the awk command reads the file, will awk return an empty
output?

Because set -u is enabled, accessing the unbound stat[0] variable below
would cause the script to abruptly crash instead of cleanly exiting.

> +	state=3D${stat[0]}
> +	cpu=3D${stat[1]}
> +	# field 24 is the resident set size in pages
> +	rss=3D$(( stat[2] * psz / 1024 ))
> +
> +	stack=3D$(awk '/\[stack\]/{print $1; exit}' /proc/"$pid"/maps)

[ ... ]

> +	if [ -n "$prev_cpu" ]; then
> +		cpu_delta=3D$(( cpu - prev_cpu ))

[Severity: Medium]
If the sum of utime and stime ($14 + $15) calculated by awk above exceeds
1,000,000 ticks, will awk format the output in scientific notation (e.g.,
1e+06) based on the default OFMT?

If so, the bash arithmetic context here will be unable to parse this format,
causing a fatal syntax error and crashing the script when monitoring
long-running processes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D6
