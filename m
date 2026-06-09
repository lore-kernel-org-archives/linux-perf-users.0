Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE037B01F
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021636; cv=none; b=siFxVg6sscwHS58JFuyaBiOWPz6S10CrzftburTN6geji08FKMky0Xm27we8RAyulg0nTv2RBynv1c3rvBpaC0dSx0aBTrBgT66JlHDf8bIrgCrHIx6A8DBbqc8CWZtpvm2+tqpNicUsQkfmDrcBIxh9qimIRxO2QRiTwt7TWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021636; c=relaxed/simple;
	bh=usXrSPDSg95i4cn/BwWCLQczJxJU58ExGnLglwkzcxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dD8ozOLud/EM4XECGY9kowLDw/ADiB7NY9uceJhCPFwYafkKqXxx8enH2acaMurAXOn7aXLWiU139rqc2WMyWVwC7PRbMIB2vMRiHiu1oVvq54aPV+MrPDSny4X5vTwOLoD5vAY9i/elPGsM/PNTfVJ/uVPDnIoNl5PYIi1o1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzAy3VT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzAy3VT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA1F1F00893;
	Tue,  9 Jun 2026 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021635;
	bh=G8+/zgdad/Qc3lR0mpwggrtVVg2vAE6e8dOfWQk6RAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzAy3VT6cG5g9CqdWlfLTJ9RbDq19p+Ppl7+Pteu5Yee80sp4z7xZrCPlxDaVhjAW
	 aMgTgakd3yH0kw5egMLSB19eJzUwXbFC3yw+kBGWG9O++/bH+4evQ44frP6BgSnNa1
	 jOCDB1h9XMHnImWDbTWuNWIPSSKiwWLeZxHzjy+Bug2eju/z6sqoT5gr9XPJlhu9BJ
	 gOaLy6q22OBviWhdzm/iMR9FRStdbdh3LPK3TAfkphdobB8U0XEormgvek1/Ir8fbd
	 8E9n/qNeg4Alhgf9eOjuIDuwN80arBP5VdrOlLPuQph/xEH/12HTSF1cPgYHO8Vjzp
	 UqMoNwVfYE32A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/19] perf test cs-etm: Skip if not root
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-12-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-12-d53a7d096a19@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:13:54 +0000
Message-Id: <20260609161354.DCA1F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The script is vulnerable to a TOCTOU symlink attack that allows a =
local attacker to overwrite arbitrary system files with root privileges.
--

commit 31448575355dfbf022d3a5103f47303bea93bbf4
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Skip if not root

Use the common idiom for skipping tests if not running as root, which is
required for these tests.

> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/te=
sts/shell/test_arm_coresight.sh
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -20,6 +20,12 @@ skip_if_no_cs_etm_event() {
> =20
>  skip_if_no_cs_etm_event || exit 2
> =20
> +if [ "$(id -u)" !=3D 0 ]; then
> +	# Requires root for -C and system wide tests
> +	echo "[Skip] No root permission"
> +	exit 2
> +fi
> +
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  file=3D$(mktemp /tmp/temporary_file.XXXXX)

[Severity: High]
This is a pre-existing issue, but does enforcing root execution expose these
temporary files to a symlink attack?

While the temporary files are securely generated with mktemp in the
world-writable /tmp/ directory, the script breaks these guarantees before
writing to them.

Looking at record_touch_file() in tools/perf/tests/shell/test_arm_coresight=
.sh:

record_touch_file() {
	echo "Recording trace (only user mode) with path: CPU$2 =3D> $1"
	rm -f $file
	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
		-- taskset -c $2 touch $file > /dev/null 2>&1
}

This explicitly deletes the safe file and executes touch as root.

Additionally, looking at arm_cs_etm_system_wide_test():

arm_cs_etm_system_wide_test() {
	echo "Recording trace with system wide mode"
	perf record -o ${perfdata} -e cs_etm// -a -- ls > /dev/null 2>&1

Successive perf record calls rename the existing ${perfdata} to .old, freei=
ng
the securely generated filename.

In both cases, could a local attacker use inotify to detect the deletion or
rename, and insert a symlink pointing to an arbitrary file (like /etc/shado=
w)?

Since this patch explicitly enforces the script to run as root, won't
subsequent file operations by perf record (which internally uses open with
O_CREAT | O_RDWR | O_TRUNC without O_NOFOLLOW) follow the symlink and
overwrite system files with root privileges?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v5-0-d53a7d096a19@linaro.org?part=3D12
