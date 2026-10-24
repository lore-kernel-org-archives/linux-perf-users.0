Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878410;
	b=SjpZFb53X/UTgHj5kZbyUi2j8d9s0jnLHlFSUjMau3nOIw7nTapBWU+JyXuxjZKfPoNg
	 cDm25xj5YV1XIs+1c8Z2bwZTZCkiaB6ElO1nlOrhg5XGc/AH08gc3ZL1F4M0V4eiTz8cg
	 v8eD0Es7nkDHQritjofXElCnf/PCvXh+RYHgcUJVTkOaXs0bgARNLTB1LrVWHd9i+hFFk
	 pZkbKdyrhtgMEkKC+E66Pt9CjExqLERfgjfEltUb34UvqhjSiraeeeJ8ilB5pnuwfy2wc
	 3yirMKvLxZUUwLROXNAG9ik8/MtnKwqA8AI/IoVqTrPcaYjJmYGlcIf2GGJmpNe85rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878410;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WxqFmrE4Xnwrh30VIlAcBg/wh5Wqt70TErpGuLypfY8=;
	b=2DJ0PwcnQU4x0lzDRmeFVqTpbduidiJ6yL7zU3ZAf/SwmAsZGSyQ+FNZ65Op1s/paZGk
	 B+QfE7Ia3UK3s34CcUCqw4hvNmQuLsDKwl+TJde1PoWvIvCYQ682nWAILK3wRIyQOsjii
	 5ZvLdrfCfI7TsIThpH7s3dGhm0EVneC+SGCEMXVDTqEJhxYWGDybMyEwwX3RlwVZM1tpb
	 Admf1zQ6VVkr1lc0uR6zkMZZ8hMh2YfjmjQJhRy6lvuIQI93XIyAgAFeCREKXq+5uFBQp
	 PNaGSiyNFZS+Bzsti63VlCuw0P1GPlESrbC+KXzTQjsvum4bxh4Xl7jKO5sQLqxS23Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4E2vK6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175CC606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4E2vK6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CDC1F01825;
	Sat, 24 Oct 2026 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878409;
	bh=WxqFmrE4Xnwrh30VIlAcBg/wh5Wqt70TErpGuLypfY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4E2vK6MUjQVo4Db+8EmFnqpumgIJiOYt9MZjNf/AruEMM7i10tpd+gqchUEHB7rF
	 Rvp8j8ZIglPBiDacJ4JzPTrdqSU5tFDLQ6oNAU6Q3QD9V4lFz5mdCjxC7Rps+h/lFf
	 z0YH0BYBlXrp/2rLzmn0nYi0Z8A7FJMQ0scFL14Rzj/3AQQXAXnTzup5IAr7YvsmYy
	 m9q4Z5jEzOvHAP+bqVGULkCET5EIDBLQCB6uFCKHQ3o+bUJIOKu1vHOlSx1nHbQeDX
	 nk1UFoNk3S08/VaSbC7DvhlZklbIsXKWn66JcNpzfG3VDkf4XkZkWpq9UCf0VLe6SV
	 oLq0/FzBmtDyg==
Message-ID: <sashiko-outbox-183901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 07/10] perf symbol: Introduce
 vmlinux_path__find() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-8-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-8-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:46:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The vmlinux_path array maintains standard paths used by perf to locate
> the kernel image (e.g. "vmlinux", "/boot/vmlinux",
> "/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
> vmlinux_path__init() populates these candidates and dso__load_vmlinux_pat=
h()
> loads symbols into a DSO/map, callers (such as test suites or probing too=
ls)
> often need to verify the existence of an accessible vmlinux on disk before
> attempting machine setup or test execution.
>=20
> Introduce vmlinux_path__find() to search through the configured vmlinux_p=
ath
> entries (or symbol_conf.vmlinux_name if explicitly set) and return the
> path to the first readable vmlinux file, or NULL if none is accessible.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D7

