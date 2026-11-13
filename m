Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582836;
	b=ssqHp+2oQtXd0NELutRFqBmJU7BXBZgvHlqZbbLfphxI9FNgq5wxK6iLAVhA3UuQkSaG
	 L+ut3na6w162yX8ntSwVuA3J7JbwJdmIdnsxw7N9JRy6COkjuzsh87FCS0x4EXuqSAZiJ
	 50iXziOd45YTIrM308Ncrmu0yfm4QmnxxIlskU0LURxTGCUV7Dk8MtkxHjbzYXI1/kktZ
	 uFf78uWszVrvtwbVTJNcSU79v2ECI96+OuznWsAmJVJz7ushvD3kGZB/QSMNn6GCbW8be
	 GZpQNUAcrdRTVa1tHdc2O9NCl6a8IhAK1KvkZhmA8FUPI6pFnZPnGglrNausmb4pzhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582836;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jvrEVxHGf2kkx1Ku6sQku37xzXaThiO3taTwWtCI0vE=;
	b=lD/EwvznRB0dyDBshAtZl63CpGlp3TtQ1inElgOfbQHHf/N5+Bi3KMuYkuXT1uuwQYHj
	 y0BAZjw6BumKTZ5KcseuxjvVVTBaeSBkB8ui+CwavehRpLLqUBSiUghlrOdyyiGXxiLc6
	 5prZ9tN11yexwFow2Duy3VUnCMKsdVbuljHNTgYwUaEkZfKL0A396Pe5N83nX7HZV36Mo
	 ztKR4CEiRGVmg3qaHXIcBmvpanh/pFRAIOHoOMGg/ayfT9vwoByMZUEiQinWgdHXpeMYZ
	 TwZ+Dp9nlVTO+v+N4fRPnAtWqJLdH/FvaNVE7rCuaz/V9GHv4xUCkmyYyZZynVX64Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUy5KRGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE8606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUy5KRGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B0C1F000C4;
	Fri, 13 Nov 2026 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582836;
	bh=jvrEVxHGf2kkx1Ku6sQku37xzXaThiO3taTwWtCI0vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUy5KRGQk3BFDwdfm63sEIHQdC9hasx5L+MuGq1Y+RZe62QD1v3MIqwPTlOBOBYjL
	 9O0bXwynogvcmOs+Zl3X/OEn6Dt0q8M+v51AjXXgg6P6z1y+Y7roxPSyePTaEaTnWj
	 fE6+sOMC3IiyQGuKz47oxKGsscYmnaeOvwPTv5yTtJvYuUDuAIDkH3AiM4eEN4WXx1
	 k851bI84pnCVpXywczKrVWlZD8VBzKsEVyavZgnBKwegGnEb4it8WVurb4+8OmgYD0
	 WugSYqkcxqg10XotOZa/b0EE/dnM+XsciDELh3Y5PFcaKKykqFocJBm9Imfrk17thG
	 mMDqyknRrXeyQ==
Message-ID: <sashiko-outbox-213066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/12] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-12-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:13:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>=20
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D11

