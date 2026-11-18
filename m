Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039715;
	b=sxoBSUQy5aervFxgIPn5m4Sfh6G7DkAqpE1ni+VN+ibytBEYcn6loyNTZETSdCirOkZI
	 5iZ4Fr8AVqb4BttJC05RuQUoZo1tECIlurdYdpK4z1Z2vpYDZSw5qddGAuwOoZRNcYBN4
	 if9am7Q/rPqtBrQ+tu4TJjgpgl/jUIbh81l6qL+GaESc6+wTEoVFHc3VwvGjf5Kh1M2EV
	 vevPd00etvjIK2VS2WZRDJ1SWPcUTeYzG0ah5mwAQgeyT65CJ0T0p6zrv5o1/5bccfuXc
	 gWVnx4Ll3Vjuybw25DbgW5tC9oNluXqYxs7RBPC6cRA71LZvstsXbRJ7HXMnir2b1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p70yZq5VmOhyumP+G2IVlu9bz5A36q0HYxlSnsZAH04=;
	b=srhdLUpKT7C3nhcr/GlRLJ/41lI880f1Hn4IH0dv0wnAyiXskzfp2DSKGCzkwMfwOtjb
	 HyCAt8Pg79MWlf4C2e4wNXOihqz5eW3Z2L0pD9X3FX3D3SeWTIw5DUrEXo2UY0E4dsdQv
	 xO1iIyPNgsT0KlWlA1gtwidczvIiUpaR9RVAxaRFPzGf4FJ7LCRvFd9KoiEehphLehXZF
	 M9QTHQFju80U4FMkKoGigAWCw4IVcPdjxtNLa64W8FZbhc5aYZE6IHd0Oro7DsY6NO6VI
	 AJPGMXhw03ziDBkLezfOU9jIOozmoTEIueg/wAVNImu0J0ecI0Xu5z6+lrXyiRJ5nqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXKlCvSP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7D606A32C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXKlCvSP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587DA1F000C5;
	Wed, 18 Nov 2026 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039715;
	bh=p70yZq5VmOhyumP+G2IVlu9bz5A36q0HYxlSnsZAH04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXKlCvSPduB315j90j91Y+giSpBTvkMdi2Uiwf3qqbmB+oSNzzS1+RSvt4SuGEyS4
	 piYHPBdT+mTDFsTalMv6bi8vh8/gJ+nE1VwN6a1jeGblOMDwRRuEYBvPks1FhFY/BU
	 b33amhfKB1gRuz2dbLyEiZJQO+jvFFfhkvI1k0VX2k+v2mfxo7sNAEHP5wKWgeHIgv
	 8cTbnCWpEiYpOg2dnu4vftabMnm1fPXCQ4jPfPmhvjtN+I18XlSEU6Ea+o4O0o7EYz
	 PecfcxVgYZfVHd4n4Voq9JtFoX6xwSOsyv+j4Prc//LJHlJbK/yyv9EAvCzjOTVGay
	 knadJ5d9N2Rng==
Message-ID: <sashiko-outbox-222085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/13] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-3-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:08:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf scripts: abspath() symlink resolution and non-root
  bypass in coverage.sh
- [Low] perf scripts: check_root_path() leaf sticky exemption and
  unchecked state read
- [Low] perf scripts: fix_ownership() chowns existing root BUILD_DIR
  without mindepth
--

commit f925befacbe87aac1cdf421770ce4909c03a1946
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds tools/perf/scripts/coverage.sh and corresponding make
targets to build perf with clang source-based coverage, run the perf test
suite, and report line and function coverage.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..9c77644e77f91
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh
> @@ -0,0 +1,1114 @@

[ ... ]

> +# The tests run from the kernel tree root, so keep these absolute.  The
> +# Makefile passes FULL_O resolved with readlink -f; resolve here too so =
an
> +# in-tree build directory compares equal to the physical PERF_DIR below.
> +abspath()
> +{
> +	realpath -m "$1"
> +}
> +BUILD_DIR=3D$(abspath "$BUILD_DIR")
> +
> +#
> +# Root executes the perf in the build directory and deletes and rewrites
> +# its cov/ directory, and that directory comes from a file the invoking
> +# user wrote or is the default under /tmp, so refuse one owned by somebo=
dy
> +# else or writable by another group or by others.  Every parent is check=
ed
> +# too: a directory another user can write lets them swap an entry between
> +# this check and the run.  The trusted user is the one behind sudo, or t=
he
> +# owner of the kernel tree when root runs the script directly, as in a
> +# container with the tree mounted from the host.
> +#
> +TRUST_UID=3D0
> +TRUST_GID=3D0
> +if [ "$ROOT" =3D 1 ]; then
> +	if [ -n "${SUDO_UID:-}" ]; then
> +		TRUST_UID=3D$SUDO_UID
> +		TRUST_GID=3D${SUDO_GID:-$SUDO_UID}
> +	else
> +		read -r TRUST_UID TRUST_GID < \
> +			<(stat -c '%u %g' "$PERF_DIR" 2>/dev/null) ||
> +			die "could not stat $PERF_DIR"
> +	fi
> +fi
> +
> +check_root_path()
> +{
> +	local path=3D$1 uid gid mode owners=3Droot
> +	[ "$ROOT" =3D 1 ] || return 0
> +	[ "$TRUST_UID" =3D 0 ] || owners=3D"root or uid $TRUST_UID"
> +	# abspath() resolves links such as /home -> /var/home on Silverblue
> +	# and CoreOS, so the walk below checks their targets.  A path not
> +	# resolved that way, like $BUILD_DIR/perf, must not be a link.
> +	[ -L "$path" ] && die "$path is a symbolic link, use its target"

[Severity: Medium]
Can another local user hijack the default /tmp/build/perf-coverage path
because abspath() resolves symlinks with realpath -m before
check_root_path() runs, and check_root_path() returns immediately when
ROOT=3D0?

During a root run, if another user creates /tmp/build and places a
symlink at /tmp/build/perf-coverage pointing to a root- or
developer-owned directory, realpath -m resolves the symlink to its
target before check_root_path() walks the path, bypassing validation of
the untrusted /tmp/build directory and redirecting rm -rf "$COV_DIR/raw"
or fix_ownership()'s chown -Rh.  During a non-root run (such as make
coverage-prep), check_root_path() is skipped and mkdir_checked() accepts
any pre-existing directory, so a pre-created mode 0777
/tmp/build/perf-coverage lets another user replace $BUILD_DIR/perf
before tests or a subsequent root run execute it.

> +	while :; do
> +		if [ -e "$path" ]; then
> +			if ! read -r uid gid mode < \
> +				<(stat -c '%u %g %a' "$path" 2>/dev/null); then
> +				die "could not stat $path"
> +			fi
> +			# A sticky directory owned by root, like /tmp, lets
> +			# anybody create entries but not replace one that
> +			# belongs to somebody else.  Anyone can set the sticky
> +			# bit on what they own, so nothing else is exempt.
> +			if ! { [ -d "$path" ] && [ "$uid" =3D 0 ] &&
> +			       [ $(( 8#$mode & 8#1000 )) !=3D 0 ]; }; then
> +				[ "$uid" =3D 0 ] || [ "$uid" =3D "$TRUST_UID" ] ||
> +					die "$path is owned by uid $uid, not by $owners"
> +				# With user private groups, which most
> +				# distributions set up, umask 002 gives
> +				# 775 and only the developer's own group
> +				# may write here.
> +				[ $(( 8#$mode & 8#002 )) =3D 0 ] ||
> +					die "$path is writable by others"
> +				if [ $(( 8#$mode & 8#020 )) !=3D 0 ] &&
> +				   [ "$gid" !=3D "$TRUST_GID" ]; then
> +					die "$path is writable by group $gid"
> +				fi
> +			fi
> +		fi
> +		[ "$path" =3D / ] && return 0
> +		path=3D$(dirname "$path")
> +	done
> +}
> +
> +# The state file is read below, so check BUILD_DIR before opening it: a
> +# directory another user can write lets them replace state with a fifo
> +# and hang root.
> +check_root_path "$BUILD_DIR"
> +
> +if [ "$COV_DIR_SET" =3D 0 ] && [ -f "$BUILD_DIR/cov/state" ]; then
> +	COV_DIR=3D$(awk -F=3D '$1 =3D=3D "COV_DIR" { print $2; exit }' \
> +		"$BUILD_DIR/cov/state")
> +fi

[Severity: Low]
Does check_root_path() exempt a sticky directory even when it is the
target directory $1 itself rather than an ancestor, and should
check_root_path() also validate "$BUILD_DIR/cov/state" before awk reads
it?

Because the sticky-bit exemption applies on the first iteration of the
loop, passing /tmp or /var/tmp as BUILD_DIR or COV_DIR passes
check_root_path() and lets root read, write, and chown entries directly
inside a world-writable sticky directory.  In addition, only $BUILD_DIR
is checked before reading $BUILD_DIR/cov/state, so an untrusted or
symlinked cov/state is opened before check_root_path "$COV_DIR" runs.

[ ... ]

> +	if [ -n "$BUILD_STAMP" ] && [ -f "$BUILD_STAMP" ]; then
> +		find "$BUILD_DIR" -user 0 -newer "$BUILD_STAMP" \
> +			-exec chown -h "$uid:$gid" {} + ||
> +			warn "could not give the files root built in $BUILD_DIR back to uid $=
uid"
> +		rm -f "$BUILD_STAMP" || true
> +	fi

[Severity: Low]
Without -mindepth 1, doesn't find "$BUILD_DIR" -user 0 -newer
"$BUILD_STAMP" also match and chown $BUILD_DIR itself when root builds
in a pre-existing root-owned directory?

Creating build outputs such as $BUILD_DIR/perf updates $BUILD_DIR's
mtime after $BUILD_STAMP is created, so find includes the top-level
directory and hands ownership of $BUILD_DIR to $uid:$gid despite
BUILD_CREATED=3D0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D2
