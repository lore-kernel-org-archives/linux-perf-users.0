Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041862;
	b=q8tVMEQjtiGxQLR3TAsgRFSp6AaE9uXKAvJ0u9x4yrCyMOAVYFZDAeVTGbggJGJY1fdK
	 4uYj1HPRHJAae14gOR4z5f1MO/2tLUCBhttRb1Rzh6niIwBtoSYU9Q4zPf/dHcfgoj96i
	 Qh3yyGYF/3ZU1jrHLfMhnLiVJ8l2+Zyc3UGpAg3Y/cEJyD8jdgosfwFoXVpsfkghb6HDx
	 E1AMYsrm0pNARQc4Aa7e/L0vxULJ73/Tfq1MJZ/QkmByycab7XJiQJt8rS8/A8sqdSFxC
	 fBeWl4HIRJsDwb5mXsxsoHt9MCcZpwdJYnHubO7svCPsS0fSsPbhcWC8HzxGeKgHkbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LHpAN8CXDYN/8APVaib1++PF13op2CPbwCkNZaApjng=;
	b=GZO/47zhUhcG6ZdolrzffCYhjKcZlwxvPmJar59EnfIDIkYE+ln51IBpjVK1qCB0aku6
	 gvwOy8s8A75sv3QZM55nj78a2A6RPJOqn4niEUWB0pvZNtIYkXt07kIQ1AlWu5Uu/rAEf
	 JFXvZqE3ZeNux1toMY/kD4/xMXz7kDnTkVMPRc2JC4oSElDjiVBE1gw7OFRxmeYQpQA82
	 OFVbvNd4J4rs25VZsO7Pa6ugSAqRkIbGRx+mQgZ7aV8oWn28A73fTlpiV2IvnDc3a0xDH
	 ++3hn0ED53doQbBQdAx+bX1vB5TCqb4275cQJjZjW5HTvwZdbhzlp0Kl/om+PhLkkjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e28vKEk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD4606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e28vKEk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9208B1F000C4;
	Wed, 18 Nov 2026 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041861;
	bh=LHpAN8CXDYN/8APVaib1++PF13op2CPbwCkNZaApjng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e28vKEk0fwSFFwaXLOXN820DJlkKMlm6LscYEfUCCG2RAfxlcFSJDh/E4emKvXVg2
	 wRSd87xuE8oUN3ZjQJsLQVcVDN2wp0Gx/h81WSYn7w8KMZCKESxTy8/rMLLnS3btlM
	 0svIFNYd9RxV1IRhWb+ZXYGcmBQOrosLGm88qBme73gzllxOJmLG9jfetZNn7QzSVm
	 xMdY8s0NDWhQpCTEO7mbp0Iuri0mIBDhO4vihtF1pqbPI3VKxqHuJKYa9ja/ngjJZE
	 4JN3Z5plwPfs9UgwTuuzYlHcn4jmEWsG8R/WxZ6Gwk1AuLO1W3VlZLTfXuxBJFyw0S
	 uMHk7FVBze55g==
Message-ID: <sashiko-outbox-222120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/13] perf build: Record the features checked
 outside FEATURE_TESTS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-11-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:44:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS, and
> jvmti and jvmti-cmlr are in neither list: they can't be part of the
> test-all fast path, which sets every FEATURE_TESTS entry to 1 when
> test-all.c builds.  Since FEATURE-DUMP is written from FEATURE_TESTS
> only, a FEATURES_DUMP=3D build, as used by build-test, never sees them and
> silently builds without libLLVM, the rust workloads and the jvmti agent.
>=20
> Record the display features and the jvmti ones that aren't in
> FEATURE_TESTS in the dump after the regular feature checks have run.
>=20
> Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-de=
v version")
> Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D10

