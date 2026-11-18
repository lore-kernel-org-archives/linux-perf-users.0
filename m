Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042085;
	b=nzSlQwHZPFJdqL/V90HSrnalJOBlf0q950/K12vvt0qJFUszuq7gJe3QceRT8m6A22/s
	 lLIHSwsNJPq01ls5K/XbOeW+PptJLTCxZSaB5oCRECRvCZc7Sq/e0scwPGqQRZsw86CQD
	 UMPv+kofb4Wz6gFjaHojLH5j+/+JyTvvMJ1GF0rtiCLoGh/4zaTpUDVdRFy31o7byDo49
	 wtMI6ARstON1wj3iSb8VublJkBr14VCDMRs6TOQLJhOaQp+7uqEYonEdTJ+OgwMT+z+cK
	 hGtSut4Q5w+THialMM26TJUCLxaLYPwlOvVKRjslBs1CiFUsK+1LrefxBYZp9RI6ktw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TJi8KHQGWsqEO1LWoZf8Iqaq8TRSPQN6QeXcWPhe+AY=;
	b=fNRFBw/ktUUFsJhBaehU/ka9X+mASP98uSkAb3qoh7vYBgAAZua/o+agkKYBOB8HMIvv
	 La6sNnOZPnAvWg9rIDwNSJTE7+x3isQe/TNoC6uPfMWqdrtU/QRaBagAE2PLY6bfRkA3S
	 IVyRP6i5A2NVEfryWNBuhQ75TaBrSamchiA9OmFUWskkEhEU2xF2iXm95PsJ/99hplwRG
	 hN4oV1q4OVzyDzw2vYvzI+AVehygr/nvK08jJqSUGoH8iKWIOkQeeYC5pqxV5737UmFiU
	 KMaXPQY1OHEc4I5/L5IU8QCOZ/nrEfmfZsL9w7g7Tg7HZ7uUcaSR+u1v+pe1t12a0cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxJhWuSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74C606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxJhWuSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C76B1F000C4;
	Wed, 18 Nov 2026 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795042085;
	bh=TJi8KHQGWsqEO1LWoZf8Iqaq8TRSPQN6QeXcWPhe+AY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nxJhWuSuwvLP3svW0BgsABqCEwb2CRiInb3oK9cZRDfh9gwhhaozaACE79katAFAV
	 Itn7FYuSTwJhjM+W7tDRVVoPrjOuH4yVuBwXnevAgqjEGSlKvPbK8nPcE/Nx7RF4yO
	 HLk89FP24wnYEmztOgnIfIuJNoD/LlmxlUZNl4ykZEqYbrZ6sO/F9Lrr9io+rQVjSW
	 nITvaTo0QUjzJ5mu90Z3jgFdcPaD5tAjT5qr6A/FukYQ994Jl+jTd1jThrck3/pEH8
	 I34LzkpRHTaOv8Pi2hky8vvwZT1tzgF2Lr+i6gfT8CqUZf2puOwsgGZ/JcYEg97BK2
	 kaJaaSRHefNWQ==
Message-ID: <sashiko-outbox-222126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/13] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-3-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:48:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf scripts: TOCTOU race and chown on untrusted dir in
  mkdir_checked()
--

commit 7ab6984627c594b546b3004b18a620f69c6a9e8e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds a clang source-based coverage script for perf along with
make targets to build, run tests, and report line and function coverage.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..4176cdae79e25
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh

[ ... ]

> +check_trusted_path()
> +{
> +	local path=3D$1 raw=3D${2:-$1} leaf=3D$1 uid gid mode owners=3Droot
> +
> +	[ "$TRUST_UID" =3D 0 ] || owners=3D"root or uid $TRUST_UID"
> +	# abspath() resolves links such as /home -> /var/home on Silverblue
> +	# and CoreOS, so a link is gone from the resolved path by the time
> +	# the walk below sees it; reject one the path as given traversed
> +	# that is not root's, since anybody who can write its directory can
> +	# retarget the run.
> +	while :; do
> +		if [ -L "$raw" ]; then
> +			if ! read -r uid gid mode < \
> +				<(stat -c '%u %g %a' "$raw" 2>/dev/null); then
> +				die "could not stat $raw"
> +			fi
> +			# The mode of a link means nothing, its owner does:
> +			# only whoever can write the directory can replace it.
> +			[ "$uid" =3D 0 ] || [ "$uid" =3D "$TRUST_UID" ] ||
> +				die "$raw is a symbolic link owned by uid $uid, not by $owners"
> +		fi
> +		[ "$raw" =3D / ] && break
> +		raw=3D$(dirname "$raw")
> +	done

[ ... ]

> +mkdir_checked()
> +{
> +	local path=3D$1 parent missing=3D()
> +	while [ ! -d "$path" ]; do
> +		missing=3D("$path" "${missing[@]}")
> +		parent=3D$(dirname "$path")
> +		[ "$parent" =3D "$path" ] && break
> +		path=3D$parent
> +	done
> +	for path in "${missing[@]+"${missing[@]}"}"; do
> +		if mkdir "$path" 2>/dev/null; then
> +			MKDIR_CREATED+=3D("$path")
> +		elif [ ! -d "$path" ]; then
> +			die "could not create $path"
> +		fi
> +	done
> +	check_trusted_path "$1"
> +}

[ ... ]

> +fix_ownership()
> +{
> +	local uid=3D$TRUST_UID gid=3D$TRUST_GID path top=3D
> +
> +	[ "$ROOT" =3D 1 ] && [ "$uid" !=3D 0 ] || return 0
> +
> +	for path in "${COV_WRITES[@]}"; do
> +		[ -e "$COV_DIR/$path" ] || continue
> +		chown -Rh "$uid:$gid" "$COV_DIR/$path" ||
> +			warn "could not give $COV_DIR/$path back to uid $uid"
> +	done
> +	# The directories this run created, in creation order: chowning one
> +	# covers everything below it, so skip those.
> +	for path in "${MKDIR_CREATED[@]+"${MKDIR_CREATED[@]}"}"; do
> +		if [ -n "$top" ]; then
> +			case "$path" in "$top"/*) continue ;; esac
> +		fi
> +		chown -Rh "$uid:$gid" "$path" ||
> +			warn "could not give $path back to uid $uid"
> +		top=3D$path
> +	done

[Severity: Low]
Can an unprivileged local user race with mkdir_checked() when /tmp/build
does not exist yet and cause fix_ownership() to run chown -Rh on an
untrusted path?

When /tmp/build is absent during the initial check_trusted_path() checks,
only /tmp exists and passes as a root-owned sticky directory.  If another
local user creates /tmp/build before mkdir_checked() runs, the creation
loop accepts the existing /tmp/build without checking its owner or
whether it is a symlink, creates child directories such as
/tmp/build/perf-coverage inside it, and appends them to MKDIR_CREATED
before calling check_trusted_path().

When check_trusted_path() then calls die while the EXIT trap is installed
(for example during build_perf() or write_state()), fix_ownership() runs
chown -Rh on the child paths recorded in MKDIR_CREATED inside the
untrusted /tmp/build directory, allowing the owner of /tmp/build to swap
the child directory before chown -Rh runs.

In addition, the raw path walk in check_trusted_path() checks symlink
ownership with [ -L "$raw" ] but does not verify the ownership and write
permissions of the parent directory holding the symlink before abspath()
resolves that parent away.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D2
