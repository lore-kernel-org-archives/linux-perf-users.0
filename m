Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942735;
	b=1/I9kw3vupFVhX2YM7nGuNJxaaV3D3SfLp/JqG4iTG11pfUnU90vvhq7usXFtOpXdJgK
	 fphWQo+bHQbed/Vi5kuuktCA1lg1ZkmgBFQy8syj8Iku9oZRKDYEO0ro11NqLVjz/mSo5
	 WpP3b68ZM/8vaNdmOjxQqlUQtPA/8YL/S4hT8vLrGxzWkJ2vQUtJeRP30lqgW3RY5wDqn
	 6JEEHmUC3+mcz4UKz2Ni6j6gBu3YauGb5igzPucBC71IsgREjc/4HsvGjQgknwfWySDRT
	 KagDsTV1EYhjqGDMFVRq9Gu9RA8wSwyoAc7xP+rT3ZyjNPl0IlNk7rypmgw0QJxWkwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LPaDB7BFz4eXUhUxCS5fBKdTBTKKGDiFkbbpBPjP1zo=;
	b=WmRHgu4Q7d3YBZ9rzAppjfBhU+geNPpADSRuM/CLOrXlcm06s0+kgBFBtNSCJZuqlupO
	 uKGHZuSSbYxxCy8Lm/UkI31tJYYlTrxGAmpY+VNAbcmNlTerr/ISkWJbn9X5s3yjF6oQG
	 onQN72sH+qRfHGAkVKYKuM0OKTSpH2De939+wLbgI+kXhH9D+75IiK75sUh8smBnCLZBz
	 jb07j+keHEKYOaIYYDS2v2DLuFJtOs8fmHXZmj/rmGx//c5BPDgkmy0jrCzvy9pr0vLdf
	 kvaj1kmv/y3pvT095iMp0U9Ov1zDf/nZ80fLfV6cCWq3iWASkctYa0ySaT+pSY8K5iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laA4CahL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D676606A337
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laA4CahL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CC61F000C6;
	Tue, 17 Nov 2026 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942735;
	bh=LPaDB7BFz4eXUhUxCS5fBKdTBTKKGDiFkbbpBPjP1zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=laA4CahLV8/nSs6BOX/1ByEC1V8l0YRHC7W9t3zHT0FCjfFO8b4UECZHCChAUOHJe
	 yeR4NZ0NlFbZnavdQnDqOOJUNOSBPYyPwvB6NJrxND93vQUjlg0MyYL8+ki4VS83vK
	 nre5+vgJn1LJISHdjj9n0KEbJjsOw2PZawBMLmitgW6uX2gpFW/jE5hoKk0BDuoRrR
	 heRyx590N0lrFble0G3ezvVouFCnW7kkVicn0O2MVCxB03esTXM2nN7s1A/XrfCLGf
	 uTIox++3bi8cQ8PNjhq5V/q+SRj8cz2/J0DetHCYHLdOfcl8x344ITvWk8lxwdQRjS
	 ACWqp3DgoVb2g==
Message-ID: <sashiko-outbox-219451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 18/23] perf env: Add __guarded_by and __must_hold
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-19-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:12:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by(), __must_hold(), and __must_hold_shared() annotations
> to the bpf_progs and cgroups trees and helpers in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D18

