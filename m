Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8F3911C7
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665410; cv=none; b=Dt72bQ7TMHHipuHBXHNZ8dOVIikWGn17YQ/05pD2jdSV/Jp6aCFyE+S7sdGRsoowkJLvx4sB6D9HktHwNE7RR2QCz9I4n0/WGmGjtDJZu8TTB8nkU3R17Bk3telmRBQ7+9fGqo7z4BQJsQj9n4HL9Md3YbWz4i6hhucHbnnPS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665410; c=relaxed/simple;
	bh=Ixy3hXQKnlUU9VVsM8A5kOv1hlzGlL3zz9LEW2CsiRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=az+DSUO8WZoKl1Q12+yaji4ZMpBlQrRYZle69xQV7MtbShxQy31EdWbHa2Hb2/WN1Rn6KvfmcaR/3TgGWM65pB8OaI+CDWdmjXbl85hV/ZKN1Gsh/7vnHvhDxUouXbARxIjBBDM1rlQX8b+qVYqNXhla9MiylAKw9yL1I30LxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9giYKOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9giYKOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552B31F000FF;
	Tue, 29 Sep 2026 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665408;
	bh=Ixy3hXQKnlUU9VVsM8A5kOv1hlzGlL3zz9LEW2CsiRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9giYKOkeVb0h2ght4Ge/gNulOSBUZakH44rvlverx3cqfMs5RkgC+vuIeooUFPIJ
	 +BuLfDlfMwMn0525NeE2kV1ypyM/DjISJPE5cahzZIxTx7UiNJ2SNBEiF4F4APrn2d
	 A/VrDkLZH7jcvexG0LBsUSy2iRNOOMG/kO9LON6Z+9NEvKXtqRShU21fIaXpaPd4xI
	 NP6UY4GCVOBWi/RncuKjiSl9QEwue51lxCK2MM3VsK1LCc0DHLJ5Yn/UnceB4nKsrd
	 io5l1dBrtDrItVJaUnSEFNZvauZfWO27iFQU4m8M6hbcStbLtmycrTMWHimDElK5qT
	 YVWh73LFX3RFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] perf test: Deflake Intel PT Python shell tests
 under load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-5-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:03:27 +0000
Message-Id: <20260929070328.552B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In test_intel_pt_events_python.sh, test_export_to_sqlite_python.sh, and
> test_export_to_postgresql_python.sh, 'sh -c "uname; true"' uses the
> shell builtin 'true' and exits within microseconds of 'uname', sending
> SIGCHLD to 'perf record' before the Intel PT AUX buffer is always
> flushed under heavy parallel load (~5-10% drop rate).
>=20
> Sleep 0.05s in the subshell after 'uname' ('sh -c "uname; sleep 0.05"')
> so 'uname' completely exits and flushes its AUX trace before 'sh' exits,
> and wrap the record and verification step in a bounded retry loop (up to
> 5 attempts). Also pass '-B -N --no-bpf-event' to 'perf record -g' in
> test_export_to_sqlite_python.sh and test_export_to_postgresql_python.sh
> to avoid build-id cache and BPF synthesis overhead.
>=20
> Fixes: d4ce72e9e238 ("perf python: Port intel-pt-events and libxed to per=
f module")
> Fixes: 62d350135e67 ("perf python: Port export-to-sqlite to perf module")
> Fixes: b1f968c9656a ("perf python: Port export-to-postgresql to perf modu=
le")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D4

