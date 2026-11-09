Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257944;
	b=Ut/AA4+PzuFdf0UgL84vExwZ9ewcdGwmaRrlGXyDLaQD/slNz5Shx7FEPkuDJOpupobX
	 BtgFai8oykKEUE6FzTTAyRVSg8baNu+pzB3vwasq3x4T92vZdOd4bG+1kS6ywboGRsRvO
	 sO+rLBTeR/aHKVnXgbFqYXEJQvlshwaouQ6uUJq++oV9lClRYsMstBjAL/RA8HF3wmtkb
	 AlVnbFaMoHK2qzis+II1zwMblYWvXspFGmmOuemzZfcQ7QDVa2jehtqKExgdbmj0YWqMo
	 /wg3kG6GRAzwPGGdTyCoNv71cjgbzOgrC0IJ+uf/puc/mm4l4K59DUOmMa14BABsImg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kgt37iJnnnkkErIPM3VIjKLz95WR+1mzv2UCRZ/PR24=;
	b=ekZ+EoU5MEQmOISDWv058UpcA4LRgFrp+jslS8108cH7tRHDJvqfqOFj7bUFbZWS+Q/K
	 +egXwtCYSsncEsx5U8l6z/XludO2DqrBJc06KKYeIci3a2J29Bokf2Nv6yyXGV/0fIpgn
	 zAlq9Dlvwm6pptE303wnGl5CiF47phacZh32Zt0D1E1vFxwzoF5JWARqrHhSVNdG+CUgk
	 KwokwaA7m9oTSEESa1e+ViOPMBto+aJgTpyEkWJbKxLnM2ndDs1MzR1cOkxcOaWLpn5Cm
	 GRNrxOWNPzal1i/oN5iad8NFdo6a+7kua0/FLYN1ku26B+f4/tmkIrIEFSuSmkhNRZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmpkSJk7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B79606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmpkSJk7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CA41F0089F;
	Mon,  9 Nov 2026 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257943;
	bh=Kgt37iJnnnkkErIPM3VIjKLz95WR+1mzv2UCRZ/PR24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmpkSJk7LqMQnf91zKBucyLxKhN/ufBrdUpBRrmNC3ZzsWC2STGSEdaSfRegiZn7p
	 TNTQT0wlTAs9IhS1hfI6eXf6D8eU6x7N07kRHugmNJQYapZqQLG/eRI+JvrAmaabhB
	 W6vRCiWysYM19HDhVaVLAyOWvvqPP+3KdpQX3ae3QOwbzLCNaK0Vce+sQHJUquRfdt
	 Q13f7rgQFxxfdv4Tj8WTKwB4DmumZJCn5YkvNhdcCgUeHUxox0qgdCrVWvKKFfgotg
	 qzpTKjxkP9K+fgUOigTnQYTcAPcsY3aND4PfAdV6Em/5qJRAY1G9b1CS/ovQlH5S5W
	 ul1ZQteOmfgGg==
Message-ID: <sashiko-outbox-205620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/20] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-9-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:59:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D8

