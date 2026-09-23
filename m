Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099244605C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148516; cv=none; b=K0IxLgm6MNhzDPBCXyOm6r7bDPLOxmFkgbT4B5ITg2yQOOe2HN5F4UYrwy41idzijB5ERA7l2eYkNoPzQuvx4SBcQpqBBmmrU3Ev9JepWow238mfs+8VYdLs6gNJld+/yVVeIYMdMbxRdbrLjeEjcKrQ0/gXQsACFekSwaBuEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148516; c=relaxed/simple;
	bh=7k3wSLXp8tH4w2U2b4ZOWOY848U3AH0VOna/Lk1je7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCUyuhJWsbk/mPKhK6GkfC8xmusilAZkUOGzqZ42axSqH9cYX1NPqqMCFbU/QaCuXbh3XSOf/tPK4h/AGfLxnI3nhz6KT98Wa326eY5U1moF1JEqxTn68hL2g0gaw+KrmgcWFrSDiKbQS1i4dzPnsvAQ+pRKUWw+Xv9VsO2nd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awAXJaX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awAXJaX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9098C1F00898;
	Wed, 23 Sep 2026 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148514;
	bh=7k3wSLXp8tH4w2U2b4ZOWOY848U3AH0VOna/Lk1je7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awAXJaX0zbaK81N81Vwtik6Pk38UQ/3UOwlks75L+aRBzemJUG33wIknDBrfUkinF
	 wqtJd3MJHMSjiGUCIToDx2Ws9TnX/edpsjcDqwzdlOj1mHTy1rac7PPjLnNiigrjXc
	 LcLDKXDijhpZkYZXsGZJ8ZwzNad5D7uVlEM4TFKY468MJZBdHOnc8HtdBCgFO5hzNN
	 Dlo1+Pl0aax+DJQlSn3P7CrtdmFwOUBXNePMWCOzg/cmPSncroJujP31+AqE06Em8Z
	 sCUpR56su3v472Uw56blQoxblxjGhPq7GUrDA2jVswDkpHJby8bqxHUbAl8RAWHSXB
	 BIkBxYLcLzvIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/23] perf test probe_vfs_getname: Scope probe name
 to PID and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a894ccb359e5caada2243cb67a6ba041cd3b9b9c.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <a894ccb359e5caada2243cb67a6ba041cd3b9b9c.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:28:34 +0000
Message-Id: <20260923072834.9098C1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D18

