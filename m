Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202214;
	b=ChafDWAvcEU4pZn8L3fTgh9V6Div66DY4SggeqbC5ydmh/94/MrSje08VIkmPvYsftRm
	 3BDukQ//qVz/S5UB+NvA1WCso6HhoOeVZ9dCTZFLRf9waqpIe8yc3DTzxKuVIqh69aGXU
	 pg+KXqctVk+0hLwnO6jcuAIXGOr4RG/dglZdFM02uZbSKZFf3wd3xo1ftntqm4FUU5hXu
	 8r5/hGt9SGl3PY+b9chVoFS6Wu5Uvlw64ioc0SFuv9v85Owi36OtnqVopXxuJOA3ako4Y
	 5bGDeasxyK2wf7diICpqEuLVMtukxkMcWJ73ytiZRo6gscilPDmKStFQF5RKkkQhifg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202214;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3cYmTiTUSJhd7N8PTE2ifOdDPSa54XKf4ecGE5LZdWs=;
	b=36C2pWsmi/DcyAdFhh53C/gZkoH5VE/9INazdUPiZYPXr4bU/EBcw0nKJTWTC6UJDDaT
	 ehaLav+iYgYayPj7AURv6Pe4MonOWZ8F/IuFkuIwNAUwlXeg+2OvrVyCoSKPmuk6s7Iv0
	 eFSOi8Gn35Wf+tfrqkDtCnMGA291IRnJ6yE79/8lAq2HGDPpCRXg46rRb3GiwYGGH6PmT
	 aW89JdMXadBSBmcMIZ+601hspeBIpL8rY5dMuTxJx89gu4BUY4JgXXokNh43W0kaQnpkc
	 Gxj5bHSHC78F4NpLMvdpU3oB9ZKcbBKps9IxLq14ullg3zP2rFphp89m8pFx1vhIRDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sbo/C6yn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28F606A6D9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sbo/C6yn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FAB1F000CF;
	Fri, 20 Nov 2026 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202213;
	bh=3cYmTiTUSJhd7N8PTE2ifOdDPSa54XKf4ecGE5LZdWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sbo/C6ynSDuMYQXzIfHRID0bJs3q0ubt3YzjUJBFHGrFKj+zRmzJJP1LE7c11xt8j
	 hCk+5SBuMMVkurfbYcLctQJYSNs93BSB93sXmA8Vkx9C8nxZUuT1A0yA8u8GJIWf0e
	 0oYU5QMwi7vrRJi5qBshhhC9nHiTTAEYhQHqj4i5h7IEp4ca9MQAO8PHYKcMcCAaqh
	 565oDFubdOaTnWO6uGsaIH0h3/6dxu+wC8pEK95MH+jvpgWrKB8UmUNsJQml+4D1YB
	 1UBdf7Ahe2+N92TjcWh4j9fjZIHbTWkfkuiSbFTNMLvcxfTPoilCahReoSJZVMzhX2
	 P3fREO2A98ilA==
Message-ID: <sashiko-outbox-225899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] coresight: etm4x: Skip features requiring
 unavailable events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <af7838ccf521e6317dbc3ef706dd4b8c979740fa.1795196854.git.aaupov@fb.com>
References: <cover.1795196854.git.aaupov@fb.com>
 <af7838ccf521e6317dbc3ef706dd4b8c979740fa.1795196854.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:16:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Feature register mappings accept TRCEVENTCTL0R without checking which
> event fields the trace unit implements. A feature that drives EVENT1 can
> therefore load on a trace unit with only EVENT0 and silently produce no
> pulses.
>=20
> Validate the descriptors before checking their requested EVENT fields
> against the decoded event count. Parameterized writes are checked against
> every writable field because parameter values may change after loading.
> Let the configuration manager treat -EOPNOTSUPP as a per-device skip and
> release the unlinked feature instance, while malformed descriptions and
> other errors still abort loading.
>=20
> Suggested-by: Mike Leach <mike.leach@arm.com>
> Assisted-by: Devmate:GPT-6.1-Sol
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795196854.gi=
t.aaupov@fb.com?part=3D2

