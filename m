Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5B3CF045
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882349; cv=none; b=VBAr9s1TUsoHfqF7IDcZnHv9SlUWH6lZNTbiRnJOwo+e08/u9/uxN99jhhkYSvvIzS3Qn79kTKMMyPCJcRzzz4RB2xaA2wlyF5t7JLsnZ5vxBvHClkOXgdiAf00sn3r1W8VgbQeKgbAKhAK80JIGPrZ6NpNQbQP2m7v538Ax/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882349; c=relaxed/simple;
	bh=ULv0UVIjpWLzyVZZmrFBpi2NAlC7/I8tVZhRuGP4I58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohic7mUymRSCbxoyS5sCOGalcD/XDDMg+gT7ar8pIqQwoImZtu3yrn6tddDzKhfc0NfY8b1pK7m1ZgNZaCt6MjgNAB2YfH7l7lNUK+yBlnPZjoUWXnbwI24iBNUapBRoDF/B9lYbaSaBn8ngRf3Z4Uzz2z++IO7q1spfxQKHYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlcnBqRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlcnBqRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B5C1F000FF;
	Sun, 20 Sep 2026 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882346;
	bh=ULv0UVIjpWLzyVZZmrFBpi2NAlC7/I8tVZhRuGP4I58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dlcnBqRl9VjloCD4XgJZ5zuRJBRDOTYWjmZwa8Dxxr3oPQGmrrqfTUziBsAQMcPKw
	 Xwb59LwUeSTtLnbnrkPXHSUdFGNhLMjNfX1Xj8HfwOSDiASpmZojmMWSckllUz+/I3
	 8vGcGMP/cgmoX7Xak7XuHINCzNQDmtK1HiMAx/rOBLJcAvPUv0X/eqj16R102QKQZi
	 2fGAaegStFOt1gFv1LhMTUaNzr3SUoFBr/BHXonJwnzYAV7VexkkZTz3OvC417OadN
	 G8nZK/kzy5r1q9+GGe3/1JBtAaQRS7K2fzWw6OQpfcrXm1hfdJLCb9kLJm5I/TWIDV
	 PO61+qmjBPVMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/49] perf build: Make pylint build test opt-out
 (NO_PYLINT=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <faf4e4c1205cf70b39a39e784ed1d58300e938b6.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <faf4e4c1205cf70b39a39e784ed1d58300e938b6.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:32:25 +0000
Message-Id: <20260920053225.D6B5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 8a54784e708b ("perf build: Add pylint build tests") added a
> compile-time pylint check for Python files in tools/perf, but left it
> opt-in via PYLINT=3D1.
>=20
> Now that pylint issues across tools/perf/python, tools/perf/pmu-events,
> and tools/perf/tests/shell/lib have been cleaned up, enable the pylint
> check by default when pylint is installed on the system, with an opt-out
> via NO_PYLINT=3D1 (matching other perf build feature flags).
>=20
> Configure PYTHONPATH in Makefile.perf so pylint resolves perf.pyi type
> stubs and pmu-events modules, enable error and warning categories
> (--disable=3Dall --enable=3DE,W --disable=3DW0123,W0311,W0511,W0603,W0622=
,W0718)
> appropriate for perf's standalone CLI and test scripts, and require
> pylint >=3D 2.16.0 (skipping with a warning if an older version is
> installed).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D14

