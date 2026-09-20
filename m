Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6A3C8C55
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882566; cv=none; b=WBJngMWdpHluwA4qqk4dDwhHuXlBaTmqVfwWCa73cIEo1J4iM5/VdJIIQ+yzlLWqICuU4FCYLF8nz1jsMceCCSaoTmXJlD6gfJ2dqAqGlApXTQ0l4wdf31/D8fdT+1gcF+peaLgRRZR8jZX64nGAVyw8/bu0a2ulYrp4rT/s5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882566; c=relaxed/simple;
	bh=2uVhkRVIrgxvhc23Bkam3pbIbUs7CzZqtcOr46a33ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QgY8RqQ5ZbEQCVy9OnILAcNe4Fpj8JfsFvGSOw5MTE33ybCfnZp9zoJdNY19hGMMtZj1z3SB9b+LwffNOWMwIZN7UsdBC/GNTcM/E0XHV/fWANQst5JtE/md+fUVjbBqZRefIFkQ86zgompy/2dL73ePVSmfGH/lCX5w+yo6gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6YNNbZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6YNNbZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05641F000FF;
	Sun, 20 Sep 2026 05:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882564;
	bh=DhMHxp5GHC1UXpxYVYuOtPlHyDAqxs7vrM6JPUvnqVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6YNNbZbGtaggZBzDsG0rLXfCz7UcZZ7ONYooWQz3FlEJ5WbJgd8jdKXIt64+//Qz
	 h3dWRNOKmUFA9v4MFxahRUVfvQB94xHO11yYnSsCDX1/Ko9g/p+/cE4T7YMPFmA8Ik
	 Ov9MCMYzxErnyW2AjRhzWub/FQog3WkVTjTyqRynew5lqqSkk7BbA5m4+GeWUIc7f0
	 8OnwboWLwsvwHcUE2ttUCNvgTer25Jgtx9Wu+1rsDEMV+PsXAxhCXMeDSOGIN+yGkX
	 gSXnQ2imixp94IGKweZV+mZa0fYenIMIrxh0W3B/MQbUr1lsEH2l5gfTQ3N8dgtymQ
	 LPTYykOYwGJ8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 32/49] perf python: Port sched-migration and SchedGui
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3e492b07bf1597c5bc0fb26eb081b84b96c05790.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <3e492b07bf1597c5bc0fb26eb081b84b96c05790.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:36:04 +0000
Message-Id: <20260920053604.B05641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port sched-migration.py and SchedGui.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor sched-migration.py into a SchedMigrationAnalyzer class using
>   perf.session for event processing and add argparse CLI support
>   (-i/--input, -v/--verbose, --gui, --no-gui).
> - Port SchedGui.py to tools/perf/python/ as a local module dependency.
> - Load wxPython dynamically via importlib only when GUI mode (--gui) is
>   requested so text-mode analysis, testing on headless systems, and
>   static analysis (mypy/pylint) succeed without wx installed.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_sched_migration_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D32

