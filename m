Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AB3C2B8F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750303; cv=none; b=bVT7L6iyohNzpDpTu8KhA7Kg0ccIhiqgr+lzAung9bTwNk0QQhWT+1fBzoKHpnv4GEml9LIjD5JjtolDDJHbT26md/KbKCYxEvGriq+FcEf/PbllIyoiksuQ0wxkkIoDPuYXVfZDyo0gwtiz63WbHycuMfVzMEnuJTa4hyXUV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750303; c=relaxed/simple;
	bh=FVNtJo9sR0Z1Jgn7N1slT9vuP1alavj8vXCvBk6MkEY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mIfLOLYeDhEgjQ4A7whp59QuKmirsR4aTPUju9uTs6xbXsruOPS1mpcwTp1ooyR+Y8UdrsAuwko7pcXR41h3SvcrbaQffdQmGt6Do08YBexAA80BnbBn5j8jbn6UUxTaQfJV5s1B2Gg3Lw6bBZC+S3fmX3uKEnN6OdTiX+sl29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL0ypT2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL0ypT2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CC61F0089B;
	Sun, 11 Oct 2026 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750302;
	bh=FVNtJo9sR0Z1Jgn7N1slT9vuP1alavj8vXCvBk6MkEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gL0ypT2eTpV8uP3pUYF6iTp1xiXV6oE6iO7/5pG/Z/4YGBo06B2gd4Bo4MiKkb2xd
	 jCVELKmR+VWZGkQCZ+eOMRXg0n+W/SPJY9hkcTPijoECLrL1Q/+S9RVP8D51DFEjIs
	 wohSvPIUa2pvpcTzQ8sGtlJWqY/ul63/V6osa9DXLR7D4+F17jPDV8Jfxezm4zFCVw
	 8FdcizN9Ep2GmwuNh3QFpJO39Le/jqfrs+XGOhEg9Jy/NWO2LdXOvoHwDbjsmeBLRk
	 Yg7QdN81766/sBG4bXtaq+vAnb/21wT/o00jp04gu3UR5efmaqsP913bbyB/dzFXT9
	 kxnLBv1YX7ZkQ==
Message-ID: <sashiko-outbox-167449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011-alpha-perf-regs-v3-v1-4-eaa625a39712@gmail.com>
References: <20261011-alpha-perf-regs-v3-v1-0-eaa625a39712@gmail.com>
 <20261011-alpha-perf-regs-v3-v1-4-eaa625a39712@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:25:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Let perf sample registers and dump the user stack, which is what the
> perf tool needs for --call-graph dwarf.
>=20
> The register indices follow the hardware numbering, so r0-r30 map
> directly to DWARF register numbers, with pc after them. r9-r15
> are callee-saved and live in switch_stack rather than pt_regs, so they
> cannot be sampled. Without r15 an unwinder cannot recover the CFA of a
> first frame that uses $15 as its frame pointer.
>=20
> sp is not in pt_regs either: for user frames it comes from
> user_stack_pointer(), and for kernel frames (PERF_SAMPLE_REGS_INTR) it
> is the end of the trap frame, as in stacktrace.c.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-alpha-perf=
-regs-v3-v1-0-eaa625a39712@gmail.com?part=3D4

