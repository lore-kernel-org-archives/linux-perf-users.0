Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C574EF149
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663935; cv=none; b=ln6grGKaI8zfK5iBATXynKo1Jq4Jn0AdASE0rjXQkpJX08PU7wxvjjW7jTLKu3//8z2tvlhQ8/VWzjfOwMaKmVexusObaEo1wW1gGs+JlNhqTT+055pW3NAhwZrCBftl3Jp0T2YL1Qz2HJR5sAnUhVLk4In2YkgZpFRt+HbADww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663935; c=relaxed/simple;
	bh=WmkWtVn3tiSrWKD9xzeNt0eXl8kde6ZDsq5A9dNJ4SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z7T5XLMF7aFyYI+BRsGynykKAWNOTFpsULjdFyPcAN32tChXurKvPr1ps3gku5OBkQcHj37Bt4uDVBPvH1qQNcoLKKOu9YmE+yVVwwD3qcsQbrNBNqcgWqs6O8Y3LNhE8OPQSmm2O25DVbaamLonUbdLJ61awYcFQwm6EhDMDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0dE2jUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0dE2jUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0345A1F00893;
	Thu, 17 Sep 2026 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663934;
	bh=WmkWtVn3tiSrWKD9xzeNt0eXl8kde6ZDsq5A9dNJ4SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0dE2jUfNwHt0sEqhm8NrmFIIMaSR0rAHBX9Xo9ldEIOFhnxoyAdLpbgP9nETCROx
	 /FLVsSXFt4XrwHda29fyrPC82g9IX/CRrlPurRHAUvG9vkz6oYPsG48/Bgy7dsnv98
	 Pq8yDTSJ9/moApnMr6LVVrRBo4ZR6SOLjEuybcQQwr0vJkxNZW05ZiuGGSoKdx+MFO
	 mQrqCEgKOUk42pIdEL+qWJGXRMgglNXf3HrfB/DLZ9jrS4DtIs/kSwFB+ssYxlwDnO
	 Nv/RoGSIT0Ltpu4WolGXykLRV1yvEzKqteP6+azm5XJOOs2arVlg01Cgr+iruo6ihz
	 E0Cw+OR6u4KUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] perf test probe_vfs_getname: Scope probe name
 to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <429c3fbad8f697a85d27ec976ff2bf88a5d17087.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <429c3fbad8f697a85d27ec976ff2bf88a5d17087.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:52:13 +0000
Message-Id: <20260917165214.0345A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The probe name `vfs_getname` was hardcoded, causing collisions when
> tests ran concurrently. Furthermore, `cleanup_probe_vfs_getname()` used
> `perf probe -d probe:vfs_getname*`, deleting probes registered by other
> parallel tests.
>=20
> Scope the probe name to the pid, and rename it to `getname_flags_$$` so
> that it no longer begins with "vfs_getname". perf trace calls
> evlist__add_vfs_getname(), which opens every event matching a hardcoded
> "probe:vfs_getname*" wildcard, so a perf trace run by any other test
> would otherwise pin this probe and make `perf probe -d` fail with
> -EBUSY. That also unblocks making the perf trace tests non-exclusive
> later in this series.
>=20
> Enumerate the probes to record and to delete from `perf probe -l`,
> matching `^probe:${vfs_getname}(_[[:digit:]]+)?$` exactly, rather than
> [ ... ]
> its siblings' probes if it ran alongside them. A comment in the test
> records this.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D9

