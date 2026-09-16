Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33773E559C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539583; cv=none; b=dF7V3shcUrv/RrFS9MFJ46WKdTQs6OvJwH+5cidiEOl4FZlI9z7p3AXGm1hSHaoSAL3RU6OUbDiDABknPK1BCr02I5T3sVP3goVsXyuBx807ElNfaBtRD0ewjwHsNIfPcy0Ni+k6ZIkO7GfKSmV1CUoC0LEyyDwmNmLoi95Kt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539583; c=relaxed/simple;
	bh=WRrdRtq8pch1jKf5ZvonqoPGf3bRkR3OA7RdWkM5GaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aP90wI0iQZacIWHe+XCyU9xhuZyn5YOkH679lPPE/s1mMaijayniPskYffmRJjf9h5XOywtPnpmO9x75eHQ+ZTqfv+GsV7az2X0p/hgIBjm7AwtsIh09ukq8X6SP9FoF9aOwTHzkiy5qZba01QyKQqbRbeOjudmDLGZNKb2hw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3XwW7RM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3XwW7RM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FFD1F000FF;
	Wed, 16 Sep 2026 06:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539581;
	bh=01bewL0QfaGMiETHpIaYtj2ZPfmuLXliViDWZuGHIcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G3XwW7RMazYvWawflDZq1kRaxZimRpnUe5rQT4dF3nsmwhPa5AywwmK3r+CVMXyog
	 NlPISx0G5uDgtWb0MxDpscqlLcG+8DoCDBusmF3DaKJUNIiIVwUbeMNqm/JVZhh/DR
	 tTawx8Kgw9kFxoTqMFRlB49oAuSdVpuxRAnqLECVKFmCoxTGxgFQcT65M+VI9sI4Or
	 aarCvnErdEDLF5XUITRIASw0Z8RngtMe7/3wr8UO+lTPdcTNTeHK5AEofZJQ8UP4Vz
	 9UbY0DWgNpVbXjNubAclBzZTz05nHHcpUnCLdTLa4gw79cvUPvOqUFwsRbvfj2Wa8u
	 XOJffDQ+TOkRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf build: Use the given CC rather than clang in
 clang builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-7-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:19:41 +0000
Message-Id: <20260916061941.81FFD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The clang block is entered when CC_NO_CLANG has determined that CC is
> clang, but it then ignores CC and hard codes $(CLANG), which defaults to
> plain "clang". Building with a versioned compiler silently switches
> compiler:
>=20
>   $ make CC=3Dclang-19		# actually builds with "clang"
>=20
> Worse, the target triple is probed with $(CLANG) too, so on a machine
> that only has versioned binaries installed the probe produces nothing
> and the build stops:
>=20
>   $ make CC=3Dclang-19
>   *** Specify CROSS_COMPILE or add CLANG_TARGET_FLAGS for x86_64
>=20
> Use $(CC) in both places. Within the block CC is known to be clang, and
> for "make LLVM=3D1" CC is already $(CLANG), so nothing changes there.
>=20
> $(CLANG) is left as it is for BPF skeletons, as bpf_skel.mak builds
> those with "$(CLANG) --target=3Dbpf" whatever CC happens to be.
>=20
> Fixes: 4772e66cb45e ("perf build: Support build with clang")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D6

