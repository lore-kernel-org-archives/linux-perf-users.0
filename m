Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C8391E6D
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405041; cv=none; b=NDtI+Q7FrRlz9T7dqtsUuwSQIOv6tLrMCV2a7sPyckS4UDecXqapj71pDA+ZdcBSEaMVlgwEYxM8izmxfFiWjrwdh9+ZPmL0Khq3V9PJMtiL62lNmSgSCAw9yNLZTPlxQ7Ak/4T6mCanhnwSV39WsQpSqagPgleIfujiTKHE/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405041; c=relaxed/simple;
	bh=uAwSjffIhe3TrWxNXCGLQpUKTUrS83peg6NB+/MGyZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oelegQci2FdaAAwFsFrMdoLkTa6/uyTZGm3CV/NavUUIpKkPqIFPJSFCLRilfstJlprEojAH0b70wU5ZsuPa4TGZwHd5DYcbOt9I/sKFJl1zaqjX9AuBOkVHge2qqegwT8aIc6iuRXqBn3t6M77MAMHMSYplitf7NyKUr/zoIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSarFuDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSarFuDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824D01F000FF;
	Sat, 26 Sep 2026 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790405037;
	bh=uAwSjffIhe3TrWxNXCGLQpUKTUrS83peg6NB+/MGyZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WSarFuDQ+U2cvQlDWY8V+ptTFatsDH/F+MVFDVyRzo3RW0Hjl0o1NvScRvtEojQIG
	 OAG2jP/MbEP6awDCs8PT4GO0oBEB0cBEgu5cz0ILKOHRiQJh85CA0xBBWya0ywHiK+
	 DmE/k7FmL18Apkb902tqiTXppZIVyY6EmN4gy7xVsL+rL4drWrhACpl/Wgm6mlmfpw
	 NLOENhq4wD9vdFjFZddpxs2Fxfs/cvTW3w547hPqdGb3HDdSajBnQqPPaU6CoCOCwN
	 1j8OZMTMCYdBaLoASiQzTSWB0eTIczkzuS3fx0IyBc5ugKDE/Tvpjhe2aO7mlBow/8
	 mU9lJlBQrmDCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 47/49] perf Makefile: Update Python script
 installation path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-48-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:43:57 +0000
Message-Id: <20260926064357.824D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the libpython feature test with a python-module feature test
> checking for Python C extension build capability, and update feature
> test references accordingly.
>=20
> Remove references to the legacy scripts/python directory and install
> standalone Python scripts (python/*.py), type stubs (python/perf.pyi),
> and the compiled perf extension module (python/perf*.so, when built)
> directly under the python directory in libexec. Update the TUI script
> browser (ui/browsers/scripts.c) to discover standalone scripts from the
> updated installation path.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D47

