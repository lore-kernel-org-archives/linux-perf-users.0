Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588637;
	b=yFVrEGyull4brRuZiBOl8FNvFsZxzJlWbQ1zrcDHHVVcu3dwaxEc2+uDseF+61wjuRTa
	 xUvndzgVmy2xoYZI71OPR+YIU4jSDPpJh2ZoNMGuwIrHnme9QqqROxYU95u9FU/NA3Yhp
	 iDx5IBy+/EtkVNUlWv+iVquCcD7K9sEno5HygMlwmeLufZkOAwvvHIKkJmR2qBujLXfvN
	 wqryYwIjPx5DmL2+VvHuHNpIpSfeteaJTO0ezT5E1O5lJenKeXh335qnMlu4VUalmgHsW
	 qx5FPBmaSegiChsmUk4YnzHBSuEIps6PZt7H1MECmxltb3Q19h6eQKsY8QrE5BU2YNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588637;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XCclRpDCI6RaYRXCfsK2fyKi7VUnDYib/EKQZ36pi5o=;
	b=PQhoaFA7Jqf2ijwVMbuGfdEy8ppTfzyKswbAEvO5CUpdnEZSHm0eIcPgOr14cz3PcneG
	 qUwfk6rD/RZ644IduyShX5Eo5PLBymozzB2kSDdFkrgJlXj84yrGWNfugd5FAjNXhhdsW
	 HJYG+oq+kpD1z5YX2M9OmhMVe9mizkIr78S6vwMnxsNnLG3U2hjqcwBDO9QiILO3pJ+DN
	 rFl8nl0LdBsc5G10chSa4F+61nD0Ie5LK7qUocq1+WmzHyubIn6XKBbusKSM4mioajyLu
	 BPgneJyiVVwFMb3d68BOYfSeSAlaXXUFTNSDHmWCzCMFeHrHt6MNaZXVazO2YzLOu1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht7kHNjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1D606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht7kHNjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BC01F000C4;
	Fri, 13 Nov 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588636;
	bh=XCclRpDCI6RaYRXCfsK2fyKi7VUnDYib/EKQZ36pi5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ht7kHNjDhvrmXB/L87f4OdyuF0/pA6sTUJ46qWYAj50m6FfVQhZv9VpVfRfzkThK/
	 OSNPr+18oqZ92lDO6gS0AOJC3O/A9wZ9tQ6wA6eNmkVcdZ+cKkmZEPtZuXwjS5MWUB
	 zM3+8MMsH12JjjkYdgplRUN1hd5qnXzS88LTi5rbJNR3GSykN7/4dIHgsfhzM/1JqW
	 UdXy1Jo7/WgUxZncZuSa/Tl7oBFbiDzS7XsldylBRuFXsCXHosG30h51o0eu0v/HK9
	 Hk/ihzeDVOyx7b2Te5ld4rscd07TizYU7B0pvdapBSDrmp3cRdt43R2U7bDa5tpf9z
	 XuyVSFn/hWOPQ==
Message-ID: <sashiko-outbox-213234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/21] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-2-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:50:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D1

