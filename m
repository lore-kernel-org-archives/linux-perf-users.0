Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607155;
	b=Xvb2OYWJQ7xeEm4ImZcXIetE9n35L6Xerr10xZNWTSj+6UDQhi/Mqdb91GeDRTM7r93C
	 vGk0RDNdfeXHwG9sa9p9QkLIonA1T329lD7IEL0w2qDADP558o2qzXoCfx0vU3OwFCi1b
	 QQhKhNJXvaC98rUtGp0pL5cfquaD2pIFlfVpIE730Q4E3Duw8K4PVO85M2ZDOEts5B0Sr
	 33wBQ0ArqSWOZU7FY1LfryUAGtLpGbjLvbCth8oAabLVPKiQrclvSXHRm/IKJCJVDF1Xr
	 Q2pc8K81trC66IjPeneNyRpkOQFLP26z+eDiyxmF31ZlO/EIGjbyqaGH0vne9P+YajA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z2qa2PUjfSCHdrvkghJkWc8WTy+yazmY8bTiWbKolfU=;
	b=Kh52j4+QvZz33CHC2jkOXrO8fJlcLntKiLxwN0x9LGGkGpOwdQLORpj8yUg3FeGSgP9H
	 cr9H4O6wiTxcu2pe6hJkJ64Rs075CmnIZGzIauJDw7EokFvoCOo1GsXjR3rzVBHzz/Oh3
	 RUcOxG5vwUuC+zzFttzaLCj9OlAC478KoatRXQU943GCJ59Vrntw8EUv9pMp1wUXP1ivO
	 1x1RKHpjb6wV6giHI44hzCvogoHyLJmSCy/9qTAbNUredVydtVGUroNen/bHvAANpfHSP
	 CmTGuzc73bpKSg/aBBNTpkYcAlFXzlBaQSkbqZht7RaGy9THBTHU8ZaxeFPmu/qI3Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeRadc+g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE1606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeRadc+g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5482B1F000C4;
	Fri, 13 Nov 2026 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607154;
	bh=Z2qa2PUjfSCHdrvkghJkWc8WTy+yazmY8bTiWbKolfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeRadc+gEecjlpSnX8c2NuzxIV3cdmvbHxrYbn6Ox4atoWWJAKc09bYx/P75syj3V
	 CzX8NUbZJ+lXB61s12B4wj5sjBIAAdYEwMrhX9LnfNWfg/Dk2VFy6vrpvpahpj8c+b
	 t4wRw8L31XBD16wzAlYmFYLn7U9KYQp/rjfucbL2bh5IU+NYYNRlntIZyx6Vd1KS5d
	 /ZxH3VwMXWONG2DdcJoMZbf5WPoIA//PXs0LSWQ55n2es78Z0ZNzm6C4raRsGwDDx6
	 Tk9jHecuakopNxHTeDirVJ7vW9JdJwm9cI7/EWb/OKvW59mXv/FIWQ57I50/8G8WJK
	 rZWU9FTYEJ7XQ==
Message-ID: <sashiko-outbox-213757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/26] perf annotate: Fix sym_hist_entry memory leak
 when zeroing histograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-3-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:59:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> annotated_source__samples maps keys to heap-allocated struct
> sym_hist_entry pointers, which annotated_source__delete() frees before
> destroying the hashmap. However, symbol__annotate_zero_histograms()
> called hashmap__clear(notes->src->samples) directly without freeing the
> stored sym_hist_entry values, leaking every entry whenever histograms
> are zeroed.
>=20
> Iterate over notes->src->samples and free each entry before calling
> hashmap__clear().
>=20
> Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D2

