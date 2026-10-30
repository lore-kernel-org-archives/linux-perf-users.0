Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373982;
	b=2zLV3qATdbR3npT3W6bE/1EIAihWYhIGSThBsnzGI+0+7KYCay/OcWJGsaO9rKSk01er
	 GM/in/qxBBDK03Z2miUsJMUvhQLNQ5UqjTOE1/2MJLH8uCgdc5/CDyY5mmNbiS1QtjVu8
	 88qNHoEpMfQkIMiioVFEmgBj8YH7CbQcZXITYXDKsWolmSJ8zBn57mT8Z924ax1cFmbfj
	 +6O3Zri5Wki+CBBu0gjKs4N5VJQXhe7fXkg2gMEn5djjmnE0WIlXfaeSkS6QALpGOVGYR
	 COYRnzXmqt5gqxQcdyvKw90NZSP4pHj12sPwqhMHPFFZsfixvYvfEuoERGdUG4y4NHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373982;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6MabD+s58NTDLB8dgOnm2QOY3oCGVGzSnzol6TjzFiE=;
	b=YaErJHsB8EcWbi9lRzYO9pVHubGvYKcoQHFhcP6py132txuI8jhclDyL8pqgnpm/+/mr
	 z35BX2ki3fTtpGNtGbhEj/1XLVxOvVKaRAjlbvmunoGU/jpUVBZ6SFYvl/D+mcp8bQKEf
	 SpWo2B2iRlZdr+DXZbtvlJg4UvDETRW+5Oz82BbJc2R/knx+fhnq9R3YD+ydPJFLx0Esa
	 dYUQhFuYrGu7PvcYUf7PFEhJMDobdG3bhrOOcuPzYs4igd1+2HuMO670lD46A9cF6aSBD
	 vpwQE6bYWJxQtD1BS40twrkGhFniOHD0TwxTUks8uN94SZZ1ryzkfthyAueyvk2OAAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HMdASpL/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F17606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMdASpL/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20561F00A1A;
	Fri, 30 Oct 2026 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373982;
	bh=6MabD+s58NTDLB8dgOnm2QOY3oCGVGzSnzol6TjzFiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMdASpL/K1jIo6VCXrHZTNeRMJcfPDaG4R2IEe3OD87dDkCxOLdYqx4NyiBCv6hdL
	 /XXeS8+ZZxU0dVOeF0H9bEYJGxNDlu+Mt2RrcZldBNaq+gPhjl5QbgwMs4+Gh7Q9F6
	 JzYLtMfDxF4iuxZ7Z1rI/2TN+BtM2oZ9BgAg16INx8wvKsK8y6ysdeLlZS02appvHN
	 O7NZnu9cGOVqx4c/TFiUre3HYMLRmbWpgoZ2kpJRGG1kC5dCnmuN8Rac2gZeyAY8U2
	 TedtZztTT5zKDkLesVVW/GJj/g8IPI7vnIKNC2SScIusuEoYQxjcn5i+apqHihndmI
	 402l62yRKtt/A==
Message-ID: <sashiko-outbox-191171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/14] perf cs-etm: Use the recorded instruction size
 for A32 and A64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-5-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-5-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:26:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Use packet->last_instr_size in cs_etm__instr_size() instead of a
> hard-coded value of four. Ordinary A32/A64 instruction ranges are
> unchanged, since their instructions are always four bytes.
>=20
> Prepare for synthesizing exception entries separately from the preceding
> instruction range. An exception packet may have last_instr_size =3D 0,
> meaning that no instruction completed at the exception source PC and the
> exception return address must not advance past that PC. The thread stack
> computes the return address as the source PC plus the instruction size,
> so returning four would incorrectly advance the return address by four
> bytes.
>=20
> Keep per-address decoding for T32. A range can mix 16-bit and 32-bit
> instructions, so last_instr_size describes only the final instruction
> and cannot determine the size at an arbitrary address in the range.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D5

