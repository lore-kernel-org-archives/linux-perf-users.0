Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A34446E4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148489; cv=none; b=UErbkEMVMYAZDTgLg8bdEvVuwrgqNGjqVbawBIowFpKu61LEOpFwj9kmZ2Rp2/vEbuYC3cMB4vkQ2xYOFsDwfxfPU7ZW4Zcis1l9SUxsYD/pF5gnghLTbscYQH1PwHY3qAI3Nx3os6CpiPJojWCdJ/iPjUpMtNdeRZ1mOBEc/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148489; c=relaxed/simple;
	bh=1Rpb13iM1yhDIybTBSf9lWWQi50ikv8j1/zHxli4MMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LAZBpIXjk6wGn1h/1IPalfUh2a+YrBJp0XVVB03JEN/754Gst1VonlC/73oEid0sHFsfxiF+syCCS/sftnhYYmbZ/WObjdYTEsr6eTZDcvGrddok6EN+fB2kV3shnmPqZgs7+iSHdm6eSCVVSn44l2SNZK1h3hVVfc2gq/mCS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaLUHBbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaLUHBbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A281F000FF;
	Wed, 23 Sep 2026 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148488;
	bh=1Rpb13iM1yhDIybTBSf9lWWQi50ikv8j1/zHxli4MMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BaLUHBbEWa3l2LJX6Hween4mo3bQTdPB9tJE41MEdNSbZIZjAlCAM0Qx9lJnAOI0H
	 jKNac8RAHwoKKZbiwaov0tMsn+iab6FNErNty52RDeLAcHdEhWspIMXduHU88Fn7og
	 UJMDCRL2bUZ7dRPrb1v5MWfA/mM2j0gMShHBMwwTXoq4n5YXkjewLgHZVimJ5uHugA
	 924310N0hJWvV/cjBDHz7GiYOp41TkcZ08GtUNIctZ7uzA1IBwzboowfvjYIPzsC44
	 UmdgXDzLYz+flPyKZdiadwmKG4oV19xoBXE7I55D1Rj7uBT6BJPVyYW+wkd4Fdftpi
	 +SaGLXed5i3Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/23] perf test record+probe_libc_inet_pton: Scope
 event to PID, add retries, and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0ef35340076ebce0f85b453c4e30bcdf6a660818.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <0ef35340076ebce0f85b453c4e30bcdf6a660818.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:28:07 +0000
Message-Id: <20260923072808.37A281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The uprobe name was not scoped to PID, and concurrent writes to
> `/sys/kernel/debug/tracing/uprobe_events` can occasionally return
> `-EBUSY` when another process holds the tracefs inode lock.
>=20
> Scope the probe event name with `$$` (`inet_pton_$$=3Dinet_pton`) and add
> a retry loop with backoff for uprobe addition. Drop the
> `(exclusive)` tag so the test can run in parallel during pass 1.
>=20
> A PID scoped probe is no longer cleaned up by any other test, so add an
> EXIT/TERM/INT trap to delete it, otherwise an interrupted run leaks the
> uprobe into the system. The trap is installed only after the root and
> IPv6 checks that `exit 2` to skip the test, as trap_cleanup() exits 1
> and would otherwise turn those skips into failures. Deletion enumerates
> the probes from `perf probe -l`, matching
> `^probe_libc:inet_pton_$$(_[[:digit:]]+)?$` exactly, rather than reading
> [ ... ]
> true, so the negation would skip the failure path and the test would
> go on to pass without having recorded anything.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D19

