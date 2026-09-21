Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654C349CEF
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969106; cv=none; b=dAwBSz+tikXzoepZt+VWq6UpdWGiN/hFL1QlpV1D8NMsjDeDUBElMheMjXLUgJxLxW4QYCBDBp3ZheHcbOWKC6qmF50E3Zf9US7A/rqD099JynadoHd+aY7ESeXIX6Hxkk+dTTD99//grbE6HXizRiK6aQNft3dZGgwfxyubtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969106; c=relaxed/simple;
	bh=doiz3D9akS0NO+2Q9XShh+qwavP1VfvoyCvBsT5w4ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e6yJwTKVSy205vhhqXC6KF58zdBpu+YFxdjyqPesMSvzavVZ8xklirRB4qnAcSeGE3/6goQy3QtLvmZaNjw5ehxTdbqeZmBeFzFBhqs0wymv48eB2DXyd/dfF1qV8uPc0Cs85Dt7Z2oPZpVBzoB6CYmz743CYi4RgP5YqHGVv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jltzYD9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jltzYD9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3921F00898;
	Mon, 21 Sep 2026 05:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969105;
	bh=k9YLk0bmnqy4fe8RMCeGXqvkn5hF6DKbVp18GwHgy/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jltzYD9N0RCU4A2bpmDIhAaCi7TO6CYSPNqm3MELaurzldjmJoWS/MjclqOFvE6kE
	 CI/a64ACIsqUAH+zLjA/20p5wF5Dnf8EeYla8rvbTtYdTEvGXLLV6lIbSoPPfnB9jP
	 +96ONz0XorsKjCxULLSahW4/B/u9GQU+tR0M0Hb9Jm05zznH2pBQtCTd3aMaEbKE4g
	 mrhOucNjw8Q6GqUnbZ7ACmureB64en/RLZICIe+q0kswVlhdUxrAZmjKa56RMQnRix
	 johHpDy+uSPPiblbYvuDeNI8r6BH4iS/p4eqfeQerhjXcSnr8jtiqBUcjh3H+HV9H8
	 7o8m+SOh+TRSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/49] perf python: Port sched-migration and SchedGui
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <fe86471b19469468ec73387058a49882d8799abb.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <fe86471b19469468ec73387058a49882d8799abb.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:38:24 +0000
Message-Id: <20260921053824.EF3921F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D32

