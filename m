Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0A303A0D
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283305; cv=none; b=d8WYUYT3Jml7Fxk//MsYDibmAUnYRDpD2498L3GhoUIXLVlviqREEaMB6odL3dQM9x23BJbqIqu1X4JhCv1AHRwL6g1iAS1lBoUwShQLQVVj4tyKeRqsaFn6cMqTpD7BcuKfTj+o+mA8YfrtL1wBJIFnd2ZDwQYS4xDvLo0uv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283305; c=relaxed/simple;
	bh=6sUFEqhT+XrVkFuDqPo0cKP6wKUJqbPbmrA+bVzH6z4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h++21tNazCoMnUjjf7LL4Htq/RK+umL2e15/Scl36h/xb2cKUu8rfm++ikN0VetIQ49RfFUCL/aw/hgOhEga0+ArHkfomYAZudBAZrFmSJbtBxM+mwJ44TZPgLG3xFfcN2cAfqGdVCTa7wC7MPvP6HQN0yApH2y5uUrJcZjj/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe0nuz7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe0nuz7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8991F000E9;
	Fri, 21 Aug 2026 03:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787283304;
	bh=PtBavAqPxGipAJxqDBYU2ZBoTHaMYzbCx/E4HeVS9BM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oe0nuz7Fk02b3Xi6hIs6PRWvEO2QSG+HgVtpHXngfQV6XM0Sio3FNyyjdj9sYb7An
	 N45DEyzTPYOxTAN6MaHZq86Z5mC4mVdAZ27y75jIjrrg68kU6cNMt8+u0Gd1F89uP/
	 svCR6qid20VWJlvArEaQ9kK0JS6/caxmlPts6z3xAD24YjwVvc/z5k+LuJ5pDTLwc9
	 yrFD1fW914TzSO1NETxaDay+0WLyc8fz8OXH/wN7Z3aJNJXb4rqQnrfxvlVJPMEQlZ
	 oPPAVj86aO0fMfnNHsE5CtQGd/vj7hHddGrev9lsPXWjWXDwm0dnIsG7BehCzcuIgQ
	 Fb9d8/Fx2HH/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Add rust target flag for loongarch cross
 compile
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Fangxu" <lifangxu22@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821032702.4258-1-lifangxu22@gmail.com>
References: <20260821032702.4258-1-lifangxu22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 03:35:03 +0000
Message-Id: <20260821033504.0C8991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing RUST_TARGET_FLAGS alias for loongarch64.
--

--- Patch [1]: [PATCH] perf build: Add rust target flag for loongarch cross=
 compile ---
commit b2d0a9ab160e1b008ff911474976ee4d8ac95e11
Author: lifangxu <lifangxu@kylinos.cn>

perf build: Add rust target flag for loongarch cross compile

This commit adds the loongarch rust target flag to fix perf cross
compilation errors for the architecture.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ba307e78fe1f..42c0ef2137502 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
[ ... ]
> @@ -1149,6 +1149,8 @@ ifndef NO_RUST
>      RUST_TARGET_FLAGS_s390	:=3D s390x-unknown-linux-gnu
>      RUST_TARGET_FLAGS_x86	:=3D x86_64-unknown-linux-gnu
>      RUST_TARGET_FLAGS_x86_64	:=3D x86_64-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_loongarch :=3D loongarch64-unknown-linux-gnu
> +

[Severity: Low]
Should there also be an alias for loongarch64 defined here?

Since tools/scripts/Makefile.arch accepts ARCH=3Dloongarch64 but this
makefile config evaluates $(ARCH) directly, a build invoked with
ARCH=3Dloongarch64 will evaluate RUST_TARGET_FLAGS_$(ARCH) as
RUST_TARGET_FLAGS_loongarch64.

Will this cause the build to fail with the unknown architecture error
because that specific alias is missing?

> =20
>      ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
>        $(error Unknown rust cross compilation architecture $(ARCH))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821032702.4258=
-1-lifangxu22@gmail.com?part=3D1
