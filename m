Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042338;
	b=nh1L0mD4zdvZTzsjDLC3GocNefea0efDFoxQMpC8cwjAyLqRDzas/OQRXIpld2S4vR3T
	 9MnXlooHqcY4kCFENC5MrgwfLuSRJ1IWQ57FqCLWaaa6Uh7sMmqc4xvNCEJe8+LbyTOca
	 XyUIIiiCh9/I21+Rhx/J7MR7FqEfpKOSh8wSyUuk973z/WRGNVRavPJr5NTaZuPa7Tg2C
	 EsRWi0bHoDlSKWE6Xhz+/hXY+pNxAqCCKc6mbIXbN3Xz/mn89CsyDX8VlT1wyFmxvEBQ6
	 HgMvubufyFJutowpcaQ9oIRmaV3RobNH8cSLDmA6/hCRbIAcipJ+hOzZO4yfoOg9t1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=knwW43rGB5857vJEfF32Y6pt0PXWIIfVuyr4U6Sh9T8=;
	b=pUMywvhdC1KmmMNjh6QQhRoUVq3eN85jgUYkWz+QqwyGbV++Dj0pqwpS3mXrJh9HaFU2
	 npFNn/0nU1uKG+tOdg3I0bzyqMMGfbEuSJuAQsVtsCV958axri8oEuK4srTr0R+BxQ29u
	 i6th0g01Cw4DW9p9qdXaoc+XxmpkKG2d4+6/a293ck2EIDAlR+A7EsGpQ1R/rLNZTMpH+
	 PjT0Nmxyn+Jwa9J4X5i4vRb5x9+Z9Vhsn23juLs74cUGFXqUrVal/XrpNgolj6C/NHjRa
	 BnXWPTXkC1BXneX505wnpY9PLWqYECWkel2Pa86oAmR3gRy+xvPawbRMC+n2pbqf5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnittpqe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75008606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnittpqe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4AB1F000C5;
	Wed, 18 Nov 2026 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795042338;
	bh=knwW43rGB5857vJEfF32Y6pt0PXWIIfVuyr4U6Sh9T8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nnittpqe39W/vQTE8BZ4yKLI6sBumvf3ZKpVEER693LWLOiHEhLJkpGS2zVe4B0Lf
	 z+OVtwAoheK3wQiDuxhQzNaZsLAZjpo902cDeiNBoQw7iD4Ennlot/x5SE41fhrXZH
	 MDa42/5qw44i+ZYTNwoA8exgnA0l03qEpndouku6ppn7wQfHWGY81qkYSlHMfeg96a
	 0CmA2N+cLNQHOLS85Azl6tuasfCob5BokNdxfrRcXfWWQKwKzfo0xIRUH698HeM3/F
	 pevqxmIk272iaKZAl2H7Ih11S96JOrf5JPEA3qMIEJGs/Vg5LjQ1YgBpowfLI/x0Pt
	 TI0VfUPBAPyiQ==
Message-ID: <sashiko-outbox-222129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/13] perf tests: Exercise DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-5-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:52:17 +0000
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
> clang emits DW_AT_location with DW_OP_addrx for globals in DWARF 5, gcc
> emits DW_OP_addr.  The global_data workload keeps a zero initialized
> struct in .bss: at run time it sits past the file backed mapping, where
> the by-name fallback through the thread maps cannot find it, so only the
> DWARF address lookup resolves it.  The test checks that its three member
> accesses are annotated, so the DW_OP_addrx path is exercised when perf
> is built with clang and DWARF 5 (e.g. coverage.sh --dwarf-version 5),
> and the DW_OP_addr one with gcc.
>=20
> It skips on 32-bit PIE builds, which reach static globals relative to
> the GOT base register, and the resolver does not track that.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D4

