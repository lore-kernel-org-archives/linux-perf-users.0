Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942355;
	b=sgqdCSk5k++ytoTmcW0WfmvP3w+j1Ydg09U9DQVpO/uQMIaTy8pPZ0VrYLOhcIslzY5W
	 Y1ZNCC+334FfFyXokGQSk+NTpSfrPX8p7z/juTZABQ7oldVusTIqjDM8sByIxtBCNuSbs
	 ckq9P9mxmtqFTLqstJZFAO3vqwAochYLFLCa4NOvSEZkMhz7DDS7Fc5AwSihkLCQfbbB3
	 FH7wVNQxsBE7Ka8l7cdc4M1LlpgWFupaX5GovpQGglzbJJeQuOK12s/5MvmQkTkqm+SRn
	 goZllbjOuY4B9RicpBEwVfqcIzpBKsIJllNYWG19jQmjGUymKgrCe/NH3Gyp7yrt3rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A2Po/2MXN/H7kEr+luqJO980eZ+opo+jtch02cic5XM=;
	b=ZMxI8YhIOKAROlrLZQHb8itPdU9XrjUGnzK4b4YCs61YwIjkVI15vvgSR+ri1wPQ7NZM
	 Ux9bb8miFHI6IKA4IM7iAFqnHH/FBLMaIx9LpaB6eFuqeFbsWsAH8dKmDMTsMEGNGgco6
	 mfh/LCcKk0eKyFpNOwE+IJTl1qWqEbFhQZuJUY0M6LbDd3+SFWfR83hPgIES4zYja+rt6
	 ZC8xn4BGrRDOOd9e7Evk/XxinjB0VX/6EXjO8f5gfrLFvu9YQYzIyeWH8rWyag/VcUpKv
	 WxOk68VmA0uY1Zm/O2k8Ol+5cgzitcvFXgmVzZ2/fvcK8+n/IJs8we3b3o434QlLZiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNqmYToe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC9606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNqmYToe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A811F000C4;
	Tue, 17 Nov 2026 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942355;
	bh=A2Po/2MXN/H7kEr+luqJO980eZ+opo+jtch02cic5XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNqmYToe748ny0c108grQwV2vfcYQ2JkoDHVYbouYRrfi0Kt5lfIk+mneU6950nnc
	 QffdbZb4eGZeicy10KtsjaDeqssMwAaBrET9Sdk6CPnv9mQMLdq81XD3uai3jjZwPz
	 C27Pdzosczi2vdTPnPaZzfOLe5I7wB4g5wGUHVgOL2L2/Rd/G4Eg7JVSV4aagZSSJb
	 HsU+bXy0UHsPwKUNswOoCZNBV1cKRYuOHMCx6MIlAXWrSPruMhglyGcTB0ljcb4juu
	 +7eJicb1gjTWgQ4jqB1eUJ4sjc8IJsiWvj/+oUosj9WMNM/uFdwj3OEeyPPCDYA+oq
	 s7EjuKEzZRRug==
Message-ID: <sashiko-outbox-219437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/23] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-9-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:05:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Factor out dso__is_bpf_prog() from __map__is_bpf_prog() and update
> dsos__find_kernel_dso_cb() to skip dso__is_bpf_prog(dso),
> DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
> In machine__process_ksymbol_register(), also check
> event->ksymbol.ksym_type =3D=3D PERF_RECORD_KSYMBOL_TYPE_BPF before setti=
ng
> DSO_BINARY_TYPE__BPF_IMAGE for is_bpf_image() symbols prior to inserting
> the DSO.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D8

