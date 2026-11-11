Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427215;
	b=hwYOGDXgfCqzEMMANIQdTrptM5UKF8eldZ1h6c4KYRZMJ1p2gKJIEjZ+af3i/GGEFodz
	 PlEBtzKSmDoC/tgfBQwdBbc6W2g3pU5Iym/Pn2uN++Qzl1Br+IWOeWHkPs53hi+oGwg3+
	 z85yTMgUd/k0YQuhiyXn+2kdUgYFRJRNoAnRkAHYLQMLw+O5mLGGRy5LFT++UrJPNhQXf
	 hALSj2KLbt6VrDwhgGj+sPkjiiFRzeSxPY31hUavVMvlL+GXITO5Kqtj8yW1sbhBvqidq
	 U9ulaJjQ0ox2pa8tUVc6qgqLrgUd9rDZPN0yFIZ1vwVuxt+tIExRWlB+8vx3899FrwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PWZfMUcfptSjErqMoYGBqLNao0rXbTC2xXvpbfXB5oQ=;
	b=zNVOVkGFmaGbwbvkbcRex7n2tteUkb5gfs4OhdY/svRwj86ThZQzmUYpyAXNEGjVM1yN
	 pKoQkghUnXNhTAthqoBJCkW06J/Dy9JAYXNmPBS2IEK6ycR/HB3tj+NZXOfA1nLe/rlsu
	 pX9D3MP1lMJxxpf/mVDGvRXP2m6M24nK+xnGtjICAa7lTrPyZwcNzF+AOTM9+FcIH4DqQ
	 BfArcRsgl8/DgTBcj98PyWV8IBYs0Amsu60eFAJNS+cPiPSCprl/wgfGzlBTlo8pdalw/
	 LEwnAbEbyxPHai4vVQjNNJQZCwbmZAjLz33DtXffTbVe6NNXdmspxPd1F3nc/eVgwgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QngY/9qf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EB606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QngY/9qf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75411F00A06;
	Wed, 11 Nov 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427215;
	bh=PWZfMUcfptSjErqMoYGBqLNao0rXbTC2xXvpbfXB5oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QngY/9qf5ygHJfJp3yPUmOhjMBB3jgmt4vdXgX5dZPtj/kKlCv4gc9FKDlegbqwPR
	 fnv1PTgsweOfCefnqIqQAMMUm9M7xi+a7sUcC1Yw1s/drqyZvgJ6wTUSgLjk17sOYd
	 hRWMRH6oOWFn/NIwoAQcOTMppjyiERMJ89G5VMA7GVvZEmI2EcZFzrEDLLVcLdSY5Z
	 Lbp2r/lo+lPKxRJx8pU4TThZ7u4z3GAGCGE65LSpuznNtEabkUh1Fg+bqIY1r4tKT/
	 Gc9QcItzvei/A0BRL6d+BK9/55mxTWLLAHO/tLcpsUTnCcddgdp4U7F/oifSy1M9Pu
	 AKwy+XqsqO16g==
Message-ID: <sashiko-outbox-209601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/20] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-9-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:00:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In machine__process_ksymbol_register(), set the binary type of non-OOL
> ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
> machine__process_bpf_event_load() upgrades to
> DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
> dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
> DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D8

