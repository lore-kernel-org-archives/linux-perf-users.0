Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370787;
	b=1wUdawgbaHeJdfYjvJ+kH161tvFFhJAgMY01av6cC3XOxwsn+fOG7YS9JogDMkqmLkXw
	 ZJmAU669juGrp3wWJtq3Y7upwgkLNbLR3jfbTgVLvKZnWYPsmQq4ON7Z+kGc1qgG+gjba
	 Fb9h0C/4+Hr+ObV3BC4djbSFfKQF11cfF6/2jbv7B4COW5std79QH/9/xGoWpBawRIwE2
	 uvZmJgKwTqjLNzmBoz4zOA29sZA207f4ZUo5/PxL/OJwsLDzUhr9EgsBHQx723/PVzx72
	 VdnsBPKmaJOT1eTdoTFbeHOvOX7mpzgI2JV9dIAapPklFRd4xbn/xCSPTQUJ+r3VN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QINLNSs1I4bddTwhd0jN2527kJVOqb3GkO3hQxTtxEw=;
	b=DFfLhBL1bGJhPUPNBYgkY+gNEfHHrQaNZvlJF1MbUzxjmtJI2GZj7N3Rce/cdWc9ftr/
	 kxeJ74IZknYOyrXQzpXiRaqNbEQ5CeLh/ESFVO+4MDg/qn8bjVv0io8e4gmRdp08Zw1uJ
	 CB9HJf/qNd5iAQozz1/8jelsPtpvAfvvJ2UYUlUHPqnuAlXj66tUQaG7RuWuYyKBQtY2s
	 +H1fzANtjhHTqpT1pzDGjaEkPNC/jBxG0Vul7x1oeaz4LgpXK7tOdbXPifLOXvEHcnm+J
	 EJ7vbKlU/AGePshDd4Zon4X406Fq4xKOf5ofAjcZ3/vHKk3swUdWqL5vbumaJuyA6qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXPJpETI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F346606A33D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXPJpETI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A11F0089F;
	Wed, 11 Nov 2026 04:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370787;
	bh=QINLNSs1I4bddTwhd0jN2527kJVOqb3GkO3hQxTtxEw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cXPJpETIRumy24wEbWoRaEpGVRoYRyUlru3bV11IZjjbDrF0p2/Vm1aXB4drTphoF
	 VuQXwol2tudJpDdpXX7RqG/jgflAOe0NVKdBFuQCumIhDvOSdc/AjgBSYY4h9+72fg
	 P5MlDFAXxe6T+whKgfRnh3bf61VYaOjHRJ+FpDwPAfwcW4J0uaIp72MJ10yZ9myigb
	 xXu9CopCiD40WQwLvL0Wm7stu6RATjqmRt8/9FgWoN8ei5O6vTuM+6ELS7NsRJHcmw
	 zchtvuaXzs5DEh/yLargOv9KLrz8Un3NtUmdwvfWfXeSP75hKHblQRlSMB/hbCdPoI
	 atW1yZicHlMEQ==
Message-ID: <sashiko-outbox-208270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf jevents: Check the JSON keys that
 jevents.py never reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111041045.2031464-4-takano32@gmail.com>
References: <20261111034333.2019831-1-takano32@gmail.com>
 <20261111041045.2031464-1-takano32@gmail.com>
 <20261111041045.2031464-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:19:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents.py takes the fields it wants out of each JSON object by name:
> jd.get('BriefDescription'), 'EventCode' in jd, and the names in
> event_fields. A key spelled another way is dropped without a word, and
> the object is built without whatever that field held.
>=20
> Two of those are in the tree now. "BriefDescript6ion" is in one entry
> each of amdzen4/cache.json, amdzen5/load-store.json and amdzen6/load-
> store.json, and since those objects carry no other description,
> ls_inef_sw_pref.all is generated with an empty text field.
> "PublicDescrition" was in 16 of the 28 entries of
> arm64/ampere/ampereonex/mmu.json; nothing a user saw changed there,
> because each of the 16 also had a BriefDescription with the same text,
> which is why the typo could sit there unnoticed.
>=20
> Add a --check mode that reads every architecture, not just the one being
> [ ... ]
> perf with it, ran the perf test above, ran the check over the whole
> tree, compared the generated tables with those from an unpatched tree on
> x86, arm64 and all architectures at once, and ran mypy on jevents.py.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111041045.2031=
464-1-takano32@gmail.com?part=3D3

