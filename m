Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155170;
	b=XeCnJMZtP06dJ7WDzazCpXtlzWsx1DajvJTGnAFldEgtUpFr5bkWpmx6fDhxRheP1GI4
	 tTS1dY5Qoad46J/Rv2gfy8psYXicGC6HKxb5fjKsIb/93EZMlayMV3UgO8AJC8ysZwi23
	 zsegZwLaLfXuIJvkIQHgzdzN7WCIhKXrdtJcnCn1Mn3IqJKzEldwBiTOXk6d3OUllpmKr
	 VqUTXZbi8GYFp1K2KBLy7KHGgkQEDW2/+TiHGWafV9TKFj8VvkjhVcjW9tNb7xlnai5y1
	 T18OMazvuOWMFnq5kM78BbIF6DMslaSBM+bDLd+nV2NcggzeCUc26I7GAzvv1j6+Q9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A64Hme2qEZ4uZpL2PzvQrSw7LZfNXCpZM5qeYy4HmxE=;
	b=ubO+ybwfrBmWkQjdw3kbCdzaJaVCtMAUlkTetYydosHmMKQ+4ZKg1ppFgD3T8SMSg5n1
	 D4lNNGnIaEDiMgZHSk2SznpLpcpAeb6+DL8eYcNXZkZtPi7FxAOVVumZG7RS+v29VoONS
	 Fkf48iQt88bbS0L/j8zRxIFpkUlneqDxUuVaFZqlczBCTkzt+Z8xlgcc2yxTjdZSZ8qha
	 3FqwCG74RtyW803AT2C+ycav1PnBNc2G49AwAxPM4Bp+KeuA5biRWlsKMD2GNHNz0ILmy
	 iPv0Fm9yODKMeuHDYNhGD9i62WGBc2E0DwpcgYm1qb1tJT5VpMvo2Yy68e7ybmVmWLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG299hNm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA8606A503
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DG299hNm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644B21F000C4;
	Fri, 20 Nov 2026 06:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155169;
	bh=A64Hme2qEZ4uZpL2PzvQrSw7LZfNXCpZM5qeYy4HmxE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DG299hNmjQ+Ls5dkUXrOY8k5PmCPw0nIUdonta23jBrbbmP9eJLQlDjjsoLvg9vpw
	 3y2+yqsQnOgJkA+SQUzvND4IOr5Yyc+4YIEa2hy5zs/5a6l6Y6c+3tI69lIiCKneeO
	 mq1Rik9RFxUAOTAWwOnHORYf6C7Rv7KOtlIQVd07gaU9ba3isbDVfI2WRQuLdaQxV0
	 ZScVjuTZaiEiwwqYLqFBeIc58tenP5hpHEnyB+ZVOYU2N5ldGqjrO+fu4+6kYgzr0R
	 23y/RneQMPpy7EVJFyQpmBPfh13B/kg+4oUf5lbC/ijOanYJ49SbZNWuWIaqgkOiDO
	 rFwLQyPKUYDhA==
Message-ID: <sashiko-outbox-224542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] perf vendor events: Fix misspelled keys in the
 event tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120060931.711483-2-takano32@gmail.com>
References: <20261113032927.634183-1-takano32@gmail.com>
 <20261120060931.711483-1-takano32@gmail.com>
 <20261120060931.711483-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:12:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Sixteen objects in arch/arm64/ampere/ampereonex/mmu.json carry
> "PublicDescrition" and one object in each of amdzen4/cache.json,
> amdzen5/load-store.json and amdzen6/load-store.json carries
> "BriefDescript6ion".  jevents.py reads only the keys it knows by name, so
> these fields have no effect: the text is dropped without a word and never
> reaches the generated tables.
>=20
> For the three AMD events that leaves them with no description at all, and
> the text comes back.  The AmpereOneX events carry the same text in
> BriefDescription and the generator drops a duplicate long description, so
> the generated arm64 tables are unchanged.
>=20
> This is the same change as "perf vendor events arm64 AmpereOneX: Fix
> misspelled PublicDescription keys" (Message-ID
> <20261113065253.746615-1-takano32@gmail.com>) and "perf vendor events amd:
> Fix a misspelled JSON key" (<20261108184600.3810059-1-takano32@gmail.com>=
),
> squashed into one patch so that this series applies on its own.
>=20
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator as described.
>=20
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU e=
vents and metrics")
> Fixes: 658448281d19 ("perf vendor events amd: Add Zen 4 core events")
> Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
> Fixes: 2f42fb0661d9 ("perf vendor events amd: Add Zen 6 core events")
> Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120060931.7114=
83-1-takano32@gmail.com?part=3D1

