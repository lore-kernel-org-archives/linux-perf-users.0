Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607236;
	b=qEvrlS6FK8SCMegvwA9YZXjivJssHocedo0r3aXMDsOlVh/+l/WlqaUfVTWYbaEt8tgY
	 G+g+X4TDj19+R+7yYooH5z1zk32jmcoMFBfkHmVpwzA9VVqa5uXfp9/VGywdX/81q8fTU
	 Dh9vdDcS9khoB2bkMvK+oyESXBHJJpePvjMVTWi4ZdKWgnDuvzJiGA+JHhURbXW8vGwDC
	 T6ocuq2N9gNX1P/G788VrL0pFajmM1nLWpUDeebow9YW0dEjTe2YhBd78df+l3s/w0VW3
	 SA/dNRHpaCGL9ArEJEiu8keZwsd8pWxJsZ3mAzdKoCGhK4fqAw3xDFLXLZ6v1Vikf6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QHFLCArVjtKUnUDvQj6C5PivB8O4Hi6vW18EskCv010=;
	b=M5LBM4/v8wx5QnDlGrAIQQSRjh9DWYW4bF2Z8gADB29uhhhAV7n/OuXiaSG6swNw1w8j
	 58QquFWSdGV9UIIEiHOyKJA/NEr+2LNJUanVKou6z26mI+CbrltZSBWclW7C8wkx3/ltl
	 vg/XAV2TuOe5ucgKBzDS3fMaFzd4WWg9MG5rdxPTis+vgtWXZlaKUDwW6svj+gkAJ9TGL
	 HRm2NKj27Av4pNk3SmpZvI5vT5jhEHX63/c/XLeX6Pqdu5gfCMhcmOJeg6kYUA++PdDFz
	 F518k0Mf5j8v8MDz3FO2BjS3u1Aamt7IHKGxInmzbs05iQeLQkqQaS81Jo16DCvEZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCBWU3i9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD453606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCBWU3i9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834CD1F000C4;
	Fri, 13 Nov 2026 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607236;
	bh=QHFLCArVjtKUnUDvQj6C5PivB8O4Hi6vW18EskCv010=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCBWU3i9GWvADsGVQ7QwcSrtS5ZkQoJGxvBrNR1mhHR7d8HRdtxGQ/N1EvzO8OrUz
	 N0T/xufpcziKDVe00fBb9foYgiFEGNlT+2TfvizIWrR/pGT3+e2Jq5P5SM+RUfPIVp
	 putBXRdLq8wbNtsVJX1NPychtZ2+GrmsRDf/YOF6XfaTURgnag1HGkxiD5Uah+TWgA
	 FQ0EHN28ieF8e+nJGjm97Ot9tNbrPc7zaGlG1NQbkQlVZPOdFHkssg1C8rHHGEcODI
	 BcSHvvVzEpTP4fx/FhE56JW4ipxkX3PdEQtLib730kgNZfwuv+b/fEDKkF/Mr33aFV
	 eHdZxx5/INK4A==
Message-ID: <sashiko-outbox-213762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 25/26] perf inject: Use generic hashmap for aslr
 evsel_orig_attrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-26-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:00:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert aslr_tool::evsel_orig_attrs in util/aslr.c to
> DECLARE_HASHMAP(evsel_orig_attrs_map, struct evsel *,
> struct aslr_evsel_priv *).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D25

