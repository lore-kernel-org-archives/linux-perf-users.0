Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD24322E8
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663725; cv=none; b=gPTZBpBAq9rN7H44lH83WI0v1m/K/7A9SY9UeSrvc+C5S5TpIGzKGzTBNn1cCxuIsh1VRI1sF6aMB8NMweZRvJgbUS+wCLiTyRd5G7xu5Dk6YPF+QXjDqTQlMgt0PELUJYOV9xEdUc2gGpQ2lZ5Q5h6tMaonB6xpqQ2y2iMWVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663725; c=relaxed/simple;
	bh=KWMVsPdgpHSyFs5UG29+rRmTfoxBSJan7DdakUkci1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F4ScCBa3X5iUXbNQvM7UxKtq0P+LYQ5FEwLdW6UuhSyBeWujabv1EsgD3DZjZlpU/m5f48qGciHtaiwBEErcl7uTXXJcb4WxY9BRBz7SRbad7Hue9/RmeLdr0TGlS/umtV2Gevr6LuX3rMJFNxW+p+N3rwYOlEGW6QAPDGqhIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqGOuZPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqGOuZPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A71F00893;
	Tue, 29 Sep 2026 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663724;
	bh=KWMVsPdgpHSyFs5UG29+rRmTfoxBSJan7DdakUkci1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqGOuZPXj9nndPvgig0COdVXrBCzwKt8hdLE7Yr2hpJkALAFXPcVh89+uFB0VexZ5
	 fIFXVhyIe2QO1I/c+gkgKVkgTrZQasPa/OZlRMsZ7d72ojCT39ZY/qMVD8TW2JweVS
	 PEDbKHAktqWZK1dbTvLmwP+HfxHN+nuvH26cXmdw6TtzexfTBTxrw7+bEawMQu7T6/
	 7FFb4bpekz4ClZceCkZjxEqWU9sgoeHo8ajp9fybscXDVwQ4M18UvlB04Pk83C5Tvd
	 ECL5ArgAYH44dJZO/WpWcxQdDqejL0HeSuA54InoOfFWn0ZPsbPoNjCGXOByedmN+g
	 Z/9sEMU5Byoqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] perf test: Deflake Intel PT Python shell tests
 under load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-5-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:35:19 +0000
Message-Id: <20260929063522.3D4A71F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D4

