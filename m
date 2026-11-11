Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370945;
	b=SDIstbp6SiZ1MFEP8/OLg3tRJlzA8bQ4u22sL8l9e2z+UWeFf/gM6oYZJemB/+v9i8c8
	 atjliF72HvGisi+K4F7sHVUefRJLGEMgKly8wLW3P/ZZKf1Sb6fxtaUeeDl3+Z8oIzM/T
	 4y6myKINL6dBQZ2Ay0ZgORSixTz9MGeV6Li5jtIMDiyDLQq4kgCxcRkY37Q7nesNdfxXr
	 d8UrbnN9Vg5LERcQrHoUyed3/PgxgqNilZMwzIyVUgO/9zoTw+sWuGKB/uc0ZJ5zlPbJk
	 4j4ceEV27g6tGsROWw54xt/wCpH+gpqGdrYnWEMsY5DQ/NiFGTxoze9XCYFNzb7NYzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370945;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ovvP9CqgbfJbyvKirqLgei7u5FVc67vm0EiL9EnhQYg=;
	b=xwJBXLWX4XSLAZEzTlKHffZRBtX4tSuoD0yc0CbXr2NMxk0obt5t01e9JOvxKxJcqQ3K
	 YMUbpYq5l9vLAK9MNoo8IK0Chd8WBVuT/CC6SmgG/XN/aAgF+8vDZ2LE2yOtkCj2op32d
	 KCIHiP0BujT7C1BD+GCLBwogl7asPxhq0h09fpvnNpjeEDDbhi7Vn5uLXT3N1JAYGItjs
	 +uFj858sKrpiWy737HGq9D4wZNtWAvQ6ctqudgO1fDX037mnOjS4/sOPij75qYILTsaQh
	 h+2Mx+EJBNp8B2YrotsHPNhp7WqEqbLP8pGW7n1iUMtUpMEsAekk3OFEO/O/NRHBX6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgCwZXhj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EB606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgCwZXhj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE991F0089F;
	Wed, 11 Nov 2026 04:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370944;
	bh=ovvP9CqgbfJbyvKirqLgei7u5FVc67vm0EiL9EnhQYg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NgCwZXhjH5bsd/cjGtoNH30Ujtn2MAU5eGDQIbjHFE9KkSGkGfjkYd2oHsNr/Bxlt
	 th3FnwedOuUTADdErgmh30LHhnB8vO8jor50rPKbNUdQgs64wzG8EOyeS3vENs9c5B
	 iIEDxgZTblapmf5Q7G9erJG8iaG+DUwRCKeaYop/4zFtNwEAditVdPcUjdu1VhN/e4
	 2fbY8w2eAcqZrXOxauZ9kDXZC9WRzWudJIUurWgB1dpclAFlN6b+dJ5Ymge6Lx+Zcn
	 az7ozR/yGFJXH8OeCdwS7/FT5Wmim8ePW4DSxiVEx4F+4a6wZSHbNAPX5neHdh0Sff
	 tVMbsnQobBtZA==
Message-ID: <sashiko-outbox-208273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf jevents: Name the metric when a MetricExpr
 is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111041045.2031464-2-takano32@gmail.com>
References: <20261111034333.2019831-1-takano32@gmail.com>
 <20261111041045.2031464-1-takano32@gmail.com>
 <20261111041045.2031464-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:22:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py reads each field it wants out of a JSON object by name, so a
> MetricExpr key that is missing or spelled another way leaves the object
> with a MetricName and no expression. Two different failures followed,
> neither of which named the metric: the rewrite in _read_json_events_impl()
> raised AttributeError on the None, and a metric that got that far reached
> print_pending_metrics(), whose assert fired on it.
>=20
> Raise in the reader instead, naming the metric, before either of them can
> happen. The check is not inside the '-' test that decides whether a metric
> takes part in the rewrite: a name with a dash in it can lose its
> expression the same way.
>=20
> Two smaller changes on the same path:
>=20
> - An architecture standard table that does not parse now carries the
> [ ... ]
> includes metricgroups.json, whose first pass runs before this point, and
> the string table built from all of them: nothing that parses a file runs
> after the output is opened.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111041045.2031=
464-1-takano32@gmail.com?part=3D1

