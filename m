Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591213;
	b=0BFk1bArc1Gz5kz4K89aP/hCEXnX7IwvEPPkrFloXHF3HvoMTGObEJ7608S29j4QKf7A
	 dLW99UyijV1gH2h5G07SkSY10fwVS5m+vgeQYcMZNGg3spTiBEhlDg73l6ZGMqNGEAvQg
	 pZk3JBpsivdGNs0woNCR3xDY5c122bW21Cyr/5qfJwGdIjUeMk0AgUG6FlWhmaUFVWdPY
	 JN/vj6KRN2pfa5hXOgOoZRQj67/UNItmpv7qsWNwqPH5kJnN+4uKmynuarMDMcu/m33Zs
	 kGL8EWjJB7GvvZ5ML5Zm0ADXBOct9N2dibEYddlJgMXEsdzKrJINzxBAmgHwJA1bTDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EHYSdvmYPR9czVEF1m7johVAh8qv7jJ5rYRvptz8Yf4=;
	b=D5fNj9DjBgstzwZxscO9Qq+yssX54pMTBIPcnm9HJApqyo5EhYaDjpsZx19KeMVv4SnC
	 Xu+v9YNnvYpVIbxmogN4Np1V+tpd57nHuV/QVmuh1KGKJLNpgHIQx0X9OCdFX64VIyfhL
	 5/6YJyyufQnj2M+PvPlBH5SQN8f+Gp38GCsdrMtscVkNdysOTwrnY6IBu8c1Db6SeBHsg
	 MCYbaBTOLo1qW+dm7/oDcGX8ldORifYInVBpE9zOHSOeHa1CSPBriJXGEw4lA9UuuYJTb
	 JpASykO58v6eRP3RPf01taGoEZbgEWrdTM17tQlaAGuoFzsz84eKRcYaXP14i817MIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4x1RHct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E26075871
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4x1RHct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624EA1F000C5;
	Fri, 13 Nov 2026 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591213;
	bh=EHYSdvmYPR9czVEF1m7johVAh8qv7jJ5rYRvptz8Yf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4x1RHctt/pTNHl4Rt5GuOVWEU6CniRl03tb6jqRYxkXz/+MV+l2UE5h8i6wiBY6M
	 cVvtt2sJg+iRRB3Eg0wovY4PRwjgPrdjJ0pGRXuQkhTUCUUuMc6DHK+0aWz5hsrniM
	 KE+5FJ3x7iRxGL+pBXgXHpCbKDjM1AJYNoS9edAZkWwVXixIBQQQUe2liKanxnMAYy
	 4P7mC7h2LA/+PdVo7FqYkxh6wErNZe1iX5//6F0UvrlPCMT+Yo721YkSNxRkz4OLb+
	 EIeNZWQKt1A9rqPmFRiCKbm8QoevkUqyxDDqXLbl50STm2i7PBL/N+lcHXlBWStPmh
	 9dkKaeZDVIlVg==
Message-ID: <sashiko-outbox-213322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/23] perf db-export: Store symbol database IDs in a
 hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-11-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:33:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, db-export reserves sizeof(u64) bytes ahead of every allocated
> struct symbol via symbol_conf.priv_size and accesses the database ID at
> a negative offset via symbol__priv(). This adds 8 bytes to every loaded
> symbol across all DSOs even when only a subset of symbols are exported,
> and relies on negative-offset pointer arithmetic ahead of struct symbol.
>=20
> Store exported symbol database IDs in an on-demand sym_db_ids hashmap in
> struct db_export keyed by struct dso_symbol * instead of using
> symbol__priv(), and retain exported struct dso references in db_export
> until db_export__exit() so exported DSO and symbol database IDs remain
> valid across the export session.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D10

