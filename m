Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700718;
	b=qWcnRSImKKrfh0Edg0MU1dObNS+CbYkFrXBhZ0te+zwRYpDO2EH3hy6Gl7pHf557R0RY
	 uDSSABVWoPfwrXK3j/Kngg9FYVpKJr55IW5Y6sbheUZ3lStUOkVurTPu1//igZtv4R5ic
	 nmC1SfP8phirtWhbVs+/xfCpikTuadIU05GkIRlrniyGN59BNzYiFRKZfLsIScdu1ZHRL
	 r+/y9uHk/Jk/3VfK4KARhyvdGEDp964Hgeo2zsm6/ZQ0Z8BnuUocMf1PTvZ8HQOecW8JH
	 wKNoXvoQ+JC8VWvs92U0lqIq/4j3sb3PgIx38Z6ewEiapeX6CMvn+H9Jr9vchFiTYyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Sbsyc7DsEG4us9hJVxcRqvoD2ndc+1MMdWinIpHiNo=;
	b=Hl15IdCn3Pt2VmLPRuz++YUDOP1ApLW1Z8aybHspX/nMZFLjfUFPgVh9mgd+qR49HtYP
	 ATY+UTiWr8Hp55AQJDqiwi243j2cB5xO8zqZBgxE2/KE2Pkt5gyTpZYOgxIArTMryiCRT
	 9Ifh4nMbCn7E8dQGOlMTd6vlg7dZQexbvSL/VZ5P9w1yFZA+dYXxBDDNILigRb8pdazp8
	 mCT1mOU1ho1j6viCc+rrDWfIJSPXks5sBDHbT2bw2gXPzWJ3kvXvJqVNTvEjkjKHyu8Tw
	 jG4hcbINY0yAUBGPOoWtaE7Udwacuwvtk3KU1k9KpKQjKLxwtHoN9mDS8M71QRs1QkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUV+RefF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42474606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUV+RefF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9D81F031E1;
	Thu, 22 Oct 2026 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700718;
	bh=6Sbsyc7DsEG4us9hJVxcRqvoD2ndc+1MMdWinIpHiNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUV+RefFrV9Lticsu4ysUuSHa851XbjrtyN1v1FFjjm2nOz1iZgnm3GEzG7o5Ky0i
	 v/6oWLZoCND2fH882GXrTDp+w6JQqB+ukvXS8YCkSIYwQ8DqoyC04NfONCOOGJLPjV
	 8wghlOPF4dcYfsGlIfsu4dr3FSfyi+Gj/zuM19WVRh/Ay7alah4dQguDG5M4gn3C9a
	 cuXlEqHQxXiKst9WjbqMKIVSS+xBwH2oAgm8zjc9RC+oWudBhjvAJO/7ktG+ZMigro
	 e6Fbx/qQ09q6TNr826oKRqOGGTJbmK3mO89Iv4RTZ+drrBvvGpNQ1ulHaAt1rgsCTp
	 2iazmo2n8fuBA==
Message-ID: <sashiko-outbox-181997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/19] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-15-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:25:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D14

