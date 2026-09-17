Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542193783A1
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627707; cv=none; b=peHhtcLC9DxhcniYT5H20xWHFDBqMg+cbX37oshXAuDXyeSEq/6m0QNsIFkOWHJA4WZCgTIbaljtAnA9+p/QjH+jDUGOLjLHP74VDiJHEsk0KzOuu1HtxUYwMqY9bEARh9ZNMTWWzVL+XCya1k2EG28M9czTyFiQXGybySKeOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627707; c=relaxed/simple;
	bh=Sw1KsGEUfMq+F0erMtmcwpSl/QEdz4mUd3IfLXXEYzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dXpB+7vE5sYaONv6pTOTdRMTjgwjZ9Vd0MrQ4sPvo4ULSTkcCfmDvs4+e2NXPEs3gF9ynu3AoXIFV8EEWT2qSJAcmO2yK4Vv8zxMRGP3EVb7yZIPuNSrEEH2CUpZyKwLxesW+5IlrtWLi+XtUeilwyHKJoJ6/xneSdbh85+BNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAZ4x0WD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAZ4x0WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46671F000FF;
	Thu, 17 Sep 2026 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627706;
	bh=Sw1KsGEUfMq+F0erMtmcwpSl/QEdz4mUd3IfLXXEYzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAZ4x0WDcXPS+/P6QVQmJIGe8jCvMpNfNABPmK0YZWo3LezF9OcQRomEVufLvHKsJ
	 yXQpk3uVmgqCoLaMLLbIQkt72qSXgKmkZXOtmRIVuUXQWRXbLxQdesUITnW4/f4hA5
	 uGvxf3WBEMc4+dE6d1Xp85P+Svgw4/Olc9H3Y2ZKQrI5lb1kiUa2f/XfwdBrnfz/F2
	 hpRgCbA0R2JV8jnACxmvjROlItjYv0WnoIGzmhN3THwwv9z9NoUSF6b9P5tTmkYuGZ
	 Wt3sSJ84YgFiDBEicY8ekvoIUMrME5S6Gng8mAZC7iHrtWyQzGUJ6MHxPwLnMdU4VP
	 PaG6T79sQJOcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/13] perf test probe_vfs_getname: Scope probe name
 to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c389c325df9dfbc4e8a69bec2da2be75d7ee9c4d.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <c389c325df9dfbc4e8a69bec2da2be75d7ee9c4d.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:48:25 +0000
Message-Id: <20260917064825.D46671F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D8

