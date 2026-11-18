Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039290;
	b=bVEKM7WJ4lST7ovl0wXP2LE8oejqpGBXyWRh2rWrtkdv1qjffLjlUgHhwnVJ2Qc8NxKk
	 tVrJwZHhM2BXL68qEeRmwPEhGj8YT9HGOyExru0wiOKTsu0fk7G+9ZVPIlj8+vQHj+8nT
	 pw+FZimChh3wWst62w4qSaIc7DzlscRQhpEvkTF84m3RrY0q0do5uYgZ3za+Gs3itn2dS
	 yR4Twk3jGhH4mUCf+nO56UFWoHef2h6njgMxmMLW52n6WHJmx95yx7cVRZSw5I91k1hcu
	 1mJgMVFlfhBZCWa1eCdmoRX/cmh5GRW9SfbWSqoDss3rwDMIvPJdsf9+QqWCn1dSl1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WbT/mNGwN1gT9ZzHmQpI9cPCiGg36AttT6yyBTF77Ic=;
	b=I4LvAPR25Iu7P6oShtZPJiLjuMXXHVQWY0j4NONg9sayDLyAY0W+tNv+v3cZzyNUn7G8
	 2q7oxxZlqOBmPV5B72ba6BaIpCNmL2GDIcyj5tADH367GnkfCwwlfRknFcXCx+DDUfkee
	 QNVJYsHxOBshWYEtNDM79IGS590gjGwZbn4cdWuoUl2A/6IgLli3tNqn6gwqanD2Pb0YC
	 Ip0zp6glgr3XS5ceUCrN9E1CNfIXTBJSBaxKR9V2lDXjkU2bNANzzg4ufu/nA52+meX6/
	 Lhvl6jbOy8cpV5QSFgB9GhpqIoQFVEKrP8tZ86nm+kD7+EP4VNnQmy5ZW3lbIr5p6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBvuHdnk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74B606A331
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBvuHdnk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D041F000C4;
	Wed, 18 Nov 2026 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039290;
	bh=WbT/mNGwN1gT9ZzHmQpI9cPCiGg36AttT6yyBTF77Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBvuHdnkTdh+Wp+RKSBdHoy1iJ/9pGJ25OkScj8+hr2Ph324PFLJgrwibSz7fT11r
	 IM+EQdQzEHAQpPZgU3Wy/tnCA73AZa+cAKRRaFcmjFzA87LL8v7OMfCr0gJrpOkaO9
	 WXbmdDlIYGcRFofeTlRVkg0QB9O1ViC7Q5tJfny7COmk3/padGKSbvA2Arbb0mshZJ
	 +kF5mt7dCOKQduU/nlhmn2kPCc3OvNKfjX7ldP9oooZM3Ak6b2XB2lpaxUtxJrLhLo
	 1ya4d9felj5txiTZ71rDOeOOMJQDf11obeAV7NvXgOm01GsZGREK4cDYvSxkTJUhhC
	 AEEZyBgXxo1og==
Message-ID: <sashiko-outbox-222065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/13] perf build: Link the jvmti agent and the GTK
 UI with EXTRA_CFLAGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-2-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:01:29 +0000
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
> The jvmti and GTK objects are compiled with EXTRA_CFLAGS but their
> shared objects are linked with LDFLAGS only, so flags with link-time
> parts never reach them.  With -fprofile-instr-generate the jvmti
> agent's __profc counters had no __llvm_profile runtime to write them,
> and its files showed 0.00% in the coverage report.
>=20
> Pass EXTRA_CFLAGS at link time, as the dlfilter rule already does.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D1

