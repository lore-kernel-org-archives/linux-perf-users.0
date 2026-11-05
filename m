Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868053;
	b=cHC84pJ/EYOwHtoYwoEbGdPtF39CZUrP+EpxIz8O1F15YUOUET5Ub8CGVQf0O5iPyTyB
	 K5+VlRl7QzmIR+8NXsP3qd5ETZWBmXUu1zoaJfWL6Y83Gk9HBJiIpGP4kd5UgN7DB+h1n
	 uc/gZBtR8B5xSuJEZN3JwE1x3qTV438CXUQGv84KVIgZFZeUTNB631Z3NHM/NKa6gfRwc
	 T4uGUNL1kcUu9v2OEqc5Wzd94eqzDb7pYDW+3pR2/jIU/BBItVT0jFCBwS9izswYvlUXL
	 c6T8UU9AMc+uJDFtVpxeBNPcM5VW+f55FCdf+MKZAsDifYv6Vw0ZbVWnxaIUaqTZdOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h0hip8z2WQYT7ylqKQX8Vq0buO1qLbNEtlhc4moJW5k=;
	b=KuKeq9xoymxyQ5MiTJNpSpiPfFsmST446yU86dzLVSK8v7mpsfcYejDdra5Jg3qDjcZA
	 Z2M7InA2Y0TIOx2Rc26ZPHZdpevwPkybKOjIkH/2Ls2ENqtr+Cx1KpxqJwXdZWaSRMfx4
	 IiqOkUCLaq3BTw45t5OzDt/i1i1el8tncumwl3c7FohI3/lJJD65XvdVipsHGP7wNSb0G
	 CCJvFduJYZ6gdzSoP3eLujd8sNG8cEEV63ohluPD7aOrMaSgxEGqdJFfw7mal+1Il5M6C
	 jh5Wm3I74Rh9WngnCxmBhhKorO7HC6BnhgFTp7tKtrHvR9TJwvA2x538bUXlx0LYNxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/6bY8gq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6359606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/6bY8gq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF501F00A16;
	Thu,  5 Nov 2026 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868052;
	bh=h0hip8z2WQYT7ylqKQX8Vq0buO1qLbNEtlhc4moJW5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j/6bY8gqPIDcp6WGuMgCXQlFs0dEAVJhv/t29ypgGib+zkLdqqODU3pNBibj/KUJl
	 r2vUA1MSrMZNyUInddKojpLVJh3YObuNnZ37GpIYV4V5BtVmW3U+gZVikhsdc0YErO
	 AI76CT9lj83V/gd6Rm+FzvgGd+nZm8O4eaqMKaS7MizL9blMHYWkgZFEhPvRZKwtTC
	 JX/EMCfyufQaU70LeNyJQfpPqtSVYUSua4yF1uEcdxEHUD7CBxUfQO70MsddyFBTk4
	 GAoVpK70uAZ16YyrjzSt+beCbXPt5sf5kP0mQx+uetK/xgrUlEATXEFEfZ4SnnNS7i
	 KBRqwOgp5B6Lw==
Message-ID: <sashiko-outbox-198732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf: initialize and destroy error list in
 test__pmu_config_helpers()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b9796c017042a3074956474a83c9b2170caec6db.1793867553.git.jirislaby@kernel.org>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <b9796c017042a3074956474a83c9b2170caec6db.1793867553.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:40:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> test__pmu_config_helpers() passes an uninitialized "err" to parse_events()
> without ever calling parse_events_error__init() on it first. Sashiko
> pointed this out in review:
> > When parse_events() fails and records an error via
> > parse_events_error__handle(), list_add(&entry->list, &err->list) and the
> > subsequent list_for_each_entry() walks in parse_events_error__print() a=
nd
> > parse_events_error__contains() will dereference the uninitialized err.l=
ist
> > pointers on the stack, and any allocated parse_events_error_entry objec=
ts
> > will be leaked.
>=20
> Fix it by calling parse_events_error__init(&err) before parse_events(), a=
nd
> by releasing the list with parse_events_error__exit(&err) on the new
> err_out_errlist path taken once the list has been initialized.
>=20
> Assisted-by: LLM
> Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and c=
onfig change tracking")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8b245572903b8c4ed0d=
c569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org?part=3D3

