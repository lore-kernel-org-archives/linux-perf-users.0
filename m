Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB90EEC3
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968564; cv=none; b=oAccBFLO9cnMMRx1d9BDoKaLxzX1sM2sMPEtv6ucCk1v2JO8PSEhTcmKRURXvRdBJoz0OqSiOU5Rpx1EuAnW7/cbt1OQob3Xf29imrskETkYpVhW6wZv0mOVCec4ZL/pRgtscJ1mXm6Ge34N/F9wKu9yq9d5mdHHRPCXXALWNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968564; c=relaxed/simple;
	bh=fM3k6FgEWs0p4Uye0lrI3G/J9MOgQRs6vU9CsIj1T+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SgQzDixhP+bI/A5/6bNL0YrTa2CNuhwYz4oVTs7/8UQ23+dM+Qjv5ti0i7iuO75EnOlmS3NKPb0mZY6/K8ileHUG/bPgjnq17PYav+O8DSmF8wB3ebFEVGhdd2Bg13EG5nS31wyBuu89J7tQp04PRdTQKbuJVNYkR8yvXbvJ6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK04hcTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK04hcTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727931F000FF;
	Mon, 21 Sep 2026 05:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968563;
	bh=fM3k6FgEWs0p4Uye0lrI3G/J9MOgQRs6vU9CsIj1T+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FK04hcTwSDsEEzyTvs1ZEL1Z8FEa68pqX/5mwyHL2DCQI2tif+dWMRSl0M0CiCu3j
	 4fCAFVe8ZOcy63Qady/3z3NHsF4hX547p5z5SI0gaeHjPlDqXY+UevEeCEaH1YN+8R
	 KvkM+4GNSPCJvVK1T+2QogD7iFmpe3Z2BsgNXkeaa8uRqES07QMOnCrKvh+14eRV/1
	 Qtgs5ZNFE8ZFjggZ+MN0uDV/oWh+AF1dK/pJ5p28Yg2IwaTbGTttRMatA79XWimHRe
	 ILNKllD03mLtKBJpZ4wwmLHi+BhkSLjU8NtpQmYVUEupjdsuK7Q6EiuE801oy8yXQK
	 WNKyCkrFDDHFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/49] perf build: Make pylint build test opt-out
 (NO_PYLINT=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <e09a629b8d92a9554be1f9a08ffcaa994394b8d2.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <e09a629b8d92a9554be1f9a08ffcaa994394b8d2.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:29:22 +0000
Message-Id: <20260921052923.727931F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D14

