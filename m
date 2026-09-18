Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7653B47E3
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742506; cv=none; b=eNMaZ3AckY8GhclP3xb3BO5tYqJpNO6v1vB0cNDkO/rD4KECdZeHB6dagMPI1c7modx6cTfXKBa6WA+cGbe0hAHEVxdi6rlmV7U5ZGbJ9BzvSYXYR9DzJjjpARwQATmsStSvYitkDaHCgcC13T+CFpvaYUfBfKYsiNPEGeGUb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742506; c=relaxed/simple;
	bh=hZlwNDdHbBpi+9+4ACUMyo/4EbiRlpyCvc9gvYeWlG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HHNGoWROOiyf0+jD+mpnkPYreqG5s3VOOddQsG7IYk0C6D3qU6+ij1H+F85TJGW6dQoaWdJ9akGsV2U2RKrLs4DoNx0iPGL72W5KcZDZ+eNCizsoIrbB4y2dc7/apG0llw5niwPfv5agjRvDXiuznqgb0iwUKOD5eTKt6HmWPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZG+vOvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZG+vOvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6811F000FF;
	Fri, 18 Sep 2026 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742504;
	bh=hZlwNDdHbBpi+9+4ACUMyo/4EbiRlpyCvc9gvYeWlG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZG+vOvl46FffRGpHzToilJkcMMOC+Wt7wf20CDA4Fga0UL2+7Qj/LLf/mOVD/rtn
	 E6NP2pbjpV6bBUjok4k5RdoXM2jHM+k2c936HzT/cuGc7E4dU+Zbo2iNmQpF4p5cqs
	 lPA8icfbgRg2HvWt62hwqEqmrj6J4TcIrVFnONBGGvdqwRULaHa+Cz/rm2Tsi19yg2
	 yqUwodW3bmrjxRAx2yyqyOnIK/i+kNE5vA1tLJs+WWgJfRPintS+lbGqUucuSRY0eA
	 OtUW5yzt2XqBI67ccPFtaHl+9q8VHp4wxWLbp6lTvOyr08RDxo0+Ashz+iJ6L5jQi1
	 edtvGAwXDJ+iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] perf test probe_vfs_getname: Scope probe name
 to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-12-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:41:43 +0000
Message-Id: <20260918144144.5A6811F000FF@smtp.kernel.org>
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
> accumulating a set per run. The fixed name at least meant the next run
> found, and went on to reuse, whatever the last one left.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D11

