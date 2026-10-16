Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3D377A81
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189270; cv=none; b=WYeY44Mei0x1U2XedMGKQa5iYSVYIhlcLVoisaUcmk5APhMoHvg/izrsQyuYU3kIVH+QQbmj3Dk4zhWCOih8+K00b6d0aP+Mz/KjuKBJ5C76nIQ+fif2f9J7VlHuM12nUxwmNt9rWdBOp0ycy++S274DeDZMre//4nosOvtNZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189270; c=relaxed/simple;
	bh=QJEpsQI69Cv+7rUrbLMls6NDncW4Z3syARujYI4HiRU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WZr41FShXHn4i3SEPGoYbJ+n8UCoO3t4WoLwlD2CCPM5oaQzT52wVQ7a9alF8tx1VxT3c7fdtP/E2UxgEpkEixnuGd/uQaWAT6AawlfK9NUHQI+6RJiPYFXCyGe9iN/7rzsrD6q3Q0SzAN51Nyg9iTfMAhX6exDzYj37riiE2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chbl33O9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chbl33O9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E161F000C5;
	Fri, 16 Oct 2026 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189268;
	bh=QJEpsQI69Cv+7rUrbLMls6NDncW4Z3syARujYI4HiRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Chbl33O9w0oaWhcokN89WV6FMFaerIzop6BrJb+bpxO6NbiwfJmqAvgDfdqWyoP5T
	 G7RphGKNGNpwAKJpkSNhOYdVYH4ma37dFpz19w3OvmoLAplOd239hA5RsyF2KOmPWh
	 eXizy4b/mlsmluBlKmsWH9Ue+IkqC+aMg5SII5VnviMsiM1g4Egsp8u/pji3jA9YmD
	 /fy8LLTnbJdaRruD740Ab++zgFc2KeRURIJ05gBmePKMIhPf/Yjk/gsSucjmBg1kHf
	 LeP3ZxQBHSPQwooD3Xv3N7+yTb7ASTYuthowetreyyEq5OZF9HBIBKmQelKNjwGZsJ
	 iMFkwrkNwNy7A==
Message-ID: <sashiko-outbox-175005@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/17] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-15-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:21:07 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D14

