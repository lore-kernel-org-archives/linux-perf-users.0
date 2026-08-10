Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFE5695
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323662; cv=none; b=i1c7zIEmf7bnkdd8ruJGss7rzgaB+ed6XV2MDM+WM4weazFXcCNlgeSW4PlBfYNMIiMRubTt1L07mhWcUZqwZpw2lVw1oRYXvuZjkWDm3XWrqii+egoWKvUdQUK4M+Tdm5yjwRAN78YK2EUaH/ndEaBBHvjawsbe+LRFc0vzE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323662; c=relaxed/simple;
	bh=DbHn/cFY2ooyx+YNLJE5twIDYDUvUeWWPPoKmCZtQH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aBG8QKzVJD5UG7nvlc76QK90izjyfN7xqn6UsyDEFgWucOPBRpxHHecOGBoYahzGewvwT1EcnT1+geyFhEtz9TjHKMyDPR2hCPVdXck4SfaJ2jUGpKl9ID4TFo9uejTqO96nMfqiyUbx9NQOvELc6BH//rbc0ERGg94BQavIdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghC26GYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghC26GYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9297F1F000E9;
	Mon, 10 Aug 2026 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786323660;
	bh=vdF3zPpBYiP7ZqbT7UuuwWfwRWyUp4mLxsOeCwkMliI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ghC26GYFzf6x6EUh2KwRZF3NVbrHFTLJcaePiEeakOOLlInjOlX8BMdMe47OgizWF
	 0fWg56ARO98lwyVuMf8Ph4gJa/lUgwuH/GKAwo7w4QqIsAS1LR9O2oErZXqSAlezFV
	 ACYUuXT4hAKObFZpM7jP8rzzQiZbKxmS3XMtX/gHTHomH7gYCIOROKaM1FWRBmIK7k
	 c4lBiDzdxk2AHjrs4Y5aSzPWtTVT0T++YuHkjC+NJ/W2FVYWd/WycC8B9vLEMst3Os
	 2j6z1zgCItWxi2sJgrEtK5DPNnXjIb5KJkrJRIG0Jef2ytpSNPJHVW006Tw5lvIWFx
	 g7P/JHXxfSaBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] perf build: install-build-deps: add RHEL family
 devel package mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260810005127.289896-8-acme@kernel.org>
References: <20260810005127.289896-1-acme@kernel.org>
 <20260810005127.289896-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 01:00:59 +0000
Message-Id: <20260810010100.9297F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing candidate packages (like zlib and jvmti) are silently om=
itted from the missing packages list, violating the stated behavior.
- [Medium] AlmaLinux is incorrectly matched as `alma` instead of `almalinux=
` in the distro detection logic.
- [Low] The temporary file created by `mktemp` is not protected by a signal=
/exit trap and will leak if the script is interrupted.
--

--- Patch [7]: [PATCH 7/7] perf build: install-build-deps: add RHEL family =
devel package mapping ---
commit 09c82c9c3894b64680aa568b20137b9484ac96d7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf build: install-build-deps: add RHEL family devel package mapping

With the Fedora mapping in place, this patch extends it to the RHEL
family (RHEL, CentOS Stream, Rocky Linux, AlmaLinux, Oracle Linux),
which shares most Fedora package names and runs dnf (RHEL 8 and
later).

> diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/script=
s/install-build-deps.sh
> index 4a6f4bda49094..41053053a72a5 100755
> --- a/tools/perf/scripts/install-build-deps.sh
> +++ b/tools/perf/scripts/install-build-deps.sh

[ ... ]

> @@ -285,11 +380,12 @@ detect_distro() {
>  	id=3D$( . /etc/os-release && echo "${ID:-}" )
>  	case "$id" in
>  	fedora)			echo "fedora" ;;
> +	rhel|centos|rocky|alma|ol)

[Severity: Medium]
Will this correctly match AlmaLinux? The ID field in /etc/os-release for
AlmaLinux is usually "almalinux" rather than "alma". If it doesn't match,
the script might fall through and abort with an unsupported distro error.

> +		# All share the Fedora package names (with the exceptions
> +		# handled by rhel_pkg_for()) and dnf.
> +		echo "rhel" ;;
>  	ubuntu)			echo "ubuntu" ;;
>  	debian)			echo "debian" ;;
> -	# RHEL and its derivatives share most Fedora package names, but the
> -	# mapping is only validated on Fedora, so don't auto-detect them.
> -	rhel|centos|rocky|alma|ol) echo "" ;;
>  	*)			echo "" ;;
>  	esac
>  }

[ ... ]

> @@ -311,33 +407,73 @@ feature_tests() {
>  	for feat in $(feature_tests "$srcdir"); do
> -		if [ "$distro" =3D "fedora" ]; then
> -			pkg=3D$(fedora_pkg_for "$feat")
> -		else
> -			pkg=3D$(debian_pkg_for "$feat")
> -		fi
> +		case "$distro" in
> +		fedora)		pkg=3D$(fedora_pkg_for "$feat") ;;
> +		rhel)		pkg=3D$(rhel_pkg_for "$feat") ;;
> +		*)		pkg=3D$(debian_pkg_for "$feat") ;;
> +		esac
>  		[ -n "$pkg" ] || continue

[Severity: Medium]
If pick_available() in rhel_pkg_for() fails to find any of the candidate
packages (like zlib-devel or zlib-ng-compat-devel), it returns an empty
string.

Since this check skips empty strings, does this bypass the missing package
tracking entirely for those features, preventing them from being reported
to the user as missing?

>  		for pkg in $pkg; do
> +			if [ "$distro" =3D "rhel" ] && ! pkg_available "$pkg"; then
> +				missing_pkgs=3D"$missing_pkgs $pkg"
> +				continue
> +			fi
>  			case " $pkgs " in
>  			*" $pkg "*) ;;
>  			*) pkgs=3D"$pkgs $pkg" ;;
>  			esac
>  		done
>  	done

[ ... ]

> @@ -377,23 +513,31 @@ main() {
>  	srcdir=3D$(cd "$(dirname "$0")/../../.." && pwd)
>  	distro=3D$(detect_distro)
>  	case "$distro" in
> -	fedora|ubuntu|debian) ;;
> +	fedora|rhel|ubuntu|debian) ;;
>  	*)
>  		echo "error: unsupported distro (got '$distro'); the package mapping i=
s not validated on other distros." >&2
> -		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26=
.04 and Debian 13 (distrobox containers)." >&2
> +		echo "Supported and validated: Fedora 44 (toolbx container), Ubuntu 26=
.04 and Debian 13 (distrobox containers), and CentOS Stream 10 (distrobox c=
ontainer)." >&2
>  		exit 1
>  		;;
>  	esac
> =20
> -	pkgs=3D$(package_set "$distro" "$srcdir")
> +	missing_file=3D$(mktemp) || {
> +		echo "error: cannot create a temporary file (mktemp failed)" >&2
> +		exit 1
> +	}

[Severity: Low]
If the script is interrupted (for example, via Ctrl-C) while running the
dnf repoquery loop, will this temporary file leak in /tmp? Should there
be a trap, similar to trap 'rm -f "$missing_file"' EXIT INT TERM, to ensure
it gets cleaned up if the script terminates early?

> +	pkgs=3D$(package_set "$distro" "$srcdir" 2>"$missing_file")
> +	missing_pkgs=3D$(cat "$missing_file")
> +	rm -f "$missing_file"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810005127.2898=
96-1-acme@kernel.org?part=3D7
