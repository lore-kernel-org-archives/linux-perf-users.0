Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA133CF21F
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882125; cv=none; b=B++SqazDVwFyI/cr4NpVlaVJDR15ob7ogXRdhp6sfrCkI8k8iwUp+RGW/ATaXirp3ra7bu/lJv3k94GmO8zMEtuqx0CU16LtnFAWkBWEZamTp2bU2RRBIsP71Yt8aIezbiTY2e5s/hSCxt5rPXsjKFylxDLeD6K3claa6pcjOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882125; c=relaxed/simple;
	bh=aY6KOjMHQ5vxAb3oYnYC8Fbho/rJyGZVB+DKx2Fp/14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FxS5eqeacgv00po63dnhQT50tgbR9PUgsrj35Zyovujr9ToTwoaLHi3srFlQNFMqf6fkLGlL+samHAOmB+aw2XAWVO80AdQVnjsOrsJk/bJB1AoMaPzlab6f6HSKQyP/AKd82Sz4QM1BO2qQ6mO/3n86cdi4802tM29XDwUpLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M60l50Ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M60l50Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DAD1F000FF;
	Sun, 20 Sep 2026 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882123;
	bh=aY6KOjMHQ5vxAb3oYnYC8Fbho/rJyGZVB+DKx2Fp/14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M60l50NyoZUyZt5zHs87ksiBD7WpQByNpyxh/aHvJQJWP/RRxOOLwtKg2sQaiH/bw
	 hX4WKkdM5TK9P+16XCE5KIr0NT75wOX9Cj8cuMd9J2FWTLzhLz5d61PXc2+TgkWgcp
	 RyUn6ZRFoHNbQIYPURPFs00uscmm+opXtaHKGrESO0ThQxcxcK3qVmFtYH4Czu0bqO
	 AsYnraIUGQe27qbeGGg+JXf/2/cTcYtJIHdxDRVg8gh95NVvQ/65Iztux7QKpRfBYA
	 Gx5stJ6iDZRlyfXRc6NTVIkQqRVIYwDHdkJ/lrtp0do2e7WZgkgfEEyY9k7/mNbSBC
	 CS3nafpRMR45A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/49] perf python: Update syscall format string to
 optional positional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f64b7f59e863302bb81c14a3a13af2e116d38b8f.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <f64b7f59e863302bb81c14a3a13af2e116d38b8f.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:28:43 +0000
Message-Id: <20260920052843.B8DAD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update the PyArg_ParseTupleAndKeywords format string for
> pyrf__syscall_name() and pyrf__syscall_id() from "i|$i" to "i|i" (and
> "s|$i" to "s|i"), allowing elf_machine to be passed as an optional
> positional argument as well as a keyword argument.
>=20
> Update syscall_id() and syscall_name() in perf.pyi to match, and set the
> return type of syscall_name() to Optional[str] as unknown syscall numbers
> return None.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D1

