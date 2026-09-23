Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87585429005
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188063; cv=none; b=cxrzzMpNj6PqdFY2rLbKZgkbRu6BHUlaprFckWoA15PnPISlhtT938L7F1+/Dh33ETConagm2CY7Ug2KFClGAkdz05ALaV1mcTiETNyDVMvEoVZPzXELiZmFO6+QmLEQdgeAoL/8ckIU0zziV7VN7T7c4HjMRWw72hJ+AcSr3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188063; c=relaxed/simple;
	bh=GCWgq9/HyYPNwHDfJ5UGb8q65Y5yaV9A4m8bQnQd64Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HXvUeCxsXbt2UkU+uqmoh9v3QBGGV5YZkIwOY2zXxkAADfc2Hz9tiYGUdg076kZvNwm60ctO5Uhi7WdUouEgbQ7+gEcEZ3TAiODJIos6465vqgbKJ4RhX+hEsL9W5vZQVAYWiZskBxWT2XMMTE6OVNa4QtaLmFkG785/m/bZGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5u2yNSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5u2yNSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D2D1F000FF;
	Wed, 23 Sep 2026 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188061;
	bh=GCWgq9/HyYPNwHDfJ5UGb8q65Y5yaV9A4m8bQnQd64Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5u2yNSwXV5GKwpyLZLQbg/r4rn/xH6xcZl+UV2xAebreHWq33EKJj+n9HS6uy7nI
	 FGv9s9gLfG04PH3/yKtwjvXDA9AOrlmyRTkOM7o9v/vTar7Pg3K1j4XyM6ze8Rmj3L
	 k41rQFiudnCgUvgSgbUDFTWINWr1+CvfqXrgNS169Ql0I5r+lLAAB1vjsLRokZkCeq
	 bo1b3ihFwyHZdehix0ZY6pfMSOABA0FWg3SIemj1gVEcvBTz1IKjY4hAqiExfMl/hi
	 0mLaok6U8to79FAaTSfumaaThM82jYeNs8l2bGYMAsJ8wbKGbbGd39wUCoVAFWdfsP
	 rQC8yYh5D+q9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/49] perf build: Make pylint build test opt-out
 (NO_PYLINT=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-15-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:27:40 +0000
Message-Id: <20260923182741.14D2D1F000FF@smtp.kernel.org>
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
> via NO_PYLINT=3D1 (matching NO_SHELLCHECK=3D1, NO_MYPY=3D1, and other perf
> build feature flags).
>=20
> Configure PYTHONPATH in Makefile.perf so pylint resolves perf.pyi type
> stubs and pmu-events modules, enable error and warning categories
> (--disable=3Dall --enable=3DE,W --disable=3DW0123,W0311,W0511,W0603,W0622=
,W0718
> --ignored-modules=3Dtextual,setproctitle) appropriate for perf's standalo=
ne
> CLI and test scripts, and require pylint >=3D 2.16.0 (skipping with a
> warning if an older version is installed).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D14

