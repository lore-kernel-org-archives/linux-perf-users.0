Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03E377A81
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189357; cv=none; b=ZRHmn8BF4awWK1nD2B9KxEV5FS493qmPrzkikrBfOynDzNdR0NXFg3/k/B1hWypMX7Isq3UJ9uG0hBnDGauOnix5IUqslH5YqYthPrIq8FvFRB1TxTU2roXhMu/ozcfL8lHOIQJarO6vPe9uKQE+Le4rONmJ7xNLw549KBXnbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189357; c=relaxed/simple;
	bh=jpI65m8xInRFwDKcompfjKFRsNSMQxQEN/04GXsMHLo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QBn6xXwXJZ9aFsCcrImiQNziEL3Mf9eWebjG8tiXpiqnLSxP0meza0yIJKyBnEf7k7DI5lO3x2FKDh5Dh26KXIvL49jAGUPkeUbVBPQU39zgaVWNvWUJzJt3CefqVU2tWYHTHBKwrx+lapn80FFy9MllLwPYghccd5MA68zlbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrDhzPS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrDhzPS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF11F000C4;
	Fri, 16 Oct 2026 22:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189356;
	bh=jpI65m8xInRFwDKcompfjKFRsNSMQxQEN/04GXsMHLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrDhzPS68rpQao4qDhGVCMn6eDlJoZUUt1X0f9SkZKj21AThTqtdbk5gN4OMD3xeK
	 1nAtxgJlPaJ8EFb4/weD7M4iq4y8PhJI6AOOIWYsHKN3aDaz3HyT76QmqPiljOF5va
	 gSgkM6LQ1N+XMgq3d8De1UBnvbUylSzKY0x7vlc+usAYphqUkrS/14mZiZWlt43gMq
	 /NiRJk4gm1/sby7KT/BNy/h3IjwJqDynDhL/T9OLgXVMveJtWIPVa+vrGR9+rjsYDo
	 viz5yftzYh9cGf+Zpu9LVzrG18xA9uDOzLUK8wuUDIYihc8ma+G1kuqxsLf5V/5BZy
	 KAo93R6AWgawQ==
Message-ID: <sashiko-outbox-175009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/17] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-16-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:22:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D15

