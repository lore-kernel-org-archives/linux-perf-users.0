Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007926;
	b=YNrnHczS5e5UdsxC728r0ST+jZsqR2yzx3obYdWfUIU4BDROe1Q1nlHd+OKDnqJr97pm
	 c8fVxNbkmU4kikDqX4ajFhubxFF0o/VO2D1AyE/MwYwHzVezu9BjXrJ49pkxSKRgs4F6o
	 5kXh6JQSa2i3W8mPHFVTrL+Iw4MvtDy25p9GPfHhLOHWdH+dKWokRibsXxjI9PNX9jMkO
	 L0fjnbKAQ7yx6ORg833Q5E7zPZzOgpApR2IeIe7unJwhO94YRUtMMROOy9eGCWVQ6MODm
	 EJXlMpWdy6WMU4DTe/qwS9Iv59r8zIxEILHgU6j9M2q1oXVidC8jh4DEVbZJl5plPfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4zUP/nLOZxg+kr+6KrwZ5nmN7Vh9TFd2zdx7PsIOzfU=;
	b=2jOz/UEx07MpLKKrf00bKIuxEjA85YC5xF1QOy771xDKZXC6DyWWosaE89iC0gJ57ad7
	 WBFDfE0HVdu7Ky0tSTKho2D6pb2ZF/OWMEseCpCGdHg1+50FYfgohYdA0BGZyPgYXKBJP
	 qxrooCuaYbMgH8mfT4+DAn603ZzwjsDvMDHCe0WBZdAwu0degIUnH5KZ7eJ3YrV3P/N1M
	 Y/abh/FhZrS0FZaE8EQJ7btED3c389GFVxHtMvS511OTs0xwVBeYi6TeBcB12Higc+bkp
	 jrnRWqgUr/q1+8OPQWiCqpUwtsLP6hi3iZeele2yIoLbVE5gaG2cfknWiA4WMNkmItA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOpAXc7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10C606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOpAXc7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B361F01825;
	Mon, 26 Oct 2026 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007925;
	bh=4zUP/nLOZxg+kr+6KrwZ5nmN7Vh9TFd2zdx7PsIOzfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOpAXc7D3IqMh/BR4RsBCnEGz2mELooQyj4A0YY8dOy0phTgf5/2hTiHp0yNnbgI9
	 ql0XNQlkYDadThsWgilUOfSmHirxvi1DKCPVWFpusOqudf4vJotLBXgE0pyc55WXMz
	 Q8xBiAwnwldVCoPGWkmoia6Vyktv1x5rKJUKt1JWiriGgWaTnDjU7T367Vxh6eXTeR
	 h/F7WTAuV9h8TxItQN5yFDjdpqdl8Ifwc5dmr+kjkauMdybSgDiOw31d/2Yw2uMyEA
	 Z/OIcw5xFw8E9aq+1Tawh4CH41J7uOrAF+OQOFOgMeK+aEe9IojKwZBEJT1BxNjVPW
	 kduyKIJrnwCFA==
Message-ID: <sashiko-outbox-184832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-6-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:45:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When tracing multiple tasks across multiple CPUs, kernel context switches
> cause different threads of execution to interleave on the same CPU. Witho=
ut
> context switch awareness, interleaved function calls corrupt the tracked
> call stack.
>=20
> Add context switch detection and per-task state tracking:
>=20
>     1.  Context switch banner parsing
>=20
>         Implement parse_context_switch() to parse context switch banners
>         (e.g. " 0) <idle>-0 =3D> migrati-19") in the trace stream, extrac=
ting
>         the CPU number and both outgoing and incoming task PIDs.
>=20
>     2.  Task state rekeying and migration
>=20
> [ ... ]
>         when context-switch banners are absent.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D5

