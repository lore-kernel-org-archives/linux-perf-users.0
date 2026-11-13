Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589149;
	b=BM8Re6q3m41Y36esfjiQ3D+3JYg2mWKIiIFdhYHJ5SmSO/axWkFbOapowTJ3xUkDK0tL
	 XUew974hpMDcLUd3jfX7lkEm6Q01BSNY5+dVWiVjAijoSDowBMtwEaEp7kVaOqMfsqhD0
	 uqxBVytOvPYac3e1A5X/OFVZ70VbwuVmbXzk0yngg/bO11ruKFOdP2kgQHutiypbx7LHL
	 2fFYnnt3EBGU7IHFsj71xTAbVuv7/wCThwlPfqE+doejUfyGGjhlu+35pSADg8W8BE13l
	 BCWVsWqz8AhivrLaIqJEfow/lYCm+PZAtfw1qPv92EECX10mRPp9kxf0U8qG1xv1x8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ujn7anMvrpsyfdi8ofWHxRHfw5Ge8BE3zRexdkhMUxw=;
	b=rWmqtmLTdxVEK+h6WFW+hgWwGIE1TJTyPw91BVQSZe3f8QBzPwwoSiBw4jWPB4Xnkk0D
	 /IAgVU0/Q+ghZej7TtxYklnje/r0YM4FfbcG/Gu/hEt3qfcnfPTxu9gmIjASgFTyDtjS+
	 GtHl3wGUqhyfAH5x4GAqGS2tBOG+1WvQvs1mU4w8MCx5uo5dJpaQ36g7v9sNQPo9X/Fxr
	 r73JaV0EplJcRRVuyBjxlkzv7FWVN2qnSzYLlzHpCNRqGQOwfg02DvhTgzEa1e0/D7gwE
	 V9zYobM/aY64ujBM/bPVj3sACjqv0HFlHsRnV64UBl/Jz9iYfDS+PDmViiMksQovWmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Csd5W2Kq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D8606A882
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Csd5W2Kq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CFD1F000C8;
	Fri, 13 Nov 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589149;
	bh=Ujn7anMvrpsyfdi8ofWHxRHfw5Ge8BE3zRexdkhMUxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Csd5W2KqDe07M3MrCC3ifBfcpNZO6VZI4ZrY2PftIodljdD5xTa0kx0+R6jM3dL22
	 idvfzuYSykxKy13hZsEa6S0j16bTtn2tkQUX68Mjtlocb6jbE+ff3kczw+3QeYbxFY
	 HnVGvHNjSO+o8UY2NHMOLP/Uwvpl7XkLX6MZvkbQHlnusDlU8GWKSZAqc9KE/pT3ZE
	 UKv1y/1kk/g1QThAeUBBqevodfGJGMWhOxHeFmUr4/Z+bzxSkiXAqLcyyu9/HFvgyM
	 smIurxpN4FP1vax2M+lHA25hr1OHl2HoDP0I4eqA8kfwvB4fQTawnRmHQ878YY3oNB
	 zeFSL43kJ7loA==
Message-ID: <sashiko-outbox-213259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/21] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-10-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:59:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D9

