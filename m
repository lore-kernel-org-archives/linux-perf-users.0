Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909988;
	b=cc86m/hkJyyu1Y4AdZTpmY+kdH89I9YE0b6rdrOrbMMqRGCRZeOkts58k8sYD+s7DO99
	 PfGRjUhYjGUmUWnmce6ElXZ0SKVhNkRnXPNDMkLRJDtLULK6Tax/UlovBq6qi6JlXVMmm
	 SRyYR6iBWq9CUDDbgVXXkVR5MGHUR6X8q1ptHC9cY3sUbVaAXvBe4ZBageTTAOZ515iYb
	 2BQ5ytanjgt/zZV0hA7lQPZDDtjPrEt7CxUPLGxB0IkqqcftrY9SKqO4QqbO+V6CfjXRv
	 +FiEO0i4qvstBfn8HeZUxi/pJYVo/tDJEOAiZlyHl2rphouODWrZlBsxS072/9sIzwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7CFKzPPfLfTn3z+ZG3FILO68pI3g2UoY8ZREI1KauMk=;
	b=xluMDbw5x3vKgxSbyMK1JScPcpW1pLXrkRQzwze5gAbSR1sgSi7yL+WEU2mX5xo+JcnA
	 MA6TT+HwlPA3N9iwA44d0C5r2NpTNVhPCpi9+lQG1QdqK4ohquSQKhU5QkP9+iTad2Evw
	 4bzF5z+ICD+ChOnLLrdq8bIMaGzz2UzkVQX1p6+5Jf11oPLFtYoMAlnpPgMc1eC9BiGdS
	 DGSvnPyQhxt4/m0B0XlTdQGzoPS1tuInkFhSCvgjzfovPknkBWvv29O8JZ9biFJeZPd9M
	 Oji7b/a+OUwLn6X7ekhUHafHerPPY440U/XbT2ZvD36ZovfNPvQVB6o+A6QyUOFe/wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJlv+grA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D2606A329
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJlv+grA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598421F000CF;
	Tue, 17 Nov 2026 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909988;
	bh=7CFKzPPfLfTn3z+ZG3FILO68pI3g2UoY8ZREI1KauMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJlv+grAYlm76WIUwIcJQDxjKRaSe3ZHg5g4ll2UKi24nvw9+nDEwqVD88aOZQMs+
	 TDkGo8sD/o4EwZ9FJu0LGimPhL3ExQfseXuJqI+V5u9UprzodeloM16FiblwvURLf8
	 R6DADXDhOZGG10ibGpUqFXNbVRrt2Bj0WDVtC05P0ISv01GEHAMkvHIjP7XV5EUH7z
	 oJyPEKzWvlwqsrN2vAYLMs61PGFOMQVT0vnsyWryeM8t+808e41D969IKomHqOSIQj
	 bnkijWZyds72JN8j/kZFJtG0AQASN93HYg+wNdjixIwmbQSET3N9+LT47NFOiCubjl
	 DGdCuXO2/2vMw==
Message-ID: <sashiko-outbox-218569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf parse-events: free partially copied terms if term
 cloning fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117095603.2397-2-gubin@cmss.chinamobile.com>
References: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
 <20261117095603.2397-2-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:06:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> parse_events_terms__copy() clones the terms of src into dest one by
> one and stops as soon as parse_events_term__clone() fails, leaving the
> terms cloned so far queued on dest->terms.  Both callers,
> parse_events_add_pmu() and parse_events_multi_pmu_add(), return on
> that error without freeing the local parsed_terms, so the partially
> copied terms and their strings are leaked.
>=20
> Free the local terms with parse_events_terms__exit() before
> returning, as both functions already do on their later error paths.
>=20
> Fixes: 0d3f0e6f94ef ("perf parse-events: Introduce 'struct parse_events_t=
erms'")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117095603.2397=
-2-gubin@cmss.chinamobile.com?part=3D1

