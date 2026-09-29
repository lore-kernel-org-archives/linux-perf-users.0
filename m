Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D043E488
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663834; cv=none; b=SSlKoSnSoJ/QU5dWkWUvz81azetfkROTk0xfV8NVhosfEqAzbSTzebOSpE5biqLPDtzorfqDwpCgi/wNirwfjiABaMFsYpHEMR4xaGhFywycrJ7bcOjJ+mrHlGLmFDbbm4d4iMiUWlV4zAHGees+BxXuN722rdedZ8Zu2RC4KZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663834; c=relaxed/simple;
	bh=dDrMH8BM77pjLJMq3ANtRa1L2vK0Q2pg2oid3QKOPGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hr89zEOg/AFqwwE+ETrvJlrhC+eLQqLgahqlHVqo64dfoKw3H1Ul/nlH6OlfxTeeVwAKrJYWrn7V1lIhuplIVBDIBlISrX7Z+TbOzq7H7UtOeleUNyNKA2LlExqBeP17wGebIS3+An+ue3kBLg0RWYMgtrC6lspavYJljGNOzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Uk5KaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Uk5KaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEC11F000FF;
	Tue, 29 Sep 2026 06:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663832;
	bh=dDrMH8BM77pjLJMq3ANtRa1L2vK0Q2pg2oid3QKOPGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4Uk5KaBtsyjqD3nNmnrm9oZ7WPBeLBCxy9TQRHOlLzEdM/ZDOz5QKJv5j9uHYymp
	 WxcP95gsRn49IKnmtSjqNtObe+924kqUY1y5bIjjy9M2ZuZ/T2agpMathEHd0mH0dg
	 N9Z3ZOHh8c7d5ty1uMhPvmxX5G6PlndMhyl43tPxKgtTLoieQIOhrxWD+9IQDODMjV
	 NQk/QGzKGFkfOSS9i9NJ5qHN64+aOYWtVwVfcZfukAvd4jjuJw3eEvv38eClZOGt7c
	 Cd07pjhNzuuNcDlQE1+LbRqkBus86tdA0NGh+Pts+PGogQPNuX1s7X3LuDJUhyYRKd
	 KvFmo+QCY2Jsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] perf python: Initialize debug output on module
 load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-9-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:37:12 +0000
Message-Id: <20260929063712.9FEC11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Unlike the perf binary's main(), PyInit_perf() does not call
> perf_debug_setup(). As a result, the first warning or error printed from
> the perf Python C extension hits debug_file() with _debug_file =3D=3D NULL
> and emits 'debug_file not set' without a trailing newline before the
> actual diagnostic message.
>=20
> Call perf_debug_setup() in PyInit_perf() and add the missing trailing
> newline to the fallback warning in debug_file().
>=20
> Fixes: ec49230cf6dd ("perf debug: Expose debug file")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D8

