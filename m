Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353036A34F
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648660; cv=none; b=DSJe7lEwDYysmsBmBtGndnkbIVlqJuZzI15fv37aXiMW82FApZUnRPhzQs7roXQgNDrQZHuAUjWpyQGIGazgx3URGeEWXruYXSymjQVbGsn/SHKIzlcrOekqyi80c5p97FVMImLyMKysy0cPXjMrQpEtXGEGAdggi5dfHGFqQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648660; c=relaxed/simple;
	bh=sKwb1prVJ09pio58PbFJQ/jZ+gpioraNBjK8vz7hx4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bCYggDPyuGwiVREt3ZBmnOjKU+/xLq/s96KQ3Aec5Z8drfETS4/m5wpL0D3LzCW+orHMPWECtXQ2OVkSinU53oeVg5s7MpzJp0Exf2wwkyEdIys17OPvIcVBWjsG0bLDr6c4LkdpYOUgMYZtZXKGU1wYLfIH3UHDlNFBF6SabFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia3WUXP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia3WUXP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0EB1F000FF;
	Tue, 29 Sep 2026 02:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648658;
	bh=sKwb1prVJ09pio58PbFJQ/jZ+gpioraNBjK8vz7hx4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ia3WUXP+EWqUHHja4bohnuBX2guuaDl0ExvV5BxmS78meNsjgxEn+ZjVvbLX0v/Ya
	 k/LTLnv5QJ2fKqSvqvu87MTgI2lJl6FVDpAnUGm+QL2wSBJywnGr4V0S5uukGD1tN/
	 TqDQrxWln6vFeRaFZxWOsZsavNjkEoZLb/PUc+eRDphlFLJ9wvJkqLlC4oaqVQalOi
	 0I3Cte0YiSBRg0DuqSzj5u1hujyKyey3jpPMVGvePOBomQehEAUzdm/CqhMC7qmMc1
	 Vd61zLGEOQYRvGnSkjdS1g6JeJPu7h/yvcu/fMFu/y0FXdpqbsAUjddkcM7+ew1+Mj
	 H+28wXLjlqJRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/9] perf test: Deflake Intel PT Python shell tests
 under load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-5-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:24:18 +0000
Message-Id: <20260929022418.8C0EB1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D4

