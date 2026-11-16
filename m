Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851729;
	b=mgEW4ccVLJj9I/5J7HPckGeFQNjkqgQvDStTnCuKiG8jePS7mQyt0T9XMgRrsWrqX8q1
	 uYl89/2uUbovYjayJ+7lT6OAAfO4ETft2XskB7etvl4Jj4DcyY5J98oIYfjSz5G3iDRMr
	 igQUTRWAu8x1FV46HO2oFlpid/5vOezjDWuvVKsBbjz4KWXxmQ/NvYQCdL4qm51z85ozh
	 mp6iIfWgSrUdCYfnLwqXGQGiSV0YdzeoaCWNQy/cbU3gpTfGKwOV8I/Qiw2xmAg2JASAs
	 WrySP8el0iI1jHkTftPaGZwAobuU1HF/8f4AFpFLA/ZXMHf4NzmQ8pqf2a/GLPxBflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851729;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8X2vHpqbeQYg9dXyyBiD7qN2EUsKqz8HXcbJjAFd56E=;
	b=ygoUw/fb3L7YI8KDOE5+a3i+Jqy0pJeM/eQFQGBBQYDeir8526X4EIgpEYMI5l8mbCI4
	 msGk7RJ4C+Csi1RU/CPvDEbvWs5yJPcEce41OaHOwnpyZAj6k7rkhXzDBV9Buh/hNZppJ
	 GG4amvv3f0AapO7fJZRYdhvtRqAFOz5H5UiHp/ZIC3YoofAGyQjKmaz7LhSUGWzxgF4oT
	 qw3ZuKfzWm2wHcHORZVJTqaoiVmxMPyCrtSYDaf732zfHECHY0mLsYW0PZStKxW/hOJ9H
	 uIAfq1+uV30kr4zeoz0e0kB7EakiV7rBCQGla85Qw8ermg2KfKLVAaw5jTiVuGIr60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzFAjRFG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F060606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzFAjRFG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B01F000C4;
	Mon, 16 Nov 2026 17:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851728;
	bh=8X2vHpqbeQYg9dXyyBiD7qN2EUsKqz8HXcbJjAFd56E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EzFAjRFGQ6cAVyb3uAUvmuArJr39AlOaG/3oj40aHuZXhjw1jLIqSnoHCPw8SRXQh
	 KGI8hBhcCctoWI2HnTIUgGYtmuhEkQlBeHfgQhxZhNWyMiWHaxJMbAISf8GNcZWw/D
	 Bw9mAmhHKcRg0NAvUVsOYbuL9pY1o0lYtChskJso9FgC5C7sUc3apyCztgAXVIwnJN
	 kwvEY2OZB3X14NcT4mzgQs5Nzofvj6nOXwlcz/AqVE12GYfbgMIDM7yIBwaPMD1VSZ
	 6c+4mGyKooJ4mUU9MyFtyI9Jnces53VUPAvVFc55j2hsnmpErAixW+EB7nYKIkgMUV
	 dTrHnnP1i/UFw==
Message-ID: <sashiko-outbox-217459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] MIPS: perf: Add SB1 and SB1A performance counter
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261116173843.911523-4-f.fainelli@gmail.com>
References: <20261116173843.911523-1-f.fainelli@gmail.com>
 <20261116173843.911523-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:55:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Support the four CPU-local SB1 performance counters through the MIPS PMU
> driver. Use 64-bit CP0 accesses for the 40 count bits and overflow bit,
> validate the documented layout at initialization, and handle sampling on
> CPU-local IP7. Keep the interrupt masked while no events are scheduled and
> clear the unused Count/Compare source sharing IP7 before enabling it and
> in the handler. Reset counters through CPU hotplug callbacks.
>=20
> Expose the historical OProfile event catalog through raw events and 48
> sysfs aliases, plus generic cycles, instructions, branches and branch
> misses. Preserve the catalog's duplicate encodings and disambiguate its
> duplicate names. Leave generic cache events unmapped where the historical
> descriptions do not establish a reliable mapping.
>=20
> Add explicit physical counter selection and independent exclusions for
> EXL and ordinary kernel execution. These exclusions only remove modes
> already permitted by perf attributes. Enforce counter 0's cycles-only
> restriction and reject reserved configurations. Reassign flexible events
> when fixed-counter requests require it, preserving counts and sampling
> state, and support groups led by software events. Honor sampling throttli=
ng.
>=20
> Document the ABI, hardware assumptions, usage and validation limits.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116173843.9115=
23-1-f.fainelli@gmail.com?part=3D3

