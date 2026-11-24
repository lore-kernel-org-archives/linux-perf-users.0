Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543899;
	b=dANrBerJJGSgVrwuUpumihOt+vI5HjGA1DjLdGsh0NALVEYxbvfL2TvIWfQ0v1OePxJi
	 30wULOV43tbPErVDTKMEe9jBgQk3ZVh0BB0YE4Df1DePrH7tK93yq2N57StndR2fjoj0B
	 y39Ga4dMNcaZQLPveGPlsqnyBJlfZHHtuxvOBCVZVP5m3+Vhj5UNttTnUm+POsCMUW2Q9
	 jeR9MZjgy4KRDUuBOdkVbdQoO1bKIpW7eYPqcQuS0OM6JGvA/WGBN2Htl9jvtEaXOqoEP
	 BcZSfSQIoD89dnmmXkaBA6aayrGBuvwTD5s8kvO795D5J79YfVfCsEn2Ik3NMJVwH2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t+VyYPgE9yDbofN1vg7w2cKR9os63USqrauG071YD9U=;
	b=sVrmxTJgNbndl3fKeXqlx/khWZGrgnmB1Hg0pHuv/DrW0247EYPVF0uS7Z39o2o7b3QB
	 eeYSzLQlRhi4hYYIiofh6TLLuLe42IN0yosn1lpbvQDzi6hmsuLU94ruQvsgMAEaO8edB
	 EK4kzBalaqXpJ40uSKZQwINlEIsTVg8yc6T/egJBIX2QMTOTzGl9W6dQDda4/Xxj1KeTO
	 v0InepqReHSupRp8wdeuVqq56JmqoGVDq9Y36gKzw3ApoebabT6pG+qZyDJ75W2/QhHrS
	 3Ye7XnwWALmqt7fRgtGClYOXDQQldFXZrwWYbofzg9T1VoxSlDEZwpJ5Vvo2PXQ4Gqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ccyp908z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82710606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ccyp908z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086301F000D0;
	Tue, 24 Nov 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543899;
	bh=t+VyYPgE9yDbofN1vg7w2cKR9os63USqrauG071YD9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ccyp908zsh4BfL7LfjEfSTiQeFWtFHGUug3tO+z0Be2ymLtDQHOWDexf6pb+Pwi8P
	 v0C15WLK1y9896gPUR11s5k7gV9C3K5uj94GGc/OSYePxI0n16FDqlAaYhuGBqIkv+
	 QKxJLd8MEkfq4UKX01T/biiXi9l5DHzqfBMnRz4X2alHlHn4oXRfSpDVGr2Bl9CxRZ
	 O8owD2Rs2PO/m8WFFrgV7zkRuO49XLDTnHEhxH3CUEPqkV5nFdUHi8viSCujGU50Nb
	 oX+GxZ6inpBerSmlbUyYtm860Qj6YdOmpTFGSYHIdAPcfxredgeztkNHGRfhs61ROu
	 o4LkF5sT7Nrcg==
Message-ID: <sashiko-outbox-231800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: check perf_allow_kernel() in
 PERF_EVENT_IOC_SET_FILTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominik Maier" <dmnk@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124180611.75836-1-dmnk@google.com>
References: <20261124180611.75836-1-dmnk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:11:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Under perf_event_paranoid =3D 2, an unprivileged caller can open a
> task-scoped counting trace event (including tracepoints and tracefs
> uprobes) with attr.exclude_kernel =3D 1 and attach trace event filters via
> PERF_EVENT_IOC_SET_FILTER without passing perf_allow_kernel(). Trace
> event filter predicates are parsed by create_filter() and support kernel
> symbol and address matching (such as the .function modifier), exposing
> kernel address information to callers that are not allowed kernel
> profiling.
>=20
> Require perf_allow_kernel() before applying trace event filters in
> perf_event_set_filter().
>=20
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dominik Maier <dmnk@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124180611.7583=
6-1-dmnk@google.com?part=3D1
