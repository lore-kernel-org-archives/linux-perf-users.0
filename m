Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39B3C81B5
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882305; cv=none; b=ajUds8uPPo8DIkB+FCv3d2LCNthfpbEtklRIc4VNmfGq1CibeIUV3p+PJ0g+v1OAbVlGc8pnierq2xWfMYjTB4JET17o5F16H9EOEYWxgV+/v5eFkaO50GxNLbYlj64MYrmb7MLkrmWz1TRN346FRjbb16kSMe+pKEjKKiTGAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882305; c=relaxed/simple;
	bh=t9OPSkGltzXFkdks1uM+aeTCF+jgRZOrvJ5Dy9I+G/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pMzAM+FEkQ5XnZgq+hzGVUOwH8qfr9i07L0BgA6HndnypwsATLdqCoZ/wUeFzxqe7m/bC472fHlTDh3EU0wLb16hD9mYhoCJ7j/0QTaKR60Dya1X7mPmu11aacS6vyQjgH8oDTzf63JnPxRFoUI7zFb+XTv+Omz4cmG35Bb4OPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrpP61Ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrpP61Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5051F000FF;
	Sun, 20 Sep 2026 05:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882304;
	bh=t9OPSkGltzXFkdks1uM+aeTCF+jgRZOrvJ5Dy9I+G/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrpP61Venm1l84XEM+2WmFGIKjdiFtL5zDREi1uV770meB7NqBcKMKPoTuEzgyxdJ
	 QPZDOcIy/NnGLqlbbLNgJTdSU6OyNJ01Lp355v6L3X7HPIVt0aWghKHHSyBmObng3m
	 TeutgswLn6CaZVcjHQA4XQDUpaR0uhkJ/waDQcIWthtf3xrxhw1QvFCtaXq8f7C+7+
	 ah2DS1Q1/yI/3FW3l8+J9S43Yl2XhMKAON+JG0V3Y0QQ//fvDWuheTpuwvnAkgjaA6
	 +6R3G/qX4AA3XcO5gCvpuIxpYiY/6mjJaqkD4fwA9sdCovaQxcc9gxPrlsDsgnIEQo
	 KoSqeMrcElNQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/49] perf python: Clean up pylint warnings in
 ilist.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b65be68e3d163b8ff889ce2d16e4d726d8e6cd74.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <b65be68e3d163b8ff889ce2d16e4d726d8e6cd74.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:31:43 +0000
Message-Id: <20260920053144.1A5051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace bare 'except:' clauses (pylint W0702: bare-except) in ilist.py
> with specific exception tuples (OSError, ValueError, RuntimeError,
> TypeError, KeyError) and use a safe '.get("name", "")' sort key in
> IListApp.compose() so that ilist.py passes pylint without warning
> suppression comments and handles unnamed PMU events gracefully.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D3

