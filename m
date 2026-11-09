Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219927;
	b=5qj8utjJoG7CNWhwVuCA0u1CFt/3dWmVkGFTCdyIzClz1gfbl/hPY315U2VVbnDR16rD
	 liEo6YzLOGqxUyTTuKX0jgc71B4XFO06ArwonWj0KPp3moOkIopu2yzwx5s5oDCLOgXf7
	 w4FP8RDVHhVECnGd7ni1WmaBqMLLWuiSTh7Q9VJRzxtQ8yyFgJ9cH2/+oHMj9RRCSbp83
	 3XC2rW5zkttQsU1BD3C3b/E9xsCs4YqNwHCnWZ49uxvKH96dXdYKTeFkLcYWVraWRLTLO
	 287zu2UlhBwsGFFV6FCc7UHb3Gu/q6muIRkkyOwyMmhiqZXyjnCXU9jdG09uJCluvJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QxtCwXMbWzZWmccpy77HF1ELCbIJJwON88Qda5K0nU8=;
	b=zJYmcU6aIXxoxhPqxQ6dBAokqZ2Pz4LjTDZawuT0ZjVjsDsrDLHJJdI9Zv7D1YfhuPuj
	 YGZbzgnpdT8IE+thkQdXtnRwZRLLOL2wQDTatogH3Los3SrjA3xNXQrn6Dz6Jxb30zWwF
	 1kSXZ7vmRaHVAhAn/TTcKxfEBPKFTm6B8VzvDeF4zEpvJS6FtCsMTyl6fUms65sey38o0
	 f/F1j3vBL/NVrj2RSsWNUUY/tEDZLaLRM60x9xZ5BIHexu3KSIT30zNliXbP9J1eFtGUu
	 i0m5R1FvCaI3cMLtKL77pwbTloNWgb5r/0tKrm+sGhBYgU+xTzxrAXUeRkNRy9qkuKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlEKFS23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90559606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlEKFS23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C21F008A5;
	Mon,  9 Nov 2026 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219927;
	bh=QxtCwXMbWzZWmccpy77HF1ELCbIJJwON88Qda5K0nU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AlEKFS23s8E5MOOAgzeEIPYog0vBDxXDgBFK71cZKrlKVjaXZ8Nl0MqbB6VcLTIaN
	 eRLMK/YfnteNWfpL+YS+XLl5KxfuhzUIAR9BCzbOmWk/JxLSezN3bHyCnS63xVGKec
	 xLMW4nRXasViHFBlaTpYhtbYa+voSXF/X7ho+8HeiOcbG76FU1sj2gCo1M7RZh5c1f
	 OPzJ5KA/wozcslByTjeAeFygfuzTreNZSqDcDhHxEjFKMzQb3tfdSr/mO9rlVBsl8q
	 vvPoIBtAA2C+n34Dkgxx4p7AToX7NHSg/3LqigF3pLafedd1el+2RN18Qpm4TOUF/J
	 EF0mCzpXD1RAg==
Message-ID: <sashiko-outbox-204815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf libdw: Find the CU by iterating all CUs
 when aranges are missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v3-1-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
 <20261109-james-perf-test-fixes-v3-1-e8d0a65e618a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:25:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> libdw__addr2line() finds the CU with dwfl_module_getsrc() and
> dwfl_module_addrdie(), which use dwarf_getaranges(). In elfutils 0.190
> this only reads .debug_aranges, which can be partial. For example, when
> Perf is built with LLVM=3D1, clang doesn't emit .debug_aranges by default
> so the lookup then fails and no source lines are found for most of the
> Perf binary.
>=20
> This used to be hidden by falling back to the next addr2line style, but
> now missing information stops the fallback since commit (62d7cdc8d587
> "perf libdw: Optimize fallback logic for missing DWARF").
>=20
> find_cu_die() in annotate-data.c already handles partial aranges by
> iterating all CUs in .debug_info and checking them with dwarf_haspc().
> Move it to dwarf-aux.c, then look up the line in that CU with
> dwarf_getsrc_die() and use the same CU for unwinding inlines. While
> [ ... ]
>   ---- end(-1) ----
>    79: test addr2line inline unwinding : FAILED!
>=20
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v3-0-e8d0a65e618a@linaro.org?part=3D1

