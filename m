Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770281DB356
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668360; cv=none; b=XFBAS66xgT4WlbXG+q3dfWm56RIvEWNymuiC0aWC4r7wQMaRRl8Ry+1TwH7+Ujcx3+/BxEiwySkUFLgEFB7H9VhVZOnUZdRWafQ/SwFe5cpQnGd0OWGzCpnwPSbQNyvQVYfmcN9mt3nczSAkngM09bNEpBPwe8nH+cDpqXEaxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668360; c=relaxed/simple;
	bh=pJHzgoB2Cvsh0hHRq3d5KVZTgvXW4RW69sJH7ybXnTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mvDJOifyQR2trbNVqRVLbXYTbOIQh9A+9is7GD/iyJr3BNDDJu4vLsCLL91nFrpFPZ5hiJDNvYJdlbn2dL0h/fRqDRlMDP89sz4unY82aPzHSmTtifVfybOGt8co8/+hf8JDCTt6I7FdpwIq8rrZMp3cUbi3NBEgFAOlPVBhPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfdNvtq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfdNvtq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B801F000E9;
	Fri, 14 Aug 2026 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668359;
	bh=V083ih+N0Pg8kWCnoOxoWSPB40noeb+Wi6hqCzDFa/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfdNvtq85Zvo1sRUaV1o0mjn8q2OffNM2H+xr+S8s+5eQy1zjLKkdbGKYkqIIFnm1
	 qtzyG8vw/N3oHXFxJ5r2PwsmFl9JvHWOehbqyKDdGogc9wupNsnBaRnooeiimjixTD
	 MZylhmkCKOn0W4xQiIHZFwXiKKJdkLnfGkSIqPkTv3U5SRz6C1nyGT6JoVFoX+eK7C
	 8WizhO8H3xe6Pm6MqYZVN2ymh7jfL6xCsJpNIqQa4B2o5X2WuoxqmaNASg4Kuk7kVJ
	 hWTMOemENjE2Rv6RbBIpMw/ty24oonn5wQ7VNmWPSGHWysRmei5AwGw4rMKXsf+8CL
	 /wOp1ylDuV5KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] perf build: Add install-build-deps framework to
 install devel packages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260810193506.18949-3-acme@kernel.org>
References: <20260810193506.18949-1-acme@kernel.org>
 <20260810193506.18949-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:45:52 +0000
Message-Id: <20260814004558.E8B801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] The `--distro` option's error message suggests `rhel` and `debian` =
as valid choices, but the script then rejects them as unsupported.
- [Low] The local variable `pkg` is declared but never used.
- [Low] Sourcing `/etc/os-release` without existence checks or stderr redir=
ection leaks error messages on unsupported systems.
--

--- Patch [2]: [PATCH 2/7] perf build: Add install-build-deps framework to =
install devel packages ---
commit f7444376f9bbb9f83dcea58b5ac3f7286c4455dd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf build: Add install-build-deps framework to install devel packages

This patch adds a 'make -C tools/perf install-build-deps' target and a
companion script to automatically install the development packages needed
to build perf. The script includes distro detection and handles the base
toolchain packages for Fedora and Ubuntu.

> diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/script=
s/install-build-deps.sh
> new file mode 100755
> index 0000000000000..6b9a1142f32ac
> --- /dev/null
> +++ b/tools/perf/scripts/install-build-deps.sh

[ ... ]

> +detect_distro() {
> +	if [ -n "$DISTRO" ]; then
> +		echo "$DISTRO"
> +		return
> +	fi
> +	local id
> +	id=3D$( . /etc/os-release && echo "${ID:-}" )

[Severity: Low]
Is it possible for a minimal container to lack /etc/os-release?=20

If so, sourcing it without an existence check or stderr redirection will
print a "No such file or directory" error to the terminal. Does this
contradict the commit message's goal of avoiding error spew in fresh
containers?

[ ... ]

> +main() {
> +	local action=3D"install"
> +	local srcdir distro pkgs pkg cmd

[Severity: Low]
This isn't a bug, but it looks like the local variable pkg is declared
here but never used in the main() function.

> +
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		--list)		action=3D"list"; shift ;;
> +		--dry-run)	action=3D"dry-run"; shift ;;
> +		--distro)
> +			[ $# -ge 2 ] || {
> +				echo "error: --distro requires an argument (fedora, rhel, ubuntu, de=
bian)" >&2

[Severity: Low]
This error message suggests "rhel" and "debian" as valid options, but the
distro validation block later in main() explicitly rejects them as
unsupported.=20

Could this error message be updated to only list the distros that are
actually supported by the script?

> +				exit 1
> +			}
> +			DISTRO=3D"$2"; shift 2 ;;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193506.1894=
9-1-acme@kernel.org?part=3D2
