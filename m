Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3C2DECD3
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783471; cv=none; b=n6x92nYqH8pr4mMY3PRUcBICpwa6EiioOJXAelImMl/ckn8OKxpHVp7wbpAuaDk/TuLvqX872Ivq8i5PY4I4sGspKzo5bSfPP4HrZgGvbyr7CRUBco177xQv2KXLPHbGzb9h7wSeLKSkO06z6VGXlreUJVvVk00hMmEnpJ25b3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783471; c=relaxed/simple;
	bh=Yj2X9sCw/ussk+NZc1zjHm+pCKSQ5eE/21Rj0vC09b8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GkYiqU5fr4cZcgp7p4x+ROlDPyTZHzzUOtqRpoWMlVbWPkvkyTv7TbUOEe3e6ZvGZcG2SxARpYKwrKcvyXJTIHHPlhtuqnX2ZH3g92ldo02S+KMZIxH8wGxdttpXi7DsU/cHwJa6vOCRtPHbG+IogKu5EB7/07TtOgkh9an6rkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGAqgVAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGAqgVAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2621F0089B;
	Mon, 12 Oct 2026 05:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783470;
	bh=HBBh9I4Fh8j5ciqaBGFKbkeNRE7TJ15/XxFg6Nya/4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGAqgVALZSGGWdrihkUtZq5Z/YGGltwobeQmYMfj93BqAlYQQlvSB+WZarwIRc+eM
	 kLTZTSYNdCKS6g76PcyctUqvQtc3X2JB+ihO1rtDdzWUxDqWt9PjmNKM1Pp3yZTY52
	 yoUOOmvzQUxPtYX7xh6RP4wyVzpPK7/HCGgATVAFs4/QXUlKYRDxd/3s4hAO0V0Tvy
	 +jh6Ha6zIt+MLQi6/LV/6S1BpIvru/lphFiesWoNzFRjTy3jO4GgfyqE3KzNG8qXyt
	 GLxORkT3O/EtanqayX1DG0T+llaFLpZHml2ttQMpml+dGui406B58lKUPqwdamj32o
	 CrrQqd9bzKM9Q==
Message-ID: <sashiko-outbox-167678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] perf test: Fix dso data tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-11-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-11-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:37:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now dso__binary_type() requires that the target file is a valid ELF file
> containing ".text" section.  But the test only checks cached read/write
> operation on a file.  Let's set the binary type to bypass the ELF check
> to read/write the file properly.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D10

