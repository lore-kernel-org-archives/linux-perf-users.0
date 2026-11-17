Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946541;
	b=WeBwNhp8j6DkZnUkVwY0KQcjHOh24f1DhDG6XychyYV24g6tXbaTHeGwDcUVhGKBMkVw
	 GDOGgZBDVGGxOFby4mD5mDVNZI1hEp12W8I9F62cqLUamyePZK/OLPUa6JoW9QWMucF8C
	 6CjKsuefnCJmyX2XGX+bL85gh/Ks2l4zw39b9C7L7XhkqLuPxL6DSs+m1P8MMYF8Cti1/
	 K/PwhM4fBEkqtXl/aZcnRte2QGkIOEH58WPRfLiWwLXtlE0We/71+23zhVL6tVeRX8Dh5
	 KSiOshMU/RpWWrH28s8G329qdLeWPHgSnlkm5fv3XDzAvdX+kgQQYLvJ98V8YQFZ1yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3hEPjXRZkbrlqzOCVe/YVByoeEDfnh5V+TsURRUbhgI=;
	b=2ukjyveLSSowa2VDgtfhDPzMs4wWInFGFMzY1k1xf0bYshtd18U4ra/vA22KXgf2Ngv6
	 m3m6bT7GhW5Z4+k9+uEGTSlPAWyFDhqWyn8vcjI3vaYBj8PaYCUPQ7gRUMlfFqsPLYf9/
	 JaGr2hJuuEWpMWTgULCgfATV9Q3g1nLrT3ElnRH2aW9WVXZ7VGi9msgOmgIeI3Xazgoxv
	 c9A0E9ZgFeLSuacfaNqt464V7W2xcTlv4+jESaN5Kj3294u+ta5EFhbJ1VpihQAaMfDEc
	 wU1J/JEO2ArKfcRG3bFre3/GNXFTFVEVvN/K4MQC6A+WA4x0U7Es2WSUuLkiyXQVlug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geYLuc6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E5606A330
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geYLuc6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E969F1F000C4;
	Tue, 17 Nov 2026 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946541;
	bh=3hEPjXRZkbrlqzOCVe/YVByoeEDfnh5V+TsURRUbhgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=geYLuc6F4wdilT2Tll+bOJSpgZ9CFpVsdw9K618iUwe1WJJTBo+ML/dMYCUin5Dqb
	 ICYCF4feFaeeTxEn5lTtjgH+QOQFUUwLs0jJNjLxx6/0vV5fGTJz0tV3LnOmj5snYy
	 xvLCclX3QQM8SeFRgrs9N5rMaVVwyI1MfoLSn2zB6fDKpGSm3MkIi4brXJHCgiB+0q
	 1LzApzO53CtT632nRz/lvoFPHwh6Xt18HVCka18LPMGhrjrEbas4I5c0CuCcwWLtvY
	 gp15fAoGAoRFCMppQpOFwYfmtkLTzWQ5B4qBTJniPhvSoMwVFJ7vzl64MuIFTK+u/K
	 sKIRHFwKqrRIg==
Message-ID: <sashiko-outbox-219585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-3-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:15:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf scripts: sticky-bit and root-shell bypass in
  check_root_path()
- [Low] perf scripts: symlink following via chown without -h in
  fix_ownership()
--

commit a0647612ea142c35ebab221e54c45ab482f8b7ad
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds tools/perf/scripts/coverage.sh and corresponding make
targets to build perf with clang source-based coverage, run the perf test
suite, and report coverage statistics.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..073d665229697
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh
> @@ -0,0 +1,984 @@

[ ... ]

> +DEFAULT_BUILD_DIR=3D/tmp/build/perf-coverage

[ ... ]

> +if [ "$ROOT" =3D 1 ] && [ "$PREP" =3D 0 ] && [ "$TABLE" =3D 0 ]; then
> +	if [ "$REPORT_ONLY" =3D 0 ] && [ "$SKIP_BUILD" =3D 0 ] &&
> +	   { [ "$FORCE_BUILD" =3D 1 ] ||
> +	     { [ ! -f "$PERF_DIR/.coverage-build-dir" ] &&
> +	       [ ! -x "$BUILD_DIR/perf" ]; }; }; then
> +		say "Running as root, building perf in $BUILD_DIR"
> +	else
> +		SKIP_BUILD=3D1
> +		say "Running as root, using the coverage build in $BUILD_DIR"
> +	fi
> +fi
> +
> +#
> +# Under sudo the build directory comes from a file the invoking user wro=
te;
> +# root would execute the perf found there and delete and rewrite its cov/
> +# directory, so refuse one owned by somebody else or writable by another
> +# group or by others.  Every parent is checked too: a directory another
> +# user can write lets them swap an entry between this check and the run.
> +#
> +check_root_path()
> +{
> +	local path=3D$1 uid gid mode
> +	[ "$ROOT" =3D 1 ] && [ -n "${SUDO_UID:-}" ] || return 0
> +	# abspath() resolves links such as /home -> /var/home on Silverblue
> +	# and CoreOS, so the walk below checks their targets.  A path not
> +	# resolved that way, like $BUILD_DIR/perf, must not be a link.
> +	[ -L "$path" ] && die "$path is a symbolic link, use its target"
> +	while :; do
> +		if [ -e "$path" ]; then
> +			if ! read -r uid gid mode < \
> +				<(stat -c '%u %g %a' "$path" 2>/dev/null); then
> +				die "could not stat $path"
> +			fi
> +			# A sticky directory (/tmp) lets anybody create entries
> +			# but not replace one that belongs to somebody else.
> +			if [ $(( 8#$mode & 8#1000 )) =3D 0 ]; then
> +				[ "$uid" =3D 0 ] || [ "$uid" =3D "$SUDO_UID" ] ||
> +					die "$path is owned by uid $uid, not by root or $SUDO_UID"
> +				# A user private group with umask 002
> +				# gives 775, so only the developer's
> +				# own group may write here.
> +				[ $(( 8#$mode & 8#002 )) =3D 0 ] ||
> +					die "$path is writable by others"
> +				if [ $(( 8#$mode & 8#020 )) !=3D 0 ] &&
> +				   [ "$gid" !=3D "${SUDO_GID:-}" ]; then
> +					die "$path is writable by group $gid"
> +				fi
> +			fi
> +		fi
> +		[ "$path" =3D / ] && return 0
> +		path=3D$(dirname "$path")
> +	done
> +}

[Severity: Medium]
Can an unprivileged local user bypass check_root_path() by setting the
sticky bit on /tmp/build/perf-coverage?

Any user can chmod +t directories and files they own, and the sticky bit
check skips all uid, gid and permission checks when $(( 8#$mode & 8#1000 ))
is non-zero instead of only allowing root-owned sticky directories.
Because DEFAULT_BUILD_DIR is /tmp/build/perf-coverage and running as root
automatically sets SKIP_BUILD=3D1 whenever $BUILD_DIR/perf is executable, a
local user can pre-create /tmp/build/perf-coverage/perf with mode 1755 (and
a dummy __llvm_profile symbol) so that root executes their binary.  In
addition, an owner of a sticky /tmp/build directory can still unlink and
replace subdirectories inside it, and check_root_path() returns early when
SUDO_UID is unset in a direct root shell.

[ ... ]

> +fix_ownership()
> +{
> +	local uid gid path
> +	[ "$ROOT" =3D 1 ] || return 0
> +	if [ -n "${SUDO_UID:-}" ]; then
> +		uid=3D$SUDO_UID
> +		gid=3D${SUDO_GID:-$SUDO_UID}
> +	else
> +		read -r uid gid < <(stat -c '%u %g' "$PERF_DIR" 2>/dev/null) || return=
 0
> +	fi
> +	[ "$uid" !=3D 0 ] || return 0
> +
> +	for path in "${COV_WRITES[@]}"; do
> +		[ -e "$COV_DIR/$path" ] || continue
> +		chown -R "$uid:$gid" "$COV_DIR/$path" ||
> +			warn "could not give $COV_DIR/$path back to uid $uid"
> +	done
> +	if [ "$COV_CREATED" =3D 1 ]; then
> +		chown "$uid:$gid" "$COV_DIR" ||
> +			warn "could not give $COV_DIR back to uid $uid"
> +	fi
> +	if [ "$BUILD_CREATED" =3D 1 ]; then
> +		chown -R "$uid:$gid" "$BUILD_DIR" ||
> +			warn "could not give $BUILD_DIR back to uid $uid"
> +	fi
> +	if [ -n "$BUILD_STAMP" ] && [ -f "$BUILD_STAMP" ]; then
> +		# -h: find matches a symlink by its own owner, but chown would
> +		# otherwise follow it and change a file outside the build tree.
> +		find "$BUILD_DIR" -user 0 -newer "$BUILD_STAMP" \
> +			-exec chown -h "$uid:$gid" {} + ||
> +			warn "could not give the files root built in $BUILD_DIR back to uid $=
uid"
> +		rm -f "$BUILD_STAMP" || true
> +	fi
> +	if [ "$STATE_DIR_CREATED" =3D 1 ] && [ -d "$STATE_DIR" ]; then
> +		chown "$uid:$gid" "$STATE_DIR" ||
> +			warn "could not give $STATE_DIR back to uid $uid"
> +	fi
> +	if [ -f "$STATE_FILE" ]; then
> +		chown "$uid:$gid" "$STATE_FILE" ||
> +			warn "could not give $STATE_FILE back to uid $uid"
> +	fi
> +	if [ -f "$POINTER" ]; then
> +		chown "$uid:$gid" "$POINTER" ||
> +			warn "could not give $POINTER back to uid $uid"
> +	fi
> +}

[Severity: Low]
Should the other chown calls in fix_ownership() also pass -h (and -RP when
recursive)?

Unlike the find ... -exec chown -h call on $BUILD_DIR, the chown calls on
$COV_DIR/$path, $STATE_FILE and $POINTER do not pass -h, and [ -e ] / [ -f ]
succeed on symlinks to existing files.  If any of those paths is a symlink
(for example during --report-only, a subset -t run where baseline.txt is
not overwritten, or an early exit after the EXIT trap is armed), root will
dereference the symlink and hand ownership of its target to $uid:$gid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D2
