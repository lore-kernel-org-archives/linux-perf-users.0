Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6113D6664
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882004; cv=none; b=AGxeRygI4K+u74sou34L7PfLEljJvZRJj70ZyOO7gsDNh66DwH1V+9VJ7nOMIdpNbxmoZyG+4QoTCPYlk0CNmlnwuO3Wi+w0LC5afhCvkmzhZ/ednh9VYtjPMyzqmjMin0HeFLOuXHFUM41QCFPd1MVqfveNNZRs1se8TCsik+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882004; c=relaxed/simple;
	bh=Fo6xZL8UKzwu68CMRYB//E9f1ZTSLmhLcLZoDMCwDaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=reL1oYzLi06ODouZPUnSkghYIRzaxwgxOKyAWaTyt9LaTztYVT+G8gIwz/2vos7HiJL9Op+j1Od1jtyMj/ulgIOR21SGDI+GHYmCdxE1aPEqmVSm0NcggQvOpUqFB6Vcg1WIReB3IwBTQ3Cm/QaswMwpgDBLZWcL74hwhVrhJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba0hv88p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba0hv88p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C51F000FF;
	Sun, 20 Sep 2026 05:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882002;
	bh=NQmJmEcH4bY0pDBVIBc1v4EV6bUlttzKD/5MiDnD5Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ba0hv88pAV1aIjR1KH1OkotudMo+NR38HSmk4god578N1UKSd4QYk3jcNhgye9frj
	 wxKrUxmOSknyGCxSU2ZNYQJACEKnHrgAvnRsqItwH0Q6Z3/3bmSu4CobUSsobZrsgh
	 01t8socusd7Bl/nFol9R0Yc+OWd1i2JjirFgOlUGz7a9SHpMatDa+y/WiGz1D78BWu
	 NCPAyExz5MqcdI/jkJ8Zr+febiFPWLvhi/JyVRfPT1eH11gNbIG4p1rhm/O9Ls1WYg
	 sYNU9xPIEysHqTbm2BUfNsxT0HlZz1pJSuqjwqu9HkOEtj32MBC5p72Aclx4hNpMiL
	 hM3UCgX83FUGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/49] perf python: Clean up pylint warnings in
 twatch.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <04eae243b929ccafe1ed8d679c426dbd7bc40098.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <04eae243b929ccafe1ed8d679c426dbd7bc40098.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:26:42 +0000
Message-Id: <20260920052642.892C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in twatch.py so that it passes pylint without
> warning suppression comments:
> - Convert tab indentation to 4 spaces (W0311: bad-indentation).
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evsel.open().
> - Convert floating multi-line string comments to '#' comments (W0105:
>   pointless-string-statement).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D6

