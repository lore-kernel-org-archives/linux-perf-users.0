Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7F3C4565
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882316; cv=none; b=LUqQfTjVQ9cgRGCodZE0EhH6YMOk6bIvcx/SXVtrpz0GKylYsMSGQr//k0SVkt9ZjYwHb0100IFLG113hcLL5rcFmljE/3Qg/xyzGYnjc5kIKN2wAyCpK5bu8v34OWS5xVdu9A+Io3rSuzOD5dEuDHaGnUO6uhSJ2VbDowHZVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882316; c=relaxed/simple;
	bh=nW+QknNdHTC7Ocvt/mRMFN/nbHs90TKf0tFgjLFuc1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGFUFMtwZwO+0rAFyqWPL8Nn4I4RMNqhx171DLtjjhKC6HDUFmLyiRFxHwWG6Lqz0+Di9W8+TnbzCMwGcm5o+xGcg+7l3zXDvSdSXZdtj9KC33PgxW4ZemLUecsLGNrmCLtmXo0QARJYuQAdVQKWioq8KvGBospxLFDW9pcflhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h39JBqDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h39JBqDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F611F000FF;
	Sun, 20 Sep 2026 05:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882314;
	bh=nW+QknNdHTC7Ocvt/mRMFN/nbHs90TKf0tFgjLFuc1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h39JBqDodAIDRRzyzvhH+dNY/UuLvMfo2PUrv+V7jBfvvdkcp9NF7PIcplm0Tk8Tx
	 WStF4DUm3rmSHDXi4nJaE0AuO1s9HGD5F4+bp6nlzE4vkxahOKCNnL+I//OxYsvD8D
	 6nDImZ36Nwpx7QBXuyapk5bP5m3w1gBi3WPNZ6mBXrNy6vN31x5GBHvVxTnTtznJmu
	 ikOISkkGz5s/n1j87QCPCCRAfDhST6rzZrPKqaOCjKGeheZ6cQM7eeLf5GX1BDQnRe
	 GqUyLFutU0M6R0ZjAN4bHYJCAMP8fF77Dj1TS0GdfgQF5g0xL8io0IlSujjhVg/I2N
	 LeG3E2gYiHxiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/49] perf build: Make mypy build test opt-out
 (NO_MYPY=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ce0228594dc98299f205bbba86e1cb8220e78a34.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <ce0228594dc98299f205bbba86e1cb8220e78a34.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:31:54 +0000
Message-Id: <20260920053154.B2F611F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D13

