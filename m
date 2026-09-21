Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDC30E828
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968605; cv=none; b=VeIoBWBIn+iba8dCJMHorQYK6iBFO0OtGR9M7ELAKa9IcKVsnv0krm6SCHFqdlfZ+Sftytno7XzsoTMw133wqeOMZ0yQ58G+mySSHN/u4O2vF+fu3gBlxJeRByzxotBDFvStb+DUROkW7glJiTlQkUsXhHgInJoQnRW4seKdtBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968605; c=relaxed/simple;
	bh=tv0nJiFa29qwfFJF0QQ4GCkKNLLhODR2qzpXKQ9BlX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jz6ThFUi6kDulU5tBYwqzJ0hTcgdPC998cYKOKHUegfyXbLQp0/M6qNoR4HcZFJlEySIxHffGjHPVsl6iunA3f+8JvS8qeToHPrIC4eVrRskiCFNu+XNo5RyrE/WHAzaJMvMFnbxB9WVUcTZkJImfCa+hLKSav95EKqF8Vte9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+WqTMMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+WqTMMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A711F000FF;
	Mon, 21 Sep 2026 05:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968604;
	bh=tv0nJiFa29qwfFJF0QQ4GCkKNLLhODR2qzpXKQ9BlX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+WqTMMffOfiQWXytU+zxhk0gQIfprXiHIA7Npx0F1Rg88hRVL4WTWwOoq/dgs4un
	 IsPusDCEKmK/uCXwloKMh18tnc12EecAcuaMb1Pb/79IlQ78jv5MqCHU0/+aiyu2rP
	 ShyKNtvzjTVaDwOtByg9jHG7DTtMo93/zf9xgYsPuKatj487LlL0OQwsuRX9L2e8nX
	 2W+K07xwSRvWFO8w18PB/YJYhfxdSPyGzV5kPOvFAMdWLHqx6tecsXXX+T77eQwvY4
	 JWw2RrbkUBkhhbClMvbHVsm3aiq27yS6BZPRseWVIZkv3fY62BeOPfo9WK1ZCF2303
	 5mWRi/CHGVZqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/49] perf build: Make mypy build test opt-out
 (NO_MYPY=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7c56d15d6e61fabe8b94f5a98713305f15bf0848.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <7c56d15d6e61fabe8b94f5a98713305f15bf0848.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:30:03 +0000
Message-Id: <20260921053004.32A711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 168910d0f937 ("perf build: Add mypy build tests") added mypy as an
> opt-in compile-time check (MYPY=3D1) because of existing mypy errors acro=
ss
> perf Python scripts.
>=20
> Now that all Python scripts in tools/perf have been cleaned up and pass
> mypy without errors, make the mypy build test opt-out (default on when
> mypy is installed, disabled with NO_MYPY=3D1), matching NO_SHELLCHECK=3D1.
> Set MYPYPATH to tools/perf/python so local imports resolve during type
> checking, and clean *.mypy_log files in 'make clean'.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D13

