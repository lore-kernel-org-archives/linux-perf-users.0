Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9411415F36
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189389; cv=none; b=ecnLYZikz6868c5ZOfoxKqLLr8zVMhGbQQUCHkw47vgqA5HDcLwSBYKk7IruyIXbwLfqA4sc+HW31Lox5ZrN1jHghAXLX6aqm7ia5jmAWrAA8QCbmErmNMWtmeuxeRRsQyYLvGpE44ZyT7Bbu7orCurEAGB1o5Q2jN4JFvLQTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189389; c=relaxed/simple;
	bh=BRrtNs9nDMCc/ViTKt9tykn4FBEQasxBsWO5336cWno=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f3IIRNMmWmQQpbHh6MkBglqnQucj3s92j4B081cS+yl0UaD1+cYItd4k6XQ2T802nzjiIUHU5yEPdWJr8KBsWZh5/Ww16A320Uvl7vGq8uNXcXd+ALSMvtL4sBCThA/mLHXqsxxcnTdVj2Y1PW9wkBsJCmObY22eRbuntXwzFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKsm1BjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKsm1BjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959281F000C4;
	Fri, 16 Oct 2026 22:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189388;
	bh=BRrtNs9nDMCc/ViTKt9tykn4FBEQasxBsWO5336cWno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKsm1BjICvTAAfRHKFtFphQktjx5gZTo3Cu3N+cYApTwD8Gvne5C4cwOq8gfVUCN4
	 LwH45a/fPodDRRg+fFUv54bF4CEZ0Nz0yUHdKo+MBYDLwziYcwAz5wIyJRRBzuiYzZ
	 wevGA09m4YSG1jQgetSrYqHD3pXTNyGlF8IIn0kKyLpM3+H7mrQkid83ihWhmw2/Ih
	 jo1yogImEpgoCfz9PZKQVLB0+ghQn9a2KMS5Ypy7GdIrLT60jDOwgqB5xpyXavUMNS
	 bcoxhPyTvj7RbIwVR13pCYgMXQbdEKkUs98dfbied47Fq6jDFX63FBZofR2qKoII58
	 hScE1Mvkn2qAg==
Message-ID: <sashiko-outbox-175012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/17] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-11-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:23:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D10

