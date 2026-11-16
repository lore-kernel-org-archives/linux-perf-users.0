Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812970;
	b=mmgUZ3CSgwDvWjsC+wXPcZUxay62dFjDDvjJCAN9wFU0GhvJsjeayPC+Sssr625XlwkJ
	 0h9Wel08qJLAAXZbflELoWYaEW/3XXWS4cFVk1paAr7T0yz0oDC06QxdE1rsRULZmzVLG
	 ahKJI/AVfF3hDSkT8+fqCitIT76rGTteMCRwcQwlIIQV9nltfefLF2jEkJS4KCDkZVqUI
	 kNtNxXDmcAg2wm8wsxgoCAGGwjOxXnST+tmSR7D28OAYNDt4E22hPxK0rQKhiq24tgOWo
	 aWzivRDt6dh9b3RUnzXhv/pzyLPP9eXU+2fvpzBZ7XzsDSo+JkUZydaar3SI5OMU1Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dQC9Sz7r4vcgGXGiS60cNSGZXfcLIcIH9iTRsTacZ8o=;
	b=40M2M65q0CTLK4q9VPWRPWFgDWZnfSyhaiHJUH6/WwdVycArU/Itt6sMzHbiKe5QBwvn
	 6a9orEX3HLXY+rdePwe7nQdGX4ALTyU9l8fEu2tTlVmHVDiITaX5qhCacwYpCaUgv6a6l
	 807+nJwOWyHRZAaJIJoqoSScxTq1t30vTz0xGBCcDX0bYwKt6gaePuMp9BBg/uBY8zbvT
	 I3V190rMUnqTAG83eQ1Gfq1dh/bhhs07xypCS10F3e7wiUIkmEiJ1I989ceABsSyhUbOc
	 bOGsinyLGoVqswMuBYGfaUXLYjlUw5agC31eoBZ2LsjvLQbmmIznPCW5MBjbugMCauA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkErW185;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555F606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkErW185
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8384E1F000C4;
	Mon, 16 Nov 2026 07:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812969;
	bh=dQC9Sz7r4vcgGXGiS60cNSGZXfcLIcIH9iTRsTacZ8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkErW185TGfxgSout/FK5SWuQUN0Gxh1OBEXxiJGRKoALzi6/ZvuZyeJY971Tp5QD
	 gudNhIVE8tHo+OJtXOsB6ppXhLxuSV9MXiqPhyIEtj2qSvbnmx0JtjP2cwmWnE+xTZ
	 f7Cx0T7EH+jxO6XSUwNhHbTvgMBUbc9w2VUx24Hn3WkGIpObjgv+YfbqiGKP3A8NPe
	 lPP7WlaQe6R3Vc6L1U+j4MHqlgJbQf9LfVcJp8+XRTDIh/C0FH9QN1rLWgooqkf5Vk
	 HJMrEsKFkNAvK6QI4ukJYnriq+sgHAbC0KYq7I9CMmuJyre8kkWxUP4nhlLozwbxnM
	 T//b1rL6ypA8Q==
Message-ID: <sashiko-outbox-216388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] perf jevents: Store raw bytes in BigCString
 instead of C-escaped strings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-2-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:09:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously BigCString stored C-escaped strings (with literal '\000',
> '\n', '\"', '\\') and estimated their compiled byte length via
> c_len(), which did not handle arbitrary escapes and caused both suffix
> folding and metricgroups sorting to compare '\000' ('\\' =3D=3D 0x5c)
> rather than NUL (0x00). Notably, sorting metricgroup names with '\000'
> placed 'BadSpec\000' ('S' =3D=3D 0x53) before 'Bad\000' ('\\' =3D=3D 0x5c=
),
> breaking strcmp() binary search in describe_metricgroup("Bad").
>=20
> Store raw NUL-delimited UTF-8 bytes directly in BigCString and
> _metricgroups, compute offsets from len(b) directly, remove c_len(), and
> escape bytes into C string literals only when emitting C source via
> bytes_to_c_literal().
>=20
> Fixes: 66c6e0c10027 ("perf jevents: Add support for metricgroup descripti=
ons")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D1

