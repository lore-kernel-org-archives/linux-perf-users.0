Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366944;
	b=Pc0k/LrgQE0SekgxPYpJqFrUXisu1BQkqLRYPu2PXbkSF/jWWuVM6EME7dzQFZ5z8Ids
	 /B31973s0uICqkANCUO73chyEMRDYVE1cqkLLpoCPfI+2MnITMcjtikqMvgk+1t8RsCEI
	 qeCGeGXcY0LBXkiAAgNh6kT39p0x8v34ApO+7uE4I3uit/eE628JBgtFU435yFq7R9QKj
	 /++urtTii1BGGasPw0t1hH3oo8S2xhMeiYHmHfgNoPxq8iXpFJhPutFgQ+wkIIKSeWbBa
	 xGLLUMWP04IZ+cRYxva4hw1AvOBeUeEyU8XSbKRbVITRG2KXpLkbCH4K8euBxiVm9YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2PSEDMHrrPOXYyfqo0gQZwGFZDdbilecKYgatjkI8U=;
	b=wRgfyfQGED00YrkGvWk25kfvo81gfXFTDrcxGnkWN2k9CKmf5jUtvHpIYNFQzka7cF8o
	 JTeT1BjxDt1+TCCnuZvn2rvor4+VO53xtFL5m0PDygZid3M0sj7iyxQwsvaUvTSWZIVlO
	 WVoo3W/PW79MoKdijbXgnbb4kaBSaZeNGkEZTzAIS9ZVciy1At81w3G721YxivkpHhBsh
	 iHRojjaW1s/3fay2VQWcrDGdgCtlBwWy5SLANj3RUfL8u+Rzd0MYNXIN3ksBdY9HQHt1+
	 bfFHzh5duzJdxYtVci5tAzxQZtWTK9eIx+c2gPJn5mtXOvJaBMWR+sb1l7XPwuBSeNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtznqKGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042A60A2639
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtznqKGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2081F00A05;
	Wed, 11 Nov 2026 03:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366944;
	bh=K2PSEDMHrrPOXYyfqo0gQZwGFZDdbilecKYgatjkI8U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XtznqKGUxyS1R6MjiAPbB6rYvhA2ZNl8iKFduXalEUsreeHOo5BmTrUTkC3E7oEnT
	 oBnSqhlLrqy67cW3NqcdqsFap7iJPtRMtWSRXgSWyhCF/aZ4u+Prc/DwSAaN4LgrKG
	 +i+OxFF/0deyGzVNiflI7lhRrlwSmIV822Uwh++lASLkR0Q6GT+u8fdjYagMnPkJpO
	 2EQkSxL/khRHpPEzwjkwLHWKNpN8NSO8m8ctAs9V1UaXFEx2meECW/KUuteBcjaQkj
	 +m9GnWtKMss68b72V5Gjr0FM8hWSUHWlc2N/Ws7I7YJv6UedoaPsVbJDXJbPOf2l4h
	 F4yvbq3Td1OSw==
Message-ID: <sashiko-outbox-208166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf jevents: Make the model argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111023448.1970467-3-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261111023448.1970467-1-takano32@gmail.com>
 <20261111023448.1970467-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:15:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The model argument carries a default of "all", but a positional argument
> with a default and no nargs is still required: "jevents.py x86 <dir>" exi=
ts
> with "the following arguments are required: model", and so does any caller
> that only wants the tables for an architecture.
>=20
> Make it nargs=3D'?' so the default is reachable and an omitted model means
> "all".  Builds pass it explicitly, so the generated tables do not change.
>=20
> Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111023448.1970=
467-1-takano32@gmail.com?part=3D2

