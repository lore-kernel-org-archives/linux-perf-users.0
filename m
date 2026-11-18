Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039451;
	b=0LlQTbjEXCEp8BJ73DmEMY7XtxsylHkooZS1MnOfzgGKo6B0TLYBeEgql56lGJgGpQyN
	 +Zq25a96f/X/lK3IzL7wVF7phgpT11LSqPKwybZierB5d2vQfx3FrHyLsiUx8x2ugI6q1
	 B1W2J0ekPvjBLRAYeczOEu+3n3mbdqcGOzIDnr1rIACCNJr6NXXlrF15WeTL/ND/FDLl0
	 NAPIlfgi5C3RHztIgCaC3t/gi9eoa+B3T3+6DhbvVWnDzGpa0Z6iZvLWD3YhzTbimoS2T
	 NnoDtmAS06mHjWSiVv2W79Yns2k1b/GcJQnIr6eAcMr+dfHzYxne1GsQcO/gq07ghHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kQzd/K1RvfmZrAbKWxi05SAwZDqiI17tum9tok6S9Gk=;
	b=4AQhHI4284ldQ+b0oQy+vevo0WN5M3bpJw5vCKO3wxbDyp+1mvGwhsQ/A0XLbNdOyQQf
	 6i8o2YeBJMDbtfWFEcIRIN5ujuoObQqYrTWEqULoYaXVxVpbu9/Gp+Wdrq4zVOQayXSip
	 YrBg8TyYleVA2kEcYcpUJb2ENUv05O9oUFRjnY+CPF2JBGXJzGLoqJYf7GMhyygX+gjKM
	 ZL55s28eaA9KVfMZM1KhPounU+zpywY1CXurh1wmaPDZ0c9qV5/t9JH9xqGyApMPe73VU
	 Uf8iPcn7W7OE3dq8r3Re9i3g0W4x7wqNEiRStpBl6BlBzmAAhV8bCz4HWZNjwXKzJkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoZXRQYb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B460A2604
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoZXRQYb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD511F000C4;
	Wed, 18 Nov 2026 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039451;
	bh=kQzd/K1RvfmZrAbKWxi05SAwZDqiI17tum9tok6S9Gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XoZXRQYbd4WJhYEhKfHSJbiER+9htcaKyhf1l6eK7vqza/0ZWWQwW4ewae1cpBh3q
	 suAPIvrRJ9UabR26eFsFNOaRPk2OFTuaH2kEfjGcJndjTL2Qye9do+DK0h+V6q+N9I
	 90vVh7JPP2DQs4yMmVtkIJFjTJtcNfxGU8Hj0aWn/qEsLx/IgDcV1aNetbLFhnRcw8
	 iDn/HKt1Qn8ZNNX2ak57cZs6KlH2UauuiHCMBkDn4UTHbY9MhmTbJmcsBW8qGwjC/g
	 SV6vfONzalZ2ktWsnLjhde/8PEqwBa4pKoIha98E1JS4S6Q6Dx6uLzCqbSfckXNIIZ
	 9F4wccyQ13ChA==
Message-ID: <sashiko-outbox-222072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/13] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-7-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:04:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The per-member percentage sums the histogram entries in the member's
> own [offset, offset + size) range.  A flexible array member is resolved
> past the end of its struct, so the struct row only covered its declared
> size and showed 0.00% while the member row showed 100.00% and the
> header said N samples.
>=20
> Take a member's extent as the end of its furthest child as well, so the
> struct counts what was resolved past it.  Union members all start at
> offset 0, so a plain union keeps its size; a member that is itself a
> struct with a flexible array extends the union too.  The TUI browser
> accounts the members the same way, use the extent there as well.
>=20
> Extend tests/shell/data_type_flex_array.sh to check that the accesses
> count for the struct in the percent, samples and period columns.
>=20
> Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex=
-array")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D6

