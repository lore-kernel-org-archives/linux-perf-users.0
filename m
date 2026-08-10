Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8EB3644A6
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378193; cv=none; b=Wm6MWWluD3nUQTbBIUHNXQWIcDxQalm0aA+0d/90+oGKM87wkKAPufZdnkhn/aLQquThayW8araQ7YX5lDE1YdZccICiiMxRk6+yms48/dV1qL8hrgj7Ej0y1g5dasDKhoYvG6pR4v60tkm7YzSZNKIwZb4T+topNozYJZB9gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378193; c=relaxed/simple;
	bh=+jAouv1h7mCM4iu+UDyR07NH3d3OIT8jmoiFx41rA2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkBwU1U9aYz0DCS5MDB1qHNzdmDSQ1LUeJgMrUwgkkA0myTb4tVoFudvC6bqaSGW94T5lK1PpLge7GHRk/6SGX6GU+JQHlRZm8l4cMC66jfQqbJDzuTi6NCwaGo91lLMjX1C0rmtIt0Ne9fHEy+OZPvQjFhQ818Uph+ffs83ws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOl8gjrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOl8gjrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF821F000E9;
	Mon, 10 Aug 2026 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786378191;
	bh=HFsJobaA4JYhv97k08waa7Hr2bdaoI+qeeR8x7VbSlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOl8gjrsttJPxaWb95vb05eVuMdliyNtWG9+2+Vp5IFoqofQPcC0nj8BuldRExOZN
	 XQagliiuRmr1JrqrZjMLSR5Yael3tg9e/BUpqATIWPzbDGIdwxUJb4qO7s4nFHjs8o
	 XxvnLxMeehyvdruABnnM53pvYVemwrjcDgRkP2y23Z5YWSPqubzD/+9fSGnVzgerUC
	 PZlCp6SrIet9ilfoij4p3seU9wlqbZEDOWP+UhmWEakdCa0nuiSivcu6Fh3xXEajSD
	 zD40l5UJT5D1GHlRHYbPwKZiAvSyXgoaDNGuyFdDhpXaNCv3aYAMwRML6edjqcHiuH
	 hxTCRIGtH+2Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] perf build: install-build-deps: add RHEL family
 devel package mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260810154437.15946-8-acme@kernel.org>
References: <20260810154437.15946-1-acme@kernel.org>
 <20260810154437.15946-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:09:50 +0000
Message-Id: <20260810160951.7AF821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The INT and TERM signal trap removes the temporary file but fail=
s to exit the script, causing the script to resume execution and proceed wi=
th an empty or partial package list after an interrupt.
--

--- Patch [7]: [PATCH 7/7] perf build: install-build-deps: add RHEL family =
devel package mapping ---
commit d7066a2ea105c214aa5807a82fc683f385da44a7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf build: install-build-deps: add RHEL family devel package mapping

This patch extends the Fedora package mapping in install-build-deps.sh to t=
he
RHEL family (RHEL, CentOS Stream, Rocky Linux, AlmaLinux, Oracle Linux). It
adds logic to check enabled repositories via dnf repoquery to handle packag=
es
that are missing or located in optional repositories like CRB or EPEL.

> diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/script=
s/install-build-deps.sh
> index 4a6f4bda49094..caf6d8d1e56d1 100755
> --- a/tools/perf/scripts/install-build-deps.sh
> +++ b/tools/perf/scripts/install-build-deps.sh
[ ... ]
> @@ -518,23 +518,43 @@ main() {
[ ... ]
> +	missing_file=3D$(mktemp) || {
> +		echo "error: cannot create a temporary file (mktemp failed)" >&2
> +		exit 1
> +	}
> +	# package_set() runs in a subshell, doing dnf repoquery loops that
> +	# may be interrupted, so also trap the temp file then.
> +	trap 'rm -f "$missing_file"' EXIT INT TERM
> +	pkgs=3D$(package_set "$distro" "$srcdir" 2>"$missing_file")
> +	missing_pkgs=3D$(cat "$missing_file")

[Severity: Medium]
Will this script continue execution if the user sends SIGINT?

Since the trap removes the temporary file but doesn't explicitly exit, an
interrupt during package_set() would delete the file and then resume execut=
ion.
The cat command would fail because the file is gone, and the script might
continue on to the sudo installation phase with an incomplete package list.

Should the trap call exit for INT and TERM signals?

> +	rm -f "$missing_file"
> =20
>  	case "$action" in
>  	list)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810154437.1594=
6-1-acme@kernel.org?part=3D7
