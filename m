Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F649E120
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187783; cv=none; b=a7hGY+VrX9fgsBF1yohCqSKkFxVXT5dOppTTV650gHGY3YKAhf4rXnwRG8a+XsrQRTJJD5+UyFU+tnDXA9jYwqdSjfH4PPjP46fZ/uo3tn51xTts8rFfYktiPE/VsOaxkxoMywWtiggoLX38cv/jUUFgZP96Augf+GiNXkYg5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187783; c=relaxed/simple;
	bh=ASoc4hpX9EvV/8oOKxBbyu9dIhM4jYmNVkFfNRK81fc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I5DUxCXUhMfsoepeo9hl0HDqVUACa9zVdQU+NXQV0Kj/DE0djlDS5mYsUoWX3RLpaIuhTIwtkQCHYk5s7az31LJ2BTDV0O7/DCBdDVQwQiYGM/aeqlJqul1OOmSQ88hjHMYP0SBsGtATUb2297wWaW/hVeV/7Yw1aKmsMZJ7EB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOtYQu7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOtYQu7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8441F00893;
	Wed, 23 Sep 2026 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187780;
	bh=luUxnxfIRwgccDYasA5YPg/gYkf7c4TQmwqYirszc+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOtYQu7NMzEBvfhR+Q8yOjrHDz+sqVqxBXFFsBPw+PUUUdcoXCYMtyYCD2+zh5eAu
	 I0YD8vpCCccrZDhHJEObBATwSu5XQg/fSEeXJNiD7NNaZB46C3s6zSCCCyVkdllRnN
	 fJcSYjcUcmAShjgKmCx+bn+dgcJ007xmOQYMIClcsak4mui501YzDsLP3rZtznaLFO
	 k8eMSr7wk9tP3wPL6LgdICk3+8AvTBhywRr81v9cNelPMks5b1J07neEq3unImhVE/
	 0gmLaTB8TtgHSbH3HEKXF1n5+W2MUznX+2eFBMURC4ntl1q96B/TiFAqkCqywepJE7
	 Sw+/z58PGJ0YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/49] perf python: Update callchain stubs and
 session thread lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-3-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:22:59 +0000
Message-Id: <20260923182300.AF8441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update pyrf_session__find_thread() in util/python.c to accept an
> optional tid parameter (defaulting to pid) and return None instead of
> raising TypeError when a thread is not found in the session machines.
>=20
> Update perf.pyi to match:
> - Set session.find_thread() signature to (pid: int, tid: int =3D -1) ->
>   Optional[thread].
> - Update callchain_node.symbol and callchain_node.dso to str (the C
>   getters return "[unknown]" fallback strings rather than None) and add
>   __iter__() to callchain.
>=20
> Also update treport.py to handle Optional[thread] returned by
> session.find_thread().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D2

