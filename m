Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827104;
	b=XGHM0l/XVJJIyUFOpuojpg2lcaLQ4m+dER5FCMPS7jMJumHmL/5soxunwdGd3Z4bvgse
	 MivbG1YGowtBWTZFkzpqkEfuTiwNqb73hU5iWlnr94dDRCwAvFfxR/HU339w2dWFH5udp
	 BUcirt8z55TW40sXkHhZtq7tEQqBbiAeHUyYYUQFvxdSxRg5ZxBM6vjH+DNh3vJH0WtdV
	 LI7OXgBeWz0xGCCPkaJCvNmtFFZXahHyJUtlTRayL3srktH7N9c3Q/pPakU+B33aTi0Pa
	 yu5se+GMfqKv7osythHOHXLDZS12v0bnnTEb2n4Hvcdlfrbq9C6ePb/eApnZXLO6QFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827104;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bGIkJGMeoDsUuCv5XZJ1l7VSAhrbPu5HUUEplYnE1pk=;
	b=K05guXoz6uC8cX5Z6S6O+LhZkoilaofJ2XKGiJcgKEx19VmK2u4P2SbbzIc7E4XEJcYD
	 /i8k3uLGl5gaPBavKy+DHB6cu0xql+iFo5PGKIL3MbURI/EJB7UHGJ/QWrA5VGbKISRi+
	 2wT1G9fDKhcWxM5//Ft03s0Y4MVtnu9R55Qb7GadK8T5WmA2KJi5fh2rgChQaNkKgk/Jv
	 y5XoKKQO68snprKzyoY3v1N5cWNRbUofno206sHVWOXAe19Up34UoI2G0pS39wxnCF80j
	 GiR4tHAnJvzLgs4NryPFnqmGQ0rb/remiP2piY2W73HvxYMRed5C5PXimB1y718QcyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSRYyH4o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A8606A869
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSRYyH4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F11F00A02;
	Wed,  4 Nov 2026 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827103;
	bh=bGIkJGMeoDsUuCv5XZJ1l7VSAhrbPu5HUUEplYnE1pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSRYyH4oPEblLAc3WQhqiDP7G/MD9oEQAez5OP2LyU1S6DxLoZRKDdgD89plCVGGx
	 Uup6rms5AEfpqhziZMUqgOyGR8CWc1YLq5xXqC+MX8EvV74sMv2n72kdGKqhVs20Vr
	 5vzYMfQ2HQKDRwMTMX7NpjbuwS/fIisMdENbYmnmDaI+mB+GFhS04VAOfG9dX2n/E/
	 phaIuCKkk4qeUSxy6JOwqKeKpXBOJcxJBRvxVIDw90Xv3HMo0HLUNtTe72pZ4RVCW/
	 TbdTGtPIZOOQXmBH+/pjGlq4NkM9IuETw+QWtxoQYZ5yPgm5dnnIN7CSIOIJzQ/2SG
	 X5ubabLviHCWw==
Message-ID: <sashiko-outbox-198091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/19] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-7-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:18:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D6

