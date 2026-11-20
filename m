Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182426;
	b=3znnTvdyFUxlbGsi4dI5k3v3Fglfv3fuyaCrFRJWl0vWGYqIrq19yG/NrsL+YLXow4ks
	 IfgSc2JMhDK17ho3SCLvlQ3P7yVjwEGKSt3bC5k/ibm/xzTUQ9UUpvN3mmLvFFK9PyGzs
	 Aw+IHQuzLan0W4TUk2Aw8CLnUyVug99NIWl/1AM59Yjuho24hHCv9MAfnKniuZeHafcn3
	 FE6AJmn6G5obURutcQroP5GQ0/e2mtvH7Jk90AMBObzzA5C4ejgG4ZcX7i2MpYaSLAld4
	 /x6hjfgSs+w3pXzpSqGBuQEcjMrqpD33tkbKcr8mKRLUjFl5nxjj6FPT00L6hzz0BFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nvlL8d4osN4enrfNRZbYaNjHbLDQo00XIwjkskr6Bqo=;
	b=nOaaRzw01+YUh/aAbWm81pOabBBbYOAFA/4/iYWk1pDuAYiviN3AtaTLCOQrm3yULNZl
	 wVEKB6FgepY+NyIS6ukIVo1gu7JuEj+AdM0RLQjU9QHABe+Iy78KwaeWySOG+/nba6R6m
	 0GSfA5PpdeFE0AbkbLwu+qY8hOuGbn/2ScgOTjGwOv0K1jm7Yz2gTOxD+Ln1AgMsu/6eY
	 ZlBP747AwTz2O8TB3OAeChVGQlt2Jcf0YkfHM+y+vp880aR/Lmlm377slETNV9+soqck0
	 txXoFP9CUKeobCPUco/pOllUewflXH109N7YZ2AevzDWUWhp8SQIG5xnQkYdz96md6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wf3jI3B5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFF606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wf3jI3B5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69441F000C4;
	Fri, 20 Nov 2026 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182426;
	bh=nvlL8d4osN4enrfNRZbYaNjHbLDQo00XIwjkskr6Bqo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Wf3jI3B5VQvJsZY4ILyeAUelJY6RYet9N+CjXuIaMM38BKc2ZYHH3riapMsbYroto
	 8Qky+qOc1Uo2WP62UdXcpTZV7dGkec97SpWvyCbuiSzesWhJidxnkYgpQ2Y76uwrNr
	 JGXdYlHq9QQsZk6+IZtORQgcxUvcJBpm9uClogRHNnDMADVvaV6KnADZKud7ysfh6O
	 7LTFO3IumDpidkLRkUPu9Ny3AbNY74ihf7J/g1p7V4YrQSzP2sGCsQHdbCgLWh2Y83
	 5lJokSHthgwc/DR0AhRpIVxGwyhnqfrf1ts/+JPAJXdLz3qSPdIxjAVFMNcsMHBx/X
	 0OWyiGgt4QhUw==
Message-ID: <sashiko-outbox-225268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/2] perf jevents: Fail the build on a key the
 tables may not carry
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120134252.1036963-3-takano32@gmail.com>
References: <20261120060931.711483-1-takano32@gmail.com>
 <20261120134252.1036963-1-takano32@gmail.com>
 <20261120134252.1036963-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:47:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py takes the fields it wants out of each JSON object by name and
> ignores the rest, so a key that is spelled differently is dropped without
> a word and the object is built without whatever that field held.
>=20
> Compare the keys of each object with _valid_keys, the keys a table may
> carry, and fail on anything else.  The generator already names the file it
> was reading and the exception names the keys it did not expect, so the
> build stops with a message that says where to look.
>=20
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator on every arch directory, with and without a key the
> tables may not carry.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134252.1036=
963-1-takano32@gmail.com?part=3D2

