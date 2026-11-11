Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423743;
	b=D/oJU4b8WtMrjAX6DHMzZAFeJDomgoWRUSG/x1tyr1JYCiUCzaa5g9Au0N4qq/9Wv35F
	 djHNn6kHWOctIwh7n43APi6tOVUjyd4aHdWB9jVSgedTBO2Ki1OZECz7pqMe6AjbZHV1q
	 y2Ngg7lj2ZmTmv/3Y+krJZuSiN6lhhY7eNceisqJTHI+h736gtN8S4oJu2halEaCVrfXQ
	 fX8e6DDZqw941M7AjDCr22n3/IGpXkuFBnHBJy3xzopL6q+PXwSj7nBojADYNGsciYHTM
	 e9R0a5/jXb609U8M0LXWFVJzGnK4Vyr+vh6mzMGMvLVXD2HyWGqBC0ak169GT29LBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xtGnstOLF87lHvdcUYHrTy9fynepThITHeYwA0Wgbag=;
	b=vvYAv+JPdtwpiFipEYd9On6WDDGqpfj38zN4joA/t2VKHcWD4qzE8fNdq+h5NHTBSyif
	 0OSVhX6P732pBTOlRazgHn7MEm9v96CjH3Rn5Y+SqI4UHVcQ0eQSyFWV+pfY0LJOXrYzy
	 +kfhWYinr77nwg2swdnaoK0J3LqPNDi6rRYvr5/nImF+m7+uiwR26bPhLctohAklYztNN
	 RsCSkS+y59ryjyNwklrVl7PO/hc8m6JB5ogeOHzePhw/UE/m2rK9o/X0zPj3mAE6io1EM
	 fZGpqfuMkdJBD6bUzCH5n4LRyWLeFM19rIng85fR7vtgXRcJdEIS+oxWh6Q6mQ/IwQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Du6jEICC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B1606A897
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Du6jEICC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134041F00A09;
	Wed, 11 Nov 2026 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423743;
	bh=xtGnstOLF87lHvdcUYHrTy9fynepThITHeYwA0Wgbag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Du6jEICCPAA+hV4pc0al0M4DZSpaiTAtUuNRWBZByCIpFwEoZhtspaOZDk3g/ndTc
	 9ZIeuPBhNuBbqfN921qyUznglxSXX16UYZIDyU8ZfMfuJl9ApJReKebJ8hTt1AUNWb
	 CSHzO/ej2dVy6qfFkfDUyKl8j5gJRTfwgbivPuAtmNp0l38igOEmH3JJ7nqrWOnAr0
	 JdkC/KV24WS7adUchQRdJeHWBlQE9SL+KO0B+ZXHIgrC6I+/hzlg/iDe2MaSwReXOc
	 ttlvki7e5cwHqzzquTVU2SickNlw6mdDqCeujTQBQf8f/FcSg3/cL9VIvUcVMiRwis
	 i+XL9VnUSOgtA==
Message-ID: <sashiko-outbox-209518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/20] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-2-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:02:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D1

