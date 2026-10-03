Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA237AA91
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991221; cv=none; b=NtvarANaA2HOji0EqwV3+UwQkp9AdohUC2CcEW0OIvsfN2ucCUelwjWOS4FqZllb3fkvRfalimBb9v/OoaGC+F3Bwwm2brXiGSnlBjoSIlvim+VhJRP2kENQnG9w7UDdESaLtVRipA4ZoateVJPwZFy+BK/RC0wzxJJI1J8Gri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991221; c=relaxed/simple;
	bh=vB8BVyl1I/3CQDravYcGfsavsNdx9kx7OzfLXw3UE2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ItaKrTwedsdmoplwFrXfkXyxdSEw/jCxMsxIp17wS6P7IK4gtWMLxtqkHNHIfV1r6epQ5KmwBgPX6ouleSBtCOxrxbMu8ltKuk5qwiabH4zaXAY81XMtPhHv7MuHBvHsg/uYTkwZ0XTsidUYt8Gt5D6/cewNyXmSZ/SDA/tj43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhHqAN51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhHqAN51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5600C1F00893;
	Sat,  3 Oct 2026 01:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991219;
	bh=vB8BVyl1I/3CQDravYcGfsavsNdx9kx7OzfLXw3UE2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JhHqAN51+IYIYuVdJEGAtSCX1PJ0N2tc/bL/fX4saEufUCl94bgLEAAD9K4sviYH3
	 CrtdD/+1sI8j4dkjoT23OOoi7dLPOl2yxw6UAZjiMIdKe6hXmp43zHaeJ7kNIRI73R
	 LE5mMxwyLfcarkkiUwsV9jSdAXqcPGnPKn+0yVRzDcgGdolMgL41foVUVbZdTlq+a/
	 kYXciZypFu7NZo5loTBervonkLXfdRdM2T0fvLn+CDjAM9ckKEf0ivylr7qPdc2XEy
	 nVcM4PUpHHU0s76VS5IlqpvdKWdQ9N4q4Qtqm7u1Duz/y6EAbXdvkTTanS1neX3tao
	 Bvptfae5VHKgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] perf symbols: Fix broken ELF_C_READ_MMAP
 fallback guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-perf-symbol-memory-send-v4-1-0a592bb2539e@uber.com>
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-1-0a592bb2539e@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:38 +0000
Message-Id: <20261003013339.5600C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
>=20
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
>=20
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection=
")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-perf-symbo=
l-memory-send-v4-0-0a592bb2539e@uber.com?part=3D1

