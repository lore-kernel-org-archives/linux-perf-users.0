Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007708;
	b=U2w7gApFqKaia3nJkQyBGpCloQNCWGcUinvBLqFiV8urh4uVMfn6jyABpkRhBmDYR1qE
	 RvVSzzmxiMUk8SA2sZuqB+fshsQ7gG1zVYv05ZRZqtjNIWYHeMJcVbIdOIIbP1ZDn//l+
	 8Wyhcip4txPUPAuA8WQAG5UreYdLZEE0YI9nVFm2Pc3NXjmv933CVnWFtcFsl+CcANvgS
	 4Y3lJXdk3fs4bsEAcwr4fJI5D8WzxUv5GfCoN1G3j6ZEY3h7r3xKOlSKadAu8cJ/LNZqF
	 q8FApiMtRd0YKL1uz85Qd0kDtJEhbJJ3OU24tvsCJ6NIEVZ1MBYLQZ6kSwWp8TngjLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jyC0SJCOSohzbYosMMLN8syzb/refnQu02+8F3/GEjI=;
	b=IReOT6L1eLIAH/L1bj/ATKyzyp/eqQscUTMNTQA/UNAXwAQcqRXqhk8uSwpRADW/sKoy
	 jpwT8uwR53czvaU4kxa6ovmwQ1k3TbS5RLUFTW4DqG1M7j9KJCez73EeLAmcHQp9i/QjL
	 vcuxfDe0hk+pSwzT2CtO1dVCzgsv8ljrLceHsQ6FKQNW+5wd3O1MymjLr85qTQnaBqcF8
	 BJzotJ/msDI/tC+IGafh/YaES6BPTZV4hrefd83oAG3Ucvy5POxcmJN30WLDd5tzYa0eZ
	 pKWpSZtVzmTrkvJzF8B1k6X2i2dD+FyEiYeVV7UCFUg2qEykmk6T8YLV0PkQaHKTObw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRPz2qah;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E776606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRPz2qah
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A7E1F031ED;
	Mon, 26 Oct 2026 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007696;
	bh=jyC0SJCOSohzbYosMMLN8syzb/refnQu02+8F3/GEjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRPz2qahEbHFP4qnLD+YJLc//h7Dn4LIDga6SFkBoMFLyVtcLdHZylNTB0rxiBuFW
	 7qmia1D3aE6k0HQkrjTrXKzNLdKziGAblXOrrZLeqZWI2Oo9KRfeuQaLZsAbtY8QdM
	 oqO8OqjHbb7oKHkWTMBbOq0jxJH0ydfU/yVnJFGrWdszZJAS4V3/4A+mQMba5ybkYj
	 MJbz2obQfdCFnRzPxmktkezShaxQsNuIna2XwWeD3sJVC40LEauKf7Hx/KYFKykPTW
	 /kxn1CZt6ISEQGz0xkrPjbndrJzs+wT9Wn5eNJ4jfbv5AumqhtOuJy2t1bCPIuZJL0
	 b5zQDEaRnFkmQ==
Message-ID: <sashiko-outbox-184826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf hist: Do not delete cumulative caller entries
 before stat_acc decays
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <efe1d231090ef4dc43fe1f002a12c7c65c8ceda2.1792995775.git.irogers@google.com>
References: <cover.1792995775.git.irogers@google.com>
 <efe1d231090ef4dc43fe1f002a12c7c65c8ceda2.1792995775.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:41:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When symbol_conf.cumulate_callchain is enabled (the default in
> 'perf top -g'), callchain parent/caller entries have he->stat.period =3D=
=3D 0
> and accumulate their period in he->stat_acc->period.
>=20
> hists__decay_entry() decays both he->stat.period and he->stat_acc->period,
> but only checks if he->stat.period =3D=3D 0 as the return condition for
> deleting the entry in hists__decay_entries(). As a result, every callchain
> caller entry with 0 self-period is unconditionally deleted from the
> histogram on the first decay pass, destroying its callchain tree while it
> still has non-zero cumulative period.
>=20
> Only mark an entry for deletion in hists__decay_entry() when both
> he->stat.period =3D=3D 0 and (when cumulate_callchain is active)
> he->stat_acc->period =3D=3D 0.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792995775.gi=
t.irogers@google.com?part=3D3

