Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591967;
	b=fS4ZzX6QI7csW8GVFKvdPjjRarS080/K6eygP6jsEN3xoV6lPdTAoE5KVokyt67Hpre9
	 4fpU2bMPto7Y3SJ6Ahkh/Ig01exORIJ/zj66Elex+5nOkyKsfyRJnrzFMtYBlBM2q0cAa
	 VyCNlHuDyAp6X3WV6V2iLOq4hZrDM4+fcoF5Zl8eAsc+m0BTP/FnFEZa2RKlIrUuXiFSg
	 J51Feq9PamIGPrPlSXsYkXUX9lPYgVQ2o4u100bDlcTV5s61A2ODaMpeCGgQEFzXO875V
	 EbzYJt5/ezN+jS+FU7QeU561GvwSzIadFYM0WZ/sqHFwUCNBr4c1+iEQwHleyDooS0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wwuiosBjLPnSOPIdf9pLvbHesEkmudcLyjGSAzmocgY=;
	b=UgYdTTOrUrbnHivTcXRM7FjGCTRYqmucEWju4eUvAnT9pKoWEro6+vN6JOOBj73d1Qw8
	 K3ohvcJlilN0+3+udkF/j7EjIbdg3tg4eWtWpjfQceLgI268r6TOnUcjlh7hD+UMSCo+g
	 syDzjDVDs4443b81ps/CcA9fT8goFVYL78cOBaxG3/22r+V6QTF2pNw/hjjfvPoSSlDRF
	 DXuI7jrDjjxwGb0swRCnkOADTpxgSxARCxLIMYu65vEkDOVjch0PfCV+V//LqdBAV11M0
	 aZAtCdAyFSQWGAGUWfApxUtc9PZnsRsLTT21QokpBkuVbZgPYjLTrnpCnMJkNWIts6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjExYYL1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A1606C080
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjExYYL1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9B21F000C4;
	Fri, 13 Nov 2026 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591967;
	bh=wwuiosBjLPnSOPIdf9pLvbHesEkmudcLyjGSAzmocgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjExYYL18i62VahvHRMaiJt7IOJz1vI2L435El2o5hdxJ8VBuH9VWxYNodz6/h+dQ
	 O+0Vet/yG2IsuECkUo6VKiJ3zfo0bQSymQ60poslHrRJcbqThM7bJQlfXskCZFYNQ9
	 LuljOieXEO0YzjyJQg2uxh+tRfEt5pn9AemQ6c1teJCeOMTGpGJYYlYGdGpCJu6Fm7
	 ttUznlg7IkLo8QjJYBn/NKRMFH94E97kWoWhCHRz5rXTPb/hXyyhHGxFfyOtZIhFig
	 a62Vk3YlaF3YMaY86K94tlwrE0AxvDfBTNmKrLX27rBzTEOo8YuYUae2OwuJJxLZAv
	 nBq9TfwV56omg==
Message-ID: <sashiko-outbox-213360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/23] perf symbol: Use session allocation wrappers
 in symbol, DSO, thread, and hist paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-23-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:46:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Connect the session-scoped allocation wrappers (perf_session__malloc,
> perf_session__zalloc, perf_session__calloc, perf_session__realloc,
> perf_session__strdup) to the primary heap allocation paths during sample
> and symbol processing: symbol__new(), symbols->symbols array growth,
> dso__new_id(), thread__new(), and hist_entry allocation.
>=20
> In normal operation when memory is available, behavior is unchanged.
> When an allocation fails with NULL, these paths now invoke
> perf_session__shrink() on the owning perf_session to reclaim
> unreferenced DSOs and auxiliary symbol/DSO buffers and retry the
> allocation once before failing.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D22

