Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182299;
	b=Zsd9LFL6kt/tCJzZBxt0n1ycwKRNCcxZDIKz8fUz5DGTsjvIGrdFUXe+dnL5ews5xjaq
	 TFcXWWBbvTWD0r3sQX5+5DogbiFx9Bii84nXUzjq8ol7nH5zmyPD48STXCyHN9QmqslsS
	 u1n6OzK0JInWF1Nix+sFlCBigzU3YOipGMkADKxwvGfEsQhamBDaL+sFqE7XvfZOyxJ/o
	 gMJfkeS4erRF4Wu7kaGIUDegjrJEKyYYW3GX2KIF2aSCyVHdEbRy+6pawkkJRBv2MOSsP
	 dRa7AnaeyO2WnZcsaSmGLha+6ctTJBIkRA/Uxe4RDOUTU2955foyJjXOol+742eeVdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6KemzYaPCII3RMAIvnI+IU3XARMuVsspN40GIUbrz18=;
	b=a2aWUWPn1aEA45dPt1VJuTkFetOqGxuyUwRKsKKbqw9/d9GsB+E3jA6PSt+WnedsyNKQ
	 VVXc0DvwEctGPnAJeXWsbFnWTDX2q0sJrFRG2x8p0QQPqKnG7wcU9T9l8E1UzugNA97Ul
	 FwEUtNPOBkDTP7lSXqcAKUdBpw8hnis0tiIZFllMY7phOKnbRc6R3b5P4LAUwcDSkCbX0
	 4rDqt6iTtDXWVEfwcxFwnWfLp4uL0z5VFpyD3zwSwBjBWFV65LqFGvWFOlUu+mYK2AZ5R
	 i5H7SXbjAesvVZeqQzOTeBizrqMBqTb7H08nOXEor8ad7Lu73qnJL/CME9/zKyBwBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BqpWzCIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF8606A32A
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BqpWzCIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7361F000C4;
	Fri, 20 Nov 2026 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182298;
	bh=6KemzYaPCII3RMAIvnI+IU3XARMuVsspN40GIUbrz18=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BqpWzCILMHF77rBPz+jwWkamEEaMZvOspmBS9tZ4k7BroE69L/1XfPv3Wy7uWmvKD
	 RqmsJa888oBKabTTYZfSwnbZpBQBAEKyMO8I97Kg1YAjqpCx0mD26VeMOPMLnrCGC3
	 xAw72HZx0Z0STVwzFm1Wpl9Iic+JD2rb+D5CU8kzOX++If49eiyY43eDm1sAmn9/qV
	 tqlxEFMNh6Tw78ai+T5Y0n0ZezQscbQ2UyuS0dlQYrECcfyWJ0+ar1/GnDlWQhAHFs
	 1lK3UDsAQ1Maa7lgXy89by4n9bMXPXfRYgLmcdbjq6A8FXajvBj8CNbdyKq6+E5hoW
	 wENiddN0kZPiw==
Message-ID: <sashiko-outbox-225266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/2] perf vendor events: Fix misspelled keys in the
 event tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261120134252.1036963-2-takano32@gmail.com>
References: <20261120060931.711483-1-takano32@gmail.com>
 <20261120134252.1036963-1-takano32@gmail.com>
 <20261120134252.1036963-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:44:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134252.1036=
963-1-takano32@gmail.com?part=3D1

