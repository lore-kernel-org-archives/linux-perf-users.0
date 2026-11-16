Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811902;
	b=sUam6buW0sWLbYlfxArpp/oBd+kvfE9ixRYpmOKWeDjf/aoFMDyo8VHdoQV3a6qxjiW7
	 ztSGYdJ24uAfmHPSBl4OopDq5ZCtmgyzA57kvjNqc5l3yiUTrqbTavw1FLYZ9h5oxu0fC
	 T9B3m6wlpWzg3MeKrQ0A3kC09ncCwN375Vnp5/rUfGp/jCf15IrbyfnGHcWkJu7tmaKrT
	 lefIHJwrVluyjQOWEz/JysmwRM3TWhPUmtA3RIi8LMyhLqnDLQKkdSKOdMPruXNeWhSC2
	 GXCXbiyoFMa52794j2TnQxBpBAaJqvj48ufzGDOYnH+nSaZ8H+KmFQa051WaxyodH9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tqmf1LPq/qKxsPuzQcHz9B87QZgvKORXlDAIt2nG+4s=;
	b=bse0stFiPw+XOTcOKjZpuUbQlq8mgH3fJYQjJ8yYHr35t/hnKsP7kwlNbZ2WQaiIgBXe
	 ULRhEZOv5gM4bZN9t5PI0rmugAhN8ddNIzc/lcNXmQaWwUh9YNCpy3qzF9yVDhpQ86vEP
	 In/3g44ygAkPBiWHVhDySgGSCJKc32Rjjw9jt53fYoxEJ5m88m9L2mG/qwmFPtYZYygl+
	 8s9RTX6l0UmNWmyGKzjC9+q9CbENlF3AhnF23VC1wNIRu9KTh/Y9xAjzvnYNAyMw2clL0
	 iqI8vWRpdVwpexAfXZRiBdvnAAS33SfGBK1XmylRdZRvTEBUg5dqTorXGv+47LQVM6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IK6vpPne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FF606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IK6vpPne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113611F000C5;
	Mon, 16 Nov 2026 06:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811902;
	bh=tqmf1LPq/qKxsPuzQcHz9B87QZgvKORXlDAIt2nG+4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IK6vpPneh+OeLWiNMsk90l4/rRtcmcItFJNL9Qd+K8FIzRlqd25I2HTxxsGdPIp6q
	 tojy4311GDIPxc462eFMbjQ5KcSrRFCETGBbZjpaBMYlBS9+UOFcMaowM17tNjXhap
	 oZOTHfp1VdMItqMmknEDaePgx+mGgVd3aqHuoPAYn7PyuyEDkqFLKQ9paJ9BYYNSkJ
	 l+hiRc5IqQ6cqSpboAt/UTiYvgt/fJFIeFLG3EBwRbS92k3G3GZFccUE5aQf44w95f
	 RaXjN6uQPKfkPwFQ2D8kfNeHnNJ8JWoB5OGlAuvAOARVOjOOWVjKqVVHbFgUUyZywY
	 AdiLc18V/eX7A==
Message-ID: <sashiko-outbox-216336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] perf annotate: Move struct annotation to a
 hashmap and remove symbol_conf.priv_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-3-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:51:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, enabling annotation added sizeof(struct annotation) to
> symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
> even though only a small fraction of symbols are ever annotated.
>=20
> Move struct annotation storage to an on-demand hashmap in
> util/annotate.c keyed by struct symbol pointer, guarded by
> annotations_lock, with an atomic nr_annotations count so unannotated
> sessions skip lock and teardown overhead while symbol__annotated()
> checks the hashmap under a read lock. Return NULL from
> symbol__annotation() on allocation failure and check for NULL at
> entry-point callers.
>=20
> With annotation, TUI map browser indices, and db-export symbol IDs no
> longer using negative-offset space ahead of struct symbol, remove
> symbol_conf.priv_size and symbol__priv().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D2

