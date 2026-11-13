Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604863;
	b=E4dC+qyh4hOxZGef8LKEYM5kbVfS3reie9amXe3YtgQfC5H5AV7LTFJtWxVPtJJ756TT
	 qX+09VSh/m1VyNvkOQ8Vc+tjl/P6LIwRaB8sTokukW/7N0WSpXI9WKWZo2+ZcEh4tB4IL
	 PHwvbHtlpIGUarQxHISXR5UPkEWeixpNLM5JKV42splgbWD5TyaHY08VcxHntbW7oA3Uc
	 t9KclL++W+Bl2jbItfo46+CwGsISIPMwP6foFQcx+UhIrQdPxSOLpdoKWKccdfmFr6tN4
	 N0fkZCkI2bcoUozYFBeudSpBUvXxJTDiR121moq4qk7F+pCbcDp6z7JC3jRdK5BaKTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/6hM+jsOlGx9ifjKYxuzS1BaABCvCFGoHI22NgKj2zY=;
	b=3B4iyCNDDAFqNKPbQSZauB5xLzXkLLZIQ2rog9fOFtG2frE99EfqCu1l2RA+i8h/bFI1
	 g6LHG40QBYsLiWT8nQAp2/iRexNVg+d2/pYLX9YHB00GEMkT7voQfADk2IPLwYFt1ZPcD
	 7fKGg6kj8fZi7B12+0GWGG4IqBTd6QLcEvrbTwaWa4w+w3ZRaq/wo4MejUw/LmeOHJfvE
	 /XS3oTfIyKiqtAH2YvtCh7FslEm/Ht3d/ZW1XZIKJ6wlN01d9A74ipj8n11xbNQwITi4a
	 ML5XcxQ8VQNJqU04La8m9Aosh8ZtXJS5XjMNtI5M/kJuoI43ufAl08QwmiNGVe6qaNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzBJd2T1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCC606A891
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzBJd2T1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC5C1F000C9;
	Fri, 13 Nov 2026 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604863;
	bh=/6hM+jsOlGx9ifjKYxuzS1BaABCvCFGoHI22NgKj2zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzBJd2T1alLl3q0coZ3uOGBfkyqeKE8J9QGZYBgwdJ9vuDmbSBw1xNEmhgS3bJZSK
	 F8Cg/I04dlFidvmPDwHfZ2Z5HDeb6EGFDUjlYbmW/cljqn3/7fIB5B7+1KzDlW7PZb
	 bUa2PvtxCw4dRl/FnJFYHNmTWFuoqFBsA1JmdqeCMrlfHsYPgadfzFVYzHcGOwDWXn
	 29du//Vsbdln9PJVboyxt3BoS0kb0BzGCkrZzy7aG3O9GvASXYZJAd+ZfbQrBq9UCQ
	 30av3piBB0oCVwmxQi8JvPYau5OCDTK+9A8xP7dF1goVWxJ1lxxEU2Y5iiSVB9NDMd
	 XKrYExGBssosA==
Message-ID: <sashiko-outbox-213711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] perf build: Default JEVENTS_ARCH to all
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-11-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:21:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf test: unused make_jevents_all variable left in
  tools/perf/tests/make
--

commit bc0eaefa256c7f8aa5fcdfd94d8c39345c28c3f0
Author: Ian Rogers <irogers@google.com>

perf build: Default JEVENTS_ARCH to all

This commit changes the default JEVENTS_ARCH setting from the host
architecture to all, enabling cross-architecture PMU event and metric
tables by default, and updates the build test suite to exercise single-arch
builds via JEVENTS_ARCH=3D$(SRCARCH).

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 5a04f67257acd..b69ddc9e1489a 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -77,6 +77,7 @@ make_clang_nondistro :=3D CC=3Dclang BUILD_NONDISTRO=3D1
>  make_extra_tests    :=3D EXTRA_TESTS=3D1
>  make_no_jevents     :=3D NO_JEVENTS=3D1
>  make_jevents_all    :=3D JEVENTS_ARCH=3Dall
> +make_jevents_arch   :=3D JEVENTS_ARCH=3D$(SRCARCH)
>  make_jevents_compress_none :=3D JEVENTS_COMPRESS=3Dnone
>  make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
>  make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
> @@ -172,7 +173,7 @@ endif
>  endif
>  run +=3D make_extra_tests
>  run +=3D make_no_jevents
> -run +=3D make_jevents_all
> +run +=3D make_jevents_arch
>  run +=3D make_jevents_compress_none
>  run +=3D make_no_bpf_skel
>  run +=3D make_gen_vmlinux_h

[Severity: Low]
Should the make_jevents_all definition be removed now that $(run) replaces
it with make_jevents_arch and leaves it unreferenced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D10
